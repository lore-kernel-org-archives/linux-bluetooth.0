Return-Path: <SRS0=5QOG=NF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847C6ECDE47
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Oct 2018 10:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56FBE20838
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Oct 2018 10:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56FBE20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeJYSx1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Oct 2018 14:53:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:32204 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbeJYSx0 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Oct 2018 14:53:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2018 03:21:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,424,1534834800"; 
   d="scan'208";a="94903878"
Received: from bpanda-all-series.iind.intel.com ([10.223.96.45])
  by orsmga003.jf.intel.com with ESMTP; 25 Oct 2018 03:21:20 -0700
From:   Bharat Bhusan Panda <bharat.b.panda@intel.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] doc/mgmt-api: Mention fast advertising interval
Date:   Thu, 25 Oct 2018 16:07:17 +0530
Message-Id: <1540463837-1579-2-git-send-email-bharat.b.panda@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1540463837-1579-1-git-send-email-bharat.b.panda@intel.com>
References: <1540463837-1579-1-git-send-email-bharat.b.panda@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 doc/mgmt-api.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 87982e0..4fb8d92 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -1632,6 +1632,18 @@ Set Advertising Command
 	The value 0x02 should be the preferred mode of operation when
 	implementing peripheral mode.
 
+	To enable fast advertising interval, use value 0x02 as peripheral mode
+	when connectable or discoverable settings are disabled or limited
+	discoverable mode is enabled. As per core spec 4.1 section 9.3.11.2,
+	A peripheral device entering any of the following GAP modes and
+	sending either non-connectable advertising events or scannable
+	undirected advertising events should use adv_fast_interval2(100ms-150ms)
+	for adv_fast_period(30s).
+		- Non-Discoverable Mode
+		- Non-Connectable Mode
+		- Limited Discoverable Mode
+		- General Discoverable Mode
+
 	Using this command will temporarily deactivate any configuration
 	made by the Add Advertising command. This command takes precedence.
 	Once a Set Advertising command with value 0x00 is issued any
-- 
1.9.1

