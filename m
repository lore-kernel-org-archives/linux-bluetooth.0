Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39040C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Mar 2022 15:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353571AbiCPPjo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Mar 2022 11:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239846AbiCPPjn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Mar 2022 11:39:43 -0400
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2328D34B8E
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Mar 2022 08:38:29 -0700 (PDT)
Received: from smtpclient.apple (p5b3d2183.dip0.t-ipconnect.de [91.61.33.131])
        by mail.holtmann.org (Postfix) with ESMTPSA id 39F7ACECF8;
        Wed, 16 Mar 2022 16:38:28 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] Bluetooth: call hci_le_conn_failed with hdev lock in
 hci_le_conn_failed
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220316153350.10047-1-dossche.niels@gmail.com>
Date:   Wed, 16 Mar 2022 16:38:27 +0100
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <99A3F96C-2926-463D-ABF6-5344CE8DC6B2@holtmann.org>
References: <20220316153350.10047-1-dossche.niels@gmail.com>
To:     Niels Dossche <dossche.niels@gmail.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Niels,

> hci_le_conn_failed function's documentation says that the caller must
> hold hdev->lock. The only callsite that does not hold that lock is
> hci_le_conn_failed. The other 3 callsites hold the hdev->lock very
> locally. The solution is to hold the lock during the call to
> hci_le_conn_failed.
> 
> Fixes: 3c857757ef6e ("Bluetooth: Add directed advertising support through connect()")
> Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
> ---
> net/bluetooth/hci_conn.c | 2 ++
> 1 file changed, 2 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

