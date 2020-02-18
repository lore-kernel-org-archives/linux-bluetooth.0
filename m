Return-Path: <SRS0=m/C2=4G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7213C34026
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Feb 2020 14:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973AE20722
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Feb 2020 14:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgBROIO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Feb 2020 09:08:14 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:35648 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgBROIN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Feb 2020 09:08:13 -0500
Received: from marcel-macpro.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id B3D71CED28;
        Tue, 18 Feb 2020 15:17:36 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] Bluetooth: hci_h5: Move variable into local scope
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200218104533.GA46714@jhedberg-mac01.local>
Date:   Tue, 18 Feb 2020 15:08:11 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <AE5F5C23-73C1-4348-8711-EC65DBA40591@holtmann.org>
References: <20200218082858.42994-1-marcel@holtmann.org>
 <20200218104533.GA46714@jhedberg-mac01.local>
To:     Johan Hedberg <johan.hedberg@gmail.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Johan,

>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>> ---
>> drivers/bluetooth/hci_h5.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Applied to bluetooth-next. I went and added a short body to the commit
> message as well, since I think we generally require that for kernel
> commits.

great. Thanks.

I purposely decided to skip that since it was too obvious what this patch was doing.

Regards

Marcel

