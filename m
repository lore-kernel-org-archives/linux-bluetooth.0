Return-Path: <SRS0=fAjn=S7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C72DC43219
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Apr 2019 16:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF57320675
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Apr 2019 16:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0PE+pT/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbfD2Qfi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Apr 2019 12:35:38 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34412 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbfD2Qfi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Apr 2019 12:35:38 -0400
Received: by mail-ot1-f65.google.com with SMTP id n15so3138122ota.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Apr 2019 09:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0kXE/uL5/IiGRrZ/pGU6A9nefg3A5RGbGoG43V564fQ=;
        b=b0PE+pT/9ivi4tfT3TSwnNjxgcNJ5o5cbkJ95/4Tp02nX88gYPdlmf7wlM4Sq3FU6q
         wBkDFtLf3am1QlwrrmcyRs/CtY70i7oGwGjbD7Bn3izTb2I4DaR8jOEeQ5kCAPQINSCD
         rMvob1KAe8wB1opu+P+bTTjcqbitvvdgh17ieI4l5+Tq3zmU7yaldI5ROJVrpfq5sbh6
         EFJtcC6xMtlhoj9aHR9gWqe/pjAL6O1JG1PJ8pXRQj/ZBAgoQoVu2HY+nX8VY/TE4E/7
         uoyyuWRZccGBHmXkOiPcoCUIUxV7eUavFcKxNTk1GKXpkLUE0u7j9RkB3sEZ08uTK9oM
         yJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0kXE/uL5/IiGRrZ/pGU6A9nefg3A5RGbGoG43V564fQ=;
        b=Gan5caSoyEuJxt8H0mv5qAs85M05SVSzNtEQMuvaaV8xwOciGBHkKcKJ6B5i9qcj/D
         tCiu7h8MjGkM9dKQDvcnJKq0sWnTV2spcU0ldoWWLV/MwfTmRgel4QSVs9fWzE/BNzqW
         8P2lckgg+yhUHv2V5nSqZTq3zw93vqA+jl9/5D+eOleEvlcEKPrpMXT34M0QSPd6m8/r
         csguE39CcjtPv5hGmuhYqFxGgeTqxUZWGSzyUKF2oSEeljxb74ANMjhbkhmtu9ImqR+Q
         7imLcz5ZUCu4Jhb/xr8BBVeOlRq9N6t+h4o3pyKdJk5iuCGWMDdX7V27F24pGcKXh2em
         Ht5w==
X-Gm-Message-State: APjAAAUAUskS2TxKlkvyzakMQb0Dr25iXOblV695j+y4vXAY7uK853XI
        t44EYvwpAduZ+ZcIuIiFyURtVl9m8Qvujhnbd64juw3NoKg=
X-Google-Smtp-Source: APXvYqw3s0OTUwysHjQILLHMfjCrEtSoonrklNzNimpxaqwd6lYWKED6IbGNgjc9MOAIzeA7tq9Ru7kpxTKSAkyk4o4=
X-Received: by 2002:a9d:3289:: with SMTP id u9mr36780734otb.52.1556555736614;
 Mon, 29 Apr 2019 09:35:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190429120259.17880-1-luiz.dentz@gmail.com> <20190429120259.17880-3-luiz.dentz@gmail.com>
In-Reply-To: <20190429120259.17880-3-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 29 Apr 2019 19:35:24 +0300
Message-ID: <CABBYNZK1LRANfR6cwu+xbLsvy4EnB+ZPS78JNK04mJ=pwTGSDw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] a2dp: Fix not calling SelectConfiguration on other
 available endpoints
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Mon, Apr 29, 2019 at 3:03 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Endpoint may not be able to select a valid configuration but there could
> be other endpoints available that could be used, so instead of just
> using the first match this collects all the matching endpoints and put
> them into a queue (ordered by priority) then proceed to next endpoint
> only failing if none of the available endpoits can select a valid
> configuration.
> ---
>  profiles/audio/a2dp.c | 77 ++++++++++++++++++++++++++++---------------
>  1 file changed, 50 insertions(+), 27 deletions(-)
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index a23abdd97..4d378a91a 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -105,6 +105,7 @@ struct a2dp_setup_cb {
>  struct a2dp_setup {
>         struct a2dp_channel *chan;
>         struct avdtp *session;
> +       struct queue *eps;
>         struct a2dp_sep *sep;
>         struct a2dp_remote_sep *rsep;
>         struct avdtp_stream *stream;
> @@ -2406,23 +2407,44 @@ void a2dp_remove_sep(struct a2dp_sep *sep)
>
>  static void select_cb(struct a2dp_setup *setup, void *ret, int size)
>  {
> -       if (size < 0) {
> -               DBG("Endpoint replied an invalid configuration");
> +       struct avdtp_service_capability *service;
> +       struct avdtp_media_codec_capability *codec;
> +       int err;
> +
> +       if (size) {
> +               caps_add_codec(&setup->caps, setup->sep->codec, ret, size);
>                 goto done;
>         }
>
> -       caps_add_codec(&setup->caps, setup->sep->codec, ret, size);
> +       setup->sep = queue_pop_head(setup->eps);
> +       if (!setup->sep) {
> +               error("Unable to select a valid configuration");
> +               queue_destroy(setup->eps, NULL);
> +               goto done;
> +       }
> +
> +       setup->rsep = find_remote_sep(setup->chan, setup->sep);
> +       service = avdtp_get_codec(setup->rsep->sep);
> +       codec = (struct avdtp_media_codec_capability *) service->data;
> +
> +       err = setup->sep->endpoint->select_configuration(setup->sep,
> +                                       codec->data,
> +                                       service->length - sizeof(*codec),
> +                                       setup_ref(setup),
> +                                       select_cb, setup->sep->user_data);
> +       if (err == 0)
> +               return;
>
>  done:
>         finalize_select(setup);
>         setup_unref(setup);
>  }
>
> -static struct a2dp_sep *a2dp_find_sep(struct avdtp *session, GSList *list,
> +static struct queue *a2dp_find_eps(struct avdtp *session, GSList *list,
>                                         const char *sender)
>  {
> -       struct a2dp_sep *first = NULL;
>         struct a2dp_channel *chan = find_channel(session);
> +       struct queue *seps = NULL;
>
>         for (; list; list = list->next) {
>                 struct a2dp_sep *sep = list->data;
> @@ -2444,26 +2466,25 @@ static struct a2dp_sep *a2dp_find_sep(struct avdtp *session, GSList *list,
>                 if (!rsep)
>                         continue;
>
> -               /* Locate last used if set */
> -               if (chan->last_used) {
> -                       if (chan->last_used->sep == rsep)
> -                               return sep;
> -                       first = sep;
> -                       continue;
> -               }
> +               if (!seps)
> +                       seps = queue_new();
>
> -               return sep;
> +               /* Prepend last used so it is preferred over others */
> +               if (chan->last_used && chan->last_used->sep == rsep)
> +                       queue_push_head(seps, sep);
> +               else
> +                       queue_push_tail(seps, sep);
>
>         }
>
> -       return first;
> +       return seps;
>  }
>
> -static struct a2dp_sep *a2dp_select_sep(struct avdtp *session, uint8_t type,
> +static struct queue *a2dp_select_eps(struct avdtp *session, uint8_t type,
>                                         const char *sender)
>  {
>         struct a2dp_server *server;
> -       struct a2dp_sep *sep;
> +       struct queue *seps;
>         GSList *l;
>
>         server = find_server(servers, avdtp_get_adapter(session));
> @@ -2473,11 +2494,11 @@ static struct a2dp_sep *a2dp_select_sep(struct avdtp *session, uint8_t type,
>         l = type == AVDTP_SEP_TYPE_SINK ? server->sources : server->sinks;
>
>         /* Check sender's seps first */
> -       sep = a2dp_find_sep(session, l, sender);
> -       if (sep != NULL)
> -               return sep;
> +       seps = a2dp_find_eps(session, l, sender);
> +       if (seps != NULL)
> +               return seps;
>
> -       return a2dp_find_sep(session, l, NULL);
> +       return a2dp_find_eps(session, l, NULL);
>  }
>
>  static void store_remote_sep(void *data, void *user_data)
> @@ -2580,13 +2601,13 @@ unsigned int a2dp_select_capabilities(struct avdtp *session,
>  {
>         struct a2dp_setup *setup;
>         struct a2dp_setup_cb *cb_data;
> -       struct a2dp_sep *sep;
> +       struct queue *eps;
>         struct avdtp_service_capability *service;
>         struct avdtp_media_codec_capability *codec;
>         int err;
>
> -       sep = a2dp_select_sep(session, type, sender);
> -       if (!sep) {
> +       eps = a2dp_select_eps(session, type, sender);
> +       if (!eps) {
>                 error("Unable to select SEP");
>                 return 0;
>         }
> @@ -2599,8 +2620,9 @@ unsigned int a2dp_select_capabilities(struct avdtp *session,
>         cb_data->select_cb = cb;
>         cb_data->user_data = user_data;
>
> -       setup->sep = sep;
> -       setup->rsep = find_remote_sep(setup->chan, sep);
> +       setup->eps = eps;
> +       setup->sep = queue_pop_head(eps);
> +       setup->rsep = find_remote_sep(setup->chan, setup->sep);
>
>         if (setup->rsep == NULL) {
>                 error("Could not find remote sep");
> @@ -2610,10 +2632,11 @@ unsigned int a2dp_select_capabilities(struct avdtp *session,
>         service = avdtp_get_codec(setup->rsep->sep);
>         codec = (struct avdtp_media_codec_capability *) service->data;
>
> -       err = sep->endpoint->select_configuration(sep, codec->data,
> +       err = setup->sep->endpoint->select_configuration(setup->sep,
> +                                       codec->data,
>                                         service->length - sizeof(*codec),
>                                         setup_ref(setup),
> -                                       select_cb, sep->user_data);
> +                                       select_cb, setup->sep->user_data);
>         if (err == 0)
>                 return cb_data->id;
>
> --
> 2.20.1

Le me know if you find any problem with this change, my headsets seems
to always succeed the first try so I cannot really reproduce the
problem.


-- 
Luiz Augusto von Dentz
