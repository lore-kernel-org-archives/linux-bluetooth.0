Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B203EC2B9F8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 May 2021 14:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 877D461401
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 May 2021 14:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbhEYOfv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 May 2021 10:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbhEYOfu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 May 2021 10:35:50 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1916C06138A
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 07:34:20 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id t17so21708300ljd.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 07:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k1BOfirE/CqN20z8rJwhxZ4UusN2SWlS5nrmjMURapc=;
        b=Crp447sIVoC9SF7/yh+4ueyMzvzvJZ4qBC2jgEp4MptNjdYJGXZjse1WSXcN2an3r9
         5sDgufXyvOlGlttuNoriQ40PwlTNjH6A0ZEVcQpz7/F76QnXwEKEfaTCg7IABsAFQANP
         AZ9B8/DMgsPY76ajmOtb3GfXucTP4jR3VYhZjhVt7n7mgBsdaOBwLzgtzp+rxKmb79lD
         wy0l9H4bufA66HgOWk0nhgASQJT1PGXBVjFq7TjVZLxwdyh1nZRPhcipDC1Rr8hz+1hU
         pq39L5rDhepRTz00saAUIN05bDYejMNIeeXSv7bY6CUleB+jExVkCUE7lzOJTI+RvZ/Z
         c1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k1BOfirE/CqN20z8rJwhxZ4UusN2SWlS5nrmjMURapc=;
        b=Eqzt0za76dqsm5/193EGrIVhkuxIymo7Ix1TwR46nRDMfxzeHoCZzFiemDWlUkJn10
         BFMgIv39UquUZjIYAY6mUioCpiR4Gd+zJKE4hYDwrk7AUyIo0QILRDb5TV6890abx0UO
         nG+c9BLayYOeHEDkukForEYYewfpa8ibJR0syPwNWYfig+yiiwYiwFquhr2DtlC4ykNV
         4FAANgofqqb+LNGmw3QRjwEBembDd4dTBEpTLtyZE30Ibf7tyCY0+b0nlcL6e/nhaC1w
         WPfritjkDYemFXhsdxKJwhva+nKQQ5r1xE9Z6WN4VEqzPWVqtvin9UhQmYCUtzuTvAXT
         smqg==
X-Gm-Message-State: AOAM532Jw/2zoKxDb+x85SXRhtrK+p1NXKVHkRITmOk81vAjG9Kgswu3
        kldT6ftq+tX+32IoYkAmdx7XpLWMTifYeszUi8kVr3DpMCxALukc
X-Google-Smtp-Source: ABdhPJyGFGvKSoEfd3aqsTmscuhsefCSjpqlZhVFsaJBZMfgdfLCHQIjf9UhB3iCEqZSllnJudXNvYu+15np3Zbzt3g=
X-Received: by 2002:a05:651c:a06:: with SMTP id k6mr21014106ljq.347.1621953258657;
 Tue, 25 May 2021 07:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210525102941.3958649-1-apusaka@google.com> <CAO1O6sehBfi+Tn6EEC8XgoORrD=JF9zO9tDCbJBgL=JpaBdL2w@mail.gmail.com>
In-Reply-To: <CAO1O6sehBfi+Tn6EEC8XgoORrD=JF9zO9tDCbJBgL=JpaBdL2w@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Tue, 25 May 2021 22:34:07 +0800
Message-ID: <CAJQfnxG1Q=6n4H_kTbFA-=b0Rbs6v7WE8mKKonqvw-nXhLnLMA@mail.gmail.com>
Subject: Re: [PATCH 00/12] Bluetooth: use inclusive language
To:     Emil Lenngren <emil.lenngren@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Miao-chen Chou <mcchou@chromium.org>,
        =?UTF-8?B?T2xlIEJqw7hybiBNaWR0YsO4?= <omidtbo@cisco.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Emil,

On Tue, 25 May 2021 at 20:19, Emil Lenngren <emil.lenngren@gmail.com> wrote:
>
> Hi Archie,
>
> Den tis 25 maj 2021 kl 12:46 skrev Archie Pusaka <apusaka@google.com>:
> >
> > From: Archie Pusaka <apusaka@chromium.org>
> >
> > Hi linux-bluetooth maintainers,
> >
> > This series contains inclusive language patches, to promote usage of
> > central, peripheral, reject list, and accept list. I tried to divide
> > the change to several smaller patches to ease downstreamers to make
> > gradual change.
> >
> > There are still three occurences in debugfs (patch 09/12) in which the
> > original less inclusive terms is still left as-is since it is a
> > file name, and I afraid replacing them will cause instability to
> > other systems depending on that file name.
> >
> >
> > Archie Pusaka (12):
> >   Bluetooth: use inclusive language in HCI role
> >   Bluetooth: use inclusive language in hci_core.h
> >   Bluetooth: use inclusive language to describe CPB
> >   Bluetooth: use inclusive language in HCI LE features
> >   Bluetooth: use inclusive language in L2CAP
> >   Bluetooth: use inclusive language in RFCOMM
> >   Bluetooth: use inclusive language when tracking connections
> >   Bluetooth: use inclusive language in SMP
> >   Bluetooth: use inclusive language in debugfs
> >   Bluetooth: use inclusive language when filtering devices out
> >   Bluetooth: use inclusive language when filtering devices in
> >   Bluetooth: use inclusive language in comments
> >
> >  include/net/bluetooth/hci.h      |  98 +++++++++++++-------------
> >  include/net/bluetooth/hci_core.h |  22 +++---
> >  include/net/bluetooth/l2cap.h    |   2 +-
> >  include/net/bluetooth/mgmt.h     |   2 +-
> >  include/net/bluetooth/rfcomm.h   |   2 +-
> >  net/bluetooth/amp.c              |   2 +-
> >  net/bluetooth/hci_conn.c         |  32 ++++-----
> >  net/bluetooth/hci_core.c         |  46 ++++++-------
> >  net/bluetooth/hci_debugfs.c      |  20 +++---
> >  net/bluetooth/hci_event.c        | 114 +++++++++++++++----------------
> >  net/bluetooth/hci_request.c      | 106 ++++++++++++++--------------
> >  net/bluetooth/hci_sock.c         |  12 ++--
> >  net/bluetooth/hidp/core.c        |   2 +-
> >  net/bluetooth/l2cap_core.c       |  16 ++---
> >  net/bluetooth/l2cap_sock.c       |   4 +-
> >  net/bluetooth/mgmt.c             |  36 +++++-----
> >  net/bluetooth/rfcomm/sock.c      |   4 +-
> >  net/bluetooth/smp.c              |  86 +++++++++++------------
> >  net/bluetooth/smp.h              |   6 +-
> >  19 files changed, 309 insertions(+), 303 deletions(-)
> >
> > --
> > 2.31.1.818.g46aad6cb9e-goog
> >
>
> Interesting move and good initiative!
>
> In my opinion however, shouldn't we wait until Bluetooth SIG changes
> the naming in the specification itself first (or rather push them to
> make the changes in the first place)? If they are about to change
> names, it would be good to make sure we end up with the same word
> choices so that we don't call one thing "le peripheral initiated
> feature exchange" while the standard calls it "le follower initiated
> feature exchange" or similar. Using different terminology than what's
> specified by the standard could easily end up in confusion I guess,
> and even more if different stacks invented their own alternative
> terminology.

So far the Bluetooth SIG has only published an "Appropriate Language
Mapping Table" (https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf).
It doesn't look like it's finalized, but it's enough to get started.
Hopefully someone in the community can help to push the changes to the
spec?

> In any case, I'm for example not sure if central/peripheral are the
> best words to use, since those are tied to a specific higher level
> profile (Generic Access Profile) and those words are not mentioned at
> all in the spec outside that context. The SMP chapter for example uses
> the terminology "initiator" and "responder", so maybe those are better
> word choices, at least in SMP.

Thanks, you are correct about that. I didn't read the spec thoroughly
and just did a simple replacement. I shall incorporate your suggestion
if this set of patches is greenlighted.

Cheers,
Archie
