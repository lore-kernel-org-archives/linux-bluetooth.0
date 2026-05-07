Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694E33F7A93
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 13:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778162319; cv=pass; b=legGOqrrp1EjSF6HHMettHm4ap8YdpJqD6U1lyOtQltniqGYmyUggJ4F+VTKJANLsK3wm0ym8f7FiONJIL1EPomoF2XFPeMWgOS9J51vfRoMcFLzfxFxfs694gxmjq/67poiklvRuA+eEE1kd5ky2kBzhHhad1AUBQnRHeKmXEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778162319; c=relaxed/simple;
	bh=AoCAbr5U9xCEYhyCDCKAnWL0f/AIZxSrA0RSWtk7W20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z7bIUlam1nKzgJ7mcCVZkzNRyr21zUw0lYmTCyzKcqAECKRNmvNZ66nrQ2vmvWl7C1A853fNkqWZX0bkYtml28k8WmKirH0yw8LITvrijWouk9HWk7R7SMvacAmTKVqebGiZ1jdpsk6lQqAIlP/eQFgYpRIXrl5C/yngqXVoTcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fveIG/du; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fveIG/du"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64eb84d1e37so695886d50.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 May 2026 06:58:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778162317; cv=none;
        d=google.com; s=arc-20240605;
        b=b1ZqmSeRw3t9CmfJTteqk3sp9SsM2yfFdGxEw5p1SI6sAvA+3Befr5yYqRNHBWVwPp
         RATeU1qc/o1OrV9WDyOMY7ObWmFcvXqgcZl26vusP3qJzvDvOZIPoNRHbJsw3OP1d8eJ
         mWALn+6alj/HruFv36kQqarveLwzwtugdxgRU5FLgUW+/0v/lqUAgvtLh5ahrmPGByR5
         Imx7ljegNnllaEwESl7ZKfmv536W+eSrWkUW5t8cuf+pzC9jS+/gUEc/kVTA7Mt1Ds/7
         9novqJplEtYlXaeXeiyXenZHf0Gf3waNjKN9DBDWHIQT1RY/z7HzNso+vfkCQ6LTrChA
         j9jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iZuTk5/6Ehu+/CuyA+GHwx3mocyxpLdsYkLa8yOQHPk=;
        fh=Wg9BdZsLXC6CXksDS90lacyYtcBiHlCc94AutkmIVY8=;
        b=av1re8AsLCgi0NpsO3W8QSN9Jku8HYscdiDZU9fi70uU0cbu2TyIFFRaJ8nX7wLG+I
         +Ro8TSI/1lZ/Qh1bNWN3O5sRv7eamTWy55cxKIqn788rDDR8hRiHl7Yi1merberj6ZJB
         YRCRgnIe12DFLiWYLft3U/prKD8W5HyZvdo2P3fD2ZZ5IIlxlacNLr7lq324xc32ttkH
         p5ViItI28tnWhsH7xGRyS6yPG7vnsFqq4wouC0X5s3LQjFx7EGi0d/fTcr7M4Q4SN84i
         sOqror6e8+Xxn6eoW5FpGl1e02irJNKeP42JLFyqO9lE2AlFwPrneLO0wqh5EjFVj7rP
         cTzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778162317; x=1778767117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZuTk5/6Ehu+/CuyA+GHwx3mocyxpLdsYkLa8yOQHPk=;
        b=fveIG/duhw9BV94X57ltMZKKZhDPGPcf7ciQttitIvw/nVH/dnD8lKKQ0/0kKY3p++
         nKy7uRsJHyCB7mfhu3vlVC8y+LyE/Zo9W6og0aBtJ1XFUAsmwj+mAzUhWsO3vINmAegR
         AIsWmtSInBBKg26/EEQuk9vwo8RE1K9MID8CWy1JKF63+t9c1WjYTCq7h1z+URRqEExQ
         TwnuX5d/5KfdOxCxjAGJGzySYShpW3hOfoeIbM0cZfUGE6U1a0LgeXbqPKWy+0c1ufFN
         KOzoZX+LOo7xzJ5YVYhD7ADgGwq1hHpx6UVP40xJgBoLbHPBcj5MZe9NKeFxKUzsz8SU
         HAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778162317; x=1778767117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iZuTk5/6Ehu+/CuyA+GHwx3mocyxpLdsYkLa8yOQHPk=;
        b=odAxjLnO6+zANmVGNKphQxCrnnD0eBm6QYtOGNA136fQOwlHUx5wxtP8ivf9rI5uMy
         Nd1RCP+jrSQlcBGJ+9BTeH0+bG2E5b/ICrcJwZ8/muCTsE5rRJNFZee18WAz8qG+/9ha
         ZF9NUJKOQjy+ISfSImJNlm05ydYe/Fq6qVchB6fGxiv2WLR7H28OJZADzHoIUAfoYESW
         iY1feG3YrdEZbwbbMkoLJX4lmFpGr+wFYO1qV+xSsqqdbvCvRcvbjBmw9dC8HqI0uJ2v
         38shu5Ub8j+SFCbPLJ1LMDhw+Pa1YJgeSjLAc1QrD0iLMwh8/zSMVv4JJr00JDtJJrIh
         /0tg==
X-Forwarded-Encrypted: i=1; AFNElJ+atpTSL5BaXC5hFtUe553CHUqP2hgaXWJPafas2OGvrrtaOD3QKdwivBVKm/Oi86Fcc4qch03D3MCd1BJqbnI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0VWPLH86Sh35DN2ZznG56meQQN0IRY4W3/lDp9/hp3IKlB/XT
	du6dJQqslTPZnHzEisyC2+RSSSUe/ZhVzxT5hb4+GhO81l0XvjpopPJiDxJmTA/RJlNlwLpWyX5
	NJAyjX2anAnQcOMCd2DhtgWsCWA0cPmU=
X-Gm-Gg: Acq92OHnQ2icEQ29J5ZgeigXqi6/3JrQGwqScqmEbwLD15hPCQyU9BNjR302xvFNvC8
	ZqEaY966uyx0sLzF20qzBV/OXSUOIQgmUKS/phUbYFUkp/8zKL/69i9ByQ6n4Do7nZPYLLPmbCI
	K4B4WWqjs2D5CJvgiJid18wgnlZLObNF3j3XfZdy+4kjh26xn2YwHIA1xLYupUEBV1U4K6gDeCn
	L3uUritIK9Z2MT4IJTX6gy++jhNPZLo5o7pbWe4YUK6Osved4l+XSNKebPibUd6X67VIGLEUH7d
	hskPlnAXP7+oCAA4vkcbkWQRvSrv13kC5n7r6uExrxKJHR8tPeaExMziiKT0tNjvfaQwxPpgxTt
	+wiFC
X-Received: by 2002:a05:690e:291:b0:651:bf56:ef13 with SMTP id
 956f58d0204a3-65c799ef581mr6344090d50.58.1778162317155; Thu, 07 May 2026
 06:58:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506155313.1412894-1-zzzccc427@gmail.com>
In-Reply-To: <20260506155313.1412894-1-zzzccc427@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 7 May 2026 09:58:25 -0400
X-Gm-Features: AVHnY4I9rq6dGnIAD4k0pRoPDlYEotxWe7REefoLd6hIS1UUWmjrRskJwuCNBIc
Message-ID: <CABBYNZKByr28j0P6FfOYqyZJs2D9rq34HJa+kgLS3wJWopBuEg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: avoid using hci_conn after dropping hold
To: Cen Zhang <zzzccc427@gmail.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cen,

On Wed, May 6, 2026 at 11:53=E2=80=AFAM Cen Zhang <zzzccc427@gmail.com> wro=
te:
>
> l2cap_chan_connect() drops the temporary HCI connection hold after
> __l2cap_chan_add() attaches the L2CAP channel and takes its own hold.
> The function then checks hcon->state to see whether the channel can be
> started immediately because the underlying HCI link is already connected.
>
> Keep that state sample before hci_conn_drop(hcon), and only use the
> cached result afterwards.  This avoids dereferencing hcon after the
> temporary hold has been released.  Use READ_ONCE() for the sample because
> HCI connection state can be advanced concurrently by the command-sync
> worker while L2CAP is setting up the channel.
>
> The sampled state is only an optimization for the already-connected case:
> a stale non-connected value leaves the L2CAP channel pending for the
> normal HCI connect confirmation path.
>
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> ---
>  net/bluetooth/l2cap_core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 95c65fece39bd..40e84c1623a9c 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -7078,6 +7078,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __l=
e16 psm, u16 cid,
>         struct l2cap_conn *conn;
>         struct hci_conn *hcon;
>         struct hci_dev *hdev;
> +       bool link_connected;
>         int err;
>
>         BT_DBG("%pMR -> %pMR (type %u) psm 0x%4.4x mode 0x%2.2x", &chan->=
src,
> @@ -7222,6 +7223,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __l=
e16 psm, u16 cid,
>         chan->src_type =3D bdaddr_src_type(hcon);
>
>         __l2cap_chan_add(conn, chan);
> +       link_connected =3D READ_ONCE(hcon->state) =3D=3D BT_CONNECTED;
>
>         /* l2cap_chan_add takes its own ref so we can drop this one */
>         hci_conn_drop(hcon);
> @@ -7236,7 +7238,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __l=
e16 psm, u16 cid,
>         chan->sport =3D 0;
>         write_unlock(&chan_list_lock);
>
> -       if (hcon->state =3D=3D BT_CONNECTED) {
> +       if (link_connected) {
>                 if (chan->chan_type !=3D L2CAP_CHAN_CONN_ORIENTED) {
>                         __clear_chan_timer(chan);
>                         if (l2cap_chan_check_security(chan, true))

It doesn't seem to be very useful to read the hcon->state and cache it
while other function still going to access it, anyway we refcount the
hcon and hci_dev_lock is being held accourding to sashiko:

https://sashiko.dev/#/patchset/20260506155313.1412894-1-zzzccc427%40gmail.c=
om

--=20
Luiz Augusto von Dentz
