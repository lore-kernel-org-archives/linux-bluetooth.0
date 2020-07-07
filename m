Return-Path: <SRS0=I8IU=AS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B9BC433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 16:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C02B82073E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 16:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgGGQJp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jul 2020 12:09:45 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:36672 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGGQJp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jul 2020 12:09:45 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 71B9ECECEE;
        Tue,  7 Jul 2020 18:19:40 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [RFC] Bluetooth: btusb: Add support for notifying the polling
 interval
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200702220558.3467870-1-luiz.dentz@gmail.com>
Date:   Tue, 7 Jul 2020 18:09:43 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <FEEBE4D6-F6C6-470D-95E6-FA20EAA1F862@holtmann.org>
References: <20200702220558.3467870-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This enables btusb to inform the polling interval used for receiving
> packets, the interval is then used wih rx_work which has been changed
> to be a delayed work.
> 
> The interval is then used as a time window where frames received from
> different endpoints are considered to be arrived at same time.
> 
> In order to resolve potential conflicts between endpoints a dedicated
> queue for events was introduced and it is now processed before the ACL
> packets.
> 
> It worth noting though that priorizing events over ACL data may result
> in inverting the order of the packets over the air, for instance there
> may be packets received before a disconnect event that will be
> discarded and unencrypted packets received before encryption change
> which would considered encrypted, because of these potential inversions
> the support for polling interval is not enabled by default so platforms
> have the following means to enable it:

we can not touch the core that impacts all transport layers even if they are not broken. So adding the second queue is not something that I think is a good idea. And again, we are just papering over a hole.

However if you want to queue within btusb driver before sending it to the core, then maybe.

Regards

Marcel

