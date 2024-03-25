Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C047EEF8
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 17:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387759; cv=none; b=AumjNNf+pmFgnZst/EUhzLjJVamonfjN8lw3nsg52/hVLEpU5X1k8CFSPWy7Dj79dYHyLSXblp9qKqO2XfiYOhZB8maNDsmsKhBxcE4MpBK+79hSfzhSKnehsxHfckm2LP1MOUHVaNTueFDiv2XzZ4hjw1rxTCcQCaCU1RA5jGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387759; c=relaxed/simple;
	bh=2g08vnB6r2yUvYTBLanqRE6XdLCWcsvzeJvqWurSxEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZGPaiKBcVuqrnO/1sqeXC8+pLgM2OEC6xQLsKwOZXoKJ1wnL7HZPXpUrj73aFz4NiKq/iTQ+Zfv32ZcPB9QOv/HPqz78kaviYlxH+0EEfGxQ9jI1aj584iiei1uUcxZV9hYqBISk0ft+CFhYQk/mi+P23o6DUsgboGqY4bWQHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRSKD8Vi; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRSKD8Vi"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d6a1ad08b8so64144581fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 10:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711387756; x=1711992556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1dEO1l3rnc/UXlSS9Dv5fFKSttuPOhRT7eCF41DP68=;
        b=VRSKD8VixVitZ/0DxJZ3ZpfB8VT+cSUuvtboVeuZy4Jyx7aFTKxTntUzVWexI0ec6T
         XxT2rc1TYT9VFAhEl+dxbbu5YgchkvHj10uUM+z5odHiAiihRtZw1Xzou/pPLJMJBxa2
         xw+RXN37Z8HCDtAd/8lebcryE6KuMkyIkogsGGKegF7XusSh2jmo8zOrGEALnX8XVjFl
         otm/IGgmfQUR7J8p7ZnhDnnL364nf7TRymi8I8AHFa+qbWBj7st9a1mEn+Ihcgzrdyy+
         8EdV9JURhKlkOwdZD7/CHTnYupVbstqiFJRS+3pjaJzZnAyM9QFFKxG55iHqUsUpH4Vw
         Ykhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711387756; x=1711992556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1dEO1l3rnc/UXlSS9Dv5fFKSttuPOhRT7eCF41DP68=;
        b=BrDAzxwhE1rT29p7eOz6m8w4upZCA8RuLQ19hWZLKd9sCZhlbEZxdSpiHJdJIN3MQG
         xxFCJMbZ0N92cxlZBLzTxQup1iW/iVar2tUIrKT+eFZiy3PgJCVtEeJoEnXSlEALPpK0
         X0YNcFDLZhjPgM9Fl4E6uGbFxKcTXkmax1JVzHKDBVny+aiwIuSfkxZ59XrcTWrGbmw+
         hXGJni4oCb71X5sRuIslV9Bv5KP2eQsTG9ReHqBlZn3ic3rNJ+DZs5UbY/xWzdywPZG1
         +hP4AgZabQMddHt1rU+s/dnaFpvDl/cq+3iE2+QKZxn3YTxMJZpEIGSj8Eq1BArgYo1k
         onOQ==
X-Gm-Message-State: AOJu0Yzv+FggXWH52gU65wQeKNWqUNCTWPdguCNirCXPMjq8owWG9zPw
	w8GwtceVmLhlJaEU0ZhQNXuBIU4PKafMvA+k9fX4f4V1QzSxqcdLUROF5nTgHvbioGZiCoDECGm
	lIGn8Y36NGfdTbmRh0tn1LvumlbL0X/mp
X-Google-Smtp-Source: AGHT+IGEekGA6N3DnGz4BrhsHRxKM25YL5kRfib/TQDqo5of7kEFLoG6MZE2hbZaMTshVn/7UMBgf8YS43Yjr+PTdwI=
X-Received: by 2002:a2e:8e86:0:b0:2d4:8fd0:b5f2 with SMTP id
 z6-20020a2e8e86000000b002d48fd0b5f2mr5344830ljk.7.1711387755771; Mon, 25 Mar
 2024 10:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <afc30fd4d201bdd92ffbc682ac66f472ce837814.1711186824.git.pav@iki.fi>
 <ad76621e8c2d414989b4eb384cb9077ca55cb16d.1711186824.git.pav@iki.fi>
In-Reply-To: <ad76621e8c2d414989b4eb384cb9077ca55cb16d.1711186824.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 25 Mar 2024 13:29:03 -0400
Message-ID: <CABBYNZJj2wt-xEu6_ZPz=uUHwy8s1eJSS85tWuc9_8V8xXnoxQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 2/2] bap: cancel ongoing SelectProperties()
 before freeing the ep
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sat, Mar 23, 2024 at 5:40=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> select_cb() callback is called when the sound server replies. However,
> at that point the ep or session for which it was made may already be
> gone if e.g. device disconnects or adapter is powered off.
>
> Fix by implementing cancelling select() callbacks, and doing it before
> freeing ep.
>
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
>  profiles/audio/bap.c   | 22 ++++++++++++++++++++++
>  profiles/audio/media.c | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
>
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index 315eff729..fdce275c9 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -1148,11 +1148,15 @@ static const GDBusMethodTable ep_methods[] =3D {
>         { },
>  };
>
> +static void ep_cancel_select(struct bap_ep *ep);
> +
>  static void ep_free(void *data)
>  {
>         struct bap_ep *ep =3D data;
>         struct queue *setups =3D ep->setups;
>
> +       ep_cancel_select(ep);
> +
>         ep->setups =3D NULL;
>         queue_destroy(setups, setup_free);
>         free(ep->path);
> @@ -1426,6 +1430,24 @@ static bool pac_select(struct bt_bap_pac *lpac, st=
ruct bt_bap_pac *rpac,
>         return true;
>  }
>
> +static bool pac_cancel_select(struct bt_bap_pac *lpac, struct bt_bap_pac=
 *rpac,
> +                                                       void *user_data)
> +{
> +       struct bap_ep *ep =3D user_data;
> +
> +       bt_bap_cancel_select(lpac, select_cb, ep);
> +
> +       return true;
> +}
> +
> +static void ep_cancel_select(struct bap_ep *ep)
> +{
> +       struct bt_bap *bap =3D ep->data->bap;
> +
> +       bt_bap_foreach_pac(bap, BT_BAP_SOURCE, pac_cancel_select, ep);
> +       bt_bap_foreach_pac(bap, BT_BAP_SINK, pac_cancel_select, ep);
> +}
> +
>  static bool pac_found_bcast(struct bt_bap_pac *lpac, struct bt_bap_pac *=
rpac,
>                                                         void *user_data)
>  {
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index edaff7867..3c5daf782 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -149,6 +149,11 @@ static void media_endpoint_cancel(struct endpoint_re=
quest *request)
>  {
>         struct media_endpoint *endpoint =3D request->endpoint;
>
> +       DBG("Canceling %s: name =3D %s path =3D %s",
> +                       dbus_message_get_member(request->msg),
> +                       dbus_message_get_destination(request->msg),
> +                       dbus_message_get_path(request->msg));
> +
>         if (request->call)
>                 dbus_pending_call_cancel(request->call);
>
> @@ -1028,6 +1033,30 @@ static int pac_select(struct bt_bap_pac *lpac, str=
uct bt_bap_pac *rpac,
>                                                                 data, fre=
e);
>  }
>
> +static void pac_cancel_select(struct bt_bap_pac *lpac, bt_bap_pac_select=
_t cb,
> +                                               void *cb_data, void *user=
_data)
> +{
> +       struct media_endpoint *endpoint =3D user_data;
> +       GSList *l;
> +
> +       for (l =3D endpoint->requests; l; l =3D g_slist_next(l)) {
> +               struct endpoint_request *req =3D l->data;
> +               struct pac_select_data *data;
> +
> +               if (req->cb !=3D pac_select_cb)
> +                       continue;
> +
> +               data =3D req->user_data;
> +               if (data->pac !=3D lpac || data->cb !=3D cb ||
> +                                               data->user_data !=3D cb_d=
ata)
> +                       continue;
> +
> +               req->cb =3D NULL;
> +               media_endpoint_cancel(req);
> +               l =3D endpoint->requests;

We probably want to do the l =3D g_gslist_next assignment inside the for
loop to guarantee the requests list in not freed in the process.

> +       }
> +}
> +
>  struct pac_config_data {
>         struct bt_bap_stream *stream;
>         bt_bap_pac_config_t cb;
> @@ -1195,6 +1224,7 @@ static void pac_clear(struct bt_bap_stream *stream,=
 void *user_data)
>
>  static struct bt_bap_pac_ops pac_ops =3D {
>         .select =3D pac_select,
> +       .cancel_select =3D pac_cancel_select,
>         .config =3D pac_config,
>         .clear =3D pac_clear,
>  };
> --
> 2.44.0
>
>


--=20
Luiz Augusto von Dentz
