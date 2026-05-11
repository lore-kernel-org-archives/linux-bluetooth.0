Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7944143D51E
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 19:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778527076; cv=pass; b=GHynK/HDFDyWJW2aFkWaljyHMpLodGth5P/hExil4/3RoS0n1P7Vs4RlYD3WOasBLuTFFUC0/5llibR1LPf8AHcWOrkOeQSP1N8DG5QIVg60amEU1OTp0PIhPEQ+IqpWZy7SAZX02LnWTz/BNs7FtzmdsggIF0/e3FlEO5uyrSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778527076; c=relaxed/simple;
	bh=hRnuTJ2MBpeAb0Ah103EPzIOHn/Yb3gy3bplKtYufjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bM6wKMjlFwf+yBt4GiG1d61zETuCq9MUVyagjCaGbIvR6aGNPr96vTg+TXSsP3+3q6C11H8l7KqWWWG4iBMdzWi5Vm0vKjb7+Lf4dTTHrvl/mHJzD7tP5ISgyQQqEExuENF6rjVBR8+hiF9OmDsdvY7WUtjNeV2Jp7Ff7rnPejI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfcWe2F8; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfcWe2F8"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-65c305f381eso5063695d50.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 12:17:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778527074; cv=none;
        d=google.com; s=arc-20240605;
        b=HOCfePRoG3TcfXjAEaW60upeZPTnC+9ax2Qbm6A+ZP77YcZeGSIpT0aHpThDlNuIIu
         OlImRRBdK9uWgNk7rtYa0Fca4vB50U9Yhz6ICcowi6bJEL1x1D4fzCc9tgU6GYrLA5JV
         4VEiGdXUvUm0Qm7gReDxijuKen3n5q3nHqFldJU98UhNHsyso46Kd9Vhis/lbswFv+oB
         sC9skQCvjcxS3wecSlgh1zWB5dE89z1q4QlTBtHj1XB/BStAlIicLGllh7ABjbqFK+PT
         NjDmVehYMOnsvf5TAadUvYq5VaWUhwQbxi5RW2PURBY2OX6U0FJwEOSEil528wVxmhQm
         uq7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=93hJQ24tDc6Hepc4QDpSwyTCjFEpDGBGZkcX/jqUMrI=;
        fh=GdowLm6Re+hnEDuGqC4HHvFWNMsg1lrusCjM2+TARtU=;
        b=D9GOpoth5LX0o49WLaNiGJ8M67CBIkcvzzHAOTT8Xud/pC5cQHPmp6tliKR1c/42Sf
         RO1VrQTBrfOlE7fVTlVF++QoLtHaQYe5Z3hieFaofhLb2fMVbmX9I4vsfN+bLkY1V0qR
         8DaCgHfYxk6UeWROmHerKpQRskTEV59WJ8KNFvZffw4kLZUekBVI/+l61x1LrLJRwJCB
         c/piTEoW8ahQ45OvsFg50vtjg3MdvPX8ktI4PFMDgr7ALkKnF/nCUVDL3K5LnGDvDmki
         SGp3ccb/F/ctzVZo19i71AmTdtKZCpNIBfsYpXk4P642Fy9m2c8v38ZfAZzVNf1LtEg0
         SzsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778527074; x=1779131874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93hJQ24tDc6Hepc4QDpSwyTCjFEpDGBGZkcX/jqUMrI=;
        b=cfcWe2F8f8CAJiqD9RuwU70uI7WsTIihWI47ULRvG826jNVk7bgStKTFmvo/zZi9ng
         2eikj5tVPshHx8TnJRI3wTJhGs15Fbi7Sdd24jxgK9eNZwfbdOJfsFpdo/kPubOUNRHM
         F5q2ke4tzNWVuJLCXyMALIzpSkneOL1y/loiVsSmIlO8EA5yl/EQISpSYq6WMMKJAUy4
         IZID4ezOE7dwb7szO7cXAwcIXQ/w3QDM3nWA+H8zNyAjO73cN3qv64MJw4FXd3cfbfch
         mm3NGTVVl3I1rRUsnJYlK/P4PdRhcbXyMUCD2gKknkaxYOGkaetSgKcSxG4qA1gdJUZn
         YCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778527074; x=1779131874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=93hJQ24tDc6Hepc4QDpSwyTCjFEpDGBGZkcX/jqUMrI=;
        b=m1o+6Ot9wHxiIPvFa2FCdth7XRO4DZX7yx2aSeCpAAeSD+I7g68d/+fgKvoJQjJVvy
         eKGA2REGc+rXwTNBXE9XtxZEjsyB3MrQBgiosYKdD1JR3KcHHzSFaIj+cFaGt3GQcjPO
         IW8bAAUoYIgWQg6N+GI7glN8X7q5Ld/Vex271cOm/wT1ksVJlAVYHDQSiTNg0kUsUGuw
         oPYxJ4xDJLTU3BSBmv5nrUndoaFyTIvZHi3zabBHRWFj9Nlh4GbGhBQU/nZPiTwzEuyN
         mB66ot0wI5MRIpwRyWGeyldRqFQtUFcUhGsuDRv8NM4FhXXgnODDytEkstLP0g21/Km/
         1msw==
X-Forwarded-Encrypted: i=1; AFNElJ9jlk2KCUFNGosn2bVj7f+fx0qhusXHzvmTnwwDZq9DLwu6xycldvAB9omig/2aJtmfKDrLz94637MjpEk/EHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRf/5UKT0Eyc7xIRGzEWQiCTt1lxusYy37Ku+dq1wJb9GSM/0u
	FuXfJ+VY5MEuKOwJflVcd2YokZTz0oD19jTP1fp0GJyJn1XAqxddBXU7L2wsv9oA0Gg3mlRErdA
	Ktcnmjs+b4D9shiiFXHKgBAx/5nY2PLg=
X-Gm-Gg: Acq92OF4TJMtx1W/FmGT4j+dTC8dJAaaEIr0uHVVewyRjmjcCANHyV+Mx883jeQLyvq
	RCks+Vd2DzQ9Ki9/ResxCNaCs8Jm7EmiBz7+JbuIF3usBqeQw3iOFgCKG3GkGeDX9untLo+QXit
	jxZSvwciHtSKCj+X5eBj38zlKMSKqS0cybHIC9/lpPdNaCLIbinJv9/28TVUSzYrFayYBlVbx7u
	gW/rRKDN9QPHdN3OrL20z9KxZl8qFYOcZtgBMquuDGaw19kpCagmFBEGkUiehlbg9k2BfA5ANKM
	EYROppGnUMauJkti766s6E/igobc64UtEEzM8EglO1df1PWtlI0K99oDAARJm50IwNSbJw==
X-Received: by 2002:a53:c05c:0:10b0:650:3064:4cf4 with SMTP id
 956f58d0204a3-65c7988dac3mr20832522d50.13.1778527074204; Mon, 11 May 2026
 12:17:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511170929.709823-1-oss@fourdim.xyz> <20260511170929.709823-2-oss@fourdim.xyz>
In-Reply-To: <20260511170929.709823-2-oss@fourdim.xyz>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 11 May 2026 15:17:43 -0400
X-Gm-Features: AVHnY4KV89zIOPf7LWDF8P4z69HaL-X1kqV5W781YH1Uxo1U2l0z795R9MQ6XAw
Message-ID: <CABBYNZL3UVcogeJGiOzEcyGi3TCGf_pCCz+Vd32K3Li0GmPVwQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v4 1/1] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
To: Siwei Zhang <oss@fourdim.xyz>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 11, 2026 at 1:09=E2=80=AFPM Siwei Zhang <oss@fourdim.xyz> wrote=
:
>
> l2cap_sock_new_connection_cb() accesses l2cap_pi(sk)->chan after
> release_sock(parent). Once the parent lock is released, the child
> socket sk can be freed by another task.
>
> Save the channel pointer into a local variable while the parent lock
> is still held to prevent this.
>
> Fixes: 8ffb929098a5 ("Bluetooth: Remove parent socket usage from l2cap_co=
re.c")
> Cc: stable@kernel.org
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
> ---
>  net/bluetooth/6lowpan.c    |  5 +++++
>  net/bluetooth/l2cap_core.c | 12 ++++++++++++
>  net/bluetooth/l2cap_sock.c | 13 ++++++++++++-
>  net/bluetooth/smp.c        |  5 +++++
>  4 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index 23a229ab6a33..71c1c04b61e5 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -755,6 +755,11 @@ static inline struct l2cap_chan *chan_new_conn_cb(st=
ruct l2cap_chan *pchan)
>
>         BT_DBG("chan %p pchan %p", chan, pchan);
>
> +       /* Match the put that the caller of ops->new_connection() perform=
s
> +        * once it is done with the returned channel pointer.
> +        */
> +       l2cap_chan_hold(chan);
> +
>         return chan;
>  }
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 7701528f1167..0f6c3c651207 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4071,6 +4071,9 @@ static void l2cap_connect(struct l2cap_conn *conn, =
struct l2cap_cmd_hdr *cmd,
>
>         __l2cap_chan_add(conn, chan);
>
> +       /* Drop the ops->new_connection() ref; conn list now pins chan. *=
/
> +       l2cap_chan_put(chan);
> +
>         dcid =3D chan->scid;
>
>         __set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
> @@ -4970,6 +4973,9 @@ static int l2cap_le_connect_req(struct l2cap_conn *=
conn,
>
>         __l2cap_chan_add(conn, chan);
>
> +       /* Drop the ops->new_connection() ref; conn list now pins chan. *=
/
> +       l2cap_chan_put(chan);
> +
>         l2cap_le_flowctl_init(chan, __le16_to_cpu(req->credits));
>
>         dcid =3D chan->scid;
> @@ -5194,6 +5200,9 @@ static inline int l2cap_ecred_conn_req(struct l2cap=
_conn *conn,
>
>                 __l2cap_chan_add(conn, chan);
>
> +               /* Drop the ops->new_connection() ref; conn list now pins=
 chan. */
> +               l2cap_chan_put(chan);
> +
>                 l2cap_ecred_init(chan, __le16_to_cpu(req->credits));
>
>                 /* Init response */
> @@ -7407,6 +7416,9 @@ static void l2cap_connect_cfm(struct hci_conn *hcon=
, u8 status)
>                         chan->dst_type =3D dst_type;
>
>                         __l2cap_chan_add(conn, chan);
> +
> +                       /* Drop the ops->new_connection() ref; conn list =
now pins chan. */
> +                       l2cap_chan_put(chan);
>                 }
>
>                 l2cap_chan_unlock(pchan);
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index cf590a67d364..295c79cf5cf3 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -1497,6 +1497,7 @@ static void l2cap_sock_cleanup_listen(struct sock *=
parent)
>  static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan=
 *chan)
>  {
>         struct sock *sk, *parent =3D chan->data;
> +       struct l2cap_chan *child_chan;
>
>         if (!parent)
>                 return NULL;
> @@ -1523,9 +1524,19 @@ static struct l2cap_chan *l2cap_sock_new_connectio=
n_cb(struct l2cap_chan *chan)
>
>         bt_accept_enqueue(parent, sk, false);
>
> +       child_chan =3D l2cap_pi(sk)->chan;
> +
> +       /* Pin the channel for the caller. Once release_sock(parent) retu=
rns,
> +        * userspace can accept(2) and immediately close(2) the child soc=
ket,
> +        * which would drop the socket's references on the channel and fr=
ee
> +        * it before the caller (e.g. l2cap_connect_req()) is done using =
the
> +        * returned pointer. The matching put is the caller's responsibil=
ity.
> +        */
> +       l2cap_chan_hold(child_chan);

The entire problem might be solvable by not removing `list_add` from
`l2cap_create_chan`. This way, it only allocates but does not attach
to global_l until __l2cap_chan_add is called which then handles the
addition. Alternatively, we could allocate it first, given the
circular dependency involving `l2cap_core`.c->l2cap_sock.c)
new_connection -> l2cap_chan_create(l2cap_sock.c->l2cap_core.c) which
makes the code rather hard to follow.

>         release_sock(parent);
>
> -       return l2cap_pi(sk)->chan;
> +       return child_chan;
>  }
>
>  static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *s=
kb)
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index 1739c1989dbd..9796c3030434 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -3231,6 +3231,11 @@ static inline struct l2cap_chan *smp_new_conn_cb(s=
truct l2cap_chan *pchan)
>
>         BT_DBG("created chan %p", chan);
>
> +       /* Match the put that the caller of ops->new_connection() perform=
s
> +        * once it is done with the returned channel pointer.
> +        */
> +       l2cap_chan_hold(chan);
> +
>         return chan;
>  }
>
> --
> 2.54.0
>


--=20
Luiz Augusto von Dentz
