Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4689386C3D
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 20:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776717726; cv=pass; b=b2UgvvptNCsYIugZNoWOPN3ngfp2Eshc2F79V3IgeuOusxr6dREotDdv1ypNrNm54XNWXzctw16xaNUl4ouwxBCdxV9kTE4zjRZlLi+2/764v0wkXPusuJsKGpj2AYz3DoSxYmBQ2RkDvOjhzjnW70SxwcymI23b//fjDoY8vTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776717726; c=relaxed/simple;
	bh=nLyhM+fp7riYQqgGoSuy0oUnaxYHgMAHlrwevd5S3dI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MbEQLfKugke5W1ffn9I3keZG4+LiTo7FFEv7O6zLVrSJy4zo4Cbvo8f9fsq1W2vk26KCjmX3PBU91bjw2UZL0YOi7COS4CYBjlrPuZDQM/y9rtUdPlBaxM5zziw6foUVQrE/H2UFpXPjVcnA6M5TeFh3DaIPb3qlxGyaya4jnAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VY8xmSGa; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VY8xmSGa"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-65006c99d38so3330689d50.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 13:42:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776717724; cv=none;
        d=google.com; s=arc-20240605;
        b=I1oh5UZ3j/wXWByGbgvnHQVQ4ZEjAvL4cIvcsmMzFm1qLMiBOKPT1fJeg/iZXI0LZu
         1IMhBaYwphCpjlJqTkz45lW1TRGn9yOPkm21vnTrMn/LAZhy0mwxBuE7SUx/N2VQ1pFP
         JMclYGf4rj7JP/gFEhddABOsXkRwReEssr10B4YHnt8PWIuMu+SpFCaEEpnw5xuvEvf9
         JZd/wTp6Y87cdlAULirIC7OOedLx9Wnzqipsydnexsf5lhls92dxPGj7j9UFQeaKnef/
         YRm61DRnk3AxvN1pYmofSdI5RL7VEBfSfbSxWr2F/QSnMyvLLUg+t8mhnhiSZVOaI/Y4
         N+oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YPMesXK6zWWUdv1z0+n4FdWvrPSk0fKkgxZCyXQ+qGI=;
        fh=kFyyEmuY8w0CHiZQXPVgRoZ1sls/Ih190MdZu94GsIc=;
        b=AycQTLSEpSdB88O869qpcBFmITfByNp29jIBBi5WV9f3UckPYpb+4yJ3XbRaGHhNOo
         Rv2v+TV6ErWeC0+6Urc1F8GR4MtgoMqxmJGjNxRua4DvGCwcZwxjD8683HB2mkpcnfIV
         2lhl3/Ic4rHG+Gy2/NHoMVgF4Px0s+BYy5Cr0j5PuE83KwFe3+5Kn3ztbutNGmclNkUc
         t9UlwoIUOm4G1YTNG4Ulex/z56DehaQ2A1Ucsv5aGkdyBPm3NIyDLd646Cut38mB1bOW
         PyjZYt9eI6ZEwO4z3n3AoFROP1xnEuPNUFemxQUgOLzbIaWIaJr2kdnGdPevNZ96nkpy
         L9zA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776717724; x=1777322524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPMesXK6zWWUdv1z0+n4FdWvrPSk0fKkgxZCyXQ+qGI=;
        b=VY8xmSGaL3UX8utF/w5kQDYF0MbC7YtY2KTprkBs9rq4rgXWMa2ZDG/4UYwzVvqw51
         6qGVPy6KXfMYOd1dZ63bLJ9gI+0RguGWTtZ/71qncHFAVPh5aI5QgVEapRAKSjisjAGx
         m0uxGUiKfySV8HygoBi5OhJWBWja1upUiCYxHzzJgVBpfDR8zxe9XrdLBY1Drk8b/IqW
         5p+sKwsYnhIvN/JSb5u8CnZljvu+A2TAqQ76SUlrl/sqltMzqxf7toXwrerQ36YPc1lY
         /6O1Rss51o6+3pV+g9vozeSHaLZgUKuP9YcXavafrrdbTb6ouyHHn8K5rjPJWieN85S3
         34VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776717724; x=1777322524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YPMesXK6zWWUdv1z0+n4FdWvrPSk0fKkgxZCyXQ+qGI=;
        b=MzWCUywUEOjK4sg1e07NLOH2Jss1tXZI8Kzf2rZ5/en6FDCnbDE+MNrlcjO+3PQ6v9
         H93ahu14tI/aNN77vGQqyQ7LmVeyPPgAt3MiQoIahCbRZuTG0Azvbvh5ThOBtwLoi/Hs
         XLzLLJ+amob3jcK0w1wRQRzxE1+np/ToTmHfHgeHejuk4kjCxyP/aHqeXSjBAXiSwe2b
         eDoSWLBChTV7NH27M5GVqnLJgbFFH+tv2o/kWnDJpO87OfTKVzmnCGWNouIRRib1p60H
         buvBF1VMz4pukxAT3EiUgKUjt3L48flTy/wDiqC61PbXuaO+E3ByBof4lcM89VWZwaMG
         JUMA==
X-Gm-Message-State: AOJu0YyXfc5Ry0Uco1C1FAcmNQaO64bj7rn8ljZ2TA5MKTKzwRnN/XPR
	7mxU1bdD50uesHnMDSq529bUtYhuK9l4ZDBE05ck3+24tf9FkhODS0bPxMP/0oEJ40iiRhZTPl3
	larynA1vwBw+nR86YrWfL6+QUle9LSBk=
X-Gm-Gg: AeBDiettSiOHBzhAqnNvCPbEMgZu0NQj4LmkjjYEmt5RRGMe227n59011AlqynpWG1i
	p3U+wPYh5w1rtIvqC+BO4jZP/aICd5UtzXbMxip/U5D3URqjA87Uqrrn7eOOsuT7S22HorEpaqq
	YEE+SYH2ARen9rXrjK6EWB91qfW0bI9Nl6XPyL2fjqySm/MTRDfhwcIhsyh7aaXLQ2uomUwjx/8
	gqKXzFIzP3O9Vr52qV45N79wkfizLnGlxr4xaI2qBXsyR4zX9hGcALtxJMH2gjHDaedajhoIvXA
	bCc+0Ksuf2FtmeINKEMp2sbAc0zsZ9ZrAZCs8KPfG3Dl3ILGzrN6MBZ/g3JoLAqW++JjfjlhzlA
	Pdrk5
X-Received: by 2002:a05:690e:1688:b0:643:1a5f:aaec with SMTP id
 956f58d0204a3-65310a71a75mr14572943d50.47.1776717723702; Mon, 20 Apr 2026
 13:42:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417102919.2549352-1-tristmd@gmail.com>
In-Reply-To: <20260417102919.2549352-1-tristmd@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 20 Apr 2026 16:41:52 -0400
X-Gm-Features: AQROBzD_GQxwoxVdlYB8b6d_zTcStlFgzMZlZcqFbSiUktCCzUOkh_n5AZI2Cjs
Message-ID: <CABBYNZK5dsj7oTpXAgJ1mOBYBvN+haDK0okR7ed33QC=Td18JQ@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: btmtk: validate WMT event SKB length before
 struct access
To: Tristan Madani <tristmd@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	sean.wang@mediatek.com, mark-yw.chen@mediatek.com, 
	linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tristan,

On Fri, Apr 17, 2026 at 6:29=E2=80=AFAM Tristan Madani <tristmd@gmail.com> =
wrote:
>
> From: Tristan Madani <tristan@talencesecurity.com>
>
> btmtk_usb_hci_wmt_sync() casts the WMT event response SKB data to
> struct btmtk_hci_wmt_evt (7 bytes) and struct btmtk_hci_wmt_evt_funcc
> (9 bytes) without first checking that the SKB contains enough data.
> A short firmware response causes out-of-bounds reads from SKB tailroom.
>
> Add length validation before each struct access to prevent OOB reads
> from malformed WMT event responses.
>
> Fixes: d019930b0049 ("Bluetooth: btmtk: move btusb_mtk_hci_wmt_sync to bt=
mtk.c")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  drivers/bluetooth/btmtk.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index 6fb6ca274..b1a96ebae 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -695,6 +695,12 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hd=
ev,
>         if (data->evt_skb =3D=3D NULL)
>                 goto err_free_wc;
>
> +       /* Validate SKB length before accessing WMT event structs */
> +       if (data->evt_skb->len < sizeof(*wmt_evt)) {
> +               err =3D -EINVAL;
> +               goto err_free_skb;
> +       }

Can't we just use skb_pull_data instead?

> +
>         /* Parse and handle the return WMT event */
>         wmt_evt =3D (struct btmtk_hci_wmt_evt *)data->evt_skb->data;
>         if (wmt_evt->whdr.op !=3D hdr->op) {
> @@ -712,6 +718,10 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hd=
ev,
>                         status =3D BTMTK_WMT_PATCH_DONE;
>                 break;
>         case BTMTK_WMT_FUNC_CTRL:
> +               if (data->evt_skb->len < sizeof(*wmt_evt_funcc)) {
> +                       err =3D -EINVAL;
> +                       goto err_free_skb;
> +               }

Ditto.

>                 wmt_evt_funcc =3D (struct btmtk_hci_wmt_evt_funcc *)wmt_e=
vt;
>                 if (be16_to_cpu(wmt_evt_funcc->status) =3D=3D 0x404)
>                         status =3D BTMTK_WMT_ON_DONE;
> --
> 2.47.3
>

https://sashiko.dev/#/patchset/20260417102919.2549352-1-tristmd%40gmail.com

We should probably check if the comments above are valid and have them fixe=
d.

--=20
Luiz Augusto von Dentz
