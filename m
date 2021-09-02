Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE55C432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 07:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 467CB60FDA
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 07:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242439AbhIBHTW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Sep 2021 03:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbhIBHTV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Sep 2021 03:19:21 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE46AC061575
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Sep 2021 00:18:23 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id m28so2194460lfj.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Sep 2021 00:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h0lO15BsZhqJ5zr4ij6dUqV7gA4LRjgZyNDSiyYM/a8=;
        b=MmoqMgO3qoZ3lkORg7FzxXVXSvm73MqxJEICPOm8lwZpE/t0oR0bn0azZ3oAzkYJQh
         KaOnL1x1uPlkUHcCIvOlRerqFHFsMErkbysprZiCvPmIcVxlgkiglpitIej9xrZ4OQXA
         LjCUDDGYmxVygEdq0JaH+B0kq9yiN6VrcU8/X2Akna6ZwbcxoY/fZVjlzEnF5fP2IBHw
         /WbmCvi/r+RSk14VR3W8a0LYnJO5IFPfoRa0QI/SK26qHa30E9ess771Boqapze/BqWE
         5z6rmWxrlk72ACJHcg4n/q1HKR411ZTSDoacpNpurnyXIbO9D67HZS+KxxoogssI8d/k
         XC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h0lO15BsZhqJ5zr4ij6dUqV7gA4LRjgZyNDSiyYM/a8=;
        b=NqRvCpGbfjkjXg9YCUgM0+MG3MFJAJLJUz3ZAwMOy8WaOvPCzh58vbfnqUDM3MJ3qx
         tnDoM77JbXPdsRMXWz3QgpjePf3MeNFtK9DTfmLoCGbaW7ks9md5HX9LC3gH77OMIoYB
         zP4lphpzt9aFMZ1CT2NGds4FIFAyxCGjio3WJMmQqkQ8bp0n/5o8Z0EN2Nci1s+rqpIn
         J3wybrfqFUW4QGtSf3ePyFDiQCo5mi8C9yB+4CfSsu/s2uq6U8y9PcnlS9uyUd0gV4cN
         8d1mkaFQDcP3DI3FgHBGrlmo1SXcl4xSnqzXKnkGFXc9EK9kR1DC39PkphERhSL5JPWM
         ewGQ==
X-Gm-Message-State: AOAM532rzQpaQAqUsU4PAAavXKB7ZsbX5yVKjry0J9CDoFkbCGuicDhB
        LWebJoSE/HZ3bSYQ2okChkNfaHI1d4s1oG7/MRi2sA==
X-Google-Smtp-Source: ABdhPJxAa1gZKZ7GWG89kgr2+FX1vFncNNqtfsQ4EzZaNtsNEg1+0RdMWeVH2f5zyjAiyzFQ8ZXyg1gMEJ1Zh/C/STc=
X-Received: by 2002:a05:6512:15e:: with SMTP id m30mr1576651lfo.82.1630567101814;
 Thu, 02 Sep 2021 00:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210902040711.665952-1-apusaka@google.com> <20210902120509.Bluez.v2.1.I3be2e373e96293524fa38328ebac177eddc71938@changeid>
 <3D29644F-F6C1-463C-83E6-23CB3FD00057@holtmann.org>
In-Reply-To: <3D29644F-F6C1-463C-83E6-23CB3FD00057@holtmann.org>
From:   Archie Pusaka <apusaka@google.com>
Date:   Thu, 2 Sep 2021 15:18:10 +0800
Message-ID: <CAJQfnxEHbXzfm_2+zvZyKwwGOdyLYSKbXiMuZd3qo6RK9a494w@mail.gmail.com>
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

Could you give me pointers on this libbluetooth API?
I can't seem to figure out which ones of these replacements belong to
libbluetooth.

Thanks,
Archie

On Thu, 2 Sept 2021 at 15:13, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Archie,
>
> > BT core spec 5.3 promotes the usage of inclusive languages.
> > This CL replaces some terms with the more appropriate counterparts,
> > such as "central", "peripheral", and "accept list".
> > ---
> >
> > Changes in v2:
> > * Merging several patches from the same directory into one
> >
> > android/bluetooth.c    |  4 ++--
> > btio/btio.c            | 20 ++++++++--------
> > lib/hci.c              | 52 +++++++++++++++++++++---------------------
> > lib/hci.h              | 44 +++++++++++++++++------------------
> > lib/hci_lib.h          |  8 +++----
> > lib/l2cap.h            |  2 +-
> > lib/mgmt.h             |  2 +-
> > lib/rfcomm.h           |  2 +-
> > monitor/control.c      |  4 ++--
> > profiles/health/mcap.c |  2 +-
> > src/adapter.c          |  4 ++--
> > src/sdpd-server.c      |  2 +-
> > tools/hcitool.c        |  8 +++----
> > tools/l2test.c         |  4 ++--
> > tools/oobtest.c        |  4 ++--
> > tools/parser/hci.c     | 14 ++++++------
> > tools/rctest.c         |  4 ++--
> > tools/rfcomm.c         |  2 +-
> > 18 files changed, 91 insertions(+), 91 deletions(-)
>
> so I am not sure if my comments were unclear last time, but touching libbluetooth is no go until we have deprecated it. So as long as it can be still installed by distributions (and it is), you can not break API.
>
> Regards
>
> Marcel
>
