Return-Path: <SRS0=OtUJ=N7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C648C4161D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Nov 2018 18:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F9C920851
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Nov 2018 18:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=augury.com header.i=@augury.com header.b="DlQHi8Ab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F9C920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=augury.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbeKUFCh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Nov 2018 00:02:37 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:35887 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725728AbeKUFCh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Nov 2018 00:02:37 -0500
Received: by mail-ua1-f67.google.com with SMTP id j3so1008824uap.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Nov 2018 10:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=augury.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oxlts8BpZ/w4CZaoVRDOHz9YWME5RUhMrSs9K/KgLTc=;
        b=DlQHi8AbhDUNm2hBckYNtIaeOp3l7cFLR2hCF9BgTC8C7F7B7oxLuAFKXbNmO9hOy5
         z4sPJEfcJvS32vVg9dmRp6c/y9fCcDCYhk/jAtv8iT0O4U+fWRzfansg0vFSzlaRzJPJ
         HMPSsSMCf3nVegAAtFGTx9zB49R8Yk/ZhhC+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oxlts8BpZ/w4CZaoVRDOHz9YWME5RUhMrSs9K/KgLTc=;
        b=A/dhEyji7k4V0/ptQgQxj43E1FzBNIAEwgH6rTN9B4qKGT+JfwHeEkoFGcfmUFQc0x
         pQliyZ0p5yTqFiowqBNtZ5uDziRB/sKTA6MDox+XYEOOUcZlBwtYA1L8YL6tUfdOrtKM
         SAfNwZ7pAMZfOBwCY3BAdsgZXgt1LFEBqWcF9cVKYyya8vKAjltgwrdwQ+I0lnaUyEMf
         VJ62m6OX42pUdqzIDsX2zK3kH6jhZSCvDOGuekFJU5IFEniZijRIPDhETONhZtfO9ITH
         k6UHn6838gc+HOH+nWTd31s5/Xdo8jxAvKjCmuy9m2pn+0c67j0YG6pP97dUX/1+fJIL
         5DpQ==
X-Gm-Message-State: AA+aEWaYS3pN3bIzaDb9V/Qa9CnOzpNvwr29MI/mv5mlMsnekMct1clq
        Idjk5vZ1lBWcIJU1hJNrcYjkQ/HxEU9tyCPQlliI/w==
X-Google-Smtp-Source: AFSGD/WFySbNkw0L1cIQknvwHwEjEL7O8uQ3Gf9jbes9HWNqGEBiSXaC6hGDvcm1nWCBkiSkXKiTyhq4gR1IQ2Q7a/8=
X-Received: by 2002:ab0:4a16:: with SMTP id q22mr1372575uae.1.1542738724384;
 Tue, 20 Nov 2018 10:32:04 -0800 (PST)
MIME-Version: 1.0
References: <20181119154311.27826-1-luiz.dentz@gmail.com> <CABBYNZK90H=0e4GKo1g96jYkg3EM+5C2DhbCvi-Cgtd8W+E3YA@mail.gmail.com>
 <CAHotPr_8M4H_6sLV+BK02QBKLwwAn0cEOFhyoMN5F0=_gY1dHQ@mail.gmail.com>
 <CABBYNZJNM2SpM2w3kwuLw1FfXcoSZfyO02xCJAgdx-BBPyw7-w@mail.gmail.com>
 <CAHotPr8nQYJkN30pTncQfx-SGgmUgTs582_q_MAiLi=bEFYO9w@mail.gmail.com> <CABBYNZJzpPd+ZfJRTyCnicr8jApj_YW31qZhUDxSk_PgKiPZKg@mail.gmail.com>
In-Reply-To: <CABBYNZJzpPd+ZfJRTyCnicr8jApj_YW31qZhUDxSk_PgKiPZKg@mail.gmail.com>
From:   Gal Ben Haim <gbenhaim@augury.com>
Date:   Tue, 20 Nov 2018 20:31:52 +0200
Message-ID: <CAHotPr8pvbCOoYHVz-k4NU-prmtkq2bZOFN5V_GjCebte5HBtg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/5] gatt: Fix invalid read when disconnecting
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

ok I patched it. i'll test it tomorrow in the office and let you know.

On Tue, Nov 20, 2018 at 3:59 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Gal,
>
> On Tue, Nov 20, 2018 at 2:35 PM Gal Ben Haim <gbenhaim@augury.com> wrote:
> >
> > i tried with both git am and git apply
>
> Does that applies to v2 as well? I just rebased it on top master, are
> you sure you don't have your own changes conflicting with it?
>
> > On Tue, Nov 20, 2018 at 12:35 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Gal,
> > > On Tue, Nov 20, 2018 at 11:31 AM Gal Ben Haim <gbenhaim@augury.com> wrote:
> > > >
> > > > I can't apply this patch, not to the revision in master and not to the 5.50 tag
> > >
> > > They are on top o master, how are you trying to apply them, with git am?
> > >
> > > > On Tue, Nov 20, 2018 at 10:50 AM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > On Mon, Nov 19, 2018 at 5:43 PM Luiz Augusto von Dentz
> > > > > <luiz.dentz@gmail.com> wrote:
> > > > > >
> > > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > > >
> > > > > > In case there is a client of AcquireNotify and a disconnect happens the
> > > > > > code not only have to free the client object but also destroy the io
> > > > > > associated with it, for this reason the client object cannot be freed
> > > > > > until the io is destroyed otherwise it may lead to the following error:
> > > > > >
> > > > > > Invalid read of size 4
> > > > > >    at 0x63920: notify_io_destroy (gatt-client.c:1461)
> > > > > >    by 0x63EDB: pipe_io_destroy (gatt-client.c:1082)
> > > > > >    by 0x6405B: characteristic_free (gatt-client.c:1663)
> > > > > >    by 0x81F33: remove_interface (object.c:667)
> > > > > >    by 0x826CB: g_dbus_unregister_interface (object.c:1391)
> > > > > >    by 0x85D2B: queue_remove_all (queue.c:354)
> > > > > >    by 0x635F7: unregister_service (gatt-client.c:1893)
> > > > > >    by 0x85CF7: queue_remove_all (queue.c:339)
> > > > > >    by 0x661DF: btd_gatt_client_service_removed (gatt-client.c:2199)
> > > > > >    by 0x695CB: gatt_service_removed (device.c:3747)
> > > > > >    by 0x85B17: queue_foreach (queue.c:220)
> > > > > >    by 0x91283: notify_service_changed (gatt-db.c:280)
> > > > > >    by 0x91283: gatt_db_service_destroy (gatt-db.c:291)
> > > > > >  Address 0x515ed48 is 0 bytes inside a block of size 20 free'd
> > > > > >    at 0x483EAD0: free (vg_replace_malloc.c:530)
> > > > > >    by 0x85D2B: queue_remove_all (queue.c:354)
> > > > > >    by 0x636D3: unregister_characteristic (gatt-client.c:1741)
> > > > > >    by 0x85D2B: queue_remove_all (queue.c:354)
> > > > > >    by 0x635F7: unregister_service (gatt-client.c:1893)
> > > > > >    by 0x85CF7: queue_remove_all (queue.c:339)
> > > > > >    by 0x661DF: btd_gatt_client_service_removed (gatt-client.c:2199)
> > > > > >    by 0x695CB: gatt_service_removed (device.c:3747)
> > > > > >    by 0x85B17: queue_foreach (queue.c:220)
> > > > > >    by 0x91283: notify_service_changed (gatt-db.c:280)
> > > > > >    by 0x91283: gatt_db_service_destroy (gatt-db.c:291)
> > > > > >    by 0x85D2B: queue_remove_all (queue.c:354)
> > > > > >    by 0x91387: gatt_db_clear_range (gatt-db.c:475)
> > > > > > ---
> > > > > >  src/gatt-client.c | 24 ++++++++++++------------
> > > > > >  1 file changed, 12 insertions(+), 12 deletions(-)
> > > > > >
> > > > > > diff --git a/src/gatt-client.c b/src/gatt-client.c
> > > > > > index 234f46ed7..55aa5e423 100644
> > > > > > --- a/src/gatt-client.c
> > > > > > +++ b/src/gatt-client.c
> > > > > > @@ -1645,13 +1645,22 @@ static const GDBusMethodTable characteristic_methods[] = {
> > > > > >         { }
> > > > > >  };
> > > > > >
> > > > > > +static void remove_client(void *data)
> > > > > > +{
> > > > > > +       struct notify_client *ntfy_client = data;
> > > > > > +       struct btd_gatt_client *client = ntfy_client->chrc->service->client;
> > > > > > +
> > > > > > +       queue_remove(client->all_notify_clients, ntfy_client);
> > > > > > +
> > > > > > +       notify_client_unref(ntfy_client);
> > > > > > +}
> > > > > > +
> > > > > >  static void characteristic_free(void *data)
> > > > > >  {
> > > > > >         struct characteristic *chrc = data;
> > > > > >
> > > > > >         /* List should be empty here */
> > > > > >         queue_destroy(chrc->descs, NULL);
> > > > > > -       queue_destroy(chrc->notify_clients, NULL);
> > > > > >
> > > > > >         if (chrc->write_io) {
> > > > > >                 queue_remove(chrc->service->client->ios, chrc->write_io->io);
> > > > > > @@ -1663,6 +1672,8 @@ static void characteristic_free(void *data)
> > > > > >                 pipe_io_destroy(chrc->notify_io);
> > > > > >         }
> > > > > >
> > > > > > +       queue_destroy(chrc->notify_clients, remove_client);
> > > > > > +
> > > > > >         g_free(chrc->path);
> > > > > >         free(chrc);
> > > > > >  }
> > > > > > @@ -1715,16 +1726,6 @@ static struct characteristic *characteristic_create(
> > > > > >         return chrc;
> > > > > >  }
> > > > > >
> > > > > > -static void remove_client(void *data)
> > > > > > -{
> > > > > > -       struct notify_client *ntfy_client = data;
> > > > > > -       struct btd_gatt_client *client = ntfy_client->chrc->service->client;
> > > > > > -
> > > > > > -       queue_remove(client->all_notify_clients, ntfy_client);
> > > > > > -
> > > > > > -       notify_client_unref(ntfy_client);
> > > > > > -}
> > > > > > -
> > > > > >  static void unregister_characteristic(void *data)
> > > > > >  {
> > > > > >         struct characteristic *chrc = data;
> > > > > > @@ -1738,7 +1739,6 @@ static void unregister_characteristic(void *data)
> > > > > >         if (chrc->write_op)
> > > > > >                 bt_gatt_client_cancel(gatt, chrc->write_op->id);
> > > > > >
> > > > > > -       queue_remove_all(chrc->notify_clients, NULL, NULL, remove_client);
> > > > > >         queue_remove_all(chrc->descs, NULL, NULL, unregister_descriptor);
> > > > > >
> > > > > >         g_dbus_unregister_interface(btd_get_dbus_connection(), chrc->path,
> > > > > > --
> > > > > > 2.17.2
> > > > >
> > > > > Can you try with this set to see it does work properly.
> > > > >
> > > > > --
> > > > > Luiz Augusto von Dentz
> > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
