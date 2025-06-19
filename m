Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AD0374D1
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 20:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750363221; cv=none; b=kE9V+oxeXPwYFroosMvdmOPK6X7zqps7l0b0Ai4nI+O+PPg6v87F+9zOnCYWTJzMqypDqK6U8ljQ8PNFBvf6vO7RrmykDte7/maI2GLjvmRtej2B8VUWzYXfFOoVfF2w//CZqXmGBQH6kP5zoKAs81ZO0/ujHAv0XSQcUsO8Clk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750363221; c=relaxed/simple;
	bh=vuMJOM2Uf3Wzf4P0gHbgLKOK976lQqbOtDDZXxw9CsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BTHSDebiJauF2G5W0MXCK2wBrgKh68k2i16/CkCWTLpnGwNIHIOLTzGxs9js+SK0WcmiHbW/wf8P55zAY4Uit7Wl37xcCPIc3OuLdMKq4QIdXVz/J7T99uBz85j+Mlxz0ndBcNtrHW2WpcNMdIoV0SVvl2umpV6aIVxG+2vZF6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIsgkLvg; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIsgkLvg"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-32b8134ef6aso11156691fa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 13:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750363217; x=1750968017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfT5Jya6QLalTqCBOcASmRSlI7kZqCvWjaOxbCF2gE8=;
        b=JIsgkLvgk0xQC+BmYXYXmRSgf0GLGWqHmJMMDhzXDNVbRxZwY/jqyEYPuqIZ+6Hf6D
         dm/UGgacj2h8Ne1l9jUr71lj3jJ1PiwXnfYr9JuyT8TdU8+YV5MY+/36x5JNOfnj85vx
         jyclSfGib7KS/el3ht0ruU6pqN/LLLd6Auz1bh7CQHHjRMuBRAaw1Dre/DhwGb8RF7gQ
         bhXTiowYsli9O8rUTohwFcegcQgyZF50dsih4Blg4jFjx9TqjRn3u8DLVKdVVZZABMOG
         uJ6bieHG84wQW6zmebVFEopA2DVbGRlFs4yjPfEEGKtv+hfopwXc2ccVPFYymV+0XHNq
         Xx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750363217; x=1750968017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RfT5Jya6QLalTqCBOcASmRSlI7kZqCvWjaOxbCF2gE8=;
        b=rMYle07huHzAHjXr3Y8fQLP9dCZzg4aSjvNugXxzhkkltU94l31Aj3Et/xY+Ni2idh
         WAKVhbXmMQj2FR+7vuidWJe5Vey25K81UNKg90RqWDC9+Wi9zUA5/u25Zeri40ybKvxZ
         Plu7qVC6r7roeHX5XAD+xoRHnP+EWueQRBCS2qnRCuIuSgliTkyRHI4WD7opLVs0dGEN
         Ypd4BmjZ+xtne4hCAhSSsx6J731KMhycLKbae4pnLnwc6Sd4AlaTX/gBuuo3gEpNuJaR
         0+pUBu3bRpKVOvJF79RSkEnMWac0vdtQUKgyaobT36435Mqck/AzxwIRTYAeHjpALUfy
         know==
X-Gm-Message-State: AOJu0Ywsq0I4FrhhWwVaa3NCbujX3zr38zPGThJE5lD6CTHFZNwquPfX
	N2mqycUozKCcIjfGiZ1n7dkCAlRM8NfW+adxiZ1lzChXJjFmIxFd+9UMNUfbEjR99SdWicZAFD3
	p4U8ZnZaZN5qNcXvmOgfCVVOWjnmfb6zY/mdHktSVtg==
X-Gm-Gg: ASbGncsM/EkJ8IHmVM9iXVnHjJcoSx0UZHV4Zhs4iW8TZCc1GKvt2rwzC22CoB3W2tR
	2vA1Jmr36ukQEPoFnyPD2JoTbCQp0NJSUBK703+uzycWDqDG7jbMzKZvNsN+MiMh8Y4rE4IJ6IL
	VCzHeQS1xo/IyNcrvC4/K0kqlzM65adBYb28llxmyRQw==
X-Google-Smtp-Source: AGHT+IF8L3Ms2ndiCH9qYXrExZ4WBM+xQNgMw1b7Hqa3h9hqWvQOy8gN3rVN7/8PFp/EvFfgIli5eXg110bNX1d/e2Y=
X-Received: by 2002:a05:651c:515:b0:32a:69c7:7b0b with SMTP id
 38308e7fff4ca-32b98ed83afmr565111fa.12.1750363217099; Thu, 19 Jun 2025
 13:00:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABtds-1fKyFYvU1jL9njmhfphU0XytO+F5mBhARAzQip+CK6cA@mail.gmail.com>
In-Reply-To: <CABtds-1fKyFYvU1jL9njmhfphU0XytO+F5mBhARAzQip+CK6cA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 19 Jun 2025 16:00:04 -0400
X-Gm-Features: AX0GCFvV7Ogtl2Rgxxb8b-yqp4r2qF6R9nJQ-1lMJ8DnXHxJQq9GaoUvfutn5eo
Message-ID: <CABBYNZLgWF7m0Lwc+C848-0qgBZfV30F7SE0YcKJCPLV5KbG-Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Revert vendor-specific ISO classification for
To: Sean Rhodes <sean@starlabs.systems>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sean,

On Thu, Jun 19, 2025 at 3:12=E2=80=AFPM Sean Rhodes <sean@starlabs.systems>=
 wrote:
>
> From 3b5497d0154a58d948ee95900e4c62704399de0a Mon Sep 17 00:00:00 2001
> From: Sean Rhodes <sean@starlabs.systems>
> Date: Wed, 2 Apr 2025 09:05:17 +0100
> Subject: [PATCH] Bluetooth: Revert vendor-specific ISO classification for
>  non-offload cards
>
> This reverts commit f25b7fd36cc3a850e006aed686f5bbecd200de1b.
>
> The commit introduces vendor-specific classification of ISO data,
> but breaks Bluetooth functionality on certain Intel cards that do
> not support audio offload, such as the 9462. Affected devices are
> unable to discover new Bluetooth peripherals, and previously paired
> devices fail to reconnect.

How it breaks? It doesn't seem there is anything regarding the
reclassification of the packets that could affect something that
doesn't support ISO packets, well except if it happens that older
controllers use the handle range of ISO but btintel_classify_pkt_type
shouldn't be set for them.

> This issue does not affect newer cards (e.g., AX201+) that support
> audio offload. A conditional check using AOLD() could be used in
> the future to reintroduce this behavior only on supported hardware.
>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Cc: Ying Hsu <yinghsu@chromium.org>
> Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: linux-bluetooth@vger.kernel.org
> Signed-off-by: Sean Rhodes <sean@starlabs.systems>
> ---
>  drivers/bluetooth/btintel.c      |  7 ++-----
>  include/net/bluetooth/hci_core.h |  1 -
>  net/bluetooth/hci_core.c         | 16 ----------------
>  3 files changed, 2 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 55cc1652bfe4..1a5108cf6517 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -3582,15 +3582,12 @@ static int btintel_setup_combined(struct hci_dev =
*hdev)
>                 err =3D btintel_bootloader_setup(hdev, &ver);
>                 btintel_register_devcoredump_support(hdev);
>                 break;
> -       case 0x18: /* GfP2 */
> -       case 0x1c: /* GaP */
> -               /* Re-classify packet type for controllers with LE audio =
*/
> -               hdev->classify_pkt_type =3D btintel_classify_pkt_type;
> -               fallthrough;

9462 seem to be JfP (0x11), so the above code shouldn't even be used for it=
.

>         case 0x17:
> +       case 0x18:
>         case 0x19:
>         case 0x1b:
>         case 0x1d:
> +       case 0x1c:
>         case 0x1e:
>         case 0x1f:
>                 /* Display version information of TLV type */
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 2b261e74e2c4..648ee7e2403f 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -649,7 +649,6 @@ struct hci_dev {
>         int (*get_codec_config_data)(struct hci_dev *hdev, __u8 type,
>                                      struct bt_codec *codec, __u8 *vnd_le=
n,
>                                      __u8 **vnd_data);
> -       u8 (*classify_pkt_type)(struct hci_dev *hdev, struct sk_buff *skb=
);
>  };
>
>  #define HCI_PHY_HANDLE(handle) (handle & 0xff)
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 3b49828160b7..64ab7702be81 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2868,31 +2868,15 @@ int hci_reset_dev(struct hci_dev *hdev)
>  }
>  EXPORT_SYMBOL(hci_reset_dev);
>
> -static u8 hci_dev_classify_pkt_type(struct hci_dev *hdev, struct sk_buff=
 *skb)
> -{
> -       if (hdev->classify_pkt_type)
> -               return hdev->classify_pkt_type(hdev, skb);
> -
> -       return hci_skb_pkt_type(skb);
> -}
> -
>  /* Receive frame from HCI drivers */
>  int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
>  {
> -       u8 dev_pkt_type;
> -
>         if (!hdev || (!test_bit(HCI_UP, &hdev->flags)
>                       && !test_bit(HCI_INIT, &hdev->flags))) {
>                 kfree_skb(skb);
>                 return -ENXIO;
>         }
>
> -       /* Check if the driver agree with packet type classification */
> -       dev_pkt_type =3D hci_dev_classify_pkt_type(hdev, skb);
> -       if (hci_skb_pkt_type(skb) !=3D dev_pkt_type) {
> -               hci_skb_pkt_type(skb) =3D dev_pkt_type;
> -       }

This will affect all cards, not just the one you are claiming.


>         switch (hci_skb_pkt_type(skb)) {
>         case HCI_EVENT_PKT:
>                 break;
> --
> 2.48.1
>


--
Luiz Augusto von Dentz
