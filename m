Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1DC1339B5
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706209828; cv=none; b=MZWHBogTK6tX769tz6rQbCmm6E2lRFDeDyGHsOpG+0Cxg6G13pqfDhfessDwLcInHLprrYD/7dh2rctJjWZ2MxHZTJNSPvl17M9QcR29LDsJRx/vxNmRaS7e2MiwxU5xwGcfhb5uLUbQGpz/MznEfIDJykq1xDL2p/hsj+2hyd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706209828; c=relaxed/simple;
	bh=ZOuS1GaI5meOk7plDU5/px3AUrt2MhtXvWQQw7lroqc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CX3rWyxN5JK1eesD/5aaisUG/ezr3DDMdkKZDAH2+kmWEeNyGPCKfc03GUPbHsQINDIROa2ZP33XoIssZD2+7HfzX0mZI5EfJQ/uL8syA0UUgaSMg7wqPJYHwGTVTEZe66KdHXq80koLPPeBA5dUboTFfrQJUiw9i/Yc+cIde2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqi/ji7s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqi/ji7s"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB4BCC433F1;
	Thu, 25 Jan 2024 19:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706209828;
	bh=ZOuS1GaI5meOk7plDU5/px3AUrt2MhtXvWQQw7lroqc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gqi/ji7so/Z4Ne/v4CguIYb/Ln7hDp7bB0zdcsc9ze5lJvimIGkrs/fe91LTYewhR
	 6NZjJnsA63zwbfcIorcEqRLEUspd1bAAuXsb/iUYee22K/ImM92uv0l9KeGm/jAhxX
	 rCyXYQspMkqjSRubcqxRwzHZqcUyA1opv1nVFtCwo0h/1Bza/0GKGc4zCenjIIlMW2
	 8IJpZNf6421pPlbRtcQqtfnq5h5T9SqmDwu9V9EaCe2O5plvSfci7kQt+YdWbaLjOb
	 V5V5rbqaES9awLSChHI4qV0TjpvjO3n7UssnqsJRYAEWmJ5iCyEB3tyd3yPQ2lcTZT
	 NNqEg7PYh1klg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D5C94D8C961;
	Thu, 25 Jan 2024 19:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/6] Autotools papercuts, linker GC, symlink
 dbus-org.bluez.obex.service
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170620982787.23941.6481888174452761774.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jan 2024 19:10:27 +0000
References: <20240124-autofoo-v2-0-a210f20aa2f7@gmail.com>
In-Reply-To: <20240124-autofoo-v2-0-a210f20aa2f7@gmail.com>
To: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, emil.velikov@collabora.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 24 Jan 2024 16:20:05 +0000 you wrote:
> Hello everyone,
> 
> Here is v2 of the autotoo papercuts.
> 
> Changes in this revision:
>  - dropped already merged patches - thanks o/
>  - drop "build: remove dummy {conf,state}{dir,_DATA}" patch
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/6] build: remove unused variable builtin_nodist
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=215e6c7083da
  - [BlueZ,v2,2/6] build: remove .service files from DEPENDENCIES lists
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=14c7f21292b1
  - [BlueZ,v2,3/6] build: remove explicit DEPENDENCIES handling
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=808d008aace3
  - [BlueZ,v2,4/6] build: manage .service.in files via configure.ac
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=116524c01de4
  - [BlueZ,v2,5/6] build: enable gc/dead code removal
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=10d6d908b5fe
  - [BlueZ,v2,6/6] build: install dbus-org.bluez.obex.service symlink
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1cd6c874c271

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


