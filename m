Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D6BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Mar 2022 14:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356656AbiCPOad (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Mar 2022 10:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356319AbiCPOac (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Mar 2022 10:30:32 -0400
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E784842A3A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Mar 2022 07:29:15 -0700 (PDT)
Received: from smtpclient.apple (p5b3d2183.dip0.t-ipconnect.de [91.61.33.131])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1173FCECF7;
        Wed, 16 Mar 2022 15:29:14 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH v2] Bluetooth: fix incorrect nonblock bitmask in
 bt_sock_wait_ready()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220314224252.3166367-1-gavin@matician.com>
Date:   Wed, 16 Mar 2022 15:29:13 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <8F322DA2-C862-4CCC-9EF9-BDB1148D5D7C@holtmann.org>
References: <20220314224252.3166367-1-gavin@matician.com>
To:     gavin@matician.com
X-Mailer: Apple Mail (2.3696.80.82.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Gavin,

> Callers pass msg->msg_flags as flags, which contains MSG_DONTWAIT
> instead of O_NONBLOCK.
> 
> Signed-off-by: Gavin Li <gavin@matician.com>
> ---
> include/net/bluetooth/bluetooth.h | 2 +-
> net/bluetooth/af_bluetooth.c      | 4 ++--
> 2 files changed, 3 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

