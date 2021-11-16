Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529F4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Nov 2021 13:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26E4361B9F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Nov 2021 13:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236921AbhKPN6r convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Nov 2021 08:58:47 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:33681 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhKPN6p (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Nov 2021 08:58:45 -0500
Received: from smtpclient.apple (p4fefc15c.dip0.t-ipconnect.de [79.239.193.92])
        by mail.holtmann.org (Postfix) with ESMTPSA id E0088CECD7;
        Tue, 16 Nov 2021 14:55:46 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH] Bluetooth: stop proccessing malicious adv data
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211101071212.15355-1-paskripkin@gmail.com>
Date:   Tue, 16 Nov 2021 14:55:46 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+e3fcb9c4f3c2a931dc40@syzkaller.appspotmail.com
Content-Transfer-Encoding: 8BIT
Message-Id: <243C55F7-277C-478F-9ECA-254E293EEDBD@holtmann.org>
References: <20211101071212.15355-1-paskripkin@gmail.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pavel,

> Syzbot reported slab-out-of-bounds read in hci_le_adv_report_evt(). The
> problem was in missing validaion check.
> 
> We should check if data is not malicious and we can read next data block.
> If we won't check ptr validness, code can read a way beyond skb->end and
> it can cause problems, of course.
> 
> Fixes: e95beb414168 ("Bluetooth: hci_le_adv_report_evt code refactoring")
> Reported-and-tested-by: syzbot+e3fcb9c4f3c2a931dc40@syzkaller.appspotmail.com
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
> net/bluetooth/hci_event.c | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

