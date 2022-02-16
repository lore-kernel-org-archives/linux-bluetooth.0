Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0D7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Feb 2022 23:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236398AbiBPXK2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Feb 2022 18:10:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiBPXK1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Feb 2022 18:10:27 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C9028BF4B
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 15:10:13 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id a7so6342530ybj.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 15:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vyXzac/0zfYzFv9ntrE79wtq3ehaIK5D+l9DryAuL0Y=;
        b=naXmXCEqrhXsnYdfNgiuB66zG1FYB0CmBBL6Pk/IiTBtUh7zDKgLbTBujQHneztK9B
         pn3/SbgmfSWXpEWaRXomoKXphmDve4l9mPgZ6j5WXtiPpzFl3phizpMwaIWEuT3jwXT4
         //9WkK4DP5Oo/BbfM9+nwj0ZPK5nAOMkwl7MXLGUtrCJSlZ3n9a25Ln1+YNylRRkRgwd
         cmccotDrBOag9P0N0RvAhRydRKWfFiLLnLdkQKd4NWz3xwcceEzstLW1Jj2s694eg137
         4MQTkn0b5CrnISfqxUOZpkj0rze/4C1PnKZ6ynyldacMDRPftjefOuI/vRkcETJHUbAZ
         RnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vyXzac/0zfYzFv9ntrE79wtq3ehaIK5D+l9DryAuL0Y=;
        b=v+AipQ8efTdniI2EJH48YaUoCCQLChC56DRQk7t/xAlicds6d2JniHdWNv2/Res94A
         roFg8gHlmADxI/5Fr4JEve/5C9DA/Md/cctvdspxERhSzeNcXe5U1V21nDDYf6gC9GvT
         P0XdqgH3vySczjinTvXPPSc4Vd3GvuXz6TqllaC5qv+Kf4xz7kGnJoc5GUSXRjAyeFal
         jFpNkwxeU7nU2k0U5cChbu0+H88hMRLCfPAZDVoXnRAC2uuTjDyGaHcaFtRZgm5RRVF9
         ewFk+p2d94WnbZH/uKfF/KDgKWeEC65PZjDUELKD9Cw1jMuRB8D0DZHmZarZOxKjoqrK
         7BEw==
X-Gm-Message-State: AOAM5310xlREsUgNYYDY86+1waCjElZE+tuOvYZgjrCL1yhHu3xAnx+A
        CKieyIR5gT6HdlVnvYgNLHSSYMwQkjfSj+SqY6Q=
X-Google-Smtp-Source: ABdhPJyF0+7+91Yl5JosYVv1ykUXZe3BRvL7jwJPyz+Z+64tB7SFmAAFfuSLsbgDRco/UsqKlCElXPdS4o7OfQ0aNV8=
X-Received: by 2002:a25:add5:0:b0:61d:c906:f4b7 with SMTP id
 d21-20020a25add5000000b0061dc906f4b7mr170947ybe.284.1645053012998; Wed, 16
 Feb 2022 15:10:12 -0800 (PST)
MIME-Version: 1.0
References: <f610b069-07ab-1004-e8f1-b84533593c92@gmail.com>
 <CABBYNZLA6bRCxd=Tse_XbUT8ReBo4QjvstSassfQAcTX+Fk9_g@mail.gmail.com>
 <b50b9b75-96ea-0d93-3687-3a79cdec5419@gmail.com> <CABBYNZKAUMOZ8vhk2ATPOaVHbcqCTg-DMD2vypkx_CTOjeVg2g@mail.gmail.com>
 <6bec2be7-a411-c5bf-6e5d-b3efee33b834@gmail.com> <CABBYNZLAZGoB1JKW63SNJuFB-4raDvHjjEk4w8y0K1MLwe4b7A@mail.gmail.com>
 <b7a2b073-fd69-36a4-6ce0-cb1b942ccde6@gmail.com>
In-Reply-To: <b7a2b073-fd69-36a4-6ce0-cb1b942ccde6@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 16 Feb 2022 15:10:02 -0800
Message-ID: <CABBYNZKjUYAqctfpap2f36TcBuJFk0wX5P8jkUjpw1qqupeb0A@mail.gmail.com>
Subject: Re: Lenovo Legion M600 wireless bluetooth mouse connected and paired
 yet not working
To:     Andrey Butirsky <butirsky@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Andrey,

On Wed, Feb 16, 2022 at 2:36 PM Andrey Butirsky <butirsky@gmail.com> wrote:
>
> On 17.02.2022 00:08, Luiz Augusto von Dentz wrote:
> >> It's BlueZ Version: 5.60-0ubuntu2.2, Ubuntu 21.10
> > I try upgrading or better yet use the head since we have some fixes like:
> >
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/profiles/input/hog-lib.c?id=0516d2527ea83c8fa209d52c564ce99408a00fbe
>
> Tried BlueZ 5.63 on my Fedora installation, no luck. Will try to build
> head if no better idea..

If that doesn't work I'm afraid you will need a dedicated kernel
driver in order to deal with its HID reports since BlueZ just forwards
the reports to the kernel.

-- 
Luiz Augusto von Dentz
