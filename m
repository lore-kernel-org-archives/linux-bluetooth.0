Return-Path: <SRS0=zBEa=4N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D02C35DF5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Feb 2020 08:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63D922464
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Feb 2020 08:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXwPT+Nq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbgBYIEx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Feb 2020 03:04:53 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40876 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729443AbgBYIEx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Feb 2020 03:04:53 -0500
Received: by mail-ot1-f67.google.com with SMTP id i6so11268119otr.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2020 00:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OAPj1XBZLNFAf4SineVPDvFpHYh1qFQIuQAZtHLdUtc=;
        b=lXwPT+Nq93BPpcUK+ygkKpiqn2heGVdf9eFTnq0l7k6/xDENj4479/5RYmP7NE0oUy
         Dshf65ACoUiaZQsm/ePnf7/bW7KS+h72QutFuXX+WBKufZDjdUBy/4gSK3E9uIDA3RF1
         T1lOOk07CYTa7IErSk16DdikvJc4/pKmUti5b0fWBsLzlP2w/2cC7VbZ5vs6olOX4S/K
         TpMV6F3rXtS1SMWdd3KNrizHX6MkLDdgHmVLUycnVLxesE/5TCIhppe9tf/vSOnyQ5g+
         cAEw/6UzwOYBZ3TYRxiPx8KvJoJNc4uxe151f3iiMbBEPWZvUKlPIbQSm4Pfx1nvDO8P
         nHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OAPj1XBZLNFAf4SineVPDvFpHYh1qFQIuQAZtHLdUtc=;
        b=iCoeK2Il66bsNAJjGAbC7hv1S2X8k2a4V37/rigXsqD5jQUNKLCRxQga50VlIsjjcw
         JGnNbXg+uRYWXoqqnxITnQKhpaZ7uhbPmxUZwoN5Jzect0ABVsqjHcdMHKVaO2MNYnlv
         EYs6qXJHKJFSCHN70nfKvydQMkSwAsLIemD2x+gfVo0p/CoSU2lwWnYjdG2JJ1IWFXMz
         7BfTT/I6axh+6sJh6qPl4Th1lVcIZ7MMM1vEY8IAGWGv+KefkF7SEdMYxKruriGNHgzG
         fGpYcEfBFs4blJ7Mlko2GgHuyEWD3d0ed70zFamrvosYKSaeJNrNO+l5Xe2CAuUjFowq
         kgRQ==
X-Gm-Message-State: APjAAAVaNmpmYdcGW9ZWUC7Db616BHFJ0v4Vi4GrWyPXKduCQlSMujom
        +JkWn3vlgDffeeslfrtp9aEes+v4vhWXyVHHF6U=
X-Google-Smtp-Source: APXvYqwN4YIQYVLshYqI4/hI6S2RPwcowXMq5a0nZ8g3JILQHNWRotH8xNlwjN5iYlI5nmeBhkNs4G8I3/UlZfZuYCo=
X-Received: by 2002:a9d:6d10:: with SMTP id o16mr45080894otp.28.1582617890863;
 Tue, 25 Feb 2020 00:04:50 -0800 (PST)
MIME-Version: 1.0
References: <20200221163911.Bluez.v1.1.I3c505b4307094eb7a6f2c5949125a17c89b2e099@changeid>
 <CABBYNZKc6UPfYLbesAk0fUaGWFHP6GNtMQHFAOt+p+Yy0jNkWg@mail.gmail.com>
 <CAJQfnxGoRhuw9_+v=TUXTa1j_rO7qZEVS=UnzS6TwNHt1FudRg@mail.gmail.com> <CAJQfnxEce-dH5Qrf538hiKZUvGmWox_Dx-RU6zS3n4Fd4X-F+Q@mail.gmail.com>
In-Reply-To: <CAJQfnxEce-dH5Qrf538hiKZUvGmWox_Dx-RU6zS3n4Fd4X-F+Q@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 25 Feb 2020 00:04:38 -0800
Message-ID: <CABBYNZJ2c_HSGku_5gtMQ=HrO96vL5hRN+4ZAWyYbxcCQJz4wA@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] src/profile: Ensure class UUID matches before
 connecting profile
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Mon, Feb 24, 2020 at 10:59 PM Archie Pusaka <apusaka@google.com> wrote:
>
> Hi Luiz,
>
> After looking at the code for device.c you pointed out,
> apparently the function update_bredr_services() is called two times
> upon connecting to a device, the first one for UUID 0x0100 (L2CAP),
> then the second one for UUID 0x1200 (PNP).
>
> I am not clear as to why BlueZ needs to search for those two records,
> but this might impacted the decision to move the service class ID
> filtering to sdp-client.c, because the service class ID of the records
> will never match 0x0100, so it will all be filtered out.

Right that is looking for all records basically, since L2CAP is
included everytime, so we need to keep that working, so perhaps a
better alternative would be to have a second helper function that does
the filtering or extend bt_search_service with another parameter, but
I guess doing the former is cleaner, though I rename bt_search_service
to just bt_search and the later since that doesn't do any filtering
and leave bt_search_service to actually filter out base on service
class.

> Could you confirm that it is okay to filter all records based on the
> service class ID, especially considering all records related to L2CAP
> query will not execute this part of the code?
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/device.c#n4630
>
> Thanks,
> Archie
>
> On Tue, 25 Feb 2020 at 13:58, Archie Pusaka <apusaka@google.com> wrote:
> >
> > Hi Luiz,
> >
> > On Tue, 25 Feb 2020 at 03:30, Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Archie,
> > >
> > > On Fri, Feb 21, 2020 at 12:41 AM Archie Pusaka <apusaka@google.com> wrote:
> > > >
> > > > From: Archie Pusaka <apusaka@chromium.org>
> > > >
> > > > According to bluetooth spec Ver 5.1, Vol 3, Part B, 4.7.2, there
> > > > might be multiple service records returned in a SDP Service Search
> > > > Attribute Response. Also, according to 2.5.2, the service pattern
> > > > can match any UUID contained within the service record, it doesn't
> > > > have to match only some specific attributes of the record.
> > > >
> > > > Therefore, before using the service record to connect to any
> > > > profile, first we must check that the service class ID of the
> > > > service record matches with whatever UUID specified in the service
> > > > pattern we are looking for.
> > >
> > > Im surprised we were not doing this currently, Im fairly sure we do
> > > that for the services/plugin though since there are only probed if the
> > > service UUID matches
> > >
> > > > ---
> > > >
> > > >  src/profile.c | 26 ++++++++++++++++++++++++++
> > > >  1 file changed, 26 insertions(+)
> > > >
> > > > diff --git a/src/profile.c b/src/profile.c
> > > > index 192fd0245..1b481836e 100644
> > > > --- a/src/profile.c
> > > > +++ b/src/profile.c
> > > > @@ -1568,8 +1568,34 @@ static void record_cb(sdp_list_t *recs, int err, gpointer user_data)
> > > >
> > > >         for (r = recs; r != NULL; r = r->next) {
> > > >                 sdp_record_t *rec = r->data;
> > > > +               sdp_list_t *svcclass;
> > > > +               sdp_list_t *svcclass_iter;
> > > >                 sdp_list_t *protos;
> > > >                 int port;
> > > > +               bool matches_class_uuid = false;
> > > > +
> > > > +               if (sdp_get_service_classes(rec, &svcclass) < 0) {
> > > > +                       error("Unable to get svc class ID list from %s record",
> > > > +                                                               ext->name);
> > > > +                       continue;
> > > > +               }
> > > > +
> > > > +               for (svcclass_iter = svcclass; svcclass_iter != NULL;
> > > > +                                       svcclass_iter = svcclass_iter->next) {
> > > > +                       char *uuid = bt_uuid2string(svcclass_iter->data);
> > > > +                       int cmp_result = bt_uuid_strcmp(uuid, ext->uuid);
> > >
> > > I think it would be probably more efficient to convert to data to
> > > binary format (bt_uuid_t) and then do the comparision with
> > > bt_uuid_cmp, also there might not be needed to iterate at all see
> > > device.c:update_bredr_service which has the logic for updating
> > > records:
> > >
> > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/device.c#n4602
> >
> > I was uncertain whether we need to iterate or not, so I went for the safer side.
> > However if there is no need to do that then this shall be updated.
> > I also agree that comparison in binary should be faster.
> >
> > >
> > > Btw, we should probably have bt_search_service doing the matching if
> > > the uuid is set instead of returning all records like it seems to be
> > > doing that way we don't have to maintain duplicate logic in both
> > > device.c and profile.c
> >
> > Got it. somewhere in sdp-client.c is a good idea.
> > Aside from device.c and profile.c, is this also used somewhere else
> > though? We might also want to take them out if we are to implement
> > the check in sdp-client.c.
> >
> > >
> > >
> > > > +                       free(uuid);
> > > > +                       if (cmp_result == 0) {
> > > > +                               matches_class_uuid = true;
> > > > +                               break;
> > > > +                       }
> > > > +               }
> > > > +
> > > > +               sdp_list_free(svcclass, free);
> > > > +
> > > > +               if (!matches_class_uuid)
> > > > +                       continue;
> > > >
> > > >                 if (sdp_get_access_protos(rec, &protos) < 0) {
> > > >                         error("Unable to get proto list from %s record",
> > > > --
> > > > 2.25.0.265.gbab2e86ba0-goog
> > > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
> >
> >
> > Thanks,
> > Archie



-- 
Luiz Augusto von Dentz
