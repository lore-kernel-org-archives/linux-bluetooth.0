Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF790C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Mar 2021 10:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85D6164F94
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Mar 2021 10:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbhCKKq4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Mar 2021 05:46:56 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:41478 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbhCKKqp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Mar 2021 05:46:45 -0500
Received: from marcel-macbook.holtmann.net (p4fefc126.dip0.t-ipconnect.de [79.239.193.38])
        by mail.holtmann.org (Postfix) with ESMTPSA id 50D91CECE2;
        Thu, 11 Mar 2021 11:54:19 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v2 1/2] Bluetooth: SMP: Fail if remote and local public
 keys are identical
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210310221309.894602-1-luiz.dentz@gmail.com>
Date:   Thu, 11 Mar 2021 11:46:42 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <55999A27-68F2-4F8D-87B3-904D21EBC88C@holtmann.org>
References: <20210310221309.894602-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This fails the pairing procedure when both remote and local non-debug
> public keys are identical.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> v2: Use crypto_memneq instead of memcmp and add a patch converting the use of
> BT_ERR/BT_DBG to bt_dev_err/bt_dev_dbg.
> 
> net/bluetooth/smp.c | 9 +++++++++
> 1 file changed, 9 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

