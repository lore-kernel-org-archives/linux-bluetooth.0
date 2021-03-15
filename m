Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDB5C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Mar 2021 20:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 612DB64EB9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Mar 2021 20:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbhCOUHy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Mar 2021 16:07:54 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:33037 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbhCOUHh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Mar 2021 16:07:37 -0400
Received: from marcel-macbook.holtmann.net (p4fefc126.dip0.t-ipconnect.de [79.239.193.38])
        by mail.holtmann.org (Postfix) with ESMTPSA id 95B01CECE5;
        Mon, 15 Mar 2021 21:15:12 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v2] Bluetooth: Cancel le_scan_restart work when stopping
 discovery
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210315173059.74030-1-sonnysasaka@chromium.org>
Date:   Mon, 15 Mar 2021 21:07:35 +0100
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Transfer-Encoding: 7bit
Message-Id: <43E0F57D-321D-4963-B0D1-6A1C078BDC7B@holtmann.org>
References: <20210315173059.74030-1-sonnysasaka@chromium.org>
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

patch has been applied to bluetooth-next tree.

Regards

Marcel

