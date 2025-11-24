Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91E731619D
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Nov 2025 16:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001565; cv=none; b=oYDQO+ZxzwpeIxRTaPIIzYICmbBtYIPCm/1bEF/mmmBOz96MSWl9pK9FgUp68apdUuuiJpa/8yDzZX0/vt4PDj88uk/OV8G5G3wfgZHnH5MV7oxjb8mQsJXr1M59pSIThdoqsQZBBJGj/WUtxqgCDv9oc1ZvkQlfyHMhu4qTGQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001565; c=relaxed/simple;
	bh=CoV3kzpUDsOyUhe9mCa7DxkH5m9zxcZhorpzQLIpAfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQmsgyXtGIhvYcqWrpOtPZvoKYazuoJdHmeIUX9p9UEYfRcjBNJIck9DzvVSq3P+8V5mXgp9mFuBWok7QFUsGknX/NQzWSWeAyIDzpIDSZWghpjwb8XNPXFcHyt5nlgHMD94R0mH+8xUHVrNIr9/52ba97yJ5/3PT4qTr6Gh+yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpY0YzI6; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpY0YzI6"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-37b99da107cso39678671fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Nov 2025 08:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764001562; x=1764606362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RW69BEi8z1DScpi3tGJarBMPLtbIMczp+AcuCpAZYAE=;
        b=WpY0YzI63cwC/LKmVdIB6cEePzmirQaaEz80URJJ0QLOFQD/fpUEHacBdCYIvvn17j
         Pgdpxu67HKccHKtuHmOqNBmKsvhbF+coLw7dBtUlOm7SDB8HxtCgVPpNWGlnWWMLOtye
         Xj986kCY+6jJ4VqhLbAzsisa6Vc8SUFD3+G/WPudmlaV5ONW7jLz60eUsR+iFiLVky0F
         Xtb1jNfVA8tn1B6GRdqpCfcuk0eWAPKJ9szaXbZKrxHawLAqynCD4rAFDqMrLrPDIfSo
         QVqYXp5Jnd+PEkxZeoKbLw+5nvJRrl2Yq2tKs6gpzR+aFE8ruxdLAxh420USz0QmwiW6
         BwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764001562; x=1764606362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RW69BEi8z1DScpi3tGJarBMPLtbIMczp+AcuCpAZYAE=;
        b=mtxkzLgIhkOD7aoq5ItIyo5Xy/SHamDf9zV3mDzoUNyWfynfAsjVI1HmR7S3YhmXkq
         O0Xzc+xGZUdQY5LQq/i3auFqS7V885GxaU/0hcSjEUXJTy36Pe/E9jvJYwqodPszDmZ8
         HumRc8i23Kc8ekZJujeco6iMiSWSvk0N/fCurmhsFqJoRjEZXWIqitCiwfe+SyZWbIfn
         EAvlQ9rf/tVJx5BGt+D4qloGVZoODvb5DAyOSoUtqoTEmz5pT+mVocp24psyGbG+68Mk
         1XVgAWQIE1JP4u9CQvle5P5bNYabY3lq1QdXdwK9H89IpWw+jB+11oe5Xwp3Bk/ZhmGb
         75aw==
X-Gm-Message-State: AOJu0Ywm7CthYdP/DzfQV+6pjToYKCTv/CdhFokOIB5yVgOwjIB0CrG8
	iROy3gpFIkCqdhD7O1Y7/X/gbQHZ0juzPfNlFouf6PQoEfoEOwmLow77qVWyvIZtxPhIMifsCg2
	7Xbyelpx59H3IQLkd8m6JdPauuxQFm4Q8K1nh
X-Gm-Gg: ASbGncusnjfoqNDL9SyITbONggTGGVwiPkCaiFnDhctsGFHY5Cxc0C3Rzr6zSCU9fDp
	6wRjZpTMlPRtW84Qw9OrP0FBV1+D8/LZcrTJ74Y5BqA46LS+pWCHPFnIuFzecUc5zlpdOdaWRh8
	A8VMxRDVtsDvtTKzllw1AyTzntc0V90W44PhN1xidD2/z7TTQXF0N1yrl5nHKJ/GhY0NbLfGYI3
	K2lH1zu97L3LSE4dri1bChIX2JxU2AcEC6rCfEEWscWgfBi391/rzqS9M/hDoAFS8HV4w==
X-Google-Smtp-Source: AGHT+IHms0TTTKdzCUVft/N1FW3XUVNIvvWiVqbCJZMcMLFdDrFqugL2mjdEw8H5Zi3O9IN9yIv1e01NQwmmP63BfGg=
X-Received: by 2002:a2e:9b14:0:b0:37b:991a:544b with SMTP id
 38308e7fff4ca-37cd9280ed1mr25265731fa.34.1764001561596; Mon, 24 Nov 2025
 08:26:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763914558.git.pav@iki.fi> <3761b0c09f02442470d64de9225d3308df2d509f.1763914558.git.pav@iki.fi>
In-Reply-To: <3761b0c09f02442470d64de9225d3308df2d509f.1763914558.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 24 Nov 2025 11:25:49 -0500
X-Gm-Features: AWmQ_bkQnVZh9EYL57zlBtaNukduevSMcNcY84dENuOxnOaU83kfG_i3VVTrVkM
Message-ID: <CABBYNZJdLZwX0t+0h3R71bvfqapj8zrc=_t=ZnVJ6SyuTj=_pA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 04/10] bap: have unicast client wait for VCS & TMAS
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sun, Nov 23, 2025 at 11:17=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Have unicast client to wait for VCS and TMAS before creating endpoints
> and transports, so that their information is available at that point.
> ---
>  profiles/audio/bap.c | 69 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 66 insertions(+), 3 deletions(-)
>
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index b07d65e68..73c5cfc74 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -127,6 +127,7 @@ struct bap_data {
>         struct btd_device *device;
>         struct btd_adapter *adapter;
>         struct btd_service *service;
> +       struct queue *wait_services;
>         struct bt_bap *bap;
>         unsigned int ready_id;
>         unsigned int state_id;
> @@ -139,6 +140,7 @@ struct bap_data {
>         GIOChannel *listen_io;
>         unsigned int io_id;
>         unsigned int cig_update_id;
> +       unsigned int service_state_id;
>  };
>
>  static struct queue *sessions;
> @@ -186,11 +188,15 @@ static void bap_data_free(struct bap_data *data)
>         queue_destroy(data->bcast, ep_unregister);
>         queue_destroy(data->server_streams, NULL);
>         queue_destroy(data->bcast_snks, setup_free);
> +       queue_destroy(data->wait_services, NULL);
>         bt_bap_ready_unregister(data->bap, data->ready_id);
>         bt_bap_state_unregister(data->bap, data->state_id);
>         bt_bap_pac_unregister(data->bap, data->pac_id);
>         bt_bap_unref(data->bap);
>
> +       if (data->service_state_id)
> +               btd_service_remove_state_cb(data->service_state_id);
> +
>         if (data->cig_update_id)
>                 g_source_remove(data->cig_update_id);
>
> @@ -2015,13 +2021,16 @@ static bool pac_found_bcast(struct bt_bap_pac *lp=
ac, struct bt_bap_pac *rpac,
>         return true;
>  }
>
> -static void bap_ready(struct bt_bap *bap, void *user_data)
> +static void bap_service_ready(struct bap_data *data)
>  {
> -       struct btd_service *service =3D user_data;
> -       struct bap_data *data =3D btd_service_get_user_data(service);
> +       struct bt_bap *bap =3D data->bap;
> +       struct btd_service *service =3D data->service;
>
>         DBG("bap %p", bap);
>
> +       if (!queue_isempty(data->wait_services))
> +               return;
> +
>         /* Register all ep before selecting, so that sound server
>          * knows all.
>          */
> @@ -2031,6 +2040,15 @@ static void bap_ready(struct bt_bap *bap, void *us=
er_data)
>         bap_select_all(data, false, NULL, NULL);
>  }
>
> +static void bap_ready(struct bt_bap *bap, void *user_data)
> +{
> +       struct btd_service *service =3D user_data;
> +       struct bap_data *data =3D btd_service_get_user_data(service);
> +
> +       queue_remove(data->wait_services, NULL);
> +       bap_service_ready(data);
> +}
> +
>  static bool match_setup_stream(const void *data, const void *user_data)
>  {
>         const struct bap_setup *setup =3D data;
> @@ -3740,6 +3758,44 @@ static int bap_probe(struct btd_service *service)
>         return 0;
>  }
>
> +static void wait_service_cb(struct btd_service *service,
> +                                               btd_service_state_t old_s=
tate,
> +                                               btd_service_state_t new_s=
tate,
> +                                               void *user_data)
> +{
> +       struct bap_data *data =3D user_data;
> +
> +       if (new_state =3D=3D BTD_SERVICE_STATE_CONNECTING)
> +               return;
> +       if (!queue_remove(data->wait_services, service))
> +               return;
> +
> +       DBG("%s", btd_service_get_profile(service)->name);
> +       bap_service_ready(data);
> +}
> +
> +static void wait_service_add(struct bap_data *data, uint16_t remote_uuid=
)
> +{
> +       struct btd_service *service;
> +       bt_uuid_t uuid;
> +       char uuid_str[64];
> +
> +       bt_uuid16_create(&uuid, remote_uuid);
> +       bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
> +
> +       service =3D btd_device_get_service(data->device, uuid_str);
> +       if (!service)
> +               return;
> +       if (btd_service_get_state(service) !=3D BTD_SERVICE_STATE_CONNECT=
ING)
> +               return;
> +
> +       queue_push_tail(data->wait_services, service);
> +
> +       if (!data->service_state_id)
> +               data->service_state_id =3D btd_service_add_state_cb(
> +                                               wait_service_cb, data);
> +}
> +
>  static int bap_accept(struct btd_service *service)
>  {
>         struct btd_device *device =3D btd_service_get_device(service);
> @@ -3760,6 +3816,13 @@ static int bap_accept(struct btd_service *service)
>                 return -EINVAL;
>         }
>
> +       queue_destroy(data->wait_services, NULL);
> +       data->wait_services =3D queue_new();
> +
> +       queue_push_tail(data->wait_services, NULL);

Why are you pushing NULL above?

> +       wait_service_add(data, TMAS_UUID);
> +       wait_service_add(data, VCS_UUID);

I wonder if we couldn't add this sort of logic directly in service.c
so in case other plugins need to do some dependency handling like
above we don't need to code it  internally in the plugin itself
creating duplicate handling.

>         btd_service_connecting_complete(service, 0);
>
>         return 0;
> --
> 2.51.1
>
>


--=20
Luiz Augusto von Dentz
