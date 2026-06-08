Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F047912CDA5
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780928637; cv=pass; b=JFZVxCxDDF6x+ChA3BUPdGlo1Vz1eOuC/wcjPpvzwuL4pUsNvNN/WU2Bc0uPg8w9cya4/FFHKfMSJZQukBmE52b2nCfEiBLxQHBovAjrXQ83Zb/0xsWJ8+gfoJaLj8kfu9+35vurNuPths1BqKyNoSz4jeKEstKJ0fQ+vai0CxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780928637; c=relaxed/simple;
	bh=QxueBsHXFQjSHyV/U7EvSE8NOt8T4849CGMBoHBQm1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O861bCqsL89yMaqv0UP3Fr4+L+TsII8SQZ/RnOHyXidqlg1XrHkn9KXkqeQZzrEq61xZjyJo1CzqamgHdw1YycJa6P1lC7lC9+kpxazKxVbjIAx9tuda9HXPdjsGC6DK2d57IEzCfqDnMF8OL47h2ew2y4/BmGKwmXfdWYyrJyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOW3XlBZ; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOW3XlBZ"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66062a414fcso4728336d50.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 07:23:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780928635; cv=none;
        d=google.com; s=arc-20240605;
        b=Yl19/qnCDm8es2CMf5iB3MgFYEy4vxOnjSQ6+2vM/L2Q1FTc0Kgckf7pSbwDptvko9
         kbIEjoly0d/fjMSupLffjwWTXySuwxfBK8QmlLPdq8TcGne/nDa73iMeQ8Osxzvff3Uj
         AtThkxaJw1zTcTkyDNyBFeQNQrfXYOl0hTXAFbh6shculHP1WA5FZEw0awipTqHgOiQI
         3R++QX4IUBNNFptWhIPMwrnymw6Qb31UvgOzW3tF64Ftv58KnTbxxI7q20UxszVH5oIb
         2gNvE4mqvwXk6nptmQWmzgN9Bhwm0p5lWLQMJbA4nFmVslL8JNxTbhU2y/NgJXelPc74
         RaaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EuwY8fP5zJs9qJWGIvB6LhZiAxbucgrNdSd9F9j+jIQ=;
        fh=tyq0gYhA4cMcqn+bWakZSAdnDDyh/si+tlAcgOGyoy0=;
        b=YQjoysTnGqeO3EnJKb5KC/guZ9WWFrvHb9IURG7hq/JKZPQJsiDRSouUkBwlVQLMQ9
         Pq/4Phzqj/m/Xrf9PVWo4n73t7lZC3TQNalNFldC3EQoGUabtMHSGBH3hRr59h8gWzt2
         W/PfiV0Qjl3Vta7y9YeLdBNHBJ5o3xFcNBO38ZFymwb4YFLYwqp+ktHCGKCnFDzFcdJy
         9kZ15TtCJ6ReAUloMIpDDZxdfW1drhZqmDqVYsG0lDYn+6NgY9WwXKQDtO6f6RMZnRyz
         Mmn1zk9i0TKKJeFLPzNjluRC/5vLkqGA0PSfSVMCuvwRPNgaQx3MOQQsjNC3W3Lz+3A0
         iCdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780928635; x=1781533435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EuwY8fP5zJs9qJWGIvB6LhZiAxbucgrNdSd9F9j+jIQ=;
        b=nOW3XlBZqgRkx+yjBDzH3db6caYEkRkeLK0cZDiRG8Ug2hbkfxKChZhMhcI09pPUD6
         L/pHOBiTmvpviy6MZnzrYVwcau58SX8UBo2cELlQvNvfd1K4EeY4ZXHfhWpmDoHa6c/B
         VGeiWsZr+VzQYs1Ms5819+phi3ztabt03PbtgACtJbU/i3zFhWSWmGXY28yzPmrSTEKl
         X+Mtz85Tp10TD6LQVppU2l/924Wd5XXSbDXZDfVrr9jEcAujVfjxtcObfO+wzQ8oR3kg
         7jgJIh8V9ufFSGJ+RT1JztOgtFRzEPNVp54C4Ii7zn6SMGfaQtuIhooCpx0YJCCjnBAU
         WwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780928635; x=1781533435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EuwY8fP5zJs9qJWGIvB6LhZiAxbucgrNdSd9F9j+jIQ=;
        b=QQyoS/ScP+8xQK/gVysd034gy3qpqujJSL+LvFe7clERIf6Ug6GuYyXkYh06MGIFkJ
         P2iFE/R7ks6QSIV22KhntgADz37CfhZcSZYNTAX4exoEXHkC/aKCzGiSwvkMopI5oPLm
         AOBTK6pSBgrTvzdCiRKXCZskFA5HiPs+/r6+t2Ao507EPMDYDuqCPbkBaG4Z0GOmkBni
         +CcWZohpko7cPDbprIYcTszbvW2pdS9unMpUal4YB6gO6Z3NWCRoVizMue/J3tsKiG/+
         7K5J7J1gvXzWS1YUgCYWTWPNWQiNeTq4Z0IsPNd9c6XjxGbCVyWnJOozd9KAm7M6S6mV
         4/vw==
X-Gm-Message-State: AOJu0YxhjX87QNS8Su2UalQUkb8NggXMewVpm54VbOryTbXj3nS/f4b3
	ibrlDdRnguwdrCAsUnhNwuzvm//h5dMZJC+mkZg8nPaQFM9mLoWVBrkk05gScPlXj80X0a09l7v
	B0tZqp9RnXAzpFr0sFYwQr7lUssgxKXM=
X-Gm-Gg: Acq92OFpfruGSUOS8fbsEG0GGVIyYTPe7/Btg1HXiarYK8eeDLaOn7Tt7vSahrQPex8
	JudgP7wMlUGaeYE5iirOG1uC05j1AtWxdensotHqInR9hwgoBzbIDI35mioUwGKB0WaEoH5zWqJ
	+x3/IheYHqnhiFdK/ok4aLnGOV0R/LQgTXeIplxj1DEXDG9O9N8xdD8T9ZlZy/5YMVJ6wwtM+IO
	9QITKfVRiW84LTLz37duOQyhdxaj8vmfNxDIFvkuTmqOrnwpwToKcc0aITY8C7Y3hQEK8gw5iQh
	vYYVBY0g7ReKJVnuD1QX41veabUyEkelJEB/lXXU5NBIuQmxoIAwHwAWS88HYAjCdLeSA6/YZho
	jPeXi
X-Received: by 2002:a05:690e:43c1:b0:660:8ae8:b98e with SMTP id
 956f58d0204a3-66106f43cfdmr9426340d50.35.1780928634870; Mon, 08 Jun 2026
 07:23:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608091140.3606008-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20260608091140.3606008-1-simon.mikuda@streamunlimited.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 8 Jun 2026 10:23:42 -0400
X-Gm-Features: AVVi8CctMTG4j3w4hWU75M0Xp0wP86Lh71XIpVYU8UiggTt5GH_fszRR9fv73ro
Message-ID: <CABBYNZLRz2iqR-eQNjXsJnyeZ8aONnjgaQDO6bRWVqfVy8SbbQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] hog: Fix starting encryption on some BLE remotes
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On Mon, Jun 8, 2026 at 5:20=E2=80=AFAM Simon Mikuda
<simon.mikuda@streamunlimited.com> wrote:
>
> When BLE remote doesn't reply with Insufficient Authentication Error
> encryption is not started.
>
> Good remote:
> < ACL Data TX: Handle 64 flags 0x00 dlen 7
>       ATT: Read Request (0x0a) len 2
>         Handle: 0x0021 Type: HID Information (0x2a4a)
> > ACL Data RX: Handle 64 flags 0x02 dlen 9
>       ATT: Error Response (0x01) len 4
>         Read Request (0x0a)
>         Handle: 0x0000
>         Error: Insufficient Authentication (0x05)
> < HCI Command: LE Start Encryption (0x08|0x0019) plen 28
>         Handle: 64 Address: xx:xx:xx:xx:xx:xx (OUI xx-xx-xx)
>         Random number: ...
>         Encrypted diversifier: ...
>         Long term key: ...
>
> Bad remote:
> < ACL Data TX: Handle 64 flags 0x00 dlen 7
>       ATT: Read Request (0x0a) len 2
>         Handle: 0x001e Type: HID Information (0x2a4a)
> > ACL Data RX: Handle 64 flags 0x02 dlen 9
>       ATT: Read Response (0x0b) len 4
> ---
>  profiles/input/hog.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/profiles/input/hog.c b/profiles/input/hog.c
> index f50a0f217..845087c9d 100644
> --- a/profiles/input/hog.c
> +++ b/profiles/input/hog.c
> @@ -189,6 +189,9 @@ static int hog_accept(struct btd_service *service)
>                 if (!bt_gatt_client_set_security(client,
>                                                 BT_ATT_SECURITY_MEDIUM))
>                         return -ECONNREFUSED;
> +       } else if (auto_sec) {
> +               bt_gatt_client_set_security(btd_device_get_gatt_client(de=
vice),
> +                               BT_ATT_SECURITY_MEDIUM);

So this forces encryption even without bonding; why?

>         }
>
>         /* TODO: Replace GAttrib with bt_gatt_client */
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
