Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447BDC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 13:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CF4560F9B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 13:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbhJYNKY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 09:10:24 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:60973 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbhJYNKY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 09:10:24 -0400
Received: from smtpclient.apple (p4ff9f2d2.dip0.t-ipconnect.de [79.249.242.210])
        by mail.holtmann.org (Postfix) with ESMTPSA id 845FDCED17;
        Mon, 25 Oct 2021 15:08:00 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] Bluetooth: hci_bcm: Remove duplicated entry in OF table
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211023101027.44123-1-paul@crapouillou.net>
Date:   Mon, 25 Oct 2021 15:08:00 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        list@opendingux.net, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <8EB5175C-BF32-4669-A54B-3705D7710B95@holtmann.org>
References: <20211023101027.44123-1-paul@crapouillou.net>
To:     Paul Cercueil <paul@crapouillou.net>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Paul,

> The entry "brcm,bcm4330-bt" was listed twice in the table.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> drivers/bluetooth/hci_bcm.c | 1 -
> 1 file changed, 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

