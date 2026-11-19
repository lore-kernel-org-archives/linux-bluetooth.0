Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795109411;
	b=rXaIfH/26KDjtc//y8C1EevyG1D79rGFdkjcfcHg5KJlGKuHyNp/AR0go2P7mK8F1MFh
	 IM8kYDxTDpn7FL7AWCz5a0kpUtg1T87k2XsUlBbe9YGagfUvtRCCDvL0MflOHh4v/euQA
	 YIHMaV+VSUPX/qxC7A1ingUWjSUN1aXqjwZL8XsbAlSszGJ6FLz78YWtiQ8oRaOjYwtuF
	 Gt4XepODTWZuLWskeUVxW2BL2PKeJs7ulOBe6K0ip0lJjGmMWqQZ3MUlUPEU/O05yYyOw
	 N6+BG852ZAVpoK1eOFMWI9540MegG1P/WtxXJAAWdiMOfPC3wyFRISLwObS+nsij7sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795109411;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=ft3mmSChUDGt4cL2Ec9qfIEVMzlaJuMpFHKTNh39bDI=;
	b=ryQGP02qCHZUdnBDKXGWOh707GSvz5G9iSPqAcCDFAD/dFKJtvQBDsgH1zu9tVSUMtj5
	 XAhVhpHG4lhwj+8KjsBwMdz2Y/LSLTClsd/YMCFdvFyB+K5CNSnNiEYZhmfr8XXuWU/bg
	 LGvl8mda4ysq33IEShLhwTxiuMrxhDkpeeoGxsLuAshT8diPvkTEyHoCfv9yGJif/2fzw
	 nWs3z7KAjZhUmRn/DjgmDlNdykMEooXGfSNiUjgRhwNHU0ydv0GEq8OTacUE2APuyok3j
	 wDViycgk5XxboBEGKTCb56YuGC2utAX7tLPdx6oxctGPxIiqz6kSYSLYUTsOQVPHytg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i2zUAGIi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796E2606A338
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 17:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i2zUAGIi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BB11F000C5;
	Thu, 19 Nov 2026 17:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795109411;
	bh=ft3mmSChUDGt4cL2Ec9qfIEVMzlaJuMpFHKTNh39bDI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=i2zUAGIi4s/4vAwdt69Dj5Ez2MX78vDd2bGv77M+JUKCJAdetGElyqtvzRCVGvkqE
	 w7HGBw1TJbWros++1mDLVopLtW86ChiDX6bPueuHaQyo81DAdsza7iaJ7Ue3elOQIt
	 YMfmratH8ClolUHVUgVWMaf2gdJXJWSa4eySbnMbw09qwqM23xvhmf4UYbXH8qFtfB
	 1YWUK6Pkh+4vCRw9mrk3V/SBtoxVLvdVFp5PTI1uL3XgU81ZEglSpnmX2jHOeFAixH
	 NrRu6QHm7gNCzcynQR2qwivvhVT1EjOjxSHoymEJRSfAfQ2j1Wx9MUfyjkc0vSURBU
	 KVwTp7G6QtIKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15463808210;
	Thu, 19 Nov 2026 17:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 00/17] Bluetooth: Fixes for issues reported by
 sashiko.dev
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179510940978.3231831.6458719198997058051.git-patchwork-notify@kernel.org>
Date: Thu, 19 Nov 2026 17:30:09 +0000
References: <20261118191118.318779-1-luiz.dentz@gmail.com>
In-Reply-To: <20261118191118.318779-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 18 Nov 2026 14:11:01 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This series fixes issues reported by sashiko.dev against the Bluetooth
> core, each patch carries the identifier of the report(s) it addresses in
> its Reported-by tag.
> 
> Missing locking around shared state:
>  - Patch 2 takes hci_req_sync_lock around hci_powered_update_sync() in
>    hci_power_on().
>  - Patches 3 and 4 look up advertising instances under hdev->lock in
>    hci_disable_ext_adv_instance_sync() and
>    hci_schedule_adv_instance_sync().
>  - Patch 5 serializes the writers of hdev->link_keys. smp_notify_keys()
>    runs with the l2cap channel lock held, which is ordered after
>    hdev->lock, so this adds a dedicated hdev->link_keys_lock instead of
>    taking hdev->lock there.
>  - Patch 13 protects the MSFT event prefix with hdev->lock.
>  - Patch 15 holds hdev->lock while looking up and freeing advertisement
>    monitors.
> 
> [...]

Here is the summary with links:
  - [v5,01/17] Bluetooth: mgmt: Fix read_index_list() buffer overflow
    https://git.kernel.org/bluetooth/bluetooth-next/c/cfdd650c5dab
  - [v5,02/17] Bluetooth: hci_core: Take req_sync lock in hci_power_on()
    https://git.kernel.org/bluetooth/bluetooth-next/c/6a296a465812
  - [v5,03/17] Bluetooth: hci_sync: Lock the lookup in hci_disable_ext_adv_instance_sync()
    https://git.kernel.org/bluetooth/bluetooth-next/c/8984b72f9508
  - [v5,04/17] Bluetooth: hci_sync: Hold hdev->lock in hci_schedule_adv_instance_sync()
    https://git.kernel.org/bluetooth/bluetooth-next/c/c592dfe9637c
  - [v5,05/17] Bluetooth: SMP: Serialize link key updates from smp_notify_keys()
    https://git.kernel.org/bluetooth/bluetooth-next/c/e428ab70fb33
  - [v5,06/17] Bluetooth: SMP: Check smp_data before using SMP_DEV()
    https://git.kernel.org/bluetooth/bluetooth-next/c/e8764a694634
  - [v5,07/17] Bluetooth: SMP: Don't create the BR/EDR channel while unregistered
    https://git.kernel.org/bluetooth/bluetooth-next/c/8a119ba64f33
  - [v5,08/17] Bluetooth: hci_event: Validate sent command length in LE Set Ext Adv Enable
    https://git.kernel.org/bluetooth/bluetooth-next/c/ad7c1f067df2
  - [v5,09/17] Bluetooth: mgmt: Reject zero multi advertising rotation duration
    (no matching commit)
  - [v5,10/17] Bluetooth: L2CAP: Don't use uninitialized EFS in l2cap_parse_conf_rsp()
    https://git.kernel.org/bluetooth/bluetooth-next/c/cb3251457da2
  - [v5,11/17] Bluetooth: mgmt: Fix mesh transmission locking and lifetime
    https://git.kernel.org/bluetooth/bluetooth-next/c/1d7a52778858
  - [v5,12/17] Bluetooth: MGMT: Fix use-after-free in mgmt_powering_down()
    https://git.kernel.org/bluetooth/bluetooth-next/c/7c8dcf322b0d
  - [v5,13/17] Bluetooth: MSFT: Protect the event prefix with hdev->lock
    https://git.kernel.org/bluetooth/bluetooth-next/c/0434cd10518c
  - [v5,14/17] Bluetooth: hci_debugfs: Fix racy toggling of debugfs controlled flags
    https://git.kernel.org/bluetooth/bluetooth-next/c/b49abf5f92ea
  - [v5,15/17] Bluetooth: hci_core: Hold hdev->lock when removing advertisement monitors
    https://git.kernel.org/bluetooth/bluetooth-next/c/7f08b6ef44fa
  - [v5,16/17] Bluetooth: MSFT: Free the response of the monitor commands
    https://git.kernel.org/bluetooth/bluetooth-next/c/775eca0c3df2
  - [v5,17/17] Bluetooth: hci_core: Don't fail removing a monitor unknown to the controller
    https://git.kernel.org/bluetooth/bluetooth-next/c/8d3e5e6fe6d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


