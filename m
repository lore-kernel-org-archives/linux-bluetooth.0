Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDB922A814
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 20:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740688702; cv=none; b=VX802OSUAmq6cGQn4y3ulPYOlgmXdTLm/FARxLf9FGPaM/zaAhPCneLWZk4kr/L79oSbTh7g+HnfS+BVsjdFh01ZRbJikRlTkbg6g6nHSqDCHhSbab8wbAQWQY8m9cVyOlTbe4UYXufp/3/Fltl/IRceU9Gzvpc8DTnKziNI8XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740688702; c=relaxed/simple;
	bh=Dk6IBlJu0n0+WId/S33KfuOKm6XfePS8EbVK2AdouUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZfE/chbGlSceUsqDUzgkJ9IHjzR5oIDj8adIL7uaKXq5FzwGzXwrWgOg6A1mRgci6O7mLIVCZi/1lSEidoE35EfpaYd0DW8J/+0RmRhbOsYbHO5/3KO/dptglSL7ElBWv5+O2vuSSld/RoFiIyZ8RHpk6TIrq8YjGsCUKiNP148=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+qVUNep; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+qVUNep"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30a2cdb2b98so13939511fa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 12:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740688699; x=1741293499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJE2eaMf4w0vxhvtjkCr+uBwDemJTNp/D5trIUvHCDo=;
        b=g+qVUNepZkUotR8ULgywGLLOTS+ysdxXC5I/HuoVXLKx7N0UPSe6JZG4h83CUuaf8Y
         pj+1ZmTa41RfVLkzjix3oxJ7C1kTfjtPihRjVi4eYevjcLKohW3V4M1lJTF7/rVjuOuH
         qR0EKBN8/eDqZyrth5c3gW5IFX9fTLUtg7OEmvtpaqvzb/PnU3NlmVEEysYGUEparq67
         qKDOMdD8i2D0vB8xsOB7rz+4lmsmWgLbM6WkUWcTuY+ObteXkyJMIxN730yqr2ZKhoLU
         Hhal/FfTFw2TeGcgkQhFieyzgCeBA/Ed/c8SEE4zY/cDuFKEPGHhLuI7y0N6hm3eKeZR
         ErCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740688699; x=1741293499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJE2eaMf4w0vxhvtjkCr+uBwDemJTNp/D5trIUvHCDo=;
        b=rKfmjCWRj1A2I22YJarzCZNkl1TKQTLFWm7l7bJYBWa4jnvu/NEU/CuMV5hd0r0GOC
         Ri2Oo4jNg+E7nIk71Y2OuiDA+MfxX04FxHgcK2LBm4YKdtHqpvhsX0bqciZbPyCfqGei
         +NPVRkCh8gXcfSITieUn/pSPJol6wGz47TmpGofQ42Nv8TzLBTS5b2PmjYL65i25EsPI
         L0DzuaHkffDSwfsx2k0du6qfYtZAb+qAd0GY1sDGNiSIh/R/fQRAr9gg0ra7zRWix6Ka
         ocWGGpNyAmnxpCDA4b2E5CqExxY/hv293SkFrgPP7FcNod63h93SZ9slzLfWb3XkBkmZ
         jMXA==
X-Gm-Message-State: AOJu0YyTlTJJMkPowZMqSCgxQ2ASeYIItVmtiuC+82jAoXPPOVWbs3rQ
	zF8rkcDMTrZhUGnxPOD0TVdU9lUY4yKvjWMM+XPuqWZTG+zb5h0jyImwTym4hNrC7u/XA2I5R7L
	9dXp4T6CdQ5uxJ5s4soEwgQwybT0=
X-Gm-Gg: ASbGncvZ6vMuKAw0CS7DtBwZz5xwy8aNiWCk6JMj1JKljJai8nx+6w6otGclLC7I0jC
	Zqw+xS67lpG84b84C1BlzR9fGmg8AbmcOqyAYWYb2YXXQK1gB4kaoZxbCcmzZJt0lb1r3hJ3hoM
	imZtWt0w==
X-Google-Smtp-Source: AGHT+IFEgpC65Gw8jlHoVd5gRuYZBzG4wNhbiGFBzXF1YMleXD0fZQuZFXmzKlcKNbiAEbPrPcXfi8voxCYpbvGnlxs=
X-Received: by 2002:a2e:be2a:0:b0:308:fd11:7715 with SMTP id
 38308e7fff4ca-30b9344e0d1mr1325801fa.33.1740688698391; Thu, 27 Feb 2025
 12:38:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dd9eaa0aee1e2fbeeb2015b807a3a2701af3a1bf.1740686998.git.pav@iki.fi>
In-Reply-To: <dd9eaa0aee1e2fbeeb2015b807a3a2701af3a1bf.1740686998.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 28 Feb 2025 01:38:06 +0500
X-Gm-Features: AQ5f1JoXE52aozFQZE_VOq7_PJZEmxTkccOz9KjL-lp0T5kx5wM0XA8AqtdWU2U
Message-ID: <CABBYNZJ=zqw1YN-S2JaA=swQk8+T+hL3+757t2y2P1ZMJzeoJg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: SCO: fix sco_conn refcounting on sco_conn_ready
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, eadavis@qq.com, luiz.von.dentz@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Thu, Feb 27, 2025 at 3:12=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> sco_conn refcount shall not be incremented a second time if the sk
> already owns the refcount.
>
> Fixes SCO socket shutdown not actually closing the SCO socket.
>
> Fixes: e6720779ae61 ("Bluetooth: SCO: Use kref to track lifetime of sco_c=
onn")
> ---
>
> Notes:
>     Making the sco_conn_add refcounts consistent in ed9588554943 exposed =
the
>     issue here.
>
>     I think this should fix the situation, but didn't yet test this in re=
al
>     use, only the sco-tester test case.
>
>  net/bluetooth/sco.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index aa7bfe26cb40..ad09b1b8e89a 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -1353,6 +1353,7 @@ static void sco_conn_ready(struct sco_conn *conn)
>                 bacpy(&sco_pi(sk)->src, &conn->hcon->src);
>                 bacpy(&sco_pi(sk)->dst, &conn->hcon->dst);
>
> +               sco_conn_hold_unless_zero(conn);

Shouldn't it check if the result is NULL otherwise perhaps we should
add sco_conn_hold which doesn't use kref_get_unless_zero.

>                 hci_conn_hold(conn->hcon);
>                 __sco_chan_add(conn, sk, parent);
>
> @@ -1411,8 +1412,10 @@ static void sco_connect_cfm(struct hci_conn *hcon,=
 __u8 status)
>                 struct sco_conn *conn;
>
>                 conn =3D sco_conn_add(hcon);
> -               if (conn)
> +               if (conn) {
>                         sco_conn_ready(conn);
> +                       sco_conn_put(conn);

Well we did this a little bit differently in iso:

    conn =3D iso_conn_hold_unless_zero(conn);
    if (conn) {
        if (!conn->hcon) {
            iso_conn_lock(conn);
            conn->hcon =3D hcon;
            iso_conn_unlock(conn);
        }
        iso_conn_put(conn);
        return conn;

But it looks like we changed that with ed9588554943 ("Bluetooth: SCO:
remove the redundant sco_conn_put"), I wonder if we have something
similar in ISO as well.

> +               }
>         } else
>                 sco_conn_del(hcon, bt_to_errno(status));
>  }
> --
> 2.48.1
>
>


--=20
Luiz Augusto von Dentz
