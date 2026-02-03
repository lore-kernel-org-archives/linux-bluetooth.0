Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19EC275B0F
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Feb 2026 18:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770142820; cv=none; b=i1usC3H7bckb5dksjJNzVCKMaZmaCKTB2Ulxfh/rOstSyRp1cfNeIt6pX1kGVaKQRaLSjFOho+0mvaz5vV4I7EOstsh4KlZr3uYlfRP5pK9mLr26G6NkOaQHRiVehtMQ8ba54izE+fEEFmHjai33tw+rbBEjSBEQOb5veHHa1Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770142820; c=relaxed/simple;
	bh=sl9QfhiJ7SK5b5KloelhLvdqGoeFnD0MeneUh8QZ3J0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mW8teTAWxyg6EihcnwpthSamAywFuM9/CEnraPDM7iBRRDZzPogaPkjIbVBD8fF853YJork5RswtwNeL5yjD/eJNmb3cwOdnW9KchAHKRoPyoUuuTt0mdALmYuFpqpkqGJt+lx6EnQ1GpGBNGTTnwhDy4tTULggUL5oBNiK+FaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpuTBl6P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpuTBl6P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA65C116D0;
	Tue,  3 Feb 2026 18:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770142820;
	bh=sl9QfhiJ7SK5b5KloelhLvdqGoeFnD0MeneUh8QZ3J0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gpuTBl6Px9z8zplDvOlew3nPASwnd6IyPI8+eBrvZobDT9/HlRS2CSRaU8ME0Li1P
	 qJRPfShD6h2uIp+FteOJcKWBBMxcwIkQAQt5L18bnuXW/402BfxSwWvR2ERtDi7b2Z
	 UYspkfcWywaP/Hg2gtVCQGRjvAik2EII5j6MEc0GCSuEkAct6ACjVpIULkmrWLdnwq
	 ZTmIZPXFbubP0a3WLtghAcaaVtupoyxwa3UKmoh6B+N8n8tMlRY45/ImbC/Xw8RZNb
	 AFva5RpAtyAdPwpKELhOY390atuegxlBaFQmlkg2+yXennHTNl752Sp+7JnYfRNZI+
	 P2RWAF9VQW5RA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 16D1E3808200;
	Tue,  3 Feb 2026 18:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 00/37] doc: Add cross-references between
 bluetoothctl
 and D-Bus API docs
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177014281661.1588350.11997574295543752338.git-patchwork-notify@kernel.org>
Date: Tue, 03 Feb 2026 18:20:16 +0000
References: <20260130220229.1346261-1-luiz.dentz@gmail.com>
In-Reply-To: <20260130220229.1346261-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 30 Jan 2026 17:01:51 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This patch series adds cross-references between bluetoothctl man pages
> and D-Bus API documentation to improve discoverability and help users
> navigate between the command-line interface and the underlying D-Bus
> APIs.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,01/37] doc/bluetoothctl: Add :Uses: fields and document arguments
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b4284016a35b
  - [BlueZ,v3,02/37] doc/bluetoothctl-mgmt: Add :Uses: fields and document arguments
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8153258ebe6c
  - [BlueZ,v3,03/37] doc/bluetoothctl-admin: Add :Uses: fields and document arguments
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7213d8dfd041
  - [BlueZ,v3,04/37] doc/bluetoothctl-advertise: Add :Uses: fields and document arguments
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c5715df9adb1
  - [BlueZ,v3,05/37] doc/bluetoothctl-assistant: Add :Uses: fields and document arguments
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fefe8c741363
  - [BlueZ,v3,06/37] doc/bluetoothctl-bredr: Add :Uses: fields and document arguments
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=061759b8736c
  - [BlueZ,v3,07/37] doc/bluetoothctl-endpoint: Add :Uses: fields and document arguments
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e3c20c3183ed
  - [BlueZ,v3,08/37] doc/bluetoothctl-gatt: Add :Uses: fields and document arguments
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=459e46abd054
  - [BlueZ,v3,09/37] doc/bluetoothctl-hci: Add :Uses: fields and document arguments
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8e926e4d8f16
  - [BlueZ,v3,10/37] doc/bluetoothctl-le: Add :Uses: fields and document arguments
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6238b7c3cabd
  - [BlueZ,v3,11/37] doc/bluetoothctl-monitor: Add :Uses: fields and document arguments
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=192dd3f72f36
  - [BlueZ,v3,12/37] doc/bluetoothctl-player: Add :Uses: fields and document arguments
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0dfb1cad3863
  - [BlueZ,v3,13/37] doc/bluetoothctl-scan: Add :Uses: fields and document arguments
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=16057f2ea3ee
  - [BlueZ,v3,14/37] doc/bluetoothctl-telephony: Add :Uses: fields and document arguments
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d7119120d26c
  - [BlueZ,v3,15/37] doc/bluetoothctl-transport: Add :Uses: fields and document arguments
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4d69f11acf8a
  - [BlueZ,v3,16/37] doc/org.bluez.Adapter: Add Used by reference and Examples
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=34a0969a8aac
  - [BlueZ,v3,17/37] doc/org.bluez.AdminPolicySet: Add Used by reference and Examples
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d0841ac272dd
  - [BlueZ,v3,18/37] doc/org.bluez.AdminPolicyStatus: Add Used by reference
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5490e7e4ccaf
  - [BlueZ,v3,19/37] doc/org.bluez.AdvertisementMonitor: Add Used by reference
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=21732e9c6b9c
  - [BlueZ,v3,20/37] doc/org.bluez.AdvertisementMonitorManager: Add Used by reference
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=48524504310b
  - [BlueZ,v3,21/37] doc/org.bluez.AgentManager: Add Used by reference and Examples
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=aeff7ee796ff
  - [BlueZ,v3,22/37] doc/org.bluez.Call: Add Used by reference and Examples
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=58029c4cf245
  - [BlueZ,v3,23/37] doc/org.bluez.Device: Add Used by reference and Examples
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4d4fb9c93cb2
  - [BlueZ,v3,24/37] doc/org.bluez.GattCharacteristic: Add Used by reference and Examples
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2123ab772fbe
  - [BlueZ,v3,25/37] doc/org.bluez.GattDescriptor: Add Used by reference
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d0488f7ea3e9
  - [BlueZ,v3,26/37] doc/org.bluez.GattManager: Add Used by reference and Examples
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fe274b385fda
  - [BlueZ,v3,27/37] doc/org.bluez.GattService: Add Used by reference
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=313ea6ba6121
  - [BlueZ,v3,28/37] doc/org.bluez.LEAdvertisement: Add Used by reference
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=056589a17947
  - [BlueZ,v3,29/37] doc/org.bluez.LEAdvertisingManager: Add Used by reference and Examples
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4bb5abd20484
  - [BlueZ,v3,30/37] doc/org.bluez.Media: Add Used by reference
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ee1551a533f0
  - [BlueZ,v3,31/37] doc/org.bluez.MediaAssistant: Add Used by reference and Examples
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bd7396ef8a62
  - [BlueZ,v3,32/37] doc/org.bluez.MediaEndpoint: Add Used by reference
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=51d1582aa803
  - [BlueZ,v3,33/37] doc/org.bluez.MediaPlayer: Add Used by reference and Examples
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=55caa7ab126f
  - [BlueZ,v3,34/37] doc/org.bluez.MediaTransport: Add Used by reference and Examples
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=54447c93e517
  - [BlueZ,v3,35/37] doc/org.bluez.Telephony: Add Used by reference and Examples
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d390dbb58d45
  - [BlueZ,v3,36/37] doc/org.bluez.MediaFolder: Add Used by reference and Examples
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5ce86fc6ace3
  - [BlueZ,v3,37/37] doc/org.bluez.MediaItem: Add Used by reference and Examples
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9b54cf6dd87f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


