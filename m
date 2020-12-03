Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B353EC433C1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 13:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6259F206A1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 13:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbgLCN4d (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Dec 2020 08:56:33 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:35159 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728830AbgLCN4d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Dec 2020 08:56:33 -0500
Received: from marcel-macbook.holtmann.net (unknown [37.83.193.87])
        by mail.holtmann.org (Postfix) with ESMTPSA id CD449CECFF;
        Thu,  3 Dec 2020 15:03:05 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH v8 1/5] Bluetooth: btintel: Fix endianness issue for TLV
 version information
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201119113943.13839-1-kiran.k@intel.com>
Date:   Thu, 3 Dec 2020 14:55:51 +0100
Cc:     BlueZ development <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        sathish.narasimman@intel.com
Content-Transfer-Encoding: 7bit
Message-Id: <3D9E3CB8-F8E9-4EC8-86A4-3B8560A71A37@holtmann.org>
References: <20201119113943.13839-1-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

> do __le32_to_cpu to tlv data fields to make sure driver runs
> correctly when running on big endian system.
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> ---
> drivers/bluetooth/btintel.c | 21 ++++++++++++++-------
> 1 file changed, 14 insertions(+), 7 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

