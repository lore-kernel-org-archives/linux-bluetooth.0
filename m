Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208C65FB9C;
	Tue, 11 Jun 2024 19:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718133908; cv=none; b=rePP4kW0To6YchN69t9/LNhfrXCloULM+6HGTO4IGh9rcjrNi3TAYNid85diygXeCzRzg943A2x9VXEv5hO5MnX9tSZKU0ol161U7Sus73HH5LVw6m4wR9+19JQVHBpQk+8/lAdkYMgbJO9IUb/v/RWNQI5ILHxKkZE9o6GBzeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718133908; c=relaxed/simple;
	bh=ZlctbvISggU/IR0Z8HVQ39WCh4kYz+88uDsp1+kzNvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bo9g0wgZui2j+OeFCeHDsZLcAzzB3hKAb2p40WWIEP9Do32mWcwnm8ppkrhES2k3KjzAFTThXoKM2Hamvf0W96wYTplheArsvgNy07tTEz7MA1WFW7hWwrkZq5z54Gln4RweYRbMNBUSeV2I7Cesr7z3A0knL2HgoAgYy1qEeyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFEvyXmd; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFEvyXmd"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ead2c6b50bso65118591fa.0;
        Tue, 11 Jun 2024 12:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718133905; x=1718738705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=va8dz7D20FrM2u2YnvurTRYFp7B2BS0KhG32rSBaKco=;
        b=AFEvyXmdHeSKzF+bDW5DotPacX90Eq66QhMS3XAK/ieTfQ4hI+5ZubvBOHbRgC7qWu
         ar73Xnxq2aRfYy2qxI4brYuvl4u+2ontXrVB3plSJve7kFQ+gfuagzrVj5n8lb6UI8S8
         2qREUbugl1gxHLC6mwumw4Yeac35/TaueZ0nbUMg4lxnkJ4co9C1R12DBmjnUW0y1t7d
         1Di/DlpIG56ZYwkMY0QPgYz27vxpc1wIYrZHEiwaJp08isdTzqMRZj5hYhmCsYz4pHq5
         2Ayj2av5JpD1gEFu6T9hgUauI9bko3tTWd2odG73d2hFchMQKEAM1+wI2uy+iL30qVxr
         UzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718133905; x=1718738705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=va8dz7D20FrM2u2YnvurTRYFp7B2BS0KhG32rSBaKco=;
        b=ruRh4nTi8pMwSQI66IXBNmIytNM1Q7p7NG6B3o6ibb+xuP2Zcncbj+p/vVpldnbd0K
         uJj+lCthSvVDtzielKapOYtTs+SaV9MN6U86JpMCTkN+zvcgncJ/xto07qOa7VI3CopN
         84/7A/nYSqIAhvGsktKzSwDw+coPx2+7BHPhmJWiDHgHs8Bc139Mi3SDVFH7k/cy1vY/
         PaUyv2JrR6iXKS5gbAc8kCp0Ey0iHZ3AiNB00RJTU1ruvT7oTOGBpo3HPyikH2jwFdf5
         yo83xIctuU40N/mPuckI8SXutPP+QQoXL+Mjrm2w2NNkw41lY5NDCT0OY8spQjdpjH6X
         bwJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiDP1YQjYovxPncrRnRAb/P+q8v+jD3JDf2RvYWOoRijyyUvzlOuAMl330+U2nIq562rapHs1QX1Dc6WjS5lYhtFK7h70KZKSj5b0iqMPtPCZGZg90U/V74Mg6b3UxGcfL+yIqlsb5FMpUpM74
X-Gm-Message-State: AOJu0Yzr1Sd8AH6sp9bJLilJdcOUdWhGSLsSKiL/B/j/UkqR+95ce1KF
	5CxCLnpxNige6F9cCLecuS+B6JOW7uAkMiw7lU1DQNTpCcCAK7vS6m6bfjJOyqr36/sNLeu44ZL
	1QlQ+foeSMu6k1Y5zKZpmKLaPV8E=
X-Google-Smtp-Source: AGHT+IG1s1p1OCjXp50p8aaf6uG+icxiijMJOKfJNYMOANGmaBghlhEGl+p0iVjZrFxnRq7JaQGyvJnobD5yZWbq3Mk=
X-Received: by 2002:a2e:a793:0:b0:2eb:d9c4:ae1a with SMTP id
 38308e7fff4ca-2ebd9c4b183mr72249711fa.40.1718133904960; Tue, 11 Jun 2024
 12:25:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000b0906d061a468b93@google.com> <tencent_0CCE4C90A7C306FCD2EE466AC9882EFFAE06@qq.com>
In-Reply-To: <tencent_0CCE4C90A7C306FCD2EE466AC9882EFFAE06@qq.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 11 Jun 2024 15:24:52 -0400
Message-ID: <CABBYNZKArASNApkJPvJn8C4HE0y5aZy0X2ZrOjjdrsDhBO+7rQ@mail.gmail.com>
Subject: Re: [PATCH] bluetooth/l2cap: sync sock recv cb and release
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com, 
	johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Edward,

On Tue, Jun 11, 2024 at 10:50=E2=80=AFAM Edward Adam Davis <eadavis@qq.com>=
 wrote:
>
> The problem occurs between the system call to close the sock and hci_rx_w=
ork,
> where the former releases the sock and the latter accesses it without loc=
k protection.
>
>            CPU0                       CPU1
>            ----                       ----
>            sock_close                 hci_rx_work
>            l2cap_sock_release         hci_acldata_packet
>            l2cap_sock_kill            l2cap_recv_frame
>            sk_free                    l2cap_conless_channel
>                                       l2cap_sock_recv_cb
>
> If hci_rx_work processes the data that needs to be received before the so=
ck is
> closed, then everything is normal; Otherwise, the work thread may access =
the
> released sock when receiving data.
>
> Add a chan mutex in the rx callback of the sock to achieve synchronizatio=
n between
> the sock release and recv cb.
>
> Reported-and-tested-by: syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail=
.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  net/bluetooth/l2cap_sock.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 6db60946c627..f3e9236293e1 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -1413,6 +1413,8 @@ static int l2cap_sock_release(struct socket *sock)
>         l2cap_chan_hold(chan);
>         l2cap_chan_lock(chan);
>
> +       if (refcount_read(&sk->sk_refcnt) =3D=3D 1)
> +               chan->data =3D NULL;

Might be a good idea to add some comment on why checking for refcount
=3D=3D 1 is the right thing to do here, or perhaps we can always assign
chan->data to NULL, instead of that perhaps we could have it done in
l2cap_sock_kill?

>         sock_orphan(sk);
>         l2cap_sock_kill(sk);
>
> @@ -1481,12 +1483,22 @@ static struct l2cap_chan *l2cap_sock_new_connecti=
on_cb(struct l2cap_chan *chan)
>
>  static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *s=
kb)
>  {
> -       struct sock *sk =3D chan->data;
> -       struct l2cap_pinfo *pi =3D l2cap_pi(sk);
> +       struct sock *sk;
> +       struct l2cap_pinfo *pi;
>         int err;
>
> -       lock_sock(sk);
> +       l2cap_chan_hold(chan);
> +       l2cap_chan_lock(chan);
> +       sk =3D chan->data;
> +
> +       if (!sk) {
> +               l2cap_chan_unlock(chan);
> +               l2cap_chan_put(chan);
> +               return -ENXIO;
> +       }
>
> +       pi =3D l2cap_pi(sk);
> +       lock_sock(sk);
>         if (chan->mode =3D=3D L2CAP_MODE_ERTM && !list_empty(&pi->rx_busy=
)) {
>                 err =3D -ENOMEM;
>                 goto done;
> @@ -1535,6 +1547,8 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *ch=
an, struct sk_buff *skb)
>
>  done:
>         release_sock(sk);
> +       l2cap_chan_unlock(chan);
> +       l2cap_chan_put(chan);
>
>         return err;
>  }
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
