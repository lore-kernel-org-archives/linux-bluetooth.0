Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9C74908CF
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786728060; cv=none; b=fn0j08AVOnYmOy2lg8OA2RM2tk6CyE/KRwkwG3NNWgLnpqMyC+wFx2f6lT9dtxgJaxUFP4aj+z5LJ99rC84n+Cp4UMRtXPDIYJFpKDDrtYqM6BvVxJrnyOXdSPu2simz99SeunieioM7w7uEV07wtEuplGXEP2suAttUNY/fNY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786728060; c=relaxed/simple;
	bh=YGii5mznjTLEGRvLu4FXIK7xKfQpQeVgCabTv4UF3Rg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qNGEtN1/cssaPN2pkR974ANO1vENstakNuBwvQxV8rlEzQS1LWSiskJxpyHDZ1eZb0XwbZWaJRxTakqAdi6lgjFaShgsHOdI/uS9L0W1KPajIxUmQ9MT/ypMbcAbsxnbilN5YXtUnD5DHFtjogVwr8EdTGW8L3tu3Lp5xeI2V1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWHYqNk3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWHYqNk3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74D81F00A3A;
	Fri, 14 Aug 2026 17:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786728058;
	bh=5mDTM/TScqttM6CRqYeOqd4hsW7wcLYQK36w5o3c6Ss=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AWHYqNk35D4jR0vAmp7eJi21QloxRvxzhigOR5nvDHp8N+F8f6Vr349FtfmmXtwPK
	 QnugsFi83B/TcEPTmgJ26A6PrXYxHTZvtrIYwntfdLtpPWcqPyUFlXCVEdMFZZNDHy
	 HX/N0ULC45xVB/rIuY6cI7o9SKZn2aqPvh11wtnRNbqSvBAEWJ7Nyo7Zo/zMdgsJbc
	 IPuw3vpslfLi3tL40BKTQv20JHkutJX4VFtrDODLh6HVwC5yNfB4W4JAFZ2LV5B5Bo
	 9wo7LgxGaMVmA7CQgrSRCXAg3yVrutNFpBdsy7OHMmLozIcX/yvfKa6DNnWYBya66r
	 ARcFOH4/WBoQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 196853924457;
	Fri, 14 Aug 2026 17:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ 0/2] adv_monitor: Fix buffer overflow caused by integer
 overflow
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178672801263.3885098.12402993534569851547.git-patchwork-notify@kernel.org>
Date: Fri, 14 Aug 2026 17:20:12 +0000
References: <20260813091937.2600061-1-hadess@hadess.net>
In-Reply-To: <20260813091937.2600061-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 13 Aug 2026 11:16:56 +0200 you wrote:
> Those issues were originally reported as security issues, but we not
> deemed worthy of a security advisory as they impacted an experimental
> feature.
> 
> Bastien Nocera (2):
>   adv_monitor: Fix buffer overflow caused by integer overflow
>   adv_monitor: Ignore additional patterns past what's supported
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] adv_monitor: Fix buffer overflow caused by integer overflow
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5cf94acaea71
  - [BlueZ,2/2] adv_monitor: Ignore additional patterns past what's supported
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=14347c86fb99

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


