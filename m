Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1EF319601
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 15:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776870948; cv=pass; b=l9CnZNhj6epvRt6vtScTZA2c4JJ2HWVCaqCQoAgAJNqPn4wPQl0wVa1rgVxrsmOHcX18ytD0lbuSaMeZPGdaeYNYqRmEk3D4XX9N2+PGhQ13PDlJeOeaBtJOgoAEMhymGVdnqePpFB0D1vZGi+1x37DVdTU8Dq+hROIPavKXDYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776870948; c=relaxed/simple;
	bh=Z/UXy/HQejHivz0qFPdoyrhBsrpSw7dRhbRuXv6gPgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fK9EK6fI3lU7DNFMHXist7pbboMS2BGkBG6ji5IeKHpiln8h60bWnMhosLN4BD/1gi4OZxWxhio58Wa4VYSC8BrFcJ1cCcDOaYSrMjzAwBL6R8aJheXGyozsCHHnTN6FGJNq9GRAFjFrZysOtTK+gwLoh8ehKhOt/Iqnmom5/9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRJjCFnm; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRJjCFnm"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-652fcd5a6d7so6198414d50.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 08:15:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776870945; cv=none;
        d=google.com; s=arc-20240605;
        b=CXdzt3VUIp/zt9x/1pnBZPccXpdeW4ceokJ1utrIVS9uMt5FQf+BFEwXqm1IwBzuvH
         Ug/0oQ10KGq7upeuN2Lk5US0b5QwXf1QzM3awvZTLscBGIX/0h65S+zhDjPUt+v+RQaS
         CQP9LV3AES8Bn0Zt9B6dwXfou6rwpMkCzyJUu+bRbZR4Tw1Kl3iF7YQ/3ca4dux0qAfp
         LZXjkW2vBZftaGt2k7uw06A9AmGRcJxPPoLdgPT/xQFSIpTPME8t8tI50MwUJjJSZ1AE
         ZHTt49lWJAe/Uu/CivrOXx/X25AG/7axcOJJ7DfSUvvdzodTAgm1/+kiKRgiOyAcdjau
         GQTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1PoAh/J3nj3CDSZmBmeHpN698NbI2/7cl+VxqRpHq6o=;
        fh=HuKfH8gPM1yKYK9vIWxVDIgQvEyWK0fr2CEOjEWPaHM=;
        b=UzQ85RXTi1Yu0ST5BJPnHgVtMwYW9Au1dRxvVBkS65rb2scbk5jqllqZZzS9+UIFW0
         SuetX2iSpUb/g9l3G/2+0hDuERxIPnNWv9YePYtosdYOUIAFIxdw8GQc5MK8b9qp1/DS
         iep9g3reos0JLenHLJsljLhqwG2DJzwxkTHxtCb3U0kOFGu7braZFZdJVsZBgq7wAWqJ
         RDLLLeibl/WdgiGR3Fs0H8HQrTiZtn6zLzj/Nb8gb32ZqowuOK+0vYbFQBoGnogJsnkH
         I6yd8w9KWY+vGpCPgnha0Mos1lSwNTZrTBc6AJ481USX5/Pk7M2jUlTN92TN/YIJ5CAe
         llAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776870945; x=1777475745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PoAh/J3nj3CDSZmBmeHpN698NbI2/7cl+VxqRpHq6o=;
        b=YRJjCFnmAl7tdC2bp8YBe547o0qy/eN4b3e06jSOUXurz2mryxUFz7/iXAF5DYsaKo
         fZGtBM7eynaGNLijPi2uDW+fCHjt0y05jlqBikaMu9rXrqFOyuhYSDTkGdtHAWiV7OAm
         FjABHp3BcoghRDGRxfTIOM1mUMNkugc+mr7ghY6C4tjKHjPp9bXYFb5NWtYdsXGDR2LB
         ndAjCBDj0NedVq8dYIBAiPz20zH3xE+iH30qWyZN8M7V1yI+YagI0KojRs9oeO36GvAU
         2d9YmyuFd+vSkcKDwxo6hdGuZSoPeqruMBSTeIGyrPhg47e+lclOZk9UrqeXT1N4PjfG
         f0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776870945; x=1777475745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1PoAh/J3nj3CDSZmBmeHpN698NbI2/7cl+VxqRpHq6o=;
        b=cUMZW8Scq8f+/NfnvQoSVV0wI1eYtoqMd9CNvtuSaNqQC77W3FQ7SeEi56FXreOM/2
         wcAbjutbPNz1QKb3V9prfbgOggmpW+4MnSvuT+cndsoPNBxWTsAQmpAyt+wpQhNrClwc
         jNgB6DFtCnwdem9Wew4DJmavLFH59UCajJQulfpEhFhS86TzAdslZVbp+wRjp30ZRT6K
         pTDB3BEj+ToVN4KbjaI5Bcf4GV5dBjJfe9jtfVyYfNrLTagcmy0UrBMSp14MNAOgTJfz
         QDH4SfDMHdubT1vTScUeowwz+Q9KWWr1J1X2LYmvBjOL47IpL1OOqZJc7c4Jx7/YIrUB
         50Qw==
X-Forwarded-Encrypted: i=1; AFNElJ8ZFv9HKETHvvBbc5hYIwzRJurYXloCXI+PRW8cU05qvPD4PK/y0f4danpA404LO5Oc5nebEMgbo6RRUnsCqmc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6NeGp8VbUTobkej6pyT1wMivXy9YZasssU/KQqMZVsbrm12Hd
	2RLuiluBqWMWIXbwTvwhD0P4YO+6ZFOZgRie6rGbCFYIJwW76i3nya6rdv3b2eAIfsR6vuOWhYb
	JR50cevFa6PBNFD7qVjE/qnt1dnY7HYY=
X-Gm-Gg: AeBDiesTKPKTkyaoKZzXtdnUDDtUJZPUVY9mgv0bwLrYhyRLitQqrEgDSmIFXvl3lXq
	E2ae4yTSXu1Wz7g+t+70fO+Eg/P7LmBmuE6LW7xSR/tMUUJVVU4CGqTu3Zn+t25iGMq8IITFOI6
	S422GlWYzShuK/bA/pL74XDuqvYKvD6Z+amTVoWhwliGU9+zyZZ+L/vMN2jiiMpufx6I8cIEx5T
	anOYbpOIurViMvxWQXmEliLfwZGNtlbMRmCHi10ndPiNkxQoJjo0lj2IJDGo9Ic1kmmNIiL8Ccw
	W9rfv2UtOiClEPG4wJysnPeB3TEOZ9f9ocypSj4zEQDeSX92u0YxKaP4UqrSmCBGFAecfS1Q4kV
	/BLy2
X-Received: by 2002:a05:690e:4802:b0:651:ba23:12 with SMTP id
 956f58d0204a3-65310b44a57mr14929239d50.53.1776870944393; Wed, 22 Apr 2026
 08:15:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417073446.95494-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260417073446.95494-1-pengpeng@iscas.ac.cn>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 22 Apr 2026 11:15:31 -0400
X-Gm-Features: AQROBzDEtLlLfuCjZiQcVuH0JEejW4K3jnT80IzUIwg18PITEP0TJQc8uuWiE6w
Message-ID: <CABBYNZLBGVon-4R=eW6NwuhGqfQ0E37BC+054rVhoeaiMP0sbw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: RFCOMM: require a credit byte before consuming it
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Marcel Holtmann <marcel@holtmann.org>, Kees Cook <kees@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Bastien Nocera <hadess@hadess.net>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pengpeng,

On Fri, Apr 17, 2026 at 3:35=E2=80=AFAM Pengpeng Hou <pengpeng@iscas.ac.cn>=
 wrote:
>
> rfcomm_recv_data() treats the first payload byte as a credit field when
> the UIH frame carries PF and credit-based flow control is enabled.
>
> After the header has been stripped, the code does not re-check that the
> frame still has at least one payload byte before dereferencing skb->data.
> A malformed short frame can therefore trigger an out-of-bounds read.
>
> Drop the frame if the optional credit byte is not present.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  net/bluetooth/rfcomm/core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index 611a9a94151e..964a78d473cc 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -1715,6 +1715,9 @@ static int rfcomm_recv_data(struct rfcomm_session *=
s, u8 dlci, int pf, struct sk
>         }
>
>         if (pf && d->cfc) {
> +               if (!skb->len)
> +                       goto drop;

We can probably use skb_pull_data below, which checks skb->len.

>                 u8 credits =3D *(u8 *) skb->data; skb_pull(skb, 1);
>
>                 d->tx_credits +=3D credits;
> --
> 2.50.1 (Apple Git-155)
>


--=20
Luiz Augusto von Dentz
