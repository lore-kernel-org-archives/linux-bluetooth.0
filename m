Return-Path: <SRS0=OtUJ=N7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C48C04EBC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Nov 2018 10:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A572A2087E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Nov 2018 10:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qr4yP9ZJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A572A2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbeKTVD7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:03:59 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44223 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbeKTVD7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Nov 2018 16:03:59 -0500
Received: by mail-ot1-f66.google.com with SMTP id z33so1190212otz.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Nov 2018 02:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XSg5Ytdl6XOtauMAAi1oplSAj2O585eWfWWUmI6/Xec=;
        b=Qr4yP9ZJqqbfk61jkl74l0dWNXRmC58xbi0VQL5XVHBFh3pm/b60+DiqKw1HoPBVAn
         rU8loDvNN7W4ncGSiZFR9+IGFVGXSci2jIoJlnBPIkBaYGksZ3s3D682ObXze6CURGAR
         GFOmHEcQNtv/DkB3trNyGNxY0YGe3xe6BsoBwWrkF5F0e7GPhah/KpQCRPILOIl5N7Wr
         rQ4pbTjXpYSieWXy6GhdD4AqzqjEE/0pkd2eCbVx5BcURz3qRxj671zFONUt/ppUPfUH
         ZXg2VKOSEoptMjenTrEYEL+n92lMVzJFr4rFVkyqbe9JAPBDy87OvP3mkFerN/be61GV
         nQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XSg5Ytdl6XOtauMAAi1oplSAj2O585eWfWWUmI6/Xec=;
        b=i4/k5JbRo3tbLDeif3HoiYBrGUHO6OhcHopGGrNnGGDElTxrseoan/egK7BvW+bo1G
         6Zc3jcecb0Oyh2l5s/JO1oaDptRhYgp3M+g7RY0Qw7Ich9uzgFLxKLHBAtwdpRhHFov6
         RapwKTyi6GmCYrWVKBSv0h9esb06dvNImLMrrs24o15ZGViY4EG7C0uZMdy2/Vw8mWT5
         JI9kJzNW3yHUUzkwXGSe8H0DGIsVeh+F5KlYQ94bUzEbmOouUUgBMZqlYWKL9ff7ddvJ
         V+fb1jBT7EwLKHPsboXBseVeX9SQltyy0VJdfI10OpD8ztw0bh14pKgrT5OtzsJPQNR3
         l8vg==
X-Gm-Message-State: AA+aEWb/wU4IEypPP7Him5Gcl5BX5BYlAc4qVrqpYGxO0bKFQcPS8PI3
        L2c6IFFpGTPhLMuj6MF3BRY1nolbaLFMuvqjpjanZg==
X-Google-Smtp-Source: AFSGD/Uul3ByfAtIOFFq5PIovlxxsacrblwBeX5YrLQxAkeUUvT0MKw/V90zNsc7x4UgdV12Ajss+oPSBcIqoQOb7K8=
X-Received: by 2002:a9d:3d0:: with SMTP id f74mr813160otf.52.1542710131210;
 Tue, 20 Nov 2018 02:35:31 -0800 (PST)
MIME-Version: 1.0
References: <20181119154311.27826-1-luiz.dentz@gmail.com> <CABBYNZK90H=0e4GKo1g96jYkg3EM+5C2DhbCvi-Cgtd8W+E3YA@mail.gmail.com>
 <CAHotPr_8M4H_6sLV+BK02QBKLwwAn0cEOFhyoMN5F0=_gY1dHQ@mail.gmail.com>
In-Reply-To: <CAHotPr_8M4H_6sLV+BK02QBKLwwAn0cEOFhyoMN5F0=_gY1dHQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 20 Nov 2018 12:35:19 +0200
Message-ID: <CABBYNZJNM2SpM2w3kwuLw1FfXcoSZfyO02xCJAgdx-BBPyw7-w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/5] gatt: Fix invalid read when disconnecting
To:     gbenhaim@augury.com
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Gal,
On Tue, Nov 20, 2018 at 11:31 AM Gal Ben Haim <gbenhaim@augury.com> wrote:
>
> I can't apply this patch, not to the revision in master and not to the 5.50 tag

They are on top o master, how are you trying to apply them, with git am?

> On Tue, Nov 20, 2018 at 10:50 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > On Mon, Nov 19, 2018 at 5:43 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > >
> > > In case there is a client of AcquireNotify and a disconnect happens the
> > > code not only have to free the client object but also destroy the io
> > > associated with it, for this reason the client object cannot be freed
> > > until the io is destroyed otherwise it may lead to the following error:
> > >
> > > Invalid read of size 4
> > >    at 0x63920: notify_io_destroy (gatt-client.c:1461)
> > >    by 0x63EDB: pipe_io_destroy (gatt-client.c:1082)
> > >    by 0x6405B: characteristic_free (gatt-client.c:1663)
> > >    by 0x81F33: remove_interface (object.c:667)
> > >    by 0x826CB: g_dbus_unregister_interface (object.c:1391)
> > >    by 0x85D2B: queue_remove_all (queue.c:354)
> > >    by 0x635F7: unregister_service (gatt-client.c:1893)
> > >    by 0x85CF7: queue_remove_all (queue.c:339)
> > >    by 0x661DF: btd_gatt_client_service_removed (gatt-client.c:2199)
> > >    by 0x695CB: gatt_service_removed (device.c:3747)
> > >    by 0x85B17: queue_foreach (queue.c:220)
> > >    by 0x91283: notify_service_changed (gatt-db.c:280)
> > >    by 0x91283: gatt_db_service_destroy (gatt-db.c:291)
> > >  Address 0x515ed48 is 0 bytes inside a block of size 20 free'd
> > >    at 0x483EAD0: free (vg_replace_malloc.c:530)
> > >    by 0x85D2B: queue_remove_all (queue.c:354)
> > >    by 0x636D3: unregister_characteristic (gatt-client.c:1741)
> > >    by 0x85D2B: queue_remove_all (queue.c:354)
> > >    by 0x635F7: unregister_service (gatt-client.c:1893)
> > >    by 0x85CF7: queue_remove_all (queue.c:339)
> > >    by 0x661DF: btd_gatt_client_service_removed (gatt-client.c:2199)
> > >    by 0x695CB: gatt_service_removed (device.c:3747)
> > >    by 0x85B17: queue_foreach (queue.c:220)
> > >    by 0x91283: notify_service_changed (gatt-db.c:280)
> > >    by 0x91283: gatt_db_service_destroy (gatt-db.c:291)
> > >    by 0x85D2B: queue_remove_all (queue.c:354)
> > >    by 0x91387: gatt_db_clear_range (gatt-db.c:475)
> > > ---
> > >  src/gatt-client.c | 24 ++++++++++++------------
> > >  1 file changed, 12 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/src/gatt-client.c b/src/gatt-client.c
> > > index 234f46ed7..55aa5e423 100644
> > > --- a/src/gatt-client.c
> > > +++ b/src/gatt-client.c
> > > @@ -1645,13 +1645,22 @@ static const GDBusMethodTable characteristic_methods[] = {
> > >         { }
> > >  };
> > >
> > > +static void remove_client(void *data)
> > > +{
> > > +       struct notify_client *ntfy_client = data;
> > > +       struct btd_gatt_client *client = ntfy_client->chrc->service->client;
> > > +
> > > +       queue_remove(client->all_notify_clients, ntfy_client);
> > > +
> > > +       notify_client_unref(ntfy_client);
> > > +}
> > > +
> > >  static void characteristic_free(void *data)
> > >  {
> > >         struct characteristic *chrc = data;
> > >
> > >         /* List should be empty here */
> > >         queue_destroy(chrc->descs, NULL);
> > > -       queue_destroy(chrc->notify_clients, NULL);
> > >
> > >         if (chrc->write_io) {
> > >                 queue_remove(chrc->service->client->ios, chrc->write_io->io);
> > > @@ -1663,6 +1672,8 @@ static void characteristic_free(void *data)
> > >                 pipe_io_destroy(chrc->notify_io);
> > >         }
> > >
> > > +       queue_destroy(chrc->notify_clients, remove_client);
> > > +
> > >         g_free(chrc->path);
> > >         free(chrc);
> > >  }
> > > @@ -1715,16 +1726,6 @@ static struct characteristic *characteristic_create(
> > >         return chrc;
> > >  }
> > >
> > > -static void remove_client(void *data)
> > > -{
> > > -       struct notify_client *ntfy_client = data;
> > > -       struct btd_gatt_client *client = ntfy_client->chrc->service->client;
> > > -
> > > -       queue_remove(client->all_notify_clients, ntfy_client);
> > > -
> > > -       notify_client_unref(ntfy_client);
> > > -}
> > > -
> > >  static void unregister_characteristic(void *data)
> > >  {
> > >         struct characteristic *chrc = data;
> > > @@ -1738,7 +1739,6 @@ static void unregister_characteristic(void *data)
> > >         if (chrc->write_op)
> > >                 bt_gatt_client_cancel(gatt, chrc->write_op->id);
> > >
> > > -       queue_remove_all(chrc->notify_clients, NULL, NULL, remove_client);
> > >         queue_remove_all(chrc->descs, NULL, NULL, unregister_descriptor);
> > >
> > >         g_dbus_unregister_interface(btd_get_dbus_connection(), chrc->path,
> > > --
> > > 2.17.2
> >
> > Can you try with this set to see it does work properly.
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
