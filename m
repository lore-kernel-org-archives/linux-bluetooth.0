Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B87E14F9FB
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jun 2024 14:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028212; cv=none; b=Hep83fPzH7ulU0JC8qYp0PdZ8tM7VWToL5+VOQyq/q9n3E07dnQwoWC9WK0bqWJsK5Xfk3ouxRUi1kaG15+cATaZQMBIdxdV0/6/C8w8LasMqTMZAhq7zY4j1FFQo8p0UUiLDjQb1JD1GY4cVDlt2PJWMsIrmkhfkNkGzMzXF20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028212; c=relaxed/simple;
	bh=EJ2kq+x9Ms0sSNBW8bYhjkjCYAfuOzIYX+lxSmf123g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E1d/3gSrU/Z0+gyYD4xGtRoMxll0aAOCMAKWdALKmx0VpigCY8wu15RYMde7Hop484ixTWFr6lUVbAj6R0OLRgZtNNkXorjkJKkEV7Hs2iliU0ZiTGJl01TBpScsl1/VEhSVA4+B8UP4daGZHUUkoVJkzs3vQj8tlvUl6Hknq2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rltLvWv+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rltLvWv+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0679FC4AF1D;
	Mon, 10 Jun 2024 14:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718028212;
	bh=EJ2kq+x9Ms0sSNBW8bYhjkjCYAfuOzIYX+lxSmf123g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rltLvWv+CdMffPX9ZCGuO7IU+IR5Hqs1Oz+vAmsuydu3yfNSuyvKAaxv1SYS7WmR2
	 yJmYJp0yYpVkqb/6SAoZkZhpxk6UfDcrEa4ZFi/PqNIGT+TeVkkTvEllfSjUe2JNWy
	 UrTSNKnLSTvZHMVZnZP3dobmtjMrjpOuuuYZg8EW8cXSbYIVifg9Q5yrZh66Q7+di1
	 sGY6WRZ0DetfsXZvIUh8bQ6+y/Rev33PCqf/FDH+9d1mwwM5KvvwZ72Dp0xtrsxf2O
	 xItXwopagaGC1jZfT+tZdBinjx76Q0IR/KlQUxxGqjhiZVDXCt0xUmCyqfeB6JZhXG
	 d/uaQEwfi5EoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8752E7C771;
	Mon, 10 Jun 2024 14:03:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: hci_event: Fix setting of unicast qos interval
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171802821194.16143.12793613621584649641.git-patchwork-notify@kernel.org>
Date: Mon, 10 Jun 2024 14:03:31 +0000
References: <20240606162917.621031-1-luiz.dentz@gmail.com>
In-Reply-To: <20240606162917.621031-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  6 Jun 2024 12:29:17 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> qos->ucast interval reffers to the SDU interval, and should not
> be set to the interval value reported by the LE CIS Established
> event since the latter reffers to the ISO interval. These two
> interval are not the same thing:
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_event: Fix setting of unicast qos interval
    https://git.kernel.org/bluetooth/bluetooth-next/c/9b70755997d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


