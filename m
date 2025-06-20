Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4543A25522D
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 08:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750409074; cv=pass; b=tK0nlTGeXIKZYTtFB28rnRjBmrpdYOuJP7EsQVC5Pk6zvJZ56YD1GqW14UU9qtGSgTZsRu/xuihiwzM0Yv/c9OibqcUyaB0/ChKsN3pKJJ0NH0tv7zA0ZSNPMAMf9LjjBrzBG5SGlqSUKxrCJV7ldj8aIvIIPgg/lLCdyjfFpXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750409074; c=relaxed/simple;
	bh=DS+Mt4G8rn7oHEIw30lAHwFrkslaxJR5atFp9nrSOvA=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=PkQAT7gaXnCOV9nfLcvMaQzwaswgfnozHKt4+wU53E+7ZuacNseIdWEWNAa2OvP6z26JvONWAEJyDn+cU1NwysOeKmxJrQOYFGQ+NP+X607LiQL+IwoQUe4zMqU77RMucHRb8ppwUKKvAdYREvI8LGu7PeUuwoed0hiAtt7FHks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=GIsjQkRm; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="GIsjQkRm"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bNrcm6t85z49Q36
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 11:44:24 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1750409065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tBfBCDgv/rZUFCgb3k+eYcv8brwDlKusoF44TA8YOC4=;
	b=GIsjQkRm0GIgFTkPZq0f9Xi56x4rJ4BgPsnVT/n5baTBuobW1Mc+cNhEoSqWVLxvg3XFVK
	28QdRJaVvb79KYr0UlBvFkYMqHUfWKlpL73uYk2zvBw5HWe8OwezapdhflKVUN1BHpfWmX
	et0Y15MdB3bRwS5ihdF9f93YYfRbKl79mI7uTP0jnxhXVDBejYWLjhvZpmVm+XvPfqmzhp
	ScH38+jumpxYUgb0CtnDKAczJoCucVh2eO97SU1EJmdOhxWqpx3+PC06HCcpzbhRH4E297
	I7NPcMGGc1xs7PWL7HoC39m4mv0/lnrrgcEVTH2h+HJV90ybXHjqW1VKaRrv2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1750409065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tBfBCDgv/rZUFCgb3k+eYcv8brwDlKusoF44TA8YOC4=;
	b=FWsnNoiMQpPcDdCqDO0POoWW8hU4+3S+0t/4A6qs5CDtaMbHv09OUChqDYZ2+BDwmhnhOT
	BOzcE+WHvb/ktTlWC1z9ytF4cS0Bl0WIkGpufDL4x2H5acsrycoF5G1nsMgNS2e7aoab74
	b2/6RhlHTR2O0dTsG94lT5zsWhHq1hDPec4c6/LTNKRIPdAhNnpBEYPDSw/Y+vnEngxa5f
	WefLYkoYhG9OradabavjDQY8x2nPRxgeStJQfHW2DOPpRJWAkXO2SGMKrcKJMtrDKgcpeN
	PzrIuxkvg8zYiH3DyREHD4P2KiWJA246PhiHXppyY0NBqZm/pbyD4X72RCkBYA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1750409065; a=rsa-sha256;
	cv=none;
	b=Ctffd6L+VXsrkAMxm6flXgafns1mcIrM+T3ZamcYDmRbOxUmwTp9MMQ9EJ8J7FpbS7KkE8
	CAt2h99Ca02RgkZhSOQ2UzRKIaGyzmirX8p9yoeqc8kX0wpYVQblobV5ICZ5H69lgmzqiM
	UzEaRDdbvqHdv6AoOUF4m/WXVEqVNM54yVYdO5RDx5SsAbbmpwZRkqqgvlWDiyHmnhQl8V
	HAzKLiGDvKdFRZgW48A+DnfXS2g1KHdnRcjVWxXHLKDReKso79uirgwMhZxjrra/oyzCun
	U6I7OnYDCZD5pmM/1Fq/yFcgENmIA5P0sU+PNVL8hxQabUTRyevCXFsT0UwoqQ==
Message-ID: <d501819fc5b854c9dce8e5f28b629787aa65a607.camel@iki.fi>
Subject: Intel AX210 thinks Disconnected CIS still exists?
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Fri, 20 Jun 2025 11:44:22 +0300
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

I'm seeing some weird behavior with Intel AX210. It's looking somewhat
like a firmware bug.

The controller seems to be producing empty ACL data packets for a CIS
handle even though it already sent "Disconnect Complete" event for the
handle.


Reproducer:
AX210 + Samsung Galaxy Buds2 Pro + BlueZ & Pipewire master branch
Switch audio profile to duplex for both earbuds using pactl, try to
play audio. The device rejects ASE configuration for one earbud, and
BlueZ starts cancelling its CIS connect.


Firmware:

[   27.539905] Bluetooth: hci0: Firmware timestamp 2025.13 buildtype 1 buil=
d 82008
[   27.539909] Bluetooth: hci0: Firmware SHA1: 0x47cf9d0e
[   27.539914] Bluetooth: hci0: No support for _PRR ACPI method
[   27.552267] Bluetooth: hci0: Found device firmware: intel/ibt-0041-0041.=
sfi
[   27.552292] Bluetooth: hci0: Boot Address: 0x100800
[   27.552294] Bluetooth: hci0: Firmware Version: 88-13.25
[   27.552296] Bluetooth: hci0: Firmware already loaded
[   27.563226] Bluetooth: hci0: Fseq status: Success (0x00)
[   27.563231] Bluetooth: hci0: Fseq executed: 00.00.02.41
[   27.563234] Bluetooth: hci0: Fseq BT Top: 00.00.02.41


HCI Command / Status / Complete log & some of ISO/ACL packets:

< HCI Command: LE Create Connected Isochronous Stream (0x08|0x0064) plen 9 =
  #8711 [hci1] 278.356781
        Number of CIS: 2
        CIS Handle: 2304
        ACL Handle: 2049
        CIS Handle: 2305
        ACL Handle: 2048

**CIG with two bidirectional CIS**

> HCI Event: Command Status (0x0f) plen 4   #8712 [hci1] 278.358100
      LE Create Connected Isochronous Stream (0x08|0x0064) ncmd 1
        Status: Success (0x00)
< HCI Command: Disconnect (0x01|0x0006) plen 3   #8720 [hci1] 278.498169
        Handle: 2305
        Reason: Remote User Terminated Connection (0x13)


**Core specification 6.0 pp 1920: "If the Host issues
this command when there is a pending HCI_LE_Create_CIS command for the
same CIS but before the CIS is created, then this command shall be
successful and the CIS shall not be created."**


> HCI Event: Command Status (0x0f) plen 4   #8721 [hci1] 278.499113
      Disconnect (0x01|0x0006) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 29   #8722 [hci1] 278.589170
      LE Connected Isochronous Stream Established (0x19)
        Status: Success (0x00)
        Connection Handle: 2305
        CIG Synchronization Delay: 5400 us (0x001518)
        CIS Synchronization Delay: 4470 us (0x001176)
        Central to Peripheral Latency: 5400 us (0x001518)
        Peripheral to Central Latency: 5400 us (0x001518)
        Central to Peripheral PHY: LE 2M (0x02)
        Peripheral to Central PHY: LE 2M (0x02)
        Number of Subevents: 3
        Central to Peripheral Burst Number: 1
        Peripheral to Central Burst Number: 1
        Central to Peripheral Flush Timeout: 1
        Peripheral to Central Flush Timeout: 1
        Central to Peripheral MTU: 60
        Peripheral to Central MTU: 60
        ISO Interval: 7.50 msec (0x0006)
< HCI Command: LE Setup Isochronous Data Path (0x08|0x006e) plen 13   #8723=
 [hci1] 278.589365
        Handle: 2305
        Data Path Direction: Input (Host to Controller) (0x00)
        Data Path: HCI (0x00)
        Coding Format: Transparent (0x03)
        Company Codec ID: Ericsson Technology Licensing (0)
        Vendor Codec ID: 0
        Controller Delay: 0 us (0x000000)
        Codec Configuration Length: 0
        Codec Configuration[0]:=20
> HCI Event: Command Complete (0x0e) plen 6   #8724 [hci1] 278.590113
      LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
        Status: Success (0x00)
        Handle: 2305
> HCI Event: LE Meta Event (0x3e) plen 29   #8725 [hci1] 278.599121
      LE Connected Isochronous Stream Established (0x19)
        Status: Success (0x00)
        Connection Handle: 2304
        CIG Synchronization Delay: 5400 us (0x001518)
        CIS Synchronization Delay: 5400 us (0x001518)
        Central to Peripheral Latency: 5400 us (0x001518)
        Peripheral to Central Latency: 5400 us (0x001518)
        Central to Peripheral PHY: LE 2M (0x02)
        Peripheral to Central PHY: LE 2M (0x02)
        Number of Subevents: 3
        Central to Peripheral Burst Number: 1
        Peripheral to Central Burst Number: 1
        Central to Peripheral Flush Timeout: 1
        Peripheral to Central Flush Timeout: 1
        Central to Peripheral MTU: 60
        Peripheral to Central MTU: 60
        ISO Interval: 7.50 msec (0x0006)
> ISO Data RX: Handle 2304 flags 0x02 dlen 4   #8726 [hci1] 278.599829
> ISO Data RX: Handle 2304 flags 0x02 dlen 4   #8727 [hci1] 278.607554
> ISO Data RX: Handle 2304 flags 0x02 dlen 4   #8728 [hci1] 278.614858
< HCI Command: LE Setup Isochronous Data Path (0x08|0x006e) plen 13   #8729=
 [hci1] 278.615107
        Handle: 2305
        Data Path Direction: Output (Controller to Host) (0x01)
        Data Path: HCI (0x00)
        Coding Format: Transparent (0x03)
        Company Codec ID: Ericsson Technology Licensing (0)
        Vendor Codec ID: 0
        Controller Delay: 0 us (0x000000)
        Codec Configuration Length: 0
        Codec Configuration[0]:=20
> HCI Event: Command Complete (0x0e) plen 6   #8730 [hci1] 278.616102
      LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
        Status: Success (0x00)
        Handle: 2305
< HCI Command: LE Setup Isochronous Data Path (0x08|0x006e) plen 13   #8731=
 [hci1] 278.616126
        Handle: 2304
        Data Path Direction: Input (Host to Controller) (0x00)
        Data Path: HCI (0x00)
        Coding Format: Transparent (0x03)
        Company Codec ID: Ericsson Technology Licensing (0)
        Vendor Codec ID: 0
        Controller Delay: 0 us (0x000000)
        Codec Configuration Length: 0
        Codec Configuration[0]:=20
> HCI Event: Disconnect Complete (0x05) plen 4   #8732 [hci1] 278.617112
        Status: Success (0x00)
        Handle: 2305 Address: 28:3D:C2:4A:7E:DA (Samsung Electronics Co.,Lt=
d)
        Reason: Connection Terminated By Local Host (0x16)

**Handle 2305 gets disconnected here**

> HCI Event: Command Complete (0x0e) plen 6   #8733 [hci1] 278.618113
      LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
        Status: Success (0x00)
        Handle: 2304
< HCI Command: LE Setup Isochronous Data Path (0x08|0x006e) plen 13   #8734=
 [hci1] 278.618160
        Handle: 2304
        Data Path Direction: Output (Controller to Host) (0x01)
        Data Path: HCI (0x00)
        Coding Format: Transparent (0x03)
        Company Codec ID: Ericsson Technology Licensing (0)
        Vendor Codec ID: 0
        Controller Delay: 0 us (0x000000)
        Codec Configuration Length: 0
        Codec Configuration[0]:=20
> HCI Event: Command Complete (0x0e) plen 6   #8735 [hci1] 278.619110
      LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
        Status: Success (0x00)
        Handle: 2304
> ISO Data RX: Handle 2304 flags 0x02 dlen 4   #8739 [hci1] 278.629825
> ACL Data RX: Handle 2305 flags 0x02 dlen 4   #8740 [hci1] 278.632832
        unexpected start frame
        05 00 00 80                                      ....

**Getting data packets for already disconnected handle?**

> ISO Data RX: Handle 2304 flags 0x02 dlen 4   #8741 [hci1] 278.636842
> ACL Data RX: Handle 2305 flags 0x02 dlen 4   #8742 [hci1] 278.639839
> ISO Data RX: Handle 2304 flags 0x02 dlen 4   #8743 [hci1] 278.644857
> ACL Data RX: Handle 2305 flags 0x02 dlen 4   #8744 [hci1] 278.646832
        unexpected start frame
        07 00 00 80                                      ....           =
=20
...
< HCI Command: Disconnect (0x01|0x0006) plen 3   #13597 [hci1] 288.315392
        Handle: 2304 Address: 28:3D:C2:4A:7D:2A (Samsung Electronics Co.,Lt=
d)
        Reason: Remote User Terminated Connection (0x13)

**Handle 2304 disconnects here**

> HCI Event: Command Status (0x0f) plen 4   #13598 [hci1] 288.316110
      Disconnect (0x01|0x0006) ncmd 1
        Status: Success (0x00)
> HCI Event: Disconnect Complete (0x05) plen 4   #13599 [hci1] 288.344136
        Status: Success (0x00)
        Handle: 2304 Address: 28:3D:C2:4A:7D:2A (Samsung Electronics Co.,Lt=
d)
        Reason: Connection Terminated By Local Host (0x16)
< HCI Command: LE Remove Connected Isochronous Group (0x08|0x0065) plen 1  =
 #13601 [hci1] 288.360011
        CIG ID: 0x00
> HCI Event: Command Complete (0x0e) plen 5   #13602 [hci1] 288.361116
      LE Remove Connected Isochronous Group (0x08|0x0065) ncmd 1
        Status: Command Disallowed (0x0c)
        CIG ID: 0x00

Disconnect Complete has already been received for both CIS.=C2=A0
This command probably should have succeeded?

--=20
Pauli Virtanen
