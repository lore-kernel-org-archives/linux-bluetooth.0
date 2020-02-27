Return-Path: <SRS0=rxlX=4P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B918C4BA06
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Feb 2020 03:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C02DC222C2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Feb 2020 03:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gge03KAJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgB0Dcl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Feb 2020 22:32:41 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35556 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbgB0Dcl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Feb 2020 22:32:41 -0500
Received: by mail-wm1-f66.google.com with SMTP id m3so1758723wmi.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2020 19:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hJz8lwTUJGKfIW2DU0BMJu536JYhyGaakRgkbk9QwRE=;
        b=gge03KAJPLIjC35uGFVmYgsGG4Yc/s+ZMdYDlhjOsTel7Qt9AEFGszZr7t3leEpCdW
         p0d9clktPQ9yPrMhxCaBVWiKmiuS8CNr625Aiahn7pkVq/EWZn9cpprAhx0onxGkVyas
         vuPka91jE7aRD+pZPV0OO+lDnKYmiStMNMcaGEMs/6tBY0y1X+lI71rbdDI8ox4X5+kB
         o8kz6Sz9+eC08wYMwp82NcjYrJZ5R6xfUFgAK8J/smYOQVqkcORw7vYenkpDjz9KPw3m
         nQFunTdZLKrMq67tJB/hLDLuYWiMDplyl+YMf0G0Ngd++Y2NvKRbIpEp4ydx83TVNbUA
         MyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hJz8lwTUJGKfIW2DU0BMJu536JYhyGaakRgkbk9QwRE=;
        b=c70FT2qd8Jg8ScUTajiGj04guFs9dwGi1cgQ/SG+60taslnEN9cuIwBOjK1ZhZMyl2
         A3FGLAEKej+AcNqZT8lSGm5ViuVQVjU3EAcPf4WPLApzs9D/jsYujfs2/yzYrJttxcGF
         bf9x3xz+PTOJ8fiKn37GFgTjYqx02ei6B7R95vObdpDDlE3FQ1vS5D5kiuSeaESIrcxO
         nsD4+0no1D5CIzLm3u+oaU4NTGsp/2CC48WvWfwt2XwZwC1bW0fZRAqQe8ZKZhuwwfk9
         L6tz8h5YtGkVAMoNr3dVZzVRYYcxIi/Awp4xsuw20GJYWBKBA8hp6bNRKt0DSGjnei/X
         3LZw==
X-Gm-Message-State: APjAAAUifvppiziVnqQ39zs3fcpI4fI4lQf4/hjfc4ZM6YszvV7JMGUY
        IV9xhcnsDKNfzN4ZlBg3EPsZbu6l/Uan+vQvwrfLHjsAGsxoBQ==
X-Google-Smtp-Source: APXvYqyLm4ISPpEVYPSmNvDRnFDG3DGFFHkrA7859RZDsDVjRXX+p7StsnRARMN+4wu73moX6hIqw+fa3MYTz5EfLRA=
X-Received: by 2002:a7b:c249:: with SMTP id b9mr2285323wmj.61.1582774358002;
 Wed, 26 Feb 2020 19:32:38 -0800 (PST)
MIME-Version: 1.0
References: <20200226161257.Bluez.v2.1.I3c505b4307094eb7a6f2c5949125a17c89b2e099@changeid>
 <CABBYNZLK3Ct9kyikQiC4-QPC+xmg8cN30wN=fK8tm6STpmvDGA@mail.gmail.com>
In-Reply-To: <CABBYNZLK3Ct9kyikQiC4-QPC+xmg8cN30wN=fK8tm6STpmvDGA@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Thu, 27 Feb 2020 11:32:26 +0800
Message-ID: <CAJQfnxFaQ2cJBVyktoBCA95TN9dhZf90R0G_DEWgsBvU=1uu9w@mail.gmail.com>
Subject: Re: [Bluez PATCH v2] src/profile: Ensure class UUID matches before
 connecting profile
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Thu, 27 Feb 2020 at 01:55, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Archie,
>
> On Wed, Feb 26, 2020 at 12:14 AM Archie Pusaka <apusaka@google.com> wrote:
> >
> > From: Archie Pusaka <apusaka@chromium.org>
> >
> > According to bluetooth spec Ver 5.1, Vol 3, Part B, 4.7.2, there
> > might be multiple service records returned in a SDP Service Search
> > Attribute Response. Also, according to 2.5.2, the service pattern
> > can match any UUID contained within the service record, it doesn't
> > have to match only some specific attributes of the record.
> >
> > Therefore, before using the service record to connect to any
> > profile, first we must check that the service class ID of the
> > service record matches with whatever UUID specified in the service
> > pattern we are looking for.
> >
> > This patch checks the service class ID of the records against the
> > requested UUID whenever bt_search_service() is called and filter
> > out the ones that don't match. For the alternative where filtering
> > is not applied, use the method bt_search().
> > ---
> >
> > Changes in v2:
> > - Move service class matching from profile.c to sdp_client.c
> > - Create function bt_search for searching without matching uuid
> > - Update device.c to use bt_search for L2CAP
> >
> >  src/device.c     | 17 ++++---------
> >  src/sdp-client.c | 62 ++++++++++++++++++++++++++++++++++++++++++++----
> >  src/sdp-client.h |  3 +++
> >  3 files changed, 64 insertions(+), 18 deletions(-)
> >
> > diff --git a/src/device.c b/src/device.c
> > index a8f4c22f3..5ff381959 100644
> > --- a/src/device.c
> > +++ b/src/device.c
> > @@ -4590,17 +4590,8 @@ static void update_bredr_services(struct browse_req *req, sdp_list_t *recs)
> >                 if (!rec)
> >                         break;
> >
> > -               if (sdp_get_service_classes(rec, &svcclass) < 0)
> > -                       continue;
> > -
> > -               /* Check for empty service classes list */
> > -               if (svcclass == NULL) {
> > -                       DBG("Skipping record with no service classes");
> > -                       continue;
> > -               }
>
> This actually still need to be checked since there could be malformed
> records which don't set a service class, that said perhaps we could
> deal with that in sdp-client.c but it doesn't seem you have added
> these checks there.
>

Those malformed records which did not set a service class will have
the uuid stored in rec->svclass to be filled with all zeroes. This
will be NULL when converted into string, so we will skip that
effectively. But it would be better if I document this behaviour in
a comment.

> > +               profile_uuid = bt_uuid2string(&rec->svclass);
> >
> > -               /* Extract the first element and skip the remainning */
> > -               profile_uuid = bt_uuid2string(svcclass->data);
> >                 if (!profile_uuid) {
> >                         sdp_list_free(svcclass, free);

Actually I can just remove svcclass here (and everywhere else)

> >                         continue;
> > @@ -5352,9 +5343,9 @@ static int device_browse_sdp(struct btd_device *device, DBusMessage *msg)
> >
> >         req->sdp_flags = get_sdp_flags(device);
> >
> > -       err = bt_search_service(btd_adapter_get_address(adapter),
> > -                               &device->bdaddr, &uuid, browse_cb, req, NULL,
> > -                               req->sdp_flags);
> > +       err = bt_search(btd_adapter_get_address(adapter),
> > +                       &device->bdaddr, &uuid, browse_cb, req, NULL,
> > +                       req->sdp_flags);
> >         if (err < 0) {
> >                 browse_request_free(req);
> >                 return err;
> > diff --git a/src/sdp-client.c b/src/sdp-client.c
> > index 413cf30ec..fc8e9ec10 100644
> > --- a/src/sdp-client.c
> > +++ b/src/sdp-client.c
> > @@ -143,6 +143,7 @@ struct search_context {
> >         gpointer                user_data;
> >         uuid_t                  uuid;
> >         guint                   io_id;
> > +       gboolean                filter_svc_class;
> >  };
> >
> >  static GSList *context_list = NULL;
> > @@ -157,6 +158,11 @@ static void search_context_cleanup(struct search_context *ctxt)
> >         g_free(ctxt);
> >  }
> >
> > +static gboolean check_record_uuid(sdp_record_t *rec, uuid_t *uuid)
> > +{
> > +       return sdp_uuid_cmp(uuid, &rec->svclass) == 0;
> > +}
>
> I wouldn't bother adding this function, instead just use sdp_uuid_cmp directly.

Yeah, not super useful. Will compare directly in the next patch.

>
> >  static void search_completed_cb(uint8_t type, uint16_t status,
> >                         uint8_t *rsp, size_t size, void *user_data)
> >  {
> > @@ -195,6 +201,12 @@ static void search_completed_cb(uint8_t type, uint16_t status,
> >                 rsp += recsize;
> >                 bytesleft -= recsize;
> >
> > +               if (ctxt->filter_svc_class &&
> > +                                       !check_record_uuid(rec, &ctxt->uuid)) {
> > +                       sdp_record_free(rec);
> > +                       continue;
> > +               }
> > +
> >                 recs = sdp_list_append(recs, rec);
> >         } while (scanned < (ssize_t) size && bytesleft > 0);
> >
> > @@ -338,7 +350,28 @@ static int create_search_context(struct search_context **ctxt,
> >         return 0;
> >  }
> >
> > -int bt_search_service(const bdaddr_t *src, const bdaddr_t *dst,
> > +static int create_search_context_full(struct search_context **ctxt,
> > +                                       const bdaddr_t *src,
> > +                                       const bdaddr_t *dst,
> > +                                       uuid_t *uuid, uint16_t flags,
> > +                                       void *user_data, bt_callback_t cb,
> > +                                       bt_destroy_t destroy,
> > +                                       gboolean filter_svc_class)
> > +{
> > +       int err = create_search_context(ctxt, src, dst, uuid, flags);
> > +
> > +       if (err < 0)
> > +               return err;
> > +
> > +       (*ctxt)->cb = cb;
> > +       (*ctxt)->destroy = destroy;
> > +       (*ctxt)->user_data = user_data;
> > +       (*ctxt)->filter_svc_class = filter_svc_class;
> > +
> > +       return 0;
> > +}
> > +
> > +int bt_search(const bdaddr_t *src, const bdaddr_t *dst,
> >                         uuid_t *uuid, bt_callback_t cb, void *user_data,
> >                         bt_destroy_t destroy, uint16_t flags)
> >  {
> > @@ -348,13 +381,32 @@ int bt_search_service(const bdaddr_t *src, const bdaddr_t *dst,
> >         if (!cb)
> >                 return -EINVAL;
> >
> > -       err = create_search_context(&ctxt, src, dst, uuid, flags);
> > +       /* The resulting service class ID doesn't have to match uuid */
> > +       err = create_search_context_full(&ctxt, src, dst, uuid, flags,
> > +                                       user_data, cb, destroy, FALSE);
> >         if (err < 0)
> >                 return err;
> >
> > -       ctxt->cb        = cb;
> > -       ctxt->destroy   = destroy;
> > -       ctxt->user_data = user_data;
> > +       context_list = g_slist_append(context_list, ctxt);
> > +
> > +       return 0;
> > +}
> > +
> > +int bt_search_service(const bdaddr_t *src, const bdaddr_t *dst,
> > +                       uuid_t *uuid, bt_callback_t cb, void *user_data,
> > +                       bt_destroy_t destroy, uint16_t flags)
> > +{
> > +       struct search_context *ctxt = NULL;
> > +       int err;
> > +
> > +       if (!cb)
> > +               return -EINVAL;
> > +
> > +       /* The resulting service class ID need to match uuid */
> > +       err = create_search_context_full(&ctxt, src, dst, uuid, flags,
> > +                                       user_data, cb, destroy, TRUE);
> > +       if (err < 0)
> > +               return err;
> >
> >         context_list = g_slist_append(context_list, ctxt);
> >
> > diff --git a/src/sdp-client.h b/src/sdp-client.h
> > index 9aa5a4d98..3a7212fd2 100644
> > --- a/src/sdp-client.h
> > +++ b/src/sdp-client.h
> > @@ -24,6 +24,9 @@
> >  typedef void (*bt_callback_t) (sdp_list_t *recs, int err, gpointer user_data);
> >  typedef void (*bt_destroy_t) (gpointer user_data);
> >
> > +int bt_search(const bdaddr_t *src, const bdaddr_t *dst,
> > +                       uuid_t *uuid, bt_callback_t cb, void *user_data,
> > +                       bt_destroy_t destroy, uint16_t flags);
> >  int bt_search_service(const bdaddr_t *src, const bdaddr_t *dst,
> >                         uuid_t *uuid, bt_callback_t cb, void *user_data,
> >                         bt_destroy_t destroy, uint16_t flags);
> > --
> > 2.25.1.481.gfbce0eb801-goog
>
> Other than that it looks pretty good.
>
> --
> Luiz Augusto von Dentz

Thanks,
Archie
