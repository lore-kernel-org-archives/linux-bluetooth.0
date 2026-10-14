Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070575625FA
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 17:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791998422; cv=none; b=jAx9vHkR1hc+mWsY+hiZlY88u+yh6+6Gw4LABhvSSere6P+yKLCY9M+aSTxmFhvlTlx9eHVE+spyWvVn5wJ2nZ+huu3//QrM8Oazy18Jd9f+sFfrpUihegVRYgIKPh7gS07sENExr8pc/2Ci3Ntr1Z9fWU7xmugIYv5SQaci6D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791998422; c=relaxed/simple;
	bh=wZJOunrHm47yKMe/BdAuLHFP1EVsLUegutXs2w/Abv0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jHuWBYT7l81i+WVVm3XFixMO2zt3N77V2D6PWIX5vFyiJLAHFfxOBi4DH/bv8HJDy+kUrwayBRFhVwlQQHkOOjnjIzBimxDSxZ4QsHlanG9Cyt5w7nBP1WOWSEZEnymaDJMQuPgI9DLYld1uJxhGqX2TV6rKhEw7ACpzk0RdpYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5asHQ6Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5asHQ6Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECB61F000C4;
	Wed, 14 Oct 2026 17:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791998417;
	bh=riUefGthrnWG9HT31N2sv7CN1ZbMzRKi2AJ7QBXsBZI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=n5asHQ6YUKFDbz76ust8Hnvdqet/IRdo0QCyOkIB4hqJbi/heo0OgW1UwZmjhcRvb
	 cDM8MIAQ5IOf608jUfHDfPX1FKkhtf/AX4JQW2+jIVnH5UhTeoS8Gm05ZHhYFMHnrd
	 yUyARw7BdXWetfXw2/RpyYk4jXAy8SiIG4nukGTBBukP7ZKXn349Nes35jRTS6CuRZ
	 3rDhLzS8ZIwW4V1X7aioWpQZQGZxNWPLUehLZ66aBZeEmFNt76g4Py/Y9DvU9HBWFv
	 LrdkS6dwCTAuC+Jhl09/P5uW97psAUmwh9QNoHFJNH+UbdLoXWgprKU+BQnok3mmBX
	 J2gjvUc/ZeY1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 772C139FD335;
	Wed, 14 Oct 2026 17:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] monitor: Add Minimum Supported Connection
 Interval
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179199841601.2868755.6857291282729326451.git-patchwork-notify@kernel.org>
Date: Wed, 14 Oct 2026 17:20:16 +0000
References: <20261013140255.521668-1-luiz.dentz@gmail.com>
In-Reply-To: <20261013140255.521668-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 13 Oct 2026 10:02:54 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The LE Read Connection Interval response carries a
> Minimum_Supported_Connection_Interval octet between the status and
> Num_Groups, in units of 125 us with a range of 0x03 to 0x3C. Add it to
> the structure and decode it.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/2] monitor: Add Minimum Supported Connection Interval
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=02aa5ea219ed
  - [BlueZ,v1,2/2] emulator: Add Minimum Supported Connection Interval
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8ebf7ffe7bc6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


