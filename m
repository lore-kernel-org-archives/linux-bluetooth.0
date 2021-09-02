Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FD7C432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 10:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23403610E5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 10:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244263AbhIBKxf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Sep 2021 06:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343663AbhIBKxP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Sep 2021 06:53:15 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37619C061760
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Sep 2021 03:52:17 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id p38so3396137lfa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Sep 2021 03:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EIpTy5Vus5ffXqjgss7nsHfMWwAe6f3djEtBXgWoKCE=;
        b=qwKHsmyFjxfEVVtxjHy6jCmTQ6vdShnHVvHxdBV2YNncKiUgovnofCCqeHLI1sAuTH
         m/MJIzVgPIR2w6GWF/JFvAh9Xo/8sIVx75StYr++YOq8OXUpx2xEj1VpZ5cmg4qprvMA
         pMXHrrHvh5/zwmlPamWkFH7dJqsnoP6tmXXRHtA4yY5dUpFxMCyn+9xaMhb6QwEyQgMU
         s7OiYOt2yxYkKyK91lUVIc7nGIKj+Lgzz+lhXOuZUvZ1+iQ8xaVdzP0HUqEndvulxl1Z
         wbdZYg18C7XIQeya2FFMQi9+S2GYPKVqAiE5Dp+YnEL7tVrc+QDcPdc68w7YPfhqayXs
         VK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EIpTy5Vus5ffXqjgss7nsHfMWwAe6f3djEtBXgWoKCE=;
        b=s8T9pWH9DMhnqPpqM7fUHZtnQNkaTaXMZxM9Vp5U5yMxtWdXgW0p4bRe9/FBed51VP
         hm5/yUndaL5WUUjS4Fp74+kW5tGDytLOiERZUtlp8MPVgX3lT+IwyaKF5FAZ+xuKLQ+o
         FaE5TodQiSDcXihuJgSNFTfp4oQbepq6T8Fv2iLXU6JNK264Su2xLhOlGfkFx0vtz3eb
         gcppLua8N02arb0K3c9qIySbOt9/unA2mqYJmoycoJL8EgHTQYPlQB9ZXTDx2nvYh8jU
         7BBmOI55E/OyRQzCEUVPVXl0UZ2TBv4DqcHtJLxCvVxYvjhT3vAvCygW4rTvb/vbrGeu
         ih+w==
X-Gm-Message-State: AOAM530lz2JqnvZ5mq5TWgcFp7Vne2dE3U5YFx4vVH6q2ywp8FMsGbqK
        ol9jB2GFXxZJyLEX79ZVm6+hJthJY65J6VF/SRDxCw==
X-Google-Smtp-Source: ABdhPJyX8omWj4QjKF1FaqwP/HHvNK4aRgcibmW7psgAxx4mD+Xe8N7cb38ss0bBV2C/c3R8twUN04wCS+7uz3UoIKk=
X-Received: by 2002:a19:f503:: with SMTP id j3mr2166069lfb.290.1630579935159;
 Thu, 02 Sep 2021 03:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210902040711.665952-1-apusaka@google.com> <20210902120509.Bluez.v2.1.I3be2e373e96293524fa38328ebac177eddc71938@changeid>
 <3D29644F-F6C1-463C-83E6-23CB3FD00057@holtmann.org> <CAJQfnxEHbXzfm_2+zvZyKwwGOdyLYSKbXiMuZd3qo6RK9a494w@mail.gmail.com>
 <33EE4DB9-DAA9-4D63-AFC0-7B4FEF789B4F@holtmann.org>
In-Reply-To: <33EE4DB9-DAA9-4D63-AFC0-7B4FEF789B4F@holtmann.org>
From:   Archie Pusaka <apusaka@google.com>
Date:   Thu, 2 Sep 2021 18:52:03 +0800
Message-ID: <CAJQfnxF2y2+TgnEtKrJWppsiA+NaiyU6cpmcZ8pzuRSm4dStbA@mail.gmail.com>
Subject: Re: [Bluez PATCH v2 01/13] lib: Inclusive language changes
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

Thanks for the pointers.
I sent a v3 series of the patch which omits all changes in
libbluetooth. Please take a look!

Regards,
Archie

On Thu, 2 Sept 2021 at 17:35, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Archie,
>
> > Could you give me pointers on this libbluetooth API?
> > I can't seem to figure out which ones of these replacements belong to
> > libbluetooth.
>
> take a clean git tree and do this.
>
>         ./bootstrap
>         ./configure --enable-library
>         make
>         make install DESTDIR=$PWD/x
>         find x
>         rm -rf x
>
> It should give you API from the include directory.
>
> x/usr/include/bluetooth
> x/usr/include/bluetooth/cmtp.h
> x/usr/include/bluetooth/hidp.h
> x/usr/include/bluetooth/bluetooth.h
> x/usr/include/bluetooth/bnep.h
> x/usr/include/bluetooth/rfcomm.h
> x/usr/include/bluetooth/l2cap.h
> x/usr/include/bluetooth/hci.h
> x/usr/include/bluetooth/sco.h
> x/usr/include/bluetooth/sdp.h
> x/usr/include/bluetooth/hci_lib.h
> x/usr/include/bluetooth/sdp_lib.h
>
> So any change here is fundamentally an API breakage.
>
> Regards
>
> Marcel
>
