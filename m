Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE1DA2A
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 Mar 2024 20:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710708305; cv=pass; b=Aa9VOIRaD0Ie487kBCVBKJX4sUypLP/0T9voGw9MmUZZ0C8ym1hDxHrUnPUfUL/AUTRrpeYume87j7IKWM1Ab5pPvDBH5jWHQQQTzH0XsrJftdUIkx6FROj8SHuj89vRdoLdRDqXAAG5EpKaFn/N+9fs/yR7UcfjSXSACH3W14M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710708305; c=relaxed/simple;
	bh=LXVk6AYpHByiFJ3zz7uskKd3dADjduoJAxGh8BmAssw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oyh2OJOSM96VtJ3djMqq765v/9MaFTk/VcORbRj12qyB7s1OSBURbQEb0MS4izPVlwHr0sNONHutYO8UWK0Z6YTFv9lKz4q+e4sgdDCPkl03z7/icUSF3ahHLeS14/n/ZVIm8XYDmgbWPWMUMIRME2c0gfgpIjPLN5l+UXAzDxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=pBFPOJxK; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="pBFPOJxK"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4TyVNP5GD2z49Q4P;
	Sun, 17 Mar 2024 22:44:53 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1710708295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c/zA6iomdaQL4hkUEXRAh5FVVm6k1JvTnuljVxsFJ+0=;
	b=pBFPOJxKIVSCrYK62I1IR0EAqPuPE+UtqKXJM2j4OS8En58hxhke/s2/U+zZCu8Zi1+GGe
	x01WiQKUC7mbA2mj4AyuyQMxHiLwDQho7ScsSKXaYSKFG0jbPWsg3hLcuQ13NaVGEBCfyc
	8voefMfHP7jCuYKhNp82NABCvAruHTcnDFYTgJLGbDCNzW1k64BQlEt2xPeOOh813I4NOZ
	RBEaRpcF/gjj2jdIOOPjRRze7RJFv40WwhEDBQeoZBxfgIXoBZltVfFrp/s7pvsbnFvrZy
	ZkCMIfkFerrKm31pAsqmH0+ZSMXn2ELA58wjh2vAI9vBokoqxIgZq0N21EOB9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1710708295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c/zA6iomdaQL4hkUEXRAh5FVVm6k1JvTnuljVxsFJ+0=;
	b=W83dcBWA5QA7iFK/GltTEVfR1F6QLS6HXQ+ZBiNctZSrNFuTfTCGwVgHfaIXl53tUFwEk3
	SYKAHHMlJJChLwSWncw00YBa26IrV2IDw4dh+CxAwgsMOKBamo1GF8bmdMUztgpnE2CQwT
	5cmmdTfRObgk5Ix/muw5umd5bV1dsg5rLp+fidxI21ORQXjyvr/b0IQPC29SxLwO+19zxY
	b6PvUtgC3ZFnyvk7+3Jt1UnW8xaZTx/cYThP+E1r8mFQnfGdRFQX6hs5w2ndSbKqtsK+tE
	H+49dvgw03j1NDL1xA+yYnSS4abk30Qma3HIKp8ziP8DO38BbJS8mIbPZxX3HA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1710708295; a=rsa-sha256;
	cv=none;
	b=cur3M6bm+cRkIgSMBWTAzEqkSAHc1FLl1FCGoVWrXp2tgJ4l+VBi3ifrVgR8iPvPK7Ut4t
	crKa6SHbllKjBemE0zR1NusyvnxmanpSRaV6xpUP8gnH28y8sqQ9P9YBlgM/RM7k2cIaoZ
	5zIM/hzC3/sT84N8HvgHG5pfQ5qcTAhKUx4LI6Mogj7J75xcVm0wkJu/n8h0akg/EBjlY1
	fZDxRKbyNNHlmSYr/4uHMtapqW5/6jeCVQmJzlI9ncfQplL4U/gZkhXt8eMKyC8SBNSIZ5
	n131CgDkCgf0HkuNixRYduCS+3G6keA+zhvCQK4ZpYVOI72ufCQKsTIVojIVOA==
Message-ID: <bdd892131d1cfac6c0f37e9cf48ba9fee8c0fc84.camel@iki.fi>
Subject: Re: [PATCH BlueZ] bap: handle ep or session freed before select_cb
 returns
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sun, 17 Mar 2024 22:44:51 +0200
In-Reply-To: <CABBYNZKHNyCLL+TrJKQLbbv7sRv7jTqSp3vKZP97kLtbFGJ3Ug@mail.gmail.com>
References: 
	<90670acf017c4fb5a4ef4dba4b666c1307e9de5c.1710602216.git.pav@iki.fi>
	 <CABBYNZKHNyCLL+TrJKQLbbv7sRv7jTqSp3vKZP97kLtbFGJ3Ug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Luiz,

su, 2024-03-17 kello 14:59 -0400, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Sat, Mar 16, 2024 at 11:24=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrot=
e:
> >=20
> > select_cb() callback is called when the sound server replies. However,
> > at that point the ep or session for which it was made may already be
> > gone if e.g. device disconnects or adapter is powered off.
> >=20
> > Track pending select_cb() callbacks, and mark them canceled when ep /
> > session goes away.
>=20
> Instead of marking them as canceled I guess we could actually cancel
> the ongoing operations which shall resulting in calling
> media_endpoint_cancel->dbus_pending_call_cancel which is what seems to
> trigger the crash, so perhaps we need cancel select or make
> pac->ops->clear cancel it implicitly, that said select doesn't involve
> the creation of any stream  so we might need to introduce
> bt_bap_select_cancel which would invoke pac->ops->clear then
> pac_clear->media_endpoint_cancel->dbus_pending_call_cancel, etc.

This probably needs adding pac_ops->cancel, and pac_ops->select shall
return unique id by which pac_ops->cancel can remove requests.

Removing all requests for LPAC e.g. as pac_ops->clear side effect
probably doesn't work, there can be simultaneous select() on same LPAC
for different devices=C2=A0and it should not cancel those.

I did not want to start with API redesign here, so it was not done like
that here.

>=20
> > Fixes crash:
> >=20
> > =3D=3D889897=3D=3DERROR: AddressSanitizer: heap-use-after-free
> > READ of size 8 at 0x60400006b098 thread T0
> >     #0 0x55aeba in setup_new profiles/audio/bap.c:840
> >     #1 0x562158 in select_cb profiles/audio/bap.c:1361
> >     #2 0x47ad66 in pac_select_cb profiles/audio/media.c:920
> >     #3 0x47661b in endpoint_reply profiles/audio/media.c:375
> >     ...
> > freed by thread T0 here:
> >     #0 0x7fd20bcd7fb8 in __interceptor_free.part.0
> >     #1 0x55f913 in ep_free profiles/audio/bap.c:1156
> >     #2 0x7d696e in remove_interface gdbus/object.c:660
> >     #3 0x7de622 in g_dbus_unregister_interface gdbus/object.c:1394
> >     #4 0x554536 in ep_unregister profiles/audio/bap.c:193
> >     #5 0x574455 in ep_remove profiles/audio/bap.c:2963
> >     #6 0x7f5341 in queue_remove_if src/shared/queue.c:279
> >     #7 0x7f5aba in queue_remove_all src/shared/queue.c:321
> >     #8 0x57452b in bap_disconnect profiles/audio/bap.c:2972
> >     #9 0x6cd107 in btd_service_disconnect src/service.c:305
> >     ...
> > previously allocated by thread T0 here:
> >     #0 0x7fd20bcd92ef in malloc
> >     #1 0x7f6e98 in util_malloc src/shared/util.c:46
> >     #2 0x560d28 in ep_register profiles/audio/bap.c:1282
> >     #3 0x562bdf in pac_register profiles/audio/bap.c:1386
> >     #4 0x8cc834 in bap_foreach_pac src/shared/bap.c:4950
> >     #5 0x8cccfc in bt_bap_foreach_pac src/shared/bap.c:4964
> >     #6 0x56330b in bap_ready profiles/audio/bap.c:1457
> >     ...
> > ---
> >  profiles/audio/bap.c | 81 ++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 70 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> > index 964ba9c21..6c74760c2 100644
> > --- a/profiles/audio/bap.c
> > +++ b/profiles/audio/bap.c
> > @@ -95,6 +95,12 @@ struct bap_ep {
> >         struct queue *setups;
> >  };
> >=20
> > +struct bap_select {
> > +       int ref_count;
> > +       struct bap_data *data;
> > +       struct bap_ep *ep;
> > +};
> > +
> >  struct bap_data {
> >         struct btd_device *device;
> >         struct btd_adapter *adapter;
> > @@ -107,8 +113,8 @@ struct bap_data {
> >         struct queue *snks;
> >         struct queue *bcast;
> >         struct queue *streams;
> > +       struct queue *selecting;
> >         GIOChannel *listen_io;
> > -       int selecting;
> >         void *user_data;
> >  };
> >=20
> > @@ -194,6 +200,14 @@ static void ep_unregister(void *data)
> >                                                 MEDIA_ENDPOINT_INTERFAC=
E);
> >  }
> >=20
> > +static void bap_cancel_select(void *data)
> > +{
> > +       struct bap_select *sel =3D data;
> > +
> > +       sel->data =3D NULL;
> > +       sel->ep =3D NULL;
> > +}
> > +
> >  static void bap_data_free(struct bap_data *data)
> >  {
> >         if (data->listen_io) {
> > @@ -210,6 +224,7 @@ static void bap_data_free(struct bap_data *data)
> >         queue_destroy(data->srcs, ep_unregister);
> >         queue_destroy(data->bcast, ep_unregister);
> >         queue_destroy(data->streams, NULL);
> > +       queue_destroy(data->selecting, bap_cancel_select);
> >         bt_bap_ready_unregister(data->bap, data->ready_id);
> >         bt_bap_state_unregister(data->bap, data->state_id);
> >         bt_bap_pac_unregister(data->bap, data->pac_id);
> > @@ -1148,11 +1163,21 @@ static const GDBusMethodTable ep_methods[] =3D =
{
> >         { },
> >  };
> >=20
> > +static void ep_cancel_select(void *data, void *user_data)
> > +{
> > +       struct bap_select *sel =3D data;
> > +
> > +       if (sel->ep =3D=3D user_data)
> > +               sel->ep =3D NULL;
> > +}
> > +
> >  static void ep_free(void *data)
> >  {
> >         struct bap_ep *ep =3D data;
> >         struct queue *setups =3D ep->setups;
> >=20
> > +       queue_foreach(ep->data->selecting, ep_cancel_select, ep);
> > +
> >         ep->setups =3D NULL;
> >         queue_destroy(setups, setup_free);
> >         free(ep->path);
> > @@ -1348,16 +1373,29 @@ static void bap_config(void *data, void *user_d=
ata)
> >         queue_foreach(ep->setups, setup_config, NULL);
> >  }
> >=20
> > +static void select_count(void *data, void *user_data)
> > +{
> > +       struct bap_select *sel =3D data;
> > +       int *count =3D user_data;
> > +
> > +       *count +=3D sel->ref_count;
> > +}
> > +
> >  static void select_cb(struct bt_bap_pac *pac, int err, struct iovec *c=
aps,
> >                                 struct iovec *metadata, struct bt_bap_q=
os *qos,
> >                                 void *user_data)
> >  {
> > -       struct bap_ep *ep =3D user_data;
> > +       struct bap_select *sel =3D user_data;
> > +       struct bap_data *data =3D sel->data;
> > +       struct bap_ep *ep =3D sel->ep;
> >         struct bap_setup *setup;
> > +       int count =3D 0;
> > +
> > +       if (!data || !ep)
> > +               err =3D ECANCELED;
> >=20
> >         if (err) {
> >                 error("err %d", err);
> > -               ep->data->selecting--;
> >                 goto done;
> >         }
> >=20
> > @@ -1366,16 +1404,23 @@ static void select_cb(struct bt_bap_pac *pac, i=
nt err, struct iovec *caps,
> >         setup->metadata =3D util_iov_dup(metadata, 1);
> >         setup->qos =3D *qos;
> >=20
> > -       DBG("selecting %d", ep->data->selecting);
> > -       ep->data->selecting--;
> > +       queue_foreach(data->selecting, select_count, &count);
> > +
> > +       DBG("selecting %d", count);
> >=20
> >  done:
> > -       if (ep->data->selecting)
> > +       if (sel->ref_count-- <=3D 1) {
> > +               if (data)
> > +                       queue_remove(data->selecting, sel);
> > +               free(sel);
> > +       }
> > +
> > +       if (!data || !queue_isempty(data->selecting))
> >                 return;
> >=20
> > -       queue_foreach(ep->data->srcs, bap_config, NULL);
> > -       queue_foreach(ep->data->snks, bap_config, NULL);
> > -       queue_foreach(ep->data->bcast, bap_config, NULL);
> > +       queue_foreach(data->srcs, bap_config, NULL);
> > +       queue_foreach(data->snks, bap_config, NULL);
> > +       queue_foreach(data->bcast, bap_config, NULL);
> >  }
> >=20
> >  static bool pac_register(struct bt_bap_pac *lpac, struct bt_bap_pac *r=
pac,
> > @@ -1420,8 +1465,21 @@ static bool pac_select(struct bt_bap_pac *lpac, =
struct bt_bap_pac *rpac,
> >         }
> >=20
> >         /* TODO: Cache LRU? */
> > -       if (btd_service_is_initiator(service))
> > -               bt_bap_select(lpac, rpac, &ep->data->selecting, select_=
cb, ep);
> > +       if (btd_service_is_initiator(service)) {
> > +               struct bap_select *sel;
> > +
> > +               sel =3D new0(struct bap_select, 1);
> > +               sel->ep =3D ep;
> > +               sel->data =3D ep->data;
> > +               sel->ref_count =3D 0;
> > +
> > +               bt_bap_select(lpac, rpac, &sel->ref_count, select_cb, s=
el);
> > +
> > +               if (sel->ref_count)
> > +                       queue_push_tail(ep->data->selecting, sel);
> > +               else
> > +                       free(sel);
> > +       }
> >=20
> >         return true;
> >  }
> > @@ -2495,6 +2553,7 @@ static struct bap_data *bap_data_new(struct btd_d=
evice *device)
> >         data->srcs =3D queue_new();
> >         data->snks =3D queue_new();
> >         data->bcast =3D queue_new();
> > +       data->selecting =3D queue_new();
> >=20
> >         return data;
> >  }
> > --
> > 2.44.0
> >=20
> >=20
>=20
>=20

