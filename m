Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430211EA7C
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 Mar 2024 19:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710702006; cv=none; b=c+C8ZJBfzPw/0C8xdEbSQiA8StFaKLs8P0X49FwD2i7+ZycrjXjGwl+5+H39YJh4FIQzGwCZmDxiZ+uw4yGMA1f94OPidI8qBueBPFha9pYuJGq5A7QXFin14VwGAL2DBpl/22zHji+HEkGJAX9642rPKqNQ3D82W3XIry6nuzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710702006; c=relaxed/simple;
	bh=hon4Tht4Torv2xKY8XXgnJoVh1DxGFNhBs7H3C5Ey5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fk84Vs1gTYelpTyJgKLtgH09jdI2dNbjRilB9UXryl9ssDpCQP9P5lBWz3GlrTow7cJEaMTW3kTFLmmwEb3o6uYMV2Ym7NUeuYIqFj8PANFSun51wbUPP9Xwk+SfJUCy82stVMsNQ0+kwYEWw7tEx52hmzLq8i/luDolbjVU+CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbQyYQAB; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbQyYQAB"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d4886a1cb4so36623931fa.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Mar 2024 12:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710702002; x=1711306802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HoPGz1Sw0NagTksM8ctJZIhX1aGaVN/9+lc4IXNaqI=;
        b=IbQyYQAB6mBvFNBQeHowwFQEtZg6NTWj9FKSDMacg8SLuLiO4Df2WX7K9ng6DUCZ07
         7Xp+O6JDfG0ERv0glSI1raW+blIZK5CIow7JJlOX6GUwTCTgfXqITCUo5yOMooxJd9ri
         ygLx90f13iisy08WQ0HiNW/RhZ8IC8+3jhkoPnkoGFnqY9fTtRUiqrTCyjgrNn5FR8z3
         Z9qZgbe2yXFzBKAgNkJrpLr8gnXspB6IZSeUYChCKkm439aPlzFPmcZs7IdXWWerlQzu
         LPCGx6u3IZsLDgSUS3QOCp0Dd5VwXzfIFYC2ZZSLRw7vu7BwS4e6BqbYxR9gEnHhsBgm
         O0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710702002; x=1711306802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6HoPGz1Sw0NagTksM8ctJZIhX1aGaVN/9+lc4IXNaqI=;
        b=GlBIFMBoWNQp+CBFzLnY4Z4NML17CWetyKtLbBVSJd5NDVrkVjBkKIdNOQJAOR3S4l
         M9VgK4xa/CJN+lzFifVhc+e2IUb+Urq+hXaaBuD8iqWEzsSt/Qg4DgprsbFXqyljh02P
         5eoTU6VQiH46P+/JzNrsIsEqD15xZpcSHeIvObooUNc7G1/6xWI3jv3hZRu1qIo7isYS
         OKm+tRZPXHo6rKWIecTehEqYmc9omWdSQI0t/Kq4MoVRngNI2fLpg7dAF1KUd3/n5Lij
         +g5yk0angzuOXUopDfGoikO17jZ8gvCK6FuYKUFPwlJ+VRoXTYriEqGgIRgZWRo0RI+Z
         aK9Q==
X-Gm-Message-State: AOJu0YyDthUJGxBRS4gMb1C0Dk5W80AZ+dCiWssPtS2Wmwqil8qkfzjG
	XZ7sxJUzWxX4p3/aY8sl7KhELxcJ1UC8mo2RcH0DDHGO/Ohc6jXn2E545Q7P+U1bzUUZQuormfP
	MieUd+rSqP8GNjUSzCE/NLrniYIfqlBQql5nvjA==
X-Google-Smtp-Source: AGHT+IGbWwrG1iP+UjU1cIuVXM+Lo/xf89gF0D4BITge+VQLovcxlspELZA6DzwxADyEydBO+RtxiDmUXGjWZOaMmFs=
X-Received: by 2002:a2e:9396:0:b0:2d2:e784:abc2 with SMTP id
 g22-20020a2e9396000000b002d2e784abc2mr8041877ljh.33.1710702001770; Sun, 17
 Mar 2024 12:00:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <90670acf017c4fb5a4ef4dba4b666c1307e9de5c.1710602216.git.pav@iki.fi>
In-Reply-To: <90670acf017c4fb5a4ef4dba4b666c1307e9de5c.1710602216.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Sun, 17 Mar 2024 14:59:48 -0400
Message-ID: <CABBYNZKHNyCLL+TrJKQLbbv7sRv7jTqSp3vKZP97kLtbFGJ3Ug@mail.gmail.com>
Subject: Re: [PATCH BlueZ] bap: handle ep or session freed before select_cb returns
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sat, Mar 16, 2024 at 11:24=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> select_cb() callback is called when the sound server replies. However,
> at that point the ep or session for which it was made may already be
> gone if e.g. device disconnects or adapter is powered off.
>
> Track pending select_cb() callbacks, and mark them canceled when ep /
> session goes away.

Instead of marking them as canceled I guess we could actually cancel
the ongoing operations which shall resulting in calling
media_endpoint_cancel->dbus_pending_call_cancel which is what seems to
trigger the crash, so perhaps we need cancel select or make
pac->ops->clear cancel it implicitly, that said select doesn't involve
the creation of any stream  so we might need to introduce
bt_bap_select_cancel which would invoke pac->ops->clear then
pac_clear->media_endpoint_cancel->dbus_pending_call_cancel, etc.

> Fixes crash:
>
> =3D=3D889897=3D=3DERROR: AddressSanitizer: heap-use-after-free
> READ of size 8 at 0x60400006b098 thread T0
>     #0 0x55aeba in setup_new profiles/audio/bap.c:840
>     #1 0x562158 in select_cb profiles/audio/bap.c:1361
>     #2 0x47ad66 in pac_select_cb profiles/audio/media.c:920
>     #3 0x47661b in endpoint_reply profiles/audio/media.c:375
>     ...
> freed by thread T0 here:
>     #0 0x7fd20bcd7fb8 in __interceptor_free.part.0
>     #1 0x55f913 in ep_free profiles/audio/bap.c:1156
>     #2 0x7d696e in remove_interface gdbus/object.c:660
>     #3 0x7de622 in g_dbus_unregister_interface gdbus/object.c:1394
>     #4 0x554536 in ep_unregister profiles/audio/bap.c:193
>     #5 0x574455 in ep_remove profiles/audio/bap.c:2963
>     #6 0x7f5341 in queue_remove_if src/shared/queue.c:279
>     #7 0x7f5aba in queue_remove_all src/shared/queue.c:321
>     #8 0x57452b in bap_disconnect profiles/audio/bap.c:2972
>     #9 0x6cd107 in btd_service_disconnect src/service.c:305
>     ...
> previously allocated by thread T0 here:
>     #0 0x7fd20bcd92ef in malloc
>     #1 0x7f6e98 in util_malloc src/shared/util.c:46
>     #2 0x560d28 in ep_register profiles/audio/bap.c:1282
>     #3 0x562bdf in pac_register profiles/audio/bap.c:1386
>     #4 0x8cc834 in bap_foreach_pac src/shared/bap.c:4950
>     #5 0x8cccfc in bt_bap_foreach_pac src/shared/bap.c:4964
>     #6 0x56330b in bap_ready profiles/audio/bap.c:1457
>     ...
> ---
>  profiles/audio/bap.c | 81 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 70 insertions(+), 11 deletions(-)
>
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index 964ba9c21..6c74760c2 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -95,6 +95,12 @@ struct bap_ep {
>         struct queue *setups;
>  };
>
> +struct bap_select {
> +       int ref_count;
> +       struct bap_data *data;
> +       struct bap_ep *ep;
> +};
> +
>  struct bap_data {
>         struct btd_device *device;
>         struct btd_adapter *adapter;
> @@ -107,8 +113,8 @@ struct bap_data {
>         struct queue *snks;
>         struct queue *bcast;
>         struct queue *streams;
> +       struct queue *selecting;
>         GIOChannel *listen_io;
> -       int selecting;
>         void *user_data;
>  };
>
> @@ -194,6 +200,14 @@ static void ep_unregister(void *data)
>                                                 MEDIA_ENDPOINT_INTERFACE)=
;
>  }
>
> +static void bap_cancel_select(void *data)
> +{
> +       struct bap_select *sel =3D data;
> +
> +       sel->data =3D NULL;
> +       sel->ep =3D NULL;
> +}
> +
>  static void bap_data_free(struct bap_data *data)
>  {
>         if (data->listen_io) {
> @@ -210,6 +224,7 @@ static void bap_data_free(struct bap_data *data)
>         queue_destroy(data->srcs, ep_unregister);
>         queue_destroy(data->bcast, ep_unregister);
>         queue_destroy(data->streams, NULL);
> +       queue_destroy(data->selecting, bap_cancel_select);
>         bt_bap_ready_unregister(data->bap, data->ready_id);
>         bt_bap_state_unregister(data->bap, data->state_id);
>         bt_bap_pac_unregister(data->bap, data->pac_id);
> @@ -1148,11 +1163,21 @@ static const GDBusMethodTable ep_methods[] =3D {
>         { },
>  };
>
> +static void ep_cancel_select(void *data, void *user_data)
> +{
> +       struct bap_select *sel =3D data;
> +
> +       if (sel->ep =3D=3D user_data)
> +               sel->ep =3D NULL;
> +}
> +
>  static void ep_free(void *data)
>  {
>         struct bap_ep *ep =3D data;
>         struct queue *setups =3D ep->setups;
>
> +       queue_foreach(ep->data->selecting, ep_cancel_select, ep);
> +
>         ep->setups =3D NULL;
>         queue_destroy(setups, setup_free);
>         free(ep->path);
> @@ -1348,16 +1373,29 @@ static void bap_config(void *data, void *user_dat=
a)
>         queue_foreach(ep->setups, setup_config, NULL);
>  }
>
> +static void select_count(void *data, void *user_data)
> +{
> +       struct bap_select *sel =3D data;
> +       int *count =3D user_data;
> +
> +       *count +=3D sel->ref_count;
> +}
> +
>  static void select_cb(struct bt_bap_pac *pac, int err, struct iovec *cap=
s,
>                                 struct iovec *metadata, struct bt_bap_qos=
 *qos,
>                                 void *user_data)
>  {
> -       struct bap_ep *ep =3D user_data;
> +       struct bap_select *sel =3D user_data;
> +       struct bap_data *data =3D sel->data;
> +       struct bap_ep *ep =3D sel->ep;
>         struct bap_setup *setup;
> +       int count =3D 0;
> +
> +       if (!data || !ep)
> +               err =3D ECANCELED;
>
>         if (err) {
>                 error("err %d", err);
> -               ep->data->selecting--;
>                 goto done;
>         }
>
> @@ -1366,16 +1404,23 @@ static void select_cb(struct bt_bap_pac *pac, int=
 err, struct iovec *caps,
>         setup->metadata =3D util_iov_dup(metadata, 1);
>         setup->qos =3D *qos;
>
> -       DBG("selecting %d", ep->data->selecting);
> -       ep->data->selecting--;
> +       queue_foreach(data->selecting, select_count, &count);
> +
> +       DBG("selecting %d", count);
>
>  done:
> -       if (ep->data->selecting)
> +       if (sel->ref_count-- <=3D 1) {
> +               if (data)
> +                       queue_remove(data->selecting, sel);
> +               free(sel);
> +       }
> +
> +       if (!data || !queue_isempty(data->selecting))
>                 return;
>
> -       queue_foreach(ep->data->srcs, bap_config, NULL);
> -       queue_foreach(ep->data->snks, bap_config, NULL);
> -       queue_foreach(ep->data->bcast, bap_config, NULL);
> +       queue_foreach(data->srcs, bap_config, NULL);
> +       queue_foreach(data->snks, bap_config, NULL);
> +       queue_foreach(data->bcast, bap_config, NULL);
>  }
>
>  static bool pac_register(struct bt_bap_pac *lpac, struct bt_bap_pac *rpa=
c,
> @@ -1420,8 +1465,21 @@ static bool pac_select(struct bt_bap_pac *lpac, st=
ruct bt_bap_pac *rpac,
>         }
>
>         /* TODO: Cache LRU? */
> -       if (btd_service_is_initiator(service))
> -               bt_bap_select(lpac, rpac, &ep->data->selecting, select_cb=
, ep);
> +       if (btd_service_is_initiator(service)) {
> +               struct bap_select *sel;
> +
> +               sel =3D new0(struct bap_select, 1);
> +               sel->ep =3D ep;
> +               sel->data =3D ep->data;
> +               sel->ref_count =3D 0;
> +
> +               bt_bap_select(lpac, rpac, &sel->ref_count, select_cb, sel=
);
> +
> +               if (sel->ref_count)
> +                       queue_push_tail(ep->data->selecting, sel);
> +               else
> +                       free(sel);
> +       }
>
>         return true;
>  }
> @@ -2495,6 +2553,7 @@ static struct bap_data *bap_data_new(struct btd_dev=
ice *device)
>         data->srcs =3D queue_new();
>         data->snks =3D queue_new();
>         data->bcast =3D queue_new();
> +       data->selecting =3D queue_new();
>
>         return data;
>  }
> --
> 2.44.0
>
>


--=20
Luiz Augusto von Dentz
