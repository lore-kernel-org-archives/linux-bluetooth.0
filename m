Received: from mail-106101.protonmail.ch (mail-106101.protonmail.ch [79.135.106.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC83EDDA9
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Aug 2026 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785673902; cv=none; b=XJaAj20RwZMWwp5gZiWmEkIyug4HlY2wS2Dcmfkisf1YE23A4Sey/NwBLO+Y6XNI8lepBOPz+uDR00yqiGXGBqdESbGxpMPP6Mux83TgB9ZgihYu/dI5RAfSa1SbEgV7hWHc6Q2n2iWTHsGruDjQQA2Hf4srd/DfoExZ55ApyoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785673902; c=relaxed/simple;
	bh=ndJuvgTBf4+ZIEoOSgo+ZJu5BIYLBgeuY5bkNN3mRtw=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=LTf+OEb6DW5FNW2Oy0GVnUQ5DOBtAqn0nDVNIe8CcKPKJYvjr7d+crqrBxj9jGxERLaB05pU/qkUgmweskcHEVsMy28ek0x3ymFiDfK8FjUGR8GminZD2F5O4Q6UYDDGlZWjvDki70nuLRbUjuWLH2aJSsiakYg/Zw8g+TEAP1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.ch; spf=pass smtp.mailfrom=protonmail.ch; dkim=pass (2048-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b=hBQIkv9c; arc=none smtp.client-ip=79.135.106.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="hBQIkv9c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
	s=protonmail3; t=1785673891; x=1785933091;
	bh=ndJuvgTBf4+ZIEoOSgo+ZJu5BIYLBgeuY5bkNN3mRtw=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=hBQIkv9cF01Ksw2htVM5OG/aY/e/LBEiqjxRuOC6mf9bmwR/qqmyFrF2AvhKhZFHB
	 bDYrbJHaaKc9zfFsxk4Gn+hOtLwrjOpmEP0dC6GC3V55nTRBPV3yQxXe2qJ9ubPWzI
	 2KtyF81NqCMzXQiiAV8qNllJc2MueFgQoQl2tRmMUTW4OTThMxGdcxrJSJwnHgGMbV
	 L8/Qjf8wmktpT7sf94VyzWrjWjEF5pZxleZd3Nf23c+eWB7q1g6AT8pYnNkFtGaixL
	 qFbfyui+eg+CApHbvkLj/vc4LjJTQrEMRJwgUMNy5ClQ9c8Cdy0HaybKb3kEGd6tVX
	 7PwUfwiRks1/A==
Date: Sun, 02 Aug 2026 12:31:25 +0000
To: "hildawu@realtek.com" <hildawu@realtek.com>, "pkshih@realtek.com" <pkshih@realtek.com>, "timlee@realtek.com" <timlee@realtek.com>, "kevin_yang@realtek.com" <kevin_yang@realtek.com>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: deniz <denizgu@protonmail.ch>
Subject: rtl_bt: RTL8852BU rom_version 3 has no matching in rtl8852bu_fw.bin
Message-ID: <6fA7_pnseglPl3sGOhJ9Blqy9rvnEcG0jTZEaJxRmt7Z9hyouvO-WtWss7N_xgZMoV7kzNlEDt4sBFiCIiyfsfpUUnB-uAtOMwVjVeX-SDg=@protonmail.ch>
Feedback-ID: 11591950:user:proton
X-Pm-Message-ID: f6499a796c320e729b41d0b92d24dd6195ebf944
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello there, forwarding this report to people in the linux-firmware repo wo=
rking on realtek devices.

A similar report was filed here:=C2=A0https://lore.kernel.org/linux-firmwar=
e/CAP9emj2-8hXB3t3SFD6RU2ZsttsiOtJ6W4Bto4jXSw+dB=3D=3DTmA@mail.gmail.com It=
 looks to be a widespread problem.

The current rtl_bt/rtl8852bu_fw.bin (Release Version 0x127C_FD78, commit"rt=
l_bt: Update RTL8852B BT USB FW to 0x127C_FD78", 2026-03-26) contains no
firmware patch matching the ECO revision of the RTL8852BU controller in Len=
ovo IdeaPads shipping today. Bluetooth is completely non-functional=C2=
=A0as a result.

Could an rom version 3 (eco 4) patch be added for RTL8852B BT USB?

I have provided diagnostic details below, please feel free to reach out for=
 more.

Happy to test any candidate firmware and report back.
Thanks,

Deniz


-------Hardware--------------


=C2=A0 Machine =C2=A0 =C2=A0 =C2=A0 =C2=A0 : Lenovo IdeaPad=C2=A0 BT contro=
ller =C2=A0 : 0bda:b853 "Bluetooth Radio", Realtek (USB)
=C2=A0 WiFi (same M.2) : RTL8852BE, rtw89_8852be, PCIe 01:00.0 - works norm=
ally
=C2=A0 Driver =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: btusb + btrtl
=C2=A0 linux-firmware =C2=A0: linux-firmware-realtek 20260622-1 (Arch Linux=
)

Controller reports:
=C2=A0 Bluetooth: hci0: RTL: examining hci_ver=3D0b hci_rev=3D000b lmp_ver=
=3D0b lmp_subver=3D8852
=C2=A0 Bluetooth: hci0: RTL: rom_version status=3D0 version=3D3
=C2=A0 Bluetooth: hci0: RTL: btrtl_initialize: key id 0

This matches the intended IC table entry in drivers/bluetooth/btrtl.c, so t=
he correct firmware file is being selected:

=C2=A0 { IC_INFO(RTL_ROM_LMP_8852A, 0xb, 0xb, HCI_USB),
=C2=A0 =C2=A0 .config_needed =3D false,
=C2=A0 =C2=A0 .has_rom_version =3D true,
=C2=A0 =C2=A0 .has_msft_ext =3D true,
=C2=A0 =C2=A0 .fw_name =C2=A0=3D "rtl_bt/rtl8852bu_fw",
=C2=A0 =C2=A0 .cfg_name =3D "rtl_bt/rtl8852bu_config",
=C2=A0 =C2=A0 .hw_info =C2=A0=3D "rtl8852bu" },


-------Problem-------

btrtl_parse_section() accepts only subsections whose ECO revision matches t=
he
controller:

=C2=A0 /* drivers/bluetooth/btrtl.c */
=C2=A0 if (common_subsec->eco !=3D btrtl_dev->rom_version + 1)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;

The controller reports rom_version =3D 3, so only an eco 4 patch is accepte=
d.
Parsing the shipped firmware with an exact replica of the kernel parser giv=
es:

=C2=A0 fw_len =C2=A0 =C2=A0 =C2=A0 : 129733
=C2=A0 signature =C2=A0 =C2=A0: RTBTCore =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(RTL_EPATCH_SIGNATURE_V2)
=C2=A0 num_sections : 2

=C2=A0 section[0]: opcode=3D0x01 (RTL_PATCH_SNIPPETS) len=3D129686
=C2=A0 =C2=A0 =C2=A0 section_hdr.num =3D 2 subsections
=C2=A0 =C2=A0 =C2=A0 [ 0] skip =C2=A0 eco=3D0x01 prio=3D15 len=3D67133 =
=C2=A0 =C2=A0eco 1 !=3D rom_version+1 (4)
=C2=A0 =C2=A0 =C2=A0 [ 1] skip =C2=A0 eco=3D0x02 prio=3D15 len=3D62533 =
=C2=A0 =C2=A0eco 2 !=3D rom_version+1 (4)
=C2=A0 =C2=A0 =C2=A0 -> contributed 0 bytes
=C2=A0 section[1]: opcode=3D0x08 (not handled by the switch) len=3D0
=C2=A0 =C2=A0 =C2=A0 -> contributed 0 bytes

=C2=A0 total len accumulated =3D 0

Only eco 1 and eco 2 are present; eco 3 is absent as well. Both subsections=
 are skipped, so no patch data is collected.

I also downloaded rtl_bt/rtl8852bu_fw.bin directly from upstream linux-firm=
ware and confirmed it is byte-identical to the packaged copy, so this is no=
t a distribution packaging artifact:


------- Consequence -------

With zero bytes collected, rtlbt_parse_firmware_v2() returns -ENODATA, no f=
irmware is downloaded to the controller, btrtl_setup_realtek() fails, and h=
ci_dev_open() fails. HCI_SETUP is therefore never cleared and mgmt_index_ad=
ded() never fires, so bluetoothd never sees a controller at all:

=C2=A0 $ bluetoothctl list =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 # empty
=C2=A0 $ sudo btmgmt info
=C2=A0 Index list with 0 items
=C2=A0 $ sudo btmgmt config
=C2=A0 Unconfigured index list with 0 items

The controller itself responds correctly from stock ROM firmware. btmon sho=
ws every identification and setup command succeeding - vendor 0xfc61 (twice=
), Read Local Version Information, vendor 0xfc6d, MSFT Read Supported Featu=
res, and the AOSP vendor command 0xfd53 all return Status: Success. The onl=
y command that does not is the MSFT LE Set Advertisement Filter Enable, whi=
ch returns Command Disallowed (0x0c) - expected, given no patch firmware wa=
s ever loaded.

Reproduced identically on kernels 6.18.40-2-lts and 7.1.4-arch1-1.

------- Note on diagnosability -------

Both error paths involved are silent, which made this very hard to track do=
wn:

=C2=A0 rtlbt_parse_firmware_v2(): =C2=A0 if (!len) return -ENODATA; =C2=
=A0 /* no message */
=C2=A0 btrtl_setup_rtl8723b(): =C2=A0 =C2=A0 =C2=A0if (ret < 0) goto out; =
=C2=A0 =C2=A0 =C2=A0 /* no message */

The only kernel output is the firmware being loaded from disk, followed by =
nothing at all - no download, no error. A single rtl_dev_err() naming the r=
equired versus available ECO revisions would make this diagnosable in secon=
ds. I am happy to send a separate patch for that to linux-bluetooth if usef=
ul.


------- ECO coverage across the family -------

For reference, ECO revisions present in linux-firmware-realtek 20260622-1:

=C2=A0 rtl8852au_fw.bin =C2=A0 =C2=A0 =C2=A0eco 2
=C2=A0 rtl8852bu_fw.bin =C2=A0 =C2=A0 =C2=A0eco 1, 2 =C2=A0 =C2=A0 =C2=
=A0<- this machine needs eco 4
=C2=A0 rtl8852btu_fw.bin =C2=A0 =C2=A0 eco 1
=C2=A0 rtl8852cu_fw_v2.bin =C2=A0 eco 1, 2
=C2=A0 rtl8851bu_fw.bin =C2=A0 =C2=A0 =C2=A0eco 1
=C2=A0 rtl8922au_fw.bin =C2=A0 =C2=A0 =C2=A0eco 2

