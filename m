Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B087BC636D4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Feb 2023 20:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjBMUke (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Feb 2023 15:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjBMUkd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Feb 2023 15:40:33 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9127015CA1
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Feb 2023 12:40:31 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id f34so20598704lfv.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Feb 2023 12:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFFV89igjG6wNWGOX/2CU/BDec6x03E1z6rhfoycLlg=;
        b=TeLM/iVGs+p9LEz0GRunFaSeV9r9j5l6nlMgM6DNHe4JQag1DeK2e7H8hHe2MsUuZV
         /O9xIR3KjQHIiWDSf9SDNVqm9hbY/xD7yzO7CUIuoMuv2O4WHQJJVaAUREFPForAqtk8
         zY3A6zEEpxL01w2WkJjpfweg8Ssoe9bC+PZbZIrJvQQLZgCdaQK3+Q6VxehnqErbK6Uk
         PJ/S5bv19F065AOR3AJ1fVNegFh6FmiksBOOMoatQKZ9J7NgHNDFwSm5R0UudkauOV+v
         +R0gkO6YZ++4fMbP43fmLb7JDU4aybxuiasuSS1rjFA+dNrl4NkXMj3AF40KV9nZcAn7
         E9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFFV89igjG6wNWGOX/2CU/BDec6x03E1z6rhfoycLlg=;
        b=7NTbO+bJwZn+qkOdnfFHMYoYvqofDFsPsvdePROeEmLltdvFKu1TfhD2rRPsKzpr0D
         mkReLv8pVaZBQ7MKUKx251BBnnZ+17VnzJvXqyeq1MY982zABSkWu7SHleRLLhnCWniq
         44nE9l1qDXovRtRhNh6FdZ6mRgNNaPd3tCSLyAIWx4l9fgz8Iim0lbOoH696TPSMXw9M
         Q8yPS8idMKu+1YYYw8yrGWX9FBMmDzWWD9dCrYi224/fU+lKKV62fywtfqH5fWPGqBiR
         vjBF6Ws7WShYOnOulyqgX7U/EgpkDS1dn1kBwSfxBJaDJBYcCaGqPOIFlEx/CxPftfiK
         4zqg==
X-Gm-Message-State: AO0yUKW/WOtlO3Ljlfu08yYCuKLcsnyJWZflY95gzbqhihbT9TFRcUz1
        vnliQ5OiUYBLcZF7MZR32Ix+/jUHagv5MzjIc4bIKf3qLm4=
X-Google-Smtp-Source: AK7set/fBpugmOhOWUsjUaz1Wt/db7IjiIQ/qzntJjlao/ghF0blPJtWS49s6DW6z5PtTguxI3oeDIfHwgOAlZlAl7Y=
X-Received: by 2002:ac2:54af:0:b0:4bb:35c9:dfb5 with SMTP id
 w15-20020ac254af000000b004bb35c9dfb5mr4137725lfk.13.1676320829653; Mon, 13
 Feb 2023 12:40:29 -0800 (PST)
MIME-Version: 1.0
References: <98ccef96a4b719599c0fb1d085c7239a12d2ed8c.1676226143.git.pav@iki.fi>
 <CABBYNZLD4CLCRSeKWj=Mb08Q9_TwkOZB0t-mUEpsT0ghDHpWBw@mail.gmail.com> <44b314270316b24f86b2439ac9433f162e4ce9bd.camel@iki.fi>
In-Reply-To: <44b314270316b24f86b2439ac9433f162e4ce9bd.camel@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 13 Feb 2023 12:40:18 -0800
Message-ID: <CABBYNZLknOHWkZb3+Mjfu77hkPEqA68xFsWALBzBfme27fzGdA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/bap: wait for GATT client ready before
 ASCS/PACS discovery
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Sun, Feb 12, 2023 at 1:50 PM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> su, 2023-02-12 kello 12:45 -0800, Luiz Augusto von Dentz kirjoitti:
> > Hi Pauli,
> >
> > On Sun, Feb 12, 2023 at 10:41 AM Pauli Virtanen <pav@iki.fi> wrote:
> > >
> > > BAP client fails to find endpoints if GATT services are not resolved
> > > when the GATT client is attached to the session.  This condition
> > > almost always occurs on the first BAP connection to a device between
> > > bluetoothd restarts, and may occur also otherwise.
> >
> > Hmm, this shouldn't happen if you have caching enabled, did you
> > disable it for some reason?
>
> Caching has not been disabled. The files in /var/lib/bluetooth/*/cache
> also get updated so presumably it is working.
>
> > > The BAP client code discovers ASCS/PACS services and characteristics =
at
> > > client attach time.
> > >
> > > Fix the connection issue by postponing PAC/ASE discovery until the
> > > GATT client is ready, if it was not ready at attach time.
> >
> > This should probably be done by the core, it should check if the
> > services are cached then it can call accept, otherwise it needs to
> > wait for the client to be ready, perhaps there is something not quite
> > right with the way to probe services as afaik if we don't have any
> > cache the driver shouldn't have been called to begin with.
>
> bap_accept gets called from
>
> #0  bap_accept (service=3D0x604000005f50) at profiles/audio/bap.c:1304
> #1  0x0000000000631755 in service_accept (service=3D0x604000005f50, initi=
ator=3Dtrue) at src/service.c:203
> #2  0x0000000000668561 in device_accept_gatt_profiles (device=3D0x6170000=
00080) at src/device.c:3739
> #3  0x0000000000676128 in gatt_client_init (device=3D0x617000000080) at s=
rc/device.c:5161
> #4  0x00000000006782e5 in device_attach_att (dev=3D0x617000000080, io=3D0=
x60c00000b2c0) at src/device.c:5331
> #5  0x00000000006788e5 in att_connect_cb (io=3D0x60c00000b2c0, gerr=3D0x0=
, user_data=3D0x617000000080) at src/device.c:5378
> #6  0x000000000053de23 in connect_cb (io=3D0x60c00000b2c0, cond=3DG_IO_OU=
T, user_data=3D0x60300001f8d0) at btio/btio.c:229
> #7  0x00007f4955d16cbf in g_main_context_dispatch () from target:/lib64/l=
ibglib-2.0.so.0
> #8  0x00007f4955d6c598 in g_main_context_iterate.constprop () from target=
:/lib64/libglib-2.0.so.0
> #9  0x00007f4955d1628f in g_main_loop_run () from target:/lib64/libglib-2=
.0.so.0
> #10 0x00000000007df9ca in mainloop_run () at src/shared/mainloop-glib.c:6=
6
> #11 0x00000000007e075a in mainloop_run_with_signal (func=3D0x558597 <sign=
al_callback>, user_data=3D0x0) at src/shared/mainloop-notify.c:188
> #12 0x0000000000558e97 in main (argc=3D1, argv=3D0x7ffd399f7788) at src/m=
ain.c:1304
>
> which does not wait for GATT client ready. The comment above that
>
> 5157=E2=94=82         /*
> 5158=E2=94=82          * Notify notify existing service about the new con=
nection so they can
> 5159=E2=94=82          * react to notifications while discovering service=
s
> 5160=E2=94=82          */
>
> looks like this is intentional. If it's like this, then services would
> need to explicitly wait.
>
> Didn't look yet how come it knows the gatt service is there then,
> however I guess it only looks for the PACS service uuid, as I think
> nothing tells device.c also ASCS would be needed.

We do load the database from cache in case there is one:

https://github.com/bluez/bluez/blob/master/src/device.c#L5328

Or are you experiencing some problem where PACS is cached but ASCS isn't?

> Best,
> Pauli
>
> >
> > > ---
> > >
> > > Notes:
> > >     Typical bluetoothctl output in the failing case, without this pat=
ch:
> > >
> > >     $ sudo systemctl restart bluetooth
> > >     $ bluetoothctl
> > >     ...
> > >     [bluetooth]# connect XX:XX:XX:XX:XX:XX
> > >     Attempting to connect to XX:XX:XX:XX:XX:XX
> > >     [CHG] Device XX:XX:XX:XX:XX:XX Connected: yes
> > >     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 0000184e-0000-1000-8000-008=
05f9b34fb
> > >     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 00001850-0000-1000-8000-008=
05f9b34fb
> > >     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 03b80e5a-ede8-4b33-a751-6ce=
34ec4c700
> > >     Connection successful
> > >     [NEW] Primary Service (Handle 0x0000)
> > >             /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0008
> > >             00001801-0000-1000-8000-00805f9b34fb
> > >             Generic Attribute Profile
> > >     ...
> > >     [NEW] Descriptor (Handle 0x0000)
> > >             /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0065/char006=
6/desc0069
> > >             00002901-0000-1000-8000-00805f9b34fb
> > >             Characteristic User Description
> > >     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 00001800-0000-1000-8000-008=
05f9b34fb
> > >     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 00001801-0000-1000-8000-008=
05f9b34fb
> > >     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 0000180a-0000-1000-8000-008=
05f9b34fb
> > >     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 00001844-0000-1000-8000-008=
05f9b34fb
> > >     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 0000184e-0000-1000-8000-008=
05f9b34fb
> > >     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 00001850-0000-1000-8000-008=
05f9b34fb
> > >     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 03b80e5a-ede8-4b33-a751-6ce=
34ec4c700
> > >     [CHG] Device XX:XX:XX:XX:XX:XX ServicesResolved: yes
> > >     [CHG] Device XX:XX:XX:XX:XX:XX Paired: yes
> > >     [xxx]# endpoint.list
> > >     [xxx]# disconnect
> > >     Attempting to disconnect from XX:XX:XX:XX:XX:XX
> > >     [CHG] Device XX:XX:XX:XX:XX:XX ServicesResolved: no
> > >     Successful disconnected
> > >     [CHG] Device XX:XX:XX:XX:XX:XX Connected: no
> > >     [bluetooth]# connect XX:XX:XX:XX:XX:XX
> > >     Attempting to connect to XX:XX:XX:XX:XX:XX
> > >     [CHG] Device XX:XX:XX:XX:XX:XX Connected: yes
> > >     Connection successful
> > >     [NEW] Endpoint /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_source0
> > >     [NEW] Endpoint /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_sink0
> > >     [NEW] Transport /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_source0=
/fd0
> > >     [NEW] Transport /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_sink0/f=
d1
> > >     [CHG] Transport /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_source0=
/fd0 Links: /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_sink0/fd1
> > >     [CHG] Transport /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_sink0/f=
d1 Links: /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_source0/fd0
> > >     [CHG] Device XX:XX:XX:XX:XX:XX ServicesResolved: yes
> > >     [xxx]# endpoint.list
> > >     Endpoint /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_source0
> > >     Endpoint /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_sink0
> > >     [xxx]#
> > >
> > >     Endpoints and transports failed to appear on the first connect to=
 the
> > >     BAP server, since GATT discovery was not yet completed when the B=
AP code
> > >     tried to discover the endpoints. Second connection succeeded.
> > >     Occasionally, it also happens that endpoints appear but transport=
s do
> > >     not, but this is hard to reproduce.
> > >
> > >     With this patch:
> > >
> > >     $ sudo systemctl restart bluetooth
> > >     $ bluetoothctl
> > >     ...
> > >     [bluetooth]# connect XX:XX:XX:XX:XX:XX
> > >     Attempting to connect to XX:XX:XX:XX:XX:XX
> > >     [CHG] Device XX:XX:XX:XX:XX:XX Connected: yes
> > >     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 0000184e-0000-1000-8000-008=
05f9b34fb
> > >     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 00001850-0000-1000-8000-008=
05f9b34fb
> > >     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 03b80e5a-ede8-4b33-a751-6ce=
34ec4c700
> > >     Connection successful
> > >     [NEW] Primary Service (Handle 0x0000)
> > >             /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0008
> > >             00001801-0000-1000-8000-00805f9b34fb
> > >             Generic Attribute Profile
> > >     ...
> > >     [NEW] Descriptor (Handle 0x0000)
> > >             /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0065/char006=
6/desc0069
> > >             00002901-0000-1000-8000-00805f9b34fb
> > >             Characteristic User Description
> > >     [CHG] Device XX:XX:XX:XX:XX:XX ServicesResolved: yes
> > >     [CHG] Device XX:XX:XX:XX:XX:XX Paired: yes
> > >     [NEW] Endpoint /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_source0
> > >     [NEW] Endpoint /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_sink0
> > >     [NEW] Transport /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_source0=
/fd0
> > >     [NEW] Transport /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_sink0/f=
d1
> > >     [CHG] Transport /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_source0=
/fd0 Links: /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_sink0/fd1
> > >     [CHG] Transport /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_sink0/f=
d1 Links: /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_source0/fd0
> > >     [xxx]#
> > >
> > >     Now the first connection works properly.
> > >
> > >     On first reading, the spec does not seem to clearly comment if AS=
Es and
> > >     PACs could be removed/added by the server while client is connect=
ed. If
> > >     that's allowed, then we'd need some bigger changes here. Regardle=
ss,
> > >     waiting for GATT client ready before first scan seems good also i=
n this
> > >     case.
> > >
> > >  src/shared/bap.c | 93 +++++++++++++++++++++++++++++++---------------=
--
> > >  1 file changed, 60 insertions(+), 33 deletions(-)
> > >
> > > diff --git a/src/shared/bap.c b/src/shared/bap.c
> > > index 22f2e6714..2d676d96f 100644
> > > --- a/src/shared/bap.c
> > > +++ b/src/shared/bap.c
> > > @@ -158,6 +158,7 @@ struct bt_bap {
> > >         struct bt_att *att;
> > >         struct bt_bap_req *req;
> > >         unsigned int cp_id;
> > > +       unsigned int client_ready_id;
> > >
> > >         unsigned int process_id;
> > >         unsigned int disconn_id;
> > > @@ -3733,41 +3734,10 @@ static void bap_attach_att(struct bt_bap *bap=
, struct bt_att *att)
> > >                                                         bap, NULL);
> > >  }
> > >
> > > -bool bt_bap_attach(struct bt_bap *bap, struct bt_gatt_client *client=
)
> > > +static void bap_attach_finish(struct bt_bap *bap)
> > >  {
> > >         bt_uuid_t uuid;
> > >
> > > -       if (queue_find(sessions, NULL, bap)) {
> > > -               /* If instance already been set but there is no clien=
t proceed
> > > -                * to clone it otherwise considered it already attach=
ed.
> > > -                */
> > > -               if (client && !bap->client)
> > > -                       goto clone;
> > > -               return true;
> > > -       }
> > > -
> > > -       if (!sessions)
> > > -               sessions =3D queue_new();
> > > -
> > > -       queue_push_tail(sessions, bap);
> > > -
> > > -       queue_foreach(bap_cbs, bap_attached, bap);
> > > -
> > > -       if (!client) {
> > > -               bap_attach_att(bap, bap->att);
> > > -               return true;
> > > -       }
> > > -
> > > -       if (bap->client)
> > > -               return false;
> > > -
> > > -clone:
> > > -       bap->client =3D bt_gatt_client_clone(client);
> > > -       if (!bap->client)
> > > -               return false;
> > > -
> > > -       bap_attach_att(bap, bt_gatt_client_get_att(client));
> > > -
> > >         if (bap->rdb->pacs) {
> > >                 uint16_t value_handle;
> > >                 struct bt_pacs *pacs =3D bap->rdb->pacs;
> > > @@ -3798,7 +3768,7 @@ clone:
> > >
> > >                 bap_notify_ready(bap);
> > >
> > > -               return true;
> > > +               return;
> > >         }
> > >
> > >         bt_uuid16_create(&uuid, PACS_UUID);
> > > @@ -3806,6 +3776,57 @@ clone:
> > >
> > >         bt_uuid16_create(&uuid, ASCS_UUID);
> > >         gatt_db_foreach_service(bap->rdb->db, &uuid, foreach_ascs_ser=
vice, bap);
> > > +}
> > > +
> > > +static void bap_attach_ready_cb(bool success, uint8_t att_ecode,
> > > +                                                               void =
*user_data)
> > > +{
> > > +       struct bt_bap *bap =3D user_data;
> > > +
> > > +       bap->client_ready_id =3D 0;
> > > +
> > > +       bap_attach_finish(bap);
> > > +}
> > > +
> > > +bool bt_bap_attach(struct bt_bap *bap, struct bt_gatt_client *client=
)
> > > +{
> > > +       if (queue_find(sessions, NULL, bap)) {
> > > +               /* If instance already been set but there is no clien=
t proceed
> > > +                * to clone it otherwise considered it already attach=
ed.
> > > +                */
> > > +               if (client && !bap->client)
> > > +                       goto clone;
> > > +               return true;
> > > +       }
> > > +
> > > +       if (!sessions)
> > > +               sessions =3D queue_new();
> > > +
> > > +       queue_push_tail(sessions, bap);
> > > +
> > > +       queue_foreach(bap_cbs, bap_attached, bap);
> > > +
> > > +       if (!client) {
> > > +               bap_attach_att(bap, bap->att);
> > > +               return true;
> > > +       }
> > > +
> > > +       if (bap->client)
> > > +               return false;
> > > +
> > > +clone:
> > > +       bap->client =3D bt_gatt_client_clone(client);
> > > +       if (!bap->client)
> > > +               return false;
> > > +
> > > +       bap_attach_att(bap, bt_gatt_client_get_att(bap->client));
> > > +
> > > +       if (bt_gatt_client_is_ready(bap->client)) {
> > > +               bap_attach_finish(bap);
> > > +       } else {
> > > +               bap->client_ready_id =3D bt_gatt_client_ready_registe=
r(
> > > +                               bap->client, bap_attach_ready_cb, bap=
, NULL);
> > > +       }
> > >
> > >         return true;
> > >  }
> > > @@ -3824,6 +3845,12 @@ void bt_bap_detach(struct bt_bap *bap)
> > >         if (!queue_remove(sessions, bap))
> > >                 return;
> > >
> > > +       if (bap->client_ready_id) {
> > > +               bt_gatt_client_ready_unregister(bap->client,
> > > +                                               bap->client_ready_id)=
;
> > > +               bap->client_ready_id =3D 0;
> > > +       }
> > > +
> > >         bt_gatt_client_unref(bap->client);
> > >         bap->client =3D NULL;
> > >
> > > --
> > > 2.39.1
> > >
> >
> >
>


--=20
Luiz Augusto von Dentz
