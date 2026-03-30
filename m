Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143AA346A11
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 16:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774888066; cv=pass; b=dXcUNPufAzhWvaQVeGf/0BKPwS+6zH3xhNB9109jq0yf94ICkf32QEEo4b6qxxuwIyBsAZY65xgkAgAe2AscFnnJWp52l6lTdRY3hjp3gy92fqxFlEi2sUijFt6uok9e8CD82fK5I3uaa9w1gHovdNOYoH7iwNMXBxhLgidbRdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774888066; c=relaxed/simple;
	bh=v9N8Rf8zs+eTIL6BJ0XSdRPfua7WUTiepP3hb1dKsf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cuzWETEJVineAtk/waxjtNwnwC58ScbUh6OJa53MaHbKGjhYGyfIKVFDknCcWRyQ0O05Z5i1QIz/94o+88VjZOrziGEzqhvjeco3+ZRCzCole2VNfezkFEs4/xqPF2m4z/I2S9RkjTTF6w7/k5VV89xc5UIP4t37awiWbDJL21U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmvEpVsR; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmvEpVsR"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64f48a5c3d8so7240591d50.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 09:27:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774888064; cv=none;
        d=google.com; s=arc-20240605;
        b=FvNDcHeSDxtELk+UA+9BH6JjPevvH2M5/HZ0jusx3xw/1yWX/NzEmXA5jTY4WUqFYf
         iaVLtGxcjYcDH1l1v48kzH2Vgf+zA0g5qWUTaJ4AzFntzPIQqcrLMDla6yq0oYJmN7t7
         BTLDfWgwVZWLu87LpYCLaeZ4v0yYI1uYD3uFTaLzgRSUOAGR/HL6DY4KEY0qEcyIcDYt
         vzMCxLkyniyoDMEE5qTiSxh9MAR625jZeixXPegnLrv+n4kqpMra8bdRd+Z8p2/Fvwwo
         oib9sn97aMAM0EOdeJEGj8b1v39B5/6s3CXtsBVloDCyO2pKqCAUkQ7shQtSGwm/KT2e
         ZAfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TX1rhCVCXKog8ActDGd3kxJlPL/HFjFl22+r1vhXzDA=;
        fh=B0NTLRl6xlnNQz3qr9HQPFnrzX7nYNILTKF+Ji2LD7k=;
        b=Fh1VxGj+AULu+75eC+TXW9oujAlz1FJ76dbK9m+2girIekKc3P3BFlbwUS9jur7dpy
         GHU+kKRKaZJ0hxP7IsLKaGYnDIRDRVJk1s6VKbw/J2/0HrjB9jogPE1LtqpdmnKyiH/J
         7wraje9AD7wrvym1jrzh1kzg+AIBtIwoHQ8a56o2pNGw44l9gi0+sr6Xafg0ShCdWZ9G
         AdgUeyPSOYFP/r25/RdvYuXefwwdjDDnvq0EjpQP4LebXoKE9BVYGrgaONlJbPjaeyL0
         NNFdqbElRwWJb4ykOF7KMrN05lcTb2zvrQWgOe++IO3EHw3Aa3feC5JpINZ53leGqJg7
         BE0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774888064; x=1775492864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TX1rhCVCXKog8ActDGd3kxJlPL/HFjFl22+r1vhXzDA=;
        b=mmvEpVsRXgFidi7RSOWN0BTCAH2936mUVD/zo6PA9dKHafc+Lrv7QHTGTocHA3OLzA
         niCo+v1A/73u97Bf5+m2991BYNYiCKTNtHdQZZWWAH5nZ7p6B7RvD7xpMQuZctdbUjnV
         vM6S52WSE2fUSBaFoTsVuxH7dhF94Uklh8W/z7EHW0UnVfUFtb9kzsluMwM4QqL64bWJ
         +ENVs9PFvNhDvvwwD3BZkW5QT2TTsPLEFZz4j4s2x2nipIpb8aRZrUR8tvHqV1UwFm7+
         uYQeGdGWmNSX9mWyA3M4R1oeWvMJ5MsABXsEA23kJjqqxl5Gom0r/pMip6hTFTr0iqRF
         GLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774888064; x=1775492864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TX1rhCVCXKog8ActDGd3kxJlPL/HFjFl22+r1vhXzDA=;
        b=kPU8cqsKIE0J4q8Xt1RmMB1IssSk2/5sAkvMx5bnq+ajg2JoLwpIFjBWOkPyjcIUgs
         1PXUrTrJ241C2lIoN3Jf4I7jtpbHfp5Od8hOa0nbb3dvzfwhWsBhOv19HHgZSNJ32b7R
         JNg5jTpGMjuMrZ+ZGSahdkfhS9PcGjAhUVZSST7FY7YJehZg3Wp03IS60FUkvqlGzizc
         zXOzdvecw4pN8218v3d0EDncvsi5lzVGrx24oD3F+EUissJ7ibhRaPZI2kEMWJUsi4Gs
         f6NpZLmyo4+x7B9VSGg59VSUABP1XjAZoiRxFXiIpMJYpGdLFK4EtgwUlewbOeqRMAqJ
         dQLg==
X-Gm-Message-State: AOJu0YwzmkMZl/OuDZX7ZZdm34ckmNpHgyAkBK8HFyorH01bcmFX5H+V
	X9EodLre4e36nXgsWKxq3h9srxxlBRdYi/bPvUJ6IDcHaZ6lvRrij+lGe2q3cw7stCf+txAwlpb
	Y6iQhUeK6wrXFSFJ64GRW7rziyHvDojhhFNEN
X-Gm-Gg: ATEYQzwhwnmVokTsGbbpxQu+lzr3TboclPpn6yP2/3GrRpKchMGqitA+hsDD3ycrkwQ
	NrhmF5Rm+D7/atQYQ9krgk29W8eXuABtQBPbmoWJZgvRiIIAY+6YambGr/8Xcz2yyaLsbdIEppm
	18IyRp7hsQZEL5P7YcJT5EACstTkJ4buY81B779zug+w6yHeQabMKchFt+Q0mGQV6lB9vdRZ5TB
	K9YTSsweHZrQ0MYciCqVuJyS35L+FzLLpXfWO+9x+45nj11FcOmZdpCL82GICm/o7m0a1TfUYy6
	mBWCyQK/uMTsdIe919/8xfKJuLKniwXE9jxSjMwM8RDS7uq/zy+rsWTz1lAw/RFQMAUswo3E2YK
	X+eB7
X-Received: by 2002:a05:690e:16a1:b0:649:b31e:8f54 with SMTP id
 956f58d0204a3-64ff71eefbfmr12970033d50.24.1774888063996; Mon, 30 Mar 2026
 09:27:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bt-smp-v3-b13a5d5f53ed4efaba74be7539453366@1seal.org> <78570f37f1da48f38336480ba61e29d9.security@1seal.org>
In-Reply-To: <78570f37f1da48f38336480ba61e29d9.security@1seal.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 30 Mar 2026 12:27:31 -0400
X-Gm-Features: AQROBzDrO9hyG6rs7O0fpQgbgr8DPEMZeNci8K3sB8oOFR5nB-heRZQKut81ck8
Message-ID: <CABBYNZKmKK=rK69P5HCcL=Jm7KZeCNsXBpi5T3MeSi7kHe-0MQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] Bluetooth: SMP: honor local HIGH security when
 selecting legacy pairing method
To: Oleh Konko <security@1seal.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"marcel@holtmann.org" <marcel@holtmann.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi @Christian Eggers,

On Mon, Mar 30, 2026 at 11:33=E2=80=AFAM Oleh Konko <security@1seal.org> wr=
ote:
>
> tk_request() currently forces JUST_CFM whenever the remote auth_req
> omits SMP_AUTH_MITM. That ignores the local pending_sec_level, even
> though the responder may still require BT_SECURITY_HIGH.
>
> The pairing-request path already rejects JUST_WORKS/JUST_CFM when
> pending_sec_level >=3D BT_SECURITY_HIGH, so letting tk_request() ignore t=
he
> local MITM requirement can make method selection inconsistent with the
> policy the stack already enforces.
>
> Only select JUST_CFM when the remote does not request MITM and the local
> side does not require HIGH security. Otherwise, derive the method from
> the IO capability table.
>
> Fixes: 2b64d153a0cc ("Bluetooth: Add MITM mechanism to LE-SMP")
> Cc: stable@vger.kernel.org
> Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Signed-off-by: Oleh Konko <security@1seal.org>
> ---
>  net/bluetooth/smp.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index e67bf7b34ea..a9fb9b513d6 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -863,13 +863,14 @@ static int tk_request(struct l2cap_conn *conn, u8 r=
emote_oob, u8 auth,
>         bt_dev_dbg(hcon->hdev, "auth:%u lcl:%u rem:%u", auth, local_io,
>                    remote_io);
>
> -       /* If neither side wants MITM, either "just" confirm an incoming
> -        * request or use just-works for outgoing ones. The JUST_CFM
> -        * will be converted to JUST_WORKS if necessary later in this
> -        * function. If either side has MITM look up the method from the
> -        * table.
> +       /* If the remote doesn't request MITM and the local side doesn't
> +        * require HIGH security, either "just" confirm an incoming reque=
st
> +        * or use just-works for outgoing ones. The JUST_CFM will be
> +        * converted to JUST_WORKS if necessary later in this function.
> +        * Otherwise, look up the method from the table.
>          */
> -       if (!(auth & SMP_AUTH_MITM))
> +       if (!(auth & SMP_AUTH_MITM) &&
> +           hcon->pending_sec_level < BT_SECURITY_HIGH)
>                 smp->method =3D JUST_CFM;
>         else
>                 smp->method =3D get_auth_method(smp, local_io, remote_io)=
;
> --
> 2.50.0

Do you have any capacity to test if such change affects any SMP test with P=
TS?

--=20
Luiz Augusto von Dentz
