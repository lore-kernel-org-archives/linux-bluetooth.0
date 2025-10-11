Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0187F22FDE8
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Oct 2025 13:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760190238; cv=pass; b=KxD/f22UWfHJefIhIr2MUCIRxm6iAF/JC6h0Sn86QLOa3XoxPNbgmevzpYvp+xeWx0y4tWOK2OF8HhPrXZthzvtRs0usJd71tw+g7OtlRvqztaCroRF1Y/NtiVzR0Fh/p+mVc6Sb3lVTWEZx7Y2daipJvrYobp5jnhwuuCeRFFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760190238; c=relaxed/simple;
	bh=dHMW5OE9fE1RpxSaonhF21MvU8secmFvusrO1PpFBrw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dCY+Ehh0Q9JZxr4wq6FUgVhGUCPEYpT1kxrwVHYetMGcD4mB3nzI1+0wrNSWyimDlYSUFu9FKOitQF0QeNCIq60kSawZIUzdGUh5X8AsClueoApEfhSC4APGpE5U5hRVmnwtxNY5TZvC54ecIol9ewMVh0/oZJF6qVIUnHosQ70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=hRQTLAoN; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="hRQTLAoN"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ckPvv2c1Rz49Pv6
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Oct 2025 16:43:39 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1760190219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6x7IqVhWJYMxua6W+CFRWEAId5krWQ4VDKNfgy8pMGQ=;
	b=hRQTLAoN5Z1BAWxCQmd7gQe5IPUG+jwZd5wdrvGcZw9C6dqF6HAUFfn9H+xOySlqXBVI4R
	O+j5cA4ZbFbsd1qHaFLmOdiAsOuH6tATAQTVNiLuSWTeole+13flKJxoNnP/0kYHt+2pzE
	qJhvE09++2j8tMZGbH1w2eK7VMKTw1ataUCW+r6u6qBovqrueP86FnORB5gtRbfSM47VYb
	rcKLx+WGdaP/DRlgnbEVUsWUYI36+Wrm5kg4HnCcEzwA4zKFV6S11PgBJyxwm07UBH5koj
	o1IKQ/TsjYRjTH+Gepq4EuWATvJ09ZhJktkVHuSmEeZvIi0EI2bYHcJRatfj7Q==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1760190219; a=rsa-sha256;
	cv=none;
	b=FmDLdH1E/xh7V44yR9F6Z3l5vNhimhfXUkQeZRmqovr3yl4Ay5drc+CNG3d1Fjt7YoMQa3
	4Yf8ibS6EOQRSSQZ4aqUMyNqCCWzbLnMxLlmADXqpG0TX1IdoFCOnmi4HrfZmpUeWG17V8
	ZUXI0GpH2NSDZO0haTPqBwK4MMPhlJ8W2TS3Qyf0oG9XhGT7Lq0WAdC5MWUbf5Xb4hLTw7
	iKrc0Ro/t+3iQCQWaPLu4PxWbD6JbED0oP0sS2ct+BmpDXCbEF0E2Ia6a840e5bbX/JbO/
	BP8l1uP75LRWVXTyDHhgemLiYJ1MMs5TT4OTRubxAxlciXc+EcMIAVncH0eBHg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1760190219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6x7IqVhWJYMxua6W+CFRWEAId5krWQ4VDKNfgy8pMGQ=;
	b=L2QoyF3amOhx96UPOWqQff19mdT5jVnY4Ce46/ct+ylrjz8pqu6tiJBIQQNO5nsXAj3x4h
	e17rWkLDADAFHQo6CLKKhnRSKeH2TAluGwJr2Ng3Vic7TV8cJ+lLufrP58hYZEWG7S+QRU
	FzmnvHEDuXl+0n2xQggymo8zq/YfH/E9Ty1m+HW/E5jsWP6EKn1XPJ+wFLYpbZvbChtMfy
	oVLJAnZYmEQVjHq3qZRFAbSeFHzvwCTJTTABAyQBof1AYWa/kI1p6r5vmiqVUau7t0trmF
	m/rsKD2hVCPTdaM89/j3jodNLVWls+v98WvQIsRgT1obWTuJSksu0o0P19peUg==
Message-ID: <f751f95098330bc7c3650c8ab7be007fb43117aa.camel@iki.fi>
Subject: Re: Intel AX210 thinks Disconnected CIS still exists?
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Sat, 11 Oct 2025 16:43:37 +0300
In-Reply-To: <d501819fc5b854c9dce8e5f28b629787aa65a607.camel@iki.fi>
References: <d501819fc5b854c9dce8e5f28b629787aa65a607.camel@iki.fi>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

This behavior, appearing to be Core spec violation, still exists with
Intel AX210 firmware

Bluetooth: hci1: Firmware timestamp 2025.20 buildtype 1 build 82053
Bluetooth: hci1: Firmware SHA1: 0x937bca4a
Bluetooth: hci1: No support for _PRR ACPI method
Bluetooth: hci1: Found device firmware: intel/ibt-0041-0041.sfi
Bluetooth: hci1: Boot Address: 0x100800
Bluetooth: hci1: Firmware Version: 133-20.25
Bluetooth: hci1: Firmware already loaded
Bluetooth: hci1: Fseq status: Success (0x00)
Bluetooth: hci1: Fseq executed: 00.00.02.41
Bluetooth: hci1: Fseq BT Top: 00.00.02.41

(The kernel behavior is not fully right as it configures the data path
after having sent Disconnect command but before Disconnect complete,
but AFAIK that is still within spec.)


pe, 2025-06-20 kello 11:44 +0300, Pauli Virtanen kirjoitti:
> Hi,
>=20
> I'm seeing some weird behavior with Intel AX210. It's looking somewhat
> like a firmware bug.
>=20
> The controller seems to be producing empty ACL data packets for a CIS
> handle even though it already sent "Disconnect Complete" event for the
> handle.
>=20
>=20
> Reproducer:
> AX210 + Samsung Galaxy Buds2 Pro + BlueZ & Pipewire master branch
> Switch audio profile to duplex for both earbuds using pactl, try to
> play audio. The device rejects ASE configuration for one earbud, and
> BlueZ starts cancelling its CIS connect.
>=20
>=20
> Firmware:
>=20
> [   27.539905] Bluetooth: hci0: Firmware timestamp 2025.13 buildtype 1 bu=
ild 82008
> [   27.539909] Bluetooth: hci0: Firmware SHA1: 0x47cf9d0e
> [   27.539914] Bluetooth: hci0: No support for _PRR ACPI method
> [   27.552267] Bluetooth: hci0: Found device firmware: intel/ibt-0041-004=
1.sfi
> [   27.552292] Bluetooth: hci0: Boot Address: 0x100800
> [   27.552294] Bluetooth: hci0: Firmware Version: 88-13.25
> [   27.552296] Bluetooth: hci0: Firmware already loaded
> [   27.563226] Bluetooth: hci0: Fseq status: Success (0x00)
> [   27.563231] Bluetooth: hci0: Fseq executed: 00.00.02.41
> [   27.563234] Bluetooth: hci0: Fseq BT Top: 00.00.02.41
>=20
>=20
> HCI Command / Status / Complete log & some of ISO/ACL packets:
>=20
> < HCI Command: LE Create Connected Isochronous Stream (0x08|0x0064) plen =
9   #8711 [hci1] 278.356781
>         Number of CIS: 2
>         CIS Handle: 2304
>         ACL Handle: 2049
>         CIS Handle: 2305
>         ACL Handle: 2048
>=20
> **CIG with two bidirectional CIS**
>=20
> > HCI Event: Command Status (0x0f) plen 4   #8712 [hci1] 278.358100
>       LE Create Connected Isochronous Stream (0x08|0x0064) ncmd 1
>         Status: Success (0x00)
> < HCI Command: Disconnect (0x01|0x0006) plen 3   #8720 [hci1] 278.498169
>         Handle: 2305
>         Reason: Remote User Terminated Connection (0x13)
>=20
>=20
> **Core specification 6.0 pp 1920: "If the Host issues
> this command when there is a pending HCI_LE_Create_CIS command for the
> same CIS but before the CIS is created, then this command shall be
> successful and the CIS shall not be created."**
>=20
>=20
> > HCI Event: Command Status (0x0f) plen 4   #8721 [hci1] 278.499113
>       Disconnect (0x01|0x0006) ncmd 1
>         Status: Success (0x00)
> > HCI Event: LE Meta Event (0x3e) plen 29   #8722 [hci1] 278.589170
>       LE Connected Isochronous Stream Established (0x19)
>         Status: Success (0x00)
>         Connection Handle: 2305
>         CIG Synchronization Delay: 5400 us (0x001518)
>         CIS Synchronization Delay: 4470 us (0x001176)
>         Central to Peripheral Latency: 5400 us (0x001518)
>         Peripheral to Central Latency: 5400 us (0x001518)
>         Central to Peripheral PHY: LE 2M (0x02)
>         Peripheral to Central PHY: LE 2M (0x02)
>         Number of Subevents: 3
>         Central to Peripheral Burst Number: 1
>         Peripheral to Central Burst Number: 1
>         Central to Peripheral Flush Timeout: 1
>         Peripheral to Central Flush Timeout: 1
>         Central to Peripheral MTU: 60
>         Peripheral to Central MTU: 60
>         ISO Interval: 7.50 msec (0x0006)
> < HCI Command: LE Setup Isochronous Data Path (0x08|0x006e) plen 13   #87=
23 [hci1] 278.589365
>         Handle: 2305
>         Data Path Direction: Input (Host to Controller) (0x00)
>         Data Path: HCI (0x00)
>         Coding Format: Transparent (0x03)
>         Company Codec ID: Ericsson Technology Licensing (0)
>         Vendor Codec ID: 0
>         Controller Delay: 0 us (0x000000)
>         Codec Configuration Length: 0
>         Codec Configuration[0]:=20
> > HCI Event: Command Complete (0x0e) plen 6   #8724 [hci1] 278.590113
>       LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
>         Status: Success (0x00)
>         Handle: 2305
> > HCI Event: LE Meta Event (0x3e) plen 29   #8725 [hci1] 278.599121
>       LE Connected Isochronous Stream Established (0x19)
>         Status: Success (0x00)
>         Connection Handle: 2304
>         CIG Synchronization Delay: 5400 us (0x001518)
>         CIS Synchronization Delay: 5400 us (0x001518)
>         Central to Peripheral Latency: 5400 us (0x001518)
>         Peripheral to Central Latency: 5400 us (0x001518)
>         Central to Peripheral PHY: LE 2M (0x02)
>         Peripheral to Central PHY: LE 2M (0x02)
>         Number of Subevents: 3
>         Central to Peripheral Burst Number: 1
>         Peripheral to Central Burst Number: 1
>         Central to Peripheral Flush Timeout: 1
>         Peripheral to Central Flush Timeout: 1
>         Central to Peripheral MTU: 60
>         Peripheral to Central MTU: 60
>         ISO Interval: 7.50 msec (0x0006)
> > ISO Data RX: Handle 2304 flags 0x02 dlen 4   #8726 [hci1] 278.599829
> > ISO Data RX: Handle 2304 flags 0x02 dlen 4   #8727 [hci1] 278.607554
> > ISO Data RX: Handle 2304 flags 0x02 dlen 4   #8728 [hci1] 278.614858
> < HCI Command: LE Setup Isochronous Data Path (0x08|0x006e) plen 13   #87=
29 [hci1] 278.615107
>         Handle: 2305
>         Data Path Direction: Output (Controller to Host) (0x01)
>         Data Path: HCI (0x00)
>         Coding Format: Transparent (0x03)
>         Company Codec ID: Ericsson Technology Licensing (0)
>         Vendor Codec ID: 0
>         Controller Delay: 0 us (0x000000)
>         Codec Configuration Length: 0
>         Codec Configuration[0]:=20
> > HCI Event: Command Complete (0x0e) plen 6   #8730 [hci1] 278.616102
>       LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
>         Status: Success (0x00)
>         Handle: 2305
> < HCI Command: LE Setup Isochronous Data Path (0x08|0x006e) plen 13   #87=
31 [hci1] 278.616126
>         Handle: 2304
>         Data Path Direction: Input (Host to Controller) (0x00)
>         Data Path: HCI (0x00)
>         Coding Format: Transparent (0x03)
>         Company Codec ID: Ericsson Technology Licensing (0)
>         Vendor Codec ID: 0
>         Controller Delay: 0 us (0x000000)
>         Codec Configuration Length: 0
>         Codec Configuration[0]:=20
> > HCI Event: Disconnect Complete (0x05) plen 4   #8732 [hci1] 278.617112
>         Status: Success (0x00)
>         Handle: 2305 Address: 28:3D:C2:4A:7E:DA (Samsung Electronics Co.,=
Ltd)
>         Reason: Connection Terminated By Local Host (0x16)
>=20
> **Handle 2305 gets disconnected here**
>=20
> > HCI Event: Command Complete (0x0e) plen 6   #8733 [hci1] 278.618113
>       LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
>         Status: Success (0x00)
>         Handle: 2304
> < HCI Command: LE Setup Isochronous Data Path (0x08|0x006e) plen 13   #87=
34 [hci1] 278.618160
>         Handle: 2304
>         Data Path Direction: Output (Controller to Host) (0x01)
>         Data Path: HCI (0x00)
>         Coding Format: Transparent (0x03)
>         Company Codec ID: Ericsson Technology Licensing (0)
>         Vendor Codec ID: 0
>         Controller Delay: 0 us (0x000000)
>         Codec Configuration Length: 0
>         Codec Configuration[0]:=20
> > HCI Event: Command Complete (0x0e) plen 6   #8735 [hci1] 278.619110
>       LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
>         Status: Success (0x00)
>         Handle: 2304
> > ISO Data RX: Handle 2304 flags 0x02 dlen 4   #8739 [hci1] 278.629825
> > ACL Data RX: Handle 2305 flags 0x02 dlen 4   #8740 [hci1] 278.632832
>         unexpected start frame
>         05 00 00 80                                      ....
>=20
> **Getting data packets for already disconnected handle?**
>=20
> > ISO Data RX: Handle 2304 flags 0x02 dlen 4   #8741 [hci1] 278.636842
> > ACL Data RX: Handle 2305 flags 0x02 dlen 4   #8742 [hci1] 278.639839
> > ISO Data RX: Handle 2304 flags 0x02 dlen 4   #8743 [hci1] 278.644857
> > ACL Data RX: Handle 2305 flags 0x02 dlen 4   #8744 [hci1] 278.646832
>         unexpected start frame
>         07 00 00 80                                      ....           =
=20
> ...
> < HCI Command: Disconnect (0x01|0x0006) plen 3   #13597 [hci1] 288.315392
>         Handle: 2304 Address: 28:3D:C2:4A:7D:2A (Samsung Electronics Co.,=
Ltd)
>         Reason: Remote User Terminated Connection (0x13)
>=20
> **Handle 2304 disconnects here**
>=20
> > HCI Event: Command Status (0x0f) plen 4   #13598 [hci1] 288.316110
>       Disconnect (0x01|0x0006) ncmd 1
>         Status: Success (0x00)
> > HCI Event: Disconnect Complete (0x05) plen 4   #13599 [hci1] 288.344136
>         Status: Success (0x00)
>         Handle: 2304 Address: 28:3D:C2:4A:7D:2A (Samsung Electronics Co.,=
Ltd)
>         Reason: Connection Terminated By Local Host (0x16)
> < HCI Command: LE Remove Connected Isochronous Group (0x08|0x0065) plen 1=
   #13601 [hci1] 288.360011
>         CIG ID: 0x00
> > HCI Event: Command Complete (0x0e) plen 5   #13602 [hci1] 288.361116
>       LE Remove Connected Isochronous Group (0x08|0x0065) ncmd 1
>         Status: Command Disallowed (0x0c)
>         CIG ID: 0x00
>=20
> Disconnect Complete has already been received for both CIS.=C2=A0
> This command probably should have succeeded?
