Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184EA1632E6;
	Mon,  2 Dec 2024 21:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733174584; cv=none; b=TYclGskI8Brw7mBQAQ+bgJuzy7r8jJDAhNPVhCcgfq8B3fudt1HAsxd9gOXmqbcyWAPaywchXYLHh5AAt41RraaF6yiRarSKsj4NXUNdAD1eToWdkitQgkEB2l3Qek8LybwBIcfvWhn1CDZ8v6nvLZDcgxHsHZiljzIYxiwB9Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733174584; c=relaxed/simple;
	bh=3rmFg6PZW6kqnmFrTfxP6UwcVV36TjAW+XbvD8WSOPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WI2vVwdhhDhgDjJUDqSXgtOxenpAxlb4EwdhRjzbD3T75/+d2f7kbGdsHGt8EkrsR/jiW83A9jvcu4qmqlVxwt37kle9XuYDgUTdCvdIGOWoRSDvQLgbIixCggfNyeAia/wLDs9JtNjTcn7GVk7xn/r5G8WrVGHGy6XcfFdoC2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=megTdNhC; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="megTdNhC"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ffc380b1d0so47651691fa.0;
        Mon, 02 Dec 2024 13:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733174580; x=1733779380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lqScwOfThaFILBFPk/MwoWHPTdynQ5MJxyYSKQFDis=;
        b=megTdNhCfnIi9bR27e+M+YSb7SC7F6Z4Xm44ec9m8Y1wh9rAtASKbv5RY/uBMeGp+z
         M/8cGmBSmmzPr4OrAd0YCQ3P7Y3/RyKQrNCGPa/fDuDCLWc/xrrMlnrKMS2hTb9U/5fa
         qID6Poep2Z/0KmbcrBRDNW2C11M8F9J5pFQtNcTkiw2z+EYGqKipYMWhRUm9RHMudWZc
         ZnGBo1FPPevdQIU4wvPNHEgKVVahws61MuDUsX90AbLdfAFrOLbXqCvSFyDdKAmFrLbD
         GurrhGIGrNQaFrI/AJyWriGQwq2j5+PMitxw5e+1djKU7kpyKc7QlvrqyRcDqSENR7yy
         68SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733174580; x=1733779380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5lqScwOfThaFILBFPk/MwoWHPTdynQ5MJxyYSKQFDis=;
        b=XzUFGi6DUXqbV1q246dNtQ6EKLXqeJFXJyspy4HJJxJu/jDLVhvTbTArUylZVYUqh8
         9nb4tF037mO4Kswz4R8NMIJEbFglrUU7bbYbdH35LRV+IkFMo+Y7lVwMoBvFBnsJeiRh
         5a6OdK9ssgTWs1lpC8GGHyrwclHLPig8fPPIy90rsTpMdz8TCff9myLI4Y0qgk4gUT5M
         l8ngfBPNqs5hYiDEJPrnYcvDSADqaLVI+IRd2NVKcWfuctrzChQScgJn3to4btJcFBHu
         +37O8rDKqmV64IcRXhVrFBhQOC+23eM7FSzhpiVfiNj49oJAtG6lNFy+zHzQ/ygx6VTM
         8+PA==
X-Forwarded-Encrypted: i=1; AJvYcCVhTdB5t5rX0b3Qc3giERQT1Abp3/B2KPs4pjesx/rD6s315ws0RrqQRSfcAs1+jjbeKoceUjAQimJP4Zdn@vger.kernel.org, AJvYcCWs6Fgf65ftNWwIWFoGK+qPX3syOb2HnHRis1yqskle6gfiYtpR1KskAHBI0qKp3q06p3NUGcXTsMEgVxBVqMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/7oopoZYpnj2jFC/2xtkfrY1spRn4HkmOjjp9PrQw9ybk0346
	u8of4jfyw+ffG6ksNDCbpx7gm6QWNBaE5KwQMgOyUtuWFTaNCeRcaKZ+UclsbZiLLFivs5d0DlZ
	UEtQ6nPZShgSJProwLv/BhNehwXk=
X-Gm-Gg: ASbGncsd8lI/A9R0jURzXO3nxK9F/yp8cdTMN/0sPRv7dqlgigzkO1zhcTrdOYt9aqz
	KArSqQqPJrYmOY1T5uUEVMyM7EnXV8A==
X-Google-Smtp-Source: AGHT+IHfLs7s1mzXm7cD7Ju2tGS9gxvNolF5sraROWQx/8YgksgRKGgc48C7d+BXtfsPkZJ+G/zoEKuhNNjJxtMixtg=
X-Received: by 2002:a05:651c:2220:b0:2ff:d728:bbc1 with SMTP id
 38308e7fff4ca-2ffde1f3281mr67554791fa.5.1733174579877; Mon, 02 Dec 2024
 13:22:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202023041.492547-1-en-wei.wu@canonical.com>
In-Reply-To: <20241202023041.492547-1-en-wei.wu@canonical.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 2 Dec 2024 16:22:47 -0500
Message-ID: <CABBYNZLBGSKp_ew1Zk5YXrpsdue4aHObfavNcQQ8KOCymt7Eww@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: avoid NULL pointer dereference in skb_dequeue()
To: En-Wei Wu <en-wei.wu@canonical.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pmenzel@molgen.mpg.de, quic_tjiang@quicinc.com, 
	kuan-ying.lee@canonical.com, anthony.wong@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi En-Wei,

On Sun, Dec 1, 2024 at 9:30=E2=80=AFPM En-Wei Wu <en-wei.wu@canonical.com> =
wrote:
>
> The WCN7851 (0489:e0f3) Bluetooth controller supports firmware crash dump
> collection through devcoredump. During this process, the crash dump data
> is queued to a dump queue as skb for further processing.
>
> A NULL pointer dereference occurs in skb_dequeue() when processing the
> dump queue due to improper return value handling:
>
> [ 93.672166] Bluetooth: hci0: ACL memdump size(589824)
>
> [ 93.672475] BUG: kernel NULL pointer dereference, address: 0000000000000=
008
> [ 93.672517] Workqueue: hci0 hci_devcd_rx [bluetooth]
> [ 93.672598] RIP: 0010:skb_dequeue+0x50/0x80
>
> The issue stems from handle_dump_pkt_qca() returning the wrong value on
> success. It currently returns the value from hci_devcd_init() (0 on
> success), but callers expect > 0 to indicate successful dump handling.
> This causes hci_recv_frame() to free the skb while it's still queued for
> dump processing, leading to the NULL pointer dereference when
> hci_devcd_rx() tries to dequeue it.
>
> Fix this by:
>
> 1. Extracting dump packet detection into new is_dump_pkt_qca() function
> 2. Making handle_dump_pkt_qca() return 0 on success and negative errno
>    on failure, consistent with other kernel interfaces
>
> This prevents premature skb freeing by ensuring proper handling of
> dump packets.
>
> Fixes: 20981ce2d5a5 ("Bluetooth: btusb: Add WCN6855 devcoredump support")
> Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
> ---
> changes in v2:
> - Fix typo in the title
> - Re-flow a line in the commit message to fit 72 characters
> - Add a blank line before btusb_recv_acl_qca()
>
> drivers/bluetooth/btusb.c | 76 ++++++++++++++++++++++++---------------
>  1 file changed, 48 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 279fe6c115fa..741be218610e 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2930,22 +2930,16 @@ static void btusb_coredump_qca(struct hci_dev *hd=
ev)
>                 bt_dev_err(hdev, "%s: triggle crash failed (%d)", __func_=
_, err);
>  }
>
> -/*
> - * =3D=3D0: not a dump pkt.
> - * < 0: fails to handle a dump pkt
> - * > 0: otherwise.
> - */
> +/* Return: 0 on success, negative errno on failure. */
>  static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb=
)
>  {
> -       int ret =3D 1;
> +       int ret =3D 0;
>         u8 pkt_type;
>         u8 *sk_ptr;
>         unsigned int sk_len;
>         u16 seqno;
>         u32 dump_size;
>
> -       struct hci_event_hdr *event_hdr;
> -       struct hci_acl_hdr *acl_hdr;
>         struct qca_dump_hdr *dump_hdr;
>         struct btusb_data *btdata =3D hci_get_drvdata(hdev);
>         struct usb_device *udev =3D btdata->udev;
> @@ -2955,30 +2949,14 @@ static int handle_dump_pkt_qca(struct hci_dev *hd=
ev, struct sk_buff *skb)
>         sk_len =3D skb->len;
>
>         if (pkt_type =3D=3D HCI_ACLDATA_PKT) {
> -               acl_hdr =3D hci_acl_hdr(skb);
> -               if (le16_to_cpu(acl_hdr->handle) !=3D QCA_MEMDUMP_ACL_HAN=
DLE)
> -                       return 0;
>                 sk_ptr +=3D HCI_ACL_HDR_SIZE;
>                 sk_len -=3D HCI_ACL_HDR_SIZE;

I know this is in the original code, but this is totally unsafe, we
can't go accessing the skb->data pointer without validating it has
this size, not to mention it is a little odd, to say the least, to
encode a dump event into a an ACL data packet, but then again it was
in the original code so I assume the firmware really does weird things
like this.

Anyway if we know for sure this is a dump packet it shall be possible
to use the likes of skb_pull_data and stop doing unsafe access like
this.

> -               event_hdr =3D (struct hci_event_hdr *)sk_ptr;
> -       } else {
> -               event_hdr =3D hci_event_hdr(skb);
>         }
>
> -       if ((event_hdr->evt !=3D HCI_VENDOR_PKT)
> -               || (event_hdr->plen !=3D (sk_len - HCI_EVENT_HDR_SIZE)))
> -               return 0;
> -
>         sk_ptr +=3D HCI_EVENT_HDR_SIZE;
>         sk_len -=3D HCI_EVENT_HDR_SIZE;

Ditto, just use skb_pull_data.

>         dump_hdr =3D (struct qca_dump_hdr *)sk_ptr;
> -       if ((sk_len < offsetof(struct qca_dump_hdr, data))
> -               || (dump_hdr->vse_class !=3D QCA_MEMDUMP_VSE_CLASS)
> -           || (dump_hdr->msg_type !=3D QCA_MEMDUMP_MSG_TYPE))
> -               return 0;
> -
> -       /*it is dump pkt now*/
>         seqno =3D le16_to_cpu(dump_hdr->seqno);
>         if (seqno =3D=3D 0) {
>                 set_bit(BTUSB_HW_SSR_ACTIVE, &btdata->flags);
> @@ -3052,17 +3030,59 @@ static int handle_dump_pkt_qca(struct hci_dev *hd=
ev, struct sk_buff *skb)
>         return ret;
>  }
>
> +/* Return: true if packet is a dump packet, false otherwise. */
> +static bool is_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +       u8 pkt_type;
> +       u8 *sk_ptr;
> +       unsigned int sk_len;
> +
> +       struct hci_event_hdr *event_hdr;
> +       struct hci_acl_hdr *acl_hdr;
> +       struct qca_dump_hdr *dump_hdr;
> +
> +       pkt_type =3D hci_skb_pkt_type(skb);
> +       sk_ptr =3D skb->data;
> +       sk_len =3D skb->len;
> +
> +       if (pkt_type =3D=3D HCI_ACLDATA_PKT) {
> +               acl_hdr =3D hci_acl_hdr(skb);
> +               if (le16_to_cpu(acl_hdr->handle) !=3D QCA_MEMDUMP_ACL_HAN=
DLE)
> +                       return false;
> +               sk_ptr +=3D HCI_ACL_HDR_SIZE;
> +               sk_len -=3D HCI_ACL_HDR_SIZE;
> +               event_hdr =3D (struct hci_event_hdr *)sk_ptr;

At this point we can actually use skb_pull_data as well since I don't
think the stack is supposed to process data packets with
QCA_MEMDUMP_ACL_HANDLE as handle.

> +       } else {
> +               event_hdr =3D hci_event_hdr(skb);
> +       }
> +
> +       if ((event_hdr->evt !=3D HCI_VENDOR_PKT)
> +               || (event_hdr->plen !=3D (sk_len - HCI_EVENT_HDR_SIZE)))
> +               return false;
> +
> +       sk_ptr +=3D HCI_EVENT_HDR_SIZE;
> +       sk_len -=3D HCI_EVENT_HDR_SIZE;

Unsafe access, sk_len might loop around as well.

> +       dump_hdr =3D (struct qca_dump_hdr *)sk_ptr;
> +       if ((sk_len < offsetof(struct qca_dump_hdr, data))
> +               || (dump_hdr->vse_class !=3D QCA_MEMDUMP_VSE_CLASS)
> +           || (dump_hdr->msg_type !=3D QCA_MEMDUMP_MSG_TYPE))
> +               return false;
> +
> +       return true;

This should probably be places in a qca specific portion, also this is
not very efficient, so I wonder if we should have some means for
driver to register handles for its vendor events like this, so driver
don't have to go pick the packet appart to detect that it is not
really meant for the Bluetooth stack to process.

> +}
> +
>  static int btusb_recv_acl_qca(struct hci_dev *hdev, struct sk_buff *skb)
>  {
> -       if (handle_dump_pkt_qca(hdev, skb))
> -               return 0;
> +       if (is_dump_pkt_qca(hdev, skb))
> +               return handle_dump_pkt_qca(hdev, skb);

This should be something like btqca_recv_acl, etc.

>         return hci_recv_frame(hdev, skb);
>  }
>
>  static int btusb_recv_evt_qca(struct hci_dev *hdev, struct sk_buff *skb)
>  {
> -       if (handle_dump_pkt_qca(hdev, skb))
> -               return 0;
> +       if (is_dump_pkt_qca(hdev, skb))
> +               return handle_dump_pkt_qca(hdev, skb);

Ditto, also since there is a clear difference between event vs ACL
packet I don't think it should be calling the same helper function to
detect if it is a dump packet or not.

>         return hci_recv_frame(hdev, skb);
>  }
>
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
