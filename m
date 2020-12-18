Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A129C4361B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Dec 2020 21:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CB3823B7B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Dec 2020 21:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgLRVsJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Dec 2020 16:48:09 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:46609 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgLRVsJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Dec 2020 16:48:09 -0500
Received: from marcel-macbook.holtmann.net (p4fefcdf9.dip0.t-ipconnect.de [79.239.205.249])
        by mail.holtmann.org (Postfix) with ESMTPSA id 297FCCED31;
        Fri, 18 Dec 2020 22:54:44 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH v2] Bluetooth: Cancel Inquiry before Create Connection
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201209213514.99326-1-sonnysasaka@chromium.org>
Date:   Fri, 18 Dec 2020 22:47:26 +0100
Cc:     linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Transfer-Encoding: 7bit
Message-Id: <C2BEF64A-EA11-422A-8F80-AADF160EC586@holtmann.org>
References: <20201209213514.99326-1-sonnysasaka@chromium.org>
To:     Sonny Sasaka <sonnysasaka@chromium.org>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

> Many controllers do not allow HCI Create Connection while it is doing
> Inquiry. This patch adds Inquiry Cancel before Create Connection in this
> case to allow the controller to do Create Connection. User space will be
> aware of this Inquiry cancellation and they may issue another discovery
> request afterwards.
> 
> Sample Command Disallowed response of HCI Create Connection:
> < HCI Command: Inquiry (0x01|0x0001) plen 5
>        Access code: 0x9e8b33 (General Inquiry)
>        Length: 10.24s (0x08)
>        Num responses: 0
>> HCI Event: Command Status (0x0f) plen 4
>      Inquiry (0x01|0x0001) ncmd 2
>        Status: Success (0x00)
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>        Address: XX:XX:XX:XX:XX:XX
>        Packet type: 0xcc18
>        Page scan repetition mode: R2 (0x02)
>        Page scan mode: Mandatory (0x00)
>        Clock offset: 0x0000
>        Role switch: Allow slave (0x01)
>> HCI Event: Command Status (0x0f) plen 4
>      Create Connection (0x01|0x0005) ncmd 1
>        Status: Success (0x00)
>> HCI Event: Connect Complete (0x03) plen 11
>        Status: Command Disallowed (0x0c)
>        Handle: 65535
>        Address: XX:XX:XX:XX:XX:XX
>        Link type: ACL (0x01)
>        Encryption: Disabled (0x00)
> 
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Reviewed-by: Alain Michaud <alainm@chromium.org>
> Signed-off-by: Sonny Sasaka <sonnysasaka@chromium.org>
> 
> ---
> net/bluetooth/hci_conn.c | 17 +++++++++++++++++
> 1 file changed, 17 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

