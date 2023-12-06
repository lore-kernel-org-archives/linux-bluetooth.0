Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZLUGhI1"
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30928D44
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Dec 2023 06:49:15 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c9f57d9952so56132141fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Dec 2023 06:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701874153; x=1702478953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQ0VIk/oR07oL4sjexz0vNJR+kU5X1BQPaQJo4zaTSk=;
        b=kZLUGhI1NpuW8eZZ8IHuLqmRdJu1r8My9mePO/uMvvDb03o26x3xpLPqN0hTKXPsYI
         JKN/8h+prcuwuq5++H61jte/jcZ+WUtg7nO6TILZBB1F/NR5U9iX1pSK9DWPS8YgGx51
         bfpHP1U7VsZE8cJcDPUqirx4nxmvt8hvNaJbPrvYif92nLlKVznKS8T+w2MEPt/IfgxD
         0NuKhoTblbURHF+71n01sHunNLewG9zDQf15ZadtyQH394/aHRJ8Y4SwIwdAoFFkIv61
         AIN/dR8OaI101n4unj2fxjDxBDP/smFb5qO+fgds+rJ/mj/qU8kZNr2Aeg3GnhCSgAGY
         ZbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701874153; x=1702478953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQ0VIk/oR07oL4sjexz0vNJR+kU5X1BQPaQJo4zaTSk=;
        b=hAwQ9v04OYw3+8UJWaIAKAO51Bgq+TIHANHRkt2YupKpbR3uXxu5FZwLjtcpRbyQM5
         LoPFsSPKD4hNrz9hloyKQVBIfCfDCg1RWSSWazUn2j//kBGotCn8TJ9n0tY1I0W2qCe7
         QBX8XDYKea4C7Lrh6qCty4deJ+m+jVKEn1dfnDwppci1pA0lv6RCAbHkvNOjA6zkEVVE
         FIiCMt9h//enOtE5glyf80ew8S2iuCFxbtCSHw9OJm9DEMgoF5DzJeK33pbwZMGKPIkI
         GRPI37PbvFeDvvxH5FzLWn/7265L3pWkevDLGhE8q1Xlg8U8FPdt2qx0L8j3XwpaeMNR
         aQYQ==
X-Gm-Message-State: AOJu0YwJ1yXYLwfPxcDvedadPbnJgwuOHNOqKFq/MQQzfvL2o5pEyJGe
	uEP6tTC/NWTooxyxEeaygv9BmaZBxhSAdtBFWhU=
X-Google-Smtp-Source: AGHT+IGIEa0WVkaXvmoZla8+ajPeOOU9CGKw6pbHhQAieHGNYtTdGG2opD55Krk8/TBoIKSVBAmAicOB52XNWx0zSiA=
X-Received: by 2002:a2e:9991:0:b0:2ca:20ce:8391 with SMTP id
 w17-20020a2e9991000000b002ca20ce8391mr593765lji.32.1701874152963; Wed, 06 Dec
 2023 06:49:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204070243.GA16386@ubuntu>
In-Reply-To: <20231204070243.GA16386@ubuntu>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 6 Dec 2023 09:48:59 -0500
Message-ID: <CABBYNZ+Bnva7CCz3ds25Qx4xnbduXTdSX_FgXAttWSmSuYJadQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: af_bluetooth: Fix Use-After-Free in bt_sock_recvmsg
To: Hyunwoo Kim <v4bel@theori.io>
Cc: marcel@holtmann.org, imv4bel@gmail.com, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kim,

On Mon, Dec 4, 2023 at 2:02=E2=80=AFAM Hyunwoo Kim <v4bel@theori.io> wrote:
>
> This can cause a race with bt_sock_ioctl() because
> bt_sock_recvmsg() gets the skb from sk->sk_receive_queue
> and then frees it without holding lock_sock.
> A use-after-free for a skb occurs with the following flow.
> ```
> bt_sock_recvmsg() -> skb_recv_datagram() -> skb_free_datagram()
> bt_sock_ioctl() -> skb_peek()
> ```
> Add lock_sock to bt_sock_recvmsg() to fix this issue.
>
> Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
> ---
>  net/bluetooth/af_bluetooth.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> index 336a76165454..9def13ac816e 100644
> --- a/net/bluetooth/af_bluetooth.c
> +++ b/net/bluetooth/af_bluetooth.c
> @@ -309,11 +309,16 @@ int bt_sock_recvmsg(struct socket *sock, struct msg=
hdr *msg, size_t len,
>         if (flags & MSG_OOB)
>                 return -EOPNOTSUPP;
>
> +       lock_sock(sk);
> +
>         skb =3D skb_recv_datagram(sk, flags, &err);
>         if (!skb) {
> -               if (sk->sk_shutdown & RCV_SHUTDOWN)
> +               if (sk->sk_shutdown & RCV_SHUTDOWN) {
> +                       release_sock(sk);

We could just reset the with err =3D 0 then we don't need to duplicate
the release_sock line.

>                         return 0;
> +               }
>
> +               release_sock(sk);
>                 return err;
>         }
>
> @@ -343,6 +348,8 @@ int bt_sock_recvmsg(struct socket *sock, struct msghd=
r *msg, size_t len,
>
>         skb_free_datagram(sk, skb);
>
> +       release_sock(sk);
> +
>         if (flags & MSG_TRUNC)
>                 copied =3D skblen;
>
> --
> 2.25.1
>


--=20
Luiz Augusto von Dentz
