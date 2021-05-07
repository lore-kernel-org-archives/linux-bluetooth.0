Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6C4C433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 May 2021 16:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 769B861431
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 May 2021 16:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbhEGQph (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 May 2021 12:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236871AbhEGQph (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 May 2021 12:45:37 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73E7C061574
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 May 2021 09:44:36 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id q10so4909153qkc.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 May 2021 09:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rehBiwuqoeTrE/V+jkpp/fz3FhsW+pn7PjItMnFizDE=;
        b=YZ1ijAGqg3pvyAvGOEMdNWMjbmrf7tkj8gFJMjGHS2/ze1XbXlUJllHFzfSqfoaPxz
         +ipiHHv0jcFNf1jWHjJpP+8pHB62jW8zPfh1AWvMpbUB4+Zmod3H1UcVkeEtKZ8q0LLU
         JAGE6DlJ5SjFV4kNSJ4xtSn+HGd7H8GeuKfWA9dSbfTPgIBm7FdHbegX16BhNl7vGyXK
         59GvRdspqyFBQY69g2gWchkR+3jRrG9rEZtjcRU0KdvpiJztNBeMKXEX4Vc0i9aiOGxK
         +Qs9f9PRvDjJmkLM5NiK+M3pozmbMwLmdbtsRSMzffsPuqOqGK27VERW0l0DDJ8odTEC
         2Tzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rehBiwuqoeTrE/V+jkpp/fz3FhsW+pn7PjItMnFizDE=;
        b=qh6F+KxORjDasN3g3yJir4/+0cQjMLusV5Rf4ucc9F+3cZpb3M0AD6eyHaAVIDv9in
         6m9WqoFN0apfQeh/TSFymnxaTW87IF5Zjc1rPidevq/ExXVHkvrlaxj2dzBkkqMMsSP0
         zDu5FKLDpYFgvbm+Q47avmT44rl16niBABua0QUXjWRVCXQERS3L50et2M+pm2/IEmOJ
         aSz47tl4wCydBw5EH62cHZyY8Tah54AvbAfh0k9cFlSSpIbKz5M62mptQMyrFC7CgMl/
         j6gm/+05v3rlLgVGMn1dhL7HJcZtrdD9aaLiTymzszX5R/QkkR4YICkRqBdqSYaXLotl
         cLPg==
X-Gm-Message-State: AOAM533ghD4iLTtlqasel5GJ2JRB63dMFOi+zJfeX0igTwE4H/ib48v8
        NM0EEhbI0UuzOa9Xk9iZ9Yx4k928fqPnmKrmGBBivA==
X-Google-Smtp-Source: ABdhPJyBJQn38augY52BG3hA6ZrZ5n0fI7pF7Q+rC91BZuAXIVzbrTXH7Hi2dvRhv6eDaDiuKtEiFgMmHScZj/bONCg=
X-Received: by 2002:a05:620a:208a:: with SMTP id e10mr6166186qka.112.1620405875829;
 Fri, 07 May 2021 09:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210429111523.Bluez.v1.1.Ic00ed950add081b346d6c8ced590bb7b2eb6e9f7@changeid>
 <44A0B714-12C5-4A43-9829-CAE3D8BF374B@holtmann.org>
In-Reply-To: <44A0B714-12C5-4A43-9829-CAE3D8BF374B@holtmann.org>
From:   Yu Liu <yudiliu@google.com>
Date:   Fri, 7 May 2021 09:43:59 -0700
Message-ID: <CAHC-ybycimdB4q13Dd4omTDu83NhZQJ0jR7_bXi0fKDJpu3jFg@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] doc/mgmt-api - Add a new error code for HCI
 status 0x3e
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

We have a couple of bugs where the controller failed on the Read
Remote Feature command after initial connection with the 0x3E error,
guy.damary@intel made some suggestions after root caused the issues,
you can see his detailed suggestions here:
https://buganizer.corp.google.com/issues/174806913#comment98. To
summarize: he suggests us to retry up to 3 times if 0x3E is
encountered during LE pairing.

Regarding this change: I see MGMT_STATUS_CONNECT_FAILED could be
returned under 4 different scenarios, 3 in the mgmt_status_table table
and 1 in pair_device as a fallback error to cover all the other cases,
so I decided to introduce a new error code to make sure we don't retry
in the cases where we shouldn't. If you think this cae be avoided by
checking other flags at the same time, I can then drop the change from
the kernel and only change the user space.

Thanks


On Fri, May 7, 2021 at 1:19 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Yu,
>
> > We want to retry the pairing when HCI status 0x3e (Connection failed to
> > established/Synchronization timeout) is returned from the controller.
> > This is to add a new MGMT error code so that we can catch this 0x3e
> > failure and issue a retry in the user space.
> >
> > Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > ---
> >
> > Changes in v1:
> > - Initial change
> >
> > doc/mgmt-api.txt | 2 ++
> > 1 file changed, 2 insertions(+)
> >
> > diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> > index 5355fedb0..f7cbf7ab2 100644
> > --- a/doc/mgmt-api.txt
> > +++ b/doc/mgmt-api.txt
> > @@ -200,6 +200,7 @@ and Command Complete events:
> > 0x12  RFKilled
> > 0x13  Already Paired
> > 0x14  Permission Denied
> > +0x15 Connection Not Established
> >
> > As a general rule all commands generate the events as specified below,
> > however invalid lengths or unknown commands will always generate a
> > @@ -1112,6 +1113,7 @@ Pair Device Command
> >                               Not Powered
> >                               Invalid Index
> >                               Already Paired
> > +                             Connection Not Established
>
> I really dislike the naming. And even more so, I request the motive here.
>
> So looking at our code, we have 3 cases where we use the previous status:
>
>         MGMT_STATUS_CONNECT_FAILED, /* Page Timeout */
>         MGMT_STATUS_CONNECT_FAILED, /* Connection Establishment Failed */
>         MGMT_STATUS_CONNECT_FAILED, /* MAC Connection Failed */
>
> And they do map to the 3 available transports, either via BR/EDR or LE or AMP. That means if you call Pair Device you already know well today when it fails to establish the link and can retry it.
>
> My question, what are you trying to fix here.
>
> Regards
>
> Marcel
>
