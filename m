Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1928143880
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Apr 2024 17:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712597277; cv=none; b=OnvZYn6qFqyJM6orUWkRe8rTbaLiCNBlJW05o0PZyCsgIB7v0Q0Ewmt/71PPkbJqVMK1Zon205goexhVkeeuOyT8ldBAT0wvgwQJaKOX3XyVS/9m/n1sL/kHVx/JZtGWScaHc01gzuqFzzvcfkngQfAnjiDO2mhP73QBsUK25go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712597277; c=relaxed/simple;
	bh=NWBkc6Xk6zGtP4bEpZjv7P92wP3z2pgLtCmEI/+Hrhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oDaGvvRrUBTP246gkP/IfcDx6VUHrYlPttUPWw2BmvKzQrNU2Z4IfV7X33tuYRhqyqmMuovrDWR4wSVDe0orsxrdN7yYh1B4DXptldbUqYto7P8KQdsuhSUj0v4oK3NHQWUXL6l3HGPioncUKp/gKLAs2HAxG9cjuzQzrh9fw/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5ouJwm0; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5ouJwm0"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so50594641fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Apr 2024 10:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712597272; x=1713202072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzuFW01f8Z3yY1cJcPvY+2D2ewiHnOvGfswWNqi4cTk=;
        b=B5ouJwm0nZViRJJtRlGBPpAiy/TUXNUt/qvjKzsuK918IkHrzi9FQIqLe53NkKWG4X
         RbSFudCrG6hFwY9HR2/ZFDlBj2OLC+RWzjckvaX6L+bzUhxSPHJm/xnBhkuR8j9W5/0F
         73FbVwwGr3C7KV5sA9VkRW6vFqMr/TkfvaklQ+BO6f8OP08/1qDLqN4fqSkqd/8N1jae
         l5HuDEfDMYQw2KOAa4sPijSVTSBuWuG7YEAa/3a8m0eH1UC4ewkzPb3HDc8cnNtaDFKM
         jpmCY0i7MPVuuidFRnNSUO12CJcDoI+KCX3UEQhG6PTAGtabcmELU8AYi4J1fOkOyzZg
         Mm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712597272; x=1713202072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzuFW01f8Z3yY1cJcPvY+2D2ewiHnOvGfswWNqi4cTk=;
        b=rWMpH2lN3mDoUVzpVpH/bJGIpIo/diQq0RhiC5HcrMX5RerS+hm3b28HuWJ97/mCWN
         8MQ+Guiwwjx2lAf8F/cKvCOq56KhK8tQEnfSnrZD32ABAe2HgqNCZRfEetyVFsXQFqUo
         rilNXJ9JhxRGb9bVF/4coG0n9HddoDWqukmvvpOYu0jfQjeO8bT/a6NRSSLGTyoJnhGV
         byUE8f8Ev2lEK/15ovRYc9Q+IvXn2sLTQugbB3b9fpxpx80doTw9b4zuvCU4CMSP9odt
         PwOB2i1ML2eLINEd4KGO8IFQeGdBGDH9cS9X6UAOP0R9EOETQL1ylF7E0T5eYGTJ7zh8
         3q2w==
X-Gm-Message-State: AOJu0YzYH0//9NyuF3e14msPYpgObV/t+dG+wQiYqze/YnK4F6KNjd0P
	ZznmvMubkIF1GqntiD0uRmOCBW9BAOmHgWibFdSCBqorjiIw7RvLBW6HMgz673ieSxfxN05vR5F
	Vd3s+fDBPl7fR7hTEqz7M3kn3Sps=
X-Google-Smtp-Source: AGHT+IF5R/176eDxbqGcGfsUaN0jxOtBojSQv5MjyrOIRFz2KtcDQzYvvmgJdU5SS0Z14VPtQiOZfp12KtDecjPi++Y=
X-Received: by 2002:a2e:8903:0:b0:2d7:1805:1079 with SMTP id
 d3-20020a2e8903000000b002d718051079mr6402551lji.7.1712597271334; Mon, 08 Apr
 2024 10:27:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408142724.12511-1-vlad.pruteanu@nxp.com> <20240408142724.12511-2-vlad.pruteanu@nxp.com>
In-Reply-To: <20240408142724.12511-2-vlad.pruteanu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 8 Apr 2024 13:27:38 -0400
Message-ID: <CABBYNZ+qmKUyAn6Ui67QL4VJ4rs4xktXWBmjmgB1te4wDwN+9Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/1] bap: Replace global bcast_pa_requests with a
 queue for each adapter
To: Vlad Pruteanu <vlad.pruteanu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com, 
	mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com, 
	iulia.tanasescu@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vlad,

On Mon, Apr 8, 2024 at 10:28=E2=80=AFAM Vlad Pruteanu <vlad.pruteanu@nxp.co=
m> wrote:
>
> This patch replaces the old global implementation of the bcast_pa_request=
s
> queue with one that stores the queue per adapter. The pa_timer has also
> been modified to be per adapter. The timer is now stopped when the queue =
is
> empty. The bcast_pa_requests queue, along with the pa_timer_id are now
> stored in the bap_data structure. Each adapter already has a coresponding
> entry in the sessions queue. Operations on the old bcast_pa_requests have
> been modified to be made on the appropriate bap_data entry.
>
> The bap_bcast_remove function has also been updated to remove from the
> queue entries of devices that were freed.
> ---
>  profiles/audio/bap.c | 109 +++++++++++++++++++++++++++++++------------
>  1 file changed, 79 insertions(+), 30 deletions(-)
>
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index db0af7e7c..82c6cf313 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -107,6 +107,8 @@ struct bap_data {
>         struct queue *snks;
>         struct queue *bcast;
>         struct queue *streams;
> +       struct queue *bcast_pa_requests;
> +       unsigned int pa_timer_id;
>         GIOChannel *listen_io;
>         int selecting;
>         void *user_data;
> @@ -127,8 +129,6 @@ struct bap_bcast_pa_req {
>  };
>
>  static struct queue *sessions;
> -static struct queue *bcast_pa_requests;
> -static unsigned int pa_timer_id;
>
>  /* Structure holding the parameters for Periodic Advertisement create sy=
nc.
>   * The full QOS is populated at the time the user selects and endpoint a=
nd
> @@ -965,15 +965,25 @@ static DBusMessage *set_configuration(DBusConnectio=
n *conn, DBusMessage *msg,
>         return NULL;
>  }
>
> +static bool match_adapter_entry(const void *data, const void *match_data=
)
> +{
> +       const struct bap_data *bdata =3D data;
> +       const struct btd_adapter *adapter =3D match_data;
> +
> +       return (bdata->user_data =3D=3D adapter) && (bdata->device =3D=3D=
 NULL);
> +}
> +
>  static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user=
_data)
>  {
>         struct bap_bcast_pa_req *req =3D user_data;
>         struct bap_setup *setup =3D req->data.setup;
> +       struct bap_data *bap_data =3D queue_find(sessions,
> +                       match_adapter_entry, setup->ep->data->adapter);

These lookups sound suspicious, couldn't you just store the bap_data
in the pa_req?

>         int fd;
>
>         DBG("BIG Sync completed");
>
> -       queue_remove(bcast_pa_requests, req);
> +       queue_remove(bap_data->bcast_pa_requests, req);
>
>         /* This device is no longer needed */
>         btd_service_connecting_complete(setup->ep->data->service, 0);
> @@ -1109,6 +1119,7 @@ static void iso_pa_sync_confirm_cb(GIOChannel *io, =
void *user_data)
>         GError *err =3D NULL;
>         struct bap_bcast_pa_req *pa_req =3D user_data;
>         struct bap_data *data =3D btd_service_get_user_data(pa_req->data.=
service);
> +       struct bt_bap *bap =3D data->bap;
>         struct bt_iso_base base;
>         struct bt_iso_qos qos;
>
> @@ -1130,12 +1141,13 @@ static void iso_pa_sync_confirm_cb(GIOChannel *io=
, void *user_data)
>         g_io_channel_unref(data->listen_io);
>         g_io_channel_shutdown(io, TRUE, NULL);
>         data->listen_io =3D NULL;
> -       queue_remove(bcast_pa_requests, pa_req);
> +       data =3D queue_find(sessions, match_adapter_entry, data->adapter)=
;
> +       queue_remove(data->bcast_pa_requests, pa_req);

Ditto.

>
>         /* Analyze received BASE data and create remote media endpoints f=
or each
>          * BIS matching our capabilities
>          */
> -       parse_base(data->bap, &base, bap_debug);
> +       parse_base(bap, &base, bap_debug);
>  }
>
>  static bool match_data_bap_data(const void *data, const void *match_data=
)
> @@ -2015,25 +2027,37 @@ static void pa_and_big_sync(struct bap_bcast_pa_r=
eq *req);
>
>  static gboolean pa_idle_timer(gpointer user_data)
>  {
> -       struct bap_bcast_pa_req *req =3D user_data;
> +       struct bap_data *bap_data =3D user_data;
> +       struct bap_bcast_pa_req *req =3D
> +                               queue_peek_head(bap_data->bcast_pa_reques=
ts);
>         bool in_progress =3D FALSE;
>
> +       /* If the queue is empty, stop the timer. It will be started,late=
r on,
> +        * if any new requests arrive.
> +        */
> +       if (req =3D=3D NULL) {
> +               /* Set the adapter's pa_timer id to 0. This will later be
> +                * used to check if the timer is on or off.
> +                */
> +               bap_data->pa_timer_id =3D 0;
> +               /* Stop the adapter's pa_timer by returning FALSE */
> +               return FALSE;
> +       }
> +
>         /* Handle timer if no request is in progress */
> -       queue_foreach(bcast_pa_requests, check_pa_req_in_progress,
> +       queue_foreach(bap_data->bcast_pa_requests, check_pa_req_in_progre=
ss,
>                         &in_progress);
>         if (in_progress =3D=3D FALSE) {
> -               req =3D queue_peek_head(bcast_pa_requests);
> -               if (req !=3D NULL)
> -                       switch (req->type) {
> -                       case BAP_PA_SHORT_REQ:
> -                               DBG("do short lived PA Sync");
> -                               short_lived_pa_sync(req);
> -                               break;
> -                       case BAP_PA_BIG_SYNC_REQ:
> -                               DBG("do PA Sync and BIG Sync");
> -                               pa_and_big_sync(req);
> -                               break;
> -                       }
> +               switch (req->type) {
> +               case BAP_PA_SHORT_REQ:
> +                       DBG("do short lived PA Sync");
> +                       short_lived_pa_sync(req);
> +                       break;
> +               case BAP_PA_BIG_SYNC_REQ:
> +                       DBG("do PA Sync and BIG Sync");
> +                       pa_and_big_sync(req);
> +                       break;
> +               }
>         }
>
>         return TRUE;
> @@ -2043,15 +2067,25 @@ static void setup_accept_io_broadcast(struct bap_=
data *data,
>                                         struct bap_setup *setup)
>  {
>         struct bap_bcast_pa_req *pa_req =3D new0(struct bap_bcast_pa_req,=
 1);
> +       struct bap_data *bap_data =3D queue_find(sessions,
> +               match_adapter_entry, data->adapter);

Wait, you do have bap_data already passed to this function, why do you
need to lookup for another?

> +
> +       /* Timer could be stopped if all the short lived requests were tr=
eated.
> +        * Check the state of the timer and turn it on so that this reque=
sts
> +        * can also be treated.
> +        */
> +       if (bap_data->pa_timer_id =3D=3D 0)
> +               bap_data->pa_timer_id =3D g_timeout_add_seconds(
> +               PA_IDLE_TIMEOUT, pa_idle_timer, bap_data);
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
> +       queue_push_tail(bap_data->bcast_pa_requests, pa_req);
>  }
>
>  static void setup_create_ucast_io(struct bap_data *data,
> @@ -2878,6 +2912,8 @@ static int bap_bcast_probe(struct btd_service *serv=
ice)
>  {
>         struct btd_device *device =3D btd_service_get_device(service);
>         struct btd_adapter *adapter =3D device_get_adapter(device);
> +       struct bap_data *bap_data =3D queue_find(sessions,
> +                                               match_adapter_entry, adap=
ter);

Don't we store the bap_data into the server user_data?

>         struct bap_bcast_pa_req *pa_req =3D
>                         new0(struct bap_bcast_pa_req, 1);
>
> @@ -2886,12 +2922,10 @@ static int bap_bcast_probe(struct btd_service *se=
rvice)
>                 return -ENOTSUP;
>         }
>
> -       /* First time initialize the queue and start the idle timer */
> -       if (bcast_pa_requests =3D=3D NULL) {
> -               bcast_pa_requests =3D queue_new();
> -               pa_timer_id =3D g_timeout_add_seconds(PA_IDLE_TIMEOUT,
> -                                       pa_idle_timer, NULL);
> -       }
> +       /* Start the PA timer if it isn't active */
> +       if (bap_data->pa_timer_id =3D=3D 0)
> +               bap_data->pa_timer_id =3D g_timeout_add_seconds(
> +               PA_IDLE_TIMEOUT, pa_idle_timer, bap_data);
>
>         /* Enqueue this device advertisement so that we can do short-live=
d
>          */
> @@ -2899,17 +2933,31 @@ static int bap_bcast_probe(struct btd_service *se=
rvice)
>         pa_req->type =3D BAP_PA_SHORT_REQ;
>         pa_req->in_progress =3D FALSE;
>         pa_req->data.service =3D service;
> -       queue_push_tail(bcast_pa_requests, pa_req);
> +       queue_push_tail(bap_data->bcast_pa_requests, pa_req);
>
>         return 0;
>  }
>
> +static bool remove_service(const void *data, const void *match_data)
> +{
> +       struct bap_bcast_pa_req *pa_req =3D (struct bap_bcast_pa_req *)da=
ta;
> +
> +       if (pa_req->type =3D=3D BAP_PA_SHORT_REQ &&
> +               pa_req->data.service =3D=3D match_data)
> +               return true;
> +       return false;
> +}
> +
>  static void bap_bcast_remove(struct btd_service *service)
>  {
>         struct btd_device *device =3D btd_service_get_device(service);
> -       struct bap_data *data;
> +       struct btd_adapter *adapter =3D device_get_adapter(device);
> +       struct bap_data *data =3D queue_find(sessions,
> +                                               match_adapter_entry, adap=
ter);

Ditto.

>         char addr[18];
>
> +       queue_remove_if(data->bcast_pa_requests, remove_service, service)=
;

Not really sure what this would be doing, aren't you supposed to clean
up if there is pa_req pending for the given service/device and stop
the pa_sync if it is in progress? It seems you just remove it from the
list but it is not free/cancel after this point.

>         ba2str(device_get_address(device), addr);
>         DBG("%s", addr);
>
> @@ -3035,6 +3083,7 @@ static int bap_adapter_probe(struct btd_profile *p,
>
>         data->bap =3D bt_bap_new(btd_gatt_database_get_db(database),
>                                         btd_gatt_database_get_db(database=
));
> +       data->bcast_pa_requests =3D queue_new();
>         if (!data->bap) {
>                 error("Unable to create BAP instance");
>                 free(data);
> --
> 2.40.1
>


--=20
Luiz Augusto von Dentz
