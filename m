Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6099BC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Aug 2021 17:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33FCD610A3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Aug 2021 17:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhHSRpk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Aug 2021 13:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhHSRpj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Aug 2021 13:45:39 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA6DC061575
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Aug 2021 10:45:02 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id r4so13828902ybp.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Aug 2021 10:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uDvWVzqUKaop+1txInwLKELJp2awJzQKE5jYu4Yk5WY=;
        b=refKDQQcgI0nIgYWjhjipvDXBaBRVHFnonXKlzTWhUQTaZH1ke5lQqYaLcUGx2PkXc
         2cYpYMFreo4h3Z0SdLLBf0Gcptn6HKpuQSRy9uLRQJQyZcJjX86pd/IQNWVFf4zxUh+8
         4bK6CiBzhGiLGR2WwbZNV8FhM3anBmI/iQFBbSbGIscm2Ux+zRGau+9onXqKrS5xvXxr
         f0XF2BEptRxqbEYD6yNX/OJVBeCIYAkcfJtImjq69amfv5Ir0mv1DpUU1V2a093MYwir
         bxoo172Qo+gjGaAGC4ZLXiQKiWwDA1NJ9uX1Do53q1yns/PRH3DNzt9U7tVDsHWGhnuX
         cjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uDvWVzqUKaop+1txInwLKELJp2awJzQKE5jYu4Yk5WY=;
        b=F29i3g/Ri7YvUVXFi5GTcxexrMRE9GZY0EyNqxyHCeWdEh9+50K9bLDtVOGH+/sen+
         TLalj+3ZgUSAggdRgwGODlbLXm0bi3GtsPn79AF5gTQrXn4PjflgtUMzQXX266wOjTV6
         Wp9h3AXemwCxssxvet54wVmZFg+sWtHPlcwWbxN4M+I2DyW41ksMJmhjhwEWWepuEbrM
         tEZu2oy+oxtkXWO8IH5cP4AbIAxh6iBcMNaTkkeUuolYdJFa8y5oE6X0BpdL43gMQAFp
         yOBpMP7y6iXIFqpdWB78PVsiJdelozI8+KYBKz3doqo/GkxiJqJq1OFJbB8KHJxqJTXW
         kjFw==
X-Gm-Message-State: AOAM530Osfqa8YPkdsYnLVQSkvzIZoVINoztj+LaVSy/kyEQlibiBI0r
        aUrsah6dD1CC/I5NcLaUDt6W/Q+Jzvqw4U4yefohoI8T
X-Google-Smtp-Source: ABdhPJzqyB1luAfqjenefWXiTSQSN5CDDRc6+yQk9m+eXh1kG70rC58JYdAv1vWauGFivJyVUAeMEooQ6en6iUsadlw=
X-Received: by 2002:a25:bd89:: with SMTP id f9mr19564079ybh.222.1629395101855;
 Thu, 19 Aug 2021 10:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210817010237.1792589-1-luiz.dentz@gmail.com> <58749BBA-28F0-464E-8CE0-22FD1FEFBDD9@holtmann.org>
In-Reply-To: <58749BBA-28F0-464E-8CE0-22FD1FEFBDD9@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 19 Aug 2021 10:44:51 -0700
Message-ID: <CABBYNZ+5y_e6gSTekN3t_nzwn=16iwJMoFzcdNN0w3D5QhD=Fg@mail.gmail.com>
Subject: Re: [RFC 1/3] adapter-api: Add Experimental property
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Thu, Aug 19, 2021 at 7:57 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > This adds Experimental property which indicates what experimental
> > features are currently enabled.
> > ---
> > doc/adapter-api.txt | 5 +++++
> > 1 file changed, 5 insertions(+)
> >
> > diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> > index 464434a81..13e904425 100644
> > --- a/doc/adapter-api.txt
> > +++ b/doc/adapter-api.txt
> > @@ -335,3 +335,8 @@ Properties        string Address [readonly]
> >                               "peripheral": Supports the peripheral role.
> >                               "central-peripheral": Supports both roles
> >                                                     concurrently.
> > +
> > +             array{string} Experimental [readonly, optional]
> > +
> > +                     List of 128-bit UUIDs that represents the experimental
> > +                     features currently enabled.
>
> I wonder if this is the best name.
>
> Do we care about just the enabled experimental features or the overall supported experimental features as well. And please keep in mind that we also have per-adapter vs global experimental features. So we should distinguish here as well.

This is per-adapter and I guess the global one would could exposed on
all adapters since we don't have a global object, or perhaps you are
suggesting to use / for that?

> We also need to document that this property is only available if bluetoothd is started with -E and otherwise this property is omitted.

Will add it.

> My proposal would be to at least name it ExperimentalSupport or ExperimentalFeatures to give us a path to nicely extend it if needed.

Sure, I do wonder if we should make it writable as well, so
applications can enable/disable experimental features themselves? Or
perhaps that is going too far as to enable unstable code by
application, it would only work when -E is given thought which would
enable everything anyway but I was thinking on having -E optionally
take a list of UUIDs so one could enable just certain features
instead.

> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz
