Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794504844;
	b=u2f2O0mzdjS8hrT0tdYJzUY50uc+qgioy4Knurvo1bpliVs6pR4KN/koahZ97B/H6bNi
	 OXj2iybW5/dx8s3vBgJWBvHWqWQGzB6zLrwbixDkGbOJPZ70PwaMgRK2C15WLU3eU0RDN
	 L/jBisarK1lvUGGhVH62ig/genCl5MnDJycgvBzZP275V7j3V1VjnOqfj7iS8FFTNCdfH
	 wRisbWct7Wm+vNOU3BXR0bLP8YirjfTvM0aFa63BC5l+BdhRt3WyzuNrHEFdpd32Cgrct
	 wWmbNzgWCYBdrbHfSnCuDxyx7f5zWn5mJhyEbpU63VqwHU1AtQGLalTnznrEwxheSzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=uWCO9U1S7oEtPLhVHcm3UThVcb5j4V4ZNb8JTcZfX1k=;
	b=cO2+s+smIwkAv0uNlzrQtfbV0E1Ox21Lc4a+RPLV3nTYlNWIXJ1wP2qySPDjyZP70A0y
	 2CUpRAP0yq/BH3IprELr2g8lD5DktSrkGw4nyb99065Bfb1c4BPW0gFgQ5lxR4G04NLDh
	 wjcii/RXVWd97F2Jpz0Ral4Z/+wo0f1I/Qw3QfdjZK0dzDg/HH2CEEMMB9Vs5Zh3Ext8D
	 BmAP4NaSe7mDS3fpWq6+ZKevFqPW4ACcCshSEqTomXGVB2tlffIBP7YNT6dtFeKAE4DOk
	 MPvdx5ABVqkwAPl5GQKi9OcBFx7QWJcZpB0k5k7gKOX+ffiUeIGfaqMBP8A8pIBMhFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="QO5mcJz/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2B4606A894
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 17:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE2B4606A894
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QO5mcJz/
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b31ca7e0bcso1874847b3.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 09:34:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794504843; cv=none;
        d=google.com; s=arc-20260327;
        b=nCwQ2ZY7Hci4Ij2JAQyz3fVGljPGWU7012Xp2HkBZ2LvxloeNb7GGuemMIAHWY77vy
         kLBramO/QonqZeHH92w4X6BD4Zh3JhqYj9CaGht5HiCaWsHiPJESxj1IU4gSxdsT3Zg+
         OUONO6yHo5XpCm6c+gtusJCT+9umcSh+XPyT3GLy8k9v2GbTscKzou+Ye2fFcx+abWky
         sQzHqM1Ab5rCcOZ+c/4hKyB89FHO/981SPX1yWOMu20R1NUB5mJqV2Oa5aa4c2FkitOJ
         Nxk71CvRaRXu+ujjwdtYwe+M6Ka5ZGwYr6eDICiEX6O/qbRMSS/gbLxVAV1QcY/73qM4
         ppYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uWCO9U1S7oEtPLhVHcm3UThVcb5j4V4ZNb8JTcZfX1k=;
        fh=h0eQ6x2YQvNL1Vl3qWYaFuXONWZvTAzm4sX7XrpcDBk=;
        b=K/yYjljN0p3h6W4itG28Rd+zvssqw4hknet67mnkKRVdAslRTuntFHYj83UhRUf82+
         GSj+tNitWFCW6umpiiw+dhgoVrobT/5U+Qyxk3zJwz8VUjozpz4/M+X8q2lo32GWQGOs
         7gmL6l5XwVf1fwYUfSgisZsu1cnFzWOAyTqmklAVzvnejRgu1ynd7KZNcLhx04gffGHU
         CHpC9PANegVZM+El6DPrVlLcAIosXE2mB5tssppIXtIEftVY9noD8QTif6Wroj138pWt
         XlFFz+wihYewwdEn1bG50kpyaFnCv7AxFN+i9Ry4wgjr7POC3OhtpQWaoA/igETSM6fI
         7mTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794504843; x=1795109643; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uWCO9U1S7oEtPLhVHcm3UThVcb5j4V4ZNb8JTcZfX1k=;
        b=QO5mcJz/d13S0YL63ZpSWiXGSdFURRfU+mKvB43VXsxiQEcvXUsMyG2i3Uv8XF71fC
         uCjPtaloBWIOcWeZHIgt0H4Ux1iJDd6RYUO4CS28Z7QRcbG/0oUMwvNDkfq47iJJ9RqP
         omkx7euaqYa4mI9vgRVC/UZMHzY9QIMD8t+sR16NWjLN6Y6WnS8KRNFz2OUN2ZMiDPa2
         ab2d8q0e/H/RB/XEIygo0BrTf+PwETe2hVJvvphZilC4kaIUAncu3YZNI1n3RkCjw06N
         8+TexfEDI6rjuPpo83sARd7f5MBVibo/NfuCtd67QGJ/DXkGqFPUN95fjmErpqq0N4qO
         HjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504843; x=1795109643;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uWCO9U1S7oEtPLhVHcm3UThVcb5j4V4ZNb8JTcZfX1k=;
        b=TAUyewfEdtebZxl0timYO1NnUT68dtbzDKMBmKmvTJiO1Uh5aWDGudqC13oFoWAcxr
         h+SrcGXVDakomhiralsnOY/JCfFGa5K7aAblw+10ZUEvpsz0bXJzg6megJuXETd5mb2Y
         JP2iDC+aljYnFCG/hhr+MQtVmq6OAR4NWA0VyA8Jw7i+l/996zWT9x1OF7BvK0fCwFiB
         +zRDQ0RhRQzs+Gzf5p6+s7DjyxU/AgpNWKXwQlYgdVTKIytqyRsrgVK8fhFoQ8EOrgxW
         +rVm3dBHip9EcBR9rhE/kk5U82EXbduapv4C4qgy2HQwH7//lPHC/RpkG0PMuQXauNik
         8kMw==
X-Gm-Message-State: APuU4Z91E+9ApHpqyR6u85gneY0xc+tS1fs8lZVFn3IpbvhdtMb2Qmod
	cGNosgAxKLj0gmKxLjK9lWsQ7ZX1urEc/glssdqpYVNQ2p9gDz/AtUW+4AkSZdtTNeVKJljuCF4
	+if5hDePzf4/kf0ZruWiopBmthyr3VN5qPQ==
X-Gm-Gg: AYBFou3geLQyUeJQCUJaxdHRffqOVD85st/hQ1yfgoQ0X1bdQBU7h4UHSYVNeuGXuW3
	4W5IyHYI3pqADH2k/1+Cqv+ymGsyEl4sV6DnkI8PkzIGU7Nd4jvpbHYBeKN7mpA3NqNaTrJM4ox
	zDRqU2ibhrZjdAr+Rj1cyxLVRguXbF1FC5W7n5LuyRIoLKeR4FM4uzVnd8RZ+BsqFRba7mS34Fs
	FHGvQXJ9v7aKhH2cowM626sxBt0M9d7hYZsdrCA23+ZVurOAJ7/8ECQvRAvHfECQMIqDfybquMt
	yK5ZyQgWwWStP6nkoOSQra7K00fgwRh0pm+poCKpQ0a3lls749W/oBPXWhaiWlMFLSe5W3OysV1
	qeH3I0LnnOZWkdauWKfAcVEE9s/OTf2vporghW1yN4BWk+0EB202L8JABQyjHRiO0O6LRH3BXNR
	CSo2HWSDte0e3JqWRSa4UAID9pddUF+oD0EHeTnRuOEeXlgCarWnoAdN4xwcY=
X-Received: by 2002:a05:690e:4186:b0:67b:e31d:6eec with SMTP id
 956f58d0204a3-67d896a3f00mr67631d50.29.1794504842862; Thu, 12 Nov 2026
 09:34:02 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112170355.22011-1-pvbozhko@salutedevices.com> <20261112170355.22011-2-pvbozhko@salutedevices.com>
In-Reply-To: <20261112170355.22011-2-pvbozhko@salutedevices.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 12 Nov 2026 12:33:50 -0500
X-Gm-Features: AclHuK-7PYdfPF78DL4Qn39C5Za_6pA0f0vdrFZPQ8-jLJzgY6xrDwq7tfF58zY
Message-ID: <CABBYNZLQ2RahhF1iTJ2H7wLM=55NN4oaka6A2a2rd-muYis+Uw@mail.gmail.com>
Subject: Re: [RFC PATCH BlueZ 1/1] advertising: Fix double-free in client_free
To: Pavel Bozhko <pvbozhko@salutedevices.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On Thu, Nov 12, 2026 at 12:08=E2=80=AFPM Pavel Bozhko
<pvbozhko@salutedevices.com> wrote:
>
> Unregister, disconnect and a failed RegisterAdvertisement can all run
> before an earlier idle client_free(). Each of those paths queues its
> own idle free, and the second g_free(client->owner) aborts bluetoothd.
> A late MGMT add completion does the same while the client is still live.
>
> Watching the disconnect during registration (0d57c12f5aca) makes the
> overlap reachable before Add Advertising completes. Those paths still
> queue a free of their own.
>
> Destroy the client once. Later remove and add completions do nothing.
>
> Fixes: cf99200d1505 ("core/advertising: Implement RegisterAdvertisement")
> Assisted-by: Grok:4.7
> ---
>  src/advertising.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++---=
------
>  1 file changed, 52 insertions(+), 10 deletions(-)
>
> Not runtime tested. The 5.79 crash is client_free() at g_free(client->own=
er),
> reached from client_free_idle_cb().
>
> diff --git a/src/advertising.c b/src/advertising.c
> index 5c929d6c2..3e6155db0 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -88,6 +88,7 @@ struct btd_adv_client {
>         uint32_t max_interval;
>         int8_t tx_power;
>         mgmt_request_func_t refresh_done_func;
> +       bool pending_destroy;
>  };
>
>  struct dbus_obj_match {
> @@ -195,13 +196,43 @@ static void remove_advertising(struct btd_adv_manag=
er *manager,
>                         manager->mgmt_index, sizeof(cp), &cp, NULL, NULL,=
 NULL);
>  }
>
> +/*
> + * Queue client_free once. Later calls are ignored so remove and a late
> + * MGMT completion cannot free the client twice.
> + */
> +static bool client_destroy_start(struct btd_adv_client *client)
> +{
> +       if (client->pending_destroy)
> +               return false;
> +
> +       client->pending_destroy =3D true;
> +
> +       if (client->client) {
> +               g_dbus_client_set_proxy_handlers(client->client, NULL, NU=
LL,
> +                                                NULL, client);
> +               g_dbus_client_set_disconnect_watch(client->client, NULL,
> +                                                  NULL);
> +       }
> +
> +       if (client->proxy)
> +               g_dbus_proxy_set_property_watch(client->proxy, NULL, NULL=
);
> +
> +       if (client->add_adv_id) {
> +               mgmt_cancel(client->manager->mgmt, client->add_adv_id);
> +               client->add_adv_id =3D 0;
> +       }
> +
> +       g_idle_add(client_free_idle_cb, client);

Just store the return of g_idle_add and then check it to prevent it to
be scheduled twice, also if the client is freed directly it can then
just remove its id to abort the callback causing a user after free.

> +       return true;
> +}
> +
>  static void client_remove(struct btd_adv_client *client)
>  {
>         struct mgmt_cp_remove_advertising cp;
>
> -       g_dbus_client_set_proxy_handlers(client->client, NULL, NULL, NULL=
,
> -                                                                       c=
lient);
> -       g_dbus_client_set_disconnect_watch(client->client, NULL, NULL);
> +       if (!client_destroy_start(client))
> +               return;
>
>         cp.instance =3D client->instance;
>
> @@ -211,8 +242,6 @@ static void client_remove(struct btd_adv_client *clie=
nt)
>
>         queue_remove(client->manager->clients, client);
>
> -       g_idle_add(client_free_idle_cb, client);
> -
>         g_dbus_emit_property_changed(btd_get_dbus_connection(),
>                                 adapter_get_path(client->manager->adapter=
),
>                                 LE_ADVERTISING_MGR_IFACE, "SupportedInsta=
nces");
> @@ -1373,6 +1402,9 @@ static void add_client_complete(struct btd_adv_clie=
nt *client, uint8_t status)
>  {
>         DBusMessage *reply;
>
> +       if (client->pending_destroy)
> +               return;
> +
>         if (status)
>                 error("Failed to add advertisement: %s (0x%02x)",
>                                                 mgmt_errstr(status), stat=
us);
> @@ -1385,11 +1417,12 @@ static void add_client_complete(struct btd_adv_cl=
ient *client, uint8_t status)
>                 return;
>
>         if (status) {
> +               if (!client_destroy_start(client))
> +                       return;
> +
>                 reply =3D btd_error_failed(client->reg,
>                                         "Failed to register advertisement=
");
>                 queue_remove(client->manager->clients, client);
> -               g_dbus_client_set_disconnect_watch(client->client, NULL, =
NULL);
> -               g_idle_add(client_free_idle_cb, client);
>
>         } else {
>                 DBusMessageIter iter;
> @@ -1416,6 +1449,9 @@ static void add_adv_callback(uint8_t status, uint16=
_t length,
>         struct btd_adv_client *client =3D user_data;
>         const struct mgmt_rp_add_advertising *rp =3D param;
>
> +       if (client->pending_destroy)
> +               return;
> +
>         client->add_adv_id =3D 0;
>
>         if (status)
> @@ -1460,6 +1496,9 @@ static void add_adv_params_callback(uint8_t status,=
 uint16_t length,
>         unsigned int mgmt_ret;
>         dbus_int16_t tx_power;
>
> +       if (client->pending_destroy)
> +               return;
> +
>         client->add_adv_id =3D 0;
>
>         if (status)
> @@ -1634,15 +1673,18 @@ static void client_proxy_added(GDBusProxy *proxy,=
 void *data)
>         if (g_str_equal(interface, LE_ADVERTISEMENT_IFACE) =3D=3D FALSE)
>                 return;
>
> +       if (client->pending_destroy)
> +               return;
> +
>         reply =3D parse_advertisement(client);
>         if (!reply)
>                 return;
>
>         /* Failed to publish for some reason, remove. */
> -       queue_remove(client->manager->clients, client);
> -       g_dbus_client_set_disconnect_watch(client->client, NULL, NULL);
> +       if (!client_destroy_start(client))
> +               return;
>
> -       g_idle_add(client_free_idle_cb, client);
> +       queue_remove(client->manager->clients, client);
>
>         g_dbus_send_message(btd_get_dbus_connection(), reply);
>
> base-commit: 9659adb6819d7e0284d0d2ba226a3894423d8db4
> --
> 2.50.1 (Apple Git-155)
>
>


--=20
Luiz Augusto von Dentz
