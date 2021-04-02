Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603A6C433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Apr 2021 09:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D2FB610E8
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Apr 2021 09:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbhDBJGm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Apr 2021 05:06:42 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:53906 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhDBJGl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Apr 2021 05:06:41 -0400
Received: from marcel-macbook.holtmann.net (p5b3d2269.dip0.t-ipconnect.de [91.61.34.105])
        by mail.holtmann.org (Postfix) with ESMTPSA id C70F2CED22;
        Fri,  2 Apr 2021 11:14:20 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH 0/2] net/Blutooth - Coding style fix
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1617259839-31383-1-git-send-email-yumeng18@huawei.com>
Date:   Fri, 2 Apr 2021 11:06:38 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, wangzhou1@hisilicon.com,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <678B96F2-0AFD-4506-AE57-1F0A164C644B@holtmann.org>
References: <1617259839-31383-1-git-send-email-yumeng18@huawei.com>
To:     Meng Yu <yumeng18@huawei.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Meng,

> Remove 'return' in void function and fix some coding style
> 
> Meng Yu (2):
>  Bluetooth: Remove 'return' in void function
>  Bluetooth: Coding style fix
> 
> net/bluetooth/6lowpan.c     | 5 +----
> net/bluetooth/hci_debugfs.c | 8 ++++----
> net/bluetooth/hci_event.c   | 2 +-
> net/bluetooth/hci_request.c | 6 ++----
> net/bluetooth/l2cap_core.c  | 7 +++----
> 5 files changed, 11 insertions(+), 17 deletions(-)

both patches have been applied to bluetooth-next tree.

Regards

Marcel

