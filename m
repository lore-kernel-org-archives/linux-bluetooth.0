Received: from server.interlinx.bc.ca (mail.interlinx.bc.ca [69.165.217.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842591DFEA
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.165.217.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707918058; cv=none; b=RkQWg6ZLgb4DRLj4NE26rDw/nSQXJ6hYO6jA300SRs49yll82AR6AHGUazsXK9vsgJwmWp88Kdunx6q9pvtvqwBC/i41RrhxYqh4qXTTLWeo8f4O0iGFZqdt1xOFX6F7zwU+xT/Fsu19Ri5KwNVr0co2EQxsYh7cGfVCIsOoNJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707918058; c=relaxed/simple;
	bh=crVP+EtxjqJ8l0DgiinyyUBWJaUAIMtiVnGdBp1JDSk=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=teOMX2mkmGN4+HOOdwpavTgflXBWoXGbvwyJilXGC4ovA4339d1Oq4NcbduSokfQ1WcbJrE/9+iQZYRCVb449UPq7WJaQo/QLypfKtdOsmI2zzC3QlLpvVv5Ri71ODPlujfMZ6+tCukW7/OO6z+maSFvBV4WoVRW+IMtvmIfQoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=interlinx.bc.ca; spf=fail smtp.mailfrom=interlinx.bc.ca; arc=none smtp.client-ip=69.165.217.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=interlinx.bc.ca
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=interlinx.bc.ca
Received: from pc.interlinx.bc.ca (pc.interlinx.bc.ca [IPv6:fd31:aeb1:48df:0:3b14:e643:83d8:7017])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by server.interlinx.bc.ca (Postfix) with ESMTPSA id 767F42ABC4
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 08:34:53 -0500 (EST)
Message-ID: <8b071973dfd2da7d8faf5d5720637662616e01cb.camel@interlinx.bc.ca>
Subject: BLE devices not (automatically, or otherwise) connecting: Failed to
 connect: org.bluez.Error.Failed Operation already in progress
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
To: linux-bluetooth@vger.kernel.org
Date: Wed, 14 Feb 2024 08:34:53 -0500
Autocrypt: addr=brian@interlinx.bc.ca; prefer-encrypt=mutual;
 keydata=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
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-0kICFoJqKGPaaV/rRNFl"
User-Agent: Evolution 3.50.4 (3.50.4-1.2.fc39) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-0kICFoJqKGPaaV/rRNFl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have an Ember Mug which is a BLE device.  I was able to pair it to my
Fedora 39 system running bluez-5.72 with a:

Bus 003 Device 029: ID 0bda:8771 Realtek Semiconductor Corp. [unknown]

BT dongle.  But now it seems unable to reconnect, automatically[1], or
otherwise (I have no idea why bluetoothctl's prompt is "Bluetooth Mouse
M557]" but it is):

$ bluetoothctl
=E2=80=A6
[Bluetooth Mouse M557]# list
Controller 8C:88:2B:45:A0:8A pc.interlinx.bc.ca [default]
[Bluetooth Mouse M557]# show 8C:88:2B:45:A0:8A
Controller 8C:88:2B:45:A0:8A (public)
	Manufacturer: 0x005d (93)
	Version: 0x0a (10)
	Name: pc.interlinx.bc.ca
	Alias: pc.interlinx.bc.ca
	Class: 0x006c0104 (7078148)
	Powered: yes
	PowerState: on
	Discoverable: no
	DiscoverableTimeout: 0x000000b4 (180)
	Pairable: yes
	UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
	UUID: Handsfree Audio Gateway   (0000111f-0000-1000-8000-00805f9b34fb)
	UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
	UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b34fb)
	UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)
	UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
	UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
	UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
	UUID: Device Information        (0000180a-0000-1000-8000-00805f9b34fb)
	UUID: Handsfree                 (0000111e-0000-1000-8000-00805f9b34fb)
	Modalias: usb:v1D6Bp0246d0548
	Discovering: yes
	Roles: central
	Roles: peripheral
Advertising Features:
	ActiveInstances: 0x00 (0)
	SupportedInstances: 0x04 (4)
	SupportedIncludes: tx-power
	SupportedIncludes: appearance
	SupportedIncludes: local-name
	SupportedSecondaryChannels: 1M
	SupportedSecondaryChannels: 2M
	SupportedSecondaryChannels: Coded
[Bluetooth Mouse M557]# devices
Device EC:4E:82:E4:98:14 Ember Ceramic Mug
[Bluetooth Mouse M557]# info EC:4E:82:E4:98:14
Device EC:4E:82:E4:98:14 (random)
	Name: Ember Ceramic Mug
	Alias: Ember Ceramic Mug
	Paired: yes
	Bonded: yes
	Trusted: no
	Blocked: no
	Connected: no
	LegacyPairing: no
	UUID: Vendor specific           (00001530-1212-efde-1523-785feabcd123)
	UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
	UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
	UUID: Device Information        (0000180a-0000-1000-8000-00805f9b34fb)
	UUID: Vendor specific           (fc543622-236c-4c94-8fa9-944a3e5353fa)
	ManufacturerData.Key: 0x03c1 (961)
	ManufacturerData.Value:
  81                                               .              =20
[Bluetooth Mouse M557]# connect EC:4E:82:E4:98:14EC:4E:82:E4:98:14
Attempting to connect to EC:4E:82:E4:98:14
[Bluetooth Mouse M557]# Failed to connect: org.bluez.Error.Failed Operation=
 already in progress
[Bluetooth Mouse M557]info EC:4E:82:E4:98:14
Device EC:4E:82:E4:98:14 (random)
	Name: Ember Ceramic Mug
	Alias: Ember Ceramic Mug
	Paired: yes
	Bonded: yes
	Trusted: no
	Blocked: no
	Connected: no
	LegacyPairing: no
	UUID: Vendor specific           (00001530-1212-efde-1523-785feabcd123)
	UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
	UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
	UUID: Device Information        (0000180a-0000-1000-8000-00805f9b34fb)
	UUID: Vendor specific           (fc543622-236c-4c94-8fa9-944a3e5353fa)
	ManufacturerData.Key: 0x03c1 (961)
	ManufacturerData.Value:
  81                                               .              =20

During which time btmon reports:

Bluetooth monitor ver 5.72
btmon[3449394]: =3D Note: Linux version 6.6.4-200.fc39.x86_64 (x86_64)     =
                                                                          0=
.747553
btmon[3449394]: =3D Note: Bluetooth subsystem version 2.22                 =
                                                                          0=
.747556
=3D New Index: 8C:88:2B:45:A0:8A (Primary,USB,hci0)                        =
                                                                   [hci0] 0=
.747557
=3D Open Index: 8C:88:2B:45:A0:8A                                          =
                                                                   [hci0] 0=
.747557
=3D Index Info: 8C:88:2B:45:A0:8A (Realtek Semiconductor Corporation)      =
                                                                   [hci0] 0=
.747558
bluetoothctl[3432959]: @ MGMT Open: bluetoothctl version 1.22              =
                                                               {0x0002} 0.7=
47559
bluetoothd[2012539]: @ MGMT Open: bluetoothd (privileged) version 1.22     =
                                                               {0x0001} 0.7=
47560
@ MGMT Event: Discovering (0x0013) plen 2                                  =
                                                        {0x0001} [hci0] 1.5=
79390
        Address type: 0x06
          LE Public
          LE Random
        Discovery: Disabled (0x00)
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6            =
                                                              #1 [hci0] 1.5=
79465
        Extended scan: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
bluetoothd[2012539]: @ MGMT Command: Start Service Discovery (0x003a) plen =
4                                                       {0x0001} [hci0] 1.5=
79491
        Address type: 0x06
          LE Public
          LE Random
        RSSI: invalid (0x7f)
        UUIDs: 0
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                              #2 [hci0] 1.5=
81137
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Random Address (0x08|0x0005) plen 6                  =
                                                              #3 [hci0] 1.5=
81210
        Address: 3B:30:98:2B:90:EC (Non-Resolvable)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                              #4 [hci0] 1.5=
82135
      LE Set Random Address (0x08|0x0005) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 13       =
                                                              #5 [hci0] 1.5=
82164
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
        PHYs: 0x05
        Entry 0: LE 1M
          Type: Active (0x01)
          Interval: 11.250 msec (0x0012)
          Window: 11.250 msec (0x0012)
        Entry 1: LE Coded
          Type: Active (0x01)
          Interval: 11.250 msec (0x0012)
          Window: 11.250 msec (0x0012)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                              #6 [hci0] 1.5=
83135
      LE Set Extended Scan Parameters (0x08|0x0041) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6            =
                                                              #7 [hci0] 1.5=
83164
        Extended scan: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                              #8 [hci0] 1.5=
84134
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 4                             =
                                                        {0x0001} [hci0] 1.5=
84163
      Start Service Discovery (0x003a) plen 1
        Status: Success (0x00)
        Address type: 0x06
          LE Public
          LE Random
@ MGMT Event: Discovering (0x0013) plen 2                                  =
                                                        {0x0001} [hci0] 1.5=
84166
        Address type: 0x06
          LE Public
          LE Random
        Discovery: Enabled (0x01)
@ MGMT Event: Discovering (0x0013) plen 2                                  =
                                                       {0x0001} [hci0] 12.3=
31534
        Address type: 0x06
          LE Public
          LE Random
        Discovery: Disabled (0x00)
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6            =
                                                             #9 [hci0] 12.3=
31560
        Extended scan: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
bluetoothd[2012539]: @ MGMT Command: Start Service Discovery (0x003a) plen =
4                                                      {0x0001} [hci0] 12.3=
31648
        Address type: 0x06
          LE Public
          LE Random
        RSSI: invalid (0x7f)
        UUIDs: 0
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                            #10 [hci0] 12.3=
33155
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Random Address (0x08|0x0005) plen 6                  =
                                                            #11 [hci0] 12.3=
33197
        Address: 1A:DD:6C:0E:11:58 (Non-Resolvable)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                            #12 [hci0] 12.3=
34155
      LE Set Random Address (0x08|0x0005) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 13       =
                                                            #13 [hci0] 12.3=
34194
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
        PHYs: 0x05
        Entry 0: LE 1M
          Type: Active (0x01)
          Interval: 11.250 msec (0x0012)
          Window: 11.250 msec (0x0012)
        Entry 1: LE Coded
          Type: Active (0x01)
          Interval: 11.250 msec (0x0012)
          Window: 11.250 msec (0x0012)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                            #14 [hci0] 12.3=
35153
      LE Set Extended Scan Parameters (0x08|0x0041) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6            =
                                                            #15 [hci0] 12.3=
35232
        Extended scan: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                            #16 [hci0] 12.3=
36177
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 4                             =
                                                       {0x0001} [hci0] 12.3=
36206
      Start Service Discovery (0x003a) plen 1
        Status: Success (0x00)
        Address type: 0x06
          LE Public
          LE Random
@ MGMT Event: Discovering (0x0013) plen 2                                  =
                                                       {0x0001} [hci0] 12.3=
36212
        Address type: 0x06
          LE Public
          LE Random
        Discovery: Enabled (0x01)

Any ideas?

[1] Am I safe in understanding that this BLE device should just
automatically connect to bluez once it's within vicinity of the BT
adapter?

Cheers,
b.



--=-0kICFoJqKGPaaV/rRNFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEE8B/A+mOVz5cTNBuZ2sHQNBbLyKAFAmXMwX0ACgkQ2sHQNBbL
yKA/XQf9EGX7Q7S/uOcog0yvoCKqOF4DZUb9I2HuXKKyA+vuPv+RRZETNzYqtRIh
m3d+TrNZfSDAwtEfViCxGI/MHuYJqDBBk0oN+Yk6m6gkOqk7dZszHyhoain4V0nD
crdXbgnEyNIouJNjkUaFdiwXO3LC6LA8qQZylCsInGXmUrrodXS46yNww41ROyBk
RXVSEqtFSjEqu/+MdBXxDxxOCT1L6Jj/oruiyiujQP0AHtrPXV7RCe4mbA1KeS5D
NcFD5jrnCm8Qmd+72lHgjCG2pWWYpuY5TuXi0jYwXmpOdU/t414Fquxigy0QZXyI
EEXjFst7X5hYDlJ1k3UwMpYVcW4r8A==
=uRy9
-----END PGP SIGNATURE-----

--=-0kICFoJqKGPaaV/rRNFl--
