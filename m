Return-Path: <SRS0=r7wX=SZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09B0C282DD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Apr 2019 17:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98F920835
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Apr 2019 17:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbfDWRX7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:23:59 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:38309 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728447AbfDWRX7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Apr 2019 13:23:59 -0400
Received: from marcel-macpro.fritz.box (p4FF9FD9B.dip0.t-ipconnect.de [79.249.253.155])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9AF15CF2DA;
        Tue, 23 Apr 2019 19:32:08 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] Bluetooth: Fix incorrect pointer arithmatic in
 ext_adv_report_evt
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1554273704-4004-1-git-send-email-jaganath.kanakkassery@intel.com>
Date:   Tue, 23 Apr 2019 19:23:58 +0200
Cc:     linux-bluetooth@vger.kernel.org,
        Jaganath Kanakkassery <jaganath.kanakkassery@intel.com>
Content-Transfer-Encoding: 7bit
Message-Id: <D6FE37F8-07A1-4319-BCF6-A0E9043664B5@holtmann.org>
References: <1554273704-4004-1-git-send-email-jaganath.kanakkassery@intel.com>
To:     Jaganath Kanakkassery <jaganath.k.os@gmail.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jaganath,

> In ext_adv_report_event rssi comes before data (not after data as
> in legacy adv_report_evt) so "+ 1" is not required in the ptr arithmatic
> to point to next report.
> 
> Signed-off-by: Jaganath Kanakkassery <jaganath.kanakkassery@intel.com>
> ---
> net/bluetooth/hci_event.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

