Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92961DA62E
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Mar 2025 13:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743427867; cv=none; b=Qs1ZaIkHJ5r71QfIUTXThdqzoUxhdA6XP4POTs6f72i4MNMc1o9pcT21C34QV18urUPTBzOuq+DsLl+xYdc8TfVZz09YTc4OlXQbCmiNdkH8j1MU/Psy1fwX64gjZnEow8Qa4BDEwy63AW5KroUh7y27GIuSwmR0uFoTjFtEjsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743427867; c=relaxed/simple;
	bh=I4GIdgHpQDlk/gLzmjx53w1yzF4uRbYkAReI/4NDzOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gDPI/wFiZUtmpGafhiOeUf/QdKezSy50juODc9oqxl4hURVH0IcxTEAsg6MxUx78gfJ+Fb2LZlPcRt3U5sWLKulBpRmc4COkX3IbY+HO9uOD07nBzhnqfXB+G6vSWCYIhOzpFjecH0AMG1DwV1xo/V67xyQDvBdr8ZywdZMjppA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDErJdFt; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDErJdFt"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30bfed67e08so45992411fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Mar 2025 06:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743427864; x=1744032664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=duKBoxpOiUynUmmSMoqEL0gS9RLQdGFoqsrHijsFxgk=;
        b=gDErJdFtwt+eqvGXo8MXP6p7cplepo8o+rOrbuQxM4whGu5x4lLo3xaa+QmK0y+hry
         aVlC4HIQ3VmwkQJFT7ShAWFmXfHA3sfY85jDiS1Pi35ezrJQXoXQjbvlS/1s+IRfZA4Q
         MQQJ2FQwplLFEcWfNJlZI8dB+e4WTYqGYfDmQFIUnTSU7ljGJEckup4lpbTNLqov2CSz
         dxtjPtpP0BG+HoDuUD5KmoTJR2eLKNWkOJOV2/Pc08SCQA7LsskP7C3g2QaGsmPAPSsB
         jzlGPiGmeN2Q7+gKiaHfrekrHQbaC9tFqJxCTE0yE6qlj/DnDTLSM3JkCWvXG4IIy1xO
         2/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743427864; x=1744032664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=duKBoxpOiUynUmmSMoqEL0gS9RLQdGFoqsrHijsFxgk=;
        b=NRnIEtt525WRU7BNM3z+r4sjxEG0iES3CbQC7GXTCEZ+q4Ng0ZOKwG3uNiPtn5oFij
         lAuGNwOzd4V90UTmwIieNx2MZYcb5SuHy3B91syAGAN64pWMJ673sfWk6SHJwE7dY/JH
         51aj+MOSyKXIaOFTTdugozgKPDPHChVPZpdCemRU7oDCqQ8Bdy4ecIvoOQaXi05k3BOJ
         JuV2X1K6ikEumvUQ48PAPQnKDiySablBcKK/yq5RzVoWce8RJ523DmHKbkGxSNt+FzJw
         xFVPGuR6gODPjL7EDCRfwgHN7dwCrSxY85YjkZoTUD/Z1jYpimP2uikwi2RAIARVsCab
         q5FA==
X-Gm-Message-State: AOJu0YxmTUBRpf+byLsXBz695pV9G6ZDxV60+oz2HOsxVihgu1DDLMya
	PKaGqjWwoC9txMr5TidZ0BDIb0Dj6xwRY6MqcXv0ufRU0h4jRftz/nEQrLItjYznVwP+3mhHNjn
	Qmr7DZlXAwm6u6iaMbLHTDFKH4OpL0g==
X-Gm-Gg: ASbGncsLXtstf+hctYykXoQvIxz9waBDb3R5vrVDJxd2aSB3zpkKJeMYtTl0zfEFpDV
	uniuaZo3lQkUHEDbcjGfgEItkADIptxdPe9Qr0+sxnNv5LGeLzCTGNPR2ej7P8v2tcW+jeRt5d1
	Ejh6UW8QcraE/WAZYPTeZFxIWn
X-Google-Smtp-Source: AGHT+IG2vVnkr5C64H1gpccAjb4ia0fHDDmNJogHwE7vU89oYkdrHs9A8suqDtaqI2m53XIuku43LnBEaTtC+xUq9Y8=
X-Received: by 2002:a2e:924c:0:b0:30d:e104:a494 with SMTP id
 38308e7fff4ca-30de104a5a5mr21615601fa.38.1743427863595; Mon, 31 Mar 2025
 06:31:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331131503.63375-1-frederic.danis@collabora.com>
In-Reply-To: <20250331131503.63375-1-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 31 Mar 2025 09:30:51 -0400
X-Gm-Features: AQ5f1Jo19QFw5M1sr_TphCVYCpcjl7ULj0xNd-fDlcPQYCsr8qm2_qPCez_320o
Message-ID: <CABBYNZLDMhwzsWR9A0YWyvZxo8G3kubRubwz_DAT83ko24Gc+A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: rfcomm: Accept any XON/XOFF char
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Mon, Mar 31, 2025 at 9:15=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> The latest version of PTS test RFCOMM/DEVA-DEVB/RFC/BV-17-C
> (RFCOMM v11.7.6.3) used unusual chars for XON (0x28 instead of
> 0x11) and XOFF (0xC8 instead of 0x13) and expect a reply with RPN
> parameters set for XON and XOFF.
>
> Current btmon traces:
> > ACL Data RX: Handle 11 flags 0x02 dlen 18
>       Channel: 64 len 14 [PSM 3 mode Basic (0x00)] {chan 0}
>       RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
>          Address: 0x03 cr 1 dlci 0x00
>          Control: 0xef poll/final 0
>          Length: 10
>          FCS: 0x70
>          MCC Message type: Remote Port Negotiation Command CMD (0x24)
>            Length: 8
>            dlci 32
>            br 3 db 3 sb 0 p 0 pt 0 xi 0 xo 0
>            rtri 0 rtro 0 rtci 0 rtco 0 xon 40 xoff 200
>            pm 0xff7f
> < ACL Data TX: Handle 11 flags 0x00 dlen 18
>       Channel: 64 len 14 [PSM 3 mode Basic (0x00)] {chan 0}
>       RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
>          Address: 0x01 cr 0 dlci 0x00
>          Control: 0xef poll/final 0
>          Length: 10
>          FCS: 0xaa
>          MCC Message type: Remote Port Negotiation Command RSP (0x24)
>            Length: 8
>            dlci 32
>            br 3 db 3 sb 0 p 0 pt 0 xi 0 xo 0
>            rtri 0 rtro 0 rtci 0 rtco 0 xon 17 xoff 19
>            pm 0x3f1f
>
> Signed-off-by: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
> ---
>  net/bluetooth/rfcomm/core.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index ad5177e3a69b..0c0525939aa0 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -1562,23 +1562,15 @@ static int rfcomm_recv_rpn(struct rfcomm_session =
*s, int cr, int len, struct sk_
>                 }
>         }
>
> -       if (rpn->param_mask & cpu_to_le16(RFCOMM_RPN_PM_XON)) {
> +       if (rpn->param_mask & cpu_to_le16(RFCOMM_RPN_PM_XON))
>                 xon_char =3D rpn->xon_char;
> -               if (xon_char !=3D RFCOMM_RPN_XON_CHAR) {
> -                       BT_DBG("RPN XON char mismatch 0x%x", xon_char);
> -                       xon_char =3D RFCOMM_RPN_XON_CHAR;
> -                       rpn_mask ^=3D RFCOMM_RPN_PM_XON;
> -               }
> -       }

So is the assumption that we don't need to check the actual character
sent part of the spec? If it is then it is probably worth quoting it,
otherwise I'd update the check to include both old and new chars.

> +       else
> +               rpn_mask ^=3D RFCOMM_RPN_PM_XON;
>
> -       if (rpn->param_mask & cpu_to_le16(RFCOMM_RPN_PM_XOFF)) {
> +       if (rpn->param_mask & cpu_to_le16(RFCOMM_RPN_PM_XOFF))
>                 xoff_char =3D rpn->xoff_char;
> -               if (xoff_char !=3D RFCOMM_RPN_XOFF_CHAR) {
> -                       BT_DBG("RPN XOFF char mismatch 0x%x", xoff_char);
> -                       xoff_char =3D RFCOMM_RPN_XOFF_CHAR;
> -                       rpn_mask ^=3D RFCOMM_RPN_PM_XOFF;
> -               }
> -       }
> +       else
> +               rpn_mask ^=3D RFCOMM_RPN_PM_XOFF;
>
>  rpn_out:
>         rfcomm_send_rpn(s, 0, dlci, bit_rate, data_bits, stop_bits,
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
