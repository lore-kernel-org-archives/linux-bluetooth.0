Return-Path: <SRS0=IL+U=OA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D9DC43441
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Nov 2018 07:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390612145D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Nov 2018 07:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=augury.com header.i=@augury.com header.b="h7IAntuY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 390612145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=augury.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbeKURtK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Nov 2018 12:49:10 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:36870 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeKURtK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Nov 2018 12:49:10 -0500
Received: by mail-ua1-f68.google.com with SMTP id u19so1578364uae.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Nov 2018 23:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=augury.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4PehN0LzEptC/NjwNvT5xUtYUJ6w0WBWbltkB1lY5CU=;
        b=h7IAntuYEnC3u3GCqhXoznAMaoWE95p+2iL9n3Ex8zYB0WZWQ5Yk6/oBZpskfs3e2X
         r35cf8KOcj0RE+idlAa14EcBa3ii1GDh7eHTKo3laGp9b0+8n7SK2gAZw0Rc7INQOjv6
         TVY0PqZ5td8bGkzsuJa+NU+gd7YA0SJBh7C0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4PehN0LzEptC/NjwNvT5xUtYUJ6w0WBWbltkB1lY5CU=;
        b=rEYmGhT5t/xa2OScmAy8b88aGRkTrl8e2Jguc8lDOVoMvqFU2fxpVoZ++sqpAKaOcZ
         uuNUO6CBFqbmYPEQZqa8WSpqg+JkZCwTQYMicrYaX2N3Lbo1HzdkEWIl1hzr7kr7X/4s
         ++84F6c17bmGSOkxjPI0O8jc268f8Cf00OWi7J3+KRzYjzfu1JL8AutMtI4qnUtn1hLB
         9N8tB65G6C+aoaeT3f/3Nw/edfCfh7s6UU12f4aBLTSJfUi9R0uMulC702PPZ7XtJl50
         KqWpS5/rjYY7X4j4FrjN+dJk/lzwBorYL1gX8tznNcuqYWOJNXcFfvFE1WZloFaw5kKE
         Vzkg==
X-Gm-Message-State: AA+aEWZMMNpglD6Ua8t/4y7A7vZSsP1Cbv5K5NIEwZuy+GYcx8ql52Zw
        +228vfcVHU6usGgiCkwuN22J+iXjLMHWjkqj41IYog==
X-Google-Smtp-Source: AFSGD/Xk4HEAvDjCStw5zmZsH2SAFnPGmNinMi0zLHqTD7cyJIyIYwBRmA5esVBHSiEjFBjFK5L7wd3YWhUGHAoiv2c=
X-Received: by 2002:ab0:70b4:: with SMTP id q20mr2384607ual.24.1542784549681;
 Tue, 20 Nov 2018 23:15:49 -0800 (PST)
MIME-Version: 1.0
References: <20181119154311.27826-1-luiz.dentz@gmail.com> <CABBYNZK90H=0e4GKo1g96jYkg3EM+5C2DhbCvi-Cgtd8W+E3YA@mail.gmail.com>
 <CAHotPr_8M4H_6sLV+BK02QBKLwwAn0cEOFhyoMN5F0=_gY1dHQ@mail.gmail.com>
 <CABBYNZJNM2SpM2w3kwuLw1FfXcoSZfyO02xCJAgdx-BBPyw7-w@mail.gmail.com>
 <CAHotPr8nQYJkN30pTncQfx-SGgmUgTs582_q_MAiLi=bEFYO9w@mail.gmail.com>
 <CABBYNZJzpPd+ZfJRTyCnicr8jApj_YW31qZhUDxSk_PgKiPZKg@mail.gmail.com> <CAHotPr8pvbCOoYHVz-k4NU-prmtkq2bZOFN5V_GjCebte5HBtg@mail.gmail.com>
In-Reply-To: <CAHotPr8pvbCOoYHVz-k4NU-prmtkq2bZOFN5V_GjCebte5HBtg@mail.gmail.com>
From:   Gal Ben Haim <gbenhaim@augury.com>
Date:   Wed, 21 Nov 2018 09:15:38 +0200
Message-ID: <CAHotPr8MyEwqATiL+4CHfTJ-40Df3cjm60CptT6wh-0GTpFgOg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/5] gatt: Fix invalid read when disconnecting
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

it fixes the same case that cause the version from master to crash.
i haven't tested for anything else..

On Tue, Nov 20, 2018 at 8:31 PM Gal Ben Haim <gbenhaim@augury.com> wrote:
>
> ok I patched it. i'll test it tomorrow in the office and let you know.
>
> On Tue, Nov 20, 2018 at 3:59 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Gal,
> >
> > On Tue, Nov 20, 2018 at 2:35 PM Gal Ben Haim <gbenhaim@augury.com> wrote:
> > >
> > > i tried with both git am and git apply
> >
> > Does that applies to v2 as well? I just rebased it on top master, are
> > you sure you don't have your own changes conflicting with it?
> >
> > > On Tue, Nov 20, 2018 at 12:35 PM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Gal,
> > > > On Tue, Nov 20, 2018 at 11:31 AM Gal Ben Haim <gbenhaim@augury.com> wrote:
> > > > >
> > > > > I can't apply this patch, not to the revision in master and not to the 5.50 tag
> > > >
> > > > They are on top o master, how are you trying to apply them, with git am?
> > > >
> > > > > On Tue, Nov 20, 2018 at 10:50 AM Luiz Augusto von Dentz
> > > > > <luiz.dentz@gmail.com> wrote:
> > > > > >
> > > > > > On Mon, Nov 19, 2018 at 5:43 PM Luiz Augusto von Dentz
> > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > >
> > > > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > > > >
> > > > > > > In case there is a client of AcquireNotify and a disconnect happens the
> > > > > > > code not only have to free the client object but also destroy the io
> > > > > > > associated with it, for this reason the client object cannot be freed
> > > > > > > until the io is destroyed otherwise it may lead to the following error:
> > > > > > >
> > > > > > > Invalid read of size 4
> > > > > > >    at 0x63920: notify_io_destroy (gatt-client.c:1461)
> > > > > > >    by 0x63EDB: pipe_io_destroy (gatt-client.c:1082)
> > > > > > >    by 0x6405B: characteristic_free (gatt-client.c:1663)
> > > > > > >    by 0x81F33: remove_interface (object.c:667)
> > > > > > >    by 0x826CB: g_dbus_unregister_interface (object.c:1391)
> > > > > > >    by 0x85D2B: queue_remove_all (queue.c:354)
> > > > > > >    by 0x635F7: unregister_service (gatt-client.c:1893)
> > > > > > >    by 0x85CF7: queue_remove_all (queue.c:339)
> > > > > > >    by 0x661DF: btd_gatt_client_service_removed (gatt-client.c:2199)
> > > > > > >    by 0x695CB: gatt_service_removed (device.c:3747)
> > > > > > >    by 0x85B17: queue_foreach (queue.c:220)
> > > > > > >    by 0x91283: notify_service_changed (gatt-db.c:280)
> > > > > > >    by 0x91283: gatt_db_service_destroy (gatt-db.c:291)
> > > > > > >  Address 0x515ed48 is 0 bytes inside a block of size 20 free'd
> > > > > > >    at 0x483EAD0: free (vg_replace_malloc.c:530)
> > > > > > >    by 0x85D2B: queue_remove_all (queue.c:354)
> > > > > > >    by 0x636D3: unregister_characteristic (gatt-client.c:1741)
> > > > > > >    by 0x85D2B: queue_remove_all (queue.c:354)
> > > > > > >    by 0x635F7: unregister_service (gatt-client.c:1893)
> > > > > > >    by 0x85CF7: queue_remove_all (queue.c:339)
> > > > > > >    by 0x661DF: btd_gatt_client_service_removed (gatt-client.c:2199)
> > > > > > >    by 0x695CB: gatt_service_removed (device.c:3747)
> > > > > > >    by 0x85B17: queue_foreach (queue.c:220)
> > > > > > >    by 0x91283: notify_service_changed (gatt-db.c:280)
> > > > > > >    by 0x91283: gatt_db_service_destroy (gatt-db.c:291)
> > > > > > >    by 0x85D2B: queue_remove_all (queue.c:354)
> > > > > > >    by 0x91387: gatt_db_clear_range (gatt-db.c:475)
> > > > > > > ---
> > > > > > >  src/gatt-client.c | 24 ++++++++++++------------
> > > > > > >  1 file changed, 12 insertions(+), 12 deletions(-)
> > > > > > >
> > > > > > > diff --git a/src/gatt-client.c b/src/gatt-client.c
> > > > > > > index 234f46ed7..55aa5e423 100644
> > > > > > > --- a/src/gatt-client.c
> > > > > > > +++ b/src/gatt-client.c
> > > > > > > @@ -1645,13 +1645,22 @@ static const GDBusMethodTable characteristic_methods[] = {
> > > > > > >         { }
> > > > > > >  };
> > > > > > >
> > > > > > > +static void remove_client(void *data)
> > > > > > > +{
> > > > > > > +       struct notify_client *ntfy_client = data;
> > > > > > > +       struct btd_gatt_client *client = ntfy_client->chrc->service->client;
> > > > > > > +
> > > > > > > +       queue_remove(client->all_notify_clients, ntfy_client);
> > > > > > > +
> > > > > > > +       notify_client_unref(ntfy_client);
> > > > > > > +}
> > > > > > > +
> > > > > > >  static void characteristic_free(void *data)
> > > > > > >  {
> > > > > > >         struct characteristic *chrc = data;
> > > > > > >
> > > > > > >         /* List should be empty here */
> > > > > > >         queue_destroy(chrc->descs, NULL);
> > > > > > > -       queue_destroy(chrc->notify_clients, NULL);
> > > > > > >
> > > > > > >         if (chrc->write_io) {
> > > > > > >                 queue_remove(chrc->service->client->ios, chrc->write_io->io);
> > > > > > > @@ -1663,6 +1672,8 @@ static void characteristic_free(void *data)
> > > > > > >                 pipe_io_destroy(chrc->notify_io);
> > > > > > >         }
> > > > > > >
> > > > > > > +       queue_destroy(chrc->notify_clients, remove_client);
> > > > > > > +
> > > > > > >         g_free(chrc->path);
> > > > > > >         free(chrc);
> > > > > > >  }
> > > > > > > @@ -1715,16 +1726,6 @@ static struct characteristic *characteristic_create(
> > > > > > >         return chrc;
> > > > > > >  }
> > > > > > >
> > > > > > > -static void remove_client(void *data)
> > > > > > > -{
> > > > > > > -       struct notify_client *ntfy_client = data;
> > > > > > > -       struct btd_gatt_client *client = ntfy_client->chrc->service->client;
> > > > > > > -
> > > > > > > -       queue_remove(client->all_notify_clients, ntfy_client);
> > > > > > > -
> > > > > > > -       notify_client_unref(ntfy_client);
> > > > > > > -}
> > > > > > > -
> > > > > > >  static void unregister_characteristic(void *data)
> > > > > > >  {
> > > > > > >         struct characteristic *chrc = data;
> > > > > > > @@ -1738,7 +1739,6 @@ static void unregister_characteristic(void *data)
> > > > > > >         if (chrc->write_op)
> > > > > > >                 bt_gatt_client_cancel(gatt, chrc->write_op->id);
> > > > > > >
> > > > > > > -       queue_remove_all(chrc->notify_clients, NULL, NULL, remove_client);
> > > > > > >         queue_remove_all(chrc->descs, NULL, NULL, unregister_descriptor);
> > > > > > >
> > > > > > >         g_dbus_unregister_interface(btd_get_dbus_connection(), chrc->path,
> > > > > > > --
> > > > > > > 2.17.2
> > > > > >
> > > > > > Can you try with this set to see it does work properly.
> > > > > >
> > > > > > --
> > > > > > Luiz Augusto von Dentz
> > > >
> > > >
> > > >
> > > > --
> > > > Luiz Augusto von Dentz
> >
> >
> >
> > --
> > Luiz Augusto von Dentz
