Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F60346AF14
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2026 12:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780489649; cv=pass; b=S0AvqVKm7GTlU/QT2Zrqr8+WvjkatzK8nnNkuwBGaDrxfCK2awWk5YHV2e3pJ0Dshs767sZy7c+VNNFW1SYEKH5meQ3gVM0rR/ocTfl4Ic3SzxyI8lVLJx4cgbMpW/dv27W8RHcfc/0mIR505jeVHrQmHaE4YzBOC/sQJfXaqHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780489649; c=relaxed/simple;
	bh=ogrwhzpvykXXmaI9kpGXNHBJDPSRaqtLf6qMpSnEwb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dd/ymLat0FeCbXy+c2DdaEFU0cT6+ZYDQy80ngd3/zma6YOSbGcnmSjAdri6XTkEhEXGyjCKb2HOfz/vs9gN8+gyR2wMxmsk8Dddx8quA5LTPuSFnDj1wonvFtuNv5N2KNZuHHkNKlFO/ZLOdi0fCW51FLG6LIaUqK/u8/Mj6kA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/+fsHNK; arc=pass smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/+fsHNK"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-69de9bc590aso4635964eaf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2026 05:27:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780489647; cv=none;
        d=google.com; s=arc-20240605;
        b=Chl2fON0X/9dje1KU4MZ1Gc8VkpmbUSCHasPdchbuqaozS4Ke/KV8diDqi6ASM/hZA
         c9qI/ziSwOsUziLkC1QRS5sYl34HUis8EBvBZnWYEds/CDz1SIuCpxAbfpmiRUffjcQN
         41DZH/sB6RKlJsPkzV4TTDuPueYU1cllMUe7COk9wpsITWAYMFhW6J6+KvZnu3IdtBCP
         bHY/0LSX8xAOX4QKNY6HVuzHG4IvoB9loRU02zRfIHDlqb4E9Z7PVP+EoTbjCFVaLma6
         fImrDZlGTHmAF/r0A89c0K2yiCxtTXm1CrnR3aiB7JQOvrsRGeTmPZc4iDahwb9ZiMMm
         sJCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=FptQnf8pOc7EoW+cyuVnKIvueJHk+/+Fx8OiNMAU2ko=;
        fh=2GQw5DfB2zqacfboSsP43D9UayeLi+b1tGvlN1F0EUg=;
        b=Wn6QTxRlOfgY1U3w4royUtLK60obO7i484xMgsK1vhqt0H+b4sWdAr6VrNjuARSH8F
         FTVFNalVFeCsT3SE5rSjmd3mZHugy9kux3clblRTdtBaj/Td/jCCIKBp3i6Utqay1ARg
         pc+ayOQc8iTneAmtdHW5BnzLg2o2H0iUxJFH5Hky/O9Sp9xbO/iuf8RN/pExPxQm5HNV
         FcW4K6ntPOHHFoQVGFGMk3/Opq1FhaYDRJRKmelG2/JsQ+ibeyhAlENU4thGbtxk2n/j
         HcJL6EdkH0AqLidtIbEAkXZafMv4KbzK9cON26qrjk0E398JnN3uwjkEdPpsyIlyDUL/
         kaVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780489647; x=1781094447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FptQnf8pOc7EoW+cyuVnKIvueJHk+/+Fx8OiNMAU2ko=;
        b=g/+fsHNKew7TcpcfxCz7ylQkOdw+T17qPRfBvq5c67OPWPM8cR5TnNvVJtlYi7Fkl6
         +lzz1Uqq0QXQ363ynu4ePsJFGYrM0Bdg1jlawZPPBcyprFW5N8DBD9TERch5QiA7T/fy
         Ee8OVtM19TQ+Y+gIaZaSMwWRBrUZMBVsWyCZsCl11S/BGRjgaop8ibcNXOAtgOX/NQ4s
         qxnnHSFMXbSfz1iLuonH9CWXBZ6+rVPh1OgyVnFE2wOCheQjCV6wLnm5xdQSnbw/siZO
         u0iEbC9n0WZfNpdIKCyyJDogjrc0ZIzGj/YqBLfnKc1rAFc9QX1R4rS2Sya5tmMVqtSI
         Kmpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780489647; x=1781094447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FptQnf8pOc7EoW+cyuVnKIvueJHk+/+Fx8OiNMAU2ko=;
        b=jj+q0QphdBYXhCAt5QMPt+0y9kiILpdEH/scpW0njDcSmj1xDpeIefmhc/y+gNlkXb
         M99CVJnN3ejcvYOhphOlHK78TvrP5X59mRJ0O38KuwPTVscDSi51eZtIE5WVyK/plPjz
         siEzpuXOn2COXZ+PyRdaFGr2f9EczTYty4XroPfyiyOa0s++mLdPa1OrYmnaQ9x2W+LR
         EbKJTCxHMwQ11q8CKpNFq8+iN7+k9xyuNIEO7VmNfZdAwE3RgfILM916xkDL3288mX5M
         +EUH3y3l4Em3nrILtM7gE1DJv5W1Ycp1OUtYRhoL1N0XufcP7oTgACeGG/8GghXeeW1n
         Fdog==
X-Gm-Message-State: AOJu0YwaIT5J4enkXDQ1QREXc0QTPFoYaIj0+9PrIPMT/5+Ya9UjcoTU
	rHjOZbMm7Ka0peGVfCBYxDwPPJAgP6TujTXiG7nAF45fgPkezbCBu2OIc8CJaTwVBZ2mUhp3uW3
	xDeoIkMw7k0caDZIGjKvK/hL4JRXvUw==
X-Gm-Gg: Acq92OEDCNsdothSJ9eGZpMckvuxFtGcozBWYaqUJ/eBnizfws1F56FvzcBXSVN+A88
	WI//xrRjaeJki2tGjZGqP7qPEeLPCejQH0D+cTzRD5m104cH/g3NqN4O2TsTRFg6iS+E+OMtQBQ
	+XwkrK+x1SsI1dlsXikwy7raqVcxSfxf/XzE6KkjSCkgZ37khrJS4fu0VNXNx0NNrcPBuYFSyRJ
	hp8JVINHwsDjGbMe9BGZhEQ/E92yJZ3W/KIzTL/puWULcqKU/52M3zqBSmtmdETaa35dEcw2Y1m
	lfYNfT8YBW3ZKXuYrFX916Zn
X-Received: by 2002:a05:6820:1805:b0:69d:c5ad:40aa with SMTP id
 006d021491bc7-69e48091882mr1724955eaf.40.1780489646876; Wed, 03 Jun 2026
 05:27:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJAa45g30APLE4avbWg6EfkcUATR1rDh7a2DOM6dBOYbdF-a1Q@mail.gmail.com>
 <KL1PR03MB59762013DD64C282D57FA37AFA132@KL1PR03MB5976.apcprd03.prod.outlook.com>
 <200a9854dcce8a152b75f1c4497210c146f89cbc.camel@mediatek.com>
 <KL1PR03MB597680711115B27DA7D42571FA132@KL1PR03MB5976.apcprd03.prod.outlook.com>
 <3333c9b420af0b81c0ed21b969ca6e67b9701a84.camel@mediatek.com>
In-Reply-To: <3333c9b420af0b81c0ed21b969ca6e67b9701a84.camel@mediatek.com>
Reply-To: messinadm@gmail.com
From: Danny Messina <messinadm@gmail.com>
Date: Wed, 3 Jun 2026 08:27:14 -0400
X-Gm-Features: AVHnY4IsyBUNAcialELixKe-i3VmBinhEfw4eMI6s8nH9SEviDYwcBlJ7hKzrLY
Message-ID: <CAJAa45h7RC7c2yeF+Z2-VHNcfLOwjM0a0kOZOfOfdMfH9GTF9A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btmtk: Fix MT7925 WMT command timeout due to
 sleep protection
To: =?UTF-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, =?UTF-8?B?U1MgV3UgKOW3q+aGsuasoyk=?= <ss.wu@mediatek.com>, 
	"marcel@holtmann.org" <marcel@holtmann.org>, =?UTF-8?B?UGV0ZXIgVHNhbyAo5pu554+G5b2wKQ==?= <Peter.Tsao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

Thanks for the background, very helpful.

On register identification: I used usbmon to confirm WMT commands were
physically reaching the device with Control OUT completing
successfully, but the device returned zero bytes on every control IN
poll for the full 10-second timeout. After reading through btmtk.c and
adding printks to trace the exact failure point, I found a December
2023 patch submission by Peter Tsao titled "Bluetooth: btusb: Fix
MT7925 fail to send download patch command" which referenced writing
to register 0x18011100 to prevent the device entering sleep state
during firmware download. Testing confirmed this resolved the WMT
timeout on my hardware. The second bypass before FUNC_CTRL was
discovered when firmware download succeeded but FUNC_CTRL subsequently
timed out, indicating the chip re-enables sleep protection during the
100ms firmware activation delay.

On the subsystem reset: I was not aware of commit 33634e2ab. In my
testing the reset was necessary to recover from repeated failed
initialization attempts, as rmmod/modprobe without a cold power cycle
left the chip unresponsive to the SLPPROT bypass alone. I defer to
your judgment on whether it belongs here.

On your v7.1-rc fix: This was reproduced on a fresh install of Pop!_OS
24.04 running kernel 6.18.7. I don't have a v7 kernel available at the
moment but will see if I can reproduce the issue there and report
back.

Happy to provide any additional debugging output in the meantime.

Best regards,
Danny Messina


On Wed, Jun 3, 2026 at 4:37=E2=80=AFAM Chris Lu (=E9=99=B8=E7=A8=9A=E6=B3=
=93) <Chris.Lu@mediatek.com> wrote:
>
> Add linux-bluetooth to maillist
>
> > From: Chris Lu (=E9=99=B8=E7=A8=9A=E6=B3=93) <Chris.Lu@mediatek.com>
> > Sent: Wednesday, June 3, 2026 3:50 PM
> > To: messinadm@gmail.com
> > Cc: luiz.dentz@gmail.com; SS Wu (=E5=B7=AB=E6=86=B2=E6=AC=A3) <ss.wu@me=
diatek.com>;
> > marcel@holtmann.org; Peter Tsao (=E6=9B=B9=E7=8F=86=E5=BD=B0) <Peter.Ts=
ao@mediatek.com>
> > Subject: Re: [PATCH] Bluetooth: btmtk: Fix MT7925 WMT command timeout
> > due to sleep protection
> >
> > Hi Danny,
> >
> > Thanks for your submission. I have some question about this patch.
> >
> > > -----Original Message-----
> > > From: Danny Messina <messinadm@gmail.com>
> > > Sent: Monday, June 1, 2026 2:07 AM
> > > To: linux-bluetooth@vger.kernel.org
> > > Cc: Peter Tsao (=E6=9B=B9=E7=8F=86=E5=BD=B0) <Peter.Tsao@mediatek.com=
>;
> > > marcel@holtmann.org;
> > > Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > > Subject: [PATCH] Bluetooth: btmtk: Fix MT7925 WMT command timeout
> > > due
> > > to sleep protection
> > >
> > >
> > > External email : Please do not click links or open attachments
> > > until
> > > you have verified the sender or the content.
> > >
> > >   The MediaTek MT7925 USB Bluetooth device (0e8d:0717) fails to
> > > initialize
> > >   with repeated "Execution of wmt command timed out" errors:
> > >
> > >     Bluetooth: hci0: Execution of wmt command timed out
> > >     Bluetooth: hci0: Failed to send wmt patch dwnld (-110)
> > >     Bluetooth: hci0: Failed to set up firmware (-110)
> > >
> > >   USB capture (usbmon) confirms WMT commands reach the device =E2=80=
=94 the
> > >   Control OUT transfer completes with status 0 =E2=80=94 but the devi=
ce
> > > never
> > >   responds on any endpoint. The control IN polling URB returns zero
> > > bytes
> > >   indefinitely until HCI_INIT_TIMEOUT expires.
> > >
> > >   The root cause is the MT7925 BT core's sleep protection register
> > >   (0x18011100, bit 1 =3D SLPPROT_BYPASS). When SLPPROT is active the
> > > BT
> > >   processor ignores incoming WMT commands.
> > >
> > >   Two additional issues compound this:
> > >
> > >   1. After repeated driver load/unload cycles without a hardware
> > > reset,
> > >      the BT subsystem's WMT state machine becomes stuck. A
> > > subsystem
> > >      reset via btmtk_usb_subsys_reset() restores it to a workable
> > > state.
> > >
> > >   2. After btmtk_setup_firmware_79xx() activates the downloaded
> > > firmware
> > >      (which ends with a 100ms activation delay), the chip re-
> > > enables
> > >      SLPPROT. The subsequent FUNC_CTRL WMT command therefore also
> > > times
> > >      out unless SLPPROT is bypassed again.
> > >
> > >   Fix this for dev_id 0x7925 in btmtk_usb_setup():
> > >     1. Call btmtk_usb_subsys_reset() to clear any stuck WMT state.
> > >     2. Set 0x18011100 |=3D BIT(1) before firmware download.
> > >     3. Set 0x18011100 |=3D BIT(1) again before FUNC_CTRL.
> > >
> >
> > Could you share how you identified which register/value need to be
> > modified on MT7925 with such situation and why performed reset at
> > this specific point helps avoid the setup issue?
> >
> > >   Tested on a System76 Thelio desktop with MT7925 PCIe combo card,
> > >   USB ID 0e8d:0717, kernel 6.18.7.
> > >
> > >   Signed-off-by: Danny Messina <messinadm@gmail.com>
> > >   ---
> > >    drivers/bluetooth/btmtk.c | 33 +++++++++++++++++++++++++++++++++
> > >    1 file changed, 33 insertions(+)
> > >
> > >   diff --git a/drivers/bluetooth/btmtk.c
> > > b/drivers/bluetooth/btmtk.c
> > >   --- a/drivers/bluetooth/btmtk.c
> > >   +++ b/drivers/bluetooth/btmtk.c
> > >   @@ -1326,6 +1326,24 @@
> > >         case 0x7922:
> > >         case 0x7925:
> > >         case 0x7961:
> > >   +             if (dev_id =3D=3D 0x7925) {
> > >   +                     u32 val =3D 0;
> > >   +
> > >   +                     /* Reset BT subsystem to clear any stuck
> > > WMT
> > > state */
> > >   +                     err =3D btmtk_usb_subsys_reset(hdev, dev_id);
> > >   +                     if (err < 0)
> > >   +                             bt_dev_warn(hdev, "BT subsys reset
> > > failed (%d), continuing", err);
> > >   +
> > >   +                     /* Bypass sleep protection so WMT commands
> > > reach the BT core */
> > >   +                     err =3D btmtk_usb_uhw_reg_read(hdev,
> > > 0x18011100,
> > > &val);
> > >   +                     if (err < 0)
> > >   +                             return err;
> > >   +                     val |=3D BIT(1);
> > >   +                     err =3D btmtk_usb_uhw_reg_write(hdev,
> > > 0x18011100, val);
> > >   +                     if (err < 0)
> > >   +                             return err;
> > >   +             }
> > >   +
> > >                 btmtk_fw_get_filename(fw_bin_name,
> > > sizeof(fw_bin_name), dev_id,
> > >                                       fw_version, fw_flavor);
> > >
> > >   @@ -1342,6 +1360,19 @@
> > >                 if (err < 0)
> > >                         return err;
> > >
> > >   +             /* Re-bypass sleep protection after firmware
> > > activation for MT7925 */
> > >   +             if (dev_id =3D=3D 0x7925) {
> > >   +                     u32 val =3D 0;
> > >   +
> > >   +                     err =3D btmtk_usb_uhw_reg_read(hdev,
> > > 0x18011100,
> > > &val);
> > >   +                     if (err < 0)
> > >   +                             return err;
> > >   +                     val |=3D BIT(1);
> > >   +                     err =3D btmtk_usb_uhw_reg_write(hdev,
> > > 0x18011100, val);
> > >   +                     if (err < 0)
> > >   +                             return err;
> > >   +             }
> > >   +
> > >                 /* Enable Bluetooth protocol */
> > >                 param =3D 1;
> > >                 wmt_params.op =3D BTMTK_WMT_FUNC_CTRL;
> >
> > I'd also like to share some relevant background on this change:
> >
> > MediaTek Bluetooth team previously implemented a similar reset before
> > firmware download to ensure the controller was always in an initial
> > state. However, it was later reported by kernel community that this
> > caused USB enumeration failures on other devices, so the change was
> > reverted (commit 33634e2ab "Bluetooth: btmtk: Remove the resetting
> > step before downloading the fw").
> >
> > In April this year, I submitted a fix addressing setup failures on
> > MediaTek Bluetooth devices, which has been included since kernel
> > v7.1- rc. Could you try reproducing the issue with a recent kernel to
> > see whether the problem still occurs?
> >
> > Looking forward to your feedback.
> >
> > Best regards,
> > Chris Lu
>
>
> *********** MEDIATEK Confidentiality Notice ***********
> The information contained in this e-mail message (including any
> attachments) may be confidential, proprietary, privileged, or
> otherwise exempt from disclosure under applicable laws. It is
> intended to be conveyed only to the designated recipient(s). Any
> use, dissemination, distribution, printing, retaining or copying
> of this e-mail (including its attachments) by unintended recipient(s)
> is strictly prohibited and may be unlawful. If you are not an
> intended recipient of this e-mail, or believe that you have received
> this e-mail in error, please notify the sender immediately
> (by replying to this e-mail), delete any and all copies of this
> e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank you!
