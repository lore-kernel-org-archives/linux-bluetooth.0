Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69012C05027
	for <linux-bluetooth@archiver.kernel.org>; Sun, 12 Feb 2023 21:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjBLVu2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 12 Feb 2023 16:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjBLVu0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 12 Feb 2023 16:50:26 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDC1EB76
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Feb 2023 13:50:24 -0800 (PST)
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by lahtoruutu.iki.fi (Postfix) with ESMTPS id C3DC51B0019D
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Feb 2023 23:50:21 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1676238621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u91KQqnOBPehfo14P7aJNvPWhs+DRxuiay+Yz81zvmg=;
        b=ZTKmIS2C8E3cAXKJA+tvOY3EVBmBvuz5LOrcuJdX6+NuHmcbbMtihKqHgmXm936qJg92LK
        vB9uTrhhLryWkoVylUE5vT5bcM22dDMCFirbMgdnm6o80UP3erhCKV++SDq6YNU5bIKPrs
        AOlugLeK+3XOYVAbqsVFutVgwEJ0Rr6/CVLldLKJeP+TswqPj3lgEBFz7m6zm0lf9rmeXX
        X1pNtgLdoQIBDEEqr5Eb7rxKexUlokHiOg9XMxoeGxWZTQlIID9Q2WUXPZaE/tRX6/Dta6
        BXH4K/EijahkS/VY/S/c/SngX+tULEPW3Gz/UN4FezP/Ll4dJKNq2VlaQxctLw==
Received: from [192.168.1.195] (91-152-123-43.elisa-laajakaista.fi [91.152.123.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav@iki.fi)
        by meesny.iki.fi (Postfix) with ESMTPSA id 5D31B2014C;
        Sun, 12 Feb 2023 23:50:16 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1676238616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u91KQqnOBPehfo14P7aJNvPWhs+DRxuiay+Yz81zvmg=;
        b=u7Tq0RNkFKDhJiZiPyWxGmXafatcJCho6vqi6I8mo7NMsG+Oq8yN9erqjlXj2no4HAl3U7
        UfjjpbTq4BY9/Fkr1teDh92StJCyZBfR1u2GVYgpC2vl9Sddi5HwuO3yGrmFdSjewwBIFY
        StuqdyNkJeo4o49LHrY2VJHjATdWcmA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1676238616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u91KQqnOBPehfo14P7aJNvPWhs+DRxuiay+Yz81zvmg=;
        b=XfL374PhdFciP4ZRFXYgapkaf0D+VCHDApiF58Y7fCEwbQuO8aHdXJ1vb1vqyRkBD5jSmw
        dzXjKxX5l9G/7fDhtCw9Rn2HwyBWU6Vc32vQJt31D8ynMzeZzDzGtYzS0StN5zZ2Im754W
        jrkToSglieD9452yhR/EUnAuHfkS8Fc=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1676238616; a=rsa-sha256; cv=none;
        b=dOqW2XuYGTd4ny8vZyeyIlPDkfaVKAAwrJw2hNyRiy3UF0xaN63BPjQryvVuvXf6sBN4xp
        lqA2tyh8qLa/hOCdlF0KkLuwJwzQRMiyuRWJRd8MMcciTdLwpULwNLTBitL4sAwuAaL/Qv
        /UK3pKULP8V1DSMcGOImUFpt3NoIBnI=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <44b314270316b24f86b2439ac9433f162e4ce9bd.camel@iki.fi>
Subject: Re: [PATCH BlueZ] shared/bap: wait for GATT client ready before
 ASCS/PACS discovery
From:   Pauli Virtanen <pav@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Date:   Sun, 12 Feb 2023 23:49:47 +0200
In-Reply-To: <CABBYNZLD4CLCRSeKWj=Mb08Q9_TwkOZB0t-mUEpsT0ghDHpWBw@mail.gmail.com>
References: <98ccef96a4b719599c0fb1d085c7239a12d2ed8c.1676226143.git.pav@iki.fi>
         <CABBYNZLD4CLCRSeKWj=Mb08Q9_TwkOZB0t-mUEpsT0ghDHpWBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

su, 2023-02-12 kello 12:45 -0800, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Sun, Feb 12, 2023 at 10:41 AM Pauli Virtanen <pav@iki.fi> wrote:
> >=20
> > BAP client fails to find endpoints if GATT services are not resolved
> > when the GATT client is attached to the session.  This condition
> > almost always occurs on the first BAP connection to a device between
> > bluetoothd restarts, and may occur also otherwise.
>=20
> Hmm, this shouldn't happen if you have caching enabled, did you
> disable it for some reason?

Caching has not been disabled. The files in /var/lib/bluetooth/*/cache
also get updated so presumably it is working.

> > The BAP client code discovers ASCS/PACS services and characteristics at
> > client attach time.
> >=20
> > Fix the connection issue by postponing PAC/ASE discovery until the
> > GATT client is ready, if it was not ready at attach time.
>=20
> This should probably be done by the core, it should check if the
> services are cached then it can call accept, otherwise it needs to
> wait for the client to be ready, perhaps there is something not quite
> right with the way to probe services as afaik if we don't have any
> cache the driver shouldn't have been called to begin with.

bap_accept gets called from

#0  bap_accept (service=3D0x604000005f50) at profiles/audio/bap.c:1304
#1  0x0000000000631755 in service_accept (service=3D0x604000005f50, initiat=
or=3Dtrue) at src/service.c:203
#2  0x0000000000668561 in device_accept_gatt_profiles (device=3D0x617000000=
080) at src/device.c:3739
#3  0x0000000000676128 in gatt_client_init (device=3D0x617000000080) at src=
/device.c:5161
#4  0x00000000006782e5 in device_attach_att (dev=3D0x617000000080, io=3D0x6=
0c00000b2c0) at src/device.c:5331
#5  0x00000000006788e5 in att_connect_cb (io=3D0x60c00000b2c0, gerr=3D0x0, =
user_data=3D0x617000000080) at src/device.c:5378
#6  0x000000000053de23 in connect_cb (io=3D0x60c00000b2c0, cond=3DG_IO_OUT,=
 user_data=3D0x60300001f8d0) at btio/btio.c:229
#7  0x00007f4955d16cbf in g_main_context_dispatch () from target:/lib64/lib=
glib-2.0.so.0
#8  0x00007f4955d6c598 in g_main_context_iterate.constprop () from target:/=
lib64/libglib-2.0.so.0
#9  0x00007f4955d1628f in g_main_loop_run () from target:/lib64/libglib-2.0=
.so.0
#10 0x00000000007df9ca in mainloop_run () at src/shared/mainloop-glib.c:66
#11 0x00000000007e075a in mainloop_run_with_signal (func=3D0x558597 <signal=
_callback>, user_data=3D0x0) at src/shared/mainloop-notify.c:188
#12 0x0000000000558e97 in main (argc=3D1, argv=3D0x7ffd399f7788) at src/mai=
n.c:1304

which does not wait for GATT client ready. The comment above that

5157=E2=94=82         /*
5158=E2=94=82          * Notify notify existing service about the new conne=
ction so they can
5159=E2=94=82          * react to notifications while discovering services
5160=E2=94=82          */

looks like this is intentional. If it's like this, then services would
need to explicitly wait.

Didn't look yet how come it knows the gatt service is there then,
however I guess it only looks for the PACS service uuid, as I think
nothing tells device.c also ASCS would be needed.

Best,
Pauli

>=20
> > ---
> >=20
> > Notes:
> >     Typical bluetoothctl output in the failing case, without this patch=
:
> >=20
> >     $ sudo systemctl restart bluetooth
> >     $ bluetoothctl
> >     ...
> >     [bluetooth]# connect XX:XX:XX:XX:XX:XX
> >     Attempting to connect to XX:XX:XX:XX:XX:XX
> >     [CHG] Device XX:XX:XX:XX:XX:XX Connected: yes
> >     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 0000184e-0000-1000-8000-00805=
f9b34fb
> >     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 00001850-0000-1000-8000-00805=
f9b34fb
> >     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 03b80e5a-ede8-4b33-a751-6ce34=
ec4c700
> >     Connection successful
> >     [NEW] Primary Service (Handle 0x0000)
> >             /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0008
> >             00001801-0000-1000-8000-00805f9b34fb
> >             Generic Attribute Profile
> >     ...
> >     [NEW] Descriptor (Handle 0x0000)
> >             /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0065/char0066/=
desc0069
> >             00002901-0000-1000-8000-00805f9b34fb
> >             Characteristic User Description
> >     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 00001800-0000-1000-8000-00805=
f9b34fb
> >     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 00001801-0000-1000-8000-00805=
f9b34fb
> >     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 0000180a-0000-1000-8000-00805=
f9b34fb
> >     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 00001844-0000-1000-8000-00805=
f9b34fb
> >     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 0000184e-0000-1000-8000-00805=
f9b34fb
> >     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 00001850-0000-1000-8000-00805=
f9b34fb
> >     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 03b80e5a-ede8-4b33-a751-6ce34=
ec4c700
> >     [CHG] Device XX:XX:XX:XX:XX:XX ServicesResolved: yes
> >     [CHG] Device XX:XX:XX:XX:XX:XX Paired: yes
> >     [xxx]# endpoint.list
> >     [xxx]# disconnect
> >     Attempting to disconnect from XX:XX:XX:XX:XX:XX
> >     [CHG] Device XX:XX:XX:XX:XX:XX ServicesResolved: no
> >     Successful disconnected
> >     [CHG] Device XX:XX:XX:XX:XX:XX Connected: no
> >     [bluetooth]# connect XX:XX:XX:XX:XX:XX
> >     Attempting to connect to XX:XX:XX:XX:XX:XX
> >     [CHG] Device XX:XX:XX:XX:XX:XX Connected: yes
> >     Connection successful
> >     [NEW] Endpoint /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_source0
> >     [NEW] Endpoint /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_sink0
> >     [NEW] Transport /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_source0/f=
d0
> >     [NEW] Transport /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_sink0/fd1
> >     [CHG] Transport /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_source0/f=
d0 Links: /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_sink0/fd1
> >     [CHG] Transport /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_sink0/fd1=
 Links: /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_source0/fd0
> >     [CHG] Device XX:XX:XX:XX:XX:XX ServicesResolved: yes
> >     [xxx]# endpoint.list
> >     Endpoint /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_source0
> >     Endpoint /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_sink0
> >     [xxx]#
> >=20
> >     Endpoints and transports failed to appear on the first connect to t=
he
> >     BAP server, since GATT discovery was not yet completed when the BAP=
 code
> >     tried to discover the endpoints. Second connection succeeded.
> >     Occasionally, it also happens that endpoints appear but transports =
do
> >     not, but this is hard to reproduce.
> >=20
> >     With this patch:
> >=20
> >     $ sudo systemctl restart bluetooth
> >     $ bluetoothctl
> >     ...
> >     [bluetooth]# connect XX:XX:XX:XX:XX:XX
> >     Attempting to connect to XX:XX:XX:XX:XX:XX
> >     [CHG] Device XX:XX:XX:XX:XX:XX Connected: yes
> >     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 0000184e-0000-1000-8000-00805=
f9b34fb
> >     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 00001850-0000-1000-8000-00805=
f9b34fb
> >     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 03b80e5a-ede8-4b33-a751-6ce34=
ec4c700
> >     Connection successful
> >     [NEW] Primary Service (Handle 0x0000)
> >             /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0008
> >             00001801-0000-1000-8000-00805f9b34fb
> >             Generic Attribute Profile
> >     ...
> >     [NEW] Descriptor (Handle 0x0000)
> >             /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0065/char0066/=
desc0069
> >             00002901-0000-1000-8000-00805f9b34fb
> >             Characteristic User Description
> >     [CHG] Device XX:XX:XX:XX:XX:XX ServicesResolved: yes
> >     [CHG] Device XX:XX:XX:XX:XX:XX Paired: yes
> >     [NEW] Endpoint /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_source0
> >     [NEW] Endpoint /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_sink0
> >     [NEW] Transport /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_source0/f=
d0
> >     [NEW] Transport /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_sink0/fd1
> >     [CHG] Transport /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_source0/f=
d0 Links: /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_sink0/fd1
> >     [CHG] Transport /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_sink0/fd1=
 Links: /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_source0/fd0
> >     [xxx]#
> >=20
> >     Now the first connection works properly.
> >=20
> >     On first reading, the spec does not seem to clearly comment if ASEs=
 and
> >     PACs could be removed/added by the server while client is connected=
. If
> >     that's allowed, then we'd need some bigger changes here. Regardless=
,
> >     waiting for GATT client ready before first scan seems good also in =
this
> >     case.
> >=20
> >  src/shared/bap.c | 93 +++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 60 insertions(+), 33 deletions(-)
> >=20
> > diff --git a/src/shared/bap.c b/src/shared/bap.c
> > index 22f2e6714..2d676d96f 100644
> > --- a/src/shared/bap.c
> > +++ b/src/shared/bap.c
> > @@ -158,6 +158,7 @@ struct bt_bap {
> >         struct bt_att *att;
> >         struct bt_bap_req *req;
> >         unsigned int cp_id;
> > +       unsigned int client_ready_id;
> >=20
> >         unsigned int process_id;
> >         unsigned int disconn_id;
> > @@ -3733,41 +3734,10 @@ static void bap_attach_att(struct bt_bap *bap, =
struct bt_att *att)
> >                                                         bap, NULL);
> >  }
> >=20
> > -bool bt_bap_attach(struct bt_bap *bap, struct bt_gatt_client *client)
> > +static void bap_attach_finish(struct bt_bap *bap)
> >  {
> >         bt_uuid_t uuid;
> >=20
> > -       if (queue_find(sessions, NULL, bap)) {
> > -               /* If instance already been set but there is no client =
proceed
> > -                * to clone it otherwise considered it already attached=
.
> > -                */
> > -               if (client && !bap->client)
> > -                       goto clone;
> > -               return true;
> > -       }
> > -
> > -       if (!sessions)
> > -               sessions =3D queue_new();
> > -
> > -       queue_push_tail(sessions, bap);
> > -
> > -       queue_foreach(bap_cbs, bap_attached, bap);
> > -
> > -       if (!client) {
> > -               bap_attach_att(bap, bap->att);
> > -               return true;
> > -       }
> > -
> > -       if (bap->client)
> > -               return false;
> > -
> > -clone:
> > -       bap->client =3D bt_gatt_client_clone(client);
> > -       if (!bap->client)
> > -               return false;
> > -
> > -       bap_attach_att(bap, bt_gatt_client_get_att(client));
> > -
> >         if (bap->rdb->pacs) {
> >                 uint16_t value_handle;
> >                 struct bt_pacs *pacs =3D bap->rdb->pacs;
> > @@ -3798,7 +3768,7 @@ clone:
> >=20
> >                 bap_notify_ready(bap);
> >=20
> > -               return true;
> > +               return;
> >         }
> >=20
> >         bt_uuid16_create(&uuid, PACS_UUID);
> > @@ -3806,6 +3776,57 @@ clone:
> >=20
> >         bt_uuid16_create(&uuid, ASCS_UUID);
> >         gatt_db_foreach_service(bap->rdb->db, &uuid, foreach_ascs_servi=
ce, bap);
> > +}
> > +
> > +static void bap_attach_ready_cb(bool success, uint8_t att_ecode,
> > +                                                               void *u=
ser_data)
> > +{
> > +       struct bt_bap *bap =3D user_data;
> > +
> > +       bap->client_ready_id =3D 0;
> > +
> > +       bap_attach_finish(bap);
> > +}
> > +
> > +bool bt_bap_attach(struct bt_bap *bap, struct bt_gatt_client *client)
> > +{
> > +       if (queue_find(sessions, NULL, bap)) {
> > +               /* If instance already been set but there is no client =
proceed
> > +                * to clone it otherwise considered it already attached=
.
> > +                */
> > +               if (client && !bap->client)
> > +                       goto clone;
> > +               return true;
> > +       }
> > +
> > +       if (!sessions)
> > +               sessions =3D queue_new();
> > +
> > +       queue_push_tail(sessions, bap);
> > +
> > +       queue_foreach(bap_cbs, bap_attached, bap);
> > +
> > +       if (!client) {
> > +               bap_attach_att(bap, bap->att);
> > +               return true;
> > +       }
> > +
> > +       if (bap->client)
> > +               return false;
> > +
> > +clone:
> > +       bap->client =3D bt_gatt_client_clone(client);
> > +       if (!bap->client)
> > +               return false;
> > +
> > +       bap_attach_att(bap, bt_gatt_client_get_att(bap->client));
> > +
> > +       if (bt_gatt_client_is_ready(bap->client)) {
> > +               bap_attach_finish(bap);
> > +       } else {
> > +               bap->client_ready_id =3D bt_gatt_client_ready_register(
> > +                               bap->client, bap_attach_ready_cb, bap, =
NULL);
> > +       }
> >=20
> >         return true;
> >  }
> > @@ -3824,6 +3845,12 @@ void bt_bap_detach(struct bt_bap *bap)
> >         if (!queue_remove(sessions, bap))
> >                 return;
> >=20
> > +       if (bap->client_ready_id) {
> > +               bt_gatt_client_ready_unregister(bap->client,
> > +                                               bap->client_ready_id);
> > +               bap->client_ready_id =3D 0;
> > +       }
> > +
> >         bt_gatt_client_unref(bap->client);
> >         bap->client =3D NULL;
> >=20
> > --
> > 2.39.1
> >=20
>=20
>=20

