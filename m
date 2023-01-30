Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F804C636CD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Jan 2023 20:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbjA3UEq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Jan 2023 15:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238041AbjA3UEn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Jan 2023 15:04:43 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42CB46D4B
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 12:04:36 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 5C9DF240283
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 21:04:35 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4P5K0252DZz6tmS;
        Mon, 30 Jan 2023 21:04:34 +0100 (CET)
Message-ID: <f81b39d2de64714e9c73b01165b5d5a4c4b42e41.camel@iki.fi>
Subject: Re: [PATCH BlueZ 7/8] shared/bap: handle central-only case
From:   Pauli Virtanen <pav@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Date:   Mon, 30 Jan 2023 20:04:34 +0000
In-Reply-To: <CABBYNZ+Vrzpa4ppBkLTcHXbXUgJxL1CsW00yzn-inWqBwUmo2w@mail.gmail.com>
References: <20230127205205.20235-1-pav@iki.fi>
         <a8aedc0f9a4c1e21d61694589c5b7a9f31cbedc1.1675103676.git.pav@iki.fi>
         <161c4172f60d926d015a5b48de48b890412d57e5.1675103676.git.pav@iki.fi>
         <CABBYNZ+Vrzpa4ppBkLTcHXbXUgJxL1CsW00yzn-inWqBwUmo2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

ma, 2023-01-30 kello 11:39 -0800, Luiz Augusto von Dentz kirjoitti:
> On Mon, Jan 30, 2023 at 11:06 AM Pauli Virtanen <pav@iki.fi> wrote:
> > 
> > Support central-only case, where no local endpoints are created, and
> > nothing is registered in the local GATT database.
> > 
> > In this case, we keep track of the local PACs ("sinks" and "sources"),
> > but there are no PACS and ASCS registrations or endpoints.
> 
> I'm not really following how that would work without local endpoints
> since the endpoints are the interface which is used to setup the
> stream with the likes of pipewire/pulseaudio we can't really remove
> them, what Id would suggest doing is to have a flag indicating if the
> instance is client only or not, that way bt_bap can identify if it
> needs to register services or not.

What I tried to say here is that in the central-only (or client in
other words) mode, no ASEs or PACs are registered in the local GATT DB.
The local endpoints do still exist in the Media1 API. In shared/bap.c
they are always associated with the PACs (not ASEs), so the client-only
mode does not need ASEs. So what is done is to my understanding what
you write above --- maybe I am missing something?

I've tested playback on this patchset for pipewire -> pipewire between
two machines, with the CIS Central flag forced to false on one end, and
CIS Peripheral false on the other end. Also playback to non-BlueZ
device works with CIS Peripheral flag disabled.

> 
> > ---
> >  src/shared/bap.c | 58 ++++++++++++++++++++++++++----------------------
> >  src/shared/bap.h |  9 +++++---
> >  unit/test-bap.c  |  4 +++-
> >  3 files changed, 40 insertions(+), 31 deletions(-)
> > 
> > diff --git a/src/shared/bap.c b/src/shared/bap.c
> > index 22f2e6714..24113bb34 100644
> > --- a/src/shared/bap.c
> > +++ b/src/shared/bap.c
> > @@ -110,11 +110,13 @@ struct bt_ascs {
> > 
> >  struct bt_bap_db {
> >         struct gatt_db *db;
> > -       struct bt_pacs *pacs;
> > -       struct bt_ascs *ascs;
> >         struct queue *sinks;
> >         struct queue *sources;
> > +
> > +       /* The following are NULL if central-only (no GATT) */
> >         struct queue *endpoints;
> > +       struct bt_pacs *pacs;
> > +       struct bt_ascs *ascs;
> >  };
> > 
> >  struct bt_bap_req {
> > @@ -565,6 +567,7 @@ static void bap_disconnected(int err, void *user_data)
> >  static struct bt_bap *bap_get_session(struct bt_att *att, struct gatt_db *db)
> >  {
> >         const struct queue_entry *entry;
> > +       struct bt_bap_db *ldb;
> >         struct bt_bap *bap;
> > 
> >         for (entry = queue_get_entries(sessions); entry; entry = entry->next) {
> > @@ -574,7 +577,8 @@ static struct bt_bap *bap_get_session(struct bt_att *att, struct gatt_db *db)
> >                         return bap;
> >         }
> > 
> > -       bap = bt_bap_new(db, NULL);
> > +       ldb = bt_bap_get_local_db(db, true);
> > +       bap = bt_bap_new(ldb, NULL);
> >         bap->att = att;
> > 
> >         bt_bap_attach(bap, NULL);
> > @@ -620,7 +624,7 @@ static struct bt_bap_endpoint *bap_get_endpoint(struct bt_bap_db *db,
> >  {
> >         struct bt_bap_endpoint *ep;
> > 
> > -       if (!db || !attr)
> > +       if (!db || !attr || !db->endpoints)
> >                 return NULL;
> > 
> >         ep = queue_find(db->endpoints, bap_endpoint_match, attr);
> > @@ -652,7 +656,7 @@ static struct bt_bap_endpoint *bap_get_endpoint_id(struct bt_bap *bap,
> >         struct gatt_db_attribute *attr = NULL;
> >         size_t i;
> > 
> > -       if (!bap || !db)
> > +       if (!bap || !db || !db->endpoints)
> >                 return NULL;
> > 
> >         ep = queue_find(db->endpoints, bap_endpoint_match_id, UINT_TO_PTR(id));
> > @@ -2170,7 +2174,7 @@ static struct bt_ascs *ascs_new(struct gatt_db *db)
> >         return ascs;
> >  }
> > 
> > -static struct bt_bap_db *bap_db_new(struct gatt_db *db)
> > +static struct bt_bap_db *bap_db_new(struct gatt_db *db, bool peripheral)
> >  {
> >         struct bt_bap_db *bdb;
> > 
> > @@ -2181,23 +2185,26 @@ static struct bt_bap_db *bap_db_new(struct gatt_db *db)
> >         bdb->db = gatt_db_ref(db);
> >         bdb->sinks = queue_new();
> >         bdb->sources = queue_new();
> > -       bdb->endpoints = queue_new();
> > 
> >         if (!bap_db)
> >                 bap_db = queue_new();
> > 
> > -       bdb->pacs = pacs_new(db);
> > -       bdb->pacs->bdb = bdb;
> > +       if (peripheral) {
> > +               bdb->endpoints = queue_new();
> > 
> > -       bdb->ascs = ascs_new(db);
> > -       bdb->ascs->bdb = bdb;
> > +               bdb->pacs = pacs_new(db);
> > +               bdb->pacs->bdb = bdb;
> > +
> > +               bdb->ascs = ascs_new(db);
> > +               bdb->ascs->bdb = bdb;
> > +       }
> > 
> >         queue_push_tail(bap_db, bdb);
> > 
> >         return bdb;
> >  }
> > 
> > -static struct bt_bap_db *bap_get_db(struct gatt_db *db)
> > +struct bt_bap_db *bt_bap_get_local_db(struct gatt_db *db, bool peripheral)
> >  {
> >         struct bt_bap_db *bdb;
> > 
> > @@ -2205,7 +2212,7 @@ static struct bt_bap_db *bap_get_db(struct gatt_db *db)
> >         if (bdb)
> >                 return bdb;
> > 
> > -       return bap_db_new(db);
> > +       return bap_db_new(db, peripheral);
> >  }
> > 
> >  static struct bt_pacs *bap_get_pacs(struct bt_bap *bap)
> > @@ -2328,6 +2335,9 @@ static void bap_add_sink(struct bt_bap_pac *pac)
> > 
> >         queue_push_tail(pac->bdb->sinks, pac);
> > 
> > +       if (!pac->bdb->endpoints)
> > +               return;
> > +
> >         memset(value, 0, sizeof(value));
> > 
> >         iov.iov_base = value;
> > @@ -2346,6 +2356,9 @@ static void bap_add_source(struct bt_bap_pac *pac)
> > 
> >         queue_push_tail(pac->bdb->sources, pac);
> > 
> > +       if (!pac->bdb->endpoints)
> > +               return;
> > +
> >         memset(value, 0, sizeof(value));
> > 
> >         iov.iov_base = value;
> > @@ -2373,21 +2386,16 @@ static void notify_session_pac_added(void *data, void *user_data)
> >         queue_foreach(bap->pac_cbs, notify_pac_added, user_data);
> >  }
> > 
> > -struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
> > +struct bt_bap_pac *bt_bap_add_vendor_pac(struct bt_bap_db *bdb,
> >                                         const char *name, uint8_t type,
> >                                         uint8_t id, uint16_t cid, uint16_t vid,
> >                                         struct bt_bap_pac_qos *qos,
> >                                         struct iovec *data,
> >                                         struct iovec *metadata)
> >  {
> > -       struct bt_bap_db *bdb;
> >         struct bt_bap_pac *pac;
> >         struct bt_bap_codec codec;
> > 
> > -       if (!db)
> > -               return NULL;
> > -
> > -       bdb = bap_get_db(db);
> >         if (!bdb)
> >                 return NULL;
> > 
> > @@ -2417,13 +2425,13 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
> >         return pac;
> >  }
> > 
> > -struct bt_bap_pac *bt_bap_add_pac(struct gatt_db *db, const char *name,
> > +struct bt_bap_pac *bt_bap_add_pac(struct bt_bap_db *bdb, const char *name,
> >                                         uint8_t type, uint8_t id,
> >                                         struct bt_bap_pac_qos *qos,
> >                                         struct iovec *data,
> >                                         struct iovec *metadata)
> >  {
> > -       return bt_bap_add_vendor_pac(db, name, type, id, 0x0000, 0x0000, qos,
> > +       return bt_bap_add_vendor_pac(bdb, name, type, id, 0x0000, 0x0000, qos,
> >                                                         data, metadata);
> >  }
> > 
> > @@ -2635,7 +2643,7 @@ static void bap_attached(void *data, void *user_data)
> >         cb->attached(bap, cb->user_data);
> >  }
> > 
> > -struct bt_bap *bt_bap_new(struct gatt_db *ldb, struct gatt_db *rdb)
> > +struct bt_bap *bt_bap_new(struct bt_bap_db *ldb, struct gatt_db *rdb)
> >  {
> >         struct bt_bap *bap;
> >         struct bt_bap_db *bdb;
> > @@ -2643,12 +2651,8 @@ struct bt_bap *bt_bap_new(struct gatt_db *ldb, struct gatt_db *rdb)
> >         if (!ldb)
> >                 return NULL;
> > 
> > -       bdb = bap_get_db(ldb);
> > -       if (!bdb)
> > -               return NULL;
> > -
> >         bap = new0(struct bt_bap, 1);
> > -       bap->ldb = bdb;
> > +       bap->ldb = ldb;
> >         bap->reqs = queue_new();
> >         bap->pending = queue_new();
> >         bap->notify = queue_new();
> > diff --git a/src/shared/bap.h b/src/shared/bap.h
> > index 47a15636c..a4e8549a5 100644
> > --- a/src/shared/bap.h
> > +++ b/src/shared/bap.h
> > @@ -34,6 +34,7 @@
> >  #define BT_BAP_CONFIG_PHY_CODEC                0x03
> > 
> >  struct bt_bap;
> > +struct bt_bap_db;
> >  struct bt_bap_pac;
> >  struct bt_bap_stream;
> > 
> > @@ -98,14 +99,14 @@ struct bt_bap_pac_qos {
> >         uint32_t ppd_max;
> >  };
> > 
> > -struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
> > +struct bt_bap_pac *bt_bap_add_vendor_pac(struct bt_bap_db *bdb,
> >                                         const char *name, uint8_t type,
> >                                         uint8_t id, uint16_t cid, uint16_t vid,
> >                                         struct bt_bap_pac_qos *qos,
> >                                         struct iovec *data,
> >                                         struct iovec *metadata);
> > 
> > -struct bt_bap_pac *bt_bap_add_pac(struct gatt_db *db, const char *name,
> > +struct bt_bap_pac *bt_bap_add_pac(struct bt_bap_db *bdb, const char *name,
> >                                         uint8_t type, uint8_t id,
> >                                         struct bt_bap_pac_qos *qos,
> >                                         struct iovec *data,
> > @@ -135,7 +136,9 @@ unsigned int bt_bap_register(bt_bap_func_t added, bt_bap_func_t removed,
> >                                                         void *user_data);
> >  bool bt_bap_unregister(unsigned int id);
> > 
> > -struct bt_bap *bt_bap_new(struct gatt_db *ldb, struct gatt_db *rdb);
> > +struct bt_bap_db *bt_bap_get_local_db(struct gatt_db *db, bool peripheral);
> > +
> > +struct bt_bap *bt_bap_new(struct bt_bap_db *ldb, struct gatt_db *rdb);
> > 
> >  bool bt_bap_set_user_data(struct bt_bap *bap, void *user_data);
> > 
> > diff --git a/unit/test-bap.c b/unit/test-bap.c
> > index afeefac84..b677f5197 100644
> > --- a/unit/test-bap.c
> > +++ b/unit/test-bap.c
> > @@ -311,6 +311,7 @@ static void test_client(const void *user_data)
> >  {
> >         struct test_data *data = (void *)user_data;
> >         struct io *io;
> > +       struct bt_bap_db *ldb;
> >         struct gatt_db *db;
> > 
> >         io = tester_setup_io(data->iov, data->iovcnt);
> > @@ -321,7 +322,8 @@ static void test_client(const void *user_data)
> >         db = gatt_db_new();
> >         g_assert(db);
> > 
> > -       data->bap = bt_bap_new(db, bt_gatt_client_get_db(data->client));
> > +       ldb = bt_bap_get_local_db(db, true);
> > +       data->bap = bt_bap_new(ldb, bt_gatt_client_get_db(data->client));
> >         g_assert(data->bap);
> > 
> >         bt_bap_set_debug(data->bap, print_debug, "bt_bap:", NULL);
> > --
> > 2.39.1
> > 
> 
> 

-- 
Pauli Virtanen
