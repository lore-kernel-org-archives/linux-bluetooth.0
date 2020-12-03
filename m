Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DB9C433C1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 13:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8DF0206F6
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 13:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbgLCNzv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Dec 2020 08:55:51 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:47141 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbgLCNzu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Dec 2020 08:55:50 -0500
Received: from marcel-macbook.holtmann.net (unknown [37.83.193.87])
        by mail.holtmann.org (Postfix) with ESMTPSA id 06097CECFE;
        Thu,  3 Dec 2020 15:02:22 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH v8 4/5] Bluetooth: btusb: Helper function to download
 firmware to Intel adapters
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201119113943.13839-4-kiran.k@intel.com>
Date:   Thu, 3 Dec 2020 14:55:09 +0100
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        chethan.tumkur.narayan@intel.com, sathish.narasimman@intel.com
Content-Transfer-Encoding: 7bit
Message-Id: <044292D8-B4B8-4FE4-A52D-44A892A860D7@holtmann.org>
References: <20201119113943.13839-1-kiran.k@intel.com>
 <20201119113943.13839-4-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

> Define a helper function to download firmware for new generation Intel
> controllers
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
> drivers/bluetooth/btusb.c | 165 ++++++++++++++++++++++++++++++++++++++
> 1 file changed, 165 insertions(+)

Patch has been applied to bluetooth-next tree.

Regards

Marcel

