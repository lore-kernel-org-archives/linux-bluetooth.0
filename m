Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE5AC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Jan 2021 17:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A96164E06
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Jan 2021 17:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhA2Rv1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Jan 2021 12:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbhA2RuS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Jan 2021 12:50:18 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3739FC061573
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jan 2021 09:49:38 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id b5so5305297vsh.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jan 2021 09:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uQVkwbFdVxWBpP1ri9UZR53ShcAtPgjyzjoEk8DQhUE=;
        b=An+wSLBc38OJie7BFNh3zfzRikkXDFO5Cy731hUTE5LkzGJLXKbfimmP1r4KbPwBIy
         UFlRadEuYGwQmTVLYiwNsyBLPT03HanIFxjDwHJGfFYK88NfUi075+nLHu9MMKo2xu5u
         UW2SUgMyxPy6IsTqyHHE0QyeLu5R21mrV2mmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uQVkwbFdVxWBpP1ri9UZR53ShcAtPgjyzjoEk8DQhUE=;
        b=gElb4ySXmH2usGCWSyJ/oo/LQ0z/y8BwMIMeLAgU4JpFuCWh//e05HJTqfdNR5UzPx
         LhMJonYb/SxNWDHVUmYrU6sOiSNkQlE+Z8kZlyy4MoyYw49s6A1hIeEcBk6YURlX7V0J
         pBhjrwVIScHRDQP8qxi9RYWruss9lMBjMuX1/fGYuIYIER5p0rAaRCqFPMvY+lOOUT8K
         rnyDkYytAgnGfuoKWF80QagfGZqSZjMHEL56C19An9LbfhpclebWFeRKt9bIld3k4ZqZ
         G2cC99lGe3PxkVY4MP2Y+vQy88c6om5NhOEa/unszwd3eUZ7Kx7NzaZx7Aad7/kd32V2
         Oulw==
X-Gm-Message-State: AOAM530PSHM7Lz/NOtaNLpyGqpnAOgmRTk98rPEBotHCVRO8IDYPGEWR
        Fh1uU27+cDNtAFtkmfVuSAWfFFSRFgrGJ41NVVhK0Q==
X-Google-Smtp-Source: ABdhPJxiGHrzwrhmwDVQeFS84MHDr+PGURZGIWtx2hXGm7/ogTCKBmbboZFodTEWZrep+slK1PipdhWpEC2/tJIj2f0=
X-Received: by 2002:a67:eb06:: with SMTP id a6mr3736611vso.30.1611942577427;
 Fri, 29 Jan 2021 09:49:37 -0800 (PST)
MIME-Version: 1.0
References: <20210128120007.5676-1-hdegoede@redhat.com>
In-Reply-To: <20210128120007.5676-1-hdegoede@redhat.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Fri, 29 Jan 2021 09:49:25 -0800
Message-ID: <CANFp7mX15xLVLnuTCOijNL6uTwiud-q+2Y2o9=GnasD=Y5LMdg@mail.gmail.com>
Subject: Re: Recent(ish) bluetooth hci_suspend_notifier() changes
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Hans,

Thanks for the pointers. I'll try to spin up a patch to fix these
issues (or ask for some help on my team).

Thanks,
Abhishek

On Thu, Jan 28, 2021 at 4:00 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi All,
>
> While debugging an rtl8723bs bluetooth issue I noticed that last year
> the bluetooth core has grown a new hci_suspend_notifier() mechanism and
> I noticed a number of possible issues / improvements with that mechanism
> which I noticed:
>
> 1. HCI_OP_WRITE_SCAN_ENABLE gets send to the HCI in some places without
>    a hci_dev_test_flag(hdev, HCI_BREDR_ENABLED) check
>
> 2. HCI_OP_SET_EVENT_FLT gets end to the HCI in some places without
>    a hci_dev_test_flag(hdev, HCI_BREDR_ENABLED) check
>
> 3. hci_req_set_event_filter sends the following requests:
>    1 HCI_OP_SET_EVENT_FLT
>    2 HCI_OP_WRITE_SCAN_ENABLE (if the scan parameters have changed only)
>    3 HCI_OP_SET_EVENT_FLT (if their are relevant whitelist entries_
>    4 HCI_OP_WRITE_SCAN_ENABLE unconditionally
>
>    It seems to me that 2. is unnecessary since it will immediately be
>    followed by 4. and 4. misses the check to see if the scan parameters
>    need updating which 2 does (this check is done in __hci_req_update_scan()
>
>
> 4. There is another unconditional, possibly unnecessary  HCI_OP_WRITE_SCAN_ENABLE
>    in the if (next == BT_SUSPEND_DISCONNECT) {} block of hci_req_prepare_suspend()
>    Note if this is made conditional then the:
>     set_bit(SUSPEND_SCAN_DISABLE, hdev->suspend_tasks);
>    should also be made conditional since then req might not contain any requests
>    in which case suspend_req_complete() will not run.
>
> Regards,
>
> Hans
>
