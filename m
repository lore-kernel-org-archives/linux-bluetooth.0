Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC60F4A1E01
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792073865; cv=none; b=EOIg6p6fLq3CaUMJG78/PwSeCDy6Ty8HN3JDnqKm8/fyimOknPJ4Fih4ugRKcHdIDX4K8RftIyLc3ddu5dSo9e0l02RH27il4ouFvuACzrpLYY4bRXc7OJF8levspQdXJlpLQGrd7vDj8KNlRIUQFix4yybkHzkqSLAYpjTezxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792073865; c=relaxed/simple;
	bh=QUCelfqIyn0PE0iXramhblaLXPpX8YNc3TRp64dK80Y=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ePjFbwlwFENr6JwTz+0FzuPCwMGsVSqky8Bv1hgqt+4cIc96g59BMN9FAzSzculBI3N+WtAVPOH5GAPLIgRwHV8nEWw9fMPUYyQSfX7oVKpZSebL81ownJXcIzgxydevPXFPldZSwA0xJm/xlSZCdNjRXO91YEdLdmDAoQf6JSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=unDSlsRo; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="unDSlsRo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1792073858; x=1792333058;
	bh=wsNMQzzgvlWtCoxTSYtt92+3Z52KFEZCq2UStG5/12g=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=unDSlsRoK4loq+SmgwC6Barc2X8GzYt2NMnfqJz5kE+cT74DQ50crF7nKrJkeQXQC
	 Ka8IvhJZbDeDGQEIsNmiDEYJaT9S78bDF+bm+rNSGCreyyOjWpeF3m+zCLBTtgta2N
	 AKZNQx5gCAtREBpBeOuIyk3ISZBW3hParige9oZ/2HGHjcBy1mW4kRoYhv9xEWbR3D
	 4/qgFNUehXPnu146PAKGRVcS3N7WbqaqlXx0FhA5iGj6BWxa24ksCnkbS5U3TKgomg
	 8VrEaumZAlhV/NCXpTplaFpznj/nBsvwxPTunDJh9D7l0ARBFC88tPNN/bePFfYUaP
	 5aysCwnFCVjnQ==
Date: Thu, 15 Oct 2026 14:17:35 +0000
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: overfion <overfion@proton.me>
Cc: Sean Wang <sean.wang@mediatek.com>, Chris Lu <chris.lu@mediatek.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Subject: [BUG] btmtk: MT7925 (0e8d:e025) firmware ASSERT in sys_log_interface_emi.c #1185 during A2DP streaming, regression since fw 20260605184935
Message-ID: <aIInPl7g7dGa1ySgQwHytJmvMjs9REEFRg37v2cHI_wVJB7-yXeJyH6OHIGGkvJVxlmNBdBLmu5mh15kd16JgHUVeBktDvoaSBPelTrpXLU=@proton.me>
Feedback-ID: 45576258:user:proton
X-Pm-Message-ID: 0504454dd0ae47e7df29a6c9e60ef3e9e0b502df
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

The MT7925 Bluetooth firmware on my laptop asserts several times per day
while streaming A2DP to a headset. btmtk collects a coredump, btusb
resets the USB device and the controller re-enumerates as a new hciN,
dropping the headset.

Hardware:  Lenovo ThinkPad P14s Gen 6 AMD (21QMS1HT00), BIOS R2XET42W (1.22=
) 2026-09-07
Chip:      MT7925, BT over USB 0e8d:e025 (WiFi on PCIe 14c3:7925, mt7925e)
BT fw:     BT_RAM_CODE_MT7925_1_1_hdr.bin, Build Time 20260813113236
           (t-neptune-main-mt7925-2249-MT7925_E1_ASIC_ROM_RAM_CE_2249_CCN16=
-20260813112803)
Kernels:   reproduced on Arch linux, linux-lts, linux-zen and CachyOS linux
           kernels, 7.0.12 through 7.2.9
Userspace: bluez 5.87, pipewire + wireplumber
Headset:   Logitech G435, A2DP sink, AAC codec
WiFi:      connected on 5 GHz (channel 48)

Firmware assert (identical in every dump I collected):

  <ASSERT> ../bluetooth/system/debug/sys_log_interface_emi.c #1185 - 0, 0x6=
454,
  0x1010707, 0xFF150001, BTSYS, id=3D0x0 idle, isr=3D0x943CA8, irq=3D0x3,
  lr=3D0x960AC8, asr_t=3D103074398
  ;etype:ASSERT, sp=3D0x2215A30, lp=3D0x960AC8
  ;exp_main: jump from cos_assert

A btmon capture shows no HCI commands from the host in the 316 seconds
before the assert, only A2DP ACL data (dlen ~530-555, every ~21 ms) and
Number of Completed Packets events. The assert fires in ISR context in
the firmware's log/EMI path, not in response to a host command.

Kernel side:

  Bluetooth: hci0: Mediatek coredump end
  usb 3-5.1: reset high-speed USB device number 5 using xhci_hcd
  Bluetooth: hci1: HW/SW Version: 0x00000000, Build Time: 20260813113236
  Bluetooth: hci1: Device setup in 1750899 usecs

Sometimes it asserts again seconds after recovery, followed by a
command timeout and another reset:

  Bluetooth: hci1: Mediatek coredump end
  Bluetooth: hci1: Opcode 0x2039 failed: -110
  usb 3-5.1: reset high-speed USB device number 5 using xhci_hcd

Regression: no failures on fw 20260414153243 (5 weeks, same headset and
usage). Failures started the day 20260605184935 was installed and
continue on 20260813113236.

Already tried, no effect: btusb.enable_autosuspend=3D0, mt7925e
disable_aspm=3D1, WiFi power save off.

I have 2 devcoredumps (~1 MB each) and the btmon capture (12 MB). I can
send them off-list, test firmware builds or patches, or collect more
traces.

Thanks,
fion

