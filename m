Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860342ED141
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 13:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756302174; cv=none; b=C28/2cSNCHE0ns1AmMHAoxsKMU/KIdCSNcZbJNnWay1r5jgz2LyXn6u2xXm4kRopUOc634eSg14PcU5Latle5tv/GCeuVnhMijPI2Gfypw8u8PL4SSTaau2JZJud/rM0tzoGgEKsxZa9O7HqQU/EHwxJ6Oev5jSsnNQCdDxsZ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756302174; c=relaxed/simple;
	bh=VhqFxVDpU/LovEKugMoDn0ABDSICwf2hF2VQHo8u6ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VOSjo0GunA0LcEItyTLCWBdIg6SdEal+Bi790PnvqhR2s2oliqh9Taic5g7BnGftMYxq8tKSHIQ7+ZZbuGClIcqBWvS/jn0ayDTXkmHRknERKjNPdbFn2g7tOH0F7FQOfVvGo4fXIkWYJf7FKheo+cXglqUGdMDqeq5oIjYw/NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4DqS6fr; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4DqS6fr"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55f3ec52a42so4517485e87.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 06:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756302171; x=1756906971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqfRSSLwhR483qDqg+kOO7AhGE+sBPN5Jnt6QvcjvQ0=;
        b=D4DqS6fr1QgWuizhVPOaoivRNekUQPe426rMbZmQbvxI+MPy9H2+LI3XYB1fn7irZv
         AdcUZ2mHvW1GuwIgAZIo69FHIEwh9dMuxYHjGz+zRxeivyQ3k5cByffvn6h26taS15Ix
         3b4vjEiLVLiIX9DmJ7tnPGJkH/XIhg5qrKLJUdmKso8mVhTFwkI0zy8MGDsgL7ijmSky
         bb6/JS51OVH65uOzixwiFLdLdaRi8V0Mu/FQ3FJDCW/0WjdceGuGubLSmib2rw811Ooh
         3vfdV1WPiyLrSJoAl4Wd2o2oLV9f+R5H8I6JHIFl/CqFXaD5Yz7Vik27J9xhNghztBOR
         1RXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756302171; x=1756906971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqfRSSLwhR483qDqg+kOO7AhGE+sBPN5Jnt6QvcjvQ0=;
        b=RXT8IUmXP6jgRrSLJMQt6mqZLQyM/gr6GmAD86Yj4C4wOy5hJcwiNUiDpU/lcD2OYS
         GjFfUKqnNglCDEkNfpHdxzQRQUL6dad0Sp6jwI2CvTeM6FQ46znalH+PR8f6LUXay8Sn
         VCe8er71+1kSt8wLILUxAeXIft7KLmIy7oOYwyAZD6yiilX4pj4M0VUISHE+CNQO0Dzz
         kHCH2x1C6TFqWMY8VOEjks9NYVMYpysQqd+ohhW5hoc2RALEaLsD4UyI5g1R5QWh5GsP
         dVJKiwfS76O0vtktfzOZqmTGoxis8+CgOQoC9UNAHBF7KHzWimYGgCg67/30I8ozCRmm
         3Lrw==
X-Gm-Message-State: AOJu0YxBRr8XqFG1zniMOgXubeYd4nduXKykOYG8NC9RXOVZoJEKMl/b
	JooxpuaJqbHQt3I9K2w+5i8PCT8ZnsX0tt/YXFtfHyN2iM01tau0HDMQbY8VjqAfEr7Z5/k7P30
	qp0u0iSExwhaXmqfW4pPDjJd5H6EhZ40=
X-Gm-Gg: ASbGncvuxLcqfkO1HoeQscHC3tl7prfymmPKpips41Q+71ezIeMGuqEOTd9Yq2r8b0Z
	4T9uYG3lE8LYrl4+4VCqGBVRKA6KiE9V8CWGao/l7AlPlOnfWEQnlEQUbbELUhsOoENx1/Li4iA
	uGk9KifZgKos/kC3CvYWwMWyV/2G9y096DvtgFdi8Qlu7twFRXFl9uZ2mVh6Pq1hGbG413KtdBp
	xqQ7Xq5dfHr+x75JMle7YazfepaUT7IWhADzFnI8ojEMZLcZeQa6ej4qArnc3axZDM=
X-Google-Smtp-Source: AGHT+IEtOVN2W0YuR03zQGZMPIhVn9AdakRcM2UqMT2MIe97eejMIz8URQIG+IPDNeRZs5nvL2mW/CJcIX9MktMnlaM=
X-Received: by 2002:a05:6512:6082:b0:55f:4ae5:8dd2 with SMTP id
 2adb3069b0e04-55f545438dcmr961707e87.55.1756302170247; Wed, 27 Aug 2025
 06:42:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZLmTCh_mn7w6U31B82cBZsmLaj92dxwfK9PVWZeMqk54Q@mail.gmail.com>
 <20250826170314.352122-1-arkadiusz.bokowy@gmail.com> <CABBYNZJ7kbHJ665-rsKQTfP_U=pfBwAPrGki7JSBpF7+wiXung@mail.gmail.com>
In-Reply-To: <CABBYNZJ7kbHJ665-rsKQTfP_U=pfBwAPrGki7JSBpF7+wiXung@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 27 Aug 2025 09:42:38 -0400
X-Gm-Features: Ac12FXx438hvzE4nCebJuLzU7tK5foxTuAa54yC0F2ois3KkHVtvwAb7jb1og0k
Message-ID: <CABBYNZKorYK7MKUr1DsipZOUbkNuecW4WpbVKtjyb5ha5EnrSQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: Check for unexpected bytes when
 defragmenting HCI frames
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arkadiusz,

On Tue, Aug 26, 2025 at 3:31=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Arkadiusz,
>
> On Tue, Aug 26, 2025 at 1:03=E2=80=AFPM Arkadiusz Bokowy
> <arkadiusz.bokowy@gmail.com> wrote:
> >
> > Some Barrot based USB Bluetooth dongles erroneously send one extra
> > random byte for the HCI_OP_READ_LOCAL_EXT_FEATURES command. The
> > consequence of that is that the next HCI transfer is misaligned by one
> > byte causing undefined behavior. In most cases the response event for
> > the next command fails with random error code.
> >
> > Since the HCI_OP_READ_LOCAL_EXT_FEATURES command is used during HCI
> > controller initialization, the initialization fails rendering the USB
> > dongle not usable.
> >
> > > [59.464099] usb 1-1.3: new full-speed USB device number 11 using xhci=
_hcd
> > > [59.561617] usb 1-1.3: New USB device found, idVendor=3D33fa, idProdu=
ct=3D0012, bcdDevice=3D88.91
> > > [59.561642] usb 1-1.3: New USB device strings: Mfr=3D0, Product=3D2, =
SerialNumber=3D0
> > > [59.561656] usb 1-1.3: Product: UGREEN BT6.0 Adapter
> > > [61.720116] Bluetooth: hci1: command 0x1005 tx timeout
> > > [61.720167] Bluetooth: hci1: Opcode 0x1005 failed: -110
> >
> > This patch was tested with the 33fa:0012 device. Now the device is
> > initialized properly:
>
> I'm trying to find any entry with 0x33fa but I couldn't find any, we
> probably want to include the Fixes tag to the commit that introduces
> support for it.

Looks like we are missing:

+       /* Barrot Technology Bluetooth devices */
+       { USB_DEVICE(0x33fa, 0x0010), .driver_info =3D BTUSB_BARROT },
+       { USB_DEVICE(0x33fa, 0x0012), .driver_info =3D BTUSB_BARROT },

We can probably add it together in the same patch, so we don't have to
rely on Fixes to inform the changes below needs to go together, but
then we should include the contents of /sys/kernel/debug/usb/devices
before the information why we need the changes to detect extra bytes
in order for it to work.

> >
> > > [43.329852] usb 1-1.4: new full-speed USB device number 4 using dwc_o=
tg
> > > [43.446790] usb 1-1.4: New USB device found, idVendor=3D33fa, idProdu=
ct=3D0012, bcdDevice=3D88.91
> > > [43.446813] usb 1-1.4: New USB device strings: Mfr=3D0, Product=3D2, =
SerialNumber=3D0
> > > [43.446821] usb 1-1.4: Product: UGREEN BT6.0 Adapter
> > > [43.582024] Bluetooth: hci1: Unexpected continuation: 1 bytes
> > > [43.703025] Bluetooth: hci1: Unexpected continuation: 1 bytes
> > > [43.750141] Bluetooth: MGMT ver 1.23
> >
> > Signed-off-by: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
> > Tested-by: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
> > ---
> >  drivers/bluetooth/btusb.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 8085fabad..24a249d1c 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -1192,6 +1192,18 @@ static int btusb_recv_intr(struct btusb_data *da=
ta, void *buffer, int count)
> >                 }
> >
> >                 if (!hci_skb_expect(skb)) {
> > +                       /* Each chunk should correct to at least 1 or m=
ore
> > +                        * events so if there are still bytes left that=
 doesn't
> > +                        * constitute a new event this is likely a bug =
in the
> > +                        * controller.
> > +                        */
> > +                       if (count && count < HCI_EVENT_HDR_SIZE) {
> > +                               bt_dev_warn(data->hdev,
> > +                                       "Unexpected continuation: %d by=
tes",
> > +                                       count);
> > +                               count =3D 0;
> > +                       }
> > +
> >                         /* Complete frame */
> >                         btusb_recv_event(data, skb);
> >                         skb =3D NULL;
> > --
> > 2.47.2
> >
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
