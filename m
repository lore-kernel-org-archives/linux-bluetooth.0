Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com [209.85.208.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFA7346795
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 07:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.194
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779953740; cv=pass; b=pU2S8rVn41w8mlW77wDi7DsaoFl3FV8fbulc24B5Pb4hMmc5EleFfGo4bwIdE4dKx8c2cdYgoYPppsWgAvPRBKNOWWL2F1NIZ77BMsaFidvXcbPdQJo/FQ3UUpBg4I+eEXoceo16HnpZMUTJ5AgFpVtJWNU6t8LR9oAc6/kmy8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779953740; c=relaxed/simple;
	bh=dH3etVDUssaRwluSnWmluBuLtqRnbXptqxEYWYPzvfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n2sQfJLMfrX2K64/Q5toGFN+QTNfDOpl7NBqCrejZrrZAd5bzXSbWyEGj0+i1WsW6YuCUy/yzWKBbXHU3erx7evlwS808ePHM/DLuxxLXwyoXgXKcdkG8m2wroNQHOwMdKyXRbwcvaW2NMHSjJFSFgJcZ32iBSXkkGQhJktoLXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nvcn1eNn; arc=pass smtp.client-ip=209.85.208.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvcn1eNn"
Received: by mail-lj1-f194.google.com with SMTP id 38308e7fff4ca-395f24a5f2cso47729181fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 00:35:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779953737; cv=none;
        d=google.com; s=arc-20240605;
        b=k+BbYXgUcXIpzEJspZcQwl9RWV8r+k9OEvGc2XULpV6N0gxggvKnec0Yt/PziCb+Wb
         2yRxPmKl9d2THBqsVKk7GR9U02PhTjp82B9FykL5ZvcPb0ZHBhhiHST+aaf3q4WypzRx
         ZMFSiV9iLVvHhPt7IgqTfB4Wv29n49OGbhhBo1tFN1lPzzZz2lbynuIFURQGZtKZdOUG
         Xe5Xi37qEeH1P+1SZsiojKIYrZnyqQZr3XhBENjDrNyGK9c5NBQLdKvkxmAYEVEzYLhM
         kBUcBMw8rDB078+GZtSa6NSCAYSzj1lGKfhdUDudms1VhQb6VX3n6nHiw9FqYZrDGQRX
         CV2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w4symvtce52/0mWK+ohaQVVUvSqMGGPNwwNiacCyEgY=;
        fh=6hgMrrVsLpkxPSG/AwSewcg1i/gyKE8VrudihdvMq9s=;
        b=X2PAYVraSzcbIxi06LB2I9+gXpMRVyoJMH91LxCtxO75DkWgMqvJYcfzzs6CibH9Fa
         7ZjJrZn1+fr1RDmpLe3IJvPRXEgw1BupYQ113A11v2q8YVUsPXEswkQGJtq3sMV0QQil
         X39sBy0xdAWQ9j+ENvEc2co6uJayeclKKcdbc9t3SwYhU2aWjxQmkCN+cv6x0qDQGdQe
         TlH1HxBiZHN3HeM+HGEbLlNO1N1QWeAaoRfjzbZY+RudeTuBsszJxy/JNboJ6fQ0jyxU
         /mRhM6kjHomZnFPacbOxATZR5OkQson6trePwEJ5k1/Xuz4sTLgemIkscMjt1NqjKosZ
         1vfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779953737; x=1780558537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4symvtce52/0mWK+ohaQVVUvSqMGGPNwwNiacCyEgY=;
        b=nvcn1eNnTvvwCan2KdMKYANLDOo7z4teRCJKgTU4hgP+ng7yIPtPrtK14Ew+VEAlH9
         6YOahb3IGVHDyC2YFYkLPtlun5pYr84j4p5fvA4l+X5r9NHrItaURTLSRhCkYHuNZyDT
         TrQMe2wQi6tXaGM7hkT/5xBjLa0fK5AoPJ9/1B1oIAHkn+Wqmd+EXn9W6skIYv4VN9t0
         xBWpuZfu8yx5Ybd1M7ViYcPtt6jL/tksbnK+UUVsgBEl3qsh63edY1rBIFRw0ED+vS5B
         o2f0td1WXghAwLhUdI4VSpm42n7RBzOr3AI9IqpqokZrZbJvp4LTdVtM4zVyx/NMPLXA
         7W2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779953737; x=1780558537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w4symvtce52/0mWK+ohaQVVUvSqMGGPNwwNiacCyEgY=;
        b=lKC6UR5vsONkd+WTHRRG1u2Ok/hyCNpuryr74H5me7c83WjLYYLR4oWvkCyY3YeS6W
         mos6fULHv/EUW+9WtI9Fbik5/S7Q9Y9Pq4kENxmwI8HEUrpJYSBWAZUOeu6RDIP4e3u8
         B6J2kIpBLl4JuPHFTdv4XTF31aoj2gev5NiI+7VrgIt6T7KT5Yd6RMRN5VDrdzVPbA1m
         dEoLN9PEcu6g2Fi8Lf2rTT09fz2niXM7rJUmVbZzqxpGJG/M3jJRoogIGNfFHZzZLFjZ
         RH2t1Id9HwYaeOPdRAkpzSrHk3nDZLuQHQnEfme/7t9iVfco8CRjQWU6izKsLKf3WBTl
         VwbA==
X-Gm-Message-State: AOJu0YwP2ZyYGBcbU5nApiPfGWrtjFYcMPARxNHUE2m17ZIbUDVkNfz+
	h4ijzISkcge0emcjtTGdqa4v+AiME3kF96NoL05UHxMssea3nxRGW4xnIst0UaoYUqdGskug22e
	qvlwR4v9mYj4PbUX5VxTpy+Wy7mTow1g=
X-Gm-Gg: Acq92OE9uxj/FKhOqTf1JF2pZfTnblgL/t6Lr6vMxe7y82flBv4w1STCWuQ+5ZJPRhW
	vnz2SgL2a4DEjtn/oNHD1oHW9NYbqR10ClAPkBLpTHPSiaNPElHQ8NrE8M6vCS1uoAkChj9gKzm
	jeXws58yLNT1mKAjJBKhNAI9EI/3z7u7DMXxKD8U+Sq/WUI4Xj3JyUxUbMrCrOvB714PVmo6Mst
	uendbYtjruvDfRulX3ZaKdqjVdlW43qPHMMh+sp42oMcd0AFl7vCvQcWPW4Q6xJZW4AxXQ+/tuE
	hQN9dvDkTLAe4eGX7esRLNWHqJdEuTE=
X-Received: by 2002:a2e:bcc1:0:b0:394:642:c638 with SMTP id
 38308e7fff4ca-395d8d947ddmr83406611fa.25.1779953736416; Thu, 28 May 2026
 00:35:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521052611.1815693-1-rollkingzzc@gmail.com>
In-Reply-To: <20260521052611.1815693-1-rollkingzzc@gmail.com>
From: Cen Zhang <rollkingzzc@gmail.com>
Date: Thu, 28 May 2026 15:35:22 +0800
X-Gm-Features: AVHnY4LX1csptsjsFijG4tTzx12Vvv38eDHqyddohKcgii1kwdvRKFTeRSUjjoI
Message-ID: <CAB7XQsEongy5tu7kNV-hLaH1P_mH8Bw2ZYv=P038TBncX_6Xew@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: bnep: reject short frames before parsing
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zerocling0077@gmail.com, 2045gemini@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

Gentle ping on this patch.  The current version follows the previous
review feedback and the bluetooth test bot reported no failures.

Please let me know if you would prefer any further changes.

Thanks,
Zhang Cen

Zhang Cen <rollkingzzc@gmail.com> =E4=BA=8E2026=E5=B9=B45=E6=9C=8821=E6=97=
=A5=E5=91=A8=E5=9B=9B 13:26=E5=86=99=E9=81=93=EF=BC=9A
>
> A BNEP peer can send a short BNEP SDU. bnep_rx_frame() reads the
> packet type byte immediately and, for control packets, reads the control
> opcode and setup UUID-size byte before proving that those bytes are
> present. bnep_rx_control() also dereferences the control opcode without
> rejecting an empty control payload.
>
> Use skb_pull_data() for the fixed fields in bnep_rx_frame() so a NULL
> return gates each dereference. Split the control handler so the frame
> path can pass an opcode that has already been pulled, and keep the
> byte-buffer wrapper for extension control payloads.
>
> Validation reproduced this kernel report:
> KASAN slab-out-of-bounds in bnep_rx_frame.isra.0+0x130c/0x1790
> The buggy address belongs to the object at ffff88800c0f7908 which belongs
> to the cache kmalloc-8 of size 8
> The buggy address is located 0 bytes to the right of allocated 1-byte
> region [ffff88800c0f7908, ffff88800c0f7909)
> Read of size 1
> Call trace:
>   dump_stack_lvl+0xb3/0x140 (?:?)
>   print_address_description+0x57/0x3a0 (?:?)
>   bnep_rx_frame+0x130c/0x1790 (net/bluetooth/bnep/core.c:306)
>   print_report+0xb9/0x2b0 (?:?)
>   __virt_addr_valid+0x1ba/0x3a0 (?:?)
>   srso_alias_return_thunk+0x5/0xfbef5 (?:?)
>   kasan_addr_to_slab+0x21/0x60 (?:?)
>   kasan_report+0xe0/0x110 (?:?)
>   process_one_work+0xfce/0x17e0 (kernel/workqueue.c:3200)
>   worker_thread+0x65c/0xe40 (?:?)
>   __kthread_parkme+0x184/0x230 (?:?)
>   kthread+0x35e/0x470 (?:?)
>   _raw_spin_unlock_irq+0x28/0x50 (?:?)
>   ret_from_fork+0x586/0x870 (?:?)
>   __switch_to+0x74f/0xdc0 (?:?)
>   ret_from_fork_asm+0x1a/0x30 (?:?)
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>
> ---
>  net/bluetooth/bnep/core.c | 51 ++++++++++++++++++++++++---------------
>  1 file changed, 31 insertions(+), 20 deletions(-)
>
> diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
> index 853c8d764..156cd3026 100644
> --- a/net/bluetooth/bnep/core.c
> +++ b/net/bluetooth/bnep/core.c
> @@ -206,14 +206,11 @@ static int bnep_ctrl_set_mcfilter(struct bnep_sessi=
on *s, u8 *data, int len)
>         return 0;
>  }
>
> -static int bnep_rx_control(struct bnep_session *s, void *data, int len)
> +static int bnep_rx_control_cmd(struct bnep_session *s, u8 cmd, void *dat=
a,
> +                              int len)
>  {
> -       u8  cmd =3D *(u8 *)data;
>         int err =3D 0;
>
> -       data++;
> -       len--;
> -
>         switch (cmd) {
>         case BNEP_CMD_NOT_UNDERSTOOD:
>         case BNEP_SETUP_CONN_RSP:
> @@ -254,6 +251,14 @@ static int bnep_rx_control(struct bnep_session *s, v=
oid *data, int len)
>         return err;
>  }
>
> +static int bnep_rx_control(struct bnep_session *s, void *data, int len)
> +{
> +       if (len < 1)
> +               return -EILSEQ;
> +
> +       return bnep_rx_control_cmd(s, *(u8 *)data, data + 1, len - 1);
> +}
> +
>  static int bnep_rx_extension(struct bnep_session *s, struct sk_buff *skb=
)
>  {
>         struct bnep_ext_hdr *h;
> @@ -299,19 +304,26 @@ static int bnep_rx_frame(struct bnep_session *s, st=
ruct sk_buff *skb)
>  {
>         struct net_device *dev =3D s->dev;
>         struct sk_buff *nskb;
> +       u8 *data;
>         u8 type, ctrl_type;
>
>         dev->stats.rx_bytes +=3D skb->len;
>
> -       type =3D *(u8 *) skb->data;
> -       skb_pull(skb, 1);
> -       ctrl_type =3D *(u8 *)skb->data;
> +       data =3D skb_pull_data(skb, sizeof(type));
> +       if (!data)
> +               goto badframe;
> +       type =3D *data;
>
>         if ((type & BNEP_TYPE_MASK) >=3D sizeof(__bnep_rx_hlen))
>                 goto badframe;
>
>         if ((type & BNEP_TYPE_MASK) =3D=3D BNEP_CONTROL) {
> -               if (bnep_rx_control(s, skb->data, skb->len) < 0) {
> +               data =3D skb_pull_data(skb, sizeof(ctrl_type));
> +               if (!data)
> +                       goto badframe;
> +               ctrl_type =3D *data;
> +
> +               if (bnep_rx_control_cmd(s, ctrl_type, skb->data, skb->len=
) < 0) {
>                         dev->stats.tx_errors++;
>                         kfree_skb(skb);
>                         return 0;
> @@ -325,23 +337,22 @@ static int bnep_rx_frame(struct bnep_session *s, st=
ruct sk_buff *skb)
>                 /* Verify and pull ctrl message since it's already proces=
sed */
>                 switch (ctrl_type) {
>                 case BNEP_SETUP_CONN_REQ:
> -                       /* Pull: ctrl type (1 b), len (1 b), data (len by=
tes) */
> -                       if (!skb_pull(skb, 2 + *(u8 *)(skb->data + 1) * 2=
))
> +                       /* Pull: len (1 b), data (len * 2 bytes) */
> +                       data =3D skb_pull_data(skb, 1);
> +                       if (!data)
> +                               goto badframe;
> +                       if (!skb_pull(skb, *data * 2))
>                                 goto badframe;
>                         break;
>                 case BNEP_FILTER_MULTI_ADDR_SET:
> -               case BNEP_FILTER_NET_TYPE_SET: {
> -                       u8 *hdr;
> -
> -                       /* Pull ctrl type (1 b) + len (2 b) */
> -                       hdr =3D skb_pull_data(skb, 3);
> -                       if (!hdr)
> +               case BNEP_FILTER_NET_TYPE_SET:
> +                       /* Pull: len (2 b), data (len bytes) */
> +                       data =3D skb_pull_data(skb, sizeof(u16));
> +                       if (!data)
>                                 goto badframe;
> -                       /* Pull data (len bytes); length is big-endian */
> -                       if (!skb_pull(skb, get_unaligned_be16(&hdr[1])))
> +                       if (!skb_pull(skb, get_unaligned_be16(data)))
>                                 goto badframe;
>                         break;
> -               }
>                 default:
>                         kfree_skb(skb);
>                         return 0;
> --
> 2.43.0
>
