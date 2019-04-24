Return-Path: <SRS0=Tr5+=S2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D913CC10F11
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Apr 2019 09:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AFCC206A3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Apr 2019 09:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgajpbT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfDXJmg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:42:36 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37143 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfDXJmg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Apr 2019 05:42:36 -0400
Received: by mail-oi1-f193.google.com with SMTP id k6so19790oic.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2019 02:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wwdEWdm5pVQhEnw/zTPFBwBUY9TZY96z8+sCAel6MEs=;
        b=GgajpbT4AFGgqZCSdlC28pPGVs0ov3uHOXIxpKmEs6pbK3gDaiQk7jlk9hex+Bwz/H
         CwKpuJbKU4rpgEsmwZgxxI62nAktYbV+G6FXFV2QXOr34dk88Jjy7dWYfZKtKGGDcWpf
         tZvh3mfRIj4mYI2Ylee266MdIF67lqBfxWg388PqmGAkNGbwEBnkPx58mVUepRIWOsvW
         jnhGRUxvkTSh8fhQldKixQzsVulGkqmhgWNmhWI1eLutICd0maOFG7RAdBsEs7ItfdN4
         1onjMk521xUpBQit2c9EaK9ra8gHrqfGuh3OaoVtASHUqc0c0ZFzFq54F/84R2yHFsT/
         F6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wwdEWdm5pVQhEnw/zTPFBwBUY9TZY96z8+sCAel6MEs=;
        b=unL/i7dWZ+q7sJKhDmAFk0xpEJaVmko//KYN+lpoppz3TFbkaTvbZ+8tIcHXphpFYk
         c5dw4SpUrDboZF/XhBpBHdoYyxpy4FXaxpWFcNFYcP03qPbFJ7Ao0kAdaTG9/WCqFfNU
         yl67OkHJXrcPAVQwFLo32gzZlouOkpi4QNtw4VN/s6iHWP0v3+Oql6HbMTs/SuNvo7JZ
         xIN1Q3rekavLxV8uB+0BqaVvB+f3cc3EWtQn0zPCj8kxruQvn2RwrhdsvqHGE+6haWKC
         HCG6maEV/gAEqvWSKzlyvSrtpDlhL6blWVS1IzSloE9V3Xb5A0dCdu8JDom5hxAg7MLi
         xbFw==
X-Gm-Message-State: APjAAAVLROkyYsjdQfN4p4o1gU1fSf5qS65Y3j9p+fO7KuhlREzxD+eO
        mj/MlTC+R3bFFAXa/buK0XopgsZfpd61zALAQeJUbbPC
X-Google-Smtp-Source: APXvYqyF9EKtwkrNRrAKwxwbsdILpNlZFqo/n7APnLWmk7HWqKjfP0L+UavDTyoNv/6SrF0hscY9e9x5aLvo3Q9mdKs=
X-Received: by 2002:aca:d984:: with SMTP id q126mr5155515oig.108.1556098954486;
 Wed, 24 Apr 2019 02:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190424083921.15679-1-luiz.dentz@gmail.com>
In-Reply-To: <20190424083921.15679-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 24 Apr 2019 12:42:22 +0300
Message-ID: <CABBYNZLcpo_Dx3X9pmKGeqSNFDLKZAqd==6wL5qcthGiqg-EeA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] a2dp: Store last used endpoint
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Wed, Apr 24, 2019 at 11:39 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This stores the last used endpoint whenever it is considered open and
> then prefer to use it when attempting to reconnect.
> ---
>  profiles/audio/a2dp.c | 104 ++++++++++++++++++++++++++++++++++++------
>  1 file changed, 91 insertions(+), 13 deletions(-)
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index 8f141739c..78b02dc84 100644
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
> @@ -2370,14 +2440,22 @@ static struct a2dp_sep *a2dp_find_sep(struct avdtp *session, GSList *list,
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

Can you give this a try, it should make the daemon remember what was
the last endpoint used (locally the remote selection we cannot really
control).


-- 
Luiz Augusto von Dentz
