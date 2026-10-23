Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792758847;
	b=st7TFP0+ROn/iZZsMaPHtpufC9mFqIy/4fP/tEKYVzb6KOCCffLxjTEm/PVs2Cy56VDP
	 +lIZUrGMi4y39dDwEgy9O7lXIrIUV4Cn8SV56IIR5cOAZKOY0nVPJ5s34aIPbVqQROiiH
	 eCAqvxLd1OeBEbPjVkKZ8qIlRBQDnWtjRajBQJ9oT6ZYLKlsEMV7ftTI71zRGb5fMXTm/
	 /zDFqWYNfx2APigje8B0BjkqZmbVtuf2zaFfUoVt6YPJ4rNfZKlTQhWh7GGTAxpe4vHLP
	 awuvxaZ4xJI3WlYOtH0f7ZNEca0EPvNSTqKXSLHvJt1QaVINXN7dDoQI8wZ06tSixbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792758847;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kQfyQg/cIaShaMOkH0zM4kq40IHH6Lp+WFj749oSK3c=;
	b=f5/54cPrZizN8+4iLDwm7rxkrc2vzwU+7T5NXeS4ilfC1mW0qU6khhKO7xmEaG1k7lqm
	 bvch7Mz3Jiw+z15k8uz18L/7jgalaQ5KxYxzokpB3n2zbPQCEFWUZSGy7XDL2dniPvx9y
	 quu5CV0PdVuiGxrmAsIZmEnkEKIIeQVv3gXr6ykzrtLNMzFRnnjQgU76H0qJO0Jif3wx3
	 K6dkLGsW9WrVu2KCWH9+oNxwH9K1v3CIyijNjFV5hnFUSyLFu/ETc63B3/TB92p2YyXNf
	 GUUbEdly6fKoWdezDjQljn/PH427nBpV1W4jmsTmiMurAsr2WFgH4i3LLAfwYm8emcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=jKX5oEZb;
	arc=none smtp.remote-ip=79.135.106.98
Received: from mail-10698.protonmail.ch (mail-10698.protonmail.ch [79.135.106.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A578F606A31E
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 12:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A578F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=jKX5oEZb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1792758842; x=1793018042;
	bh=kQfyQg/cIaShaMOkH0zM4kq40IHH6Lp+WFj749oSK3c=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=jKX5oEZbOfXl1imDoh52FrFXYn9gnherU6p7hJQ1uTQ/InRqWabKRWfuXX7sIMLbD
	 AJmRmI/pEsfRwodtCclfkmSStEYTudgRT0ox23hVtwAeOsdrjJihXFZPLMe0O7aqiO
	 YQyewczeIh04f+tnVfZXa/lG/2lKU0xdV6GgoISIWmmwQDl0n50UFqTxXLiwZraeev
	 Qlghi2ea3U9XA3Ez1H97Rmd4HmJJn5SQ1fggcdJYjTh/YR2GnW8aXzewenc20Iov1h
	 u/Th4qHX/SZ4eK7fhrKCo2Yh8rlJ+JO4vYPyBEHxhczGrf2Lv1IZGQ7YKvZVHEMV02
	 o9qB+qP2n0w5w==
Date: Fri, 23 Oct 2026 12:33:58 +0000
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: Gabriela Bartova <gabriela.bartova@proton.me>
Subject: btusb/btrtl: Realtek 0bda:b853 (RTL8852BE, ROM version 3) hci0 never initializes, zero BD address, no FW download
Message-ID: <GVrWcj7OWY_xn1c3JqNTGsmDKwlpNoj63oqTpfrGGly6WR9wsgzphoI-J7uyPreMyDvLfKSCTyaPY-gFqmdFh3YdaR-DHKOMM1gMvpYvfQk=@proton.me>
Feedback-ID: 229776960:user:proton
X-Pm-Message-ID: 14c7f0de6e9d7e3f0a103643f12ef17553ee1c2b
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,
I am reporting a Bluetooth controller that is detected by btusb but never f=
inishes setup, so BlueZ never sees it. Wi-Fi on the same card works.

Hardware
- Laptop: Lenovo LOQ 15ARP10E (AMD)
- BIOS: SUCN16WW, 11/11/2025 (no newer version offered via fwupd)
- Bluetooth: USB ID 0bda:b853 "Realtek Bluetooth Radio" (RTL8852BE combo ca=
rd)
- Wi-Fi on same card: rtw89_8852be, works (rtw89/rtw8852b_fw-1.bin loads)
- Distro: Linux Mint (Cinnamon)

Kernels tested (same failure on both)
- 6.14.0-37-generic
- 7.0.0-38-generic

Symptoms
- hci0 is registered, but BD address stays 00:00:00:00:00:00 and all featur=
es are zero
- bluetoothctl list: empty
- btmgmt info: "Index list with 0 items" (btmgmt config shows 0 unconfigure=
d as well)
- btmgmt power on: "Invalid Index"
- hciconfig hci0 up: "Can't init device hci0: No data available (61)"
- rfkill: not blocked (soft/hard both "no") during these tests

dmesg at module load
=C2=A0 Bluetooth: hci0: RTL: examining hci_ver=3D0b hci_rev=3D000b lmp_ver=
=3D0b lmp_subver=3D8852
=C2=A0 Bluetooth: hci0: RTL: rom_version status=3D0 version=3D3
=C2=A0 Bluetooth: hci0: RTL: btrtl_initialize: key id 0
=C2=A0 Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_fw.bin
=C2=A0 Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_config.bin
=C2=A0 Bluetooth: hci0: Opcode 0xfcf0 failed: -16
=C2=A0 Bluetooth: hci0: AOSP extensions version v0.96


With the packaged firmware, hciconfig up fails with =E2=80=98Invalid argume=
nt (22)=E2=80=99 and dmesg shows =E2=80=98didn=E2=80=99t find patch for chi=
p id 3=E2=80=99. With the current upstream file, the message is absent but =
hciconfig up fails with =E2=80=98No data available (61)=E2=80=99.
btrtl dynamic debug (module btrtl +p) shows the firmware being parsed:
=C2=A0 hci0: RTL: FW version 013525d6-0002c3f8
=C2=A0 hci0: RTL: opcode 0x0001
=C2=A0 hci0: RTL: subsec, eco 0x01, len 0001063d
=C2=A0 hci0: RTL: subsec, eco 0x02, len 0000f445
=C2=A0 hci0: RTL: opcode 0x0008
Only eco 0x01 and eco 0x02 sections are listed, while the chip reports ROM =
version 3. I do not know whether this mismatch is relevant.

btmon trace (hciconfig hci0 up)
- The controller answers the vendor commands 0x3f|0x0061 and 0x3f|0x006d an=
d Read Local Version successfully (Bluetooth 5.2, subversion 0x8852, manufa=
cturer Realtek).
- The only failing command is the Microsoft Extension "LE Set Advertisement=
 Filter Enable" (0x3f|0x00f0, subcommand 0x05), which returns Command Disal=
lowed (0x0c). This corresponds to the "Opcode 0xfcf0 failed: -16" line.
- I see no firmware download commands in the trace, and no HCI Reset or Rea=
d BD Addr afterwards. The index is closed right after the 0x3f|0x0153 vendo=
r command.

btmon OUTPUT:
Bluetooth monitor ver 5.72btmon[4259]: =3D Note: Linux version 7.0.0-38-gen=
eric (x86_64) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.500853
btmon[4259]: =3D Note: Bluetooth subsystem version 2.22 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00.500856
=3D New Index: 00:00:00:00:00:00 (Primary,USB,hci0) =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [hci0] 0.500858
bluetoothd[1055]: @ MGMT Open: b.. (privileged) version 1.23 =C2=A0{0x0001}=
 0.500859
=3D Delete Index: 00:00:00:00:00:00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[hci0]=
 44.716375
=3D New Index: 00:00:00:00:00:00 (Primary,USB,hci0) =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0[hci0] 44.754649
=3D Open Index: 00:00:00:00:00:00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0[hci0] 44.754727
< HCI Command: Vendor (0x3f|0x0061) plen 5 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#1 [hci0] 44.754752
=C2=A0 =C2=A0 =C2=A0 =C2=A0 10 38 04 28 80 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 .8.(. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
> HCI Event: Command Complete (0x0e) plen 6 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 #2 [hci0] 44.756221
=C2=A0 =C2=A0 =C2=A0 Vendor (0x3f|0x0061) ncmd 2
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Status: Success (0x00)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ef be =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.. =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0
< HCI Command: Read Local Version I.. (0x04|0x0001) plen 0 =C2=A0#3 [hci0] =
44.756253
> HCI Event: Command Complete (0x0e) plen 12 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0#4 [hci0] 44.759216
=C2=A0 =C2=A0 =C2=A0 Read Local Version Information (0x04|0x0001) ncmd 2
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Status: Success (0x00)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 HCI version: Bluetooth 5.2 (0x0b) - Revision 11=
 (0x000b)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP version: Bluetooth 5.2 (0x0b) - Subversion =
34898 (0x8852)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Manufacturer: Realtek Semiconductor Corporation=
 (93)
< HCI Command: Vendor (0x3f|0x006d) plen 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#5 [hci0] 44.759253
> HCI Event: Command Complete (0x0e) plen 5 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 #6 [hci0] 44.762211
=C2=A0 =C2=A0 =C2=A0 Vendor (0x3f|0x006d) ncmd 2
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Status: Success (0x00)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 03 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 . =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0
< HCI Command: Vendor (0x3f|0x0061) plen 5 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#7 [hci0] 44.762240
=C2=A0 =C2=A0 =C2=A0 =C2=A0 10 a4 ad 00 b0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 ..... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
> HCI Event: Command Complete (0x0e) plen 6 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 #8 [hci0] 44.765200
=C2=A0 =C2=A0 =C2=A0 Vendor (0x3f|0x0061) ncmd 2
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Status: Success (0x00)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 00 00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.. =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0
< HCI Command: Vendor (0x3f|0x00f0) plen 1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#9 [hci0] 44.765655
=C2=A0 =C2=A0 =C2=A0 =C2=A0 00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 . =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0
> HCI Event: Command Complete (0x0e) plen 22 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 #10 [hci0] 44.769258
=C2=A0 =C2=A0 =C2=A0 Vendor (0x3f|0x00f0) ncmd 2
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Status: Success (0x00)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 00 3f 00 00 00 00 00 00 00 08 23 79 54 33 77 88=
 =C2=A0.?........#yT3w.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 97 68 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.h =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0
< HCI Command: Vendor (0x3f|0x00f0) plen 2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 #11 [hci0] 44.769283
=C2=A0 =C2=A0 =C2=A0 =C2=A0 05 01 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.. =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0
> HCI Event: Command Complete (0x0e) plen 5 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0#12 [hci0] 44.771208
=C2=A0 =C2=A0 =C2=A0 Vendor (0x3f|0x00f0) ncmd 2
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Status: Command Disallowed (0x0c)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 05 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 . =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0
< HCI Command: Vendor (0x3f|0x0153) plen 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 #13 [hci0] 44.771238
> HCI Event: Command Complete (0x0e) plen 18 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 #14 [hci0] 44.775255
=C2=A0 =C2=A0 =C2=A0 Vendor (0x3f|0x0153) ncmd 2
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Status: Success (0x00)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 00 00 00 00 00 00 00 00 60 00 00 00 00 00 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0........`..... =C2=A0
=3D Close Index: 00:00:00:00:00:00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [hci0=
] 44.775281


dmesg | grep -i -E "hci0|bluetooth|btusb" OUTPUT:

[ 758.962164] hci0: skb len 8

[ 758.962167] hci0: length 1

[ 758.962176] hci0 cmd_cnt 1 cmd queued 1

[ 758.962180] hci0: skb 00000000e2be942f

[ 758.962183] hci0 type 1 len 8

[ 758.965119] hci0

[ 758.965125] hci0 Event packet

[ 758.965129] hci0: event 0x0e

[ 758.965132] hci0: opcode 0xfc61

[ 758.965139] hci0: result 0x00

[ 758.965151] hci0: end: err 0

[ 758.965155] Bluetooth: hci0: RTL: btrtl_initialize: key id 0

[ 758.965158] Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_fw.bin

[ 758.965499] Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_config.bin

[ 758.965550] Bluetooth: hci0: RTL: didn't find patch for chip id 3

[ 758.965560] hci0: Initialize MSFT extension

[ 758.965563] hci0: Opcode 0xfcf0

[ 758.965566] hci0: opcode 0xfcf0 plen 1

[ 758.965570] hci0: skb len 4

[ 758.965573] hci0: length 1

[ 758.965584] hci0 cmd_cnt 1 cmd queued 1

[ 758.965588] hci0: skb 000000001001aa3d

[ 758.965592] hci0 type 1 len 4

[ 758.969118] hci0

[ 758.969123] hci0 Event packet

[ 758.969127] hci0: event 0x0e

[ 758.969130] hci0: opcode 0xfcf0

[ 758.969138] hci0: result 0x00

[ 758.969150] hci0: end: err 0

[ 758.969154] hci0: Opcode 0xfcf0

[ 758.969157] hci0: opcode 0xfcf0 plen 2

[ 758.969160] hci0: skb len 5

[ 758.969163] hci0: length 1

[ 758.969172] hci0 cmd_cnt 1 cmd queued 1

[ 758.969176] hci0: skb 0000000087f6e5ca

[ 758.969180] hci0 type 1 len 5

[ 758.971123] hci0

[ 758.971134] hci0 Event packet

[ 758.971137] hci0: event 0x0e

[ 758.971141] hci0: opcode 0xfcf0

[ 758.971146] hci0: result 0x0c

[ 758.971157] hci0: end: err -16

[ 758.971160] Bluetooth: hci0: Opcode 0xfcf0 failed: -16

[ 758.971164] hci0: Initialize AOSP extension

[ 758.971167] hci0: Opcode 0xfd53

[ 758.971169] hci0: opcode 0xfd53 plen 0

[ 758.971172] hci0: skb len 3

[ 758.971174] hci0: length 1

[ 758.971181] hci0 cmd_cnt 1 cmd queued 1

[ 758.971184] hci0: skb 00000000de554a13

[ 758.971187] hci0 type 1 len 3

[ 758.975114] hci0

[ 758.975120] hci0 Event packet

[ 758.975124] hci0: event 0x0e

[ 758.975127] hci0: opcode 0xfd53

[ 758.975134] hci0: result 0x00

[ 758.975147] hci0: end: err 0

[ 758.975150] Bluetooth: hci0: AOSP extensions version v0.96

[ 758.975153] Bluetooth: hci0: AOSP quality report is not supported

[ 758.975158] hdev hci0 event 8


Things already tried
- Unblocking rfkill, reloading btusb (rmmod/modprobe), and USB unbind/bind
- Replacing the firmware with the current upstream file
- Full cold power cycles (shutdown, charger unplugged, power button held)
- Kernels 6.14 and 7.0
- The Lenovo Windows driver package contains only BTNIC003-format .dat file=
s, which are not usable on Linux

Questions
1. Does any released rtl8852bu_fw.bin contain a patch for chip id 3 (ROM ve=
rsion 3)?
2. Why does setup stop before any firmware download without logging an erro=
r?

I am happy to test patches or provide more traces (btmon, usbmon, additiona=
l dynamic debug).

Thank you,


Gabriela Bartova.
