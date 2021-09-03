Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38C5C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Sep 2021 22:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B67B96101A
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Sep 2021 22:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbhICWux (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Sep 2021 18:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbhICWuw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Sep 2021 18:50:52 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F165CC061575
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Sep 2021 15:49:51 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id p14so601472vsm.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Sep 2021 15:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XAX2U/8mtUmawWtvW6sh0MbLS6kbD2yznGYQpYDhu1U=;
        b=JrOZFn7BHpDJ11i94USSt5o2cV7OEon2xDHXsLIm5+NxPYBHq0HDTvnmwGw1bxW4OA
         lkfCAsf32bqYkT5PGb09Fsp1b+0/epzMZD1+d4PQkjh1Hmi6NMrpH8/RWfTw76OLGGHI
         TnE2vWJmNBo2WADiz71UJvzv9WZapAVA8Ay5X4BB4A8i27gTe/iPEqsVIc/zchnTWXur
         TEyi1lpG7ExWfI2jhOaMjRpkuj6HzrMEB1qDVKiziWp7wpAzsy9kvCPvpurer/d1+37h
         fxGYjgVAzHR73LBbwSPVYfu61RokKZkmfUH/qAecqbTmDBaWcs6bFkq/MOh/2dnwKUhj
         FuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XAX2U/8mtUmawWtvW6sh0MbLS6kbD2yznGYQpYDhu1U=;
        b=s3XFz0QpcAH2eM6JIqVvHz/HiHhdRDxflEMSb3stFF8QqxZb9jGRq6ZXVaYDHZWurk
         MbQIaM1NuPZWT+4LCITZfn9cj/uQBPQ8ezqxcunNOC44oaO1n1hIFTunZEsCqVVWQHyA
         HBlPVNKTN/e+QZC5zwwx3296l4+yUQaEWuVhminvKTg8mHm3oijjauCe3I53TPS8GQGh
         UPQku/eWddEDUzSENgcgsogDDfVAlPzROkc8ZQXuk3GSL5sRFX55QcsFIDdmvqlZc/KM
         8R9vubm8LDT/wpt5uDKMB8D0vs60gsAnDw9dueT0JKz3RL2wsOqtxQWlrPNyjL9iIOfO
         pxNA==
X-Gm-Message-State: AOAM533Aunw6+vEP977hrIikNkmdiMXwhDkL8QG7mFQd6wPbLoJWGjKZ
        ishiekSiorOjyR4+Mgpw4yjQ/hjMdBotO5vTJEhyeBo4
X-Google-Smtp-Source: ABdhPJwttlnitb8EFlgZqFLy2q2SFAcmbp2vbes2SR9NAAv4m3MufrdbquttHk6cSIKMNmIp3LFClVu432CdZ7dWEwg=
X-Received: by 2002:a05:6102:3ec8:: with SMTP id n8mr1057864vsv.39.1630709390850;
 Fri, 03 Sep 2021 15:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210829155012.164880-1-pav@iki.fi> <20210829155012.164880-3-pav@iki.fi>
In-Reply-To: <20210829155012.164880-3-pav@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 3 Sep 2021 15:49:40 -0700
Message-ID: <CABBYNZK6b=HrLWSufVyRwNJ9jnhFaQ3d0dabQY+BW0_qbkNB7A@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] avdtp: use separate local SEID pool for each adapter
To:     Pauli Virtanen <pav@iki.fi>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Sun, Aug 29, 2021 at 8:52 AM Pauli Virtanen <pav@iki.fi> wrote:
>
> Local SEIDs are currently allocated from a pool that is common for all
> adapters. However, AVDTP spec v1.3, sec 4.10 states "To prevent
> conflicts, the scope of the SEID shall be both device-local and
> connection-local. The application is responsible for assigning a SEID,
> which is not in use on the connection to the same peer device." In
> practice, registering the same media application for multiple adapters
> can result to running out of SEIDs, even though the spec does not
> require SEIDs to be unique across adapters.
>
> Use a separate SEID pool for each btd_adapter to fix this.
> ---
>  profiles/audio/a2dp.c  |  2 +-
>  profiles/audio/avdtp.c | 55 ++++++++++++++++++++++++++++++++++++------
>  profiles/audio/avdtp.h |  4 ++-
>  3 files changed, 51 insertions(+), 10 deletions(-)
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index 02caa83e1..1e8a66b8a 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -2615,7 +2615,7 @@ struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
>
>         sep = g_new0(struct a2dp_sep, 1);
>
> -       sep->lsep = avdtp_register_sep(server->seps, type,
> +       sep->lsep = avdtp_register_sep(adapter, server->seps, type,
>                                         AVDTP_MEDIA_TYPE_AUDIO, codec,
>                                         delay_reporting, &endpoint_ind,
>                                         &cfm, sep);

avdtp.c shall not have dependencies on adapter.c, or any btd_ function
that is daemon specific.

> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index 25520ceec..f2aa98b23 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -44,7 +44,6 @@
>  #define AVDTP_PSM 25
>
>  #define MAX_SEID 0x3E
> -static uint64_t seids;
>
>  #ifndef MAX
>  # define MAX(x, y) ((x) > (y) ? (x) : (y))
> @@ -325,6 +324,7 @@ struct avdtp_local_sep {
>         GSList *caps;
>         struct avdtp_sep_ind *ind;
>         struct avdtp_sep_cfm *cfm;
> +       struct btd_adapter *adapter;

We should probably use the list (server->seps) instead to avoid
depending on the btd_adapter here.

>         void *user_data;
>  };
>
> @@ -414,6 +414,8 @@ struct avdtp {
>
>  static GSList *state_callbacks = NULL;
>
> +static GHashTable *adapter_seids = NULL;

I rather not use glib structures in new code.

>  static int send_request(struct avdtp *session, gboolean priority,
>                         struct avdtp_stream *stream, uint8_t signal_id,
>                         void *buffer, size_t size);
> @@ -3768,7 +3770,41 @@ int avdtp_delay_report(struct avdtp *session, struct avdtp_stream *stream,
>                                                         &req, sizeof(req));
>  }
>
> -struct avdtp_local_sep *avdtp_register_sep(struct queue *lseps, uint8_t type,
> +static uint8_t get_adapter_seid(struct btd_adapter *adapter)
> +{
> +       uint64_t *seids;
> +
> +       if (adapter_seids == NULL)
> +               adapter_seids = g_hash_table_new_full(g_direct_hash,
> +                                               g_direct_equal, NULL, g_free);
> +
> +       seids = g_hash_table_lookup(adapter_seids, adapter);
> +
> +       if (seids == NULL) {
> +               seids = g_new0(uint64_t, 1);
> +               g_hash_table_insert(adapter_seids, adapter, seids);
> +       }
> +
> +       return util_get_uid(seids, MAX_SEID);
> +}
> +
> +static void clear_adapter_seid(struct btd_adapter *adapter, uint8_t seid)
> +{
> +       uint64_t *seids = adapter_seids ?
> +                       g_hash_table_lookup(adapter_seids, adapter) : NULL;
> +
> +       if (seids == NULL)
> +               return;
> +
> +       util_clear_uid(seids, seid);
> +
> +       if (*seids == 0)
> +               g_hash_table_remove(adapter_seids, adapter);
> +}
> +
> +struct avdtp_local_sep *avdtp_register_sep(struct btd_adapter *adapter,
> +                                               struct queue *lseps,
> +                                               uint8_t type,
>                                                 uint8_t media_type,
>                                                 uint8_t codec_type,
>                                                 gboolean delay_reporting,
> @@ -3777,7 +3813,7 @@ struct avdtp_local_sep *avdtp_register_sep(struct queue *lseps, uint8_t type,
>                                                 void *user_data)
>  {
>         struct avdtp_local_sep *sep;
> -       uint8_t seid = util_get_uid(&seids, MAX_SEID);
> +       uint8_t seid = get_adapter_seid(adapter);

Perhaps the uid pool should be passed instead of self generated by
avdtp.c, that way each server instance can contain its own seid pool
which can be passed to avdtp_register_sep, or better yet it can pass
the seid directly so the avdtp.c code is no longer responsible for
managing it and that is transfer to the caller which is already
managing the list anyway.

>
>         if (!seid)
>                 return NULL;
> @@ -3791,11 +3827,13 @@ struct avdtp_local_sep *avdtp_register_sep(struct queue *lseps, uint8_t type,
>         sep->codec = codec_type;
>         sep->ind = ind;
>         sep->cfm = cfm;
> +       sep->adapter = adapter;
>         sep->user_data = user_data;
>         sep->delay_reporting = delay_reporting;
>
> -       DBG("SEP %p registered: type:%d codec:%d seid:%d", sep,
> -                       sep->info.type, sep->codec, sep->info.seid);
> +       DBG("SEP %p registered: type:%d codec:%d adapter:%p seid:%d", sep,
> +                       sep->info.type, sep->codec, sep->adapter,
> +                       sep->info.seid);
>
>         if (!queue_push_tail(lseps, sep)) {
>                 g_free(sep);
> @@ -3813,10 +3851,11 @@ int avdtp_unregister_sep(struct queue *lseps, struct avdtp_local_sep *sep)
>         if (sep->stream)
>                 release_stream(sep->stream, sep->stream->session);
>
> -       DBG("SEP %p unregistered: type:%d codec:%d seid:%d", sep,
> -                       sep->info.type, sep->codec, sep->info.seid);
> +       DBG("SEP %p unregistered: type:%d codec:%d adapter:%p seid:%d", sep,
> +                       sep->info.type, sep->codec, sep->adapter,
> +                       sep->info.seid);
>
> -       util_clear_uid(&seids, sep->info.seid);
> +       clear_adapter_seid(sep->adapter, sep->info.seid);
>         queue_remove(lseps, sep);
>         g_free(sep);
>
> diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
> index b02534cd5..70807cff9 100644
> --- a/profiles/audio/avdtp.h
> +++ b/profiles/audio/avdtp.h
> @@ -278,7 +278,9 @@ int avdtp_abort(struct avdtp *session, struct avdtp_stream *stream);
>  int avdtp_delay_report(struct avdtp *session, struct avdtp_stream *stream,
>                                                         uint16_t delay);
>
> -struct avdtp_local_sep *avdtp_register_sep(struct queue *lseps, uint8_t type,
> +struct avdtp_local_sep *avdtp_register_sep(struct btd_adapter *adapter,
> +                                               struct queue *lseps,
> +                                               uint8_t type,
>                                                 uint8_t media_type,
>                                                 uint8_t codec_type,
>                                                 gboolean delay_reporting,
> --
> 2.31.1
>


-- 
Luiz Augusto von Dentz
