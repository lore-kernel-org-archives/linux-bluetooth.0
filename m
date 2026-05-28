Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043FC3BED23
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 12:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779973132; cv=pass; b=r5SQl/WhqoF+LMaSBmqMj/WulnHOhma+Txfb0ZzFE4cEU9ayAcagjFnRoK3jZHy6D/3QA49vnKxWyUSaEiglPM4Ez/3IDzxYufoMnVGVl2rpu5f8lCAKHbtiIb0rpavvtPMW2uzvU5UxEYcAvy2vzOKMmlJnXn8L3zlD+XyK9sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779973132; c=relaxed/simple;
	bh=+kCy2x17u7tcKib2rz+F+ifNov37Ey1LlpqOXkXU5S0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DgTPOyY+Z3T8H8HDVze75nApQpvyGyGyQmus8p5KEuxdobRc81oNENLmch5r0TrsRcXNnMIXX+Weh7nxjltsEnIdX/vuftO5UqDvpTx61SLTBLkXzOeEOlp2/26DRAni20vhmAGiw3ckZGVJG7o+Kw4lL573+lk9J8GUAj9oMx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+HIce+0; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+HIce+0"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7bb0d18c7f9so120754987b3.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 05:58:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779973130; cv=none;
        d=google.com; s=arc-20240605;
        b=SB+XXtwGSArWgq7VKF+tp7pOVeT0rI7pr3ZJ5a1zKasc32trc3PkZSQNXPs2E0Is+G
         GWeGYqcVkyPZtUfcjW9NrX6G4xzZ99SVfwD8BTvkap6s9fo07/zCXpigU3SMuV3nXOE+
         PuNbk5MlAvtm4aJbazKRHg9X1h0M+LvLRN+VsxqcCb1/to1nLUEAoAbVqfkPpQe6sGnT
         zmI1ctZ54iXZRxpUb7US5A/fpmJqlDhI9AljPuNimDj6B/1RtvxBq+tf2yaKGTfHq7R5
         uFOa9gOuM+4XUptexQZS0JCylrKDIafUX3hcJyF+uPYRvptNJ6nZFvBymVkfsTw/H1ir
         v0WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LJk3+EJzFleovF5E74YmPNIDSB00JjTFpJfsMgzVcAA=;
        fh=BQr9b5AD0rwi9Y+w2SlPpr+AdD2Lg3fU+1gnHN41laI=;
        b=fwcTmsRHcP/iP1HPx+b5Nv4NHmQFDeQXgxTG2G+t+S9kFyYX2kwE9qqzQOVXg4CriK
         CzG5XeCeME5AqaxhqmZOVPmbL+JEpTqDF2BLckVoonLyfeMmBvUDfLtLSVEmfPZaqc2G
         8uKgVK7i7vS5UJSf1fBokrgK3cZ/R/kPMd+5fIqELFW9NQ2CLciHr1A6AO09+w9UZiaq
         PscNzulKeHi27ECmydUODYHv6VgrU22HM8u5nB7Kp5uwJnoMKeXscyGJGh8ra2VdlMpZ
         VZnOvlaH7EbD0DqPPrv4Z8890RSRrCYyaWarjTRWRenJHvhnt//WLZsvUB7YZQuwUT53
         kL7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779973130; x=1780577930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJk3+EJzFleovF5E74YmPNIDSB00JjTFpJfsMgzVcAA=;
        b=A+HIce+0V/txnR086lJmFyXPLA8goa/xhBfbFqUXTZrYKLegdb1OIHHmk/ccB5sKlW
         qRJ7NEn9IR2NJtoeKoqItoKblUDgKOOCmFB0c18zHXTq6D0K9IBn5pD4+n+bVtq2GZbF
         b0kYa7QOfWwnisD21GmNffrKvJ49G7fdKUDgUzhQpsoIuFVs0f6gArQuacLx6xu2rzzG
         a07vA8uYChbRj3MfeH2Hs0+xOahJPdiZX3JTteRznj2Ne5uXY0OjJ1LQik8/nZFEnnNi
         1RALUEgkEUYyyMF0C6hG6ctvSRsb7HBIPCJsAWg00tBNZ67/IeLqh+dHjRZ8kY9cryjb
         KO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779973130; x=1780577930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LJk3+EJzFleovF5E74YmPNIDSB00JjTFpJfsMgzVcAA=;
        b=QUr+6L5Pl7v4nfVnMfA7+iJMxT/O5SvWvK4vI5csnNiUYQ0zJu2q6WWANE8qVoOdjm
         Xo8mmYSR1SfKslYP9Ts5Mlfl+5OL5ChtoMNsjSYGFnwEfEi7E/KkVonOECNppMrbf4Kr
         96JAtlkPawLkUp09LPHCesgoFFkbUJtqU7Yk1xP9KdtNGE0dojQXbZndKdN0L15XLBE4
         jFuPs8IA+05//CHEctqCn/ZKDsUtKKGzqTZtr38V7AVUai6ouBCbJt0iqbchJX3mGRVw
         S2xJotHaqgNQ+k3v8uB6KkgfghNdxbqWRCLNKXYoEp9XenVft6h/JH62fCyn3MR6mKNJ
         DbPA==
X-Forwarded-Encrypted: i=1; AFNElJ+E1QvSBdb6/kIBbak5lF8nB0cTLBjwYbMzqmcojBpyiC70tARlYZCvkEsWYWZlnIO2TvLPhddsIwNFksr9K6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy13OOA4BdnEtiT21ZzzZ+NyVrPC4XBDT2RLuralBLlWrQypKY3
	Si4TFKumQkSfFAZZEC3OPvaN5ZXrlg2Cvj9njwMRbAwmk6HsV3kG3K11Fu3tWfufH6p/g7Bdukc
	9hPTNhITzVlHyFbh6ZyN9YmS8MvRA9K4=
X-Gm-Gg: Acq92OGrYWkoX1j77vrTmmI/VO1sm2pnCG4g2o9+sa9aq7cNv4KYm0M9OiYQYoEn+Py
	PxJQR7pFdyG8eB2Jf0GKRb3USaCbzUez+FOSus0gVVPYI2u5XzAmmZuBOtZb8fhY3FwBlO+relM
	tPRANs387hwb4ZiNZ9Z/PTPlmfboCVJnULkeVx75w8V7cKuXstMb2jKEzVNrlJBEaOalhDu+yrm
	8ACRiLhj+aZa9JzEFySOM31u6Qhe1CoaVs2pqQCsYoGdXvMe6UN1v1YaeUmoA4p7dEZV3RJSaj9
	SZxeGwQ2zaIQcaotx5xi44ApWLw1hWEsdXFWVskk3hq/a2GfGAhssI5LMHxacI6WJq++lWAh755
	5AR4N
X-Received: by 2002:a05:690c:b81:b0:7c9:30f5:2048 with SMTP id
 00721157ae682-7d3388835bamr290115817b3.18.1779973129778; Thu, 28 May 2026
 05:58:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521052611.1815693-1-rollkingzzc@gmail.com>
In-Reply-To: <20260521052611.1815693-1-rollkingzzc@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 28 May 2026 08:58:38 -0400
X-Gm-Features: AVHnY4Inug4OKPb0kCsGZ_9hcgW4b3sQg6ExExxB9O0WrEEfDKFkNT5W7YlEqq0
Message-ID: <CABBYNZJ7aETr9KdUFdU5uVkcr8RMzOyBS5xv4vpb7ij6Di7FOA@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: bnep: reject short frames before parsing
To: Zhang Cen <rollkingzzc@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zerocling0077@gmail.com, 2045gemini@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zhang,

On Thu, May 21, 2026 at 1:26=E2=80=AFAM Zhang Cen <rollkingzzc@gmail.com> w=
rote:
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

This still looks incorrect to me, why should we do * 2? If look at
BNEP_FILTER_NET_TYPE_SET it just use the header to pull using
get_unaligned, I know this is an existing problem but except if the
BNEP_SETUP_CONN_REQ header length works on a multiple of 2 this makes
no sense to me.

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


--=20
Luiz Augusto von Dentz
