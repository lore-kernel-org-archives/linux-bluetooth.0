Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334A031A554
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 19:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756236732; cv=none; b=VKDahMO2B9r1Eb03O/OvKtuuH2SQfloeAHHosW2B3VVhvnnfsxvg0JWzwiF4cipJlefUlW+Z1J1/2jH19z4DoXtAYfJRwAVpuCvt0ck5YHOfYT4hHNXBkV+M5LTj5xo7TIGr/KTgxf9eoZlIshVuei4Qu/XqwoKFXyVpBFePrOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756236732; c=relaxed/simple;
	bh=L2hc4szBYUpK+twqX/xFuZcMbKClBPF8MQkCl/j+yiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rFyVnnLIOTXAA1sAUC5AMRYGjPqdLy40rqXW73nAbYLZuWFG7Bfj/wMLRwhSF1+16Y/qUr9geDMnevMU0ALhNW/X/M3YnDzvOGSpO4Z/5ybqs3Nbooj/NGeZrzRr2R+7yPAOQK9cn/A+PgJpuOH8k+iPlu8nHt2c7poORmYF784=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHP2DgvM; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHP2DgvM"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-333f92d60ddso44965961fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 12:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756236729; x=1756841529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDrkE0Fr57Ns7m37fmVzhJjkVww+HP1YBzUVbwQbwio=;
        b=kHP2DgvM+MeDB+VfunMqy6u5ybIzYisD+3Vb+atjv4E9RC9wDFscnBEmOu1JhGROxI
         cH3tSBJXBGP10d1UGPc1ZmVOoffFB4ZmkXEZCp1CXGOsfbrqXoh8ddrW4so/uU5xXUZV
         4/S2BBFzPSYNPzr1CwQmACmES6Rme68Pha42W850HXjfZBg4skO3hxOymKEX7nhxfK2g
         caLLQ+a9ASfSsfcx9HgChIzou6CZR6elFUxIr4hALc4KhzVpDZlx/HibhQIXyKiJDe/l
         j5Q5Je5Qo3IjV2BIpy+yBKNz6STpfE3bsFc6Q5OxV4WdGe/qxrID4x9pJyGFcSlkw56l
         hZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756236729; x=1756841529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDrkE0Fr57Ns7m37fmVzhJjkVww+HP1YBzUVbwQbwio=;
        b=kSnQ4dD5qg6BgriSPJTVk2C/MyrLwXCF22UQvODjWCB0xn1kI1l+DdhSV02eeTfHuj
         Gm7WPm4ErBiunW4bLiY0GHylFs5bBY6JZqmK4C4LZnESoR/2NbCugTWODOZnbbvU6UgR
         aLKpPKAu0gS8a3/qYljGDwAkppBaXVX9FMtmPenzRstOZY1maXd351Ei73i39VPsw2Bq
         0R9fYPnDtjIEh1vCd7hU2ZsPrbXifaehcKAxKqT8GATY8TZLC7YfEKBMt4YHuvsCiOXD
         air1PHO1HMBSYgvOY8xCXSE1WMnUUgvOngbLrLrE5cHaOwF1wo16FiB0Mn5RCwAuLRYy
         qfkQ==
X-Gm-Message-State: AOJu0YxoGsUjDIf6hBmEeFokrzP4kkFOFYle7Yz24vfN8Yy4n4u6N38F
	SdzVWNoQeKwyF6In8t9yQHPU/g4oe2eZ692ykOGqF8HzOPBdrWHaykVOnRY6Knj0JVIU8h82dLs
	le4OydELAiyU0YNrHj4htnKAcYLaH5uBfbRrg
X-Gm-Gg: ASbGnctBPf9VDeFUbA1VWNLoqhSE++THVtJLq6pa8z2s5nf9Q4qtuc1l2hiNJoqrDdU
	Rg8mmwLyFbMLY8jfXnKMBfwyHk5ZzEPUPG5ctMy03nK/kqG7w3+GX5G5oVCtCeVIXsB3K9tegJc
	q9p/m5QDIHDqEq1bxQDxNXQa+F9mc5ax78ouOdwr8kbCq2SJ+4EawR+S7ZRgKV14byWPc82sqeV
	5VzrJ6uulYuMFh4sm8b9KCO6/sNPPf59xSCDV9Xb2CqdqZ3TnzX/3Rh
X-Google-Smtp-Source: AGHT+IEzmzAmHtATzOYBbqOGircPK/WVDZDklO4eqMcDZlESbdDnEBNlNQDuTqRBtcApvfABpGdYJlTxrAJbwCJZIUU=
X-Received: by 2002:a05:651c:1a0c:b0:336:6b37:c8f4 with SMTP id
 38308e7fff4ca-3366b37cf0bmr30752961fa.35.1756236728926; Tue, 26 Aug 2025
 12:32:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZLmTCh_mn7w6U31B82cBZsmLaj92dxwfK9PVWZeMqk54Q@mail.gmail.com>
 <20250826170314.352122-1-arkadiusz.bokowy@gmail.com>
In-Reply-To: <20250826170314.352122-1-arkadiusz.bokowy@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 26 Aug 2025 15:31:56 -0400
X-Gm-Features: Ac12FXxGVPV_rIKbbNKcuhacWIg1ZUUE-BW_jO3-NUd69Tn_0KEdAcWl2j270ik
Message-ID: <CABBYNZJ7kbHJ665-rsKQTfP_U=pfBwAPrGki7JSBpF7+wiXung@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: Check for unexpected bytes when
 defragmenting HCI frames
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arkadiusz,

On Tue, Aug 26, 2025 at 1:03=E2=80=AFPM Arkadiusz Bokowy
<arkadiusz.bokowy@gmail.com> wrote:
>
> Some Barrot based USB Bluetooth dongles erroneously send one extra
> random byte for the HCI_OP_READ_LOCAL_EXT_FEATURES command. The
> consequence of that is that the next HCI transfer is misaligned by one
> byte causing undefined behavior. In most cases the response event for
> the next command fails with random error code.
>
> Since the HCI_OP_READ_LOCAL_EXT_FEATURES command is used during HCI
> controller initialization, the initialization fails rendering the USB
> dongle not usable.
>
> > [59.464099] usb 1-1.3: new full-speed USB device number 11 using xhci_h=
cd
> > [59.561617] usb 1-1.3: New USB device found, idVendor=3D33fa, idProduct=
=3D0012, bcdDevice=3D88.91
> > [59.561642] usb 1-1.3: New USB device strings: Mfr=3D0, Product=3D2, Se=
rialNumber=3D0
> > [59.561656] usb 1-1.3: Product: UGREEN BT6.0 Adapter
> > [61.720116] Bluetooth: hci1: command 0x1005 tx timeout
> > [61.720167] Bluetooth: hci1: Opcode 0x1005 failed: -110
>
> This patch was tested with the 33fa:0012 device. Now the device is
> initialized properly:

I'm trying to find any entry with 0x33fa but I couldn't find any, we
probably want to include the Fixes tag to the commit that introduces
support for it.

>
> > [43.329852] usb 1-1.4: new full-speed USB device number 4 using dwc_otg
> > [43.446790] usb 1-1.4: New USB device found, idVendor=3D33fa, idProduct=
=3D0012, bcdDevice=3D88.91
> > [43.446813] usb 1-1.4: New USB device strings: Mfr=3D0, Product=3D2, Se=
rialNumber=3D0
> > [43.446821] usb 1-1.4: Product: UGREEN BT6.0 Adapter
> > [43.582024] Bluetooth: hci1: Unexpected continuation: 1 bytes
> > [43.703025] Bluetooth: hci1: Unexpected continuation: 1 bytes
> > [43.750141] Bluetooth: MGMT ver 1.23
>
> Signed-off-by: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
> Tested-by: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
> ---
>  drivers/bluetooth/btusb.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 8085fabad..24a249d1c 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1192,6 +1192,18 @@ static int btusb_recv_intr(struct btusb_data *data=
, void *buffer, int count)
>                 }
>
>                 if (!hci_skb_expect(skb)) {
> +                       /* Each chunk should correct to at least 1 or mor=
e
> +                        * events so if there are still bytes left that d=
oesn't
> +                        * constitute a new event this is likely a bug in=
 the
> +                        * controller.
> +                        */
> +                       if (count && count < HCI_EVENT_HDR_SIZE) {
> +                               bt_dev_warn(data->hdev,
> +                                       "Unexpected continuation: %d byte=
s",
> +                                       count);
> +                               count =3D 0;
> +                       }
> +
>                         /* Complete frame */
>                         btusb_recv_event(data, skb);
>                         skb =3D NULL;
> --
> 2.47.2
>
>


--=20
Luiz Augusto von Dentz
