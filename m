Return-Path: <SRS0=yo6A=RS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC083C43381
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Mar 2019 14:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D1F5217F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Mar 2019 14:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbfCOOKm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Mar 2019 10:10:42 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:57473 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729170AbfCOOKm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Mar 2019 10:10:42 -0400
Received: from marcel-macpro.fritz.box (p4FEFC449.dip0.t-ipconnect.de [79.239.196.73])
        by mail.holtmann.org (Postfix) with ESMTPSA id 54F4FCEEB3;
        Fri, 15 Mar 2019 15:18:40 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH Bluetooth 1/1] Bluetooth: L2CAP: add return check for
 security level set
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1552619793-29992-1-git-send-email-fugang.duan@nxp.com>
Date:   Fri, 15 Mar 2019 15:10:40 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <D29353D9-E94C-43C8-AE22-08B9ACC3C693@holtmann.org>
References: <1552619793-29992-1-git-send-email-fugang.duan@nxp.com>
To:     Andy Duan <fugang.duan@nxp.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Andy,

> Add return check for security level set for socket interface since
> stack will check the return value.
> 
> Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
> ---
> net/bluetooth/l2cap_sock.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

