Return-Path: <SRS0=Zhcm=6P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D648C47253
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 May 2020 17:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 183462173E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 May 2020 17:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NaRHZgKT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbgEARR7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 May 2020 13:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729246AbgEARR6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 May 2020 13:17:58 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB21C061A0C
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 May 2020 10:17:58 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id f8so4356474lfe.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 May 2020 10:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NCIQzoQkXUC2sPB4DCcD1ewh2MMBFcxdtF5Uc5/Li6Q=;
        b=NaRHZgKTXiWqpT8hBHW8lzXf9ZulNjem7O0KHmLF7rP9+Ai5KMQuJxX9pEn/eqbbei
         m5kzzlKNNvh6P9BvDAOqpWx9gQERqapXVxag1MlXZCE/OzCE/SysBSKr8DnqGBHrIvJH
         cp9ARzAaz6fwYQ5HQcgV8M298qId1rYMdjA4+3P0q4ykrnz8L9J1zmUCiHDwFp6y2zqh
         YNFKJJqrenr8u4QolILWokbdbp9pDFenGK7nZ5Yc0fkLbzuYCmUCsBVZmdtWJKsVwHF5
         VpfRM7SVrcMB9j8qiHABPYCD06TKuKPSwHAqxExsGQSHJ+KVLUMIi4Ndyxb6okaikKzF
         sckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NCIQzoQkXUC2sPB4DCcD1ewh2MMBFcxdtF5Uc5/Li6Q=;
        b=sRSz0rMNyPvjP3AsGVgkLCbm+V7PYbT35LKMWLlEIMSZPE9ofX+Ta0Gprf/rBFJvgI
         9xvP6mX8wIZu+S8We+PMcahL5KXDlaL5VFgI1MrWRyw6VcsuTW2hFxZ2mPCUaXIaqvxF
         VOKSuOsrDX+e77uatyYcUbcwzswAFmvMXPgH+oL6VDtJ/96Jrw/dGB6E6Y8WQaaKRcqv
         nRlWVwdinPHMdkwP7p4FpBhEEx/g5Obysah5hKkaZNHjda1FVqhng/v7fzSwDSpmcKIw
         /t5URWlYT65YCv5fKgXyOAvvK1xhSS9oYk9u4Mfv0DpNiVxIULyZvRFQISceRnt701jl
         USHQ==
X-Gm-Message-State: AGi0Puanz8FOEHfYDNnkOPw4XtMbzf8EaJxpkM1GkaS44+bXXQQ9Z3Nv
        D7aCRuf3poloYq8eSrE3urRNqcxJ5dW77OWTqB4U7w==
X-Google-Smtp-Source: APiQypJ2NBCBbaD1WyrVEfTMw845r/iFrBMf2gGdCBnbdILr5Ds+p7LeGQfwSwXg3IecMLtcOGpZu9facLadViRkJME=
X-Received: by 2002:ac2:57cc:: with SMTP id k12mr3011693lfo.69.1588353476620;
 Fri, 01 May 2020 10:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200501144037.1684-1-alainm@chromium.org> <4195BFB9-1586-435F-8FC2-ED215959A591@holtmann.org>
In-Reply-To: <4195BFB9-1586-435F-8FC2-ED215959A591@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Fri, 1 May 2020 13:17:45 -0400
Message-ID: <CALWDO_W4AquYjw5LZR+pbFnPEB=shYKDH7_JDGHexpsXUnC7aA@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1] shared/gatt-client:Ignore orphaned characteristics
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,


On Fri, May 1, 2020 at 12:26 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Alain,
>
> > The gatt discovery proceedure simplification to discover all
> > characteristics at once has exposed a device side issue where some
> > device implementation reports orphaned characteristics.  While this
> > technically shouldn't be allowed, some instances of this were observed
> > (namely on some Android phones).
> >
> > The fix is to simply skip over orphaned characteristics and continue
> > with everything else that is valid.
> >
> > This has been tested as part of the Android CTS tests against an
> > affected platform and was confirmed to have worked around the issue.
> > ---
> >
> > src/shared/gatt-client.c | 5 ++++-
> > 1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> > index 963ad619f..d604c77a3 100644
> > --- a/src/shared/gatt-client.c
> > +++ b/src/shared/gatt-client.c
> > @@ -632,7 +632,10 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
> >                       util_debug(client->debug_callback, client->debug_data,
> >                               "Failed to insert characteristic at 0x%04x",
> >                               chrc_data->value_handle);
> > -                     goto failed;
> > +
> > +                     /* Skip over invalid characteristic */
> > +                     free(chrc_data);
> > +                     continue;
> >               }
>
> should we add a warning here?
Is there a good way other than the util_debug mechanism to write  a warning?

>
> And I think it would be good to have a bit more verbose comment why this is done this way instead of aborting.
Ack, will be added in V2.

>
> Regards
>
> Marcel
>
