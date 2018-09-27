Return-Path: <SRS0=a08L=MJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C99C43382
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Sep 2018 10:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E6E2159D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Sep 2018 10:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E6E2159D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeI0Qqj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Sep 2018 12:46:39 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:53081 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbeI0Qqj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Sep 2018 12:46:39 -0400
Received: from marcel-macbook.fritz.box (p4FEFC9BB.dip0.t-ipconnect.de [79.239.201.187])
        by mail.holtmann.org (Postfix) with ESMTPSA id CE2F0CF170;
        Thu, 27 Sep 2018 12:36:18 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH] Bluetooth: btusb: Add quirk for BTUSB_INTEL_NEW
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180925170457.33979-1-teravest@google.com>
Date:   Thu, 27 Sep 2018 12:29:02 +0200
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        jpawlowski@google.com, Johan Hedberg <johan.hedberg@intel.com>
Content-Transfer-Encoding: 7bit
Message-Id: <8674BF84-BE2E-466F-8A9C-2D9DC3F86F67@holtmann.org>
References: <20180925170457.33979-1-teravest@google.com>
To:     Justin TerAvest <teravest@google.com>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Justin,

> Intel "new" controllers can do both LE scan and BR/EDR inquiry at once.
> 
> Signed-off-by: Justin TerAvest <teravest@google.com>
> ---
> drivers/bluetooth/btusb.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

