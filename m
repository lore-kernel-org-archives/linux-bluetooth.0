Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4C42230A
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17760F7
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 08:27:23 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id D0B21240106
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 17:27:20 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4STZZt0rZ3z9rxR;
	Mon, 13 Nov 2023 17:27:17 +0100 (CET)
Message-ID: <f0ad805e67aebe4d0a8ff72894ad245d19e2f8df.camel@iki.fi>
Subject: Re: [PATCH BlueZ 1/4] shared/bap: add bt_bap_stream_config_update
 for updating QoS choice
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 13 Nov 2023 16:27:17 +0000
In-Reply-To: <CABBYNZKFP9SiEcrcNM3ASRXmDqt2+CUngEpMFaMtrBymq5u28Q@mail.gmail.com>
References: 
	<b48261aeab5a4f5927c9da5296b2ffb079bee375.1699802164.git.pav@iki.fi>
	 <CABBYNZKFP9SiEcrcNM3ASRXmDqt2+CUngEpMFaMtrBymq5u28Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Luiz,

ma, 2023-11-13 kello 10:39 -0500, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Sun, Nov 12, 2023 at 11:00=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrot=
e:
> >=20
> > Add bt_bap_stream_config_update for updating the QoS while in Codec
> > Configured state.
> > ---
> >  src/shared/bap.c | 18 ++++++++++++++++++
> >  src/shared/bap.h |  3 +++
> >  2 files changed, 21 insertions(+)
> >=20
> > diff --git a/src/shared/bap.c b/src/shared/bap.c
> > index 13bbcf793..d90e39f7c 100644
> > --- a/src/shared/bap.c
> > +++ b/src/shared/bap.c
> > @@ -4600,6 +4600,24 @@ unsigned int bt_bap_stream_config(struct bt_bap_=
stream *stream,
> >         return 0;
> >  }
> >=20
> > +int bt_bap_stream_config_update(struct bt_bap_stream *stream,
> > +                                       struct bt_bap_qos *qos)
> > +{
> > +       if (!bap_stream_valid(stream))
> > +               return -EINVAL;
> > +
> > +       if (stream->ep->state !=3D BT_BAP_STREAM_STATE_CONFIG)
> > +               return -EINVAL;
> > +
> > +       switch (bt_bap_stream_get_type(stream)) {
> > +       case BT_BAP_STREAM_TYPE_UCAST:
> > +               stream->qos =3D *qos;
> > +               return 0;
> > +       }
> > +
> > +       return -EINVAL;
> > +}
> > +
> >  static bool match_pac(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac=
,
> >                                                         void *user_data=
)
> >  {
> > diff --git a/src/shared/bap.h b/src/shared/bap.h
> > index 23edbf4c6..099c2edd0 100644
> > --- a/src/shared/bap.h
> > +++ b/src/shared/bap.h
> > @@ -255,6 +255,9 @@ unsigned int bt_bap_stream_config(struct bt_bap_str=
eam *stream,
> >                                         bt_bap_stream_func_t func,
> >                                         void *user_data);
> >=20
> > +int bt_bap_stream_config_update(struct bt_bap_stream *stream,
> > +                                       struct bt_bap_qos *pqos);
> > +
>=20
> Can't we just make bt_bap_stream_config do update the config in case
> it is for a broadcast? At least to me it seems a much cleaner approach
> then starting introducing new functions where the user needs to know
> when they should be called, etc.

This is used for updating the QoS for unicast, when the stream has
already the right caps, and we are not going to send another Config
Codec.

For unicast we can avoid adding this function, but it makes
bap_create_io more complicated as it then cannot get the stream QoS we
want to use from bt_bap_stream, and we have to explicitly deal with the
linked stream QoS in profiles/media/bap.c.

We also cannot use bt_bap_stream_qos to update the QoS in this case,
because the IO has to be created first (with the right QoS), so we
first get the auto-allocated CIG/CIS from kernel, and only after that
send Config QoS to the ASE.

In principle we can have bt_bap_stream_config only update the QoS for
unicast if the config is already right.=C2=A0This is probably not good,
since whether you get ASE event then depends, and caller has to check
first.

Or we could have bt_bap_stream_config(stream, &qos, NULL, NULL, NULL)
do what bt_bap_stream_config_update does here.

Not sure what you prefer.

(v2 is anyway necessary here, we need to check linked streams first
before proceeding to QoS.)

***

For broadcast some of the cases where bt_bap_stream_config is called is
probably meant to only update the QoS only like here.

But there I think the transport creation gets a bit tangled, as
sometimes it's done in bt_bap_stream_config and sometimes as a side
effect in bt_bap_stream_set_user_data...

>=20
> >  unsigned int bt_bap_stream_qos(struct bt_bap_stream *stream,
> >                                         struct bt_bap_qos *qos,
> >                                         bt_bap_stream_func_t func,
> > --
> > 2.41.0
> >=20
> >=20
>=20
>=20

--=20
Pauli Virtanen
