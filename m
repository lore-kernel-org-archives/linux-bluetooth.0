Return-Path: <SRS0=qc6f=CZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04749C43461
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 23:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACEEA22207
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 23:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AmHXne3Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgIPXWu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Sep 2020 19:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgIPXWs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Sep 2020 19:22:48 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D71C06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 16:22:47 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l17so313390edq.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 16:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qMsguu8tJLPB5Vgo+RL9WgHX2Yp6h0a1DLW8ySVT02U=;
        b=AmHXne3YhBQCkkgDfCre4DBbLLDFt/9aqLpqwbv3EX13EmkJWIISxNslkTbNwI0E++
         xmKypgK0mzCPBdj4zzrkShsGzaCYPFI4bjp/nUNzLmU7h1eiTEXbjpPQqqdqFUPJardw
         n/MBBHEFLnr4G+aBI9vUfhmDIVGU1sv2ZiY18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qMsguu8tJLPB5Vgo+RL9WgHX2Yp6h0a1DLW8ySVT02U=;
        b=YfsCj/pk5hf1QD9HJvtgNDXAsUdstAi/m4WwSOSSC0hgOICnVclL66Mh4JqMLiVx5S
         5huhYWZFcNjbSoNDu0SLlR+CCgY+oS9iUoN+G0pmZG3x7OQjx3ZpL2VjblzaJ5y9srf/
         ngjxP03ww1jMHDRWJzAtH+CYnj93a078CIjWYPEIDq17NOA6zFYNqVUPQ1XO8vdkrWHh
         kp597Wr2D2C5aXA/6CbB4FIZ4cWe+27iGJFKSOAOYixvbA3B+RPKT1M35kIRED3Iw5m5
         Pv5jQXJiaA5KKnRqaUGQAz/WnBAtwZ5tMhWr0bMLZoBjjEvQ465wtQh7ti1BERC+vqCb
         vICw==
X-Gm-Message-State: AOAM5320FIwJJMHziHbrvsGxeNdtTUyWG+1JF6WKQuw5Dg+WMXn3U70s
        iuEYFhg71iqkM5apg3D6O/+K1Jwvh3p5LA==
X-Google-Smtp-Source: ABdhPJyEaHne5vptjZFye8ehjHRADcGAWC818ri9PTeA2BoIIsnDoLrSLP3ara1MizQ5fUC/lsdoTA==
X-Received: by 2002:a50:fe07:: with SMTP id f7mr31416640edt.173.1600298565174;
        Wed, 16 Sep 2020 16:22:45 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id r15sm14974237edv.94.2020.09.16.16.22.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 16:22:44 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id j2so45579wrx.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 16:22:44 -0700 (PDT)
X-Received: by 2002:a5d:574c:: with SMTP id q12mr28880581wrw.253.1600298563795;
 Wed, 16 Sep 2020 16:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200813002819.359374-1-sonnysasaka@chromium.org>
 <CAO271mneguPsiJRNjW44oGEHZSuYof0og9+cHxByqoOntjevYw@mail.gmail.com> <CABBYNZL1jaVfvxAZ0GVEa2A0i_8bw_=ynYPL7z20H0ZkDVF3xA@mail.gmail.com>
In-Reply-To: <CABBYNZL1jaVfvxAZ0GVEa2A0i_8bw_=ynYPL7z20H0ZkDVF3xA@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Wed, 16 Sep 2020 16:22:32 -0700
X-Gmail-Original-Message-ID: <CAO271mmH3r-S-4fDgraQ892JvxbJhwdDsTLKVJMBigm5+aLHfw@mail.gmail.com>
Message-ID: <CAO271mmH3r-S-4fDgraQ892JvxbJhwdDsTLKVJMBigm5+aLHfw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] checkpatch: Ignore SPDX license tag
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Thanks for the clarification. Please do ignore this patch then.

On Wed, Sep 16, 2020 at 4:05 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sonny,
>
> On Wed, Sep 16, 2020 at 3:43 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> >
> > Dear BlueZ maintainers,
> >
> > I saw recent patches that BlueZ started adding SPDX license tags to
> > file headers. Is this where the convention is going? If so, please
> > ignore this patch.
>
> Yes, it is better that way so we don't have to keep up with the
> license on every file and will probably attempt do some automation to
> check if SDPX Identifier is proper.
>
> > On Wed, Aug 12, 2020 at 5:28 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> > >
> > > BlueZ does not use SPDX license tag on file headers.
> > >
> > > ---
> > >  .checkpatch.conf | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/.checkpatch.conf b/.checkpatch.conf
> > > index 419733832..72c3529c3 100644
> > > --- a/.checkpatch.conf
> > > +++ b/.checkpatch.conf
> > > @@ -12,3 +12,4 @@
> > >  --ignore PREFER_PACKED
> > >  --ignore COMMIT_MESSAGE
> > >  --ignore SSCANF_TO_KSTRTO
> > > +--ignore SPDX_LICENSE_TAG
> > > --
> > > 2.26.2
> > >
>
>
>
> --
> Luiz Augusto von Dentz
