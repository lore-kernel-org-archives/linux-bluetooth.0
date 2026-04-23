Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA16632C937
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 16:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776962444; cv=none; b=LW7/A+xAHgP6JlaGq4dlAZGM5Jwl9urOljKBrWSZeWaxTHBv8BQ0h0R1QHLoYihpuqy6+hrlAm15b1DGg9eDJ68ut1QFY+7Allo8cLd4UZeYjUQfA5i+IeVQsKSqOueWS2OeV0vwUs6+M4mM5sLEWBss5Ov80a1CJKKDZ/IFcm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776962444; c=relaxed/simple;
	bh=kDBUIeTFSsEkTg1FuFd8wRN6AA7HfTaWwWZuHISpyHk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rOYZ85mDkk56yOpWP8GKSpLL+Ern6LVW2eI/hMqhbYVq9tdMlecpuuHsoFc8iwTuAfLTJ1V5sllaiT5ySvIT/YRHLMme/8H7dCoyEjo+0F1P103LRNb+Jp891QuOMj4lM2wjK8Vag2G3ckm5H5TkUGxkC0jChc+ickGXKIzRlss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rliQLYLS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rliQLYLS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6DAC2BCAF;
	Thu, 23 Apr 2026 16:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776962444;
	bh=kDBUIeTFSsEkTg1FuFd8wRN6AA7HfTaWwWZuHISpyHk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rliQLYLSwy4A4oAZs9eDZOHiToJ5tad3a8uoWwUfwI8b0zueUffE3vJE1aiNoNMVN
	 BCNeDg4HEnmEM2cVFyDcyMf05sqALQUEHAdaTTb8asoKXmuXQlNhT6Iy/3ZBaVUY+9
	 q2qQFiZWjUhWdf4r63k3EKW3n8dzSWLdpf+JF1HzkjzSGd/RdxQGNR9TabkUEdjKSB
	 tQEURMuuz1mklacs2+TsTJDWsOEOAr8Yrry2QalmxeILTGOyQ1mPXRZdFR48GWoTOX
	 PuR43o6XjsdhOoLKdKAXeo8iarlfdedOq7cOF89m2bpHLcQkQTGqDwI9GetWd8bIhT
	 2Nf9YKlDOfNBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02F0938111CE;
	Thu, 23 Apr 2026 16:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v11 0/3] Add initial Channel Sounding support for
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177696240555.664628.12018499209882369582.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 16:40:05 +0000
References: <20260421113148.3809176-1-naga.akella@oss.qualcomm.com>
In-Reply-To: <20260421113148.3809176-1-naga.akella@oss.qualcomm.com>
To: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
 quic_anubhavg@quicinc.com, prathibha.madugonde@oss.qualcomm.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 21 Apr 2026 17:01:45 +0530 you wrote:
> This patch series introduces initial support for Bluetooth Channel
> Sounding (CS) using the raw HCI interface.
> This series lays the groundwork for CS support by adding commonly required
> protocol definitions, configuration parsing, and event handling for
> the reflector role.
> 
> The changes include:
> 
> [...]

Here is the summary with links:
  - [BlueZ,v11,1/3] shared: rap: Introduce Channel Sounding HCI raw interface support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d9da103fd1a2
  - [BlueZ,v11,2/3] main.conf: Add Channel Sounding config parsing support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=55262e1a2ccf
  - [BlueZ,v11,3/3] profiles: ranging: Add HCI LE Event Handling in Reflector role
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=868b9e3745dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


