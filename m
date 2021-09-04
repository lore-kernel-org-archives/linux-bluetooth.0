Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EEAC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Sep 2021 10:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAF0860F3A
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Sep 2021 10:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236025AbhIDKh6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 4 Sep 2021 06:37:58 -0400
Received: from mout01.posteo.de ([185.67.36.141]:42231 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234482AbhIDKh5 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 4 Sep 2021 06:37:57 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id EE6AC24002A
        for <linux-bluetooth@vger.kernel.org>; Sat,  4 Sep 2021 12:36:54 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4H1rgp3p4Tz6tmR;
        Sat,  4 Sep 2021 12:36:54 +0200 (CEST)
Message-ID: <c2d67b7cfe2d7bc087ec8bd3b9e34cf487d54c81.camel@iki.fi>
Subject: Re: [PATCH BlueZ 2/2] avdtp: use separate local SEID pool for each
 adapter
From:   Pauli Virtanen <pav@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date:   Sat, 04 Sep 2021 10:36:54 +0000
In-Reply-To: <CABBYNZK6b=HrLWSufVyRwNJ9jnhFaQ3d0dabQY+BW0_qbkNB7A@mail.gmail.com>
References: <20210829155012.164880-1-pav@iki.fi>
         <20210829155012.164880-3-pav@iki.fi>
         <CABBYNZK6b=HrLWSufVyRwNJ9jnhFaQ3d0dabQY+BW0_qbkNB7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

pe, 2021-09-03 kello 15:49 -0700, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
> 
> On Sun, Aug 29, 2021 at 8:52 AM Pauli Virtanen <pav@iki.fi> wrote:
> > 
> > Local SEIDs are currently allocated from a pool that is common for all
> > adapters. However, AVDTP spec v1.3, sec 4.10 states "To prevent
> > conflicts, the scope of the SEID shall be both device-local and
> > connection-local. The application is responsible for assigning a SEID,
> > which is not in use on the connection to the same peer device." In
> > practice, registering the same media application for multiple adapters
> > can result to running out of SEIDs, even though the spec does not
> > require SEIDs to be unique across adapters.
> > 
> > Use a separate SEID pool for each btd_adapter to fix this.
> > ---
> >  profiles/audio/a2dp.c  |  2 +-
> >  profiles/audio/avdtp.c | 55 ++++++++++++++++++++++++++++++++++++------
> >  profiles/audio/avdtp.h |  4 ++-
> >  3 files changed, 51 insertions(+), 10 deletions(-)
> > 
> > diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> > index 02caa83e1..1e8a66b8a 100644
> > --- a/profiles/audio/a2dp.c
> > +++ b/profiles/audio/a2dp.c
> > @@ -2615,7 +2615,7 @@ struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
> > 
> >         sep = g_new0(struct a2dp_sep, 1);
> > 
> > -       sep->lsep = avdtp_register_sep(server->seps, type,
> > +       sep->lsep = avdtp_register_sep(adapter, server->seps, type,
> >                                         AVDTP_MEDIA_TYPE_AUDIO, codec,
> >                                         delay_reporting, &endpoint_ind,
> >                                         &cfm, sep);
> 
> avdtp.c shall not have dependencies on adapter.c, or any btd_ function
> that is daemon specific.

Ack.

> > diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> > index 25520ceec..f2aa98b23 100644
> > --- a/profiles/audio/avdtp.c
> > +++ b/profiles/audio/avdtp.c
> > @@ -44,7 +44,6 @@
> >  #define AVDTP_PSM 25
> > 
> >  #define MAX_SEID 0x3E
> > -static uint64_t seids;
> > 
> >  #ifndef MAX
> >  # define MAX(x, y) ((x) > (y) ? (x) : (y))
> > @@ -325,6 +324,7 @@ struct avdtp_local_sep {
> >         GSList *caps;
> >         struct avdtp_sep_ind *ind;
> >         struct avdtp_sep_cfm *cfm;
> > +       struct btd_adapter *adapter;
> 
> We should probably use the list (server->seps) instead to avoid
> depending on the btd_adapter here.

This would mean that a2dp_server owns the SEID pool.

a2dp_server is the only local SEP user, and there's 1-to-1
correspondence with adapters, so that should work currently. But I
don't know (so far...) the big picture / plans for BlueZ design, so not
yet clear to me who should own the pool.

If a2dp_server owns it, as you write below, it's better then to just
have it own the bitmap.

> 
> >         void *user_data;
> >  };
> > 
> > @@ -414,6 +414,8 @@ struct avdtp {
> > 
> >  static GSList *state_callbacks = NULL;
> > 
> > +static GHashTable *adapter_seids = NULL;
> 
> I rather not use glib structures in new code.
> 
> >  static int send_request(struct avdtp *session, gboolean priority,
> >                         struct avdtp_stream *stream, uint8_t signal_id,
> >                         void *buffer, size_t size);
> > @@ -3768,7 +3770,41 @@ int avdtp_delay_report(struct avdtp *session, struct avdtp_stream *stream,
> >                                                         &req, sizeof(req));
> >  }
> > 
> > -struct avdtp_local_sep *avdtp_register_sep(struct queue *lseps, uint8_t type,
> > +static uint8_t get_adapter_seid(struct btd_adapter *adapter)
> > +{
> > +       uint64_t *seids;
> > +
> > +       if (adapter_seids == NULL)
> > +               adapter_seids = g_hash_table_new_full(g_direct_hash,
> > +                                               g_direct_equal, NULL, g_free);
> > +
> > +       seids = g_hash_table_lookup(adapter_seids, adapter);
> > +
> > +       if (seids == NULL) {
> > +               seids = g_new0(uint64_t, 1);
> > +               g_hash_table_insert(adapter_seids, adapter, seids);
> > +       }
> > +
> > +       return util_get_uid(seids, MAX_SEID);
> > +}
> > +
> > +static void clear_adapter_seid(struct btd_adapter *adapter, uint8_t seid)
> > +{
> > +       uint64_t *seids = adapter_seids ?
> > +                       g_hash_table_lookup(adapter_seids, adapter) : NULL;
> > +
> > +       if (seids == NULL)
> > +               return;
> > +
> > +       util_clear_uid(seids, seid);
> > +
> > +       if (*seids == 0)
> > +               g_hash_table_remove(adapter_seids, adapter);
> > +}
> > +
> > +struct avdtp_local_sep *avdtp_register_sep(struct btd_adapter *adapter,
> > +                                               struct queue *lseps,
> > +                                               uint8_t type,
> >                                                 uint8_t media_type,
> >                                                 uint8_t codec_type,
> >                                                 gboolean delay_reporting,
> > @@ -3777,7 +3813,7 @@ struct avdtp_local_sep *avdtp_register_sep(struct queue *lseps, uint8_t type,
> >                                                 void *user_data)
> >  {
> >         struct avdtp_local_sep *sep;
> > -       uint8_t seid = util_get_uid(&seids, MAX_SEID);
> > +       uint8_t seid = get_adapter_seid(adapter);
> 
> Perhaps the uid pool should be passed instead of self generated by
> avdtp.c, that way each server instance can contain its own seid pool
> which can be passed to avdtp_register_sep, or better yet it can pass
> the seid directly so the avdtp.c code is no longer responsible for
> managing it and that is transfer to the caller which is already
> managing the list anyway.

I'll change this to a2dp_server owning the bitmap.

For knowledge of MAX_SEID and error handling, it may be cleaner if the
pool is passed in.

> > 
> >         if (!seid)
> >                 return NULL;
> > @@ -3791,11 +3827,13 @@ struct avdtp_local_sep *avdtp_register_sep(struct queue *lseps, uint8_t type,
> >         sep->codec = codec_type;
> >         sep->ind = ind;
> >         sep->cfm = cfm;
> > +       sep->adapter = adapter;
> >         sep->user_data = user_data;
> >         sep->delay_reporting = delay_reporting;
> > 
> > -       DBG("SEP %p registered: type:%d codec:%d seid:%d", sep,
> > -                       sep->info.type, sep->codec, sep->info.seid);
> > +       DBG("SEP %p registered: type:%d codec:%d adapter:%p seid:%d", sep,
> > +                       sep->info.type, sep->codec, sep->adapter,
> > +                       sep->info.seid);
> > 
> >         if (!queue_push_tail(lseps, sep)) {
> >                 g_free(sep);
> > @@ -3813,10 +3851,11 @@ int avdtp_unregister_sep(struct queue *lseps, struct avdtp_local_sep *sep)
> >         if (sep->stream)
> >                 release_stream(sep->stream, sep->stream->session);
> > 
> > -       DBG("SEP %p unregistered: type:%d codec:%d seid:%d", sep,
> > -                       sep->info.type, sep->codec, sep->info.seid);
> > +       DBG("SEP %p unregistered: type:%d codec:%d adapter:%p seid:%d", sep,
> > +                       sep->info.type, sep->codec, sep->adapter,
> > +                       sep->info.seid);
> > 
> > -       util_clear_uid(&seids, sep->info.seid);
> > +       clear_adapter_seid(sep->adapter, sep->info.seid);
> >         queue_remove(lseps, sep);
> >         g_free(sep);
> > 
> > diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
> > index b02534cd5..70807cff9 100644
> > --- a/profiles/audio/avdtp.h
> > +++ b/profiles/audio/avdtp.h
> > @@ -278,7 +278,9 @@ int avdtp_abort(struct avdtp *session, struct avdtp_stream *stream);
> >  int avdtp_delay_report(struct avdtp *session, struct avdtp_stream *stream,
> >                                                         uint16_t delay);
> > 
> > -struct avdtp_local_sep *avdtp_register_sep(struct queue *lseps, uint8_t type,
> > +struct avdtp_local_sep *avdtp_register_sep(struct btd_adapter *adapter,
> > +                                               struct queue *lseps,
> > +                                               uint8_t type,
> >                                                 uint8_t media_type,
> >                                                 uint8_t codec_type,
> >                                                 gboolean delay_reporting,
> > --
> > 2.31.1
> > 
> 
> 

-- 
Pauli Virtanen

