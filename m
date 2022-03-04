Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F596C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Mar 2022 15:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240276AbiCDPc3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Mar 2022 10:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238996AbiCDPc2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Mar 2022 10:32:28 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64E9D1C57E6;
        Fri,  4 Mar 2022 07:31:40 -0800 (PST)
Received: from smtpclient.apple (p5b3d2910.dip0.t-ipconnect.de [91.61.41.16])
        by mail.holtmann.org (Postfix) with ESMTPSA id AEE81CECCA;
        Fri,  4 Mar 2022 16:31:39 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH] Bluetooth: move adv_instance_cnt read within the device
 lock
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <f181dc17-3b27-436b-15c1-832feb573d25@ugent.be>
Date:   Fri, 4 Mar 2022 16:31:39 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <6F62ECEB-DBCD-434B-BA9A-CF7942B8AD55@holtmann.org>
References: <f181dc17-3b27-436b-15c1-832feb573d25@ugent.be>
To:     Niels Dossche <niels.dossche@ugent.be>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Niels,

> The field adv_instance_cnt is always accessed within a device lock,
> except in the function add_advertising. A concurrent remove of an
> advertisement with adding another one could result in the if check
> "if a new instance was actually added" to not trigger, resulting
> in not triggering the "advertising added event".
> 
> Signed-off-by: Niels Dossche <niels.dossche@ugent.be>
> ---
> net/bluetooth/mgmt.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

