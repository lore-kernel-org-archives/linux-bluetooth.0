Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA04C433E9
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 00:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9199C64F44
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 00:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355556AbhCDAeT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:34:19 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:40213 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388526AbhCCVKt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Mar 2021 16:10:49 -0500
Received: from marcel-macbook.holtmann.net (p4ff9fb90.dip0.t-ipconnect.de [79.249.251.144])
        by mail.holtmann.org (Postfix) with ESMTPSA id 58E05CED0A;
        Wed,  3 Mar 2021 22:17:37 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH] Bluetooth: Allow scannable adv with extended MGMT APIs
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210303111505.1.I3108b046a478cb4f1b85aeb84edb0f127cff81a8@changeid>
Date:   Wed, 3 Mar 2021 22:10:02 +0100
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <EA8605ED-9E87-4A8F-BEE6-3B2720732278@holtmann.org>
References: <20210303111505.1.I3108b046a478cb4f1b85aeb84edb0f127cff81a8@changeid>
To:     Daniel Winkler <danielwinkler@google.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Daniel,

> An issue was found, where if a bluetooth client requests a broadcast
> advertisement with scan response data, it will not be properly
> registered with the controller. This is because at the time that the
> hci_cp_le_set_scan_param structure is created, the scan response will
> not yet have been received since it comes in a second MGMT call. With
> empty scan response, the request defaults to a non-scannable PDU type.
> On some controllers, the subsequent scan response request will fail due
> to incorrect PDU type, and others will succeed and not use the scan
> response.
> 
> This fix allows the advertising parameters MGMT call to include a flag
> to let the kernel know whether a scan response will be coming, so that
> the correct PDU type is used in the first place. A bluetoothd change is
> also incoming to take advantage of it.
> 
> To test this, I created a broadcast advertisement with scan response
> data and registered it on the hatch chromebook. Without this change, the
> request fails, and with it will succeed.
> 
> Reviewed-by: Alain Michaud <alainm@chromium.org>
> Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> Signed-off-by: Daniel Winkler <danielwinkler@google.com>
> ---
> 
> include/net/bluetooth/mgmt.h | 1 +
> net/bluetooth/hci_request.c  | 3 ++-
> net/bluetooth/mgmt.c         | 1 +
> 3 files changed, 4 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

