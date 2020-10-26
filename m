Return-Path: <SRS0=rjyd=EB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E015C4363A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 22:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ACD1206ED
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 22:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lwTeOlsi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391707AbgJZWCh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Oct 2020 18:02:37 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:36382 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391677AbgJZWCh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Oct 2020 18:02:37 -0400
Received: by mail-ej1-f65.google.com with SMTP id w27so16087387ejb.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2020 15:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DOoO/HzOtcYbCVil2+BSIHbf6pggECx+aGN95jwi/Lk=;
        b=lwTeOlsirDCarKchgtWJf4tDWNwZsC5mVEaT6sXSNE02xyj87lxNmjUuxub2I9z7rT
         aM6sJCridIo7gaT8KZVyJoxYZwg60zGk736+E5IGAFDLT8nJnFYyic13CtpvmAOsJ9O5
         L/noJ7feEvB+0Cp5nnOhySDqL5o7xSb5Rtn+30r7q0TX5oPuo4GTxtcMCLlzf3EpJ938
         AWsLlrIDvnosCe6BaDwfEKjVe5lonFfL2VSeUXk8wWLWsBkRKilrPujkL1cYIxHy8P6R
         kHXxDc1cNB5kWRFVTBYKAq+SJFJE6W0opCrPwj5dYIqOdArAVHqRvYWEeVN39C7LHh/S
         qssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DOoO/HzOtcYbCVil2+BSIHbf6pggECx+aGN95jwi/Lk=;
        b=qY7B8HDk8k+vZi2UaF39AvtT1jSCkXf0TPcE9mLXTWKaDpxic/1aszcovWFUQtEzwf
         bpS0oo+gSkRQRPDsW3Ka6buB6cBDy9/CK/jFby7177V/od1tcwdZ2r/X74EBobZu5aP5
         IPCUS3xRdDtc0hHehZtsSFo5h1Tf5AcsiK2g9GopCXP+5w7kFUDrZBIB1RCHZrzPuNs6
         qSXiLXonHpaU0IJSwxvQDEToZGH87mydDRBMKNCP3WIkXe9mh6Ff5dtwY+IrwoNWAXIw
         I4/fshVjk1LWHxSIxnUkyvtVU4reINxRWH1KQihBD3zDIEsnIOMUOCMMlK7/AIvyd1mo
         A4dg==
X-Gm-Message-State: AOAM5326gZtKYI/Cpu6kWPU6Yv21xDGBhzB6XVt042K0UPElmpP5RdT1
        fWx2l5/Xto5kn+mREpOsX+hgBbM2BcRZ8GHYpTXNCQ==
X-Google-Smtp-Source: ABdhPJxIXWXoqaM5tZPE3ElFgr32LPUsYJK5tc86TSNzGgsTiGNv5cyhZq9hDdSdGxY6FLZOtWbILrqv0ltbkszARu0=
X-Received: by 2002:a17:906:4d03:: with SMTP id r3mr16584134eju.364.1603749754952;
 Mon, 26 Oct 2020 15:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <20201001230152.2422908-1-danielwinkler@google.com>
In-Reply-To: <20201001230152.2422908-1-danielwinkler@google.com>
From:   Daniel Winkler <danielwinkler@google.com>
Date:   Mon, 26 Oct 2020 15:02:23 -0700
Message-ID: <CAP2xMbs9ZeYrCCFOh5dh2Yj5PnrJ1hRyb03b_2aaPN6Q20MMqA@mail.gmail.com>
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

Hello Maintainers,

Pinging again to see if there is further feedback on this advertising
patch series. Please let me know if there are any further comments
that I can address.

Best regards,
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
