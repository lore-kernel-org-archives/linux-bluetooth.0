Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9078143AAB;
	Wed, 22 May 2024 14:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716387073; cv=none; b=VRMEYTnb4Nz2/px88qandXprt2mj8o5iI1YNzxBsAbpvX00/7P+pOHcKqRVNi79UOnw/4ScD7/ZztivgavUQs+W36EGBdHdKN6G0PSVAlrxtW/vNDOzDwJBIdaT24WaXejlIQ4oqjZnzeddP3+DwfZk/Rm+GXnSEdzR26pMDcYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716387073; c=relaxed/simple;
	bh=xUHnB59YZBJ+MtRkgCTRpWxOQ85///HxM3Bwhhiw2Xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tqAj1hplX5jUgudG5C3EHwA/A3k4jK1vobjLgu4z3FyQXeOzlMrD2aWz5JUpcdRWm09cewNdS8jvnHd94qh7cuslP2AoV7/+NhnpLTXtL8GXSDrWrnmMfkho8uV3uHS9ymuVLpv0fX0vgPWjBqocQA/iEdPXupql0+QAi0MTAIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMsPLKLb; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMsPLKLb"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e1d6166521so7715451fa.1;
        Wed, 22 May 2024 07:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716387070; x=1716991870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZ3yTU/lh4Hxqjx0yA+60n7D2aZddfwNxcfrlB1P2kI=;
        b=jMsPLKLbYYlAEj8rTxPu+cQhqpj8C5zZgisu+GXl6LHc9w+UFBHEGie3xLnnnjik2V
         rjykKEIOBPtjCEEkcMqE1jKlOB4IjDXNHuhDeUbDxfND6XD1YW4YhPV5iOblTtOjzvC7
         uwFiiTGvwLxD4wSZQOYMqXFe9LcDQolZjsjxGyeYdwE1pj28XoVjkqGJst9R6O31JXE2
         XIXNOjWb0v+x/xybfsjKYBfPUU5umKkuMGClKPM2JK7QsiXbAOHo2PbfXIvrj9lim5eS
         qxvEYqOeUx8u+A8jX1n1qlP5Z1JRewxovITlq+SbJblzYjOq/fZGtSfxpTNAGI2XtXny
         4OEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716387070; x=1716991870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZ3yTU/lh4Hxqjx0yA+60n7D2aZddfwNxcfrlB1P2kI=;
        b=iWz3zQqw8UM/QIEBRcQDShD3a55S6Qr0tWelCav20twqz3U1/hSJDVoUfj2qWgQxqw
         lAWqayazRhVRL9+LXXhYCu0dNyMzbJsRqh+Oa7cq/nbNqhVHpL6AjKDMDu8kNXBXQXzW
         KUMBvCyn6xaEevv08I5eox4eFJU+IncICozNeEKswcKXpt7d/Andp3znRJFfbMxucEED
         Nsp2PAQRiq/n0vjvYpyZV4Jj9IkHdajgLyQsxcd8iCf0hIW1M10VfgcY4DaYavRodN/E
         n6Cy9rPoAOyqzKMKAQbN8GPoVIYHCP2PLKnEHfrs85EsgZVPmHBDdaombMR+jyPQWhz2
         Rrpg==
X-Forwarded-Encrypted: i=1; AJvYcCXNc/yjHBSG/wMg8gFuRZQmozjAsntMB3B6jfx+QLHDQ5mKIHo8QGur5rxH2JYXMNZ3pjcrt6PAcHhFjnutaK7yM7Se9FyfG0HzH3Xk
X-Gm-Message-State: AOJu0YwSK4gIzE350pG8zPIq1swBabCBMpDdDtCRSfSKc5X3UVM5VjeL
	PxjZuRKLcgCipDiPRV12lbcis0mXI+1Z1FfBQciHrGkJ3PlQ4ZpLDVIyrExoAXWv22nPxa5wkBJ
	VTI3ntI9HsNMh0NQvzCI6pz8FQrYmTc6y
X-Google-Smtp-Source: AGHT+IG6rYAdN/Dcb5tmOBO2GnL/OSrUDYNrm7e/ToFfTiZGx5keAMXIy363sCxf0105kyjWtZT+X7MkmruJvWRD4rE=
X-Received: by 2002:a2e:a30a:0:b0:2e8:44f4:fd0b with SMTP id
 38308e7fff4ca-2e844f5017bmr13023841fa.8.1716387069468; Wed, 22 May 2024
 07:11:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522111139.2612601-1-yinghsu@chromium.org>
In-Reply-To: <20240522111139.2612601-1-yinghsu@chromium.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 22 May 2024 10:10:57 -0400
Message-ID: <CABBYNZKwKLDFtuOLzxdTJj7wxfAJyS4PL_ZWf2h3+ALwC82hsw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: vendor specific ISO data packet identification
 by handle
To: Ying Hsu <yinghsu@chromium.org>
Cc: linux-bluetooth@vger.kernel.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ying,

On Wed, May 22, 2024 at 7:11=E2=80=AFAM Ying Hsu <yinghsu@chromium.org> wro=
te:
>
> When HCI raw sockets are opened, the Bluetooth kernel module doesn't
> track CIS/BIS connections. User-space applications have to identify
> ISO data by maintaining connection information and look up the mapping
> for each ACL data packet received. Besides, btsnoop log catpured in
> kernel would couldn't tell ISO data from ACL data in this case.
>
> By differentiating ISO data from ACL data earlier in btusb, we can
> eliminate unnecessary lookups and improve btsnoop log clarity.
> This patch enables vendor-specific differentiation between ISO and
> ACL data packets.
>
> Signed-off-by: Ying Hsu <yinghsu@chromium.org>
> ---
> Tested LE unicast recording on a ChromeOS device with Intel AX211
>
>  drivers/bluetooth/btusb.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 79aefdb3324d..543961b6c671 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -889,6 +889,8 @@ struct btusb_data {
>         int (*recv_acl)(struct hci_dev *hdev, struct sk_buff *skb);
>         int (*recv_bulk)(struct btusb_data *data, void *buffer, int count=
);
>
> +       int (*is_iso_data_pkt)(struct sk_buff *skb);

I'd had this sort of callback in hdev itself so the stack can consult
the driver about packet types at any stage, see bellow.

> +
>         int (*setup_on_usb)(struct hci_dev *hdev);
>
>         int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
> @@ -1229,6 +1231,8 @@ static int btusb_recv_bulk(struct btusb_data *data,=
 void *buffer, int count)
>
>                 if (!hci_skb_expect(skb)) {
>                         /* Complete frame */
> +                       if (data->is_iso_data_pkt && data->is_iso_data_pk=
t(skb))
> +                               hci_skb_pkt_type(skb) =3D HCI_ISODATA_PKT=
;

Id keep a single point in the stack doing the reclassification of the
packets, which should probably be in hci_recv_frame, Id suggesting
doing something like:

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b3ee9ff17624..505ef0b58f8c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2941,6 +2941,14 @@ int hci_reset_dev(struct hci_dev *hdev)
 }
 EXPORT_SYMBOL(hci_reset_dev);

+static u8 hci_pkt_type(struct hic_dev *dev, struct sk_buff *skb)
+{
+       if (hdev->pkt_type)
+               return hdev->pkt_type(dev, skb);
+
+       return hci_skb_pkt_type(skb);
+}
+
 /* Receive frame from HCI drivers */
 int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
@@ -2950,6 +2958,10 @@ int hci_recv_frame(struct hci_dev *hdev, struct
sk_buff *skb)
                return -ENXIO;
        }

+       /* Check if the driver agree with packet type classification */
+       if (hci_skb_pkt_type(skb) !=3D hci_pkt_type(skb))
+               hci_skb_pkt_type(skb) =3D hci_pkt_type(skb);
+
        switch (hci_skb_pkt_type(skb)) {
        case HCI_EVENT_PKT:
                break;


>                         btusb_recv_acl(data, skb);
>                         skb =3D NULL;
>                 }
> @@ -2539,6 +2543,13 @@ static int btusb_recv_bulk_intel(struct btusb_data=
 *data, void *buffer,
>         return btusb_recv_bulk(data, buffer, count);
>  }
>
> +static int btusb_is_iso_data_pkt_intel(struct sk_buff *skb)
> +{
> +       __u16 handle =3D (__le16_to_cpu(hci_acl_hdr(skb)->handle) & 0xfff=
);
> +
> +       return (handle >=3D 0x900);
> +}
> +
>  static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *=
skb)
>  {
>         struct urb *urb;
> @@ -4361,6 +4372,9 @@ static int btusb_probe(struct usb_interface *intf,
>                 /* Override the rx handlers */
>                 data->recv_event =3D btintel_recv_event;
>                 data->recv_bulk =3D btusb_recv_bulk_intel;
> +
> +               /* Override for ISO data packet*/
> +               data->is_iso_data_pkt =3D btusb_is_iso_data_pkt_intel;
>         } else if (id->driver_info & BTUSB_REALTEK) {
>                 /* Allocate extra space for Realtek device */
>                 priv_size +=3D sizeof(struct btrealtek_data);
> --
> 2.45.1.288.g0e0cd299f1-goog
>


--=20
Luiz Augusto von Dentz
