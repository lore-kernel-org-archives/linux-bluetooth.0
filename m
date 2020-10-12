Return-Path: <SRS0=4Twx=DT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF2DC433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Oct 2020 15:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C940A2076E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Oct 2020 15:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hTxru8r8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbgJLPxQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Oct 2020 11:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgJLPxQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Oct 2020 11:53:16 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B6DC0613D0
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2020 08:53:15 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id x7so13743915eje.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2020 08:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=foq0loIEwLZ2CrP66dBlHX1TGqg6KV8aLxDJ/20YLJ0=;
        b=hTxru8r8ni9XVYkShYSpYEN2K8LddprGxqtQN31cuOtZ8upMpKPh7fUL0yLHwK12el
         ibs+RXaWe8jnQzRgrVBUIF6LrgyRKMCAeRSJI7Fl0nTQGEuIxsClTfB5sAR0Xg17ab3h
         G0KHRGDKhbF+gtHWJLJwAw3CaG1bD3DzsIm1sEP096Mw9kzdJRPFnsaCiIAYNCK8oqfR
         CWSx36j9T8LzF4ABEj94M/ueyhFrppvheKYLKpaGXXXY609rrKwG5Mqfht/nIAeJ0tXO
         ySSUUqkqrrrUHrC9irw/Cjo+D7AlFKiLHIR2eP3pkjssdCZyiSBSPx/Ze8zfWywY3tb4
         qrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=foq0loIEwLZ2CrP66dBlHX1TGqg6KV8aLxDJ/20YLJ0=;
        b=ed5f8F2MK9SUWWZFLk85UxjH08X9CmsM6/m2ldxgXtAHvbdK9IEGThSiCYrPZoVsqH
         JV2W7Fupa/qz0f4+rkxf//8SSKbpFm/f/scPdd4A95sKxU4B+ycgYhaf9/H1GxlFBUt9
         waXYyy55jA0/6v0BctBTFZ9GVowZpZWcKoZ88duaPAeqsp8EfJcQroOQHPdWXwUcjyK9
         B0yklhYQ4U/Ptp+19qAlzqA8DpcJiRVjOA4+DsR9++i9nYKUwHfTNrBKY5KuxJyzWNAI
         mY0CzUdUVysruHtNAr/SDROPmgHpWHLhTGKb8niaj+amSfUHTHuoI4CbKi8aGOANAbdn
         0dyQ==
X-Gm-Message-State: AOAM532s8WCppR1qzSGGi8EmcHpDDddK4OOtiWGsUtBP4JleFaPNZMXJ
        4935oHuLPNlzCXMZYHHtlXykEfjwMpgphxaW9XEkKA==
X-Google-Smtp-Source: ABdhPJz1RYXOqxLt5C3YdV+WI1AJYPNMkco3QDrBk5DfCsTJcrLFDLWTHDs+4qK90L4LYXiD26z5nCyIDpbnbjKbrso=
X-Received: by 2002:a17:906:c407:: with SMTP id u7mr17956987ejz.206.1602517994225;
 Mon, 12 Oct 2020 08:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <20201001230152.2422908-1-danielwinkler@google.com>
In-Reply-To: <20201001230152.2422908-1-danielwinkler@google.com>
From:   Daniel Winkler <danielwinkler@google.com>
Date:   Mon, 12 Oct 2020 08:53:02 -0700
Message-ID: <CAP2xMbt81z2tM49+NbJoix-mAzM_JAFu0gQJcT7AA02NnXirqw@mail.gmail.com>
Subject: Re: [Bluez PATCH v4 00/10] Bluetooth: Add new MGMT interface for
 advertising add
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        chromeos-bluetooth-upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Maintainers,

Just a friendly ping to take a look at this series at your
convenience. The latest series should address the issues from the
previous ones. Thanks in advance!

Best,
Daniel

On Thu, Oct 1, 2020 at 4:01 PM Daniel Winkler <danielwinkler@google.com> wrote:
>
> Hi Maintainers,
>
> This patch series defines the new two-call MGMT interface in userspace
> for adding advertising instances. Bluez will detect if kernel supports
> the new MGMT commands, and use them if so. Each new advertising instance
> will be configured by a MGMT call to set advertising parameters,
> followed by a MGMT call to set advertising data. The new data pipeline
> is meant to be unnoticeable from the clients' perspective, with the
> exception of new intervals and tx power support, and new exposed
> advertising manager properties.
>
> All changes have been tested on hatch (extended advertising) and kukui
> (no extended advertising) chromebooks with manual testing verifying
> correctness of parameters/data in btmon traces, and our automated test
> suite of 25 single- and multi-advertising usage scenarios.
>
> V2 of the series puts documentation at the front as requested.
>
> Thank you in advance for your review!
> Daniel Winkler
>
>
> Changes in v4:
> - mgmt-api: moved optional params into 'flags' field
> - mgmt-api: added info for new return parameters for max data size
> - mgmt-api: Move Controller Capabilities MGMT doc into new patch
> - mgmt-api: Tx Power range put into single capabilities entry
> - Moved optional params into flags field
> - Use returned max data length in adv data length check
> - Move tx power range into single capability field
>
> Changes in v3:
> - Removed Tx Power Selected MGMT event
> - Changed Read Security Info cmd to  Read Controller Capabilities
> - Added selected tx power to MGMT params response
> - Removed Tx Power Selected MGMT event from monitor
>
> Changes in v2:
> - Removed extra space in Add Extended Advertising Parameters API
> - Uses btd_has_kernel_features to detect kernel command support
> - Cleaned fail path in add_adv_params_callback
>
> Daniel Winkler (10):
>   doc/advertising-api: update API with new interface
>   doc/mgmt-api: Add new Advertising MGMT interfaces to mgmt-api
>   doc/mgmt-api: Update controller capabilities MGMT command in mgmt-api
>   advertising: Detect if extended advertising mgmt commands are
>     supported
>   advertising: Parse intervals and tx power from adv
>   advertising: Use new mgmt interface for advertising add
>   advertising: Query LE TX range at manager initialization
>   advertising: Expose SupportedCapabilities for advertising
>   client: Add SupportedCapabilities to bluetoothctl
>   monitor: Add new MGMT adv commands and events to monitor
>
>  client/main.c           |   1 +
>  doc/advertising-api.txt |  50 +++++
>  doc/mgmt-api.txt        | 238 +++++++++++++++++++++++-
>  lib/mgmt.h              |  46 ++++-
>  monitor/packet.c        |  69 ++++++-
>  src/adapter.c           |   4 +
>  src/adapter.h           |   1 +
>  src/advertising.c       | 403 ++++++++++++++++++++++++++++++++++++++--
>  tools/btmgmt.c          |  12 +-
>  9 files changed, 791 insertions(+), 33 deletions(-)
>
> --
> 2.28.0.709.gb0816b6eb0-goog
>
