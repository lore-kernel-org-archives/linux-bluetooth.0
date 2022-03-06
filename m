Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85677C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Mar 2022 08:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbiCFIuZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Mar 2022 03:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiCFIuZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Mar 2022 03:50:25 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32DA458E4A
        for <linux-bluetooth@vger.kernel.org>; Sun,  6 Mar 2022 00:49:33 -0800 (PST)
Received: from smtpclient.apple (p5b3d2910.dip0.t-ipconnect.de [91.61.41.16])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3C986CECF9;
        Sun,  6 Mar 2022 09:49:32 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [BlueZ PATCH v4 1/8] doc: Introduce the quality report command
 and event
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHFy41_D3bBzU6Efd3q8Fuh2Ftmq5CrJ6zOj4hCH=x_9M5O89Q@mail.gmail.com>
Date:   Sun, 6 Mar 2022 09:49:31 +0100
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        pali@kernel.org, chromeos-bluetooth-upstreaming@chromium.org
Content-Transfer-Encoding: 7bit
Message-Id: <44687930-3737-46E5-991C-F6C1910C48F7@holtmann.org>
References: <20220215133636.2827039-1-josephsih@chromium.org>
 <666C5B97-A51C-48B9-AC91-0655C0D158B5@holtmann.org>
 <CAHFy41_KiZygzfj91+8tJQWqESWKCXuatQFuKovh+DnMcPyY8Q@mail.gmail.com>
 <8AD1FDEA-CB22-4DEE-9ACE-CAAD3459DEF0@holtmann.org>
 <CAHFy41_D3bBzU6Efd3q8Fuh2Ftmq5CrJ6zOj4hCH=x_9M5O89Q@mail.gmail.com>
To:     Joseph Hwang <josephsih@google.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Joseph,

>  What I plan to do about adapter power cycle for quality report:
> 
>  Step 1: At power off, do not clear the flag of HCI_QUALITY_REPORT in
> hci_dev_clear_volatile_flags(). Will use HCI_QUALITY_REPORT to track
> if the quality report is enabled before power off. Will also disable
> the quality report explicitly in hci_sync.c:hci_dev_open_sync() just
> before aosp_do_close()  so that different vendor chips will have
> quality off at power off.
> 
>  Step 2: In hci_sync.c:hci_dev_open_sync(), re-enable quality report
> explicitly just after aosp_do_open() if HCI_QUALITY_REPORT is true so
> that all vendor chips have quality back on at power on.
> 
>  If the quality report is not enabled before power cycle,
> HCI_QUALITY_REPORT will always stay false. Nothing mentioned above
> will be executed in this case.
> 
>  One thing is worth noting here. The HCI_QUALITY_REPORT represents
> the host setting instead of the controller state. During power off,
> the HCI_QUALITY_REPORT host setting remains true while the controller
> state about quality report is turned off. This behavior is similar to
> "wide-band-speech" whose setting remains true during power off.
> 
>  Does this sound good to you? If yes, I will append a new patch to
> the next Series-version. Thanks!

yes, that sounds good. Please provide the mgmt addition as first patches.

Regards

Marcel

