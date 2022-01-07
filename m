Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3827BC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jan 2022 07:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345004AbiAGHkv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jan 2022 02:40:51 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:57711 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235765AbiAGHku (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jan 2022 02:40:50 -0500
Received: from smtpclient.apple (p4fefca45.dip0.t-ipconnect.de [79.239.202.69])
        by mail.holtmann.org (Postfix) with ESMTPSA id DA831CECE9;
        Fri,  7 Jan 2022 08:40:48 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] Bluetooth: L2CAP: uninitialized variables in
 l2cap_sock_setsockopt()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220107071644.GC22086@kili>
Date:   Fri, 7 Jan 2022 08:40:48 +0100
Cc:     Christoph Hellwig <hch@lst.de>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <15BB58F3-4D63-4901-837D-00DF3A8F0847@holtmann.org>
References: <20220107071644.GC22086@kili>
To:     Dan Carpenter <dan.carpenter@oracle.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Dan,

> The "opt" variable is a u32, but on some paths only the top bytes
> were initialized and the others contained random stack data.
> 
> Fixes: a7b75c5a8c41 ("net: pass a sockptr_t into ->setsockopt")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> net/bluetooth/l2cap_sock.c | 14 ++++++++------
> 1 file changed, 8 insertions(+), 6 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

