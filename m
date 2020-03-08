Return-Path: <SRS0=rf5u=4Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B948C18E5B
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Mar 2020 07:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F2320828
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Mar 2020 07:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgCHHpK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 8 Mar 2020 03:45:10 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:43489 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgCHHpK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 8 Mar 2020 03:45:10 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id A7B1ACED15;
        Sun,  8 Mar 2020 08:54:36 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] Bluetooth: L2CAP: Make use of skb_pull to parse signaling
 PDUs
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200306225127.9824-1-luiz.dentz@gmail.com>
Date:   Sun, 8 Mar 2020 08:45:08 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <A913BCE4-1FA7-4F54-9A34-ECA8DA983B40@holtmann.org>
References: <20200306225127.9824-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This uses skb_pull when parsing signalling PDUs so skb->data for
> pointing to the current PDU and skb->len as the remaining bytes to be
> processed.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/l2cap_core.c | 29 +++++++++++++----------------
> 1 file changed, 13 insertions(+), 16 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

