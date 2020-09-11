Return-Path: <SRS0=2FZ9=CU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE2AC433E2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Sep 2020 06:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03266221ED
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Sep 2020 06:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbgIKGvR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Sep 2020 02:51:17 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:46408 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbgIKGvN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Sep 2020 02:51:13 -0400
Received: from marcel-macbook.fritz.box (p4ff9f430.dip0.t-ipconnect.de [79.249.244.48])
        by mail.holtmann.org (Postfix) with ESMTPSA id 00165CED1A;
        Fri, 11 Sep 2020 08:58:07 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH v1 2/4] Bluetooth: hci_intel: drop strange le16_to_cpu()
 against u8 values
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200903184850.53055-2-andriy.shevchenko@linux.intel.com>
Date:   Fri, 11 Sep 2020 08:51:12 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <CD9DE84B-CA69-4420-8D6D-6C51ADEBB84E@holtmann.org>
References: <20200903184850.53055-1-andriy.shevchenko@linux.intel.com>
 <20200903184850.53055-2-andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Andy,

> Sparse rightfully complains:
> 
>  hci_intel.c:696:26: warning: cast to restricted __le16
>  hci_intel.c:701:26: warning: cast to restricted __le16
>  hci_intel.c:702:26: warning: cast to restricted __le16
>  hci_intel.c:703:26: warning: cast to restricted __le16
>  hci_intel.c:725:26: warning: cast to restricted __le16
>  hci_intel.c:730:26: warning: cast to restricted __le16
>  hci_intel.c:731:26: warning: cast to restricted __le16
>  hci_intel.c:732:26: warning: cast to restricted __le16
> 
> because we access non-restricted types with le16_to_cpu().
> More confusion is added by using above against u8. On big-endian
> architecture we will get all zeroes. I bet it's not what should be
> in such case.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> drivers/bluetooth/hci_intel.c | 14 ++++----------
> 1 file changed, 4 insertions(+), 10 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

