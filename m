Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D8FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Dec 2021 15:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346161AbhLDPoR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 4 Dec 2021 10:44:17 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:40643 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345300AbhLDPoQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 4 Dec 2021 10:44:16 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id 2FB9ECED34;
        Sat,  4 Dec 2021 16:40:50 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH v4] Bluetooth: btusb: Add support for queuing during
 polling interval
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211203223813.2326558-1-luiz.dentz@gmail.com>
Date:   Sat, 4 Dec 2021 16:40:49 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <0311CD82-A721-4225-8893-CBB52A3E4283@holtmann.org>
References: <20211203223813.2326558-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This makes btusb to queue ACL and events during a polling interval
> by using of a delayed work, with the interval working as a time window
> where frames received from different endpoints are considered to be
> arrived at same time and then attempt to resolve potential conflics by
> processing the events ahead of ACL packets.
> 
> It worth noting though that priorizing events over ACL data may result
> in inverting the order compared to how they appeared over the air, for
> instance there may be packets received before a disconnect event that
> will be discarded and unencrypted packets received before encryption
> change which would considered encrypted, because of these potential
> changes on the order the support for queuing during the polling
> interval is not enabled by default so it requires setting
> force_poll_sync debugfs while the adapter is down.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> v2: Check for intr_interval instead of enable_poll_sync when dispatching
> since the former can only be changed on open/resume.
> v3: Change the way the feature is enabled from module parameter to debugfs
> entry and rename it from enable_poll_sync to force_poll_sync.
> v4: Cosmetic changes to address comments.
> 
> drivers/bluetooth/btusb.c | 129 ++++++++++++++++++++++++++++++++++++--
> 1 file changed, 124 insertions(+), 5 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

