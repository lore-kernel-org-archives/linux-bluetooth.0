Return-Path: <SRS0=a08L=MJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97FFC43382
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Sep 2018 10:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB322159D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Sep 2018 10:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB322159D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbeI0RME (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:12:04 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:49665 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbeI0RME (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Sep 2018 13:12:04 -0400
Received: from marcel-macbook.fritz.box (p4FEFC9BB.dip0.t-ipconnect.de [79.239.201.187])
        by mail.holtmann.org (Postfix) with ESMTPSA id 0F782CF16A;
        Thu, 27 Sep 2018 13:01:38 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH RESEND] Bluetooth: btrsi: fix bt tx timeout issue
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1535954266-6339-1-git-send-email-siva8118@gmail.com>
Date:   Thu, 27 Sep 2018 12:54:21 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        Sasidhar Mudigonda <sasidhar.mudigonda@redpinesignals.com>,
        Siva Rebbagondla <siva.rebbagondla@redpinesignals.com>,
        Sanjay Kumar Konduri <sanjay.konduri@redpinesignals.com>
Content-Transfer-Encoding: 7bit
Message-Id: <7CC1BD5C-5039-46C6-BAE0-860D47A165E0@holtmann.org>
References: <1535954266-6339-1-git-send-email-siva8118@gmail.com>
To:     Siva Rebbagondla <siva8118@gmail.com>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Siva,

> observed sometimes data is coming with unaligned address from kernel
> BT stack. If unaligned address is passed, some data in payload is
> stripped when packet is loading to firmware and this results, BT
> connection timeout is happening.
> 
> sh# hciconfig hci0 up
> Can't init device hci0: hci0 command 0x0c03 tx timeout
> 
> Fixed this by moving the data to aligned address.
> 
> Signed-off-by: Sanjay Kumar Konduri <sanjay.konduri@redpinesignals.com>
> Signed-off-by: Siva Rebbagondla <siva.rebbagondla@redpinesignals.com>
> ---
> drivers/bluetooth/btrsi.c | 13 ++++++++++++-
> 1 file changed, 12 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

