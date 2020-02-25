Return-Path: <SRS0=zBEa=4N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C4DC35DF8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Feb 2020 06:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DCB7218AC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Feb 2020 06:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lMNll2uB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgBYG7g (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Feb 2020 01:59:36 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36234 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgBYG7g (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Feb 2020 01:59:36 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so13327628wru.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2020 22:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Aka4v4J6eN44pOf1Tlt4VSvLy5q1UFQKce/CVZypNEw=;
        b=lMNll2uB8w6Ybo6kpupHwJevTjQJF7cjcpL80WVtobk6jLowz2t7CK4uafv4sny0xo
         s9B3pMwlaRFvccyeSzulh3ZQLLdlh9xF1HcHcfuqQTMcEOliHlrfKhH+VL13B7qyjuNl
         ghE+b3djlrH0qcqdaOJrJVoradLdQRlqrt/kd+t2bRl1rFZxWumBNqja0HsFKdhAyaKw
         7MVx1QY6UaBSrkTit6CCtFw0vnlTAO50qla6R+WJGzpazRmRhbCxoeaaTGM4TX11SXGG
         JQvapjBFBZN5OMpT5eH0KU/ZEcEqu+n4sbAP2eEGi8oNQ1qZGiMMc3hiZOSLhfYxdFBc
         1Y9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Aka4v4J6eN44pOf1Tlt4VSvLy5q1UFQKce/CVZypNEw=;
        b=h0XT8wkvNfLKNSZC9nCNataq7gnD+gDdm0J5Be4SdJ3g4uH0kFdt6wMQ10UvsymvGl
         I5bQGCcso7aVSMUUi+/ZwMBclm2nf4M0eOV88LorkFjy+g9MWsxbAKcu3jFkB/2qdhil
         C07e7OjAv9X+sVH/VZ8hpYGNdPCouRbZAPkWCD0K1JL9CTTPN5AZfNb8/2hppmHHx08W
         3kjoXNk8RhdNHEJtP60HEDG4G02oL6u9vMSldS3sdzc+q6MU/N23/DByMGPXyakcE8ER
         rEtIO8Q7p1tdrIcmIxqVNLu2WcytJjo3bOzP8W0I3Pwe+q9IjL6CHqUUdpYei+o0FVWS
         z1tQ==
X-Gm-Message-State: APjAAAUvuBLEhsMnqzejO/QbXOuAeHnKhpNI5wfnjBgDGByah09rWN+G
        PS6l9f3a8D+3s9Bfejptp75VCkmARdvVQus8DXWPLQ==
X-Google-Smtp-Source: APXvYqyD+RsQp/VJysfXhinZp+vmG/2N5yxVTFBn12GKQ41ADuv+3/4WYif5/EPX7EjHoTOMd3Gn0b0O4Dy7+1RPJUI=
X-Received: by 2002:adf:e742:: with SMTP id c2mr6926586wrn.262.1582613972896;
 Mon, 24 Feb 2020 22:59:32 -0800 (PST)
MIME-Version: 1.0
References: <20200221163911.Bluez.v1.1.I3c505b4307094eb7a6f2c5949125a17c89b2e099@changeid>
 <CABBYNZKc6UPfYLbesAk0fUaGWFHP6GNtMQHFAOt+p+Yy0jNkWg@mail.gmail.com> <CAJQfnxGoRhuw9_+v=TUXTa1j_rO7qZEVS=UnzS6TwNHt1FudRg@mail.gmail.com>
In-Reply-To: <CAJQfnxGoRhuw9_+v=TUXTa1j_rO7qZEVS=UnzS6TwNHt1FudRg@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Tue, 25 Feb 2020 14:59:21 +0800
Message-ID: <CAJQfnxEce-dH5Qrf538hiKZUvGmWox_Dx-RU6zS3n4Fd4X-F+Q@mail.gmail.com>
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

After looking at the code for device.c you pointed out,
apparently the function update_bredr_services() is called two times
upon connecting to a device, the first one for UUID 0x0100 (L2CAP),
then the second one for UUID 0x1200 (PNP).

I am not clear as to why BlueZ needs to search for those two records,
but this might impacted the decision to move the service class ID
filtering to sdp-client.c, because the service class ID of the records
will never match 0x0100, so it will all be filtered out.

Could you confirm that it is okay to filter all records based on the
service class ID, especially considering all records related to L2CAP
query will not execute this part of the code?
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/device.c#n4630

Thanks,
Archie

On Tue, 25 Feb 2020 at 13:58, Archie Pusaka <apusaka@google.com> wrote:
>
> Hi Luiz,
>
> On Tue, 25 Feb 2020 at 03:30, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Archie,
> >
> > On Fri, Feb 21, 2020 at 12:41 AM Archie Pusaka <apusaka@google.com> wrote:
> > >
> > > From: Archie Pusaka <apusaka@chromium.org>
> > >
> > > According to bluetooth spec Ver 5.1, Vol 3, Part B, 4.7.2, there
> > > might be multiple service records returned in a SDP Service Search
> > > Attribute Response. Also, according to 2.5.2, the service pattern
> > > can match any UUID contained within the service record, it doesn't
> > > have to match only some specific attributes of the record.
> > >
> > > Therefore, before using the service record to connect to any
> > > profile, first we must check that the service class ID of the
> > > service record matches with whatever UUID specified in the service
> > > pattern we are looking for.
> >
> > Im surprised we were not doing this currently, Im fairly sure we do
> > that for the services/plugin though since there are only probed if the
> > service UUID matches
> >
> > > ---
> > >
> > >  src/profile.c | 26 ++++++++++++++++++++++++++
> > >  1 file changed, 26 insertions(+)
> > >
> > > diff --git a/src/profile.c b/src/profile.c
> > > index 192fd0245..1b481836e 100644
> > > --- a/src/profile.c
> > > +++ b/src/profile.c
> > > @@ -1568,8 +1568,34 @@ static void record_cb(sdp_list_t *recs, int err, gpointer user_data)
> > >
> > >         for (r = recs; r != NULL; r = r->next) {
> > >                 sdp_record_t *rec = r->data;
> > > +               sdp_list_t *svcclass;
> > > +               sdp_list_t *svcclass_iter;
> > >                 sdp_list_t *protos;
> > >                 int port;
> > > +               bool matches_class_uuid = false;
> > > +
> > > +               if (sdp_get_service_classes(rec, &svcclass) < 0) {
> > > +                       error("Unable to get svc class ID list from %s record",
> > > +                                                               ext->name);
> > > +                       continue;
> > > +               }
> > > +
> > > +               for (svcclass_iter = svcclass; svcclass_iter != NULL;
> > > +                                       svcclass_iter = svcclass_iter->next) {
> > > +                       char *uuid = bt_uuid2string(svcclass_iter->data);
> > > +                       int cmp_result = bt_uuid_strcmp(uuid, ext->uuid);
> >
> > I think it would be probably more efficient to convert to data to
> > binary format (bt_uuid_t) and then do the comparision with
> > bt_uuid_cmp, also there might not be needed to iterate at all see
> > device.c:update_bredr_service which has the logic for updating
> > records:
> >
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/device.c#n4602
>
> I was uncertain whether we need to iterate or not, so I went for the safer side.
> However if there is no need to do that then this shall be updated.
> I also agree that comparison in binary should be faster.
>
> >
> > Btw, we should probably have bt_search_service doing the matching if
> > the uuid is set instead of returning all records like it seems to be
> > doing that way we don't have to maintain duplicate logic in both
> > device.c and profile.c
>
> Got it. somewhere in sdp-client.c is a good idea.
> Aside from device.c and profile.c, is this also used somewhere else
> though? We might also want to take them out if we are to implement
> the check in sdp-client.c.
>
> >
> >
> > > +                       free(uuid);
> > > +                       if (cmp_result == 0) {
> > > +                               matches_class_uuid = true;
> > > +                               break;
> > > +                       }
> > > +               }
> > > +
> > > +               sdp_list_free(svcclass, free);
> > > +
> > > +               if (!matches_class_uuid)
> > > +                       continue;
> > >
> > >                 if (sdp_get_access_protos(rec, &protos) < 0) {
> > >                         error("Unable to get proto list from %s record",
> > > --
> > > 2.25.0.265.gbab2e86ba0-goog
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
>
> Thanks,
> Archie
