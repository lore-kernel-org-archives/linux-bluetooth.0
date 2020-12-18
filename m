Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4D5C4361B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Dec 2020 21:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EC5523B7B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Dec 2020 21:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgLRV2U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Dec 2020 16:28:20 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:52708 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgLRV2U (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Dec 2020 16:28:20 -0500
Received: from marcel-macbook.holtmann.net (p4fefcdf9.dip0.t-ipconnect.de [79.239.205.249])
        by mail.holtmann.org (Postfix) with ESMTPSA id C0E83CED33;
        Fri, 18 Dec 2020 22:34:55 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH 1/1] Bluetooth: Remove hci_req_le_suspend_config
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201207161221.1.I94feef9a75a69b0d0c7038d975239ef3b1b93ee6@changeid>
Date:   Fri, 18 Dec 2020 22:27:38 +0100
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        Howard Chung <howardchung@google.com>
Content-Transfer-Encoding: 7bit
Message-Id: <C0715297-245B-45A7-A6FD-3A1A04710AD0@holtmann.org>
References: <20201208001254.575890-1-abhishekpandit@chromium.org>
 <20201207161221.1.I94feef9a75a69b0d0c7038d975239ef3b1b93ee6@changeid>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

> Add a missing SUSPEND_SCAN_ENABLE in passive scan, remove the separate
> function for configuring le scan during suspend and update the request
> complete function to clear both enable and disable tasks.
> 
> Fixes: dce0a4be8054 ("Bluetooth: Set missing suspend task bits")
> Reviewed-by: Alain Michaud <alainm@chromium.org>
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> 
> net/bluetooth/hci_request.c | 25 ++++++++-----------------
> 1 file changed, 8 insertions(+), 17 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

