Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C405F193436
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Apr 2025 20:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743627471; cv=none; b=pBGRI8AC2MnYgY+gAzJoYofzejeFmAOeXt8yITwc4NjdzLXY6ggNwOeaAJkxIIGvVONN2MMD64oA8UCRmSVOLf0M14cdujs21jmX6+Di0Gpt3TNjg54vdn35Oys0FmGbjbM94SkrZAj/Ko4369xNtzTGBrMZnLi25XU0amCngHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743627471; c=relaxed/simple;
	bh=PeA8Og8tLdTywAVZKD53YSb8zrjfl5/FeBd2KR/PWrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CnI3reIibOQDb2o0z4dTK/tPI2mSm+W0tNC2LHwR+YGjol0M5RZI3cbpIoaEVG7RnbZabWj4eGn3JjXmvEU7Pirp3s1+tTMqyLliH09A6AcpXDfO4wHupcVPi8Nxy8HImHgdw3nMSOJh3aeYnAKJPDg4D2Ml7CM81iKJZdflbkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5I446TT; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5I446TT"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30bfca745c7so1840391fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Apr 2025 13:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743627468; x=1744232268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FY6DrmRW6SujfXTHoWQ3u4dKC2oydYwAyBNhX2J/0qw=;
        b=i5I446TT8u9MM/TcwhyJcGCox4rIdjIEULJ2AfsN8hvD8VOhlv4ktAztFH4cQMopNe
         cUqTSx0IpGTir/D8nLEOCQ4ngGqOLhIVERcgDKhhlHYjIEz6idbfcgBBs1L++hJVGGB+
         BJ22WCo7rcnQIZz7DO1ZEvQuWDMyqZFgChf1UAZSTsLR804KCkBSwfn+CsFKgN/6/sIE
         6xugtfuczIo2EOWgw1gwfvgm4NxSNIymt2z2yEM6HTPfpISwxGfE0ic0dDyWZzyvr5a7
         rdiZuqD0w2lPp8fjgjY0qzxytBgCU/PDwUPa8VcoAahn1uNJifgM9MyjNUZPGvQgjzms
         ODGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743627468; x=1744232268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FY6DrmRW6SujfXTHoWQ3u4dKC2oydYwAyBNhX2J/0qw=;
        b=enmnAWu1Fkap8YfvHml0DhqVuXnXf6oKeBVPpe6SmN4Ln77ReG2SBSprifk6tD1/4k
         w4jhdMRoOT2duIRlejXY7LKRs64x/kcjrK/DfkPUsDEH2CIB6E4sYpbny//oGv3Xz72a
         JOfmBFfJcYDlUD+cX60++v4KdolzDH7XW5WoitbvBT5stx81H76vPK0r7+HY7n5Hsa4j
         ZAuWJ5HHJn/baegw1CR7r1fqj+7zlx+cB1vELJcImJ8Nj8SBBq3oDe9e10I+oO5uUCPt
         EH3+S6P1mV52LEOXJDhi/71FrzBN6tYZZfsde3AVKyn1pP2KiRtYjKzEsLUO4uZJRQGA
         8fGQ==
X-Gm-Message-State: AOJu0YznwtN6gqsGAt6cm2kU0PaLzAtAFhpkG/MmpXxAWDD/pJ3hsDbl
	j7pCe57ioVYtzyXQ03svFFsp6lRn+BOEtKeXuWsAVm+3SQA2kPUITaPqVOr3dBmbYmlqYP305Pu
	/p2g6NJaLVUOdJozuypI2EKIfChqHIg==
X-Gm-Gg: ASbGnctXplHFuXHdZIcxiBMdIi+fS8fpgG2xsHFQDVSfBRRRvmR9MzPBzDts2gZHs79
	hxjM4j8qDK9TLQzxEjCtAw5ExneNqtv8Ta8dDQmQ5PHyrZqeFOasXtpYecCt1M1vmYvQGRvHbwl
	r0u2tnQeLMlOPU7nX+whrW1svF
X-Google-Smtp-Source: AGHT+IHZtbxT0soJxvFnwAaXPzI7hcR2yp9AzLxH6fwJeiVmxejDnOaqaBbskw90Y8QT38oeBLrHjD1VDOZiCY6Oh/w=
X-Received: by 2002:a2e:aaa8:0:b0:30d:e104:d64a with SMTP id
 38308e7fff4ca-30ef91e9b57mr10407971fa.38.1743627467529; Wed, 02 Apr 2025
 13:57:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402022054.64501-1-kiran.k@intel.com>
In-Reply-To: <20250402022054.64501-1-kiran.k@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 2 Apr 2025 16:57:34 -0400
X-Gm-Features: AQ5f1JqiG96ygT2KjQ2Tw-Kkej4Jvm2Z0g5HF9Kr8tQ0pdsbS9lrXatHIAs0rak
Message-ID: <CABBYNZ+p+_M7396tqo16ORDdBf38wQFRckBG4ZanXUoCQZCoRQ@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Avoid redundant buffer allocation
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com, 
	chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com, 
	vijay.satija@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On Tue, Apr 1, 2025 at 10:04=E2=80=AFPM Kiran K <kiran.k@intel.com> wrote:
>
> Reuse the skb buffer provided by the PCIe driver to pass it onto the
> stack, instead of copying it to a new skb.
>
> Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe trans=
port")
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel_pcie.c | 58 ++++++++++++--------------------
>  1 file changed, 22 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index e0b50513403f..ebc36fd33de8 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -947,8 +947,10 @@ static int btintel_pcie_recv_event(struct hci_dev *h=
dev, struct sk_buff *skb)
>                 /* This is a debug event that comes from IML and OP image=
 when it
>                  * starts execution. There is no need pass this event to =
stack.

Is this logged/sent to monitor at least?

>                  */
> -               if (skb->data[2] =3D=3D 0x97)
> +               if (skb->data[2] =3D=3D 0x97) {
> +                       kfree_skb(skb);
>                         return 0;
> +               }
>         }
>
>         return hci_recv_frame(hdev, skb);
> @@ -964,7 +966,6 @@ static int btintel_pcie_recv_frame(struct btintel_pci=
e_data *data,
>         u8 pkt_type;
>         u16 plen;
>         u32 pcie_pkt_type;
> -       struct sk_buff *new_skb;
>         void *pdata;
>         struct hci_dev *hdev =3D data->hdev;
>
> @@ -974,8 +975,7 @@ static int btintel_pcie_recv_frame(struct btintel_pci=
e_data *data,
>         pdata =3D skb_pull_data(skb, BTINTEL_PCIE_HCI_TYPE_LEN);
>         if (!pdata) {
>                 bt_dev_err(hdev, "Corrupted packet received");
> -               ret =3D -EILSEQ;
> -               goto exit_error;
> +               goto no_or_short_data;
>         }
>
>         pcie_pkt_type =3D get_unaligned_le32(pdata);
> @@ -987,8 +987,7 @@ static int btintel_pcie_recv_frame(struct btintel_pci=
e_data *data,
>                         pkt_type =3D HCI_ACLDATA_PKT;
>                 } else {
>                         bt_dev_err(hdev, "ACL packet is too short");
> -                       ret =3D -EILSEQ;
> -                       goto exit_error;
> +                       goto no_or_short_data;
>                 }
>                 break;
>
> @@ -998,8 +997,7 @@ static int btintel_pcie_recv_frame(struct btintel_pci=
e_data *data,
>                         pkt_type =3D HCI_SCODATA_PKT;
>                 } else {
>                         bt_dev_err(hdev, "SCO packet is too short");
> -                       ret =3D -EILSEQ;
> -                       goto exit_error;
> +                       goto no_or_short_data;
>                 }
>                 break;
>
> @@ -1009,8 +1007,7 @@ static int btintel_pcie_recv_frame(struct btintel_p=
cie_data *data,
>                         pkt_type =3D HCI_EVENT_PKT;
>                 } else {
>                         bt_dev_err(hdev, "Event packet is too short");
> -                       ret =3D -EILSEQ;
> -                       goto exit_error;
> +                       goto no_or_short_data;
>                 }
>                 break;
>
> @@ -1020,45 +1017,40 @@ static int btintel_pcie_recv_frame(struct btintel=
_pcie_data *data,
>                         pkt_type =3D HCI_ISODATA_PKT;
>                 } else {
>                         bt_dev_err(hdev, "ISO packet is too short");
> -                       ret =3D -EILSEQ;
> -                       goto exit_error;
> +                       goto no_or_short_data;
>                 }
>                 break;
>
>         default:
>                 bt_dev_err(hdev, "Invalid packet type received: 0x%4.4x",
>                            pcie_pkt_type);
> -               ret =3D -EINVAL;
> -               goto exit_error;
> +               goto no_or_short_data;
>         }
>
>         if (skb->len < plen) {
>                 bt_dev_err(hdev, "Received corrupted packet. type: 0x%2.2=
x",
>                            pkt_type);
> -               ret =3D -EILSEQ;
> -               goto exit_error;
> +               goto no_or_short_data;
>         }
>
>         bt_dev_dbg(hdev, "pkt_type: 0x%2.2x len: %u", pkt_type, plen);
>
> -       new_skb =3D bt_skb_alloc(plen, GFP_ATOMIC);
> -       if (!new_skb) {
> -               bt_dev_err(hdev, "Failed to allocate memory for skb of le=
n: %u",
> -                          skb->len);
> -               ret =3D -ENOMEM;
> -               goto exit_error;
> -       }
> -
> -       hci_skb_pkt_type(new_skb) =3D pkt_type;
> -       skb_put_data(new_skb, skb->data, plen);
> +       hci_skb_pkt_type(skb) =3D pkt_type;
>         hdev->stat.byte_rx +=3D plen;
> +       skb_trim(skb, plen);
>
>         if (pcie_pkt_type =3D=3D BTINTEL_PCIE_HCI_EVT_PKT)
> -               ret =3D btintel_pcie_recv_event(hdev, new_skb);
> +               ret =3D btintel_pcie_recv_event(hdev, skb);
>         else
> -               ret =3D hci_recv_frame(hdev, new_skb);
> +               ret =3D hci_recv_frame(hdev, skb);
>
> -exit_error:
> +goto out;
> +
> +no_or_short_data:
> +       ret =3D -EILSEQ;
> +       kfree_skb(skb);

Don't really like where this is going, having a goto label to cleanup
is fine, having multiple and the having to figure out which one does
what is rather confusing and doesn't help that much, anyway if we got
a negative ret you can probably just make it drop the skb on the if
(ret) statement.

> +out:
>         if (ret)
>                 hdev->stat.err_rx++;
>
> @@ -1192,8 +1184,6 @@ static void btintel_pcie_rx_work(struct work_struct=
 *work)
>         struct btintel_pcie_data *data =3D container_of(work,
>                                         struct btintel_pcie_data, rx_work=
);
>         struct sk_buff *skb;
> -       int err;
> -       struct hci_dev *hdev =3D data->hdev;
>
>         if (test_bit(BTINTEL_PCIE_HWEXP_INPROGRESS, &data->flags)) {
>                 /* Unlike usb products, controller will not send hardware
> @@ -1214,11 +1204,7 @@ static void btintel_pcie_rx_work(struct work_struc=
t *work)
>
>         /* Process the sk_buf in queue and send to the HCI layer */
>         while ((skb =3D skb_dequeue(&data->rx_skb_q))) {
> -               err =3D btintel_pcie_recv_frame(data, skb);
> -               if (err)
> -                       bt_dev_err(hdev, "Failed to send received frame: =
%d",
> -                                  err);
> -               kfree_skb(skb);
> +               btintel_pcie_recv_frame(data, skb);
>         }
>  }
>
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
