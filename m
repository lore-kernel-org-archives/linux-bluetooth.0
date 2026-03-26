Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4C475801
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 14:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774535212; cv=pass; b=VyZ3AEsZP1EQHY/JMGYEWV8CnP6F86HW9dTexHvnuLIDCy0h8u+ehgGoklOLj1Z4dIUAReD73tGH7JbeOmnkMs/Kmz4nmhfmqPc8G+syy0A29EoPgY3t5MnJobqFfBa/h6+OkKqHtMAPh9uZMyrqrEbMIgnvgz1eu7//kq2zBUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774535212; c=relaxed/simple;
	bh=zHP7Jq5euAxnyqdwV/t9nV2KIHJnG6xYhWK1aevKOjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IvFizVFS4LN8FPw3SqDjunwaKtKugTjA59wn8KV4i/L2qmFT6pJExoHGoNOuMkBviwGhiEVc12unePrDPlxK+28hOga8sHWKYW/9BQuxEMrfzgqvMEXNRz4snnTFEBeoNIT3l4BFmJSAOnXj275ygakxI+7pKRcgVJT572F0964=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZX4IOFJ4; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZX4IOFJ4"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64eecef1a3fso1394999d50.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 07:26:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774535208; cv=none;
        d=google.com; s=arc-20240605;
        b=L145b1B573LYNBryfWrDiaqV9Llb0xW+xzd0h8R4i/AyllTTkkb3Vc+QpzOwersa2+
         nZ0NKizsM3r6s9gaPdr0szgt3pLPhs9HtKh8Y85fnqKNQygE1+8AOm0BJOMXQH7WMjVC
         TB1EIxUL9qQI/L1/nUZMtBFcAlt6b3Ny+k0N/Y1lm5foJX/FNxFw/Y9l1ubY3MrHejX1
         QZ4ZEwmTVAnnVSvPfXUNIF5wryO1NkaNMH9zb4AgsgmcDU0NVxeqtxLzjba7aYtD8ro7
         J9xVRjPVbM4E9nDaNiekPOBEmKkjAoDV3bJrrAzhFpSIfKCEppkXMHMrOBfQlgo/EEPm
         t5Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6TtxKFQDlIr+XibLbSFRG0hIMmxVw0gOUomdrJVcEig=;
        fh=mUSJG5N1NnR2cqS6UA/oKYZYmm5j9m3b+zuKxNoTEn0=;
        b=Ja/vgqg/IggIwLwkFroFYREIbfw3COvEcmLZ0j77DCMcSXwkK71GJFJbCIf/MEHtKD
         C4Fom/LfpoQMN79jTQ7b1ToQl+oxmB1DsdZC5MeeCdvoXa3EGy3FjuKuRxl2PT5jKiCf
         QzMtoH1wuuqLGABqfqlHsvGKUAd/YoyS42U462GPCBlcCuQy0Tw1Imubs2VLzSpACqFN
         4qGmeIquLKriJMtKyWveWADNA2SLe0g0gpuFMMnWwauUg28L8QV8q5ku9nFsESkL0xVs
         ZMr21CIDw/ZxnPTjzbHiyqZQGDouKxUzJdrj79w9xnCCCLhh+zx/eoMmMaYmDcDYPLKl
         VcqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774535208; x=1775140008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TtxKFQDlIr+XibLbSFRG0hIMmxVw0gOUomdrJVcEig=;
        b=ZX4IOFJ4db8QJQ/wkSsusgHv47p+Zp0LB0ywlA3GLBC6q8NiXLkeYezirmWEw6uy1Q
         fC7I75Ln1l82JZ+dLObvsMKwkHlyCffKmyUYy2RVU0tnyOdh5shYd9ighUg6U8J+PMxr
         l4wWTtxtTnDlLqVXWtbx3N9Uqq6AHKG4klpm+5z5yXxRgx9NuIaFruZCaeNOmC0hUwTC
         M2p9W5w4uaPzPBOF9tiye9kDUR6ZPI4l9YKlgT7xLeGoWg7baMr92FuT522ivmAfINcR
         GYX3VxgQ9YKoe9JmKBUxigZGOSWOeRqZAMJrZWhjoHczAFBBnR9bjKRxngMUuOJbrCH1
         8ifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774535208; x=1775140008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6TtxKFQDlIr+XibLbSFRG0hIMmxVw0gOUomdrJVcEig=;
        b=se1tmIo4HhG6JcNmQvADJZ3ajDA8uM5q4zKBD7D0paTcfN8TwGxpuu+8BUvsGbzrn7
         Bi3yCB/MhIRmMF8ZhMrnaCsvKJobGONLX07Fpq9Xx85vj5wsfYQGUIybi5kwXxu/AJ1M
         0/6d1RmN/efYwH7oZNuh1axaVhq2Gd92H3zrCSeVphORo4EOlMpKVxfqgMSvxGBFfnQu
         tU3QzI1aAtYHdbbb3yvVKnbuD0CTh7NH3RFft2ytod0gdEgXAxtvc5M2m+c1VZv+Np8f
         6wLrmPhhPxUnd0cu660SxVbJKR8OB73sVNKB38sNAGmY6HmFH07yobkP74KKIAyVJESz
         DiKg==
X-Forwarded-Encrypted: i=1; AJvYcCV8dsfbnwIb9yOaCMS/FX7hjNBNtzdCwcEdCNuWnhCTDqEM9LIWAVr2Hqtc7y95AcFpFRcy4RAsJpvF26AMgV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQdSNRcx7clMpMf4DqJUwtPyy7Ntmr1uLCvZz0LEEVp4D+b/cN
	JBHZtHvrC9D6fso+g2YWdYthyQD6mbozJl02kTQedhnYZgGSL9aVh2XdHp20VU9PpLoHCWHB0o8
	zjFcb+KimQEKqhcjimmKCtj9yYXZigIw=
X-Gm-Gg: ATEYQzwAf4IDMoY22XOrusnDUgYZdUXxVM/E6stv5hOhvxb739k4+UlRKGozwZJ5kmz
	2cmK9pzeFBEkF0LjaKpHzaHJxC2RgfSiLHtZ8Jtg8YEkejogbmFMBPehGI7r6VMgdOv3w7syQgQ
	V/YtRjDjzpCy3kHza1JB0AkAJbkeJZLQ0OuMSXwCAgqf1U5hAqACFVNBG+fNlmhWY1BSX17GzcN
	wjjRb5sfLLfDvl/wMOzj66Cummbd9isCSTNN1rIfnwakbtRxvUH9EH/+D1xhX8gLK6n7L14rVwm
	I08YQ0mEODdWK2Ej4YqrEKdKM6+/zf8fti944uWiTGmbG0YTZSIP9WGPJjV+oxlwEDn+bQ==
X-Received: by 2002:a05:690e:400e:b0:649:ef87:5bc8 with SMTP id
 956f58d0204a3-64ee60b905dmr7663074d50.7.1774535208304; Thu, 26 Mar 2026
 07:26:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326122842.13664-1-zzzccc427@gmail.com>
In-Reply-To: <20260326122842.13664-1-zzzccc427@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 26 Mar 2026 10:26:37 -0400
X-Gm-Features: AQROBzCG-g9sqOiBYtxeicg1k1oNU48S2PmcqXg0c_0SDurSZXg8JR1D4PXbpNw
Message-ID: <CABBYNZ+nWzf0te1BuyDNQXdV9PsJg88vHEmxW68FOiiFpz8QQg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: SCO: fix race conditions in sco_sock_connect()
To: Cen Zhang <zzzccc427@gmail.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cen,

On Thu, Mar 26, 2026 at 8:49=E2=80=AFAM Cen Zhang <zzzccc427@gmail.com> wro=
te:
>
> sco_sock_connect() checks sk_state and sk_type without holding the
> socket lock, creating a TOCTOU race where two threads can both pass the
> state check and proceed to sco_connect() concurrently.
>
> This causes multiple issues:
> 1. Both threads create separate HCI and SCO connections

Ok, the first and the second points don't seem to agree. If each
thread creates its own socket then the sk wouldn't be the same would
it? Or is the first point about two concurrent connect syscalls to the
same fd? In which case that should have been made clearer.

> 2. The second thread's sco_chan_add() overwrites sco_pi(sk)->conn,
>    orphaning the first connection (memory/resource leak)
> 3. If the socket is closed between the state check and sco_connect()'s
>    inner lock_sock(), the connect proceeds on a dead socket (UAF)
>
> Fix this by:
> - Moving lock_sock() before the sk_state/sk_type checks in
>   sco_sock_connect() to serialize concurrent connect attempts
> - Fixing the sk_type !=3D SOCK_SEQPACKET check to actually return the
>   error instead of just assigning it
> - Adding a state re-check in sco_connect() after lock_sock() to detect
>   state changes during the lock gap
> - Adding sco_pi(sk)->conn check in sco_chan_add() to prevent
>   double-attach of the socket to multiple connections
> - Adding hci_conn_drop() on sco_chan_add failure to prevent HCI
>   connection leaks
>
> Fixes: 9a8ec9e8ebb5 ("Bluetooth: SCO: Fix possible circular locking depen=
dency on sco_connect_cfm")
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> ---
>  net/bluetooth/sco.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index e7db50165879..689788ad26a4 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -298,7 +298,7 @@ static int sco_chan_add(struct sco_conn *conn, struct=
 sock *sk,
>         int err =3D 0;
>
>         sco_conn_lock(conn);
> -       if (conn->sk)
> +       if (conn->sk || sco_pi(sk)->conn)
>                 err =3D -EBUSY;
>         else
>                 __sco_chan_add(conn, sk, parent);
> @@ -353,9 +353,20 @@ static int sco_connect(struct sock *sk)
>
>         lock_sock(sk);
>
> +       /* Recheck state after reacquiring the socket lock, as another
> +        * thread may have changed it (e.g., closed the socket).
> +        */
> +       if (sk->sk_state !=3D BT_OPEN && sk->sk_state !=3D BT_BOUND) {
> +               release_sock(sk);
> +               hci_conn_drop(hcon);
> +               err =3D -EBADFD;
> +               goto unlock;
> +       }
> +
>         err =3D sco_chan_add(conn, sk, NULL);
>         if (err) {
>                 release_sock(sk);
> +               hci_conn_drop(hcon);
>                 goto unlock;
>         }
>
> @@ -652,13 +663,18 @@ static int sco_sock_connect(struct socket *sock, st=
ruct sockaddr_unsized *addr,
>             addr->sa_family !=3D AF_BLUETOOTH)
>                 return -EINVAL;
>
> -       if (sk->sk_state !=3D BT_OPEN && sk->sk_state !=3D BT_BOUND)
> +       lock_sock(sk);
> +
> +       if (sk->sk_state !=3D BT_OPEN && sk->sk_state !=3D BT_BOUND) {
> +               release_sock(sk);
>                 return -EBADFD;
> +       }
>
> -       if (sk->sk_type !=3D SOCK_SEQPACKET)
> -               err =3D -EINVAL;
> +       if (sk->sk_type !=3D SOCK_SEQPACKET) {
> +               release_sock(sk);
> +               return -EINVAL;
> +       }
>
> -       lock_sock(sk);
>         /* Set destination address and psm */
>         bacpy(&sco_pi(sk)->dst, &sa->sco_bdaddr);
>         release_sock(sk);
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
