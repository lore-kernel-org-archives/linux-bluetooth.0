Return-Path: <SRS0=Ti+w=XA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C047C43331
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Sep 2019 15:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011A8206B8
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Sep 2019 15:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388335AbfIEPeF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Sep 2019 11:34:05 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:43048 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733031AbfIEPeE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Sep 2019 11:34:04 -0400
Received: from marcel-macbook.fritz.box (p4FEFC197.dip0.t-ipconnect.de [79.239.193.151])
        by mail.holtmann.org (Postfix) with ESMTPSA id 53EF2CECD1;
        Thu,  5 Sep 2019 17:42:51 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/1] bluetooth: update default BLE connection params
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <705dbccb-58a9-7adc-8430-c16b395c27e5@gmail.com>
Date:   Thu, 5 Sep 2019 17:34:03 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Jamie Mccrae <Jamie.Mccrae@lairdconnect.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <4BFC2A23-1D8A-4021-BB74-418A13676E65@holtmann.org>
References: <705dbccb-58a9-7adc-8430-c16b395c27e5@gmail.com>
To:     Carey Sonsino <csonsino@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Carey,

> Update the default BLE connection parameters.
> 
> Commit c49a8682fc5d298d44e8d911f4fa14690ea9485e introduced a bounds
> check on connection interval update requests, but the default min/max
> values were left at 24-40 (30-50ms) which caused problems for devices
> that want to negotiate connection intervals outside of those bounds.
> 
> Setting the default min/max connection interval to the full allowable
> range in the bluetooth specification restores the default Linux behavior
> of allowing remote devices to negotiate their desired connection
> interval, while still permitting the system administrator to later
> narrow the range.
> 
> The default supervision timeout must also be modified to accommodate
> the max connection interval increase.  The new default value meets the
> requirements of the bluetooth specification and the conditions in
> the hci_check_conn_params function.
> 
> The downside to modifying the default supervision timeout is that
> it will take longer (about 10 seconds) to detect a link loss condition.
> 
> Fixes c49a8682fc5d: (validate BLE connection interval updates)

I decided to revert c49a8682fc5d and we need an overall better solution for handling connection parameters.

Regards

Marcel

