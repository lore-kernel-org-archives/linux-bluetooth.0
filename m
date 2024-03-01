Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C293A269
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Mar 2024 19:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319644; cv=none; b=HThnHvTPx0DNDgg/cOqJPHvpF++WiUawAdkXzRLkYY+YXmrJUtiL8+O/nNb7FCThjL1VCKwYLBuIuEEojO5Aj5z5OnvX3qtkkN7PkMFosJ5qoGwmKZl/1c96fpn+TjNZA5iw8OdHl76sHpWtuyxLy56U3t8mFnnk/PyyWA+byWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319644; c=relaxed/simple;
	bh=p0iCQF6tfZ3sTkEb5KQvRA0IoMtLbnCQ5cdI3WdtlJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Am2Xm6Nf/5w2qNCYB8bOhy3bOaj/vS5rBnlOA7BCv+myAzsf5O5sFWuxppxjaFW4ymhUioRJdlVPpIqyoLIfNC54VZwTNCkT05BSl8GWUxj1F6qrvM3DXrV7Cv5NU2E1kEAfOAmAq0Iq9ZA+Heg6XKsCXfr6FWQ+5vBibR06+r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXflwiKq; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXflwiKq"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d22b8801b9so30810191fa.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Mar 2024 11:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709319623; x=1709924423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSCUpYDM+vEb9vAJjmz++xzqFFb0ZAQgxxcYXzxgeJ4=;
        b=PXflwiKqWvZHRclKUO6yqvw289E6HTgSXeMDzsaqPlCxdMDKavxi55ssLXd7oF3bnj
         zNFzxhLAL2CjYVP1dsP+GOKGvvfHM5sEZco/RUUQSBcnh8xVHz3VDXZ5iLtBytmTYx/4
         UoWyiNsRFVpHpPTq2pmMYltDwUH6UpAXKa72gMRR5vtIcKnfqhQBCLtSSm23Mi6pt6UZ
         r3OjRrH0bdRZu+U8Q45yRmoDvQSHPI56rCkKo5MVLZwiNFvANOBkhf+Fd2MSwzXAnOPj
         zSgHQRfsAOacFEVTapXW40nAjSeJIkYsHzOGo/pcf8dyRK2a8XQtmBh3VYDSiaXxSLuz
         YuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709319623; x=1709924423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSCUpYDM+vEb9vAJjmz++xzqFFb0ZAQgxxcYXzxgeJ4=;
        b=kv/S59FeEWFIWNg/t3k6yOuQFxyf6/KJ/59lTjYiYwupdm+gItQIc/4iWQXmHE43y7
         /8PWnBXstmwCMooyB80j9dvID2Gf+plRUwx78fGiuU3es8l0xVFz1tiUA1VaITrsEJxJ
         JkW7jYsKFRMZicLhYWi625RPNiFQtNzWfLDpAs6TEKeGG724Ttt03WyU0aSM+kXtxv0V
         xA+n2alLDhBh2Iv8a39XhMwwlgbWDbCjARAUFMpueU/cDAav4TnBQ9SafdgSk8wBUApL
         EM9ULj7pMMNkLIBEXnUWxwqmKISX35y4DrJVwI1ANrhoBziDzcVHbiKV1ilAqWoWjFPT
         EbUg==
X-Gm-Message-State: AOJu0Yxi2S3zAMaTQ3sETQsOc3SqtC9i5E33HmR8ahI+kJcFC/GhypBZ
	eNFKx0yqjLuM11O8iuKJ7d5NGNgN+kCtirMIJe579FmQzW1nHDzxVIdQ7kzYtPyGLfyGlFdB2hf
	S6nwc4fmEe/8HoWOjZTfN0qMycjSMbaZU
X-Google-Smtp-Source: AGHT+IE92zhMgYr16m1QWwELp/Xtw1MwxnOqm9hrmChibeJ1TgIo3aYF2GWoggj5NY2eVXIhxcOzXljahTTZytvVrdI=
X-Received: by 2002:a2e:a222:0:b0:2d2:db6e:77e with SMTP id
 i2-20020a2ea222000000b002d2db6e077emr1656632ljm.15.1709319622820; Fri, 01 Mar
 2024 11:00:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301185034.2756103-1-luiz.dentz@gmail.com>
In-Reply-To: <20240301185034.2756103-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 1 Mar 2024 14:00:10 -0500
Message-ID: <CABBYNZ+0o2EqGtub9jBGHC+DLdb5ZNXbcc9FXquLtAxRAvGVVg@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: af_bluetooth: Fix deadlock
To: linux-bluetooth@vger.kernel.org
Cc: Hyunwoo Kim <v4bel@theori.io>, Simon Kirby <sim@hostway.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 1:50=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Attemting to do sock_lock on .recvmsg may cause a deadlock as shown
> bellow, so instead of using sock_sock this uses sk_receive_queue.lock
> on bt_sock_ioctl to avoid the UAF:
>
> INFO: task kworker/u9:1:121 blocked for more than 30 seconds.
>       Not tainted 6.7.6-lemon #183
> Workqueue: hci0 hci_rx_work
> Call Trace:
>  <TASK>
>  __schedule+0x37d/0xa00
>  schedule+0x32/0xe0
>  __lock_sock+0x68/0xa0
>  ? __pfx_autoremove_wake_function+0x10/0x10
>  lock_sock_nested+0x43/0x50
>  l2cap_sock_recv_cb+0x21/0xa0
>  l2cap_recv_frame+0x55b/0x30a0
>  ? psi_task_switch+0xeb/0x270
>  ? finish_task_switch.isra.0+0x93/0x2a0
>  hci_rx_work+0x33a/0x3f0
>  process_one_work+0x13a/0x2f0
>  worker_thread+0x2f0/0x410
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0xe0/0x110
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x2c/0x50
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1b/0x30
>  </TASK>
>
> Fixes: 2e07e8348ea4 ("Bluetooth: af_bluetooth: Fix Use-After-Free in bt_s=
ock_recvmsg")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/af_bluetooth.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> index b93464ac3517..67604ccec2f4 100644
> --- a/net/bluetooth/af_bluetooth.c
> +++ b/net/bluetooth/af_bluetooth.c
> @@ -309,14 +309,11 @@ int bt_sock_recvmsg(struct socket *sock, struct msg=
hdr *msg, size_t len,
>         if (flags & MSG_OOB)
>                 return -EOPNOTSUPP;
>
> -       lock_sock(sk);
> -
>         skb =3D skb_recv_datagram(sk, flags, &err);
>         if (!skb) {
>                 if (sk->sk_shutdown & RCV_SHUTDOWN)
>                         err =3D 0;
>
> -               release_sock(sk);
>                 return err;
>         }
>
> @@ -346,8 +343,6 @@ int bt_sock_recvmsg(struct socket *sock, struct msghd=
r *msg, size_t len,
>
>         skb_free_datagram(sk, skb);
>
> -       release_sock(sk);
> -
>         if (flags & MSG_TRUNC)
>                 copied =3D skblen;
>
> @@ -570,10 +565,11 @@ int bt_sock_ioctl(struct socket *sock, unsigned int=
 cmd, unsigned long arg)
>                 if (sk->sk_state =3D=3D BT_LISTEN)
>                         return -EINVAL;
>
> -               lock_sock(sk);
> +               spin_lock(&sk->sk_receive_queue.lock);
>                 skb =3D skb_peek(&sk->sk_receive_queue);
>                 amount =3D skb ? skb->len : 0;
> -               release_sock(sk);
> +               spin_unlock(&sk->sk_receive_queue.lock);
> +
>                 err =3D put_user(amount, (int __user *)arg);
>                 break;
>
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
