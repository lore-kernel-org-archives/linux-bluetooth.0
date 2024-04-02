Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C797415AD8E
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 18:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712081425; cv=none; b=e5RQlebET5voQW5ppc9PVF71/XbZ4pCwdkOxABWXPGIHQNJq93sGbUk+Ar2HaBE0UrZ8eiQgv2dlipPkoet956OmlPMTIltgqPRZdFIa0x3m58KyIztO1kJoNGZy8draVCXAHDI1GWWddqJAO5SyeMVAxs/2Q6YokBYTVFzQNWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712081425; c=relaxed/simple;
	bh=PVqI/9LEAqmDZVC1hFvWHUceM9zIXDWY1nnq5RRWBZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fx34ERBKjUWf7ejmZu3YOpanHH8ECjV1OKPSVjPK9eAMVmpBD+wYF6Ft+UdoY3xt3Udny36RGZIju09e1wNfmvMD7Q3wMW8JsNfUl+slfBFhr8DaqHw4SvGyr/rZm2RAPdURcd7C45Yw2ApQJOcXxAHL+orwgNYIzu1h+zS1mOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHWZ5N4x; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHWZ5N4x"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d718efedb2so81144641fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Apr 2024 11:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712081422; x=1712686222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uAFHw3IeVbrmsweXn1cbmGf65Lx6lspieG5GDVF/nA=;
        b=fHWZ5N4xAY0Q62OfwHpwpev8sr8/TwvXnA6AiXsEphtkU1GrjykCjmDAO2aGsSHE5s
         8RoxHoxE94CklNNkufbN85zBE9O7DLaxrQFEaYZ09y4iJvOcvK7+g6eb1/d+eo96Wvlh
         rU8Rm5gxg+jc9P6U/s/NhQyuMFuVp9wa74eWv5b0qf3FtizyP+bZwqf9NkFpsX82NWXS
         w/GPMrX2O7G0XDXqSU42sgGankEQaUTXhcCY+t6oMAszuYAa2/glex5VJKucCFK7XZX6
         WgDgh1KAVJ8rjckJNRRvRh27NbxX8EKdblsOjINR69zEcBe5bBPlhPEcqzXvjYnWX+ut
         h6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712081422; x=1712686222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0uAFHw3IeVbrmsweXn1cbmGf65Lx6lspieG5GDVF/nA=;
        b=tOEWLRTKbut41tzMAKa+CSyvQT3ib1fBjihWHj786R0D7i+pOSW7EbKYg1blq3Fxmk
         koX6V9NT/y7S/O8WsxLPLqWRm0js5alBdy7qNKdTmRKHFZNK56t0OPsbiuhUhFY3iZfu
         n/lNFcSvuqNq+cRHvW3pBbDAj1KzvtXScUIWG56QlTQN0Z5sGzYe29nKkK0UABiqdm5F
         I5pvt+8gO1JcHa9Xy85g/LybQKVazxC9Y76gUZYDV8AJ+QbSyGS2xoiBaXFH+wMBs75T
         DQuAfP43eu32QRTkE9yHDyGUeiCzIRYgq+2VnnFybMf9qXRZH1xyQWxWzi24SKJkXtXH
         gXUg==
X-Gm-Message-State: AOJu0Yy33M1RF81j/jeZKFyhcG5m+PXyy9PfAtQpPzOoeoy8W9bKTdss
	8RwyL5IPkN/AeRHrYoh9XbeNVBLg0+IaYqqBwmUy3QmtyiQ+Fix0rPrxs3smfdjdvPU5LyGzCvP
	WsEzNqFbWHVpBIPCUxPozmvcJ5dk=
X-Google-Smtp-Source: AGHT+IEidyCbBDvUxCbCbqP90xUFuuFZE/gITUfenojDTdURsjXo9NrnB3D7mP1nH4mQGyF62zG7ppmqmsYhzkxNgSE=
X-Received: by 2002:a05:651c:19ab:b0:2d7:11bf:1fc4 with SMTP id
 bx43-20020a05651c19ab00b002d711bf1fc4mr2393764ljb.42.1712081421738; Tue, 02
 Apr 2024 11:10:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b44e1da7ebbfe99b74c136b8750981a4fb0ab243.1712075760.git.pav@iki.fi>
In-Reply-To: <b44e1da7ebbfe99b74c136b8750981a4fb0ab243.1712075760.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 2 Apr 2024 14:10:08 -0400
Message-ID: <CABBYNZJoAjqF2Ay_gWhvU-Am+FZ4hXxuB3PM6yHR4-DZ+QOymA@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: add experimental BT_NO_ERRQUEUE_POLL socket option
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Tue, Apr 2, 2024 at 12:41=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Add experimental feature that enables a SOL_BLUETOOTH socket option to
> disable POLLERR on non-empty socket error queue.  Add corresponding MGMT
> experimental feature UUID for it.
>
> This is intended to allow applications disable the POLLERR wakeups due
> to TX timestamps, and allow upper layers of the stack to enable and
> consume TX timestamps, without needing to complicate the lower layer
> POLLERR handling which is only interested in real socket errors.
>
> It is a socket option disabled by default, as it enables a deviation
> from the common net/ TX timestamping API.
>
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>  include/net/bluetooth/bluetooth.h | 12 +++-
>  net/bluetooth/af_bluetooth.c      | 98 ++++++++++++++++++++++++++++++-
>  net/bluetooth/iso.c               |  8 +--
>  net/bluetooth/l2cap_sock.c        |  8 +--
>  net/bluetooth/mgmt.c              | 63 +++++++++++++++++++-
>  net/bluetooth/sco.c               |  8 +--
>  6 files changed, 181 insertions(+), 16 deletions(-)
>
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bl=
uetooth.h
> index c95afcd9c605..0f11b436e5b3 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -242,6 +242,8 @@ struct bt_codecs {
>
>  #define BT_ISO_BASE            20
>
> +#define BT_NO_ERRQUEUE_POLL    21

Perhaps we should revert the logic here and have it as
BT_POLL_ERRQUEUE which by default shall be considered enabled, that
said don't we have a race if SO_TXTIMESTAMP is send ahead it could
enqueue events on errqueue thus triggering the socket to wake up even
if it later sends BT_POLL_ERRQUEUE? Or that stops the wake ups
regardless?

>  __printf(1, 2)
>  void bt_info(const char *fmt, ...);
>  __printf(1, 2)
> @@ -389,7 +391,8 @@ struct bt_sock {
>  enum {
>         BT_SK_DEFER_SETUP,
>         BT_SK_SUSPEND,
> -       BT_SK_PKT_STATUS
> +       BT_SK_PKT_STATUS,
> +       BT_SK_NO_ERRQUEUE_POLL
>  };
>
>  struct bt_sock_list {
> @@ -412,6 +415,10 @@ int  bt_sock_stream_recvmsg(struct socket *sock, str=
uct msghdr *msg,
>                             size_t len, int flags);
>  __poll_t bt_sock_poll(struct file *file, struct socket *sock, poll_table=
 *wait);
>  int  bt_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long =
arg);
> +int bt_sock_setsockopt(struct socket *sock, int level, int optname,
> +                      sockptr_t optval, unsigned int optlen);
> +int bt_sock_getsockopt(struct socket *sock, int level, int optname,
> +                      char __user *optval, int __user *optlen);
>  int  bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo)=
;
>  int  bt_sock_wait_ready(struct sock *sk, unsigned int msg_flags);
>
> @@ -652,4 +659,7 @@ void mgmt_cleanup(struct sock *sk);
>
>  void bt_sock_reclassify_lock(struct sock *sk, int proto);
>
> +int bt_no_errqueue_poll_set_enabled(bool enabled);
> +bool bt_no_errqueue_poll_enabled(void);
> +
>  #endif /* __BLUETOOTH_H */
> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> index 67604ccec2f4..cee4814f2aae 100644
> --- a/net/bluetooth/af_bluetooth.c
> +++ b/net/bluetooth/af_bluetooth.c
> @@ -68,6 +68,8 @@ static const char *const bt_slock_key_strings[BT_MAX_PR=
OTO] =3D {
>         "slock-AF_BLUETOOTH-BTPROTO_ISO",
>  };
>
> +static bool no_errqueue_poll_enabled;
> +
>  void bt_sock_reclassify_lock(struct sock *sk, int proto)
>  {
>         BUG_ON(!sk);
> @@ -500,6 +502,26 @@ static inline __poll_t bt_accept_poll(struct sock *p=
arent)
>         return 0;
>  }
>
> +int bt_no_errqueue_poll_set_enabled(bool enabled)
> +{
> +       if (enabled !=3D no_errqueue_poll_enabled) {
> +               WRITE_ONCE(no_errqueue_poll_enabled, enabled);
> +               return 0;
> +       }
> +       return 1;
> +}
> +
> +bool bt_no_errqueue_poll_enabled(void)
> +{
> +       return READ_ONCE(no_errqueue_poll_enabled);
> +}
> +
> +static bool bt_sock_error_queue_poll(struct sock *sk)
> +{
> +       return !test_bit(BT_SK_NO_ERRQUEUE_POLL, &bt_sk(sk)->flags) &&
> +               !skb_queue_empty_lockless(&sk->sk_error_queue);
> +}
> +
>  __poll_t bt_sock_poll(struct file *file, struct socket *sock,
>                       poll_table *wait)
>  {
> @@ -511,7 +533,7 @@ __poll_t bt_sock_poll(struct file *file, struct socke=
t *sock,
>         if (sk->sk_state =3D=3D BT_LISTEN)
>                 return bt_accept_poll(sk);
>
> -       if (sk->sk_err || !skb_queue_empty_lockless(&sk->sk_error_queue))
> +       if (sk->sk_err || bt_sock_error_queue_poll(sk))
>                 mask |=3D EPOLLERR |
>                         (sock_flag(sk, SOCK_SELECT_ERR_QUEUE) ? EPOLLPRI =
: 0);
>
> @@ -582,6 +604,80 @@ int bt_sock_ioctl(struct socket *sock, unsigned int =
cmd, unsigned long arg)
>  }
>  EXPORT_SYMBOL(bt_sock_ioctl);
>
> +int bt_sock_setsockopt(struct socket *sock, int level, int optname,
> +                      sockptr_t optval, unsigned int optlen)
> +{
> +       struct sock *sk =3D sock->sk;
> +       int err =3D 0;
> +       u32 opt;
> +
> +       if (level !=3D SOL_BLUETOOTH)
> +               return -ENOPROTOOPT;
> +
> +       lock_sock(sk);
> +
> +       switch (optname) {
> +       case BT_NO_ERRQUEUE_POLL:
> +               if (!bt_no_errqueue_poll_enabled()) {
> +                       err =3D -ENOPROTOOPT;
> +                       break;
> +               }
> +
> +               if (copy_from_sockptr(&opt, optval, sizeof(opt))) {
> +                       err =3D -EFAULT;
> +                       break;
> +               }
> +
> +               if (opt)
> +                       set_bit(BT_SK_NO_ERRQUEUE_POLL, &bt_sk(sk)->flags=
);
> +               else
> +                       clear_bit(BT_SK_NO_ERRQUEUE_POLL, &bt_sk(sk)->fla=
gs);
> +               break;
> +
> +       default:
> +               err =3D -ENOPROTOOPT;
> +               break;
> +       }
> +
> +       release_sock(sk);
> +       return err;
> +}
> +EXPORT_SYMBOL(bt_sock_setsockopt);
> +
> +int bt_sock_getsockopt(struct socket *sock, int level, int optname,
> +                      char __user *optval, int __user *optlen)
> +{
> +       struct sock *sk =3D sock->sk;
> +       int err =3D 0;
> +       u32 opt;
> +
> +       if (level !=3D SOL_BLUETOOTH)
> +               return -ENOPROTOOPT;
> +
> +       lock_sock(sk);
> +
> +       switch (optname) {
> +       case BT_NO_ERRQUEUE_POLL:
> +               if (!bt_no_errqueue_poll_enabled()) {
> +                       err =3D -ENOPROTOOPT;
> +                       break;
> +               }
> +
> +               opt =3D test_bit(BT_SK_NO_ERRQUEUE_POLL, &bt_sk(sk)->flag=
s);
> +               if (put_user(opt, (u32 __user *)optval))
> +                       err =3D -EFAULT;
> +               break;
> +
> +       default:
> +               err =3D -ENOPROTOOPT;
> +               break;
> +       }
> +
> +       release_sock(sk);
> +       return err;
> +}
> +EXPORT_SYMBOL(bt_sock_getsockopt);
> +
>  /* This function expects the sk lock to be held when called */
>  int bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo)
>  {
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 42b4495e019e..3c5cf7789d38 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -1602,8 +1602,8 @@ static int iso_sock_setsockopt(struct socket *sock,=
 int level, int optname,
>                 break;
>
>         default:
> -               err =3D -ENOPROTOOPT;
> -               break;
> +               release_sock(sk);
> +               return bt_sock_setsockopt(sock, level, optname, optval, o=
ptlen);
>         }
>
>         release_sock(sk);
> @@ -1673,8 +1673,8 @@ static int iso_sock_getsockopt(struct socket *sock,=
 int level, int optname,
>                 break;
>
>         default:
> -               err =3D -ENOPROTOOPT;
> -               break;
> +               release_sock(sk);
> +               return bt_sock_getsockopt(sock, level, optname, optval, o=
ptlen);
>         }
>
>         release_sock(sk);
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 7846a068bf60..a0f7c1bcdec8 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -698,8 +698,8 @@ static int l2cap_sock_getsockopt(struct socket *sock,=
 int level, int optname,
>                 break;
>
>         default:
> -               err =3D -ENOPROTOOPT;
> -               break;
> +               release_sock(sk);
> +               return bt_sock_getsockopt(sock, level, optname, optval, o=
ptlen);
>         }
>
>         release_sock(sk);
> @@ -1103,8 +1103,8 @@ static int l2cap_sock_setsockopt(struct socket *soc=
k, int level, int optname,
>                 break;
>
>         default:
> -               err =3D -ENOPROTOOPT;
> -               break;
> +               release_sock(sk);
> +               return bt_sock_setsockopt(sock, level, optname, optval, o=
ptlen);
>         }
>
>         release_sock(sk);
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 32ed6e9245a3..8f62850023a0 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -4339,6 +4339,12 @@ static const u8 mgmt_mesh_uuid[16] =3D {
>         0x8d, 0x4d, 0x03, 0x7a, 0xd7, 0x63, 0xe4, 0x2c,
>  };
>
> +/* 69518c4c-b69f-4679-8bc1-c021b47b5733 */
> +static const u8 no_errqueue_poll_uuid[16] =3D {
> +       0x33, 0x57, 0x7b, 0xb4, 0x21, 0xc0, 0xc1, 0x8b,
> +       0x79, 0x46, 0x9f, 0xb6, 0x4c, 0x8c, 0x51, 0x69,
> +};
> +
>  static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
>                                   void *data, u16 data_len)
>  {
> @@ -4350,8 +4356,8 @@ static int read_exp_features_info(struct sock *sk, =
struct hci_dev *hdev,
>
>         bt_dev_dbg(hdev, "sock %p", sk);
>
> -       /* Enough space for 7 features */
> -       len =3D sizeof(*rp) + (sizeof(rp->features[0]) * 7);
> +       /* Enough space for 8 features */
> +       len =3D sizeof(*rp) + (sizeof(rp->features[0]) * 8);
>         rp =3D kzalloc(len, GFP_KERNEL);
>         if (!rp)
>                 return -ENOMEM;
> @@ -4429,6 +4435,11 @@ static int read_exp_features_info(struct sock *sk,=
 struct hci_dev *hdev,
>                 idx++;
>         }
>
> +       flags =3D bt_no_errqueue_poll_enabled() ? BIT(0) : 0;
> +       memcpy(rp->features[idx].uuid, no_errqueue_poll_uuid, 16);
> +       rp->features[idx].flags =3D cpu_to_le32(flags);
> +       idx++;
> +
>         rp->feature_count =3D cpu_to_le16(idx);
>
>         /* After reading the experimental features information, enable
> @@ -4926,6 +4937,53 @@ static int set_iso_socket_func(struct sock *sk, st=
ruct hci_dev *hdev,
>  }
>  #endif
>
> +static int set_no_errqueue_poll_func(struct sock *sk, struct hci_dev *hd=
ev,
> +                                    struct mgmt_cp_set_exp_feature *cp,
> +                                    u16 data_len)
> +{
> +       struct mgmt_rp_set_exp_feature rp;
> +       bool val, changed =3D false;
> +       int err;
> +
> +       /* Command requires to use the non-controller index */
> +       if (hdev)
> +               return mgmt_cmd_status(sk, hdev->id,
> +                                      MGMT_OP_SET_EXP_FEATURE,
> +                                      MGMT_STATUS_INVALID_INDEX);
> +
> +       /* Parameters are limited to a single octet */
> +       if (data_len !=3D MGMT_SET_EXP_FEATURE_SIZE + 1)
> +               return mgmt_cmd_status(sk, MGMT_INDEX_NONE,
> +                                      MGMT_OP_SET_EXP_FEATURE,
> +                                      MGMT_STATUS_INVALID_PARAMS);
> +
> +       /* Only boolean on/off is supported */
> +       if (cp->param[0] !=3D 0x00 && cp->param[0] !=3D 0x01)
> +               return mgmt_cmd_status(sk, MGMT_INDEX_NONE,
> +                                      MGMT_OP_SET_EXP_FEATURE,
> +                                      MGMT_STATUS_INVALID_PARAMS);
> +
> +       val =3D cp->param[0] ? true : false;
> +
> +       err =3D bt_no_errqueue_poll_set_enabled(val);
> +       if (!err)
> +               changed =3D true;
> +
> +       memcpy(rp.uuid, no_errqueue_poll_uuid, 16);
> +       rp.flags =3D cpu_to_le32(val ? BIT(0) : 0);
> +
> +       hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
> +
> +       err =3D mgmt_cmd_complete(sk, MGMT_INDEX_NONE,
> +                               MGMT_OP_SET_EXP_FEATURE, 0,
> +                               &rp, sizeof(rp));
> +
> +       if (changed)
> +               exp_feature_changed(hdev, no_errqueue_poll_uuid, val, sk)=
;
> +
> +       return err;
> +}
> +
>  static const struct mgmt_exp_feature {
>         const u8 *uuid;
>         int (*set_func)(struct sock *sk, struct hci_dev *hdev,
> @@ -4943,6 +5001,7 @@ static const struct mgmt_exp_feature {
>  #ifdef CONFIG_BT_LE
>         EXP_FEAT(iso_socket_uuid, set_iso_socket_func),
>  #endif
> +       EXP_FEAT(no_errqueue_poll_uuid, set_no_errqueue_poll_func),
>
>         /* end with a null feature */
>         EXP_FEAT(NULL, NULL)
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index 99c2b713d826..d4697f147b5a 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -968,8 +968,8 @@ static int sco_sock_setsockopt(struct socket *sock, i=
nt level, int optname,
>                 break;
>
>         default:
> -               err =3D -ENOPROTOOPT;
> -               break;
> +               release_sock(sk);
> +               return bt_sock_setsockopt(sock, level, optname, optval, o=
ptlen);
>         }
>
>         release_sock(sk);
> @@ -1212,8 +1212,8 @@ static int sco_sock_getsockopt(struct socket *sock,=
 int level, int optname,
>                 break;
>
>         default:
> -               err =3D -ENOPROTOOPT;
> -               break;
> +               release_sock(sk);
> +               return bt_sock_getsockopt(sock, level, optname, optval, o=
ptlen);
>         }
>
>         release_sock(sk);
> --
> 2.44.0
>
>


--=20
Luiz Augusto von Dentz
