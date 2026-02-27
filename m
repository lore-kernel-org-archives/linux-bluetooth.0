Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55599345CA5
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772209990; cv=pass; b=CeTFseBmwjxq11sWAMG9pEeYJAiBT1G+ujT1nGgwOII3+aJTJqxRtv2m4Wc3rtQzBcWHrwGRtQu2XFWOpn0B00l/P9myLrzuoe+HK3DnGybi1VQhMKNSDlxIJbH9Y3uUvEo/KiX/xQ4RN98lL9BTIR8mrlTitiB6krjHm1xlK2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772209990; c=relaxed/simple;
	bh=IuFsb6h9gNCtnSbkXK6ku/RAqPx7SxhzdwQm7z6McLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u6KDH38+ZK606m/0gNH4f8qvum99BynXqskV1OpXdquU31yKm/OOmB8m+6+GRdh7sMwwJ2JuQa6vXQodNR8LTY6ccwC4CB9K5m1iJmRBBcyFFR+HFPPYldK/mwdGo4iWkCC7NT1HJ24L7I/rLpfTgG0upRgIvFif8Y3lBqBw/PU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nome8bVf; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nome8bVf"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64ae222d978so2065407d50.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 08:33:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772209987; cv=none;
        d=google.com; s=arc-20240605;
        b=KQrhuyNCoAPEKy+dpUTpdsTr8G2cjBd7QMR/OTQbDh9WZo17MT1LbCSw5sEBL7cJCi
         iqSd7t7SGB+Z7zqMt4TWGzEsyFGCTKGszlzO5IvzqshDKBPPyITanawoHL/Qyld1PDBZ
         i2ODli8QOBl7hGbP8ofo/M2bMvcGkzDELn9UCUd473mkPqTqAqS1ysQLMjEF3UznMI48
         ihzdmFlXTOBqetHkF3lrJ5JAg9muH1qrIT9erB36LobvMUyrdXQn6RvDUHwjLn3d+8dF
         GQ+SfEuANMjJ4KMTRbBFGR07SYr2LsvlQilxS5MQ6G1Ef2y097fdEM0tf4AGt07H7nMM
         +gLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FtOd9RKwiHGMmoU8mHmA7+NoGG8+Xu0LJh0LYiKCWEA=;
        fh=1fz9LSvKI35CJE+hUnH4yaORc8MHueMppyFMJ5ZRfM8=;
        b=egMhnR/U3rAJCJWKyU32mBlg28uvC/SabB1lugVLnxt6qjgXlRRFpHAuADf1IDg7kn
         ZoqMVyP4ydbD7AGxnW5RgX/Rv0eMT1XWHyHKSisVCxM0KGTpvEllOFOZlt/oYdE7D007
         kdznmknGHlpZfdzk4Q4vXA1IiYxvPFGQ4ehvMmWiylNWnE3CyfTKUOQ/KmsAOmItluL4
         PS1znN5FL23kAAsZjX57RtSJJk3BoYnkC4Os5tMaypjKFK4+uzg9BgU0ntryYMao+pt0
         kDmGSmjlxRlLDD2F4vBUEsG4QNoDsuJzXcRqp+OBI+PgOOxjyDrVjhudeaS/R8qmLWGD
         BfEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772209987; x=1772814787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtOd9RKwiHGMmoU8mHmA7+NoGG8+Xu0LJh0LYiKCWEA=;
        b=nome8bVfwqjr5LRlt9ib+PLQtR9PfR0tNwFosAq1cPw0mOsxKnPNXzI9s/Ek8uLj7L
         R6Tfv+nGedVuq/Tcj1/cX0cYBeb2+RWd0lL8RlumZuisWlLPhzganqu4rbXaQLGhIAIg
         hzjiUjCXg/4kvkuA44+pwFXieGEQown0eqHp4/z4XOISflG9kELlfFw7nQsDnjrTMngG
         66YcRTRj+88cAP86hAHQ7odmSsnH+9S2aSWf/+yK+vTTShHZ944LYM3s9x0SIemTnbwH
         tvZcaReGsknO1gy/wMpIbVQYCvkes8Z3WGgpB5TQAD5AAWYl4kfWhW1RcZeLUjhkj7P6
         Y1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772209987; x=1772814787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FtOd9RKwiHGMmoU8mHmA7+NoGG8+Xu0LJh0LYiKCWEA=;
        b=ow6qcQFi2uFB68jnpQVCDXLKVddK5BAbGxu8VjpQ+nq+x4wAS2eutjYTFLyJOohq85
         qNZaUCtN5sijXMFwAPvgXfWH8GMz23AIV0Mlo03uEGqyhhh2Awjw/dAQvRzJrvAlI73v
         oCzAu6keDd24TqHs15H3eRPOnNqLCzDE17iXDxL8urPX3ceLKtIIjzW+9abdSRkk9ue7
         WUUxodUXILOSyuXyZihTuXpIgg8tngzBsfZfYMnyFbRmd9sp0mk8HEQAkdgRDMRgfQ1r
         XhMf5Q650R8Nua8LIvs9mv9svjfN8RalqMXowblwdwlFU9EKdhHLeJN1AI7qO993snsj
         +4DQ==
X-Gm-Message-State: AOJu0YyDE7gvhnIHtbfavlQCRaBX5camxQpbQwwgEIfk1axCnrbpSrEU
	Yh/TRLbIXHqTYfynz4I/sgh2OSkSwP/kRkvCXYdSmzLIhKjwGNltDJQ9pdOShNGSdXu5JnvxKok
	bKfbm3rd3ccntZwd1W0+anWMxl+i3u2U=
X-Gm-Gg: ATEYQzxjay+xgIafi43G4MRQ769YzQxT2hMu6riJ1mQ4yW0ibny/0mIoySiVfFaThlb
	KQw9MK3saCYNrwPF/BTgjYYyg5CqJmhXnDc+na8cgIE9fh17U1UB8+HFp3CU7SizvPyB7GcjvJc
	Okp524t6ngInRJsDnXEeOxO187MzFheWw/LoBjS/O/0Y0Y0GP3SLZ0bkHE3yhG/t4RrzLgEe/+8
	9RjGGCYFjA4ODNwxn4T2/8nNyLlHeFuRdvhaEg9W22bniQ3mkFAYP0nUGcKx/8ZT996AgT3UX3Q
	bYcQ+rqrG0oLpzVvrAUuiZ6XAipvNxCv7K3E/f2dmkTFcux4h/AHOBZQV9b1gyhpxZRM4A==
X-Received: by 2002:a05:690e:1544:10b0:64a:e9db:c834 with SMTP id
 956f58d0204a3-64cc22100d4mr2208259d50.57.1772209987095; Fri, 27 Feb 2026
 08:33:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227160022.21462-1-ceggers@arri.de> <20260227160022.21462-2-ceggers@arri.de>
In-Reply-To: <20260227160022.21462-2-ceggers@arri.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 27 Feb 2026 11:32:55 -0500
X-Gm-Features: AaiRm50FISGbrD1XPb3LfC0V_gpiTxdmo1Cdqc9ZWiHw_3RRTfW7V4t2671-lAM
Message-ID: <CABBYNZJJZRav3wRfmkQNg-kyARXwf6A+yDRu94jt8Fb6C0OULQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 01/15] doc/qualification: gap-pics: add footnote for
 TSPC_GAP_21_9 feature
To: Christian Eggers <ceggers@arri.de>
Cc: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Fri, Feb 27, 2026 at 11:08=E2=80=AFAM Christian Eggers <ceggers@arri.de>=
 wrote:
>
> This feature is not supported by some host controllers (e.g. RTL8761BU)
> and must be disabled with such hardware.
> ---
>  doc/qualification/gap-pics.rst | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/doc/qualification/gap-pics.rst b/doc/qualification/gap-pics.=
rst
> index f5b63a00ac98..d7673e5da088 100644
> --- a/doc/qualification/gap-pics.rst
> +++ b/doc/qualification/gap-pics.rst
> @@ -832,7 +832,7 @@ Prerequisite: GAP 5/3 "Peripheral (LE)" OR GAP 38/3 "=
Peripheral (BR/EDR/LE)"
>  | TSPC_GAP_21_8    | x        | Peripheral-initiated Feature Exchange   =
     |
>  |                  |          | procedure (C.1)                         =
     |
>  +------------------+----------+-----------------------------------------=
-----+
> -| TSPC_GAP_21_9    | x        | Connection Parameter Request procedure (=
O)   |
> +| TSPC_GAP_21_9    | x(1)     | Connection Parameter Request procedure (=
O)   |
>  +------------------+----------+-----------------------------------------=
-----+
>  | TSPC_GAP_21_10   |          | Data Length Update procedure (O)        =
     |
>  +------------------+----------+-----------------------------------------=
-----+
> @@ -848,6 +848,15 @@ Prerequisite: GAP 5/3 "Peripheral (LE)" OR GAP 38/3 =
"Peripheral (BR/EDR/LE)"
>    otherwise Optional.
>  - C.2: Excluded IF SUM ICS 31/17 "Core v4.2" OR SUM ICS 31/18 "Core v4.2=
+HS",
>    otherwise Optional.
> +- (1) Only set of Bluetooth controller supports the HCI_LE_CONN_PARAM_RE=
Q_PROC
> +  LE feature, otherwise, GAP/CONN/CPUP/BV-08-C will fail.
> +  # cat /sys/kernel/debug/bluetooth/hci0/features
> +   0: ff ff ff fe db fd 7b 87
> +   1: 02 00 00 00 00 00 00 00
> +   2: 5f 02 00 00 00 00 00 00
> +  LE: bd 5f 66 00 00 00 00 00
> +      ^^
> +      ++- This byte must have the 2nd bit (0x02) set.

I think we might want to say exactly what feature it is rather than
just the hexdump and point to the expected value, perhaps this
requires Connection Parameters Request procedure?
https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core-=
62/out/en/low-energy-controller/link-layer-specification.html#UUID-56ada5ed=
-4ae3-acee-198f-27ead57d86f1

>
>  LE Capability Statement
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --
> 2.51.0
>
>


--=20
Luiz Augusto von Dentz
