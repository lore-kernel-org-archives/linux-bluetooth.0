Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040EEC4167E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jan 2022 22:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiAYWUY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jan 2022 17:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbiAYWUN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jan 2022 17:20:13 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946E6C06173B
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 14:20:13 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 23so65840167ybf.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 14:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nci8tIAmJ0hfFPnXQ0s6maYUikMg+tK790vQDUtwbCk=;
        b=WwU9UxS6nUKrLh6Gl7kXie6s0ZS7lGgMauaCfO84SijEx2Mjv+aPArmgFvJpMQbrwO
         WMsw0nSi5q02FpkQ5Ln8/gmr5z85r5IFCD8lfKrdGL2lyFz+eDPmHwo+A/DGwdnMtYHk
         WFxD+5Zqh6wvQij0s3JVFIQ6XxmOL+ZQqDHp7uKQuMtuELQznzkX9R4D9iaEl4Rgcs8F
         cYEMt5yW3CDaf88yoDAeI7ZmXGrITvn99XqU24xHQBZwRpC3sKSJ2pWdEBnSeTiFxW4B
         kz5d9d/k8bnc2WZ/sUxcG/88oxqbg0mW2g909KguyxbaDvy2v/7cN553m1GvX+JLQpJ0
         Swdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nci8tIAmJ0hfFPnXQ0s6maYUikMg+tK790vQDUtwbCk=;
        b=YaH2BCxQ2KdaZOpULbSnNR3/oEy6Z/F5O6e++7fnX5yfraYuiH87VNrWqdKT1ombIP
         emi8/9+XBlznRkjmihF5dmFhO5oMwJyokF646OJ80SJMk9NBT6S8VJR06xFrth39Ki9g
         Qu+Ox5WeOkWtZM4QRCQVPyl5XwN+5YubuRH67Utv7b0NpqPPRX+hu8jTs78GBpfyE5eC
         YWx7Zf5wywwjYJGp/5HgCJ9a90S727O4Xf+gZ+chkHSjE72avErwwryP4lze4OpusVrI
         BTe+JKZtJHmcK+wLyoZLSdW/oIhYMw+a3+f8V318oi6TRbCgVfuM+tbR9ow9Wp/OdDM7
         /c9A==
X-Gm-Message-State: AOAM531qsqX3BkcRJ4Pj80KZdytG4l41/9ET1y9fPKw54DYMMAjqfKii
        wjedoQQs8cNTQ5necvQVZ9XjaO5GNMsTiAwmu/A2qL3ZWuI=
X-Google-Smtp-Source: ABdhPJyqatp7LzB9xxc6I0gQLHO7YsTOwNJ3wBV8bw4JrU4sSGPbqnB9QRV1af8+D790jZSC0Glo2aOkmt/SBUdxOFQ=
X-Received: by 2002:a25:c2c5:: with SMTP id s188mr4945992ybf.188.1643149212606;
 Tue, 25 Jan 2022 14:20:12 -0800 (PST)
MIME-Version: 1.0
References: <20220125010458.2326473-1-luiz.dentz@gmail.com> <2C1196AC-0A23-4EF6-9A54-B98612FFBEE1@holtmann.org>
In-Reply-To: <2C1196AC-0A23-4EF6-9A54-B98612FFBEE1@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 25 Jan 2022 14:20:01 -0800
Message-ID: <CABBYNZLinu2XwPr=wed9nwW-TDkZVxhcCxCxxMYHwe243ZzxrQ@mail.gmail.com>
Subject: Re: [RFC 1/2] shared/mgmt: Add request timeout handling
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Tue, Jan 25, 2022 at 1:38 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > This adds request timeout handling, by default the timeout is set to 2
> > seconds but in case the user want a different timeout it can use
> > mgmt_send_timeout to set a different value.
> > ---
> > src/shared/mgmt.c | 70 +++++++++++++++++++++++++++++++++++++++++------
> > src/shared/mgmt.h |  5 ++++
> > 2 files changed, 67 insertions(+), 8 deletions(-)
> >
> > diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
> > index 41457b430..291a2c636 100644
> > --- a/src/shared/mgmt.c
> > +++ b/src/shared/mgmt.c
> > @@ -25,6 +25,9 @@
> > #include "src/shared/queue.h"
> > #include "src/shared/util.h"
> > #include "src/shared/mgmt.h"
> > +#include "src/shared/timeout.h"
> > +
> > +#define MGMT_TIMEOUT 2
> >
> > struct mgmt {
> >       int ref_count;
> > @@ -49,6 +52,7 @@ struct mgmt {
> > };
> >
> > struct mgmt_request {
> > +     struct mgmt *mgmt;
> >       unsigned int id;
> >       uint16_t opcode;
> >       uint16_t index;
> > @@ -57,6 +61,8 @@ struct mgmt_request {
> >       mgmt_request_func_t callback;
> >       mgmt_destroy_func_t destroy;
> >       void *user_data;
> > +     int timeout;
> > +     unsigned int timeout_id;
> > };
> >
> > struct mgmt_notify {
> > @@ -81,6 +87,9 @@ static void destroy_request(void *data)
> >       if (request->destroy)
> >               request->destroy(request->user_data);
> >
> > +     if (request->timeout_id)
> > +             timeout_remove(request->timeout_id);
> > +
> >       free(request->buf);
> >       free(request);
> > }
> > @@ -150,6 +159,26 @@ static void write_watch_destroy(void *user_data)
> >       mgmt->writer_active = false;
> > }
> >
> > +static bool request_timeout(void *data)
> > +{
> > +     struct mgmt_request *request = data;
> > +
> > +     if (!request)
> > +             return false;
> > +
> > +     request->timeout_id = 0;
> > +
> > +     queue_remove_if(request->mgmt->pending_list, NULL, request);
> > +
> > +     if (request->callback)
> > +             request->callback(MGMT_STATUS_TIMEOUT, 0, NULL,
> > +                                             request->user_data);
> > +
> > +     destroy_request(request);
> > +
> > +     return false;
> > +}
> > +
> > static bool send_request(struct mgmt *mgmt, struct mgmt_request *request)
> > {
> >       struct iovec iov;
> > @@ -169,6 +198,12 @@ static bool send_request(struct mgmt *mgmt, struct mgmt_request *request)
> >               return false;
> >       }
> >
> > +     if (request->timeout)
> > +             request->timeout_id = timeout_add_seconds(request->timeout,
> > +                                                     request_timeout,
> > +                                                     request,
> > +                                                     NULL);
> > +
> >       util_debug(mgmt->debug_callback, mgmt->debug_data,
> >                               "[0x%04x] command 0x%04x",
> >                               request->index, request->opcode);
> > @@ -566,7 +601,8 @@ bool mgmt_set_close_on_unref(struct mgmt *mgmt, bool do_close)
> > static struct mgmt_request *create_request(struct mgmt *mgmt, uint16_t opcode,
> >                               uint16_t index, uint16_t length,
> >                               const void *param, mgmt_request_func_t callback,
> > -                             void *user_data, mgmt_destroy_func_t destroy)
> > +                             void *user_data, mgmt_destroy_func_t destroy,
> > +                             int timeout)
> > {
> >       struct mgmt_request *request;
> >       struct mgmt_hdr *hdr;
> > @@ -598,12 +634,18 @@ static struct mgmt_request *create_request(struct mgmt *mgmt, uint16_t opcode,
> >       hdr->index = htobs(index);
> >       hdr->len = htobs(length);
> >
> > +     /* Use a weak reference so requests don't prevent mgmt_unref to
> > +      * cancel requests and free in case of the last reference is dropped by
> > +      * the user.
> > +      */
> > +     request->mgmt = mgmt;
> >       request->opcode = opcode;
> >       request->index = index;
> >
> >       request->callback = callback;
> >       request->destroy = destroy;
> >       request->user_data = user_data;
> > +     request->timeout = timeout;
> >
> >       return request;
> > }
> > @@ -735,10 +777,11 @@ unsigned int mgmt_send_tlv(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
> >       return ret;
> > }
> >
> > -unsigned int mgmt_send(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
> > -                             uint16_t length, const void *param,
> > -                             mgmt_request_func_t callback,
> > -                             void *user_data, mgmt_destroy_func_t destroy)
> > +unsigned int mgmt_send_timeout(struct mgmt *mgmt, uint16_t opcode,
> > +                             uint16_t index, uint16_t length,
> > +                             const void *param, mgmt_request_func_t callback,
> > +                             void *user_data, mgmt_destroy_func_t destroy,
> > +                             int timeout)
> > {
> >       struct mgmt_request *request;
> >
> > @@ -746,7 +789,7 @@ unsigned int mgmt_send(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
> >               return 0;
> >
> >       request = create_request(mgmt, opcode, index, length, param,
> > -                                     callback, user_data, destroy);
> > +                                     callback, user_data, destroy, timeout);
> >       if (!request)
> >               return 0;
> >
> > @@ -766,6 +809,15 @@ unsigned int mgmt_send(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
> >       return request->id;
> > }
> >
> > +unsigned int mgmt_send(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
> > +                             uint16_t length, const void *param,
> > +                             mgmt_request_func_t callback,
> > +                             void *user_data, mgmt_destroy_func_t destroy)
> > +{
> > +     return mgmt_send_timeout(mgmt, opcode, index, length, param, callback,
> > +                                     user_data, destroy, MGMT_TIMEOUT);
> > +}
> > +
>
> I am not happy with this. No every command has to setup a timeout handler and so on. This is not really what should be done since the mgmt communication with the kernel is actually pretty low latency.

Well we don't have any way to check if the kernel is really responding
within a reasonable time, so I thought it would be a good idea to have
a default to capture when a command /reply does not respond, otherwise
it is pretty hard to debug such conditions since the request will stay
in the queue indefinitely.

> If you want to add a special send_timeout, then do that, but leave the send alone.
>
> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz
