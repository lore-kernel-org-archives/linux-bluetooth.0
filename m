Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F696C05027
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Feb 2023 20:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbjBJUHa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Feb 2023 15:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbjBJUH3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Feb 2023 15:07:29 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3ABF74990
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Feb 2023 12:07:28 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id br9so10009013lfb.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Feb 2023 12:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bt7Bpcpkf0OLnw3d3NWkNkvghIo3oJeJMA55iCEvmp4=;
        b=U5wd1HIhdan6w+RJH40ycyZthodabXXipzdb5JexVCmpOgkkmi2zz5y/MXscIS0r2K
         Z491jrhpPIK75bHQbMILxfDQlQxiot8qzPIB9gD+Fkw6BKE+9sXVrQLmJK9cyI27HWiD
         IOgwb2Vo9Kk2/bEMqeYNC5brU28wzR1rWawx6Oj2O3HPS8TpG6s5KpbLQILJ8W4bWt9M
         ATqlT5MSRBLFdv8P7BRzDAmT5ScDKSEI2wGMQ7UvVzd3ncINFaM6UqdcDbQF4jV+D/fR
         LnAApw10eMjx8PaGeR2oDrVXgIDgKCFrWjJFCnwct0oOsYJNXj18M1H2GpKfNMqNYdgV
         QX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bt7Bpcpkf0OLnw3d3NWkNkvghIo3oJeJMA55iCEvmp4=;
        b=5/IuTjjrcQzFDxOslKdobMb5YoFv4aMd9RulA0ZCjxEM8t3VFqswiTPiBkgr3HMCGy
         DCmu755MGC2Zxuj/bCztpjSI9Xks5eVqpjYeAmpDYOSuh7YAyH+00g9/ULrZP/+IcErJ
         FW2bS/BKQchEYzMzNFHiEo8Yrz9BIz6jCyLDzwWlJSD8kqibX+7llncPjdmtYhBxi9Ng
         xwNJk6fBcTIF5aC7rgcPvV5VwSSbjHRLZ7fkWWsF1/vVFJ0wBFA1xpyh4yBMPppWstPq
         3ZKRcsEBtd3ECLHjz4HvdKffdumADOgtvgwq61mxzIbHCUl21ouXIspVasf9zb4H6/Kb
         OgIg==
X-Gm-Message-State: AO0yUKUTRWVXAjS6Vn3hW5tmo4hnvn5Nwm/ha1c7JNIrQXA6HeX9rtUJ
        nE9GA4K/ySov8Kww9NoHXnVR99J8Xc9hl8PxhtuIqBxOWlw=
X-Google-Smtp-Source: AK7set8aJMg6aKE5+1THtDYEEz7ySWeZJewRkohTB9XEl5B8N/l5iovUaVV1F2mvwkrtugY+wFaJ+uZaoAz5h16OtlQ=
X-Received: by 2002:a19:c51a:0:b0:4cc:84da:1ef6 with SMTP id
 w26-20020a19c51a000000b004cc84da1ef6mr2474132lfe.262.1676059647085; Fri, 10
 Feb 2023 12:07:27 -0800 (PST)
MIME-Version: 1.0
References: <a8aedc0f9a4c1e21d61694589c5b7a9f31cbedc1.1675103676.git.pav@iki.fi>
 <CABBYNZLWt6y7beYF8-62G018LY+8yHSOhQAdvVKFbWn1YDzKQQ@mail.gmail.com>
In-Reply-To: <CABBYNZLWt6y7beYF8-62G018LY+8yHSOhQAdvVKFbWn1YDzKQQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 10 Feb 2023 12:07:15 -0800
Message-ID: <CABBYNZL3mhOkiNgxG50ZgWNwKHVMXdKVkDgDBsXvviu+Ds3h3Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/8] doc: add MGMT setting for CIS features, remove
 Quality Report
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Mon, Feb 6, 2023 at 5:08 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Pauli,
>
> On Mon, Jan 30, 2023 at 10:43 AM Pauli Virtanen <pav@iki.fi> wrote:
> >
> > Add definitions for new MGMT Controller Information settings bits,
> > indicating adapter Connected Isochronous Stream - Central/Peripheral
> > feature support.
> >
> > The Set Quality Report command was removed in
> > commit 0454e2d09570 ("mgmt: Add support for Mesh in the kernel"),
> > but the settings bit was not removed. It's also not implemented on
> > kernel side, so remove it now.
>
> Let's split this into 2 patches, one removing Quality Report, since it
> was never implemented, and then another including the new flags.

Are you still planning on updating this set?

> > ---
> >
> > Notes:
> >     Was the quality report setting bit reserved on purpose?
> >
> >     From the commit log it looks like it was forgotten to remove from the
> >     docs, but this is not clear.
> >
> >  doc/mgmt-api.txt | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> > index 90d612ed8..58395dc90 100644
> > --- a/doc/mgmt-api.txt
> > +++ b/doc/mgmt-api.txt
> > @@ -332,7 +332,8 @@ Read Controller Information Command
> >                 15      Static Address
> >                 16      PHY Configuration
> >                 17      Wideband Speech
> > -               18      Quality Report
> > +               18      Connected Isochronous Stream - Central
> > +               19      Connected Isochronous Stream - Peripheral
> >
> >         This command generates a Command Complete event on success or
> >         a Command Status event on failure.
> > @@ -2925,7 +2926,8 @@ Read Extended Controller Information Command
> >                 15      Static Address
> >                 16      PHY Configuration
> >                 17      Wideband Speech
> > -               18      Quality Report
> > +               18      Connected Isochronous Stream - Central
> > +               19      Connected Isochronous Stream - Peripheral
> >
> >         The EIR_Data field contains information about class of device,
> >         local name and other values. Not all of them might be present. For
> > --
> > 2.39.1
> >
>
>
> --
> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
