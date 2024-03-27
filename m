Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19274E1C8
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561697; cv=pass; b=DoYrouOTy2244TIWN4X6hBMqn1xcKQ7JKaztDFbAp5yWmd5AMD8o/cjOJln+LeoDwQMB9V1UA0K6zZfV9JQ1L0vhMBxtXFJuUogdKBCEg9x4Z1gtQAqpo2NBDuf2bLe69Cu7NiZ0nMHpqnNO1dIvhBW/Yj9ZCeDcz+UO+aGIO/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561697; c=relaxed/simple;
	bh=65f87D93HOxCkJxeE52Lp1dnj2szf9UN74cOh+MAr0I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wzx6743GTORHDwDw1vlPtA9ennJobvvNI7YFOVlHByar0ok7iU7+AWeHKp5dnBY/pdB+DQ5RziCyzHMcmojt2/jclrSJAErWwuSWUI8JaBoXCX+5I8eZSn3ncS5/CVL913X2dbkJMlbPJhr27i51+Z+BSTnQzhlCTZYBoGyXeKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=qy1X3yXS; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="qy1X3yXS"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4V4Yzl58qVz49Q5L;
	Wed, 27 Mar 2024 19:48:03 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1711561685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=j9EA0UExgbX1WInt5ZoJG2EjPTuGDFnMzq9wnkLXeNE=;
	b=qy1X3yXSMGELupoGNslmEot97BjN4BgFcHpNsgxmapv/5l6p4lOGzFGHatqn86hRdxSU2s
	Ok35R05R0pEgixzzOwZW4uoico+uZWOtNRVZUn5W8G611SxRNld8IVPdFGfXsuma+O9WdA
	XmAqIEGKcZO4x3VyjNQO0isFAV2U7xPOyTdk3885lu/uS0wwZwFVnP49iNzdu3M2gyQC6Y
	9n+vOL77AeqzVfYCcSsaWru12G8UIjyoDWZD6ZQfQCqjZwC2/u4YTi9O0t1mZpl9fU/R6y
	91SqcSrOtEnn5BGoBskepfO28jjYCtIDU6kf3f7tAQ9TO5ejGzre7obK4/HPvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1711561685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=j9EA0UExgbX1WInt5ZoJG2EjPTuGDFnMzq9wnkLXeNE=;
	b=aEjcQo3Ib5+v14knz0eW0WW3i4X3hhrziuxGptclaL9RtsAU3G9sQ+WRSh/8TaYNQJPxG2
	r6zITj3IHJLboUDvpAolKk/OUw4TCQFQo3h3iNeh24stCvAH7Jry1oOZ9VGxeZFa1lX1n8
	QzdmY9HhCV5XqyCJX+qWKN0sfEC7Fh0gvaE8CPvUGYLtB9LUZnyW5Lg6M1ZET3RBxLTft1
	JG5a2QbHPkMtuxPfnZaIHwRnIs+Rvpeakm/CCFLCcl5IBmxfR9wMQfn5rhP9K5W2exdKlK
	lgYZNZQLeXXHzvITdXZCuc/ewcfO5Dj/iduvIJjF2iEHaegaLcbO0DSpdL1f5g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1711561685; a=rsa-sha256;
	cv=none;
	b=nQDy7yDYJB06GoVIpZmzcV5ft39fEHfurFFdu/l0CuDFxe0RfmfbxDSiS70co0YuqZYdKu
	vJW+udmqHUPo32x5kE9N8iu4sJ+lYAGuABXNtsPbDu1PeZf+S0ZRgDjSJPhrUCGcmAC/uR
	zaXj+vkA8qRITWoA/OU+Gx4QWGQyWzODHnmN4Buqt7WNi/yN1FZEDsP0+d1l9sj9MjVugu
	zThAwJXtMeWzfMkoNLelU9lr50muDepJyZW4HahdMEaQAOeVAIjbVD+xEy/qz20pz2n4xi
	r8S8zTMrqJThLy5jFqZwIojU6mdJYXW5WvmNWm+BMHSfXM7LEtsix7CAsxj/ww==
Message-ID: <0b191e2c9773ab6d559bd8d72ae36c509c02999b.camel@iki.fi>
Subject: Re: [PATCH BlueZ 2/2] iso-tester: Separate iso_defer_accept into
 dedicated functions
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Iulia Tanasescu
	 <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com, 
 mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
 vlad.pruteanu@nxp.com,  andrei.istodorescu@nxp.com
Date: Wed, 27 Mar 2024 19:48:01 +0200
In-Reply-To: <CABBYNZJZQf8uvyNzHiqOo4UqwdYb+OEyBZvt1EHvEd3h7t1CMQ@mail.gmail.com>
References: <20240327161019.3078-1-iulia.tanasescu@nxp.com>
	 <20240327161019.3078-3-iulia.tanasescu@nxp.com>
	 <CABBYNZJZQf8uvyNzHiqOo4UqwdYb+OEyBZvt1EHvEd3h7t1CMQ@mail.gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Luiz & al.,

ke, 2024-03-27 kello 12:50 -0400, Luiz Augusto von Dentz kirjoitti:
> On Wed, Mar 27, 2024 at 12:10=E2=80=AFPM Iulia Tanasescu
> <iulia.tanasescu@nxp.com> wrote:
> >=20
> > This separates the iso_defer_accept function into dedicated ones for
> > unicast/broadcast, since the flow is different for each scenario:
> > For unicast, POLLOUT is checked on socket before calling read and
> > adding a G_IO_OUT watch. Checking for POLLOUT is not necessary for
> > broadcast, since currently this event is never generated on the
> > child socket. Instead, G_IO_IN is generated after BIG sync is
> > established and a BIS socket is ready to be accepted.
>=20
> @Pauli Virtanen Is this inline with TX Timestamping though? Or that
> only cares for POLLERR?

AFAICS this won't interact with TX timestamping. The timestamping only
cares about MSG_ERRQUEUE which is not touched here, and also the setup
here seems to concern what happens before user sends payloads, so
before there is going to be any timestamps.

> Also it would be great to know what are the plans of PW with respect
> to broadcast, I was thinking something like this:
>=20
> 1. Broadcast Source: Have some dedicated card that can be configured
> via configuration file or a dedicated app that performs the
> configuration which can then select what streams shall be broadcasted,
> since broadcasting things like system audio notifications probably
> doesn't make much sense.
> 2. Broadcast Sink: This shall be a little bit easier since we now
> enumerate the BASE found over the air, so it should work very closely
> to unicast, but perhaps you may also want to start a scan session
> while the card selection dialog is open so the user don't need to use
> yet another app to trigger it, or perhaps this should really be done
> at Bluetooth system settings that way PW don't show any Broadcast Sink
> until the user selects it at Bluetooth APP, this way we don't clutter
> PW interface with unsynchronized Broadcast Sinks. Note that in the
> future we are going to remove the step of creating a MediaEndpoint for
> Sinks since they are already configured over the air they shall appear
> as MediaTransports ready to be Acquired.

I've been waiting for the BlueZ side of it to settle down a bit. (I
note the BlueZ broadcast API is not documented, would be great if the
.rst docs would be updated too in the patches.) It would also be great
if there is some way to test all this locally, we've merged patches
from Silviu for broadcast sink, but I have myself only looked that it
should be OK in theory.


For Broadcast Source:

The plan here would be to add first some support that we can create and
destroy broadcast source MediaEndpoints on the fly, and then wire it up
to the runtime setting system we have, so user can create and remove
endpoints without having to restart daemons to reload configs.

Generally they would appear to user applications in similar way as
network audio sinks, there's established way how all this goes.

The fact that it has to be via the same DBus connection as the rest is
a bit inconvenient, but can be dealt with.

Ideally the BlueZ DBus API would be such that there could also be a
dedicated "broadcast" application that can send streams, without
needing to interact with the sound server, and also allowing a sound
server to be running its own broadcast sources if any simultaneously.


For Broadcast Sink:

We are going to expose whatever we see over the DBus API to the user as
audio sources, which can be connected where they want to, and will be
acquired when connected.

For controlling the scanning of the broadcast streams, and which
streams are going to be synced to: It feels a bit orthogonal to the job
of a sound server. We could in principle do it. The BT Controller would
appear a sound card object, and it would have additional properties
that would list the available streams, and one poke e.g. with
Pipewire's command line tools to sync to specific streams.

This would be inventing an API to do something that might in principle
also be DBus API in BlueZ.

I guess a question for both source and sink is whether the sound server
should do the whole thing, or only be responsible for the routing of
audio, with things like configuring BASE or selecting which streams to
sync being an orthogonal DBus API (which could then be controlled by
the sound server, or by a dedicated app which could then either
implement its own audio transports or leave it the audio transport part
to the sound server).

>=20
> > ---
> >  tools/iso-tester.c | 45 +++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 35 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/tools/iso-tester.c b/tools/iso-tester.c
> > index 1864b9e9d..60afef301 100644
> > --- a/tools/iso-tester.c
> > +++ b/tools/iso-tester.c
> > @@ -4,7 +4,7 @@
> >   *  BlueZ - Bluetooth protocol stack for Linux
> >   *
> >   *  Copyright (C) 2022  Intel Corporation.
> > - *  Copyright 2023 NXP
> > + *  Copyright 2023-2024 NXP
> >   *
> >   */
> >=20
> > @@ -489,6 +489,8 @@ struct iso_client_data {
> >         bool pa_bind;
> >  };
> >=20
> > +typedef bool (*iso_defer_accept_t)(struct test_data *data, GIOChannel =
*io);
> > +
> >  static void mgmt_debug(const char *str, void *user_data)
> >  {
> >         const char *prefix =3D user_data;
> > @@ -2582,11 +2584,10 @@ static void setup_listen(struct test_data *data=
, uint8_t num, GIOFunc func)
> >         }
> >  }
> >=20
> > -static bool iso_defer_accept(struct test_data *data, GIOChannel *io)
> > +static bool iso_defer_accept_bcast(struct test_data *data, GIOChannel =
*io)
> >  {
> >         int sk;
> >         char c;
> > -       struct pollfd pfd;
> >         const struct iso_client_data *isodata =3D data->test_data;
> >         struct sockaddr_iso *addr =3D NULL;
> >=20
> > @@ -2610,6 +2611,31 @@ static bool iso_defer_accept(struct test_data *d=
ata, GIOChannel *io)
> >                 free(addr);
> >         }
> >=20
> > +       if (read(sk, &c, 1) < 0) {
> > +               tester_warn("read: %s (%d)", strerror(errno), errno);
> > +               return false;
> > +       }
> > +
> > +       tester_print("Accept deferred setup");
> > +
> > +       data->io_queue =3D queue_new();
> > +       if (data->io_queue)
> > +               queue_push_tail(data->io_queue, io);
> > +
> > +       data->io_id[0] =3D g_io_add_watch(io, G_IO_IN,
> > +                               iso_accept_cb, NULL);
> > +
> > +       return true;
> > +}
> > +
> > +static bool iso_defer_accept_ucast(struct test_data *data, GIOChannel =
*io)
> > +{
> > +       int sk;
> > +       char c;
> > +       struct pollfd pfd;
> > +
> > +       sk =3D g_io_channel_unix_get_fd(io);
> > +
> >         memset(&pfd, 0, sizeof(pfd));
> >         pfd.fd =3D sk;
> >         pfd.events =3D POLLOUT;
> > @@ -2632,12 +2658,8 @@ static bool iso_defer_accept(struct test_data *d=
ata, GIOChannel *io)
> >         if (data->io_queue)
> >                 queue_push_tail(data->io_queue, io);
> >=20
> > -       if (isodata->bcast)
> > -               data->io_id[0] =3D g_io_add_watch(io, G_IO_IN,
> > -                                       iso_accept_cb, NULL);
> > -       else
> > -               data->io_id[0] =3D g_io_add_watch(io, G_IO_OUT,
> > -                                       iso_connect_cb, NULL);
> > +       data->io_id[0] =3D g_io_add_watch(io, G_IO_OUT,
> > +                               iso_connect_cb, NULL);
> >=20
> >         return true;
> >  }
> > @@ -2648,6 +2670,9 @@ static gboolean iso_accept_cb(GIOChannel *io, GIO=
Condition cond,
> >         struct test_data *data =3D tester_get_data();
> >         const struct iso_client_data *isodata =3D data->test_data;
> >         int sk, new_sk;
> > +       iso_defer_accept_t iso_accept =3D isodata->bcast ?
> > +                                               iso_defer_accept_bcast =
:
> > +                                               iso_defer_accept_ucast;
> >=20
> >         data->io_id[0] =3D 0;
> >=20
> > @@ -2676,7 +2701,7 @@ static gboolean iso_accept_cb(GIOChannel *io, GIO=
Condition cond,
> >                                 return false;
> >                 }
> >=20
> > -               if (!iso_defer_accept(data, io)) {
> > +               if (!iso_accept(data, io)) {
> >                         tester_warn("Unable to accept deferred setup");
> >                         tester_test_failed();
> >                 }
> > --
> > 2.39.2
> >=20
>=20
>=20

--=20
Pauli Virtanen
