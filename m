Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0EEC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Dec 2021 21:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359209AbhLCVPz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Dec 2021 16:15:55 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:56527 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353164AbhLCVPy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Dec 2021 16:15:54 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7F75ACED1F;
        Fri,  3 Dec 2021 22:12:29 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH v2 00/15] Rework parsing of HCI events
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211201185506.1421186-1-luiz.dentz@gmail.com>
Date:   Fri, 3 Dec 2021 22:12:29 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <6A74F9E1-EB26-47A7-BAB8-360017C4C540@holtmann.org>
References: <20211201185506.1421186-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This reworks the parsing of HCI events using skb_pull_data to check
> event length, in addition to that it does introduce function tables to
> handle events, LE subevents, Command Complete and Command Status which
> simplify the callback by adding a common code that uses skb_pull_data
> when parsing such events.
> 
> v2: Fix declaration of hci_event_func.
> 
> Luiz Augusto von Dentz (15):
>  skbuff: introduce skb_pull_data
>  Bluetooth: HCI: Use skb_pull_data to parse BR/EDR events
>  Bluetooth: HCI: Use skb_pull_data to parse Command Complete event
>  Bluetooth: HCI: Use skb_pull_data to parse Number of Complete Packets
>    event
>  Bluetooth: HCI: Use skb_pull_data to parse Inquiry Result event
>  Bluetooth: HCI: Use skb_pull_data to parse Inquiry Result with RSSI
>    event
>  Bluetooth: HCI: Use skb_pull_data to parse Extended Inquiry Result
>    event
>  Bluetooth: HCI: Use skb_pull_data to parse LE Metaevents
>  Bluetooth: HCI: Use skb_pull_data to parse LE Advertising Report event
>  Bluetooth: HCI: Use skb_pull_data to parse LE Ext Advertising Report
>    event
>  Bluetooth: HCI: Use skb_pull_data to parse LE Direct Advertising
>    Report event
>  Bluetooth: hci_event: Use of a function table to handle HCI events
>  Bluetooth: hci_event: Use of a function table to handle LE subevents
>  Bluetooth: hci_event: Use of a function table to handle Command
>    Complete
>  Bluetooth: hci_event: Use of a function table to handle Command Status
> 
> include/linux/skbuff.h      |    2 +
> include/net/bluetooth/hci.h |   59 +-
> net/bluetooth/hci_event.c   | 3031 +++++++++++++++++++----------------
> net/bluetooth/msft.c        |    2 +-
> net/bluetooth/msft.h        |    2 +-
> net/core/skbuff.c           |   23 +
> 6 files changed, 1689 insertions(+), 1430 deletions(-)

all 15 patches have been applied to bluetooth-next tree.

Regards

Marcel

