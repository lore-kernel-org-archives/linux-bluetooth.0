Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E682FB674
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736522231; cv=none; b=M2JUUHokZarGWlTsUPDtefrzOceNlKwAy4I1xlK8UA17Rah3lBIr4DC/NSQURm/CYHQvWzYX5njfXZN85AO2I3Y5V1As3yzNcdiWeB97A9HlTUk8AMkZ7+lZ+90lU/NGnO7st+7/kFO9NleG7uCsQWPFh0UK61b7MhCjYNKfocg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736522231; c=relaxed/simple;
	bh=Xw+ftpp10Gipy6OOwWFkS7XcyG0qhwmuqxZWP8NnkN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/s5Faoz2RZ4AOeai8GrmXJ0A7eijZtoKx2GVQdgq9ByCJzdriz9Z9HHV+/4b0zawp7V/Pii1dK0onPWwXHi9fNaU7npQIO8vTg/jn62OoxsOuxjYBleLaRshfp69wkr4wUsOH9rBRMq1rCYKRH2x/mqnMjTipRYtseMZqC5HaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQ34QVEs; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQ34QVEs"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-300479ca5c6so18315001fa.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 07:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736522228; x=1737127028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSqbmfGJe16qiE9G6ENw9OMPCVehUYPujBdQ+/Kx5fI=;
        b=hQ34QVEsOqCB+OjA7dAuW/xdNnUau4A9KY+HzkRZgbQ1YYBLlaldupghIb4kYqNgXR
         KMkmfdJkA+5NQv+bl2jvnAvbIwv8QXPoebEByHk+PoIqsrkjcR4NyK2DlPOKxis73PZH
         GYeNBpmlQ3kqpzS26FTx4HmBG8pVmhwPCTzgPs8bosF2WTG3YucoXAUhUaYRU7mPfELW
         QjgW/B67atrfLLNbbqV5WdON5J2F/QEUSYpwZV3VoyHPM+PNo3SbwZzgtoUMMrXeekty
         EgvXykbPFrwZj9WNsloPAUCUfC24GGtagSIVNq7mD/7ziS1eKyTMy6os7Vr+umht/gly
         ZOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736522228; x=1737127028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BSqbmfGJe16qiE9G6ENw9OMPCVehUYPujBdQ+/Kx5fI=;
        b=R17Vq9Mhtc3sUjjHB1PCKjNHvYe3sh2KEzIWWC7AmjVKlqRAAEYZkzaioexpss9squ
         qqyhGrNbLM41BrtQYo4bVNVZX6QP4xXIfhExRT6Br672yUTF1urPh7+5cFf3KSkySOpz
         uITalL9V6SZ/ZqbG6gl/uLfJBndAzWCc8OwdE0okVyELHty5yIm/ZodMV5CEquwZZWlC
         PVGyjGa1Kpt2SHzEGQ1FySz6zhi+qNE90mTm/0cgjqmrbQXRxJnxFNWKHFFmoOtUHP3V
         +dyYL7FIbYPd6jg/0lvPFLhL7Co/buDsT61QW5EURFF6CJ051UaH4Z0t+dgzUbqnkoa5
         Di7w==
X-Gm-Message-State: AOJu0YwL27FxRjrAHKdLr9DjZcGKpYA/dJhBVb++cuuDz/H3EqD5HPdS
	ZoHq8vG1WZ3fGB54k37gNUIkCx87OfQdthRYGL7P7MmmO0Oqc4duF9AG8MOVptblz5IdBfnUTMP
	Fk8E03JLYtNourVH+knpqtxgxCOdxUHEI
X-Gm-Gg: ASbGncvN+k7rJ/ExcDzoCjXTLRS6zA+ah6hB+zzxtLtmY64TngGu67s8hVxDK3O080G
	DMfNu6Hqw7EKZaum17fHZ1HqMzZrwXi6ehJydmd8=
X-Google-Smtp-Source: AGHT+IE0mPpuPy4nwBro5P3rJmWIipgAkvYWxCUlrBCZqvR7MupU6x4blRRTTdW8AEOzegnf0iFJAYWQiP3fd4kFS7c=
X-Received: by 2002:a05:651c:50a:b0:302:1fce:392e with SMTP id
 38308e7fff4ca-305f45e7f69mr41982061fa.25.1736522227488; Fri, 10 Jan 2025
 07:17:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110145019.2380299-1-michal.dzik@streamunlimited.com> <20250110145019.2380299-3-michal.dzik@streamunlimited.com>
In-Reply-To: <20250110145019.2380299-3-michal.dzik@streamunlimited.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 10 Jan 2025 10:16:54 -0500
X-Gm-Features: AbW1kvbIZSvRLRyPrxOyVcEKXUFd5LOLbLgRbawJ_EeCTwv_RqV4Tb9dzUOZWVA
Message-ID: <CABBYNZ+3kSLwwXrDJ8mNTw43bVHdedrAmse2TwycQvvRoFr01w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/3] vcp: fix memory & connection management
To: Michal Dzik <michal.dzik@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michal,

On Fri, Jan 10, 2025 at 9:54=E2=80=AFAM Michal Dzik
<michal.dzik@streamunlimited.com> wrote:
>
> Those changes are mandatory to be able to connect to the same VCP
> renderer more than once without need to restart bluez.
> - use vcp_disconnect() to close client connection and reset vcs members
> - call bt_vcp_detach() the same way as bt_vcp_attach - from btd_profile
>   callback
> - vcs members are cleared during disconnect, because they are expected
>   to be null when connecting
> ---
>  profiles/audio/vcp.c |  9 +++++++++
>  src/shared/vcp.c     | 23 +++++++++++++++++++----
>  2 files changed, 28 insertions(+), 4 deletions(-)
>
> diff --git a/profiles/audio/vcp.c b/profiles/audio/vcp.c
> index 83e568f22..0203673bf 100644
> --- a/profiles/audio/vcp.c
> +++ b/profiles/audio/vcp.c
> @@ -72,7 +72,16 @@ static void vcp_debug(const char *str, void *user_data=
)
>
>  static int vcp_disconnect(struct btd_service *service)
>  {
> +       struct vcp_data *data =3D btd_service_get_user_data(service);
>         DBG("");
> +
> +       if (!data) {
> +               error("VCP service not handled by profile");
> +               return -EINVAL;
> +       }
> +       bt_vcp_detach(data->vcp);
> +
> +       btd_service_disconnecting_complete(service, 0);
>         return 0;
>  }
>
> diff --git a/src/shared/vcp.c b/src/shared/vcp.c
> index 489cd2b97..c92eb00d4 100644
> --- a/src/shared/vcp.c
> +++ b/src/shared/vcp.c
> @@ -389,13 +389,24 @@ static void vcp_detached(void *data, void *user_dat=
a)
>
>  void bt_vcp_detach(struct bt_vcp *vcp)
>  {
> +       struct bt_vcs *vcs;
>         if (!queue_remove(sessions, vcp))
>                 return;
>
> -       bt_gatt_client_unref(vcp->client);
> -       vcp->client =3D NULL;
> +       if (vcp->client) {
> +               bt_gatt_client_unref(vcp->client);
> +               vcp->client =3D NULL;
> +       }
>
> -       queue_foreach(vcp_cbs, vcp_detached, vcp);
> +       if (vcp->rdb) {
> +               vcs =3D vcp_get_vcs(vcp);
> +               vcs->service =3D NULL;
> +               vcs->vs =3D NULL;
> +               vcs->vs_ccc =3D NULL;
> +               vcs->vol_cp =3D NULL;
> +               vcs->vf =3D NULL;
> +               vcs->vf_ccc =3D NULL;

You shouldn't need to clean up the found attributes, these are stored
in the gatt_db and are persisted on reconnection.

> +       }
>  }
>
>  static void vcp_db_free(void *data)
> @@ -489,6 +500,7 @@ static void vcp_debug(struct bt_vcp *vcp, const char =
*format, ...)
>
>  static void vcp_disconnected(int err, void *user_data)
>  {
> +       // called only when this device is acting a a server

Use C style comments (/*) rather than C++.

>         struct bt_vcp *vcp =3D user_data;
>
>         DBG(vcp, "vcp %p disconnected err %d", vcp, err);
> @@ -508,12 +520,15 @@ static struct bt_vcp *vcp_get_session(struct bt_att=
 *att, struct gatt_db *db)
>                         return vcp;
>         }
>
> +       // called only when this device is acting a a server
>         vcp =3D bt_vcp_new(db, NULL);
>         vcp->att =3D att;
>
>         bt_att_register_disconnect(att, vcp_disconnected, vcp, NULL);
>
> -       bt_vcp_attach(vcp, NULL);
> +       if (!sessions)
> +               sessions =3D queue_new();
> +       queue_push_tail(sessions, vcp);
>
>         return vcp;
>
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
