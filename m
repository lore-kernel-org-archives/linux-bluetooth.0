Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54BA39A05F
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 19:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899386; cv=pass; b=DOb+z0sRjyOWEMt80Iw8bn10/SIWQlHJUPePotY/okEWR/sXyAVryP67Pl69NgdZeFL2U0MmdYkr7xurR6nZEKafP1OVYIO57kmpWWOiOPZPWDhNB3KVGWm+skTu6iqjrNDBPTFbnoYlMgIw0Bbr+nkXhS48P+X3LAVZ+GF2nyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899386; c=relaxed/simple;
	bh=VOHBkXEEGvtOi4xRbgU9eEYEdZ33wTfbvFZ5aI4/z9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2VPkQomKGkE8vmbOCTjidqs3fzJNiHR3sxqXjeY3uxnAg/vGtPaSi/9REU+YqxncZoh8cVz5v6LKvO1E43iYc/XXN00itFWO8mMs9y+6LBQaVvgtIire/1aFTSJbDEv9Axrilf+4S3l6TgWvJ0lceqFeaooYuMlFPgM4ImzJrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzhH783F; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzhH783F"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-650158138d9so3145691d50.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 12:36:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774899384; cv=none;
        d=google.com; s=arc-20240605;
        b=RODAQf9IFk6ywTE0UMEGVVH8QSyjF3MbA/S4l/EgM+7gmkTa0Ytfq49//ylYpPCuV5
         o6oQPA3FSSpSEANDnkUF7kilqnOmUnAVxWG2b/NC3ueqLjOcPediRC+/CdRvjWN1+B9c
         YCwJfDVmsxJRrmCKRGEV7hk8Owg5NMaSHS2PD8eUczK33KG40fd+tbGlFH3oqQUQtKUO
         TdA62W+VeUzWSA9mIXUMJithJcOuDfaw34/Uuhr984j7yIepqzw2VYQayHilVinUy8rc
         GlCLSzALCMLUaEW0dG1xlyX3EhGpLij68cbwVPSALzbbOdsO3t4oGyo5KtP2TcsieyeR
         WXWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oTZDZepOrmawTD9Ecu+6VDSjmONCioqOkSOXBIra8+c=;
        fh=B0NTLRl6xlnNQz3qr9HQPFnrzX7nYNILTKF+Ji2LD7k=;
        b=PsHliMWD4TYXQSRebXemrUbEIWuST18qwFniqIep3O+AhV3QkB5uWx6LNf0ZAv+dC1
         zQBhpMv3UPD8uJPHYjHQqzDXaviCPMEzx1ZxVdGWSAFjJMhN6kbFM/c+RbPELXUdEe9c
         L0mBknmOh6MJ3Tl2xZLYD8GA/6rJQMUFCPZwmXEvI0jdTVJNTktLN0pGIb60UPTJrxkw
         QauJxvE2hZzn0g2qg6DvtcKu0qsNEjkw53ESKxGtXD2hG2dDNH/2KTi+QwlkmP4IO2E5
         tQe6mrXFgkxXjbDKVtnk6jpWL88/ydJKk15BI/Z2lnvHspUkdZYSmuXWf8ApAo5+kth4
         /lIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774899384; x=1775504184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTZDZepOrmawTD9Ecu+6VDSjmONCioqOkSOXBIra8+c=;
        b=AzhH783FiMUhaTsVVKD6HA7rJzTwE1a5drYT+/oFWdWdVOKiMhLj8cHclPCE23r6Yd
         HFMGSx520P7PZNg6tUSRygISiyZYXPXGk3/TVSiKC5TlwdLCfRLEqJIuskCI8XSPp8x5
         6yv1ZFdzr/mbNKurW5fwsqaXnU+EofFAxfrjAIIIqto1Cm9Ps1wD5ofNpXM+2qlrczG5
         ObjdtulGQgn/DGlhkKNN2HnRe+g78ZlVf6w8c/EdEC6OF7ghLCbYKI0C8LewzD++CiRC
         yGQQyY6BzTLsgccEe+m6DS+VsyQHTQuMrmsiaF/0FYvLVZJa3nGFUuwBYfC8VLzXd/BZ
         qDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774899384; x=1775504184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oTZDZepOrmawTD9Ecu+6VDSjmONCioqOkSOXBIra8+c=;
        b=J8KA0sSmNueOBI7iU5OHLIPxql7ExTNAvib4UZ6iF/JKxA+XTbArC/2NnIs1zhtv+Z
         18MBqsYGqFjnVmeavV3N1wNiO+34IDIe3x5UyhFXgehF1QmoyeXGCQ0eMZTsz4aIaEZM
         AsjszzjXOZIwbsCQN81hglnkkegBdNTwHQSLYhrxLyDMWM5bbEIZGQglEL1rWZWhPuUb
         RcuI3huJr4Sr7mgPC/MUsekZJaWmCxtdCvpF8LuOigiDTKzfmbe7qNcEzCFLGoEzPTV6
         zMLxIBw948PKj6zdXRp4ZlL1VSaRYtQdaBwgRqVH/8VW34X7/fMHu/8thlTcf7EL+Iv8
         9RDg==
X-Gm-Message-State: AOJu0Yxij/llAjDElPo/FD4RO8OjozGROLS4jPKrAXLJbQO3yTNur0JE
	jETFjBdvX0aIvB0Bxl2/WmGf96IbmmllwYz7uLNA5FkuDM30zpyWtM2nnZYgEw22yzvzurYECY+
	e7fotUGMmdpYtWMi4fGFP49S2qdaBu6I=
X-Gm-Gg: ATEYQzxl1jAXwu1n+KpSA2H9I3iDDMKJKdSc9vNBgfMChzwt3xBgFDkWObuJlaKm9eP
	vHKXVOktz8Kq9jHxpRcyMHe21OVJf/W2H3oKT8Wc4zQ4jKo/WPwQPoU8PH4biDEsSHzxvn1hHGQ
	kzgJelP/wSo9XWhxYdcMVe07tg5ayC4Y0eeA06DLarOKAJAiIPyusiD9GaFnvD8Va67uKr9FNPK
	SjetIVVGvHxOKIh//IgZ3twapi+mzz/jIsU2F1lN+wHwnb9ffotE2DFagJVfrNJQ2d6oDeTgq5D
	sgKZetvp8j1xflwxefYqk8JWL4NCp85l/YzZVbHwjLwKXw4c/UhykBaXm7NtpEju1hc=
X-Received: by 2002:a53:ac94:0:b0:650:16ed:c1a9 with SMTP id
 956f58d0204a3-65016edc4a3mr6510387d50.4.1774899383675; Mon, 30 Mar 2026
 12:36:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bt-smp-v3-b13a5d5f53ed4efaba74be7539453366@1seal.org> <78570f37f1da48f38336480ba61e29d9.security@1seal.org>
In-Reply-To: <78570f37f1da48f38336480ba61e29d9.security@1seal.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 30 Mar 2026 15:36:11 -0400
X-Gm-Features: AQROBzCmI9v4TonJPlPzchW4zfNfL9X9_SIEczU3FjRqG1Kt8sM7Xo9n2U9Ko8g
Message-ID: <CABBYNZKHUosCj5+byy-XJ2spYhKP6p62ai5zoHehG=x5b441SA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] Bluetooth: SMP: honor local HIGH security when
 selecting legacy pairing method
To: Oleh Konko <security@1seal.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"marcel@holtmann.org" <marcel@holtmann.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Oleh,

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

https://sashiko.dev/#/patchset/bt-smp-v3-b13a5d5f53ed4efaba74be7539453366%4=
01seal.org

Seem valid, perhaps we will need to do something like the following to
force the SMP_AUTH_MITM bit in the response:

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 485e3468bd26..9841acc9d074 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1809,6 +1809,19 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn
*conn, struct sk_buff *skb)
                return 0;
        }

+       /* If we need MITM check that it can be achieved */
+       if (conn->hcon->pending_sec_level >=3D BT_SECURITY_HIGH) {
+               u8 method;
+
+               method =3D get_auth_method(smp, conn->hcon->io_capability,
+                                        req->io_capability);
+               if (method =3D=3D JUST_WORKS || method =3D=3D JUST_CFM)
+                       return SMP_AUTH_REQUIREMENTS;
+
+               /* Force MITM bit if not set by initiator */
+               auth |=3D SMP_AUTH_MITM;
+       }
+
        build_pairing_cmd(conn, req, &rsp, auth);

        if (rsp.auth_req & SMP_AUTH_SC) {
@@ -1826,16 +1839,6 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn
*conn, struct sk_buff *skb)
        if (sec_level > conn->hcon->pending_sec_level)
                conn->hcon->pending_sec_level =3D sec_level;

-       /* If we need MITM check that it can be achieved */
-       if (conn->hcon->pending_sec_level >=3D BT_SECURITY_HIGH) {
-               u8 method;
-
-               method =3D get_auth_method(smp, conn->hcon->io_capability,
-                                        req->io_capability);
-               if (method =3D=3D JUST_WORKS || method =3D=3D JUST_CFM)
-                       return SMP_AUTH_REQUIREMENTS;
-       }
-
        key_size =3D min(req->max_key_size, rsp.max_key_size);
        if (check_enc_key_size(conn, key_size))
                return SMP_ENC_KEY_SIZE;

--=20
Luiz Augusto von Dentz
