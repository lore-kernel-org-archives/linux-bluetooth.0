Return-Path: <SRS0=2tab=5J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F43C4332B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 08:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28A620786
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 08:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgCXIsc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Mar 2020 04:48:32 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:41661 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgCXIsc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Mar 2020 04:48:32 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 54C4ACED08;
        Tue, 24 Mar 2020 09:58:02 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH v5 1/3] Bluetooth: L2CAP: Add get_peer_pid callback
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200323203458.24733-2-luiz.dentz@gmail.com>
Date:   Tue, 24 Mar 2020 09:48:30 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <B522B1CE-AF17-410F-A9B4-3C79BFA5E649@holtmann.org>
References: <20200323203458.24733-1-luiz.dentz@gmail.com>
 <20200323203458.24733-2-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This adds a callback to read the socket pid.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> include/net/bluetooth/l2cap.h | 1 +
> net/bluetooth/l2cap_sock.c    | 8 ++++++++
> 2 files changed, 9 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

