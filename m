Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CE44DA9D2;
	Wed, 16 Sep 2026 18:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584129; cv=none; b=CiX8zY0A6qxt9A+wfYJkVl6PuURL0Mr//qse/pLanfrnxWa0cTCeHcqdZeooqWjZr+oquzlnwsceFtftNuKXRXCx2uoRC652eeUGPzf+Roi1z+AMOjLda/qGiqb7yMtDd9TGjkQv73B5GmwBKOShwwuUpP+fYWspXfCj7OtWY44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584129; c=relaxed/simple;
	bh=IHnKZKMVvxRIw5vix+b5WTBv8ERLlHKvaVGtm2KUB6Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BuSkum6ADsnrttn1xuCXrGtmPzJfkICDstU8PhMHW0qhhAPUOkYehmxoDmnnBELeCKkscr66LMuotqb3q0oA42BzOxfSpFVaIBvvgNeWu/5/ZNbl5TYYqBVSk4AfsUbpvedhD6Pb9p54Ju+W6KgvJLBRk7ple9TMFUaZiduBQrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIuWTiIV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIuWTiIV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119141F0089B;
	Wed, 16 Sep 2026 18:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584076;
	bh=dv+tNSsCg+epusvovYLvo1Q1vd2NMXatfZ4gDeyg5jg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NIuWTiIVQZVjRpAh7dEQOIDKp+V37OLqRfJkd59LMmnlPsrq6jPbkEX3XnrVd+a9Q
	 Kf56ZlIJxJ7YYN5AX1heIWPD3IK36UCgo3g4JC9Iw3XZjCjyyupytkpORK/7SHzmD1
	 FFwNgQjea+sGg+9d8cY578cLloFdpaabCK44Dasme3RG46t1Q9gk2B0caSJlwPwXZv
	 UFFceZfy3jY6J9Dt7xwQ5epFKnWQkBih8syecYxwAbpZjsjRZJkSzt2V2us0Vq1UV9
	 c7F+WXw5XVQ4AzDA4b/mVCvxQtiI2nIcB2dYIc7+z2CT9qlLdGiP8zaWDVFQj5HGXg
	 OrFZqSc/KB5Sw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5690139E8A59;
	Wed, 16 Sep 2026 18:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] MAINTAINERS: add entry for NXP wireless Bluetooth
 driver
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178958400988.3235826.5026729407609214703.git-patchwork-notify@kernel.org>
Date: Wed, 16 Sep 2026 18:40:09 +0000
References: <20260916020719.61981-1-alex.zhou@oss.nxp.com>
In-Reply-To: <20260916020719.61981-1-alex.zhou@oss.nxp.com>
To: None <alex.zhou@oss.nxp.com>
Cc: linux-kernel@vger.kernel.org, luiz.von.dentz@intel.com,
 luiz.dentz@gmail.com, marcel@holtmann.org, linux-bluetooth@vger.kernel.org,
 amitkumar.karwar@nxp.com, sherry.sun@nxp.com, neeraj.sanjaykale@nxp.com,
 song.xue_1@nxp.com, alex.zhou@nxp.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 16 Sep 2026 04:07:19 +0200 you wrote:
> From: Alex Zhou <alex.zhou@nxp.com>
> 
> Add Song Xue and Alex Zhou as maintainers for the NXP wireless
> Bluetooth driver.
> 
> Signed-off-by: Alex Zhou <alex.zhou@nxp.com>
> Acked-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> 
> [...]

Here is the summary with links:
  - [v1] MAINTAINERS: add entry for NXP wireless Bluetooth driver
    https://git.kernel.org/bluetooth/bluetooth-next/c/b9409f97f553

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


