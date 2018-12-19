Return-Path: <SRS0=/IWC=O4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF804C43387
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 13:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A532C218A6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 13:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbeLSNhx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:37:53 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:33908 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728959AbeLSNhx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Dec 2018 08:37:53 -0500
Received: from marcel-macpro.fritz.box (p4FF9F1DE.dip0.t-ipconnect.de [79.249.241.222])
        by mail.holtmann.org (Postfix) with ESMTPSA id 016E3CEEAF;
        Wed, 19 Dec 2018 14:45:30 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] Bluetooth: Fix unnecessary error message for HCI request
 completion
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181127093746.7414-1-johan.hedberg@gmail.com>
Date:   Wed, 19 Dec 2018 14:37:51 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <B8B8FE13-4F1D-4F9D-9C76-42E5B39C3016@holtmann.org>
References: <20181127093746.7414-1-johan.hedberg@gmail.com>
To:     Johan Hedberg <johan.hedberg@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Johan,

> In case a command which completes in Command Status was sent using the
> hci_cmd_send-family of APIs there would be a misleading error in the
> hci_get_cmd_complete function, since the code would be trying to fetch
> the Command Complete parameters when there are none.
> 
> Avoid the misleading error and silently bail out from the function in
> case the received event is a command status.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 6 ++++++
> 1 file changed, 6 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

