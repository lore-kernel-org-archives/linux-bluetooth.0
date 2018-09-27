Return-Path: <SRS0=a08L=MJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C39C43382
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Sep 2018 10:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF2F2159D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Sep 2018 10:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF2F2159D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbeI0RKd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:10:33 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:55379 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbeI0RKc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Sep 2018 13:10:32 -0400
Received: from marcel-macbook.fritz.box (p4FEFC9BB.dip0.t-ipconnect.de [79.239.201.187])
        by mail.holtmann.org (Postfix) with ESMTPSA id 37108CF16A;
        Thu, 27 Sep 2018 13:00:07 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH v2 0/3] Bluetooth: L2CAP: Improve credits logic
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180904103922.25504-1-luiz.dentz@gmail.com>
Date:   Thu, 27 Sep 2018 12:52:50 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <136C6167-7F57-4CF5-AEFD-DC54BDBFDFA3@holtmann.org>
References: <20180904103922.25504-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> These changes replace the existing threshold logic with a limpler logic
> that gives back credits after receiving an SDU. It also removes the
> debugfs entries to configure the MPS and credits with auto selected one
> derived from the MTU and MPS.
> 
> v2: Account from the SDU length when adjusting the MPS.
> 
> Luiz Augusto von Dentz (3):
>  Bluetooth: L2CAP: Derive MPS from connection MTU
>  Bluetooth: L2CAP: Derive rx credits from MTU and MPS
>  Bluetooth: L2CAP: Detect if remote is not able to use the whole MPS
> 
> include/net/bluetooth/l2cap.h |  3 --
> net/bluetooth/l2cap_core.c    | 66 +++++++++++++++++++++++------------
> 2 files changed, 44 insertions(+), 25 deletions(-)

all 3 patches have been applied to bluetooth-next tree.

Regards

Marcel

