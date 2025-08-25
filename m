Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C41A267B02
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 18:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756146738; cv=none; b=bsbcK0qJng7TFTiJ5/hAIilomOORtb0HFLs1UXP8+GgObjkcgKCwO4X+aXaAOvcsZDHzxkIkJQd6oU2vwWUtZH52h7TGohCNz4GyISqaeq4SMWsW1K5ILVx9BsAJq9O1sg/MvCNzDOy4rULFwxlNHA7n8SsT4nTNVVjfQz2Au5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756146738; c=relaxed/simple;
	bh=1tg8l6+khk7nLfpBc8svcbaYdM78T0diWvudBuDD4Z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gi3Vck64yBfsi6PwZ4jR1V/GanBgd4gYWgu8y/p3PTLCO8Nns0tJPPRUCrxYecm5VLlaDarRHIxe6hf1BdDwFParF1Eom+iWbh/gbgQCeGhMn428dw8LKrgKnzS7Dg/5bBrBTVVJP4PZDIFYWXtDf5N/b1k6+xDr9qUcYJwuc9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITeOuApq; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITeOuApq"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3367f35d11aso6818771fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 11:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756146734; x=1756751534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvdp4JqGysaLrKcj3oNCIDf7jqI3nCJz968KqZoTuW8=;
        b=ITeOuApqmB2z0gdEeiUBVcHxFl7xC6snk3zVI6313kiavumceJx4VQNtho/AAWeL3B
         a+XVxxIRWE3ZmH0gO9WpDAmO+zYpFXQZ5JVRTnB/6lbcU2FR/m3wnWLs8aL2VdhXuAmG
         EPqdw84wQJEcqnju+obdkhsdSy8KtoHn+TZqNlIgI0y8Cxu3d1FuKdV0FPpUyKt5sI7A
         zfDFeT5H2k3uoPryjSBoy78J0LjD2r4ND5vQr0vB5AMp4llK6Ady6GQt+9orjBrIW+5B
         hMUPHmeseZnLslH5A3kXB64MxoT0AKQObSa4h+L/wWkJUCPCakpc3FYnyj50jqPi+y/x
         n7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756146734; x=1756751534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yvdp4JqGysaLrKcj3oNCIDf7jqI3nCJz968KqZoTuW8=;
        b=CFcZ8eR5tXsP+VW2reawE2f8Qn4I+VyCgitbv99vh2J1hfejeU2G3Ylb7NN3atW69f
         aZcXHMK2dJ6jgCut7MirJWxOvfINAqrrRLOd2mf/vycSoAqLI3059ioB0qeJ2rMRrJ3c
         yd0iWbHQTCC1QuPbmEnoG0d3rwzJP+dOwkl8EiFbyYTpgPUFuHi1+LMUpcc/c1lyOpPa
         DtRqWrdueNVsrWn1EJRlpH7/RjOaqoaK5oZ6Ajkmv3ReshPOaMnqnLy3m8kKgz04cLLU
         dVt74V3oms4eLFCbn46kXNSevhgbGNLUesoATh4Iz1StR4+yljW8h0/8LWgwCdRtEfwW
         0HMA==
X-Gm-Message-State: AOJu0Yy0DTGQvlLkkhq6wkc1lGuvoCYdCkkUcUYvWAIz97KdqtWSJOxm
	TKOaY0OROBhfJN70un2ZKfqK0g4aiZPbeg51qWyppeYW5ZKSFPTFv0SZQm0W61vUStTX2tzUMMB
	xrda1ziGQJJ6v2Zy3YcQNX8y5i5FdjEEZ+GXpex0=
X-Gm-Gg: ASbGnctY0I5RAJHyFjPfAA/HBBnat9jG1kTDal9/dZxeQgFGzgivqfNPOu/1AgZ5n1g
	V5g6WtqX/z8VCEhntJ+OioWShUvDYefb523kjpQ5MNHAfqV4tA341cBw/v1ckeT3q6h6hmolgdX
	v/6WiuC5KEQlaBkhluHZQcydnddOsT65M6oFMaBzMWEq2kUNCw1j1YPakpee3m8gVmIayiG0v9j
	PZ4RTrU0KAREVvoJZpm4cjVlMcdTAXZolHjJMuiUE2d+4aLxURV39V4
X-Google-Smtp-Source: AGHT+IGMq9Tkr6cwUVUeTvCVRpFeXBOiGlYzOIAqiYbG1q6TYMcLImO7YtgfZWbztG+5GMU2nNJPMzYL2wXVZpB0XcA=
X-Received: by 2002:a2e:be0d:0:b0:332:2c2a:63bf with SMTP id
 38308e7fff4ca-33650feee6bmr36573951fa.20.1756146733736; Mon, 25 Aug 2025
 11:32:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825172504.339117-1-arkadiusz.bokowy@gmail.com>
In-Reply-To: <20250825172504.339117-1-arkadiusz.bokowy@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 25 Aug 2025 14:32:01 -0400
X-Gm-Features: Ac12FXyJOjWwz46rMVlS_m0WTFxXwdZbJrb085iMcLWABVLQSW4mtDbo3rfT1c8
Message-ID: <CABBYNZKazQ0zROk1+gs5=U+zaZDwkMmD01MTYLuMZ3VUaoZZQg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Fixup quirk for reading ext features on
 some Barrot controllers
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arkadiusz,

On Mon, Aug 25, 2025 at 1:25=E2=80=AFPM Arkadiusz Bokowy
<arkadiusz.bokowy@gmail.com> wrote:
>
> Apparently, some Barrot based USB Bluetooth dongles erroneously sent one
> extra random byte for the HCI_OP_READ_LOCAL_EXT_FEATURES command. The
> consequence of that is that the next HCI transfer is misaligned by one
> byte causing undefined behavior. In most cases the response event for the
> next command fails with random error code.
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
> This patch was not tested with the 33fa:0010 device, however, Internet
> search suggest that the cause for the issue with this particular device
> is exactly the same, e.g.: https://github.com/bluez/bluez/issues/1326

This issue above seem to be something different though, it looks like
there is some fragmentation of the response but then in the meantime
we send another command (HCI_OP_READ_BUFFER_SIZE 0x1005) and that
times out, so the description and the code changes don't really seem
to match.

> Signed-off-by: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
> ---
>  drivers/bluetooth/btusb.c   | 30 ++++++++++++++++++++++++++++++
>  include/net/bluetooth/hci.h |  9 +++++++++
>  2 files changed, 39 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 8085fabad..b89efe482 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -66,6 +66,7 @@ static struct usb_driver btusb_driver;
>  #define BTUSB_INTEL_BROKEN_INITIAL_NCMD BIT(25)
>  #define BTUSB_INTEL_NO_WBS_SUPPORT     BIT(26)
>  #define BTUSB_ACTIONS_SEMI             BIT(27)
> +#define BTUSB_BARROT                   BIT(28)
>
>  static const struct usb_device_id btusb_table[] =3D {
>         /* Generic Bluetooth USB device */
> @@ -810,6 +811,10 @@ static const struct usb_device_id quirks_table[] =3D=
 {
>         { USB_DEVICE(0x0cb5, 0xc547), .driver_info =3D BTUSB_REALTEK |
>                                                      BTUSB_WIDEBAND_SPEEC=
H },
>
> +       /* Barrot Technology Bluetooth devices */
> +       { USB_DEVICE(0x33fa, 0x0010), .driver_info =3D BTUSB_BARROT },
> +       { USB_DEVICE(0x33fa, 0x0012), .driver_info =3D BTUSB_BARROT },
> +
>         /* Actions Semiconductor ATS2851 based devices */
>         { USB_DEVICE(0x10d7, 0xb012), .driver_info =3D BTUSB_ACTIONS_SEMI=
 },
>
> @@ -1120,6 +1125,21 @@ static void btusb_qca_reset(struct hci_dev *hdev)
>         btusb_reset(hdev);
>  }
>
> +static int btusb_barrot_urb_quirk(struct btusb_data *data, struct sk_buf=
f *skb)
> +{
> +       struct hci_dev *hdev =3D data->hdev;
> +       struct hci_ev_cmd_complete *ev;
> +
> +       if (hci_test_quirk(hdev, HCI_QUIRK_FIXUP_LOCAL_EXT_FEATURES_URB_B=
UFFER) &&
> +           hci_event_hdr(skb)->evt =3D=3D HCI_EV_CMD_COMPLETE) {
> +               ev =3D (struct hci_ev_cmd_complete *)(hci_event_hdr(skb) =
+ 1);
> +               if (__le16_to_cpu(ev->opcode) =3D=3D HCI_OP_READ_LOCAL_EX=
T_FEATURES)
> +                       return 1;
> +       }
> +
> +       return 0;
> +}
> +
>  static inline void btusb_free_frags(struct btusb_data *data)
>  {
>         unsigned long flags;
> @@ -1192,6 +1212,13 @@ static int btusb_recv_intr(struct btusb_data *data=
, void *buffer, int count)
>                 }
>
>                 if (!hci_skb_expect(skb)) {
> +                       /* Discard one extra byte sent by some Barrot USB
> +                        * controllers. Otherwise, the rest of the transf=
er
> +                        * will be misaligned by one byte.
> +                        */
> +                       if (btusb_barrot_urb_quirk(data, skb) && count =
=3D=3D 1)
> +                               count =3D 0;
> +
>                         /* Complete frame */
>                         btusb_recv_event(data, skb);
>                         skb =3D NULL;
> @@ -4218,6 +4245,9 @@ static int btusb_probe(struct usb_interface *intf,
>                 hci_set_quirk(hdev, HCI_QUIRK_BROKEN_WRITE_AUTH_PAYLOAD_T=
IMEOUT);
>         }
>
> +       if (id->driver_info & BTUSB_BARROT)
> +               hci_set_quirk(hdev, HCI_QUIRK_FIXUP_LOCAL_EXT_FEATURES_UR=
B_BUFFER);
> +
>         if (!reset)
>                 hci_set_quirk(hdev, HCI_QUIRK_RESET_ON_CLOSE);
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index df1847b74..ec9b47a39 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -351,6 +351,15 @@ enum {
>          */
>         HCI_QUIRK_BROKEN_READ_ENC_KEY_SIZE,
>
> +       /*
> +        * When this quirk is set, the URB buffer with response event for=
 the
> +        * HCI_OP_READ_LOCAL_EXT_FEATURES command needs to be trimmed by =
one byte.
> +        * This is required for some Barrot controllers which erroneously=
 transfer
> +        * an extra random byte at the end of the buffer which misaligns =
the rest
> +        * of the HCI communication.
> +        */
> +       HCI_QUIRK_FIXUP_LOCAL_EXT_FEATURES_URB_BUFFER,
> +
>         /*
>          * When this quirk is set, the reserved bits of Primary/Secondary=
_PHY
>          * inside the LE Extended Advertising Report events are discarded=
.
> --
> 2.47.2
>
>


--=20
Luiz Augusto von Dentz
