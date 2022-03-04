Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17932C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Mar 2022 09:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239313AbiCDJzR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Mar 2022 04:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiCDJzQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Mar 2022 04:55:16 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28DDA3B034
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Mar 2022 01:54:27 -0800 (PST)
Received: from smtpclient.apple (p5b3d2910.dip0.t-ipconnect.de [91.61.41.16])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9B7E1CEC82;
        Fri,  4 Mar 2022 10:54:26 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH 1/3] Bluetooth: btusb: Make use of of BIT macro to declare
 flags
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220303221709.387865-1-luiz.dentz@gmail.com>
Date:   Fri, 4 Mar 2022 10:54:26 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <4FEB0E81-A466-4D0D-9519-4F081BB773A7@holtmann.org>
References: <20220303221709.387865-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This makes use of BIT macro when declaring BTUSB flags which makes it
> understand how many bits are in use and many are left.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> drivers/bluetooth/btusb.c | 54 +++++++++++++++++++--------------------
> 1 file changed, 27 insertions(+), 27 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

