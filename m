Return-Path: <SRS0=kdk/=ZN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E284FC432C0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Nov 2019 23:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD4DB206D7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Nov 2019 23:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfKUXgw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Nov 2019 18:36:52 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:47786 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfKUXgw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Nov 2019 18:36:52 -0500
Received: from marcel-macbook.holtmann.net (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id 05FE9CED19;
        Fri, 22 Nov 2019 00:45:58 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH 1/2] Bluetooth: Move error check into the right if-clause
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191121144138.GA70662@vaespino-mobl1.amr.corp.intel.com>
Date:   Fri, 22 Nov 2019 00:36:50 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <1ACA0CFD-B0A2-41D9-9AB3-295DE534511B@holtmann.org>
References: <20191121075130.92705-1-marcel@holtmann.org>
 <20191121144138.GA70662@vaespino-mobl1.amr.corp.intel.com>
To:     Johan Hedberg <johan.hedberg@gmail.com>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Johan,

>> The if-clause for hdev->setup should also include the error handling
>> since that is where the error really comes from. The code currently
>> works correctly since ret=0 is assigned early on, but it is a lot
>> harder to read and understand.
>> 
>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>> ---
>> net/bluetooth/hci_core.c | 8 ++++----
>> 1 file changed, 4 insertions(+), 4 deletions(-)
> 
> Both patches in this set have been applied to bluetooth-next. Thanks.

so my cleanup patch was actually a mistake. In itself it was the right fix, but with the follow up patch, we actually want it that way to allow the invalid_bdaddr variable assignment to be done after hdev->setup.

I posted a v2 now that fixes that. We need to do a push --force to fix this up. A follow up patch would cause a hard to track history.

Regards

Marcel

