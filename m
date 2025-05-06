Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DB82797A5
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 May 2025 14:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746543589; cv=none; b=YufXA3NTmGlJgnhVxDz245CwfsCSgBFaLmH6absLw9JsgpQ4kVZJT0kutpJqUVye3p5/1aAlyDm++XAAFT4+bF65Gbf0eA7kiMOMJsIiQ0gKtr0Zs0hLsNehckbE3kePjR/vTGSCwGOh8VqfYA0DeorjqN7LplVgtbWXU84IdZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746543589; c=relaxed/simple;
	bh=YXse3yuJ2Cq17Oal60nc/d3R5sHU8PQGqs6r009waWk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M8S216yxp5uM/sK215cZ7o/Evn5cawSU8tbq4Kpgrsmgaz3sEibfH/oHIvyQQABG3B83xyi0M4tK9z8g0QJjxokV+eunDfuh3GwGYS3a8lOFNBqQd/OFPbcy0IombWwucWMKA5xxs7jzahH7h5K8sPslazsN79jqLd94m47S1+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etDJJyoy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etDJJyoy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD0AC4CEE4;
	Tue,  6 May 2025 14:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746543588;
	bh=YXse3yuJ2Cq17Oal60nc/d3R5sHU8PQGqs6r009waWk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=etDJJyoy9oioVZUn0s9TWPyqi/xt/DkMtRVFJAkvB6n6lO7gpRAq3iKf5KmGL0rTk
	 rSHIqXhsjHRaSt/D1AfaSIK0EkPn5DQ0snhRMAO8ljIEa/dRDcVFdNI6j2/t4uYI0+
	 nTKdroRvubzXBcVLaOg5c5ECmWdUdLFUu7yAQmNChXps3q5/pJM19HSsQ0XY40pu8F
	 Kok82TnpuwoX5/3Arn6QpZBcpV4MXDOkcpcjT8FgkE02MlmOenvPIt0OpAo7LlFecR
	 epe9yW3Zmdk5Bb38ytxTf/wzpm91XHSIBVkdujDd4OzIdPu9PEmD7ooFsEfqL1sreJ
	 4M5V4cDW2HRAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC056380CFD7;
	Tue,  6 May 2025 15:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] main.conf: Fix documentation of TemporaryTimeout=0
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174654362775.1554625.14734919877868851002.git-patchwork-notify@kernel.org>
Date: Tue, 06 May 2025 15:00:27 +0000
References: <20250506144814.49996-1-luiz.dentz@gmail.com>
In-Reply-To: <20250506144814.49996-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  6 May 2025 10:48:14 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Setting TemporaryTimeout to 0 never enables temporary_timer which means
> device_disappeared will never be called and the device will remain
> temporary forever (until the service is restarted).
> 
> Fixes: https://github.com/bluez/bluez/issues/1100
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] main.conf: Fix documentation of TemporaryTimeout=0
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=313de9af36cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


