Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DDAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jan 2022 07:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbiAGHmf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jan 2022 02:42:35 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:36660 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbiAGHme (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jan 2022 02:42:34 -0500
Received: from smtpclient.apple (p4fefca45.dip0.t-ipconnect.de [79.239.202.69])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8756BCECE8;
        Fri,  7 Jan 2022 08:42:33 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] Bluetooth: hci_sock: fix endian bug in
 hci_sock_setsockopt()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220107071727.GD22086@kili>
Date:   Fri, 7 Jan 2022 08:42:33 +0100
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <2F363C3C-4D1C-42B6-8877-D321864F473D@holtmann.org>
References: <20220107071727.GD22086@kili>
To:     Dan Carpenter <dan.carpenter@oracle.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Dan,

> This copies a u16 into the high bits of an int, which works on a big
> endian system but not on a little endian system.
> 
> Fixes: 09572fca7223 ("Bluetooth: hci_sock: Add support for BT_{SND,RCV}BUF")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> net/bluetooth/hci_sock.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

