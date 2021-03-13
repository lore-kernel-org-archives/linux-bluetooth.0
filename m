Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042B9C433E0
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Mar 2021 11:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA07E64F1C
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Mar 2021 11:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhCMLAi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 13 Mar 2021 06:00:38 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:48167 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbhCMLAP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 13 Mar 2021 06:00:15 -0500
Received: from marcel-macbook.holtmann.net (p4fefc126.dip0.t-ipconnect.de [79.239.193.38])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3E61FCED1B;
        Sat, 13 Mar 2021 12:07:50 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH] Bluetooth: Cancel le_scan_restart work when stopping
 discovery
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210313004435.73331-1-sonnysasaka@chromium.org>
Date:   Sat, 13 Mar 2021 12:00:13 +0100
Cc:     linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <86C70A5F-A214-4CA7-A801-82405C17AC78@holtmann.org>
References: <20210313004435.73331-1-sonnysasaka@chromium.org>
To:     Sonny Sasaka <sonnysasaka@chromium.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

> Not cancelling it has caused a bug where passive background scanning is
> disabled out of the blue, preventing BLE keyboards/mice to reconnect.
> Here is how it happens:
> After hci_req_stop_discovery, there is still le_scan_restart_work
> scheduled. Invocation of le_scan_restart_work causes a harmful
> le_scan_disable_work to be scheduled. This le_scan_disable_work will
> eventually disable passive scanning when the timer fires.
> 
> Sample btmon trace:
> 
> < HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
>        Type: Passive (0x00)
>        Interval: 367.500 msec (0x024c)
>        Window: 37.500 msec (0x003c)
>        Own address type: Public (0x00)
>        Filter policy: Accept all advertisement (0x00)
>> HCI Event: Command Complete (0x0e) plen 4
>      LE Set Scan Parameters (0x08|0x000b) ncmd 1
>        Status: Success (0x00)
> < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
>        Scanning: Enabled (0x01)
>        Filter duplicates: Disabled (0x00)
>> HCI Event: Command Complete (0x0e) plen 4
>      LE Set Scan Enable (0x08|0x000c) ncmd 2
>        Status: Success (0x00)
> ...
> < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
>        Scanning: Disabled (0x00)
>        Filter duplicates: Disabled (0x00)
>> HCI Event: Command Complete (0x0e) plen 4
>      LE Set Scan Enable (0x08|0x000c) ncmd 2
>        Status: Success (0x00)
> // Background scanning is not working here onwards.
> 
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Signed-off-by: Sonny Sasaka <sonnysasaka@chromium.org>
> 
> ---
> net/bluetooth/hci_request.c | 1 +
> 1 file changed, 1 insertion(+)

I can apply this cleanly to bluetooth-next tree. Please double-check and rebase if it is still needed.

Regards

Marcel

