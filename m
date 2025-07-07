Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3226929C35B
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751898002; cv=none; b=RgXcvX4LIY4Rff6IMfcHmiqSKZftKW/hlFRrc2KejkBwhDCwMkUT07EYzlTdwa3K6BdnYywer1MbvGEcgVzACAdPUoFHpDi+xsOCRbMTdtYVprQh5AdYZcXhte9qtGLYtQ4rOw56dETjZCabSy6nGV6UY9Mh/qgxrzyqHuXGnlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751898002; c=relaxed/simple;
	bh=8Vw6asJHHDqdg58i3u+Dzug/w7Oj82KlIgczcan58mI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOAW/Otwp7cg43Fo7Xc2qSZ+mqRMK1bZrMok/6m+2eCfRDFTOixCctPu3nkGI3HziVB5jPJeSMolyrDUjn1Cds7Oc1qjfwTkqWqDOtuw+TlONr6VfakzDIw68pd263vwJ6wYuYfkcnTWhaTjJ0RbMv9Fu/6tSrrLZfWhcn//p4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOMlOUUh; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOMlOUUh"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-32b5226e6beso28898541fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jul 2025 07:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751897998; x=1752502798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kXKLT4bdoQCL+3oVI8Lk+yQ1MIWzwcvvLVXRb158vQ=;
        b=jOMlOUUhagvsfzGGbYLE21AnAt89TA9fPhoYdPeJYYfMR0eYSKa4UEiegOjHjJQo3Q
         ErfXBJynaZ281ucdKhVFXO6+QC450FMorcTbe8EkDpssMh+WViHAp+qWTYSRRbbA0Zpn
         2oRyoj24woJvpu06eND2696lV8DXC1W6B+4LTsFee9NU6Q42yUF/2cyHVxFpd53KMSTK
         MOETip7Nh7xzmDCt3p3JCw++nomXuAgrCPw1sPtPVVDlanFxHOBAlcGL0aF1Crt9CJE5
         0o1HaQmOUQGR2/wZnQRKjP+ByeXH2v31E3al5qvHvUlAoqQG6mCNx0GzFmpNBSVHNuEy
         RXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751897998; x=1752502798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kXKLT4bdoQCL+3oVI8Lk+yQ1MIWzwcvvLVXRb158vQ=;
        b=w1fGuF0J5aTUdpshkuCkfC7TpzuX+lZoSUHAT/xjuLsLkBNFphhtUcE3AWMOs6pKRI
         97d7corsjxZsuYcNHQFxppRGUWs4oer1orU1ZSdPsrDviaccX2gMVZbKbSgCAgf1JpPv
         3yuaVdLPjX68FKBJV3GM0iN2Gef8CU/oja+XnOpVEqSnszwVYhPD3ALkAmkCkeDjTqGh
         PAGRplJ3jdiMjIeS7hV1SZEqhvyA84coms1Sjb7nsVjOaD7+qCo77vc9vt+kVn+GkBo3
         tLiuyBxAur5pwVB+yeNw3prhBi7PHv3D1I/tNkSU7JLBvnw++l1/2L/YaRqkS7kpdp56
         GziQ==
X-Gm-Message-State: AOJu0Yy9bGJwqffRGWR1bZEt1VD2cyWu6GDTz4qQiyVesQWMRykDOXRi
	58YndmW73aUfLxlo+G7gAKGx1p2CGo1qmjRB0qwLL1Ob/7wtnqjD81oLjNxoMdO51ci/lm0eGJc
	06bNwPv/tjHoKvC7Eu1nywfCVJs+gMRr42p3JZJc=
X-Gm-Gg: ASbGncteVMkNmdf6evq9d8ZaBWlhNT6Mp3sChCEcwTrukA+E7Y1QgcbE7xvUqEDr+Cb
	sZePnNIG84+rVX/M3WlTLmWIPaZJXVtUWdTPUffxsKzEwBYyIKf1LOQf2EN5gDbxq61XOigo5f/
	cMUgBCJTBpj53dJ3EahoRa3vZEEsVpus9W6Pl+OTnUZw==
X-Google-Smtp-Source: AGHT+IFANSIUojIVsSstImYncf6y1BbFL9P9f4qAbNdVnO6cXFcpIl2TwIqPGkAfBKulAISIJgCd136Qp2z4Ndc1WrY=
X-Received: by 2002:a2e:8a9b:0:b0:32a:778d:be76 with SMTP id
 38308e7fff4ca-32f092c6cb8mr17002421fa.26.1751897997759; Mon, 07 Jul 2025
 07:19:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707134958.72368-1-frederic.danis@collabora.com>
In-Reply-To: <20250707134958.72368-1-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 7 Jul 2025 10:19:44 -0400
X-Gm-Features: Ac12FXwbqSPe8sp2iEoxMF4WcY_2mA16Ci3ez54HbLX6OPLvCt8Kdc-plq5sbn8
Message-ID: <CABBYNZL7ZDFJvBZSU041pR5-qMU77fYL46tQbdceMBsA3KrJyw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] audio/avrcp: Fix crash with invalid UTF-8 item name
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Mon, Jul 7, 2025 at 9:51=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> As stated in AVRCP 1.6.2 chapter 6.10.2.3 Media element item, for the
> Displayable Name Length property, the target device may truncate the
> item name:
>
>   Length of Displayable Name in octets. The name shall be limited such
>   that a response to a GetFolderItems containing one media player item
>   fits within the maximum size of PDU which can be received by the CT.
>
> This truncatation may occur in the middle of a multi-byte character,
> at least with Samsung Music app, which triggers a DBus assertion and
> crashes bluetoothd:
>
>   profiles/audio/player.c:media_folder_create_item() Din Dhal Jaye
>       Haye with lyrics | "=E0=A4=A6=E0=A4=BF=E0=A4=A8 =E0=A4=A2=E0=A4=B2 =
=E0=A4=9C=E0=A4=BE=E0=A4=8F
>       =E0=A4=B9=E0=A4=BE=E0=A4=AF" =E0=A4=97=E0=A4=BE=E0=A4=A8=E0=A5=87 =
=E0=A4=95=E0=A5=87 =E0=A4=AC=E0=A5=8B=EF=BF=BD type audio uid 1
>   profiles/audio/player.c:media_folder_create_item()
>       /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item1
>   profiles/audio/player.c:media_player_set_metadata() Title: Din Dhal
>       Jaye Haye with lyrics | "=E0=A4=A6=E0=A4=BF=E0=A4=A8 =E0=A4=A2=E0=
=A4=B2 =E0=A4=9C=E0=A4=BE=E0=A4=8F =E0=A4=B9=E0=A4=BE=E0=A4=AF"
>       =E0=A4=97=E0=A4=BE=E0=A4=A8=E0=A5=87 =E0=A4=95=E0=A5=87 =E0=A4=AC=
=E0=A5=8B=E0=A4=B2 | Guide | Dev Anand, Waheeda Rehman
>   =E2=80=A6
>   arguments to dbus_message_iter_append_basic() were incorrect,
>       assertion "_dbus_check_is_valid_utf8 (*string_p)" failed in
>       file dbus-message.c line 2775.
>   This is normally a bug in some application using the D-Bus library.
> ---
>  profiles/audio/avrcp.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 831f1dc8b..65b40c57f 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -2598,6 +2598,19 @@ static struct media_item *parse_media_element(stru=
ct avrcp *session,
>         if (namelen > 0)
>                 memcpy(name, &operands[13], namelen);
>
> +       /* Truncate name to the last valid UTF-8 character */
> +       while (!g_utf8_validate(name, namelen, NULL)) {

Not really sure why you are doing this on a loop?

> +               char *end =3D g_utf8_find_prev_char(name, name + namelen)=
;
> +
> +               if (end =3D=3D NULL) {
> +                       name[0] =3D '\0';
> +                       break;
> +               }
> +
> +               namelen =3D end - name;
> +               name[namelen] =3D '\0';
> +       }

This might be a better approach than what the likes of name2utf8 is
doing so I wonder if we should replace that as well, that said I'd
suggest we add something built-in e.g. strtoutf8 and then handle the
truncation in a more generic way.

>         count =3D operands[13 + namesize];
>
>         player =3D session->controller->player;
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
