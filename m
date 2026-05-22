Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D69534BA28
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 19:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779479460; cv=pass; b=kLg/JObiuqNLSGpBiq3lvWroUI3cFzu9IEK0qBzMaqDjXpPhDoJJjVSm6UDY0TbqAxjDdQd9otQ8JogjnbiOVbCCUglKWxt9gdqXSckQ56gvUonUqFRx8e0vF4PAKKQVGgWQK758z5882nANGwt6Rzdl9hvf2HCey1qvfjoQzIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779479460; c=relaxed/simple;
	bh=w13QDMKdFXVU9rMclB6pzScQGNlOb3CT8W9ZyRiGiCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CtG4G9oOOrFt3KfWMHDiJ5c8wlW7MshvIblgiMz4BS//BSzYYDuNzd9mj6RDD+WDyrDPLgqFXvrJeDznTeUhlli3rnW4OhhnZkJ3qxz6IC723s9vQNHnNJaQrwHfP1dE28SeSd+G/+oMNxJ1Hrkq7yzryxQBZ4KWiF7GAMyOEEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHvu9Wlf; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHvu9Wlf"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a87782588cso72382e87.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 12:50:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779479457; cv=none;
        d=google.com; s=arc-20240605;
        b=GLjx01jRKdUNXBKOqW304APIUPcN6wmz3wQ50FcGnOL09XrFB5t7FSyl2XWyplHeFT
         0eocE/dOObfd+2Ma0Gv2RkqY9c0WvSVL+PL838N6jcwc9Gz7h8sj8D1evb9wr3kku0K0
         BbdxpMhYhkp2FK5OXwsHtemwcUdFvfyuEYda3GIgXGfYpAWuisfDgVl+evSSuNNPqz6P
         ybB7DocWUVKY4T5p6ffHm05adlZtSlLXhVLKDJ5alo8DOHEP+RlnCKQFDLatDTOFscEX
         +Rr/UlkhpZT1Aa5MHbnJeLLqPk/7+l/qQG5N6TFQMOVFyfxTcnIHj5j8nxb6oogXvNyg
         PisA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pq6Snvx3M6Cvj+MHUaAmKvnQl7LjByn3Z0Yyem+lcHg=;
        fh=hGG92/Vk4AjoHT3DPUQGAgJ8IYo5jzEJbJI7msJVmjQ=;
        b=Lwcavi9nryWZ+cO6az/FlUtRscNa4o958CXX3HRJNbYagm6wSVn/DILZbZiymyCRjN
         YIpn4PIyNM0ATCe18I5JR23tyKdYS/IyZBRbtghn9afCXupd+ydrcCM3d16/lOE7f80R
         ShsP2xv0aF1Of1AUfKTHuELEGcd2BzKqsl5a6OK3b26Wcs5SXzISRXiuPFMSM7cNzQaw
         EkpagxfG9csWsFawJSx6o9k2II1CykD2kxJ1eOD0OUqtIvI3cFkLwlUbnvjYMdyZ+b66
         KeCwN8zckWrTm3JwEWPan1yeps2EpaazZ8dNyILQ4DeFXJuctEkH1MvaK0uvbVNNYX0G
         XcQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779479457; x=1780084257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pq6Snvx3M6Cvj+MHUaAmKvnQl7LjByn3Z0Yyem+lcHg=;
        b=HHvu9Wlf+YF5LwtnSucPT/wbNfIMf22wXPEblZSK47jf8LxEaG+G+xr8TEowWF3QbR
         u0IOS3lHBb8UE3zQVCZQD71CmtfMwFDk7XGrCX1ByGHTRZ+HQ1D+02a1c1xBdr17zYBT
         ELPVwcF5CvW/1oggef/TuOU+R33jo6MvHBSUpMDbq3kPe7q2eafjC+WINDhZeFsqVBEe
         kH3K1Tc3UgyHHd2KGKbdxMxojSaqZhvVi1pPzfGhFG1v1sLwJRShCAzlwxthnvRqhVbC
         MgHHL2pNlVd4+U4D3ku5VSgSISmeD/5x3xyAzEarO4WFdRqALuudk67/rpFXSY0rs2tZ
         59Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779479457; x=1780084257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pq6Snvx3M6Cvj+MHUaAmKvnQl7LjByn3Z0Yyem+lcHg=;
        b=CtKU8KmT+mZWNpBaRkPsxihTmr+uc0S/1hOwickvi0Tq/uKGFC9j2wOYgdM0+qE9mX
         3AlXDI5fr3bvRKGFKbi0EjoScgyG9IItL7n3IsVgfaeU6arZ+iq7sFDbMsGhfdjXgj+g
         LT9np71FRVP79yYTB9z4Flj1LkS2l/amDSVyuhD9arKBoBZjKkZt0Ax/j+xmrYPfHtP2
         FSTVLawZ0nBJf4UmaI9BU1IhxHgf+9tfBMIxsdNHpZh9xhEGDcfDVS712fVSKUb0sSNu
         SlPZUAaMTARtAsNE5a5+2CsRKKNTyUdceU2CSyVM2jPhCLNPEK2elffWAIaQeWKWhpkS
         eJYw==
X-Gm-Message-State: AOJu0YyxYhwVy59ZidAnvNQpiI+8D8EnPX/FfHBdaB8LGZVVPxiuHoPY
	RMexwoLMNBLAHdwAT1Cq0aaRKM/6sBe+s/NZDNcaPnkEOHB1L+J0RUhqbR1OfQtSrR4OV9ThWRg
	k4dT03d7JuPt9hTRWoS2yD2y1husB2/7ahJv0
X-Gm-Gg: Acq92OEqOPHzsX9S8D8jKL5MlYs0Kstt2nCnCkte7qsbGw+Nls1TRNlgCVaejeROiTx
	wo80CC38odL/DDp0O8HMu43MPNaCOc3PAcvLWxGF3uxFiFxmUFEhM9PFpXUScLvIAUolp+jfXGI
	LeJO5/kTwLIRPfWWUdLIfT0qYWOZs8R9zg1O62Hv6xO9yUx9A8sFJBJPX1NQsLp/W1YaiKga/sS
	/DCZIE5Xu+XDa0zo87Cmy3+2Zxi0YN1N3ubQwpmKe8lUHzKB8g8gSGkMGNO7GGBPiyLoLYYc+Di
	+OTHMe+BGVd0qTbBLIPaAU5lzFi4p0P6dUkpdQQ=
X-Received: by 2002:a05:6512:1243:b0:5aa:116c:4127 with SMTP id
 2adb3069b0e04-5aa323a9065mr1749567e87.41.1779479456947; Fri, 22 May 2026
 12:50:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522175658.41667-1-meatuni001@gmail.com>
In-Reply-To: <20260522175658.41667-1-meatuni001@gmail.com>
From: SeungJu Cheon <suunj1331@gmail.com>
Date: Sat, 23 May 2026 04:50:44 +0900
X-Gm-Features: AVHnY4LSOxoBwV8oIV0SXoHrFePQWlSvLBHUXQVkre292EgLiHWaufbhRjsmr64
Message-ID: <CAGwK=3o0ufRr-611yN5Vx4dKaQ9=9BVrv8t3Emxh4_sQtAaXrA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: RFCOMM: add length check in rfcomm_recv_mcc
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Kees Cook <kees@kernel.org>, 
	stable@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Muhammad,

Thanks for catching this. You're right =E2=80=94 my v2 added the length
check but accidentally dropped the skb_pull(skb, 2), which leaves
skb->data pointing at the MCC header when the sub-handlers run.

Since my v2 isn't merged yet, I'll fold your fix into a v3 of my
original series so everything stays in one patch. I'll add a
Suggested-by tag to credit you.

Thanks again for the review.

Regards,
SeungJu


On Sat, May 23, 2026 at 2:57=E2=80=AFAM Muhammad Bilal <meatuni001@gmail.co=
m> wrote:
>
> rfcomm_recv_mcc() casts skb->data to struct rfcomm_mcc * and
> reads mcc->type and mcc->len without first checking that skb->len
> is at least sizeof(*mcc) (2 bytes). A remote device can send a
> crafted UIH frame with a one-byte or zero-byte MCC payload to
> trigger an out-of-bounds read of the second byte.
>
> The unconditional skb_pull(skb, 2) that follows compounds the
> problem: if skb->len is less than 2, skb->data and skb->len are
> corrupted for all downstream MCC sub-handlers.
>
> Replace the open-coded cast and skb_pull() with skb_pull_data(),
> which atomically validates skb->len against sizeof(*mcc) and
> advances skb->data. Return -EILSEQ on failure.
>
> SeungJu Cheon's v2 patch added a manual skb->len size check in
> rfcomm_recv_mcc() before an open-coded cast, but removed the
> subsequent skb_pull(skb, 2) without replacing it. This leaves
> skb->data pointing at the MCC header when the sub-handlers are
> called, causing them to parse from the wrong offset. Using
> skb_pull_data() here avoids this problem: it validates, casts,
> and advances skb->data atomically, and is consistent with how
> the sub-handlers themselves were fixed in Cheon's patch.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/linux-bluetooth/20260414010741.233892-1-suu=
nj1331@gmail.com/
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
>  net/bluetooth/rfcomm/core.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index d11bd5337..4e8047012 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -1644,17 +1644,20 @@ static int rfcomm_recv_msc(struct rfcomm_session =
*s, int cr, struct sk_buff *skb
>
>  static int rfcomm_recv_mcc(struct rfcomm_session *s, struct sk_buff *skb=
)
>  {
> -       struct rfcomm_mcc *mcc =3D (void *) skb->data;
> +       struct rfcomm_mcc *mcc;
>         u8 type, cr, len;
>
> +       /* Minimum MCC frame: type(1) + len(1) */
> +       mcc =3D skb_pull_data(skb, sizeof(*mcc));
> +       if (!mcc)
> +               return -EILSEQ;
> +
>         cr   =3D __test_cr(mcc->type);
>         type =3D __get_mcc_type(mcc->type);
>         len  =3D __get_mcc_len(mcc->len);
>
>         BT_DBG("%p type 0x%x cr %d", s, type, cr);
>
> -       skb_pull(skb, 2);
> -
>         switch (type) {
>         case RFCOMM_PN:
>                 rfcomm_recv_pn(s, cr, skb);
> --
> 2.54.0
>
