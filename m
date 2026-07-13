Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6821D14F70
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 00:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783901686; cv=none; b=IH7h9s+od79JIlM051wh9SkfX27sgljLXjZH/G6D2UsE9ttw7pQFW36C4l2spubbMNXc6I3rDGvCcvVc/BtOCmzGg3hGFsbsAy3MbTvtCvy2MN4lst8xo0vnCebVLC7fjd2jzl9dRUX/mbc52H8RCEO/xiHS9zpz9fYsC93r6CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783901686; c=relaxed/simple;
	bh=WZI8p1iQfY0gWBQiidp+LYJMhmj/upPIv/OdGo0ct10=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=GjqYriggPcdQOKRJkVZ5CodfB5+2tr4gmrnVOOC9mcZD/Cpnpv2CgxF6X3AeaMcd25ajzbHs5C9OjP/vO4BQOLKIoqP4wJVaKfJGc7jFkDeojFpiA5M5isZvXIq3tas7YfOcUqx8NTQh4uvKZGQyRviNoSwG/M7YunA8eeO4sP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=AKB0Fdat; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="AKB0Fdat"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gz2xP0vV7z8tNT
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 02:14:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783901673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lBTKlCel8kChvcXRJCSA/gFFRv9sbvI9QIqsEf4UVvE=;
	b=AKB0Fdati9PGFc9yqHwA8WgboWAQ7z6LoIeG0+VKobIF6MVSTy2fUYAZVFbggqgGGOBbf1
	aAqm3Dpk9rJbxirWlLvIiYOBH6wdJ3qZTvi0ru+pYiRIzssFqRwEZWs9LydRR8SH6QJwPE
	8LxVa5wrKKK8m+IWC4buQ4ITppyzANITJThK5nxzRUQiJBvzr2UiS4is/X8kBFtww2C9mV
	37vzvsfUmCQVBgEl6T8WR8ZhRgd3SDDDiJfpOlOkhC1NcXcsgPi1XjmoUMci059vlOpAp/
	4witx6jLrRfbC3K2vtgCnijWi3Y77hHeHpzhmKaVZtDshAwX0R7W+Ze6exmXqA==
Date: Mon, 13 Jul 2026 02:14:32 +0200 (CEST)
From: ultron321@mailbox.org
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-ID: <39049458.689965.1783901672028@app.mailbox.org>
Subject: Sony INZONE Buds (LE Audio only) terminate link with 0x13 before
 CIS setup; works on Windows 11, same controller
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-MBO-RS-META: sn9tszhqz9rj41ehdczmzxnu5tk616sa
X-MBO-RS-ID: 696b6fb79864691b3b0

Hi,
 
I am unable to use a pair of LE-Audio-only earbuds (Sony INZONE Buds) over
Bluetooth on Linux. They bond and complete GATT discovery, but the peripheral
then terminates the ACL with reason 0x13 (Remote User Terminated) before any
CIS is set up, so no audio stream is ever established.
 
The same earbuds work out of the box on Windows 11 on the *same laptop / same
controller*, which rules out the controller and the earbud firmware and points
to the host stack.
 
 
Environment
-----------
- BlueZ:        5.86  (also reproduced with bluez-git master)
- Kernel:       7.1.2-arch3-1  (Arch / EndeavourOS)
- PipeWire:     1.6.7
- WirePlumber:  0.5.15
- liblc3:       installed
- bluetoothd:   running with Experimental enabled; BAP endpoints are registered:
      bluetoothd: Endpoint registered: path=/MediaEndpointLE/BAPSink/lc3
      bluetoothd: Endpoint registered: path=/MediaEndpointLE/BAPSource/lc3
 
 
Controller (btmgmt info)
------------------------
hci0  Primary controller  addr XX:XX:XX:XX:XX:XX  version 13  manufacturer 2 (Intel)
  supported settings: ... le secure-conn wide-band-speech cis-central cis-peripheral
                      ll-privacy past-sender past-receiver ...
  current settings:   powered bondable ssp br/edr le secure-conn wide-band-speech
                      cis-central cis-peripheral ll-privacy past-sender past-receiver
 
Note: cis-central is present in BOTH supported and current settings. This is an
Intel BE200. LE Audio streaming works fine on this controller with other LE-Audio
sinks (Galaxy Buds3 Pro), so CIS-Central itself is functional.
 
 
Peripheral
----------
Sony INZONE Buds - LE Audio only, advertises "BR/EDR Not Supported".
  Modalias:   usb:v054Cp0EC1d0206  (VID 0x054C Sony, PID 0x0EC1)
  Appearance: 0x0941 (Earbud)
  CSIP coordinated set (RSI in advertising; CSIS with Set Size / Rank / Lock / SIRK),
  2 members: BUD_1 and BUD_2 (both Static Random).
 
 
Steps to reproduce
-------------------
1. Factory-reset the buds, both out of the case (full CSIP set advertising).
2. bluetoothctl -> scan on -> pair BUD_1.
3. Bond succeeds, then the peripheral disconnects immediately.
 
 
Expected
--------
After bonding + GATT discovery, BlueZ configures an ASE, sets up CIG/CIS, a
PipeWire BAP sink appears, and the link stays up.
 
 
Actual
------
The peripheral terminates the link ~1.1 s after connection-complete with reason
0x13 (Remote User Terminated) - a deliberate disconnect by the device, not a
supervision timeout (0x08). No LE Set CIG Parameters (0x08|0x0062) and no
LE Create CIS (0x08|0x0064) is ever issued.
 
 
Key observation - failing vs. succeeding path
---------------------------------------------
On a minority of attempts the link STAYS UP: ServicesResolved=yes, full LE Audio
GATT resolved (ASCS with 2x Sink ASE + 1x Source ASE, PACS, VCS, CSIS, BASS,
TMAS). The only difference is the connect path: `connect` issued while discovery
is active (bluetoothctl "Scan and connect: yes"), with both set members
advertising, vs. a plain pair/connect after bonding. Same machine, same buds,
same software - only the connect timing differs. This suggests a
connect/idle-handling timing issue rather than a missing capability.
 
 
Ruled out
---------
- Controller / CIS-Central:  BE200, cis-central active (see btmgmt info); works with other LE-Audio sinks.
- Cross-OS:                  same laptop/controller/buds work out of the box on Windows 11.
- LC3 / BAP:                 liblc3 present; BAPSink/lc3 + BAPSource/lc3 registered.
- Experimental:              enabled (BAP endpoints prove it).
- Pairing / security:        SMP completes, encryption AES-CCM, LTK + IRK stored.
- CSIP services:             present and discovered.
- Codec negotiation:         never reached; device drops before any ASE config.
- Reproduced on BlueZ stable and bluez-git, across full reboots.
 
 
Log A - failing attempt, btmon (shortened)
------------------------------------------
> LE Enhanced Connection Complete (Status: Success)
      Role: Central
      Peer: BUD_1 (Static Random)
      Connection interval: 45.00 msec   Supervision timeout: 420 msec
> LE Read Remote Used Features
      Connected Isochronous Stream - Central
      Connected Isochronous Stream - Peripheral
      Connected Isochronous Stream (Host Support)
< SMP: Pairing Request  (SC, Bonding)
> SMP: Pairing Response (NoInputNoOutput, SC, Bonding)
  ... ECDH keys / confirm / random / DHKey check ...
> Encryption Change: Enabled with AES-CCM
@ New Long Term Key (stored) ; New IRK (stored) ; Pair Device: Success
  ... ATT GATT discovery: GAP, GATT, DIS, CSIS(0x1846), CAS(0x1853),
      TMAS(0x1855), BASS(0x184f), ASCS(0x184e), PACS(0x1850), VCS(0x1844) ...
> HCI Event: Disconnect Complete
      Reason: Remote User Terminated Connection (0x13)   # ~1.1 s after connect
 
No LE Set CIG Parameters and no LE Create CIS appear anywhere in the capture.
 
 
Log B - succeeding attempt, bluetoothctl (link stays up)
--------------------------------------------------------
[BUD_1] Scan and connect (yes,no): yes
[CHG] Device BUD_1 Connected: yes
  ... full GATT tree resolves ...
[CHG] Device BUD_1 ServicesResolved: yes
[CHG] Device BUD_1 Modalias: usb:v054Cp0EC1d0206
  # ASCS: 2x Sink ASE (0x2bc4), 1x Source ASE (0x2bc5), ASE Control Point (0x2bc6)
  # PACS, VCS, CSIS (SIRK/Size/Lock/Rank), BASS, TMAS all present; link does not drop.
 
 
Related
-------
- Arch forum, same device, unresolved: https://bbs.archlinux.org/viewtopic.php?id=302495
- Setup followed per PipeWire LE Audio + LC3 wiki:
  https://gitlab.freedesktop.org/pipewire/pipewire/-/wikis/LE-Audio-+-LC3-support
 
 
I can provide full btmon captures of both the failing runs on
request. Happy to test patches.
 
Thanks,
Adrian
