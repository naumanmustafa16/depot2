module ApplicationHelper
    def current_date
      Time.now.strftime('%B %d, %Y') # Example: "November 18, 2024"
    end

    def current_time
      Time.now.strftime('%I:%M %p') # Example: "03:45 PM"
    end
end
