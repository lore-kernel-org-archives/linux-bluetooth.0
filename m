Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964461A8C18;
	Thu, 20 Jun 2024 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718902416; cv=none; b=SCAxs95KBS9JRi6TPesREo/xIeusnV3WVzZuUakkuG1tMLk+IQ9zysPOmj5yfb/NK+yWbTtrQyPQu5ZjYFTHTeRV8xqZSvIes+Z+PTxJDiEH9632e0gMSGFX0Lx1DQEBOxzfXEHq/MHTtRjvV0nLPXVmUpkVV2ql9jFu6lviJX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718902416; c=relaxed/simple;
	bh=iM5Eg97x8n8d8z/94RRfa6VktLX6DakK5UrL/H3w44k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sN8VZr4zz9XW87nQGTQ0MCbZrtlH8f+riucJDugbqFqO5cKDUn1Yq/LD7Fw2afkoSIGVzyvs8J+g/WmSnR41WUXcgJVNVAFAEHiQFSDW7RPhH2FPxW+B8UxV9byn6g2+dznSDWu7aMJ5xcg4izW63tRea9MEAoQRZDZV6g33Uxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I09D2cnI; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I09D2cnI"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ebe3bac6c6so13292431fa.1;
        Thu, 20 Jun 2024 09:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718902413; x=1719507213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlSI1kU5EfoPWbu4rORadLRlFAtcZ+ELmaMk1xCCeVI=;
        b=I09D2cnIm1hQf9lUyh2xpLW0JRaCM7dmeYHSytahgCGESQyaYxDwx8lAHjcxGyMelN
         Bt5knjmDCmGmTvmLeuWn/x14cuhuphgZpQr3xjcIyD5ZZJRcrwxF6OsKztGZnSqi3EQy
         tkNay8DDPQ+aP0wNEhu7n/JSZ948o7N47E2QIlfYui7hiH/bzR8msn2o86v/PIl90Rs2
         QdMt7TlsbuqpNTUxBydxDCxktwWL25VSlaCYOXQ5Rok8dX/42RfVpSuKKSiGPnN1pAnZ
         9j3tAVwxOnCLVHWYmMrVc5aIxKXJjyolxnPQPQ+8PIXl2QOrJ6uKZnQc3feIJ5gMD/E0
         ocDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718902413; x=1719507213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XlSI1kU5EfoPWbu4rORadLRlFAtcZ+ELmaMk1xCCeVI=;
        b=PRxg8M2ugR1QyfXqHhA/HfzYZxEW6m9xkIhqZv7O7B7VaOAVDl0OvCbMpacLwFGaYM
         b77pB7R4q2/GnC3q/W/ByhzgjIzu3VqNIH9Mi4qyfsEfW+2n4k3hqT/q1Jp0D9FXZu8j
         TMttTF3Na0uU02gkjGpljwE+ykNnhUOR4Y4Nsrepg8MTXlayFn36wv//bdFE+sDMszcS
         iM0rijEt2NDTjnrWz4YclKs66b1YDbNErXJrneYOURvP4u+zanwn0Xv2XDmWeiL49E8Q
         vHWTuAKZdQHsyFvBUKw0mKdhe6U4PZosGD1Arx+FU5fC2v497tHu96HMYaet5nLoRDs6
         Nb2A==
X-Forwarded-Encrypted: i=1; AJvYcCXoyM3G3VlgredCXrZ1geNYb+l4dsLZ2Iii3E1VMXKT2DTBS+ECQ+ADVyzXNEJ9tn5vHPXTCIaPCeTeGYciy8rwQIIt0YXXnqkDhCGirklCG4bxtzwqP5Q08G/gCSow1oQgRyh40QfDCEdOLzJW
X-Gm-Message-State: AOJu0Yz5stXDCZ+RfI+VXqSP7PBJxg+WR5EJT1fKzEA2OndGBVpoBWXq
	UJ9tQB6+lJv/JJhI8eYwnjjNepiELa9EspT1uk04McSV1vTAYOLOQlZXp+EqrakounD8pnKLXXh
	X6VykcweiUhZywrfDJAgoF4EkVyM=
X-Google-Smtp-Source: AGHT+IFYNYaMtnMjT1lCQBP24bfOt2PsGSoUdV1BJ8zPVziliE1+X33uhkQ2caEYoAad3z1jsIsKR1FmYKEPuzMlGZQ=
X-Received: by 2002:a2e:9949:0:b0:2eb:d9b3:634b with SMTP id
 38308e7fff4ca-2ec3cfe0d2cmr41715041fa.46.1718902412428; Thu, 20 Jun 2024
 09:53:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZKArASNApkJPvJn8C4HE0y5aZy0X2ZrOjjdrsDhBO+7rQ@mail.gmail.com>
 <tencent_8D9918CF808DC6A5FF8DCB12055DECDDF107@qq.com>
In-Reply-To: <tencent_8D9918CF808DC6A5FF8DCB12055DECDDF107@qq.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 20 Jun 2024 12:53:19 -0400
Message-ID: <CABBYNZLu-wAu6cdyDVim=bP+0Ld-P=YvENO=fa6r=rdY4UqukQ@mail.gmail.com>
Subject: Re: [PATCH v2] bluetooth/l2cap: sync sock recv cb and release
To: Edward Adam Davis <eadavis@qq.com>
Cc: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marcel@holtmann.org, 
	syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Edward,

On Fri, Jun 14, 2024 at 9:46=E2=80=AFPM Edward Adam Davis <eadavis@qq.com> =
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
> Sock is dead, so set chan data to NULL, avoid others use invalid sock poi=
nter.
>
> Reported-and-tested-by: syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail=
.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  net/bluetooth/l2cap_sock.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 6db60946c627..f45cdf9bc985 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -1239,6 +1239,10 @@ static void l2cap_sock_kill(struct sock *sk)
>
>         BT_DBG("sk %p state %s", sk, state_to_string(sk->sk_state));
>
> +       /* Sock is dead, so set chan data to NULL, avoid other task use i=
nvalid
> +        * sock pointer.
> +        */
> +       l2cap_pi(sk)->chan->data =3D NULL;
>         /* Kill poor orphan */
>
>         l2cap_chan_put(l2cap_pi(sk)->chan);
> @@ -1481,12 +1485,25 @@ static struct l2cap_chan *l2cap_sock_new_connecti=
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
> +       /* To avoid race with sock_release, a chan lock needs to be added=
 here
> +        * to synchronize the sock.
> +        */
> +       l2cap_chan_hold(chan);
> +       l2cap_chan_lock(chan);
> +       sk =3D chan->data;
>
> +       if (!sk) {
> +               l2cap_chan_unlock(chan);
> +               l2cap_chan_put(chan);
> +               return -ENXIO;
> +       }
> +
> +       pi =3D l2cap_pi(sk);
> +       lock_sock(sk);
>         if (chan->mode =3D=3D L2CAP_MODE_ERTM && !list_empty(&pi->rx_busy=
)) {
>                 err =3D -ENOMEM;
>                 goto done;
> @@ -1535,6 +1552,8 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *ch=
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

Looks like this was never really tested properly:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
WARNING: possible recursive locking detected
6.10.0-rc3-g4029dba6b6f1 #6823 Not tainted
--------------------------------------------
kworker/u5:0/35 is trying to acquire lock:
ffff888002ec2510 (&chan->lock#2/1){+.+.}-{3:3}, at:
l2cap_sock_recv_cb+0x44/0x1e0

but task is already holding lock:
ffff888002ec2510 (&chan->lock#2/1){+.+.}-{3:3}, at:
l2cap_get_chan_by_scid+0xaf/0xd0

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&chan->lock#2/1);
  lock(&chan->lock#2/1);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by kworker/u5:0/35:
 #0: ffff888002b8a940 ((wq_completion)hci0#2){+.+.}-{0:0}, at:
process_one_work+0x750/0x930
 #1: ffff888002c67dd0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0},
at: process_one_work+0x44e/0x930
 #2: ffff888002ec2510 (&chan->lock#2/1){+.+.}-{3:3}, at:
l2cap_get_chan_by_scid+0xaf/0xd0

l2cap_sock_recv_cb is assumed to be called with the chan_lock held so
perhaps we can just do:

       sk =3D chan->data;
       if (!sk)
               return -ENXIO;

--=20
Luiz Augusto von Dentz
