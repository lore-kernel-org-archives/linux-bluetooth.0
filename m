Return-Path: <SRS0=Bgmv=7Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D52C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jun 2020 11:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56BDE2072F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jun 2020 11:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgFKLot (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Jun 2020 07:44:49 -0400
Received: from mga12.intel.com ([192.55.52.136]:26678 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbgFKLot (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Jun 2020 07:44:49 -0400
IronPort-SDR: ADLqV6gLNFBRWzV9nVssr6VEU7PsKFiXFSIT9RV7PnqiTC1/auEoUNHG+dSqU09aNmucjVzzsh
 eH4fmNgbi8Kg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 04:44:49 -0700
IronPort-SDR: 3aBYBeqRXRJXIsYXHRRUKTDkE4JJnIm1NtMB2H9u4Xc6rW/oxdZd/CfDm+TnuOMsdcGEstzDTt
 kCzn/Dv3MMBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,499,1583222400"; 
   d="scan'208";a="296562824"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by fmsmga004.fm.intel.com with ESMTP; 11 Jun 2020 04:44:47 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, kiraank@gmail.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH 0/4] Add support for new generation Intel controllers
Date:   Thu, 11 Jun 2020 17:15:22 +0530
Message-Id: <20200611114526.13594-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi All,
This patchset series defines a structure and few helper functions required
to enable new generation Intel controllers

Raghuram Hegde (4):
  Bluetooth: btintel: Define tlv structure to enable firmware download
  Bluetooth: btintel: Add helper functions to dump boot/firmware info
  Bluetooth: btintel: Add helper functions to parse firmware name
  Bluetooth: btintel: Add helper function to help controller type

 drivers/bluetooth/btintel.c | 173 ++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h |  49 ++++++++++
 2 files changed, 222 insertions(+)

-- 
2.17.1

