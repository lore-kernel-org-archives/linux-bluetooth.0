Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193881547C0
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775764833; cv=none; b=j2wluzZajb03/KDwLuWW16oGAvsHWkRUM+aK3dpmLpwZLHPZyQJ096C2Kd9vl128trtXBvHkVaOH1erKFl3f3e9wTkTFe9EALOMkDv5hK/bnjSoNa32BqQ4vJwTrr3Pc6ZWUtvu0cD0FjjSkXzdVfJB11BJDc8wC414AN1gphk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775764833; c=relaxed/simple;
	bh=ONQEdR/bCSxd0+M9XKhOhhK+eMDQHVHamCDtb55dnsI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h5bEs4Iscac9Le7jAuy0AlqlsDRrZNP9XkRx/RPV/bBlmuZ6wtHFzLslVYyqTwXREIFIF9fOmwjcPsVWPxXFIK9jD8nbfXgOtNBwZqG8/ioBJFcr4fCdfwroXoayVQzNmkS7IWMKHmIp45tV4Y9TqFkkhGcx5/3TLLvbmW207GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWFvPs6z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWFvPs6z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8252C4CEF7;
	Thu,  9 Apr 2026 20:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775764832;
	bh=ONQEdR/bCSxd0+M9XKhOhhK+eMDQHVHamCDtb55dnsI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CWFvPs6zbo8ODbEBNLoE4pTJQiG1i1qfVMmQHZb7ZFLkCNXH6w8pfVtK35Ckdgyqs
	 PJy6ju30VVGZEFDOc39Kbdp8oPi/N/CohmaCaievQbDOqs5OfnYNV94t6HDbn1d3TK
	 Qvsx3g/AwLWEA1kUoU0xA3ijMlXk4SRnKHs+rZnzs0yFsZM7cVJDnmqB5u2q/88OBw
	 KS3xN1/r7/YMMK05GaA3haTSAtqNAkITKFGDQiILdQ78atC2TclM3SSXOa1YLJEsvk
	 DayEeUmGTFVT46VPT3Xmq9JoZHrUtP5Rp0s8fdLscRaH3SnWDErPy4DG0TlzPPcNAP
	 K5gzk+b85gzIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CCDE39308B7;
	Thu,  9 Apr 2026 20:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/3] device: Fix btd_device_connect_services not
 discovering
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177576480804.1716836.13143854168077217345.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 20:00:08 +0000
References: <20260408182223.295711-1-luiz.dentz@gmail.com>
In-Reply-To: <20260408182223.295711-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  8 Apr 2026 14:22:21 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> btd_device_connect_services would not attempt to discover in case the
> selected bearer is BR/EDR and once discover is complete then it shall
> proceed with connecting the services.
> ---
>  src/adapter.c |  9 ---------
>  src/device.c  | 27 +++++++++++++++++++++++++--
>  2 files changed, 25 insertions(+), 11 deletions(-)

Here is the summary with links:
  - [BlueZ,v2,1/3] device: Fix btd_device_connect_services not discovering
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=418306daec60
  - [BlueZ,v2,2/3] client: Prompt user to start scanning on connect command
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c8527a27723b
  - [BlueZ,v2,3/3] client: Stop discovery when connected with filter.auto_connect
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=44e54e39ae1a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


