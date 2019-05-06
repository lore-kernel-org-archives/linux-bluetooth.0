Return-Path: <SRS0=wqlf=TG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9813CC04A6B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 May 2019 12:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AAEB20830
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 May 2019 12:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCZZS3kn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbfEFMqS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 May 2019 08:46:18 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45453 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfEFMqS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 May 2019 08:46:18 -0400
Received: by mail-ot1-f68.google.com with SMTP id a10so11273627otl.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 May 2019 05:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AmOb+VmNSkDlVE63gOooVRjb5juknlc//VXlbBE1pIs=;
        b=fCZZS3knMBdTI11uQWcGb/nOdxVOo8n2hqEKKNUQ280LMNomAyjeO3IFS6fpOawYGC
         aozhvK3mnuWyg7CfGMA6ELO26sHCN6tuU99oHuzQ6kS5gCg13FzKmGTpNYlnL2eDvevh
         ClBwaNZlf549xpbyQARVkzVgUzfHkm77XW8PKGI6AjVyLxW8H1qCU0MENDMReYzOgmV0
         hKXo/HEviJ9Rvnc1LNqCtJtBD7hFAZ+5aE7raQYsQFeUlQ0GjOEH9NO28Jt4GasCDe1u
         YTWVS7RwxZehEA7oaNnglNR96pvp09ozedgZ9HRGdgM1Z6UDjfTxmgzZ9iqmVOK9vwjh
         VYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AmOb+VmNSkDlVE63gOooVRjb5juknlc//VXlbBE1pIs=;
        b=oO2xG06AYkHuIU5vXz+fdwyEy3nAyHfiZ+eyrfZFDSuedm9pM7HWsNe6FFNgnSdw9G
         re1qkwNR/Bl7EXWPTCeh38uuZulpPRfsIlqapIEPY/qXodwtTriKEylfqQJZS1AwS1H9
         rvh1axXtjaiZkMbzfDhafJU2n3C7mOL7IDU3FAeiOnJde4LIPRcSUFTyRlMlA/xhV9Lw
         ZQ0v4YiwBC8SED5oHfKKXulADMCQ5Py0eXoG/XOLFCc8kWvVii0I9I1XV83hHEKg5ls6
         2pF7cqeV44e+gdCT+rb4L3OT+WhgDwzeGBEGMoQrQOuGIxyuOYPAgVeV07HZViijqzHL
         thag==
X-Gm-Message-State: APjAAAXMgI5NgHnHUF5GEs58KIXd4L2+veDfq4sUIYoC8fwPVijLkTbC
        vKdJ9TQGJ787y3ef6RphZC+3oZ/sXHjRCxc3RRfFQgfrqUs=
X-Google-Smtp-Source: APXvYqy9D5Eb3GwjszrGURMPYGjUuRL9Lr2YdE17ykHd1obLOw1TOEBeGCYFtc603r/vTDBfh0QpD18EqFdlq5g5CbU=
X-Received: by 2002:a9d:39c3:: with SMTP id y61mr13150449otb.84.1557146777199;
 Mon, 06 May 2019 05:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190506124310.19151-1-luiz.dentz@gmail.com> <20190506124310.19151-6-luiz.dentz@gmail.com>
In-Reply-To: <20190506124310.19151-6-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 6 May 2019 15:46:03 +0300
Message-ID: <CABBYNZJ4+Be+sAXVAL_96qov5Go3BpRwmJtkdOVXC4apfL2K9A@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] a2dp: Reword LastUsed
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Mon, May 6, 2019 at 3:43 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> In addition to storing the remote endpoint also store the local one as
> well so we it can properly be restore.
> ---
>  profiles/audio/a2dp.c  | 147 +++++++++++++++++++++++++++++++----------
>  profiles/audio/avdtp.c |   5 ++
>  profiles/audio/avdtp.h |   1 +
>  3 files changed, 119 insertions(+), 34 deletions(-)
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index b54c50315..046193688 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -139,6 +139,11 @@ struct a2dp_remote_sep {
>         struct avdtp_remote_sep *sep;
>  };
>
> +struct a2dp_last_used {
> +       struct a2dp_sep *lsep;
> +       struct a2dp_remote_sep *rsep;
> +};
> +
>  struct a2dp_channel {
>         struct a2dp_server *server;
>         struct btd_device *device;
> @@ -148,7 +153,7 @@ struct a2dp_channel {
>         unsigned int auth_id;
>         struct avdtp *session;
>         struct queue *seps;
> -       struct a2dp_remote_sep *last_used;
> +       struct a2dp_last_used *last_used;
>  };
>
>  static GSList *servers = NULL;
> @@ -214,6 +219,8 @@ static void setup_free(struct a2dp_setup *s)
>                 g_io_channel_unref(s->io);
>         }
>
> +       queue_destroy(s->eps, NULL);
> +
>         setups = g_slist_remove(setups, s);
>         if (s->session)
>                 avdtp_unref(s->session);
> @@ -844,13 +851,13 @@ static bool match_remote_sep(const void *data, const void *user_data)
>         return sep->sep == rsep;
>  }
>
> -static void store_last_used(struct a2dp_channel *chan,
> -                                       struct avdtp_remote_sep *rsep)
> +static void store_last_used(struct a2dp_channel *chan, uint8_t lseid,
> +                                                       uint8_t rseid)
>  {
>         GKeyFile *key_file;
>         char filename[PATH_MAX];
>         char dst_addr[18];
> -       char value[4];
> +       char value[6];
>         char *data;
>         size_t len = 0;
>
> @@ -862,7 +869,7 @@ static void store_last_used(struct a2dp_channel *chan,
>         key_file = g_key_file_new();
>         g_key_file_load_from_file(key_file, filename, 0, NULL);
>
> -       sprintf(value, "%02hhx", avdtp_get_seid(rsep));
> +       sprintf(value, "%02hhx:%02hhx", lseid, rseid);
>
>         g_key_file_set_string(key_file, "Endpoints", "LastUsed", value);
>
> @@ -873,21 +880,38 @@ static void store_last_used(struct a2dp_channel *chan,
>         g_key_file_free(key_file);
>  }
>
> -static void update_last_used(struct a2dp_channel *chan,
> -                                               struct avdtp_stream *stream)
> +static void add_last_used(struct a2dp_channel *chan, struct a2dp_sep *lsep,
> +                               struct a2dp_remote_sep *rsep)
> +{
> +       if (!chan->last_used)
> +               chan->last_used = new0(struct a2dp_last_used, 1);
> +
> +       chan->last_used->lsep = lsep;
> +       chan->last_used->rsep = rsep;
> +}
> +
> +static void update_last_used(struct a2dp_channel *chan, struct a2dp_sep *lsep,
> +                                       struct avdtp_stream *stream)
>  {
>         struct avdtp_remote_sep *rsep;
>         struct a2dp_remote_sep *sep;
>
>         rsep = avdtp_stream_get_remote_sep(stream);
> -
> -       /* Update last used */
>         sep = queue_find(chan->seps, match_remote_sep, rsep);
> -       if (chan->last_used == sep)
> +       if (!sep) {
> +               error("Unable to find remote SEP");
>                 return;
> +       }
> +
> +       /* Check if already stored then skip */
> +       if (chan->last_used && (chan->last_used->lsep == lsep &&
> +                               chan->last_used->rsep == sep))
> +               return;
> +
> +       add_last_used(chan, lsep, sep);
>
> -       chan->last_used = sep;
> -       store_last_used(chan, rsep);
> +       store_last_used(chan, avdtp_sep_get_seid(lsep->lsep),
> +                                       avdtp_get_seid(rsep));
>  }
>
>  static gboolean open_ind(struct avdtp *session, struct avdtp_local_sep *sep,
> @@ -909,7 +933,7 @@ static gboolean open_ind(struct avdtp *session, struct avdtp_local_sep *sep,
>         setup->stream = stream;
>
>         if (!err && setup->chan)
> -               update_last_used(setup->chan, stream);
> +               update_last_used(setup->chan, a2dp_sep, stream);
>
>         if (setup->reconfigure)
>                 setup->reconfigure = FALSE;
> @@ -944,7 +968,7 @@ static void open_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
>                 if (setup->start)
>                         finalize_resume(setup);
>         } else if (setup->chan)
> -               update_last_used(setup->chan, stream);
> +               update_last_used(setup->chan, a2dp_sep, stream);
>
>         finalize_config(setup);
>
> @@ -1483,6 +1507,7 @@ static void channel_free(void *data)
>         avdtp_remove_state_cb(chan->state_id);
>
>         queue_destroy(chan->seps, remove_remote_sep);
> +       free(chan->last_used);
>         g_free(chan);
>  }
>
> @@ -1631,6 +1656,9 @@ static int a2dp_reconfig(struct a2dp_channel *chan, const char *sender,
>         setup->sep = lsep;
>         setup->rsep = rsep;
>
> +       g_slist_free_full(setup->caps, g_free);
> +       setup->caps = NULL;
> +
>         caps_add_codec(&setup->caps, setup->sep->codec, caps, size);
>
>         l = avdtp_get_type(rsep->sep) == AVDTP_SEP_TYPE_SINK ?
> @@ -1871,11 +1899,37 @@ static bool match_seid(const void *data, const void *user_data)
>         return avdtp_get_seid(sep->sep) == *seid;
>  }
>
> +static int match_sep(const void *data, const void *user_data)
> +{
> +       struct a2dp_sep *sep = (void *) data;
> +       const uint8_t *seid = user_data;
> +
> +       return *seid - avdtp_sep_get_seid(sep->lsep);
> +}
> +
> +static struct a2dp_sep *find_sep_by_seid(struct a2dp_server *server,
> +                                                       uint8_t seid)
> +{
> +       GSList *l;
> +
> +       l = g_slist_find_custom(server->sources, &seid, match_sep);
> +       if (l)
> +               return l->data;
> +
> +       l = g_slist_find_custom(server->sinks, &seid, match_sep);
> +       if (l)
> +               return l->data;
> +
> +       return NULL;
> +}
> +
>  static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
>                                                                 char **seids)
>  {
> -       struct avdtp_remote_sep *sep;
> -       uint8_t seid;
> +       struct a2dp_sep *lsep;
> +       struct a2dp_remote_sep *sep;
> +       struct avdtp_remote_sep *rsep;
> +       uint8_t lseid, rseid;
>         char *value;
>
>         if (!seids)
> @@ -1884,12 +1938,12 @@ static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
>         for (; *seids; seids++) {
>                 uint8_t type;
>                 uint8_t codec;
> +               GSList *l = NULL;
>                 char caps[256];
>                 uint8_t data[128];
>                 int i, size;
> -               GSList *l = NULL;
>
> -               if (sscanf(*seids, "%02hhx", &seid) != 1)
> +               if (sscanf(*seids, "%02hhx", &rseid) != 1)
>                         continue;
>
>                 value = g_key_file_get_string(key_file, "Endpoints", *seids,
> @@ -1899,7 +1953,7 @@ static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
>
>                 if (sscanf(value, "%02hhx:%02hhx:%s", &type, &codec,
>                                                                 caps) != 3) {
> -                       warn("Unable to load Endpoint: seid %u", seid);
> +                       warn("Unable to load Endpoint: seid %u", rseid);
>                         g_free(value);
>                         continue;
>                 }
> @@ -1908,7 +1962,8 @@ static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
>                         uint8_t *tmp = data + i / 2;
>
>                         if (sscanf(caps + i, "%02hhx", tmp) != 1) {
> -                               warn("Unable to load Endpoint: seid %u", seid);
> +                               warn("Unable to load Endpoint: seid %u", rseid);
> +                               g_free(value);
>                                 break;
>                         }
>                 }
> @@ -1920,23 +1975,39 @@ static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
>
>                 caps_add_codec(&l, codec, data, size / 2);
>
> -               sep = avdtp_register_remote_sep(chan->session, seid, type, l);
> -               if (!sep) {
> -                       warn("Unable to register Endpoint: seid %u", seid);
> +               rsep = avdtp_register_remote_sep(chan->session, rseid, type, l);
> +               if (!rsep) {
> +                       warn("Unable to register Endpoint: seid %u", rseid);
>                         continue;
>                 }
>
> -               register_remote_sep(sep, chan);
> +               register_remote_sep(rsep, chan);
>         }
>
>         value = g_key_file_get_string(key_file, "Endpoints", "LastUsed", NULL);
>         if (!value)
>                 return;
>
> -       if (sscanf(value, "%02hhx", &seid) != 1)
> +       if (sscanf(value, "%02hhx:%02hhx", &lseid, &rseid) != 2) {
> +               warn("Unable to load LastUsed");
> +               return;
> +       }
> +
> +       g_free(value);
> +
> +       lsep = find_sep_by_seid(chan->server, lseid);
> +       if (!lsep) {
> +               warn("Unable to load LastUsed: lseid %u not found", lseid);
>                 return;
> +       }
>
> -       chan->last_used = queue_find(chan->seps, match_seid, &seid);
> +       sep = queue_find(chan->seps, match_seid, &rseid);
> +       if (!sep) {
> +               warn("Unable to load LastUsed: rseid %u not found", rseid);
> +               return;
> +       }
> +
> +       add_last_used(chan, lsep, sep);
>  }
>
>  static void load_remote_seps(struct a2dp_channel *chan)
> @@ -2442,7 +2513,6 @@ static void select_cb(struct a2dp_setup *setup, void *ret, int size)
>         setup->sep = queue_pop_head(setup->eps);
>         if (!setup->sep) {
>                 error("Unable to select a valid configuration");
> -               queue_destroy(setup->eps, NULL);
>                 goto done;
>         }
>
> @@ -2453,7 +2523,7 @@ static void select_cb(struct a2dp_setup *setup, void *ret, int size)
>         err = setup->sep->endpoint->select_configuration(setup->sep,
>                                         codec->data,
>                                         service->length - sizeof(*codec),
> -                                       setup_ref(setup),
> +                                       setup,
>                                         select_cb, setup->sep->user_data);
>         if (err == 0)
>                 return;
> @@ -2493,11 +2563,11 @@ static struct queue *a2dp_find_eps(struct avdtp *session, GSList *list,
>                         seps = queue_new();
>
>                 /* Prepend last used so it is preferred over others */
> -               if (chan->last_used && chan->last_used->sep == rsep)
> +               if (chan->last_used && (chan->last_used->lsep == sep &&
> +                                       chan->last_used->rsep->sep == rsep))
>                         queue_push_head(seps, sep);
>                 else
>                         queue_push_tail(seps, sep);
> -
>         }
>
>         return seps;
> @@ -2566,11 +2636,18 @@ static void store_remote_seps(struct a2dp_channel *chan)
>         key_file = g_key_file_new();
>         g_key_file_load_from_file(key_file, filename, 0, NULL);
>
> +       data = g_key_file_get_string(key_file, "Endpoints", "LastUsed", NULL);
> +
>         /* Remove current endpoints since it might have changed */
>         g_key_file_remove_group(key_file, "Endpoints", NULL);
>
>         queue_foreach(chan->seps, store_remote_sep, key_file);
>
> +       if (data) {
> +               g_key_file_set_string(key_file, "Endpoints", "LastUsed", data);
> +               g_free(data);
> +       }
> +
>         data = g_key_file_to_data(key_file, &length, NULL);
>         g_file_set_contents(filename, data, length, NULL);
>
> @@ -2656,10 +2733,12 @@ unsigned int a2dp_select_capabilities(struct avdtp *session,
>         codec = (struct avdtp_media_codec_capability *) service->data;
>
>         err = setup->sep->endpoint->select_configuration(setup->sep,
> -                                       codec->data,
> -                                       service->length - sizeof(*codec),
> -                                       setup_ref(setup),
> -                                       select_cb, setup->sep->user_data);
> +                                                       codec->data,
> +                                                       service->length -
> +                                                       sizeof(*codec),
> +                                                       setup_ref(setup),
> +                                                       select_cb,
> +                                                       setup->sep->user_data);
>         if (err == 0)
>                 return cb_data->id;
>
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index f4c9a2ed8..91b1e4b96 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -3710,6 +3710,11 @@ avdtp_state_t avdtp_sep_get_state(struct avdtp_local_sep *sep)
>         return sep->state;
>  }
>
> +uint8_t avdtp_sep_get_seid(struct avdtp_local_sep *sep)
> +{
> +       return sep->info.seid;
> +}
> +
>  struct btd_adapter *avdtp_get_adapter(struct avdtp *session)
>  {
>         return device_get_adapter(session->device);
> diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
> index b03ca9030..ad2cb9bcb 100644
> --- a/profiles/audio/avdtp.h
> +++ b/profiles/audio/avdtp.h
> @@ -296,6 +296,7 @@ struct avdtp_remote_sep *avdtp_find_remote_sep(struct avdtp *session,
>  int avdtp_unregister_sep(struct queue *lseps, struct avdtp_local_sep *sep);
>
>  avdtp_state_t avdtp_sep_get_state(struct avdtp_local_sep *sep);
> +uint8_t avdtp_sep_get_seid(struct avdtp_local_sep *sep);
>
>  void avdtp_error_init(struct avdtp_error *err, uint8_t type, int id);
>  const char *avdtp_strerror(struct avdtp_error *err);
> --
> 2.20.1

I hope this fixes the problems you have been seeing, it should at
least take care of the issues with wrong order of SelectConfiguration
and restoring the exact same endpoint used last time.


-- 
Luiz Augusto von Dentz
