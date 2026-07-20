Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43627429015
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784556652; cv=pass; b=a/Og86P6bbY24VBwkuQK8ljbRJ/zL+Qf3gFV+9YQ/R0hEtoZctqvHYmDKrI5EsD49EoBFQWvOLxhuGZMjaA7rTitpwkvDrLHwAMdtSsj3lJxAEdoNGNMrqJeh2/C05S/0s6sNkAzquDoHepExUF6y+rB1uaQ/fyDeM5scGQcM4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784556652; c=relaxed/simple;
	bh=U2EA2MB3ae9KEadk4B+b3u7NLWMnRQ4hRKtTinDQ0hE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZAIn0/VwJHYGsN8UF4hMwO3tqbKkM64r3vt1mA9I2VDYy1mLm0lNsaPpXBofUSvPBKfNBpcahaJjiyO6IcsnmnkLynSSlbzWuz0rp8HO8u5i7k7Y2V1oT/IpXtjdUOj3OP4YWbtwV7ekaNJVV2NJAGCwHNiOxz6/UnVz6xeTO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6J3g6So; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6J3g6So"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-80a123ef90aso55925967b3.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 07:10:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784556650; cv=none;
        d=google.com; s=arc-20260327;
        b=M0wXLa/FS33iusxk2FoEIzf2l1yEk8dTAEDZToeNAr8t7LBQRYam9KAlvOpCMb33rQ
         b4ry85LvHFn+LGo45ITVjgIVuKB4ohvuFXaqoGhkXQx95pf5shTnxfMM45Iu1rdQnMKO
         KUbDSulmYKi0YhTSJb6GMHCFvgRiJYINbxPVNnIqaYxt4FExoX1Ab7iAnhXulEqJn+p4
         pcy879iUGG7EVFrMxUKTBlzugi023GvC8WkRMQn7r/bFXMpu/czgbU4jk+we28BFATqR
         SDge40b6/LoKZug1aVjfXYHlLWBwWjUhhsXN1N6B3HhRWvS+uBTXA6JHXxh0dem6aA7j
         km4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=inHJwBwNfOgxc+TrPzs6N4XULVKjX0Qf1MYheYO3L0g=;
        fh=o0nTRqLI4TQ8eMTT3c6p2UQ23PD7jlumF6oGp1uTkWg=;
        b=h/4yrtTX4uYzJ7Fqu87BgjB64ib+RXHTCe5FhU+2aa0XWrPWGGspBOypJvTv2T4wcz
         KnIbFm9XlV7GUjCXX8mtrpTziodMCgVY2r8TvOOTSePJeiVlx1VlgA0O9PiPq/GGPIPk
         Qxv1IDtGGeQZguF3NRa7hepTqb5BQ35ENJIN8VuxY0ysTbNfXyFFlkpAHWNvd76NGSMh
         b+0Rj0Sukk5yu+mSU5HrTr9YsQ4KQsdDSkLY7Jn9lJEBDt9OVH3dbGEEMTef1ZPeF92/
         FCRzIE+ypUqawHdYH+dYOZQ4ZevUDXZErzRZ0MMWhsqG6AHhx6REeb1IXyBzEeBp9OL7
         lHRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784556650; x=1785161450; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=inHJwBwNfOgxc+TrPzs6N4XULVKjX0Qf1MYheYO3L0g=;
        b=I6J3g6SoExvNjSaWpnSDw1vvJ+QQv+ioazwF9nkL2UhO8HQ7Izz46Oere1Z+I5q6Yc
         djznP4FbxX0B2ZXTE7wjo7eTt5BYXpk12alUDcOwhOfV0jR6du3otMBnsmmNnzl2y3R4
         8KahLA4grHCSVetmvsGk67ujTzQr8+SjA88/2W5gv/oOwbIo0Uvk4yRWqWirpjIpEWFU
         d0cST22OcZ1288vCyNpNPgoR1fthrRs0XSE1yK6W3rH4/azpS2cL/ugCVb4LNNK0xqvx
         5mo7FIRPALZFS1HUKmB6/qen5AkecTFAXQv31w2TGFbcLucVhRcyBuMTjtjzkSVF8KtA
         UO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784556650; x=1785161450;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=inHJwBwNfOgxc+TrPzs6N4XULVKjX0Qf1MYheYO3L0g=;
        b=jZC3GTZG1Zl9JGD8F74OZALH+7bzotmOQ8QVbVsfxzJhxCedfOyvB0Pkh/PvnjurX/
         75HaZev8uCcN269UcqbZDJVlDSXPls+5JVZZeRNJuYbaO2Zvri8df2pTLRStrP8rb4XO
         QCMZ29FHVVCH2Zkn1xeHs/hhdIceHPAnksqa0HIz10syhNwcfnVbKaepdJlmE7CMv7ZV
         tXQyGHP7BphyFAcUd/GpGe0o882B/T+TJlLu3SBuAXoBep1WA00SKhjwF84gAZLXz6Kd
         yucD2jAHCzntD7AMTX96/dunNQUXEvOV5pW8brJiJ+5y2GiJ+CxaaGzOE56p4yw1CQ8P
         5djA==
X-Forwarded-Encrypted: i=1; AHgh+Rphneu8jGKOTy1ehsEFmXToxFdZfUdf1U1CUb4+dfUeaAKpDIHmuyiI0lAqbDzXeJdStf5zeHLP3PJazvstKeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlHNZa9odOs2+2q88UVUqj6SUEWKQreEOPKWNoFHGZm1QxNzKE
	59TDYWbeDMlPrLZ1EL/ghUQ1k3eVEOPTY3U+r3XG8mgmYb6h8wdxcedet9ZtFw3Xw9IhtsrCUD+
	EhaKuU9CC9qO3nxf4jybEJaWidH1TrGU=
X-Gm-Gg: AR+sD113cujID49NfRxDyuM90WYVwAvVmylIhqtvk3kdG6QAYtzgDPEkWFsB+JO3cwI
	2IewwDz5nJ5ZOCwLGygkrGdIhYMgmCtTzPqRxtOa+X+QJcC8vxQIAC5L39C/UHfrii4K6lav3hj
	ZzUIEH0ls7YW6N0KQeA84EzlMRbcHbBPNM2AIE1vl6J3BrkwyNywPyrldiNqYA733QnWoexQQxe
	z8r81+C58pbM0Io4hiIvEgNXpgFZ7/IOBGWfi4CcRd2PE+hu6HAo/G/sFDHhv097Bm/7No3svFV
	v+RRjq3YI2JqSagtL/VzXitxatCPhxWgzfNED3PTuWZ4DQeA034qBhE1
X-Received: by 2002:a05:690c:4983:b0:80c:16ad:2f16 with SMTP id
 00721157ae682-81ef1499635mr42679007b3.8.1784556649975; Mon, 20 Jul 2026
 07:10:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260719-vendor_hci-v1-0-df2ac5a50117@oss.qualcomm.com> <20260719-vendor_hci-v1-2-df2ac5a50117@oss.qualcomm.com>
In-Reply-To: <20260719-vendor_hci-v1-2-df2ac5a50117@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 20 Jul 2026 10:10:37 -0400
X-Gm-Features: AUfX_mwC55okHxqYZHA2Rdh8HYzyPyK9rxSw5iZYAhSWVf65kWBSV_lXRnyxwbc
Message-ID: <CABBYNZK0RSZ6xOgkx=wcme9kUWXFHydAvHR+EXwkp4eJwp-QKw@mail.gmail.com>
Subject: Re: [PATCH bluez RFC 2/3] doc: hci-protocol: Add sock option
 BT_RCV_VENDOR_PKT for HCI_CHANNEL_USER
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Zijun Hu <zijun_hu@icloud.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 20, 2026 at 1:41=E2=80=AFAM Zijun Hu <zijun.hu@oss.qualcomm.com=
> wrote:
>
> BT_RCV_VENDOR_PKT was introduced to support vendor HCI frame.
> ---
>  doc/hci-protocol.rst | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/doc/hci-protocol.rst b/doc/hci-protocol.rst
> index db10b35df736..91cbc5b65a78 100644
> --- a/doc/hci-protocol.rst
> +++ b/doc/hci-protocol.rst
> @@ -136,6 +136,24 @@ Example:
>      len =3D sizeof(mtu);
>      err =3D getsockopt(sock, SOL_BLUETOOTH, BT_RCVMTU, &mtu, &len);
>
> +BT_RCV_VENDOR_PKT (since Linux 7.3)
> +-----------------------------------
> +
> +Enable receiving vendor HCI frames, requires hci_channel to be set to
> +HCI_CHANNEL_USER.
> +
> +Default is disabled.
> +
> +Example:
> +
> +.. code-block::
> +
> +    int enable =3D 1;
> +    int err;
> +
> +    err =3D setsockopt(fd, SOL_BLUETOOTH, BT_RCV_VENDOR_PKT, &enable,
> +                                                    sizeof(enable));
> +

I don't think we have any socket option with this name, besides this
should really go as an HCI packet with an H4 header set accordingly.

>  RESOURCES
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
