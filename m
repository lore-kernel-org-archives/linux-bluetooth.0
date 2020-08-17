Return-Path: <SRS0=KHjC=B3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7357AC433E1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Aug 2020 21:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46B6A20738
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Aug 2020 21:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KdbZs+H5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgHQV2u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Aug 2020 17:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgHQV2t (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Aug 2020 17:28:49 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8FCC061389
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 14:28:48 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id cq28so13572391edb.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 14:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bBCMQeGY4Yt1dNxEDMZhgLQrrMQkGXldrNWfS6LMfEI=;
        b=KdbZs+H53rII9I5yLj6Q2r22pr4S+R+pjy8gN4X9GI+3O0YcCSAROczL+a5sE1zioG
         021VvT5EPdrc76z4Q5OX4K054JywINWd8qoBGWrigZ8pAJXKgG3Te0Zje06FbfmCwmJF
         vcuPKtv5tAYKvOBxaTu8isc9KsW/dQsvHPT9viYaEp3eHbk19vdluvqSnosaAV/NiEYB
         NCUwrgljyTiomLNztyE8K+cHZPPGSlABlGu/D6MdFWClPYc5xEsu0G7YnJRv9ya1FMnx
         0fOq27OWP//x8mm69fV8tNAOxorV4AXX1LBXX67GfzxUIRxA2JKa2KKqK249nSeWJB+D
         /sHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bBCMQeGY4Yt1dNxEDMZhgLQrrMQkGXldrNWfS6LMfEI=;
        b=TC9KcFnF+7klp/Tqmq/4CKpg+ceZg2napwjXqvP32vO9V6PsK3UICBmK+kzo5fnTx/
         DXDNO6S0rh7aNOZLzybVx6+tBhtkgpCsgG6Qgswogu+3Fw4ve1M/iYAnncxNU9m1zwmW
         ZIIa/dSJh0SAFFULgzQEg7h5U8vzAZyIXR8hH7X2OErt+JAZ0NbxtRUETaN1vQ+Aiy01
         5B/55HiWU4AsQiDGid2Vy8zG1r0kIQsmtCiOXoBkqu5lQ5W+z/ZAz+WUkosllVzRkWRW
         +YDGOZk85QnWX7ZmOjxh+YnyDvj2/bT0v/AErMWAFlL4AySs5W1HxSeWHksWRER8142i
         Ydnw==
X-Gm-Message-State: AOAM532RQputhBYLhsiu6yBpECHcZXH1IEIbN/+OrfCjTxcs+6xKPbVh
        ebV/a9p5giju7ri3ip1gTw9VSaiq4e2JakjUysMLsJpaRFDK0A==
X-Google-Smtp-Source: ABdhPJxUCRKz+bCfFDCMDvf3n5ZZbEeyIGgUUa/WOPPLmnwpuOJNi1ahBrCJpczUoJtODHY5iCYJWgYf3hvAWLhyjrc=
X-Received: by 2002:a50:f311:: with SMTP id p17mr17507537edm.37.1597699727322;
 Mon, 17 Aug 2020 14:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200803235811.2441774-1-yudiliu@google.com> <20200803165804.RFC.v1.1.Ibaa1dfd49179a141c19a651f3c2132a28b71b344@changeid>
 <7D5EF527-14F0-42C2-B39B-50B55F01BE74@holtmann.org>
In-Reply-To: <7D5EF527-14F0-42C2-B39B-50B55F01BE74@holtmann.org>
From:   Yu Liu <yudiliu@google.com>
Date:   Mon, 17 Aug 2020 14:28:11 -0700
Message-ID: <CAHC-ybzq91aAHWtQUt_4PN9OF0yzXsW_7dWR37go6Q5+Cjre=A@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] adapter - D-Bus API for querying the adapter's capability
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

Thanks for the suggestion, after talking to the original author we
dropped the original idea and added the new API as suggested. Thanks.


On Wed, Aug 12, 2020 at 5:13 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Yu,
>
> > Initially this is introduced to query whether WBS is supported by the a=
dapter,
> > the API is generic enough to be extended to support querying others in
> > the future.
> >
> > Reviewed-by: sonnysasaka@chromium.org
> >
> > ---
> >
> > Changes in v1:
> > - Initial change
> >
> > doc/adapter-api.txt | 17 +++++++++++++++++
> > 1 file changed, 17 insertions(+)
> >
> > diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> > index 1a7255750..250d0e9b3 100644
> > --- a/doc/adapter-api.txt
> > +++ b/doc/adapter-api.txt
> > @@ -204,6 +204,23 @@ Methods          void StartDiscovery()
> >                                        org.bluez.Error.NotReady
> >                                        org.bluez.Error.Failed
> >
> > +             dict GetSupportedCapabilities()
> > +
> > +                     This method returns a dictionary of supported
> > +                     capabilities that is populated when the adapter
> > +                     initiated.
> > +
> > +                     The dictionary is following the format
> > +                     {capability : value}, where:
> > +
> > +                     string capability:      The supported capability =
under
> > +                                             discussion.
> > +                     variant value:          A more detailed descripti=
on of
> > +                                             the capability.
> > +
> > +                     Possible errors: org.bluez.Error.NotReady
> > +                                      org.bluez.Error.Failed
>
> can=E2=80=99t this be just an array{string} that lists the capabilities?
>
> And if we introduce it, then lets introduce it also with the first user o=
f it. Otherwise we end up forgetting to comment on the actual possible capa=
bilities.
>
> Regards
>
> Marcel
>
