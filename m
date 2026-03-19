Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BE83ED104
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935765; cv=pass; b=WOzkP3NC7GZ3cxS9Dv9xicooTWqnzIoSb2H+9HfGhv50y7GvILTmMqIf6d/1lxMusPHa0cTl7yNLrZLP9GbxZPlSrPS1OA+elQDwNuVim5wHL9PJOFcOd9hiixGpPlti6WERTWbxsNfUtpertbGelp5UAX7f/rQK7EE7bIijFu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935765; c=relaxed/simple;
	bh=yRuGv36QC0uvfvBh5pXQtwLVnZu9xQZuqquYgaedHos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VjMW4APcL/MWcOKTDvR/vJxQohqKqFvtTfz4myJlvg7EN8zA+c538clEl7JcZUkcd0bk/QDc366r4xvIvJOLTf7WmSkQypDeHxhX09MaSmmQG3+k7fXVXeNpUXJAkbBPnYNT9f38ppijOJT/UxiF3JB3LxNkhFeQoPGSCjcGW4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dm0FaHyX; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dm0FaHyX"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64c31ca77b4so1490274d50.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 08:56:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773935763; cv=none;
        d=google.com; s=arc-20240605;
        b=UUQaH2AAZN+To4TiJ8ooW+SPQCffSZNbuPHdI0ORfOqjGF0xkpFBwSYvIlHiWeBdiU
         k8McTmJCufqZYfj+6GR4xvoCwZtqYSOwZ0sZ+c2i/nhGU8HfMmONmw6BIE5Tm9Yml7/o
         JYKqM0thDkByykTHqN6m0dDJXxrZgjtiWl1j+fXIYNZfPEFYSr+xw0DswU7xxO8lz/fR
         A9V0GZY8Na/KcJS/a4N5U4cBhyHMiAbm5PM/lUzffb8IvttuwqYVyg26jWkIAEnknAQp
         oqDNGqlR/K33wM8xWc/pbKyOn/9ad8ZN2oNb4IR0OsgZDxZq9ggrAMWlFPpzfYoL59u7
         RNww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l3mta9WvtZh0NcaxhV5KrdKdscVi2MpE6o/2dFJSQtI=;
        fh=+0GZWw+CEQelTjYp2GyyQMozbdYpw1smwU7o9Agw4XY=;
        b=RjsojHSARJNlHiOMhIxrDX4ngeqD/RgfpFwHX6reYc9CoPyudR9eS+F/Y3XDq5UfSZ
         JaecDj/WYojFY1Yv3AvLKZvWXeJbfjDPc+vEgJqvTSqTcxr8LA7NT1rOjsc+yBkEdKtu
         MS+8nmBDlxxuLQBOIQB0f6bRfB+GCXTz0eMmRqDjcc8+Gqr4dcRmyAlfOiptU1v67TO1
         w+8cM4Q3qubwqUyp+IpaasWb/jt1b6T3+iz2x643dJiLr1jUjT5HcFM9/GgzdsvaN85N
         IR3ZpPUutEgZRrAfrmGJaiw6/FHMOx4FWMVyupZfl0p8QWg7DqPdzwWDxcHD/c0mKMtN
         ZOFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773935763; x=1774540563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3mta9WvtZh0NcaxhV5KrdKdscVi2MpE6o/2dFJSQtI=;
        b=dm0FaHyXCTKOliKw/Bc3J1unTyNgKqQb+Dl9RZABbnk3Vrnzk1JaZ5iXkqUthBfCwA
         0dYsSDPROkNXMXiTuP+8pRvpKcKQQra5ksPJnWb/UxyrYJ56pizvZc1GBHV3r/Cx0O12
         sgLjxWNoyrxhKdeeAZAMJ4POj/sVTv1Xk98Bz9qlF9ED+hICXGaOJBse2vgNOB4MQ31q
         fZuGX41l9hl4SjQYgmQ6O8kYmS2/9E7mxwa1kPe+V0woIDAobOZnMe1fhnkAd5JgATJG
         CseqBO8JTEWPvWxDUWGvwDEJeFS29JVxNqYGhEzvmOcZkXj5wbPn8PRoJKZkTYMCtAXW
         90Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773935763; x=1774540563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l3mta9WvtZh0NcaxhV5KrdKdscVi2MpE6o/2dFJSQtI=;
        b=rgqdvPGkdMAIdQb1tsli+FaxNgXzQRHe7uVPu3+knpYSCAptT5O1ap7R+lqmTJOO0T
         Kc+b1VTLofmxPL4WKPsDz/pMMZ4thKAxXhwMC77MEihY7lZX83JVYiRnoewVmkKyZTqd
         CswLpE5SeGjYdzaQuITahQxQt0vhqWC8/s5zRlvVNzbC3Cvs5S5xyctq7hr0DOXMFON3
         Y0B1cA9wSV9Hk1jVM9vcXmFq0LWkNU/lYutm9w8lkOtuIpu+eRHTkWtHbliCgEoXRQ5q
         la37GIbWj6zc4IUqtjRmBcyO4AX0sKosUS7aem4DHlPU6mE+IzGkBSnTyNBaIWToNueP
         b7VQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu2g1cEKf0++2543Mj9y3DhDA1J+C4DFf6nd5y/hs1N9/iZrIdYhFHnz6j5eqa51LB7pC3ovq94pCFfG+vPrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YypibyUF8mYqCc6wFwAB99aRaQJDy8udYzXdLM5oHgs1rNlDxXM
	ZCidlgXruu06BhpQfW5qB5nr6O069+IAnE1wJWQ/I2bzRYDE5qBBDc6ptF4SDsmQ9ft4avKKrHW
	ABsS7rSwnZdKe8KEEyO9a5u9efYCzhfE=
X-Gm-Gg: ATEYQzzJOPQQd9DnJfuZK2YA5HBeyXpktSA2J8L4rSzdx0PLofmvDKG75Zx0hCE7vAU
	MQqDhBePKey2UItqDrkPm846Ttxdh8rhYxp3JJQLH0Vj7EimOqlPxN/+0wglmYTlf1ydTTTa3Y2
	9Jaa9lXzwb6Ypj4W/jr2L4DoG6PN0z8ln6y6IZO/wpfqsJnonm29tzfDnNCuWU5qZrsRNJSI29i
	2oCwZmptautK8AzIg+g/uoMf/xCqAnpNVWWFvKwwEgN9uM3AR8I4iVoK6MQHDUaazEg2fAo8exP
	bSVEY2yjP8HXIi/rgoAyeWCMnT1XBXbQV2oRaPsLrLCdFo2ANhgv5jiyCGVaY6popcNw3g==
X-Received: by 2002:a53:b80a:0:b0:64a:f3fa:af4a with SMTP id
 956f58d0204a3-64e912ef159mr5970340d50.5.1773935762834; Thu, 19 Mar 2026
 08:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <abwSxg_C6n8Avid3@v4bel>
In-Reply-To: <abwSxg_C6n8Avid3@v4bel>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 19 Mar 2026 11:55:51 -0400
X-Gm-Features: AaiRm50nxrYFFg4s8WdQMwdi7Lt9SZy1J6xSGEwqkgx56ZNcWalolWUvkGvg4_c
Message-ID: <CABBYNZKpf9GjYvk_dBebaQmiP6ngfW_m1qR-iz7f48eAj8aaDA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix use-after-free in l2cap_chan_timeout()
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hyunwoo,

On Thu, Mar 19, 2026 at 11:14=E2=80=AFAM Hyunwoo Kim <imv4bel@gmail.com> wr=
ote:
>
> l2cap_chan_timeout() reads chan->conn without holding any lock and
> without taking a reference on the connection. If l2cap_conn_del()
> frees the connection concurrently, mutex_lock(&conn->lock) operates
> on freed memory. The existing NULL check is insufficient as it cannot
> prevent the connection from being freed after the check passes, and
> the early return also leaks the channel reference held by the timer.
>
> Fix by reading chan->conn under l2cap_chan_lock() and holding the
> connection with l2cap_conn_get(). After acquiring locks in the correct
> order (conn->lock then chan->lock), re-verify chan->conn in case
> l2cap_conn_del() already cleaned up the channel.
>
> Fixes: 3df91ea20e74 ("Bluetooth: Revert to mutexes from RCU list")
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>  net/bluetooth/l2cap_core.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index abd091155d04..a432e94281dc 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -406,13 +406,20 @@ static void l2cap_chan_timeout(struct work_struct *=
work)
>  {
>         struct l2cap_chan *chan =3D container_of(work, struct l2cap_chan,
>                                                chan_timer.work);
> -       struct l2cap_conn *conn =3D chan->conn;
> +       struct l2cap_conn *conn;
>         int reason;
>
>         BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
>
> -       if (!conn)
> +       l2cap_chan_lock(chan);
> +       conn =3D chan->conn;
> +       if (!conn) {
> +               l2cap_chan_unlock(chan);
> +               l2cap_chan_put(chan);
>                 return;
> +       }
> +       l2cap_conn_get(conn);
> +       l2cap_chan_unlock(chan);
>
>         mutex_lock(&conn->lock);
>         /* __set_chan_timer() calls l2cap_chan_hold(chan) while schedulin=
g
> @@ -420,6 +427,17 @@ static void l2cap_chan_timeout(struct work_struct *w=
ork)
>          */
>         l2cap_chan_lock(chan);
>
> +       /* Recheck since l2cap_conn_del() may have cleaned up the channel
> +        * while we were waiting for conn->lock.
> +        */
> +       if (!chan->conn) {
> +               l2cap_chan_unlock(chan);
> +               l2cap_chan_put(chan);
> +               mutex_unlock(&conn->lock);
> +               l2cap_conn_put(conn);
> +               return;
> +       }
> +
>         if (chan->state =3D=3D BT_CONNECTED || chan->state =3D=3D BT_CONF=
IG)
>                 reason =3D ECONNREFUSED;
>         else if (chan->state =3D=3D BT_CONNECT &&
> @@ -436,6 +454,7 @@ static void l2cap_chan_timeout(struct work_struct *wo=
rk)
>         l2cap_chan_put(chan);
>
>         mutex_unlock(&conn->lock);
> +       l2cap_conn_put(conn);
>  }
>
>  struct l2cap_chan *l2cap_chan_create(void)
> --
> 2.43.0

Actually maybe this is because we don't use cancel_delayed_work_sync
to wait for the work to complete on l2cap_chan_del, actually that
should use disable_delayed_work_sync to prevent the timer from being
rearmed, and that should be done to all the timers since l2cap_chan is
about to be destroyed.

--=20
Luiz Augusto von Dentz
