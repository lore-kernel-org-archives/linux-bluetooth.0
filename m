Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CBC4C62E
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 22:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713391470; cv=none; b=AtdB5i3LM3Si5RMPSgWNh3nahFgGN5aWiOBCCKMTzGY7KcBKcq+s6VmYpUhTuQrvTafzJXJfBtTw2XbOjCof1XDhEGYnrs/V7TDsUv2+/4dAHAhirOY99QIw7EqaYZ7JaSG+A54dJOGqQ/OutEdtCs7cYWhrxgSxmwP6O5Q9Q+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713391470; c=relaxed/simple;
	bh=jamSVvbAETdqJMadhWvEpE8jC6waGxUKhB9aIRAyIpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLYV7yRwVltyUzetaFHI3p0m9ACfLvN1vl/+twLZnxJFRYuWHSn7wVntLGmlstkRWIfdCbm5Q5vJjb2WsVoYC3SYiGL7g40mOUltd/Mi6PDUcRF6vT1p8IxkwlEsa5wsPlwgxpgFxXoK1sGkg033nwOXs/P38hl57mVwK2BQQ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbrUIvdE; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbrUIvdE"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2db7c6b5598so3576901fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 15:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713391467; x=1713996267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=of2riEfH9Jz8hCAfg+FZoft0pRyYqg0mEWix4MKf6As=;
        b=BbrUIvdEoVsLE5CNa6Og3S1DJMvyhpKJksHvBBq14P+JUygGlw9fGbWWp+dDOaHs3k
         +MngaitNGyadfutg8FDiJZd7grLUD1YJgcOLtleh/qGxWRKTwXf8wZQfaXX8+CxiZGo5
         /8o27e4twwddf96ximvJHNqMdACmOSLamcPumfIkZH/L4GfyJ+FHySh83Zhe//Kx5868
         UkxKcd/ES8n85c1nEOnrxR6U3B4mIqh1oGvh7ry8AIunYnijNCvaDOu7pnQbwB/GIabQ
         d7MpoEYPZAH7R5U/VJ2iYKwPpxKySriXcI4h2hDNU82VY+I97Peja+dL1VCRB9s8evW1
         4YfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713391467; x=1713996267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=of2riEfH9Jz8hCAfg+FZoft0pRyYqg0mEWix4MKf6As=;
        b=F7CwAyc5Sja3EWyIogXmqZHn+0PypwTEzonLgjjOJT5wjVGxWAkrlioRgwgrOkun5l
         OzzEU3+oj4GhALUKrkUBHBJKndTxEpPhjFNQGhnYZ3xuNRmPO8KDSXKPR9ovviBhZM4n
         miN23ZPxJl4sFZDKVyvqOkaQEhuofVY0OQHPW47/p61XuIBOIRvApomotOp5j6TDC2w6
         tb1E6sfxTcGRJjLWSHae0LhGA+wd5rufPBrMNPKoHpSIfPomxDPTQUIXp3oB1SPsxXm7
         IhK+dMY1aAnKYF15WpoaRX5A1caqWpPYPfFfJ/yT+/9Z2nu5I9oWNjqSZ6/3bbVA9w0i
         K6zg==
X-Gm-Message-State: AOJu0YwLYG5Egx4Yq7aJqg4Stal//sT+A6ri6VJYCw0SP+CigJOWyClR
	pW14IokvRuaJrPKouHc+S2Tvw93pOAlaU8aX+yTPET3zkf/scHDeTy3zOUd5V+2zMHp1/XS2Kxt
	xBmbCyWWCAY/gQ6OQ8yGp8p0gm4P1IA==
X-Google-Smtp-Source: AGHT+IE69ahgR/af7blDzP3F1VZ/121LrzNZIaCEpPpmymnnUz9j3pv0FQmIo8Qdt8fuUy0KfrWLtprbghy+/kyyKk4=
X-Received: by 2002:a2e:8788:0:b0:2d8:8232:8c6d with SMTP id
 n8-20020a2e8788000000b002d882328c6dmr328899lji.52.1713391466600; Wed, 17 Apr
 2024 15:04:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417142537.6523-1-vlad.pruteanu@nxp.com> <20240417142537.6523-2-vlad.pruteanu@nxp.com>
In-Reply-To: <20240417142537.6523-2-vlad.pruteanu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 17 Apr 2024 18:04:13 -0400
Message-ID: <CABBYNZJaw9MB--tHXEcejkp6NTuN1WctuaXFSQiBo347Xvcg4w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/1] bap: Replace global bcast_pa_requests with a
 queue for each adapter
To: Vlad Pruteanu <vlad.pruteanu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com, 
	mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com, 
	iulia.tanasescu@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vlad,

On Wed, Apr 17, 2024 at 10:26=E2=80=AFAM Vlad Pruteanu <vlad.pruteanu@nxp.c=
om> wrote:
>
> This patch replaces the current implementation that uses a global
> bcast_pa_requests queue and instead creates a queue and a timer for
> each adapter.
>
> The queue for a specific adapter, the timer's id and the adapter's id
> form a new struct called pa_timer_data. For each adapter a new instance
> of this struct is created and inserted into the global queue, pa_timers.
>
> Operations on the old bcast_pa_requests queue have been modified such
> that:
> 1) based on the adapter_id, the correct entry in the pa_timers queue is
> retrieved
> 2) the operation can be called on the bcast_pa_requests queue from the
> resulting pa_timer_data instance
>
> The timers are created and stopped on a per adapter basis. A timer is
> stopped if the adapter's pa_req queue is empty. A pa_timer_id equal
> to 0 means that the timer is stopped.
>
> The bap_bcast_remove function has been updated to remove from the
> pa_req queue entries of devices that were freed. pa_req that are already
> in progress are treated by the bap_data_free function.
>
> This patch also fixes a crash that occurs when a device is freed before
> the pa_idle_timer handles it's entry in the pa_req queue. The following
> log was obtained while running an Unicast setup:
>
> =3D=3D105052=3D=3DERROR: AddressSanitizer: heap-use-after-free on address
> 0x60400001c418 at pc 0x55775caf1846 bp 0x7ffc83d9fb90 sp 0x7ffc83d9fb80
> READ of size 8 at 0x60400001c418 thread T0
> 0 0x55775caf1845 in btd_service_get_device src/service.c:325
> 1 0x55775ca03da2 in short_lived_pa_sync profiles/audio/bap.c:2693
> 2 0x55775ca03da2 in pa_idle_timer profiles/audio/bap.c:1996
> ---
>  profiles/audio/bap.c | 115 ++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 97 insertions(+), 18 deletions(-)
>
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index db0af7e7c..df0c35a6f 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -126,9 +126,14 @@ struct bap_bcast_pa_req {
>         } data;
>  };
>
> +struct pa_timer_data {
> +       struct btd_adapter *adapter;
> +       unsigned int pa_timer_id;
> +       struct queue *bcast_pa_requests;
> +};
> +
>  static struct queue *sessions;
> -static struct queue *bcast_pa_requests;
> -static unsigned int pa_timer_id;
> +static struct queue *pa_timers;
>
>  /* Structure holding the parameters for Periodic Advertisement create sy=
nc.
>   * The full QOS is populated at the time the user selects and endpoint a=
nd
> @@ -965,15 +970,25 @@ static DBusMessage *set_configuration(DBusConnectio=
n *conn, DBusMessage *msg,
>         return NULL;
>  }
>
> +static bool pa_timer_match_adapter(const void *data, const void *match_d=
ata)
> +{
> +       struct pa_timer_data *pa_timer =3D (struct pa_timer_data *)data;
> +
> +       return pa_timer->adapter =3D=3D match_data;
> +}
> +
>  static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user=
_data)
>  {
>         struct bap_bcast_pa_req *req =3D user_data;
>         struct bap_setup *setup =3D req->data.setup;
> +       struct pa_timer_data *pa_timer =3D queue_find(pa_timers,
> +                       pa_timer_match_adapter, setup->ep->data->adapter)=
;
>         int fd;
>
>         DBG("BIG Sync completed");
>
> -       queue_remove(bcast_pa_requests, req);
> +       queue_remove(pa_timer->bcast_pa_requests, req);
> +       free(req);
>
>         /* This device is no longer needed */
>         btd_service_connecting_complete(setup->ep->data->service, 0);
> @@ -1111,6 +1126,8 @@ static void iso_pa_sync_confirm_cb(GIOChannel *io, =
void *user_data)
>         struct bap_data *data =3D btd_service_get_user_data(pa_req->data.=
service);
>         struct bt_iso_base base;
>         struct bt_iso_qos qos;
> +       struct pa_timer_data *pa_timer =3D queue_find(pa_timers,
> +                               pa_timer_match_adapter, data->adapter);
>
>         DBG("PA Sync done");
>
> @@ -1130,8 +1147,8 @@ static void iso_pa_sync_confirm_cb(GIOChannel *io, =
void *user_data)
>         g_io_channel_unref(data->listen_io);
>         g_io_channel_shutdown(io, TRUE, NULL);
>         data->listen_io =3D NULL;
> -       queue_remove(bcast_pa_requests, pa_req);
> -
> +       queue_remove(pa_timer->bcast_pa_requests, pa_req);
> +       free(pa_req);
>         /* Analyze received BASE data and create remote media endpoints f=
or each
>          * BIS matching our capabilities
>          */
> @@ -2015,14 +2032,15 @@ static void pa_and_big_sync(struct bap_bcast_pa_r=
eq *req);
>
>  static gboolean pa_idle_timer(gpointer user_data)
>  {
> -       struct bap_bcast_pa_req *req =3D user_data;
> +       struct pa_timer_data *pa_timer =3D user_data;
> +       struct bap_bcast_pa_req *req;
>         bool in_progress =3D FALSE;
>
>         /* Handle timer if no request is in progress */
> -       queue_foreach(bcast_pa_requests, check_pa_req_in_progress,
> +       queue_foreach(pa_timer->bcast_pa_requests, check_pa_req_in_progre=
ss,
>                         &in_progress);
>         if (in_progress =3D=3D FALSE) {
> -               req =3D queue_peek_head(bcast_pa_requests);
> +               req =3D queue_peek_head(pa_timer->bcast_pa_requests);
>                 if (req !=3D NULL)
>                         switch (req->type) {
>                         case BAP_PA_SHORT_REQ:
> @@ -2034,6 +2052,14 @@ static gboolean pa_idle_timer(gpointer user_data)
>                                 pa_and_big_sync(req);
>                                 break;
>                         }
> +               else {
> +                       /* pa_req queue is empty, stop the timer by retur=
ning
> +                        * FALSE and set the pa_timer_id to 0. This will =
later
> +                        * be used to check if the timer is active.
> +                        */
> +                       pa_timer->pa_timer_id =3D 0;
> +                       return FALSE;
> +               }
>         }
>
>         return TRUE;
> @@ -2043,15 +2069,25 @@ static void setup_accept_io_broadcast(struct bap_=
data *data,
>                                         struct bap_setup *setup)
>  {
>         struct bap_bcast_pa_req *pa_req =3D new0(struct bap_bcast_pa_req,=
 1);
> +       struct pa_timer_data *pa_timer =3D queue_find(pa_timers,
> +                               pa_timer_match_adapter, data->adapter);
> +
> +       /* Timer could be stopped if all the short lived requests were tr=
eated.
> +        * Check the state of the timer and turn it on so that this reque=
sts
> +        * can also be treated.
> +        */
> +       if (pa_timer->pa_timer_id =3D=3D 0)
> +               pa_timer->pa_timer_id =3D g_timeout_add_seconds(
> +               PA_IDLE_TIMEOUT, pa_idle_timer, pa_timer);
>
>         /* Add this request to the PA queue.
> -        * We don't need to check the queue here and the timer, as we can=
not
> -        * have BAP_PA_BIG_SYNC_REQ before a short PA (BAP_PA_SHORT_REQ)
> +        * We don't need to check the queue here, as we cannot have
> +        * BAP_PA_BIG_SYNC_REQ before a short PA (BAP_PA_SHORT_REQ)
>          */
>         pa_req->type =3D BAP_PA_BIG_SYNC_REQ;
>         pa_req->in_progress =3D FALSE;
>         pa_req->data.setup =3D setup;
> -       queue_push_tail(bcast_pa_requests, pa_req);
> +       queue_push_tail(pa_timer->bcast_pa_requests, pa_req);
>  }
>
>  static void setup_create_ucast_io(struct bap_data *data,
> @@ -2880,18 +2916,18 @@ static int bap_bcast_probe(struct btd_service *se=
rvice)
>         struct btd_adapter *adapter =3D device_get_adapter(device);
>         struct bap_bcast_pa_req *pa_req =3D
>                         new0(struct bap_bcast_pa_req, 1);
> +       struct pa_timer_data *pa_timer =3D
> +                       queue_find(pa_timers, pa_timer_match_adapter, ada=
pter);
>
>         if (!btd_adapter_has_exp_feature(adapter, EXP_FEAT_ISO_SOCKET)) {
>                 error("BAP requires ISO Socket which is not enabled");
>                 return -ENOTSUP;
>         }
>
> -       /* First time initialize the queue and start the idle timer */
> -       if (bcast_pa_requests =3D=3D NULL) {
> -               bcast_pa_requests =3D queue_new();
> -               pa_timer_id =3D g_timeout_add_seconds(PA_IDLE_TIMEOUT,
> -                                       pa_idle_timer, NULL);
> -       }
> +       /* Start the PA timer if it hasn't been started yet */
> +       if (pa_timer->pa_timer_id =3D=3D 0)
> +               pa_timer->pa_timer_id =3D g_timeout_add_seconds(
> +               PA_IDLE_TIMEOUT, pa_idle_timer, pa_timer);
>
>         /* Enqueue this device advertisement so that we can do short-live=
d
>          */
> @@ -2899,17 +2935,38 @@ static int bap_bcast_probe(struct btd_service *se=
rvice)
>         pa_req->type =3D BAP_PA_SHORT_REQ;
>         pa_req->in_progress =3D FALSE;
>         pa_req->data.service =3D service;
> -       queue_push_tail(bcast_pa_requests, pa_req);
> +       queue_push_tail(pa_timer->bcast_pa_requests, pa_req);

That doesn't really seems that different since it still using a global
queue, instead Id expected to have the pa_req stored inside the
bap_data and then have the bap_data set as user_data of the service so
if the service is removed, e.g. due to user stopping scanning, the
remove callback will be called for the service to cleanup and then we
can cleanup the pa_req as well.

>
>         return 0;
>  }
>
> +static bool match_service(const void *data, const void *match_data)
> +{
> +       struct bap_bcast_pa_req *pa_req =3D (struct bap_bcast_pa_req *)da=
ta;
> +
> +       if (pa_req->data.service =3D=3D match_data)
> +               return true;
> +       return false;
> +}
> +
>  static void bap_bcast_remove(struct btd_service *service)
>  {
>         struct btd_device *device =3D btd_service_get_device(service);
> +       struct btd_adapter *adapter =3D device_get_adapter(device);
> +       struct pa_timer_data *pa_timer =3D
> +                       queue_find(pa_timers, pa_timer_match_adapter, ada=
pter);
> +       struct bap_bcast_pa_req *pa_req;
>         struct bap_data *data;
>         char addr[18];
>
> +       /* Remove the corresponding entry from the pa_req queue. Any pa_r=
eq that
> +        * are in progress will be stopped by bap_data_remove which calls
> +        * bap_data_free.
> +        */
> +       pa_req =3D queue_remove_if(pa_timer->bcast_pa_requests,
> +                                               match_service, service);
> +       if (pa_req)
> +               free(pa_req);

Like Ive explained above this is probably harder than just having the
pa_req store directly into bap_data and then the bap_data be stored as
user_data of the service thus avoiding this sort of lookup pattern to
remove the service.

>         ba2str(device_get_address(device), addr);
>         DBG("%s", addr);
>
> @@ -3021,6 +3078,7 @@ static int bap_adapter_probe(struct btd_profile *p,
>         struct btd_gatt_database *database =3D btd_adapter_get_database(a=
dapter);
>         struct bap_data *data;
>         char addr[18];
> +       struct pa_timer_data *pa_timer;
>
>         ba2str(btd_adapter_get_address(adapter), addr);
>         DBG("%s", addr);
> @@ -3055,6 +3113,14 @@ static int bap_adapter_probe(struct btd_profile *p=
,
>
>         bt_bap_set_user_data(data->bap, adapter);
>         bap_data_set_user_data(data, adapter);
> +
> +       if (pa_timers =3D=3D NULL)
> +               pa_timers =3D queue_new();
> +       pa_timer =3D new0(struct pa_timer_data, 1);
> +       pa_timer->adapter =3D adapter;
> +       pa_timer->bcast_pa_requests =3D queue_new();
> +       queue_push_tail(pa_timers, pa_timer);

I see know why you have a global queue, it is to store the pa_req on a
per adapter manner, while I agree we probably need a list containing
the data of each adapter that shall probably be name bap_adapter and
then the queue adapters, bap_data shall have bap_adapter pointer
rather that btd_adapter, than this becomes a lot more readable and you
don't have to lookups other than just adding and removing pa_req to
data->adapter->pa_q.

>         return 0;
>  }
>
> @@ -3063,11 +3129,24 @@ static void bap_adapter_remove(struct btd_profile=
 *p,
>  {
>         struct bap_data *data =3D queue_find(sessions, match_data_bap_dat=
a,
>                                                 adapter);
> +       struct pa_timer_data *pa_timer =3D queue_find(pa_timers,
> +                                       pa_timer_match_adapter, adapter);
>         char addr[18];
>
>         ba2str(btd_adapter_get_address(adapter), addr);
>         DBG("%s", addr);
>
> +       queue_remove_all(pa_timer->bcast_pa_requests,
> +                                       NULL, NULL, free);
> +       free(pa_timer->bcast_pa_requests);
> +       queue_remove(pa_timers, pa_timer);
> +       free(pa_timer);
> +
> +       if (queue_isempty(pa_timers)) {
> +               queue_destroy(pa_timers, NULL);
> +               pa_timers =3D NULL;
> +       }
> +
>         if (!data) {
>                 error("BAP service not handled by profile");
>                 return;
> --
> 2.40.1
>


--=20
Luiz Augusto von Dentz
