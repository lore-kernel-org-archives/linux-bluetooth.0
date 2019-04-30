Return-Path: <SRS0=EsMn=TA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1252BC43219
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Apr 2019 12:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5692080C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Apr 2019 12:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACqHyC+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfD3MlT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Apr 2019 08:41:19 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35004 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfD3MlT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Apr 2019 08:41:19 -0400
Received: by mail-ot1-f66.google.com with SMTP id g24so7139071otq.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Apr 2019 05:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=byVuGxKKNLVMVbdyVLLab/qlPUv0kw9a/Lcv1A9LFpg=;
        b=ACqHyC+3x4qoyvXK/lI6mYE0mSya2/nwDqmFRsWUEvn2WZFC5nh/sEgKgDR3ZaFFZa
         fbdE8w11+55eQkUIX1Trr+wSfH7OKS7WJ29AilY7gm7BQWlCtnHGMP+IvdmoGOhftwGv
         1U4HWsoz/JVIDo7r8QKMxYkfxYlmhxv+zTVEjhP+xaW1vUVbmOfsSrXRT/DFBXI/CLpB
         rPgvFQgsGPCcnRj4u8RBBt7MfRTDfmxIvjXcnB6RWzavPm1ITd+nBOn3P2UOAmQkTQgR
         oXCr8T6MC1x9rohEznzKNSg9OuDA28+AWq1F4U3fd9DTr9PtALEFsQXX5Ma7hT0QtKHC
         fkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=byVuGxKKNLVMVbdyVLLab/qlPUv0kw9a/Lcv1A9LFpg=;
        b=iCpNoQpjJLZ9ImbpDiu2DSMyn6sogCNXw/EeOmTLxyq+/WUc10Cn3nYEGePegKb2tw
         PcBvQIAec2r5L6gnG1ZKDLHX3dNjq+clPt59ZA85WycAtAGCDvpoYCRIAy8VIT5CgomU
         lBO4D1QsyZc/NVWWcx+x660LXMtNYnpasf38YdamhfXBKj5YQz4kOTmJaFw7yyBSS/CP
         z3JQrj3gU23i/ulqohCSR95eexoUYZvYaH2rTazJovrxzTZQG9MCzWpWiA/K2VACqwWW
         J06GiWDNii4pQBKuhTnR8BgAGuTJH2R4YHBJFLPJN05mwauvAKavfp2VimeM4kQYhFsu
         x8ww==
X-Gm-Message-State: APjAAAXbWUz1nrWKrgkLYslHrTUraNRA8xXJyLUWFy9/I4vv9K9dw+hj
        DDPSuV1FSOh/4yzlyVmaFnujruGvDaggwxTSoxmCfUV+BHE=
X-Google-Smtp-Source: APXvYqxf87FtqO9Oq1Fh+QLDzClBR9BF3r7ubdUsKc+BYPpVVuVS3fdKQwdMh4/p6VAs06TPuGuCdR6eQD0LXm1loZc=
X-Received: by 2002:a9d:740d:: with SMTP id n13mr7208651otk.291.1556628077629;
 Tue, 30 Apr 2019 05:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190429120259.17880-1-luiz.dentz@gmail.com>
In-Reply-To: <20190429120259.17880-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 30 Apr 2019 15:41:04 +0300
Message-ID: <CABBYNZ+BTro=DxUGqL0XW4TeE0p64P1kQkwt7uOakk_3Pe_phA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] a2dp: Store last used endpoint
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Mon, Apr 29, 2019 at 3:03 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This stores the last used endpoint whenever it is considered open and
> then prefer to use it when attempting to reconnect.
> ---
>  profiles/audio/a2dp.c | 105 ++++++++++++++++++++++++++++++++++++------
>  1 file changed, 92 insertions(+), 13 deletions(-)
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index 8f141739c..a23abdd97 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -147,6 +147,7 @@ struct a2dp_channel {
>         unsigned int auth_id;
>         struct avdtp *session;
>         struct queue *seps;
> +       struct a2dp_remote_sep *last_used;
>  };
>
>  static GSList *servers = NULL;
> @@ -860,6 +861,60 @@ static gboolean open_ind(struct avdtp *session, struct avdtp_local_sep *sep,
>         return TRUE;
>  }
>
> +static bool match_remote_sep(const void *data, const void *user_data)
> +{
> +       const struct a2dp_remote_sep *sep = data;
> +       const struct avdtp_remote_sep *rsep = user_data;
> +
> +       return sep->sep == rsep;
> +}
> +
> +static void store_last_used(struct a2dp_channel *chan,
> +                                       struct avdtp_remote_sep *rsep)
> +{
> +       GKeyFile *key_file;
> +       char filename[PATH_MAX];
> +       char dst_addr[18];
> +       char value[4];
> +       char *data;
> +       size_t len = 0;
> +
> +       ba2str(device_get_address(chan->device), dst_addr);
> +
> +       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s",
> +               btd_adapter_get_storage_dir(device_get_adapter(chan->device)),
> +               dst_addr);
> +       key_file = g_key_file_new();
> +       g_key_file_load_from_file(key_file, filename, 0, NULL);
> +
> +       sprintf(value, "%02hhx", avdtp_get_seid(rsep));
> +
> +       g_key_file_set_string(key_file, "Endpoints", "LastUsed", value);
> +
> +       data = g_key_file_to_data(key_file, &len, NULL);
> +       g_file_set_contents(filename, data, len, NULL);
> +
> +       g_free(data);
> +       g_key_file_free(key_file);
> +}
> +
> +static void update_last_used(struct a2dp_channel *chan,
> +                                               struct avdtp_stream *stream)
> +{
> +       struct avdtp_remote_sep *rsep;
> +       struct a2dp_remote_sep *sep;
> +
> +       rsep = avdtp_stream_get_remote_sep(stream);
> +
> +       /* Update last used */
> +       sep = queue_find(chan->seps, match_remote_sep, rsep);
> +       if (chan->last_used == sep)
> +               return;
> +
> +       chan->last_used = sep;
> +       store_last_used(chan, rsep);
> +}
> +
>  static void open_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
>                         struct avdtp_stream *stream, struct avdtp_error *err,
>                         void *user_data)
> @@ -884,7 +939,8 @@ static void open_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
>                 setup->err = err;
>                 if (setup->start)
>                         finalize_resume(setup);
> -       }
> +       } else if (setup->chan)
> +               update_last_used(setup->chan, stream);
>
>         finalize_config(setup);
>
> @@ -1077,14 +1133,6 @@ static gboolean close_ind(struct avdtp *session, struct avdtp_local_sep *sep,
>         return TRUE;
>  }
>
> -static bool match_remote_sep(const void *data, const void *user_data)
> -{
> -       const struct a2dp_remote_sep *sep = data;
> -       const struct avdtp_remote_sep *rsep = user_data;
> -
> -       return sep->sep == rsep;
> -}
> -
>  static struct a2dp_remote_sep *find_remote_sep(struct a2dp_channel *chan,
>                                                 struct a2dp_sep *sep)
>  {
> @@ -1791,19 +1839,28 @@ done:
>         queue_push_tail(chan->seps, sep);
>  }
>
> +static bool match_seid(const void *data, const void *user_data)
> +{
> +       const struct a2dp_remote_sep *sep = data;
> +       const uint8_t *seid = user_data;
> +
> +       return avdtp_get_seid(sep->sep) == *seid;
> +}
> +
>  static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
>                                                                 char **seids)
>  {
>         struct avdtp_remote_sep *sep;
> +       uint8_t seid;
> +       char *value;
>
>         if (!seids)
>                 return;
>
>         for (; *seids; seids++) {
> -               uint8_t seid;
>                 uint8_t type;
>                 uint8_t codec;
> -               char *value, caps[256];
> +               char caps[256];
>                 uint8_t data[128];
>                 int i, size;
>                 GSList *l = NULL;
> @@ -1847,6 +1904,15 @@ static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
>
>                 register_remote_sep(sep, chan);
>         }
> +
> +       value = g_key_file_get_string(key_file, "Endpoints", "LastUsed", NULL);
> +       if (!value)
> +               return;
> +
> +       if (sscanf(value, "%02hhx", &seid) != 1)
> +               return;
> +
> +       chan->last_used = queue_find(chan->seps, match_seid, &seid);
>  }
>
>  static void load_remote_seps(struct a2dp_channel *chan)
> @@ -2355,8 +2421,12 @@ done:
>  static struct a2dp_sep *a2dp_find_sep(struct avdtp *session, GSList *list,
>                                         const char *sender)
>  {
> +       struct a2dp_sep *first = NULL;
> +       struct a2dp_channel *chan = find_channel(session);
> +
>         for (; list; list = list->next) {
>                 struct a2dp_sep *sep = list->data;
> +               struct avdtp_remote_sep *rsep;
>
>                 /* Use sender's endpoint if available */
>                 if (sender) {
> @@ -2370,14 +2440,23 @@ static struct a2dp_sep *a2dp_find_sep(struct avdtp *session, GSList *list,
>                                 continue;
>                 }
>
> -               if (avdtp_find_remote_sep(session, sep->lsep) == NULL)
> +               rsep = avdtp_find_remote_sep(session, sep->lsep);
> +               if (!rsep)
>                         continue;
>
> +               /* Locate last used if set */
> +               if (chan->last_used) {
> +                       if (chan->last_used->sep == rsep)
> +                               return sep;
> +                       first = sep;
> +                       continue;
> +               }
> +
>                 return sep;
>
>         }
>
> -       return NULL;
> +       return first;
>  }
>
>  static struct a2dp_sep *a2dp_select_sep(struct avdtp *session, uint8_t type,
> --
> 2.20.1

Applied.


-- 
Luiz Augusto von Dentz
