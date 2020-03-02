Return-Path: <SRS0=RPtH=4T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0804FC3F2D1
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Mar 2020 22:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28EC2173E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Mar 2020 22:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMriu6dm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgCBWSc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Mar 2020 17:18:32 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35268 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgCBWSc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Mar 2020 17:18:32 -0500
Received: by mail-oi1-f193.google.com with SMTP id b18so940832oie.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Mar 2020 14:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7zuNMxriEf+womOInX0BwQb1Tw8qII562EpchSc8IGA=;
        b=EMriu6dmNcO81BgesUPJ0h0S43hklIXTvXiO4vBcm5fH0cry2qn2z+dZOSRWxLap9O
         uT/VXtN/e7cs+VTrnPwz+gbWX5OtgwwgZJcGEZF6xsvXQ0YxNk/E/AaVv7dhkpmkhKKB
         B1CzFWxrnC7aniUfMPu+6DnpUmrzxSsllqH6koiMczjR8ux4o43LwkDqdFE4Yvgl6TQN
         YOGScCG40lkjx9Dj1+ODnLlTWCU3n8rTC0xvbo+dHz5gDqVWcG/ZPuXZBY3rI06LM/Tl
         +L8EspG5v/cqn5ATvJcf/DnKtYY7sJRoqmtV2vB5ztyP/gvvfNAlR+pf9WzSadwOy/qV
         I54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7zuNMxriEf+womOInX0BwQb1Tw8qII562EpchSc8IGA=;
        b=Hf0sFWUV7KVOnhsUvcCbJAqsQOa3LE8Lp+a1w9XNLOeoYQxUejgldm5vRx8ugpia36
         mirbJzIod0W1iXbnHCtFxqa+G/2+OP7ZpFas7mri5EHz9ql2IhEMQ6lxkIxK9cE3COhs
         xNCxc5gkdqqV19/EJm7Jka+j+h49Wh6bijRdSbZRPipgqaeBpx0bY/w20z+2QVCL3NL9
         m2k1Cwy/rUWRididRm0PJ/ipHwd83nd1ifpzixPxSviucU+lcENxK4g0eNWin22QT0vb
         U7tDougGxxQrovLxy8GL4vc+LkdSS8nILxh+TRB8S4qgonuVEsPR2T4Vs/nxjDhGS/EC
         Mnhw==
X-Gm-Message-State: ANhLgQ2PXfPAJQFy1seD2t6QuQeiQYPMvrG8EW2wEoxJOKqv1K2XhEoz
        0qTb9X8eCB/gbUlwYdUn9Hn9Fl+I1JgmEO81vWM=
X-Google-Smtp-Source: ADFU+vuCHIzSYz/maH97IMpuj+i8MeS3MgJ8weys3zPpKLNpxRZFQiYXiv8Q67trBx2jLfCZxjcuSj/F/lG+HrmDf5Q=
X-Received: by 2002:a05:6808:10b:: with SMTP id b11mr446567oie.110.1583187510967;
 Mon, 02 Mar 2020 14:18:30 -0800 (PST)
MIME-Version: 1.0
References: <20200302120658.Bluez.v3.1.I3c505b4307094eb7a6f2c5949125a17c89b2e099@changeid>
In-Reply-To: <20200302120658.Bluez.v3.1.I3c505b4307094eb7a6f2c5949125a17c89b2e099@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 2 Mar 2020 14:18:19 -0800
Message-ID: <CABBYNZLSzd4i6FFaTXBXHb+8QmNW8jR1sr9g3hKEOiNMQ4KZjQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v3] src/profile: Ensure class UUID matches before
 connecting profile
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Sun, Mar 1, 2020 at 8:07 PM Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> According to bluetooth spec Ver 5.1, Vol 3, Part B, 4.7.2, there
> might be multiple service records returned in a SDP Service Search
> Attribute Response. Also, according to 2.5.2, the service pattern
> can match any UUID contained within the service record, it doesn't
> have to match only some specific attributes of the record.
>
> Therefore, before using the service record to connect to any
> profile, first we must check that the service class ID of the
> service record matches with whatever UUID specified in the service
> pattern we are looking for.
>
> This patch checks the service class ID of the records against the
> requested UUID whenever bt_search_service() is called and filter
> out the ones that don't match. For the alternative where filtering
> is not applied, use the method bt_search().
>
> ---
>
> Changes in v3:
> - Simplify sdp_client.c
> - Add comment for the behavior when SDP record is missing the
>   service class ID
>
> Changes in v2:
> - Move service class matching from profile.c to sdp_client.c
> - Create function bt_search for searching without matching uuid
> - Update device.c to use bt_search for L2CAP
>
>  src/device.c     | 26 +++++++--------------
>  src/sdp-client.c | 61 ++++++++++++++++++++++++++++++++++++++++++++----
>  src/sdp-client.h |  3 +++
>  3 files changed, 67 insertions(+), 23 deletions(-)
>
> diff --git a/src/device.c b/src/device.c
> index a8f4c22f3..c351a1562 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -4584,27 +4584,18 @@ static void update_bredr_services(struct browse_req *req, sdp_list_t *recs)
>
>         for (seq = recs; seq; seq = seq->next) {
>                 sdp_record_t *rec = (sdp_record_t *) seq->data;
> -               sdp_list_t *svcclass = NULL;
>                 char *profile_uuid;
>
>                 if (!rec)
>                         break;
>
> -               if (sdp_get_service_classes(rec, &svcclass) < 0)
> -                       continue;
> -
> -               /* Check for empty service classes list */
> -               if (svcclass == NULL) {
> -                       DBG("Skipping record with no service classes");
> -                       continue;
> -               }
> +               /* If service class attribute is missing, svclass will be all
> +                * zero and the resulting uuid string will be NULL.
> +                */
> +               profile_uuid = bt_uuid2string(&rec->svclass);
>
> -               /* Extract the first element and skip the remainning */
> -               profile_uuid = bt_uuid2string(svcclass->data);
> -               if (!profile_uuid) {
> -                       sdp_list_free(svcclass, free);
> +               if (!profile_uuid)
>                         continue;
> -               }
>
>                 if (bt_uuid_strcmp(profile_uuid, PNP_UUID) == 0) {
>                         uint16_t source, vendor, product, version;
> @@ -4638,7 +4629,6 @@ static void update_bredr_services(struct browse_req *req, sdp_list_t *recs)
>
>  next:
>                 free(profile_uuid);
> -               sdp_list_free(svcclass, free);
>         }
>
>         if (sdp_key_file) {
> @@ -5352,9 +5342,9 @@ static int device_browse_sdp(struct btd_device *device, DBusMessage *msg)
>
>         req->sdp_flags = get_sdp_flags(device);
>
> -       err = bt_search_service(btd_adapter_get_address(adapter),
> -                               &device->bdaddr, &uuid, browse_cb, req, NULL,
> -                               req->sdp_flags);
> +       err = bt_search(btd_adapter_get_address(adapter),
> +                       &device->bdaddr, &uuid, browse_cb, req, NULL,
> +                       req->sdp_flags);
>         if (err < 0) {
>                 browse_request_free(req);
>                 return err;
> diff --git a/src/sdp-client.c b/src/sdp-client.c
> index 413cf30ec..b92a083af 100644
> --- a/src/sdp-client.c
> +++ b/src/sdp-client.c
> @@ -143,6 +143,7 @@ struct search_context {
>         gpointer                user_data;
>         uuid_t                  uuid;
>         guint                   io_id;
> +       gboolean                filter_svc_class;
>  };
>
>  static GSList *context_list = NULL;
> @@ -195,6 +196,16 @@ static void search_completed_cb(uint8_t type, uint16_t status,
>                 rsp += recsize;
>                 bytesleft -= recsize;
>
> +               /* Check whether service class ID matches some specified uuid.
> +                * If the record is missing service class ID, svclass will be
> +                * all zero, and thus will be unequal to the requested uuid.
> +                */
> +               if (ctxt->filter_svc_class &&
> +                               sdp_uuid_cmp(&ctxt->uuid, &rec->svclass) != 0) {
> +                       sdp_record_free(rec);
> +                       continue;
> +               }
> +
>                 recs = sdp_list_append(recs, rec);
>         } while (scanned < (ssize_t) size && bytesleft > 0);
>
> @@ -338,7 +349,28 @@ static int create_search_context(struct search_context **ctxt,
>         return 0;
>  }
>
> -int bt_search_service(const bdaddr_t *src, const bdaddr_t *dst,
> +static int create_search_context_full(struct search_context **ctxt,
> +                                       const bdaddr_t *src,
> +                                       const bdaddr_t *dst,
> +                                       uuid_t *uuid, uint16_t flags,
> +                                       void *user_data, bt_callback_t cb,
> +                                       bt_destroy_t destroy,
> +                                       gboolean filter_svc_class)
> +{
> +       int err = create_search_context(ctxt, src, dst, uuid, flags);
> +
> +       if (err < 0)
> +               return err;
> +
> +       (*ctxt)->cb = cb;
> +       (*ctxt)->destroy = destroy;
> +       (*ctxt)->user_data = user_data;
> +       (*ctxt)->filter_svc_class = filter_svc_class;
> +
> +       return 0;
> +}
> +
> +int bt_search(const bdaddr_t *src, const bdaddr_t *dst,
>                         uuid_t *uuid, bt_callback_t cb, void *user_data,
>                         bt_destroy_t destroy, uint16_t flags)
>  {
> @@ -348,13 +380,32 @@ int bt_search_service(const bdaddr_t *src, const bdaddr_t *dst,
>         if (!cb)
>                 return -EINVAL;
>
> -       err = create_search_context(&ctxt, src, dst, uuid, flags);
> +       /* The resulting service class ID doesn't have to match uuid */
> +       err = create_search_context_full(&ctxt, src, dst, uuid, flags,
> +                                       user_data, cb, destroy, FALSE);
>         if (err < 0)
>                 return err;
>
> -       ctxt->cb        = cb;
> -       ctxt->destroy   = destroy;
> -       ctxt->user_data = user_data;
> +       context_list = g_slist_append(context_list, ctxt);
> +
> +       return 0;
> +}
> +
> +int bt_search_service(const bdaddr_t *src, const bdaddr_t *dst,
> +                       uuid_t *uuid, bt_callback_t cb, void *user_data,
> +                       bt_destroy_t destroy, uint16_t flags)
> +{
> +       struct search_context *ctxt = NULL;
> +       int err;
> +
> +       if (!cb)
> +               return -EINVAL;
> +
> +       /* The resulting service class ID need to match uuid */
> +       err = create_search_context_full(&ctxt, src, dst, uuid, flags,
> +                                       user_data, cb, destroy, TRUE);
> +       if (err < 0)
> +               return err;
>
>         context_list = g_slist_append(context_list, ctxt);
>
> diff --git a/src/sdp-client.h b/src/sdp-client.h
> index 9aa5a4d98..3a7212fd2 100644
> --- a/src/sdp-client.h
> +++ b/src/sdp-client.h
> @@ -24,6 +24,9 @@
>  typedef void (*bt_callback_t) (sdp_list_t *recs, int err, gpointer user_data);
>  typedef void (*bt_destroy_t) (gpointer user_data);
>
> +int bt_search(const bdaddr_t *src, const bdaddr_t *dst,
> +                       uuid_t *uuid, bt_callback_t cb, void *user_data,
> +                       bt_destroy_t destroy, uint16_t flags);
>  int bt_search_service(const bdaddr_t *src, const bdaddr_t *dst,
>                         uuid_t *uuid, bt_callback_t cb, void *user_data,
>                         bt_destroy_t destroy, uint16_t flags);
> --
> 2.25.0.265.gbab2e86ba0-goog

Applied, thanks.

-- 
Luiz Augusto von Dentz
