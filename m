Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794412223;
	b=G6G5lNyP6/gcSYXb5UHxNNgMiywnHovGw81YRxSE9xt06uZXn61zeRzpY9U4f4qFIyCD
	 S66TcmqIiSYXXqwI6xGxQvvHgMBkAa4HqI+JZqVSmqImyMAIDhcZ3QSWe3TO88DrdhSmF
	 JggHoa2vyN0ToITRnAUN/zl8ATVD43ndA0cRBO7WqmD9/YQUO5+510lzELYkt/GhTR8Js
	 1HhQpAKHfv23h7Sz+VVkMOP/gv9sfPDF6S+DPLfJTZVTyWTjSijCJOOS0YRkHGJvAxjLj
	 4ohZG/d+4cH6M6Imp6m861yTOburJSAoi8DNP2GwR1GQ+XjqAvonVoKtXEyvffOQtig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794412223;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=tyvDtIOproK2RWqGRCOSv/qyrxR3Y4BnQiDrcV1ztXs=;
	b=MTFL83dLE0nUQ1BIn1PP+3wH5fPUgk5xbCpdBAZoyV9BHqErHqlFDUwnL8tcLoz/Alt+
	 vqxLDqtiCnHC6XHfT/mB6+0jLss9Bx3tWh/wz8KyJfKMQEEelPtNgANtouUqDsYZ12o4V
	 941OXsbL2EqkjRy2C27bAlIJe587aNeQuiWf0r7/75MdOVBK9QL/VgiQJqAnyYcdp6G7M
	 aZfRc4Dp1bqzVNZL5xmB4GU9vQX6ybB7TV3fJjGiJAltAeAld9n8+G8Dnq7H8hIhSwYg7
	 nMWMsTkaQ7zuFBnnOfyY1BzqKutpcWqc0ETJwOiHY8HcvMrW6YwtJU+8nuowlWgafJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g8cY2C3S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE054606A33E
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 15:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE054606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g8cY2C3S
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-679a2b5fe87so4004843d50.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 07:50:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794412221; cv=none;
        d=google.com; s=arc-20260327;
        b=RCvueBMsjUm1ejyI/qObQxjg6Ff5+Cqcs4j1moRveqavncnndAqWxgt6t/SDZlhvlb
         D/PhU51OF1iaTizIidILJtN0SxRmLL6YMZjHMevH/nWX8AK2zDnuFArSWM61muwITaq1
         GBL73WvSDnfLP0bKSgTBFGRVFx64RKaOMgHkvV09Y5JTfUVLNulZL3fRgdxeicyTbBZN
         cC4cXurzbX+fGKXjA06LsC4z1euaFQp2C9qmSNBqdfiXy/EfqTgycrr8EqLxNW7NByKj
         A/gOjb79tlf7d6VFuBB/DLEhJ03FNs1vLmcx7HOjQTlS/I5bnn9wRjverWtVMU+NTzHA
         0wfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tyvDtIOproK2RWqGRCOSv/qyrxR3Y4BnQiDrcV1ztXs=;
        fh=BP1+C22n99D22J7lCS06XFh4YcH5Wyu18lQrChJ90TM=;
        b=ZRxgQ0WS+aQ5awEPPHENYTzGlwssndC7p4F3/DbN6vIUtt930OvjhbVebjlqJEaRmT
         twK/j58glZfxQVKbV45mg9KTbZq1qwtTZmgBJASVxEZbbGnubOtbeXABaZ4GxMX8NucG
         pReaW76xqezqn1+sNbjmPeCVu7WdQX4dkDNOppLmmbS0ELLXrieRxnAW7eF9eT4grRhA
         VZtjV0rxnHsEH5ajxuAcu+MsuRa7JTpNeP9AUfboSvHvzE26pP4XyxTVt3w+wYlvpbf4
         Ec26x9UhtmO67s/ClPjP6F8LoAdQSSGb3bih9ENVI+Jqwzu0CJ4og6iytUBQs1++7R3W
         s5ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794412221; x=1795017021; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tyvDtIOproK2RWqGRCOSv/qyrxR3Y4BnQiDrcV1ztXs=;
        b=g8cY2C3SKJcDs/D6yzhHkUl3adeUuc6a+21DlDK4ufcC0ZpMJokPeXzIoZkH/MXiv0
         sK7RKlNccaQ7NKFAp/+fl1bxfdoNa5LbGo3xa/306uk5O85IRsy+4lJr8hdOizvAOPZd
         zelnug3dTHCQl6ZLxB0AoQTPfO9XW5gZ3er4osPwaFU5nbW64gQ5Baa+OCVgnqZuY9I1
         7HlX9EOikyH28c0AC+CT/BSNAOc1t4Hok3a09mjem961ViwcCFAjy9ZfUzQXSdWPGzJB
         hkeGcr/5iGsSFJrXP4JvjVSTOV9vji826VE7DD+2lnrJBif69CASk9zeKmXMk4c8EaZ6
         Rk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794412221; x=1795017021;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tyvDtIOproK2RWqGRCOSv/qyrxR3Y4BnQiDrcV1ztXs=;
        b=xsly1DWAKSPWTbO5fC998EUPbB9SAb3DMtcAl3+1TKdDdRe/fyDhNJp0QuOinfz9ix
         PvEw1U+g5WkPmZzVj8UOHteCHba/lJWUgqvNBrl3uc4Fk8EkQWYi2pLvz0xcQ6mAzFT7
         WURq73XJ/zBndzUtzJgulJzlLGsvsYiT2VqR9+yWrRWPBXrqLQdoVHVmjOFLNq2BLUhi
         6nmqMK5UtBhHV2vm7VjsNGs+qV6MClZjlyYKmzFoROkJngNm2/o8RnL2maP7B0tK3gL6
         uVCfKMV+mfA6gkhqwrvqZ3fru2LBsfJmIuRgEY7Ew3UZPsXkH92dSa6XDOrXLZhmGo6n
         6Iqw==
X-Gm-Message-State: APuU4Z81A+ojQj3+Hwn7MMUl/XYDqZUeUhwHQFdqpV6DuHxPUJvFNGzu
	HBNSZ/CRZJkmuXv6hvFhc5Q7sfiZx0aQVe6ZDDocEcWC/Z25CE7cXLc/Tsz26WPuQCq8+ExC47A
	NDSXCPovM2eoXJkc1RiKkFhNr7lkBds0=
X-Gm-Gg: AYBFou0zf9xZy9XN/UrPI9m2NFrg83+FmSiIG+vSydnOKe+BFa7jLhevOiMBtiOH17p
	l8+fxlS2s4TbPr5h0vF2YEFbYV/BgmRWL38IaP5v09FDQBJTQ7AySW++55WyBtk8DtksCLoS6h/
	vDl6C+Frcs6v31qEp3kFpvCdEo5eB1mWbj24dvR2Hl/X7/gbPjUIv1QJkiMYpALI05rfiUDh39H
	empEt/sN/OSDuF38Nq2n4yeEB0WagmDr9o5FKnNVLeNKza9wgszNyjkt6HGxotyN8CVlZryg8xx
	YYiQRHEyD9smWilrTouGIVK6l24ccFbi8f7VBU3gbbneUTkmaCGMRA0jMQ4LZjpDQOVRYCvj0on
	kcfnrDJ0SphiMFeALFCwOv7tsGc1JaBL9ZqBWD170JwfsvwKEnO5doPZhZAzy5ZVbLcqnuVu6K3
	100mZPB6+5UVTytasi6oyEYUf8gGOLYpCunVv89fNE4rLvI2ZIBkW14AWGvxdx+DVRok2V/qEyq
	XoNJA==
X-Received: by 2002:a05:690e:4894:10b0:67b:eda0:b411 with SMTP id
 956f58d0204a3-67c67effd43mr1154284d50.48.1794412221155; Wed, 11 Nov 2026
 07:50:21 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111094425.1444893-1-jinwang.li@oss.qualcomm.com> <20261111094425.1444893-2-jinwang.li@oss.qualcomm.com>
In-Reply-To: <20261111094425.1444893-2-jinwang.li@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 11 Nov 2026 10:50:09 -0500
X-Gm-Features: AclHuK_QwCjcI6LPN_mmhwCJv6ku5f8GtnwFfKTw9WC1IoB9VQsu0P11zTVtCV0
Message-ID: <CABBYNZJ=rFAEiQ9KxwTAQfZ+nsuudYaVZgyEr01eqBxaZBMuLg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 01/20] obexd/pbap: Fix PRODID property name
To: Jinwang Li <jinwang.li@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, cheng.jiang@oss.qualcomm.com, 
	wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com, 
	xiuzhuo.shang@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jinwang,

On Wed, Nov 11, 2026 at 4:44=E2=80=AFAM Jinwang Li <jinwang.li@oss.qualcomm=
.com> wrote:
>
> Use the standard PRODID spelling in the PBAP property tables and filter
> mask so PropertySelector and vCardSelector bit 25 match the property.
>
> Fixes: 3a1e6b3e8dc1 ("obexd: Implement Filter related function for PBAP c=
lient")
> Fixes: 4f805f5e09f3 ("obexd: Add EVCard filter for PullPhoneBook")
> Fixes: c8e98708ea3a ("obexd: Add support to all fields required by vCard =
3.0")
> Assisted-by: Claude:claude-sonnet-5-5
> ---
>  obexd/client/pbap.c             | 2 +-
>  obexd/plugins/phonebook-ebook.c | 2 +-
>  obexd/plugins/vcard.c           | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
> index 1970d3357..fbd843a4a 100644
> --- a/obexd/client/pbap.c
> +++ b/obexd/client/pbap.c
> @@ -107,7 +107,7 @@ static const char *filter_list[] =3D {
>         "KEY",
>         "NICKNAME",
>         "CATEGORIES",
> -       "PROID",
> +       "PRODID",
>         "CLASS",
>         "SORT-STRING",
>         "X-IRMC-CALL-DATETIME",
> diff --git a/obexd/plugins/phonebook-ebook.c b/obexd/plugins/phonebook-eb=
ook.c
> index beb72b22b..d8621b8f9 100644
> --- a/obexd/plugins/phonebook-ebook.c
> +++ b/obexd/plugins/phonebook-ebook.c
> @@ -81,7 +81,7 @@ static const char *attribute_mask[] =3D {
>                 "KEY",
>                 "NICKNAME",
>  /* 24 */       "CATEGORIES",
> -               "PROID",
> +               "PRODID",
>                 "CLASS",
>                 "SORT-STRING",
>  /* 28 */       "X-IRMC-CALL-DATETIME",
> diff --git a/obexd/plugins/vcard.c b/obexd/plugins/vcard.c
> index 0a727b729..3827602cc 100644
> --- a/obexd/plugins/vcard.c
> +++ b/obexd/plugins/vcard.c
> @@ -54,7 +54,7 @@
>  #define FILTER_KEY (1 << 22)
>  #define FILTER_NICKNAME (1 << 23)
>  #define FILTER_CATEGORIES (1 << 24)
> -#define FILTER_PROID (1 << 25)
> +#define FILTER_PRODID (1 << 25)
>  #define FILTER_CLASS (1 << 26)
>  #define FILTER_SORT_STRING (1 << 27)
>  #define FILTER_X_IRMC_CALL_DATETIME (1 << 28)
> --
> 2.34.1
>

Copilot flagged some problems:

https://github.com/bluez/bluez/pull/2794#pullrequestreview-5861421304

Also next time lease send with a cover letter and a summary of the
changes since the last version to make easier to follow what has been
addressed.

--=20
Luiz Augusto von Dentz
