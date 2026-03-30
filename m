Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502FA39A7EA
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 19:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774900281; cv=pass; b=Uc7fTNjVlp2zc7eK9WM1ZjXpTVVMHkeCnKAO+S2++QdnDEHzhliMKcSLeMPvyzzXtltKdVog4vOW8E98ZzTXU+xwA7hPMvMJwh2PiPzOjliSicQcPXi4qJaxqL/5qBX6vWx8i93Wwl2YX9JFIK+piNb6L+iXgE1b/fax8U7uU3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774900281; c=relaxed/simple;
	bh=XFJO2FiqDjQ+65cMKQQnolCljbLx8VyXTGABvPVGFgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RWHQsijnpI1sKPBBuqUvxGdWFLD49a1XN/vKdOmt5/6CCsFLs99gd+Lj0K337l3Ml4uybTohOoTyVNfBghIYX6ym7CvZDv8Kd6BXR5R1O9pe+YM4nEWaxtUVgFnLCQDpldOzCEIFVIPvO2+KO4xxVG2a6Ae9hx+f2z6O7kpfKYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7EKWLRB; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7EKWLRB"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-650182d19e0so2695343d50.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 12:51:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774900278; cv=none;
        d=google.com; s=arc-20240605;
        b=QANZV/axEo2zeuXgx7lYLDevnoGMKVrkrUN2FwQa2HUkThS9pc2m2nwSce2zjf9vE5
         D6Ya7NpKI7hSA1xDPuM04B/bGDh8mJgJuFJK0diZL7VSX3FSgT5SVFC3fNrG6vn4zrC6
         TuhowjQoMpZtHaI+sQXX5UHnTa2pUPdsO1a9sPHc0ktK2WG1QB/hwm6MSt/poZgMcM6K
         /yZS0Ur1DBJOb78AH4cP+YQ3rbQyntguiPm2uewy/3vBr392g7q/7Z9jyafhPmDgb1NK
         TJyS/+q7tGr0n0ax/MQtjDBl9Z8pxXnz/EX1zTs6ABLQcCdAb7/vZMtTSfw3SmocGfws
         C1EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XfKNvyS7K49qe0UCAo+yyDfQl89msPOaI9UN+hDNaDA=;
        fh=LQfOhVP3dW09eNCOvmq0FqCwKcz2BUyF25XiqUPTamw=;
        b=MUXqCohgrCZ9dkji92g2nOsoedUn5r+TK+Tw7M2SOsLT9lZ+WCqpGM6dWdBJ2I5kwR
         6SM1vkDrEt5TMgb1iFlrYUFortg0w1nOCjcSe/a38X85U2Kr0EIpku1YSpdiUsydRC8T
         cQ3Nr3oBm9STLdwY+a0S/Le9jiIjaD/9cAjMuVTXsmxHTN0E1HrCVmSmjM1PhhuutoRb
         j+kPPXUVcb/5RYAnrUXfkEKoQQGW7Cn5CkmRrevyqXmLgP0p85ylWYefUtIYtoQsPuH+
         qQ5vyGRZLCl48MYXnRr+5lN57UJeE6ZZJTNgeqmIBzBNLlOD7Xun69eatpPby7WcoWV6
         FIGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774900278; x=1775505078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfKNvyS7K49qe0UCAo+yyDfQl89msPOaI9UN+hDNaDA=;
        b=a7EKWLRBIAw3fGpKr+Y6KyKnN7LUnrkwd+9qSnFeNMIXvuGb2dFxPGmzk9RT0lcECx
         TjN42CWu6LjwAD6hlpsS4ZrOvDGQZghIZtWilo317SrMB40fdcR4lxvBLbuwwpW5nH6N
         IJ3y+GY74HWXg4NNCsI7PTg4cD3WVYy73MHtdVHLFoR/3TiIQbbYnpH1HDg4ZOIxQ21d
         L90QzudmnOUuLbwgaXzmvt5muVvSEDT/+Myjs/0HH3oaKQCDtxAFjH7EEygdeEOW7NI9
         BtWKjimARjDKYPVvPVYdpZ9noDNyZYhkK3tNhU0B6jEYEeXfUWu+3uhDxnbDAmqtIns6
         65dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774900278; x=1775505078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XfKNvyS7K49qe0UCAo+yyDfQl89msPOaI9UN+hDNaDA=;
        b=Gh7B7RHaZGH6SkOxijzcXKXA9edq30TIQNG62nB6myFjVxOTT1/6mV4728J0El79UO
         Sn9MmbaOCMBx7j41KOx6ICp50iSN6ec6lojQUZAtPVwP7WsEzBrixVnbwhoQWvMCMyis
         O24LuynqU8ZRd5xbR53BJcatJpNKx5XjaoVn7Mu+KBJDUVcjecG0YIusuHDPaxH11XDE
         yuxXlYs0krc5jTPl438UJrHoUVrItzN2om/oZ0jK5MA+uamxtkLBXY/RRZjBlaBslJrd
         nUA6ob7J8/gaFEcbIx1SI5D/cfnczOhffqbsBrPdKXMGPCq5JLkL5T7iCaOEL6J/PFra
         wwPg==
X-Forwarded-Encrypted: i=1; AJvYcCVy79DYNb3i2pm3xvQ7H4j8qXu7i+Z3qQm4mg7iSv3GZsuZ9gtqg/5K8c6OhntI6iicDyldbYwN7SnFsegjgPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6fVFrr1WYhAwj2NB5aJd1swN3BmqaqUL0kDkFuxDBgd44KTWd
	xHa0Mss1DDdnRy60sRmiI5sZny9QiOkzD/RCGrIcwzuxiFT+HTn+YOHWG6A+p6hLBL6qPILoLwL
	21ztcaK0tfBbSA+4YJmYDLRgf80CHVIM=
X-Gm-Gg: ATEYQzxSAH2WHRyxoNqxmjn6fM02IIdRffdERwO+/b9RJ3Sw8cnACIvqpXuZ4j9YYci
	U3B+gq8FwcdwPBN6fdchc8XcuKO7xBwJB4Iu+9UNYQN2QDUX0wtLH1kAusHgNhtasUdYVc77fdf
	ZC0o7nankIrPJxoapC2lSTWKvdpFTB4o/1U3H6+ZtW9MzC23BaCnTuHXf8nQrKs+9VNArkvO/ci
	4HVURGrrRFQi2UEAHCyhrbwsrYAp90wBvbOfFB7emetUDjti/DHSogQ1CxdoNZQcpLurubp9z5J
	9MDFIJCcH+rREIcig8SEI5IZ2aTkFaJ9Fpeu0k7xJ25H0ZHvjY4ACw2MSLeS7tAcHbA=
X-Received: by 2002:a05:690e:1c08:b0:64c:a894:f723 with SMTP id
 956f58d0204a3-64ff7027e97mr14084881d50.0.1774900276530; Mon, 30 Mar 2026
 12:51:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKvcANPiqdO_Re3+06DWhb7uyKP+gCODJpo35sq5-x62gYJUPw@mail.gmail.com>
 <20260328200938.140528-1-xiaoguai0992@gmail.com>
In-Reply-To: <20260328200938.140528-1-xiaoguai0992@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 30 Mar 2026 15:51:04 -0400
X-Gm-Features: AQROBzA6KBl4EzkRU6poaG_SGJBRNepQU1Vk92F_42K5UY1gfxCQ9I_0GrAfF_I
Message-ID: <CABBYNZ+8UW62Qot6=ev2Mf-Kc6JgJYtxh0B3OdV2zXJx=N0m1Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: ISO: validate ISO_END fragments
To: Kangzheng Gu <xiaoguai0992@gmail.com>
Cc: gregkh@linuxfoundation.org, marcel@holtmann.org, luiz.von.dentz@intel.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kangzheng,

On Sat, Mar 28, 2026 at 4:09=E2=80=AFPM Kangzheng Gu <xiaoguai0992@gmail.co=
m> wrote:
>
> A malformed ISO_END fragment can trigger a NULL pointer dereference
> due to missing validation before processing. An oversized end fragment
> should also be rejected.
>
> Add the same validation for ISO_END as for ISO_CONT, and reset the
> in-progress reassembly state when malformed input is detected.
>
> Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kangzheng Gu <xiaoguai0992@gmail.com>
> ---
>  net/bluetooth/iso.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index be145e2736b7..8707f3c4b103 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -2587,6 +2587,27 @@ int iso_recv(struct hci_dev *hdev, u16 handle, str=
uct sk_buff *skb, u16 flags)
>                 break;
>
>         case ISO_END:
> +               BT_DBG("End: frag len %d (expecting %d)", skb->len,
> +                      conn->rx_len);
> +
> +               if (!conn->rx_len) {
> +                       BT_ERR("Unexpected end frame (len %d)",
> +                              skb->len);
> +                       kfree_skb(conn->rx_skb);
> +                       conn->rx_skb =3D NULL;
> +                       conn->rx_len =3D 0;
> +                       goto drop;
> +               }

I suspect this was not quite right:

https://sashiko.dev/#/patchset/20260328200938.140528-1-xiaoguai0992%40gmail=
.com

Have you actually validated this changes against any hardware?

> +               if (skb->len > conn->rx_len) {
> +                       BT_ERR("Fragment is too long (len %d, expected %d=
)",
> +                              skb->len, conn->rx_len);
> +                       kfree_skb(conn->rx_skb);
> +                       conn->rx_skb =3D NULL;
> +                       conn->rx_len =3D 0;
> +                       goto drop;
> +               }

Hmm, this is the end fragment so anything other than skb->len =3D=3D
conn->rx_len is unexpected.

>                 skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb-=
>len),
>                                           skb->len);
>                 conn->rx_len -=3D skb->len;
> --
> 2.50.1
>


--=20
Luiz Augusto von Dentz
