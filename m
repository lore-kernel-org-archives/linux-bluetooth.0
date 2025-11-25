Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD731487E9
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Nov 2025 16:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764088245; cv=none; b=TKU17g33gmt5peUnldwBFDQ4k/gr7MqgD25Dz6oyd+ka2ZLgIkrGFNZfdXfZr66GyZAVTO0N2P7M1+LoMWxzKMLyFkDY+VXgMyVy0IEGndWCdvr43cmU8/C0XbPxaJh3UTxPVwRS1a5tBsZchBOPvTBmcdRH7cKfM5VSA2lsVLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764088245; c=relaxed/simple;
	bh=vwrxT9AJ/b53tsYOnv07pWxn/wG29PLv+IUofrTXayc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R6z+38oDFOjEN+wkQe37WZHk6Uh44t29sQtB7S4VOEX52C+zd8Mok5Tf8xC5PNDMBrMOLjevJoxE2DD43idAuX/IW+2Yua+Q73gFi8y1uoyWQCyDIW75ZAk6H1kfS84o+ctbmmbzKZVrmseDyWNSo43Bd9siwRJIS/xlnQQ79Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrIws/uz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrIws/uz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E86BC4CEF1;
	Tue, 25 Nov 2025 16:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764088245;
	bh=vwrxT9AJ/b53tsYOnv07pWxn/wG29PLv+IUofrTXayc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PrIws/uzyFKP+saXEQY6J+D4L1nVI+26fOnLoCs6GRXSAbom4PRR0oPAKtell0GoB
	 0fvVt2Eo1JqpUSfdrc1gvrXn2psPjQE/X4Sx0MpmG6a2sZT5KZD8I1cr/tiPavVJIl
	 KNnU0FlF6sPQs7ciBq4qrLcO+N/PUhApo7QcA39vd+uImAkr02piryRlE1tjqgooZp
	 CxuNJ1z5/UvRp4SFim0Be0QAaO6TxiqVCubf4qbBu0BPKvCttfWLqqaFDENqQq7evl
	 WY2wzwDxdKfoHYmbeIzdAM+/yq92/fEGP1TTdh/pxeHUAOrFde/c6Kr0oqaRABZ9tm
	 pgDuseXSSaDRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF98380AA61;
	Tue, 25 Nov 2025 16:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bluez v1] transport/audio: fix build with a2dp support
 disabled
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176408820751.830058.168632641278620652.git-patchwork-notify@kernel.org>
Date: Tue, 25 Nov 2025 16:30:07 +0000
References: <20251122161046.177385-1-ps.report@gmx.net>
In-Reply-To: <20251122161046.177385-1-ps.report@gmx.net>
To: Peter Seiderer <ps.report@gmx.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 22 Nov 2025 17:10:46 +0100 you wrote:
> Fixes:
>     CCLD     src/bluetoothd
>   /usr/lib64/gcc/x86_64-suse-linux/bin/ld: profiles/audio/bluetoothd-media.o: in function `endpoint_init_a2dp_sink':
>   .../bluez-5.85/profiles/audio/media.c:728:(.text.endpoint_init_a2dp_sink+0x2b): undefined reference to `a2dp_add_sep'
>   /usr/lib64/gcc/x86_64-suse-linux/bin/ld: profiles/audio/bluetoothd-media.o: in function `endpoint_init_a2dp_source':
>   .../bluez-5.85/profiles/audio/media.c:715:(.text.endpoint_init_a2dp_source+0x28): undefined reference to `a2dp_add_sep'
>   /usr/lib64/gcc/x86_64-suse-linux/bin/ld: profiles/audio/bluetoothd-media.o: in function `set_configuration':
>   .../bluez-5.85/profiles/audio/media.c:512:(.text.set_config+0x35): undefined reference to `a2dp_setup_get_device'
>   /usr/lib64/gcc/x86_64-suse-linux/bin/ld: .../bluez-5.85/profiles/audio/media.c:525:(.text.set_config+0x8c): undefined reference to `a2dp_setup_remote_path'
>   /usr/lib64/gcc/x86_64-suse-linux/bin/ld: profiles/audio/bluetoothd-media.o: in function `media_endpoint_remove':
>   .../bluez-5.85/profiles/audio/media.c:250:(.text.media_endpoint_remove+0xc): undefined reference to `a2dp_remove_sep'
>   /usr/lib64/gcc/x86_64-suse-linux/bin/ld: profiles/audio/bluetoothd-media.o: in function `endpoint_reply':
>   .../bluez-5.85/profiles/audio/media.c:361:(.text.endpoint_reply+0x267): undefined reference to `a2dp_parse_config_error'
>   collect2: error: ld returned 1 exit status
>   make[1]: *** [Makefile:5491: src/bluetoothd] Error 1
>   make: *** [Makefile:4096: all] Error 2
> 
> [...]

Here is the summary with links:
  - [bluez,v1] transport/audio: fix build with a2dp support disabled
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0b7395a34796

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


