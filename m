Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8F0C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Sep 2021 20:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6466C61106
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Sep 2021 20:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243210AbhIMUP4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Sep 2021 16:15:56 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:60669 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242914AbhIMUP4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Sep 2021 16:15:56 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 11C99CECCB;
        Mon, 13 Sep 2021 22:14:38 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v3 1/4] Bluetooth: Add bt_skb_sendmsg helper
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210903222732.1472560-1-luiz.dentz@gmail.com>
Date:   Mon, 13 Sep 2021 22:14:38 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <443C268A-4C0F-4B6C-87BF-BF13EFB0E40A@holtmann.org>
References: <20210903222732.1472560-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> bt_skb_sendmsg helps takes care of allocation the skb and copying the
> the contents of msg over to the skb while checking for possible errors
> so it should be safe to call it without holding lock_sock.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> include/net/bluetooth/bluetooth.h | 28 ++++++++++++++++++++++++++++
> 1 file changed, 28 insertions(+)

all 4 patches have been applied to bluetooth-next tree.

Regards

Marcel

