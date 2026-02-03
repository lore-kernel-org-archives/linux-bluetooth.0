Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1760F3ACF05
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Feb 2026 18:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770142819; cv=none; b=OGAdn7Ky3WBfwcugMg/YT89pAyXcKofouaHilBx6T/n3tRxXfG1nZBZd2HAYmVs166qndp2z6EJgxgCuiMwBrw/3cgYEp5j9AXxxdcVK+jK5rZyHkc44/9rr/jDbdsNUiQ7zAE1NN3/Lh0MPKr8uOxFZiXK1VpYGS6QLR2pV8pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770142819; c=relaxed/simple;
	bh=KK63u+Ionip2ABuMxargTsbL7hTByp4X1Fpe8KO5x/Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M6WVdCm1bk+HZkI+3yS1/3lup+3ldAdBIQh9xe5hqo8XJNWM9IazDHe5aHY99ak6ntsEzQmrCLrriwFyWgoEY9q9IVLgdMCuS+MmboJOrUEEkfCc3+ANf+C2oeDTLCvmT4qmlJlV6OaInnJTgEjWvvnwi38ejvQ350E/8lQhaI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABfPCdmI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABfPCdmI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C75C116D0;
	Tue,  3 Feb 2026 18:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770142818;
	bh=KK63u+Ionip2ABuMxargTsbL7hTByp4X1Fpe8KO5x/Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ABfPCdmI1sjJuDOhcAnxMpm1mor4sQBFLKU6/VXwJNxx/oA2vrHaAkIdpvJvhFr1C
	 1YtQ7Ij7fVqi6fUlF3cjYJVVeoG/Vr8QNfI3ToIf1OS8uBbXNOGeNw7/rMdMkytmsw
	 NDfh7Djp0dYNEa1uP0W8wRCR22QPy0XWdvvHNfQ+uW80iH71ib8pxcWOW/faIaO59n
	 BRPHfxNKPoUPcKRxre5SMuD7ihMwWSvT1w3G68v+0WPgZZmeL8QeOpY6HAez/fYbGP
	 nA4ZvICupFEeLaLoliI8Wh+9kcdnOvWNK4K6lBfcwK9LKPwEVnn58LEFHj1URJFii5
	 VwJWdR6M7EgwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 90EF03808200;
	Tue,  3 Feb 2026 18:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 00/35] doc: Add cross-references between
 bluetoothctl
 and D-Bus API documentation
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177014281525.1588350.14020829158797445607.git-patchwork-notify@kernel.org>
Date: Tue, 03 Feb 2026 18:20:15 +0000
References: <20260130193921.1273263-1-luiz.dentz@gmail.com>
In-Reply-To: <20260130193921.1273263-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 30 Jan 2026 14:38:42 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This patch series enhances the BlueZ documentation by adding cross-references
> between bluetoothctl command documentation and D-Bus API documentation:
> 
> - bluetoothctl docs: Add :Uses: fields linking each command to its
>   corresponding D-Bus interface method(s)
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,01/35] doc/bluetoothctl: Add :Uses: fields and document arguments
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b4284016a35b
  - [BlueZ,v2,02/35] doc/bluetoothctl-mgmt: Add :Uses: fields and document arguments
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8153258ebe6c
  - [BlueZ,v2,03/35] doc/bluetoothctl-admin: Add :Uses: fields and document arguments
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7213d8dfd041
  - [BlueZ,v2,04/35] doc/bluetoothctl-advertise: Add :Uses: fields and document arguments
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c5715df9adb1
  - [BlueZ,v2,05/35] doc/bluetoothctl-assistant: Add :Uses: fields and document arguments
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fefe8c741363
  - [BlueZ,v2,06/35] doc/bluetoothctl-bredr: Add :Uses: fields and document arguments
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=061759b8736c
  - [BlueZ,v2,07/35] doc/bluetoothctl-endpoint: Add :Uses: fields and document arguments
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e3c20c3183ed
  - [BlueZ,v2,08/35] doc/bluetoothctl-gatt: Add :Uses: fields and document arguments
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=459e46abd054
  - [BlueZ,v2,09/35] doc/bluetoothctl-hci: Add :Uses: fields and document arguments
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8e926e4d8f16
  - [BlueZ,v2,10/35] doc/bluetoothctl-le: Add :Uses: fields and document arguments
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6238b7c3cabd
  - [BlueZ,v2,11/35] doc/bluetoothctl-monitor: Add :Uses: fields and document arguments
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=192dd3f72f36
  - [BlueZ,v2,12/35] doc/bluetoothctl-player: Add :Uses: fields and document arguments
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0dfb1cad3863
  - [BlueZ,v2,13/35] doc/bluetoothctl-scan: Add :Uses: fields and document arguments
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=16057f2ea3ee
  - [BlueZ,v2,14/35] doc/bluetoothctl-telephony: Add :Uses: fields and document arguments
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d7119120d26c
  - [BlueZ,v2,15/35] doc/bluetoothctl-transport: Add :Uses: fields and document arguments
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4d69f11acf8a
  - [BlueZ,v2,16/35] doc/org.bluez.Adapter: Add Used by reference and Examples
    (no matching commit)
  - [BlueZ,v2,17/35] doc/org.bluez.AdminPolicySet: Add Used by reference and Examples
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d0841ac272dd
  - [BlueZ,v2,18/35] doc/org.bluez.AdminPolicyStatus: Add Used by reference
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5490e7e4ccaf
  - [BlueZ,v2,19/35] doc/org.bluez.AdvertisementMonitor: Add Used by reference
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=21732e9c6b9c
  - [BlueZ,v2,20/35] doc/org.bluez.AdvertisementMonitorManager: Add Used by reference
    (no matching commit)
  - [BlueZ,v2,21/35] doc/org.bluez.AgentManager: Add Used by reference and Examples
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=aeff7ee796ff
  - [BlueZ,v2,22/35] doc/org.bluez.Call: Add Used by reference and Examples
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=58029c4cf245
  - [BlueZ,v2,23/35] doc/org.bluez.Device: Add Used by reference and Examples
    (no matching commit)
  - [BlueZ,v2,24/35] doc/org.bluez.GattCharacteristic: Add Used by reference and Examples
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2123ab772fbe
  - [BlueZ,v2,25/35] doc/org.bluez.GattDescriptor: Add Used by reference
    (no matching commit)
  - [BlueZ,v2,26/35] doc/org.bluez.GattManager: Add Used by reference and Examples
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fe274b385fda
  - [BlueZ,v2,27/35] doc/org.bluez.GattService: Add Used by reference
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=313ea6ba6121
  - [BlueZ,v2,28/35] doc/org.bluez.LEAdvertisement: Add Used by reference
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=056589a17947
  - [BlueZ,v2,29/35] doc/org.bluez.LEAdvertisingManager: Add Used by reference and Examples
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4bb5abd20484
  - [BlueZ,v2,30/35] doc/org.bluez.Media: Add Used by reference
    (no matching commit)
  - [BlueZ,v2,31/35] doc/org.bluez.MediaAssistant: Add Used by reference and Examples
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bd7396ef8a62
  - [BlueZ,v2,32/35] doc/org.bluez.MediaEndpoint: Add Used by reference
    (no matching commit)
  - [BlueZ,v2,33/35] doc/org.bluez.MediaPlayer: Add Used by reference and Examples
    (no matching commit)
  - [BlueZ,v2,34/35] doc/org.bluez.MediaTransport: Add Used by reference and Examples
    (no matching commit)
  - [BlueZ,v2,35/35] doc/org.bluez.Telephony: Add Used by reference and Examples
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d390dbb58d45

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


