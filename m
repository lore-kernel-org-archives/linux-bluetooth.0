Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DC12EEE65
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 13:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784122934; cv=pass; b=dGiF1RxmzAtzXmjGSvimX//qpxLLmdlDJbf/3/Veijf322pXZBXA6SjXog7IGpgq/aE3SoPXj0x8JCsPUEn7vzGXk0tlXNdXNVwul2hl0KnV2tYE9DU7J+r+amusimM+QoHMOlbzHrjrRw8YlpHRFWpqGg9qXkmghfgQwXLLd8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784122934; c=relaxed/simple;
	bh=TEKKGjqEfMWmwsa+cMgVq3IQmP0A16+M7ky5WF4a7OQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cyG9LxU/uFbscOLPStvKbsh3IlXqXrnxIZy4+A89Z50Bth/3yds9O1VelgibsHPFDc+2iKk57mTBmgw3O/rxxUo6bdf28QztjIG13kdQQWn7w6jhXETmulr0TCvLRYIjqZDYIt83yF7IygF2Hji182q+MeH3qgkOikc+slYcFXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9dTgCXD; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9dTgCXD"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-81e6f0b4610so59191667b3.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 06:42:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784122932; cv=none;
        d=google.com; s=arc-20260327;
        b=T2UFMnsY+TW56x25WY4j+XYfqy1En9c2LEq+QpTEezrApFlrZEpQPvcBBs3sC8DgdJ
         FEQYXyulIksbkGQjtVk2buHqp3tRNb4iMlFRS2txHg14mVfSjUD8aPYOc3lZCjGhH4Px
         /Jx3ap6T8sKaFut84ATv/Ti46oiNZetZ8sYQj51MbKVfxykg+IWFqTjj5HBjVxAszaJ0
         xtZDdmcjD8iSZtEKDcU1f7vrysF3HdcbglCHbMwnxeKeAxHr3wyBS5Jw94VM7ygKBngQ
         CMuwc6e+1l4mlIczYqFthF7DxkIPO6FrhODuLOZfGXSt1sF9h0NvKHnn//lgU0aX8cTO
         3psQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ItVwI3BLVN5uHxtpHsZp3rjaap0GDNANk/jcqz+m0+g=;
        fh=ImHaVp9LKIGjD0tRyxgUyPXd5WNSYdKgZ1TGxuDzvzM=;
        b=E1CkuIQtmIkm613iPwyezjDcTzHt/LhP/AJ7oMcVFGbrqkvlLZEWeZ8BUTMqEgBK3Q
         4FRY3+O233oYOjy1xntcH2BXh0HZX/SvUsIR8fHmBXLdYml5oebazq4u3OyYLlI84EhM
         UwwUCZmHeSsN/CrQIwWj7JZS6i6WvPP/iPG9myrkPVcUVYjeFO1mysoVjHeMIkzfndcu
         L0/lya2ssCQDS0QiAdVS05XctP077SnX1KJqfmAtLX9+r6WOetyhXTpmKT5JIfh9s6wy
         C9CFZHrl5NlKgyrfFLHHyUKfrc/m1g+gMaE/jbZWk8R/6wPG4YTl8sMoqOJ5bD5g8ZWR
         ztaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784122932; x=1784727732; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ItVwI3BLVN5uHxtpHsZp3rjaap0GDNANk/jcqz+m0+g=;
        b=m9dTgCXD25jbXPIcamYZpi1RorySmSF0J5KrluGK9SKfUFTQLXnWNBQKexbFpUikNT
         I7BZCeBHd/c5VwpsJZ1Za7TymHXmQXJYQfrnuf/hzn8TgsWaYHrQGbsjRAc3tWK9AQoT
         6ELWMTOh/fy4IUnCD/80ACpeK5zUoCZm5Sw4KRSEmtEvmXKzqniel07m2LBbqfodSHJ6
         5NHXgDps+ezUP44DBA6y/RZIoIriX4tSCwJaG53GK+3P3bkDlel8/lHUDFxP57sU7CQe
         B1SAdfEPI1FX5J10+U+4omsi3mp+8at2z/plsIg2Bk1/j9U5EyoUM0zOx9sAVxmYUcFD
         o3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784122932; x=1784727732;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ItVwI3BLVN5uHxtpHsZp3rjaap0GDNANk/jcqz+m0+g=;
        b=bbZDfFeoRaDijrVSkP1r5ByjyPJ0Ix0D4brNGEYjscsZGObRXd6wKnaIiwizdyKrqs
         UOZ8TrSiVYiGWmjsmGByyZKS98m25lTd66US54Y21jzHQ6M7k8C5qbD0l+aaZnpDVLZ3
         R7B5uqQU07kDa6MQZh2j1SGzlP/CvC7ysnAqjjCcLODQPoapRAq0DYA9wZia3wsSpBeG
         K6GOTgvkX70qqwIPNRAC0XYfTwX3zlAE7aMdrsA28gC5++El2mALPiWmPxAa2ygJ5jaK
         ysHNND94juvnS9TJ8vPTN3b1PaP8PwKmBIHrEL5OXWUORDczl9hHo2YBR7MZUc3OG+Ut
         aZDQ==
X-Gm-Message-State: AOJu0Ywwb9Nhv77HTCmqy19p8DGKs5zfgLGt8fAgj5pJJnO1tyGbtiD+
	S8SHC8jDsjYliLo61S4+cTNjxFQquGkLYSSKCQv7TtbC7ymgoF9RyfGRhKiJLO+rfe1EpvyEzKc
	yZxQ7zuCJAysBG0T5/8Vrrb7zyKYMd0g=
X-Gm-Gg: AfdE7cna+RmZIan6fzHkPFfefEdGmagq2kn473zofgrHyXPaakGIRKtl1rqb/2OIN2S
	vUtjva66I+7W11NvPiOemvaT54rHdX3S6eOCALw63WSzysw1qAtMY0+5mdfS2+e9fo/LufVHDq+
	1XtfsSeVYgWIQKAw1FVXia4+JT+R3mUJG3OsZE95nTzvsXYB/M+AJFAgy7qRjebqJZ/fOJmiSYp
	iekAsNLFHV24H9kRi3XFHiOjB61JgvKG+qEOvo7f7DCobKGZ7Gw3eNYlUpwVzJ7stP7UbFgSJDc
	ujtdknVD2gCswLBhV6oiuAV3XCxsWJTdFAOoyb+bma/DoWadgDPa1rx2
X-Received: by 2002:a05:690c:9504:b0:81e:c7d2:f26 with SMTP id
 00721157ae682-81ec7d224d5mr28716837b3.6.1784122931984; Wed, 15 Jul 2026
 06:42:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715090206.212130-1-frederic.danis@collabora.com> <20260715090206.212130-8-frederic.danis@collabora.com>
In-Reply-To: <20260715090206.212130-8-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 15 Jul 2026 09:42:01 -0400
X-Gm-Features: AUfX_mwSNzJBWSjtXl_FIrGqJlSIKxXxC7SN9r6vWHLnixbnzBHQzlC2elr1h44
Message-ID: <CABBYNZK9O1Udf98zk5=Cf7QbB7uBhXGZf+Hmcn32aVGe-sWxRw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 7/8] profiles/audio: fix UAF on external media
 service teardown
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Wed, Jul 15, 2026 at 5:03=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> Keep media_app endpoint/player queues in sync with object lifetime to
> avoid stale pointers during proxy removal.
>
> When admin allowlist reapply removes audio services, endpoint/player
> objects may be destroyed through non-proxy paths first.
> Later proxy_removed_cb calls queue_remove_if() and matching by path
> can dereference freed endpoint/player memory.
>
> Fix by:
> - adding media_app back-references in media_endpoint/local_player
> - unlinking from app queues inside media_endpoint_remove or
>   local_player_remove
> - setting ownership when app-registering endpoint/player objects
>
> This prevents heap-use-after-free in match_endpoint_by_path or
> match_player_by_path during service disconnect.
>
> Assisted-by: GPT:GPT-5.3-Codex
> ---
>  profiles/audio/media.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index 5d9ea2cbc..95f9580b0 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -136,12 +136,14 @@ struct media_endpoint {
>         guint                   watch;
>         GSList                  *requests;
>         struct media_adapter    *adapter;
> +       struct media_app        *app;
>         GSList                  *transports;
>         struct endpoint_features        features;
>  };
>
>  struct local_player {
>         struct media_adapter    *adapter;
> +       struct media_app        *app;
>         char                    *sender;        /* Player DBus bus id */
>         char                    *path;          /* Player object path */
>         GHashTable              *settings;      /* Player settings */
> @@ -305,6 +307,11 @@ static void media_endpoint_remove(void *data)
>         }
>  #endif
>
> +       if (endpoint->app) {
> +               queue_remove(endpoint->app->endpoints, endpoint);
> +               endpoint->app =3D NULL;
> +       }
> +
>         info("Endpoint unregistered: sender=3D%s path=3D%s", endpoint->se=
nder,
>                         endpoint->path);
>
> @@ -2076,6 +2083,11 @@ static void local_player_remove(void *data)
>  {
>         struct local_player *mp =3D data;
>
> +       if (mp->app) {
> +               queue_remove(mp->app->players, mp);
> +               mp->app =3D NULL;
> +       }
> +
>         info("Player unregistered: sender=3D%s path=3D%s", mp->sender, mp=
->path);
>
>         local_player_destroy(mp);
> @@ -3168,6 +3180,8 @@ static void app_register_endpoint(void *data, void =
*user_data)
>                 return;
>         }
>
> +       endpoint->app =3D app;
> +
>         queue_push_tail(app->endpoints, endpoint);
>
>         return;
> @@ -3196,6 +3210,8 @@ static void app_register_player(void *data, void *u=
ser_data)
>         if (!player)
>                 return;
>
> +       player->app =3D app;
> +
>         if (g_dbus_proxy_get_property(proxy, "PlaybackStatus", &iter)) {
>                 if (!set_status(player, &iter))
>                         goto fail;
> --
> 2.43.0

I guess this can be applied separetely, at least I don't see any
relation with the other changes.

--=20
Luiz Augusto von Dentz
