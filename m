Return-Path: <SRS0=ORc3=EC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B32C4363A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Oct 2020 22:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 168D221D24
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Oct 2020 22:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZniS+UT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374778AbgJ0WOu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Oct 2020 18:14:50 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38952 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374818AbgJ0WOu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Oct 2020 18:14:50 -0400
Received: by mail-ot1-f65.google.com with SMTP id o14so2559275otj.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2020 15:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pA6R5CNLspVjWlAeipojKPWiDIO4liFXA9RLJBrCZ4s=;
        b=OZniS+UTZOmDFTofIyoT7oHZTNpCbk4l4fXhtvHJ7QU3wU3iZj7wOn3gswN3boVZ8b
         EpjAZMD2gSDGI5vSG+XQHsFoqXQysZ553z3hnE+2N4ob43SpjI8sMmCHCToKqe8d95mh
         DrEUjerdLUGxilbPSuxLnjGiPyulAwDNrie9TMjxTLEwTpPp4gikisyuA4FepzUiHt5k
         R1+vJ4K0lZeV7iW0gq5qlmJPpCUBYLwkcnuiAo2C5ytk6vLmTooyY6ham0akFYiV4oi5
         ahnEt9jdWFo3b62H9PIxSS4vFNpg1miNvYw+ZeTkGWpYBqrOfwkXhinAlR3S3IUBnrzr
         eOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pA6R5CNLspVjWlAeipojKPWiDIO4liFXA9RLJBrCZ4s=;
        b=B3bOklCSMan/u2oLJiy2jRYm+RW3z+xmz+pwJOJNhRV2SVLCLtt8WAMjJe5LD054mY
         wG73AMdMviZh2olOGMCSu3ICmQbZkc9UQ6LWAUh6xbjXLwCBtNYLLjH6V+wNMzFkQ/sl
         gfkQYS4SDLT0rmswtL14+4/qDVxmojsc7IO/CgcMj/3PXtMNxkqggZqu1Hbqmm68p3/u
         MiCoFXp3ph2kgMnYyfxHmwPjzxjlqnQeR8QOvfaSvBxHNesRfGgfhupaiKM8uEHNDDj2
         Y0dA8YkuZZ06VjYFN8JjfElNli+jOyzv5/FxYmqkauV3C9Y2WQe/jTUR3cLjrEUjVpCO
         T2Dw==
X-Gm-Message-State: AOAM531luh9c+c/v0bKw1J021Lwluu3VwTZah4+cJz7Th/u9TqDEkQQY
        RbornofWlNAs1uyGl71AyMRup4mfpVnEk/6DvR0=
X-Google-Smtp-Source: ABdhPJy2ik290NhmmqW6h0vs39G25UCdsCeOWzDOtIsIDIE+epylbEaxnCTXaRSmm2lT0oL3TELqCvNe3wB6xSL0EIk=
X-Received: by 2002:a05:6830:134c:: with SMTP id r12mr2934259otq.240.1603836829078;
 Tue, 27 Oct 2020 15:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <20201001230152.2422908-1-danielwinkler@google.com> <CAP2xMbs9ZeYrCCFOh5dh2Yj5PnrJ1hRyb03b_2aaPN6Q20MMqA@mail.gmail.com>
In-Reply-To: <CAP2xMbs9ZeYrCCFOh5dh2Yj5PnrJ1hRyb03b_2aaPN6Q20MMqA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 27 Oct 2020 15:13:38 -0700
Message-ID: <CABBYNZLig6m8gv5X-MmaaQCNongTmgTCd_Q9EDO=tTCC0kR2Lw@mail.gmail.com>
Subject: Re: [Bluez PATCH v4 00/10] Bluetooth: Add new MGMT interface for
 advertising add
To:     Daniel Winkler <danielwinkler@google.com>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        chromeos-bluetooth-upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Daniel, Marcel,


On Mon, Oct 26, 2020 at 5:09 PM Daniel Winkler <danielwinkler@google.com> wrote:
>
> Hello Maintainers,
>
> Pinging again to see if there is further feedback on this advertising
> patch series. Please let me know if there are any further comments
> that I can address.
>
> Best regards,
> Daniel
>
>
> On Thu, Oct 1, 2020 at 4:01 PM Daniel Winkler <danielwinkler@google.com> wrote:
> >
> > Hi Maintainers,
> >
> > This patch series defines the new two-call MGMT interface in userspace
> > for adding advertising instances. Bluez will detect if kernel supports
> > the new MGMT commands, and use them if so. Each new advertising instance
> > will be configured by a MGMT call to set advertising parameters,
> > followed by a MGMT call to set advertising data. The new data pipeline
> > is meant to be unnoticeable from the clients' perspective, with the
> > exception of new intervals and tx power support, and new exposed
> > advertising manager properties.
> >
> > All changes have been tested on hatch (extended advertising) and kukui
> > (no extended advertising) chromebooks with manual testing verifying
> > correctness of parameters/data in btmon traces, and our automated test
> > suite of 25 single- and multi-advertising usage scenarios.
> >
> > V2 of the series puts documentation at the front as requested.
> >
> > Thank you in advance for your review!
> > Daniel Winkler
> >
> >
> > Changes in v4:
> > - mgmt-api: moved optional params into 'flags' field
> > - mgmt-api: added info for new return parameters for max data size
> > - mgmt-api: Move Controller Capabilities MGMT doc into new patch
> > - mgmt-api: Tx Power range put into single capabilities entry
> > - Moved optional params into flags field
> > - Use returned max data length in adv data length check
> > - Move tx power range into single capability field
> >
> > Changes in v3:
> > - Removed Tx Power Selected MGMT event
> > - Changed Read Security Info cmd to  Read Controller Capabilities
> > - Added selected tx power to MGMT params response
> > - Removed Tx Power Selected MGMT event from monitor
> >
> > Changes in v2:
> > - Removed extra space in Add Extended Advertising Parameters API
> > - Uses btd_has_kernel_features to detect kernel command support
> > - Cleaned fail path in add_adv_params_callback
> >
> > Daniel Winkler (10):
> >   doc/advertising-api: update API with new interface
> >   doc/mgmt-api: Add new Advertising MGMT interfaces to mgmt-api
> >   doc/mgmt-api: Update controller capabilities MGMT command in mgmt-api
> >   advertising: Detect if extended advertising mgmt commands are
> >     supported
> >   advertising: Parse intervals and tx power from adv
> >   advertising: Use new mgmt interface for advertising add
> >   advertising: Query LE TX range at manager initialization
> >   advertising: Expose SupportedCapabilities for advertising
> >   client: Add SupportedCapabilities to bluetoothctl
> >   monitor: Add new MGMT adv commands and events to monitor
> >
> >  client/main.c           |   1 +
> >  doc/advertising-api.txt |  50 +++++
> >  doc/mgmt-api.txt        | 238 +++++++++++++++++++++++-
> >  lib/mgmt.h              |  46 ++++-
> >  monitor/packet.c        |  69 ++++++-
> >  src/adapter.c           |   4 +
> >  src/adapter.h           |   1 +
> >  src/advertising.c       | 403 ++++++++++++++++++++++++++++++++++++++--
> >  tools/btmgmt.c          |  12 +-
> >  9 files changed, 791 insertions(+), 33 deletions(-)
> >
> > --
> > 2.28.0.709.gb0816b6eb0-goog
> >

Other than the small comments these look good to me.

--
Luiz Augusto von Dentz
