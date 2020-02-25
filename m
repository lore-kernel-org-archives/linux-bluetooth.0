Return-Path: <SRS0=zBEa=4N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BE9C35DF5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Feb 2020 05:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0CE24653
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Feb 2020 05:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X1P2gW18"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgBYF6X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Feb 2020 00:58:23 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34775 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgBYF6X (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Feb 2020 00:58:23 -0500
Received: by mail-wr1-f68.google.com with SMTP id z15so4828425wrl.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2020 21:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DgDOWnoRdqXdI9bQwdE/XHj+LImCcei1vyd6/cTCvYY=;
        b=X1P2gW18zPONQLT2CVyqYKfojnKX+WtP4eVw6WDL3JivATN57e/PsM9/Q+m0YJ1TbZ
         No6fEr4VokzYCf5Zu7jUIiTX72irgpUN2dhbyW+PmyF18pj6K0pLvMMoYh8GQxAjvOPi
         Xm7LBo259ctyXASJYdKo+fV+9mkXNIJwr3R0sBl6pfNap9fcwu32LeGaKVKfhRpA6RC8
         sSUqOatOEeAwgpxmiRuLG0hEdZFHoeQmYPFVRfRpEbEeLt+GTqGZY/9pvPS0ClA5cnNg
         HgnOmQ5FeF1lgXfYpOW3Hqr3iQ6caykqRkQqykI7Y4LlqBPgijraZg7wYnpBUngPIqL6
         S9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DgDOWnoRdqXdI9bQwdE/XHj+LImCcei1vyd6/cTCvYY=;
        b=aEpBSoas0+B+D1gW+dkH+FZbKVGvqAt0b/EIInurYEZX5rfne5Geb7nQYoEkcisecg
         Xb+8ktTdxSOF5e2WK1fRlmP5zAHx2URVnguWcA/QFBfVOfKmsSUjwdXLmmOKG4wBYfXC
         yCg7PE0LDh5StYk9TY2W0/vVXPHfrnlPGVHZ08D2qIOjy+1iyEwLURDAORq5bYVGkWd2
         jYMIaH3vwWVNWj6eYAyMe5/PDwysxUFFgDSk+pv7FZ4OIJNUFrls1pAL2jgiqYpZc0bH
         HrkRlmi1VpQCI1hbY14NOBUX3sjCGvzLsoBp+mkNDbEimN3qY/kC0I2XV5f1du7QnkaX
         LE7A==
X-Gm-Message-State: APjAAAWzN5dNDB5U6yKHVxFw9WdyrM024EQg879Cit88mFEWsya+i/3Q
        HicQ3Js5HU5aka4jo7H7lSlTu10aZ9CdPoUPY4Ms2A==
X-Google-Smtp-Source: APXvYqyj/uoEbCb+Cvjl4/eVoMe3rWWvrLHsl/AE4XtmpVOMDqZLP6H595QsENKP9jVbZga0eDXYTU4zSwKi4WfMUGs=
X-Received: by 2002:a5d:484f:: with SMTP id n15mr70798068wrs.365.1582610300938;
 Mon, 24 Feb 2020 21:58:20 -0800 (PST)
MIME-Version: 1.0
References: <20200221163911.Bluez.v1.1.I3c505b4307094eb7a6f2c5949125a17c89b2e099@changeid>
 <CABBYNZKc6UPfYLbesAk0fUaGWFHP6GNtMQHFAOt+p+Yy0jNkWg@mail.gmail.com>
In-Reply-To: <CABBYNZKc6UPfYLbesAk0fUaGWFHP6GNtMQHFAOt+p+Yy0jNkWg@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Tue, 25 Feb 2020 13:58:09 +0800
Message-ID: <CAJQfnxGoRhuw9_+v=TUXTa1j_rO7qZEVS=UnzS6TwNHt1FudRg@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] src/profile: Ensure class UUID matches before
 connecting profile
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Tue, 25 Feb 2020 at 03:30, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Archie,
>
> On Fri, Feb 21, 2020 at 12:41 AM Archie Pusaka <apusaka@google.com> wrote:
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
>
> Im surprised we were not doing this currently, Im fairly sure we do
> that for the services/plugin though since there are only probed if the
> service UUID matches
>
> > ---
> >
> >  src/profile.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/src/profile.c b/src/profile.c
> > index 192fd0245..1b481836e 100644
> > --- a/src/profile.c
> > +++ b/src/profile.c
> > @@ -1568,8 +1568,34 @@ static void record_cb(sdp_list_t *recs, int err, gpointer user_data)
> >
> >         for (r = recs; r != NULL; r = r->next) {
> >                 sdp_record_t *rec = r->data;
> > +               sdp_list_t *svcclass;
> > +               sdp_list_t *svcclass_iter;
> >                 sdp_list_t *protos;
> >                 int port;
> > +               bool matches_class_uuid = false;
> > +
> > +               if (sdp_get_service_classes(rec, &svcclass) < 0) {
> > +                       error("Unable to get svc class ID list from %s record",
> > +                                                               ext->name);
> > +                       continue;
> > +               }
> > +
> > +               for (svcclass_iter = svcclass; svcclass_iter != NULL;
> > +                                       svcclass_iter = svcclass_iter->next) {
> > +                       char *uuid = bt_uuid2string(svcclass_iter->data);
> > +                       int cmp_result = bt_uuid_strcmp(uuid, ext->uuid);
>
> I think it would be probably more efficient to convert to data to
> binary format (bt_uuid_t) and then do the comparision with
> bt_uuid_cmp, also there might not be needed to iterate at all see
> device.c:update_bredr_service which has the logic for updating
> records:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/device.c#n4602

I was uncertain whether we need to iterate or not, so I went for the safer side.
However if there is no need to do that then this shall be updated.
I also agree that comparison in binary should be faster.

>
> Btw, we should probably have bt_search_service doing the matching if
> the uuid is set instead of returning all records like it seems to be
> doing that way we don't have to maintain duplicate logic in both
> device.c and profile.c

Got it. somewhere in sdp-client.c is a good idea.
Aside from device.c and profile.c, is this also used somewhere else
though? We might also want to take them out if we are to implement
the check in sdp-client.c.

>
>
> > +                       free(uuid);
> > +                       if (cmp_result == 0) {
> > +                               matches_class_uuid = true;
> > +                               break;
> > +                       }
> > +               }
> > +
> > +               sdp_list_free(svcclass, free);
> > +
> > +               if (!matches_class_uuid)
> > +                       continue;
> >
> >                 if (sdp_get_access_protos(rec, &protos) < 0) {
> >                         error("Unable to get proto list from %s record",
> > --
> > 2.25.0.265.gbab2e86ba0-goog
> >
>
>
> --
> Luiz Augusto von Dentz


Thanks,
Archie
