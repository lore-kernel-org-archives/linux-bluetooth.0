Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D59293B5F
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 13:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198702; cv=pass; b=P6/WTxw/eRBNeqRrMgJxBHZ5QorteuWoaaXtqS4um1rikAstGg6QNf0Fm3dZDJHFYiUKiOnMcLSYwl0TaatbUQRflFpLpsyPsEI3ax4vqjZx1JxGJ+u5euwyj7ENtG2ofK6jkM+yj/vDWvmQkIn0VMJep5hih5yQsOTBcFIIzRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198702; c=relaxed/simple;
	bh=UiRZFFSxfNaur1h+hBHhc1qozTGbc/kYlWrCOxKchwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VFr+rUL30XeWiORoy3aYGRmT1ekdSEv7NxequfoOiFK3A3mAe++AeIKaEncElkKILuLt+U5yK4c6wK5m3U+0P7CuzjFwyApos8HKUsMJmIFDMg13X4mSQCHH53pALHsC40aOs88aFTG7AA4koixr8jbPhG2Il9bikEFXI7U4M+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLy5ilMv; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLy5ilMv"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-65318dafbcbso3470897d50.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 06:51:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779198700; cv=none;
        d=google.com; s=arc-20240605;
        b=bWujH4bSaxvSuSe0SLr8f94ndO77/dB+ogjbBdUJ/HPjk7cMaU9wxtEmSVkvjYHV6L
         uyhTg1F7ZRsaE41E2WG6K7R01ovRU+chx0iPvKrINQVNxI0XQKZg8KhmWVeGGCvjH+qo
         DPTULBQRbmZt3NKOD7Dngej2Ahf4rgvvC+Zc/S8URX597ZpYbIX3kloseFRzcC0kX4Vm
         oupJwV0XZAd4sEHhdXImDyfNf2hqsHC8/ZY1Xk6fn8FFmf/kQkHp3zcxKu/UPKxzCNjX
         59d/Fo/i+swJd5PwFckv6SNWv0NKyek3CLq5bNsQp3zR1ew/T2xWyVfWsmHw6Ewkl3kd
         YYyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aVwge8U30I+3Do88tXXDA6OptpDzAX2Akk5fAL8cugo=;
        fh=Qb2hl4z2Dsw80npCSz9odwT0B/Pq37l7Shj4qcb1TFc=;
        b=i1HlysYf/K9RKtz8lYM6bY/m2cPIXtkEWzYeKsDJH9R/Wz81PP1NkH6uubygT8tFxg
         5ycRjKV1Iz2PKp6sWRC299TlAArzevVtob+jZPeRzHLBrpqYJ00I797EN30qKFyM/v3O
         RhxEvLt1dVSCN/qb1qaSeY88NjvtbgevyouIFN/w9kImvvZvQGM6hfHaR/9258E6mr7Y
         KFU/9AY76ZFp+OH9JjlrwINBPGfiEjcexHNPmisiQ/MyZ2eRlnBBUPO4kNfjevAU5pYe
         pfFnoe48D7j5BOaolb+oGZMOgd2JJ5gm0NrB0C+j/UfDF6Cl6Vb7qlH2uq0HqrVPTs94
         R8LA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779198700; x=1779803500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVwge8U30I+3Do88tXXDA6OptpDzAX2Akk5fAL8cugo=;
        b=JLy5ilMvbUziUXyPAMbiS4OmKRiUDaJWiElbMaEgM95sucr2AhzgRcWDUefjzzwdZM
         fV5CX40YmxCzdzS8MSSZ3DEqMaUeFAHVgEsIwDBLrb2q96ewybO8O7GXwFWVkpeOd8ON
         KJhRYRdctBvZV2R1knhoW7HmKWVbGCxQDNdo4kdtkL49ktR0092+g6Y4zgaZLVW0K4/X
         Hu9QFvid9DBhiRD5iiGoJ35rEQTncpU1mViN3blcZ6rWNvAglVZHSiod7SiJSjcvtDBq
         2oF8B1bdcnxvYIx3bMVbJl8iUAjuVPEaR+ejKGqwhvdzjvP9HK0PlzTWJHHARQNdAI22
         XNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779198700; x=1779803500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aVwge8U30I+3Do88tXXDA6OptpDzAX2Akk5fAL8cugo=;
        b=nEDEtgG3P1sOZ78qwp7c3eiTx500pAOVy1Qko7lMNWrwr9A54B1CSXDF1vCkZegbvD
         GwBKWhR5ziIVDuqmaSXzsqtICuw4vUF11WSaeYSqyTIfg9pftxRu273JHtgpO7r8p/ua
         v1ggz7nV6iSQa0uCus/922r4McnE0jVx+Wflj359ubn317LchsAnRPgWYXOZ/POmCs4L
         P9w26QnmQwSjsBywtOe0ReYDKGLOaWVGv9LEKK6JKlWJAnsZoFLOAg9pyVyxQfS+fg+x
         9COJAngyup+/KaqH4qCqR6kgXpatUa27SkiB0zXJcpeCd1MJg/l2XDkaYSGvQJhQhkb1
         m+ZQ==
X-Gm-Message-State: AOJu0YxAIbaUwXufvw7wINYOsuNVSxHpk7ivz3sIdDOHATn8TzBY/zqn
	t4Ehus6MHWrjYRN3LNpVAJnQ3xAKOKelHUzU5LnI+e1H252zkZu7RWtRF6KcG3bZCAO98SqD7hQ
	p1mRtejAzsdWL5z4Q6i0SV0fZv5ABQySAldG8aig=
X-Gm-Gg: Acq92OFdVp6WWpoJ6HXeq4OFcpx0pCkYdMYghuFEas++THTxHZVQG1DDMM717jSiqKj
	2H3GiZD9jmnaCIayP3olhSHLJSZyQRb/F0PuY/tjjh5loLiVHMLo+mNaVyoZ3rqN8XB9e9HlXRT
	ycB3d/FIEqaRdz9aRcZ5DMftCspGr4hxBRS4sQJsKx4hJUUM+ltL2SE/6pnm45+lNe8tLBr9LKZ
	2jiMN/0kswEJML5Q2hXqh0IQODDteNiLXhhsfidDEfkoObO/tc0R3SKNeB+yzow0BnjDEBOJQJL
	LhrUcFjZOSoIbUnKJA5PXSB3Fo6nbnSrN0B4fe+nndq0RMKlitYO2zLp8ESo33TEYgDSdnz05Rx
	qJhVL
X-Received: by 2002:a05:690e:4007:b0:658:1e1d:b8c6 with SMTP id
 956f58d0204a3-65e22813734mr18649450d50.44.1779198700259; Tue, 19 May 2026
 06:51:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519042017.29564-1-meatuni001@gmail.com>
In-Reply-To: <20260519042017.29564-1-meatuni001@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 19 May 2026 09:51:29 -0400
X-Gm-Features: AVHnY4K8F5R_BLPl_8aQWJk9ha54hIO3-GwHyckk614v30mRPpXpGNIIWjZC0HQ
Message-ID: <CABBYNZJ+m7xLo4BBGZzDXV=U7uNWSc7fbHU4QL+jUsN8zAVfkg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: RFCOMM: add minimum length check in rfcomm_recv_frame
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Muhammad,

On Tue, May 19, 2026 at 12:20=E2=80=AFAM Muhammad Bilal <meatuni001@gmail.c=
om> wrote:
>
> rfcomm_recv_frame() casts skb->data to struct rfcomm_hdr * and
> immediately dereferences hdr->addr and hdr->ctrl without first
> validating that skb->len is large enough to hold the header. A
> remote device can send a crafted short RFCOMM frame over L2CAP to
> trigger an out-of-bounds read before any session state is checked.
>
> The FCS trimming code that follows compounds the problem:
>
>         skb->len--; skb->tail--;
>
> If skb->len is already zero the decrement wraps to UINT_MAX, causing
> skb_tail_pointer() to return a pointer far outside the skb and
> producing a second out-of-bounds read when the FCS byte is consumed.
>
> Add a minimum length check before the header pointer is assigned. A
> well-formed RFCOMM frame requires at least addr(1) + ctrl(1) +
> len(1) + fcs(1) =3D sizeof(struct rfcomm_hdr) + 1 bytes. This single
> guard prevents both the header out-of-bounds read and the skb->len
> integer underflow.
>
> Note: SeungJu Cheon posted a related patch that adds equivalent
> length checks inside the individual MCC sub-handlers
> (rfcomm_recv_pn, rfcomm_recv_rpn, rfcomm_recv_rls, rfcomm_recv_msc,
> rfcomm_recv_mcc). That fix and this one are complementary and
> independent; neither subsumes the other.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
>  net/bluetooth/rfcomm/core.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index d11bd5337..6b300237c 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -1741,7 +1741,7 @@ static int rfcomm_recv_data(struct rfcomm_session *=
s, u8 dlci, int pf, struct sk
>  static struct rfcomm_session *rfcomm_recv_frame(struct rfcomm_session *s=
,
>                                                 struct sk_buff *skb)
>  {
> -       struct rfcomm_hdr *hdr =3D (void *) skb->data;
> +       struct rfcomm_hdr *hdr;
>         u8 type, dlci, fcs;
>
>         if (!s) {
> @@ -1750,10 +1750,17 @@ static struct rfcomm_session *rfcomm_recv_frame(s=
truct rfcomm_session *s,
>                 return s;
>         }
>
> +       /* Minimum valid frame: addr(1) + ctrl(1) + len(1) + fcs(1) */
> +       if (skb->len < sizeof(*hdr) + 1) {
> +               kfree_skb(skb);
> +               return s;
> +       }
> +
> +       hdr =3D (void *) skb->data;

Let's replace this with skb_pull_data.

>         dlci =3D __get_dlci(hdr->addr);
>         type =3D __get_type(hdr->ctrl);
>
> -       /* Trim FCS */
> +       /* Trim FCS - safe: skb->len >=3D sizeof(*hdr) + 1 >=3D 1 */
>         skb->len--; skb->tail--;

It might be a good idea to check if we can use skb_pull_data here as
well, instead of changing the tail to then use skb_tail_pointer.

>         fcs =3D *(u8 *)skb_tail_pointer(skb);
>
> --
> 2.54.0
>


--=20
Luiz Augusto von Dentz
