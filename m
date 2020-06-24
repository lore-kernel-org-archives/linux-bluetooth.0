Return-Path: <SRS0=JtDF=AF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42571C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Jun 2020 18:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E00F20738
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Jun 2020 18:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406066AbgFXSdd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Jun 2020 14:33:33 -0400
Received: from mga11.intel.com ([192.55.52.93]:6951 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405581AbgFXSdd (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Jun 2020 14:33:33 -0400
IronPort-SDR: e7/jcJrh3RmUm9iwXRcUt3Zws1tGgwVqDVMGzjMRSNTIb/YAU7nfCENl2TVdlYfnsTSfimyZOU
 c1u/X2GJN73A==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="142807121"
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="scan'208";a="142807121"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 11:33:33 -0700
IronPort-SDR: ELJjNVM78q4UYxmPn4a6SbRNIun8dHM1mi9DA7//uDKK9ERbpbN4qzr8RxwALS+sFY4gvLIafw
 R0j6KqtqEHpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="scan'208";a="263711189"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by fmsmga007.fm.intel.com with ESMTP; 24 Jun 2020 11:33:31 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, kiraank@gmail.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH 0/1] Refactor btusb_setup_intel_new
Date:   Thu, 25 Jun 2020 00:04:31 +0530
Message-Id: <20200624183432.1356-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Firmware download code is moved out of btusb_setup_intel_new into 
a new function to enhance readability and have scalability to plugin
new firmware download sequence 

Kiran K (1):
  Bluetooth: btusb: Refactor of firmware download flow for Intel
    conrollers

 drivers/bluetooth/btusb.c | 146 +++++++++++++++++++++-----------------
 1 file changed, 80 insertions(+), 66 deletions(-)

-- 
2.17.1

