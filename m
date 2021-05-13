Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8D8C433ED
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 May 2021 20:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7FC46143E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 May 2021 20:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbhEMUeF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 May 2021 16:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbhEMUeC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 May 2021 16:34:02 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A20C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 May 2021 13:32:52 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id g38so36264754ybi.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 May 2021 13:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9gSJvxq9TZXq1GwaseZEPaKwcE1dnQixxohqgAeeFXo=;
        b=ixMpTGYfNiho9J8nc/X6oD3d2bp8YRQsbLYaa2Gh26K0LLGzZDYaFL63KzKiIiRSUs
         fHW5GjL3utUKu66QEFS5c9H43HAQtG+pSo99GLH47DafInxZLC8hTaYqCmqzSJ2Dpvvj
         l8E05AWeAGCMI3T5jmF3L5S22Ckw9HTBZl2DIsRhxnihA2g7e9RCry8HZYhM/IZA3hGw
         BZcu3OxLtWlKrDEu+/mzz71MT/5/3CFw+L925sI8yHZOiLS1cLrtPcVsBycWNwsbPC9M
         x4dPCk0ZP/9B1HJobBJH8OxLaHdyC7wOqSblWrSyEcdHkCjAW9arsOCoR6qhhM7MZ9JJ
         ILXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9gSJvxq9TZXq1GwaseZEPaKwcE1dnQixxohqgAeeFXo=;
        b=mJ3BoJip3lKJjq5vzuZRstgfNOnVfMsxv9wdievvahLTD3fMsAJDtksSHHVoytAsxr
         xY1w6jSHzymiIda7ZtnvncVO+swxHlc7vS2cf6/uG90hytJjH4lFR/RXlooSMkqJh1MV
         I4OG+SLhNKia9tf5i2rG4dedhteC7PrwbbHfQe2YERJj+HC/gtDtEyhOkpcwWqCghWpB
         XrNKk/ycujsbaxOf83/Hee1DOrAaHPHID+ZC3Joqs2KNFjbhuidamR4XOWjKo8icVRto
         vESTR4JE5iZVStqjvqg6sMN13zcGybCO3LOzjfFz9y0EZgS1uZdrciB6GDXlPZ+F4u5x
         fFvg==
X-Gm-Message-State: AOAM532SQKfjt9wfj7iAHMKZ3CgvICQr1dLpDZFUdyESfMtvovwEkS1c
        6gqWkFBHi2fBwtI/s2+8dk28Pom6bslpEU4b+h4=
X-Google-Smtp-Source: ABdhPJxXIynL4vjp9xtzrhWgJQafEZbXPDvzXp9lSvCpZRvdufyM/S90Txf+5DEc0+7lLcz4lYa5nEoXhs2wuRr2s94=
X-Received: by 2002:a25:ad8b:: with SMTP id z11mr30920248ybi.91.1620937971792;
 Thu, 13 May 2021 13:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210512133932.4e2b4bd0@ivy-bridge> <6af830fc74d50c722ecb9855038a00bf6673d4e5.camel@hadess.net>
 <11748148.O9o76ZdvQC@x2>
In-Reply-To: <11748148.O9o76ZdvQC@x2>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 13 May 2021 13:32:41 -0700
Message-ID: <CABBYNZ+1cCbHn6JaKM-GEAHQnZLr-SGRA=+fRiVd6haYqPaW+w@mail.gmail.com>
Subject: Re: [PATCH 1/1] Fix various memory leaks
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Steve,

On Wed, May 12, 2021 at 7:12 PM Steve Grubb <sgrubb@redhat.com> wrote:
>
> On Wednesday, May 12, 2021 6:35:54 PM EDT Bastien Nocera wrote:
> > On Wed, 2021-05-12 at 13:39 -0400, Steve Grubb wrote:
> > > diff --git a/obexd/plugins/filesystem.c b/obexd/plugins/filesystem.c
> > > index 09bff8ad0..44e3cf3d2 100644
> > > --- a/obexd/plugins/filesystem.c
> > > +++ b/obexd/plugins/filesystem.c
> > > @@ -415,7 +415,7 @@ static void *capability_open(const char *name,
> > > int oflag, mode_t mode,
> > >                         goto fail;
> > >                 }
> > >
> > > -               object->buffer = g_string_new(buf);
> > > +               object->buffer = buf;
> > >
> > >                 if (size)
> > >                         *size = object->buffer->len;
> >
> > Pretty certain this is wrong.
>
> Yeah, now that you mention it...that is a GString object. I guess we
> g_free(buf) right after the g_string_new(). Should I resend just that one
> patch or do I need to regenerate all 7 emails?

Please resend as v7, also while at it remove the signed-off-by as we
don't use that in userspace.

-- 
Luiz Augusto von Dentz
