Return-Path: <SRS0=iWKJ=BW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9204CC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Aug 2020 20:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76A162076C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Aug 2020 20:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgHLUtk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Aug 2020 16:49:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:41644 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbgHLUtk (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Aug 2020 16:49:40 -0400
IronPort-SDR: HNuIpzlUtEa25JT9khlacIX5t3P67npAtFRizqW+eniKW/KDHcbHXWcbXx2CBJDdw80FGg+8Ln
 AL5OYfuM5WQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9711"; a="141695141"
X-IronPort-AV: E=Sophos;i="5.76,305,1592895600"; 
   d="scan'208";a="141695141"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 13:49:40 -0700
IronPort-SDR: iW19ueYDiZLNg7Max9fMuQFCCJ2zYgzNvte/+Y9RE8ecToYnw7DkHMxu5qBq3Zdr9f0G5NVJCZ
 ajrsRpqd+BWQ==
X-IronPort-AV: E=Sophos;i="5.76,305,1592895600"; 
   d="scan'208";a="276669179"
Received: from kwang8-mobl1.amr.corp.intel.com (HELO han1-mobl3.jf.intel.com) ([10.254.80.72])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 13:49:39 -0700
From:   tedd.an@linux.intel.com
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [V2 1/3] btp: Update connect event structure
Date:   Wed, 12 Aug 2020 13:49:30 -0700
Message-Id: <20200812204932.25627-1-tedd.an@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates the connect event struct to align withe the btp spec.

 Opcode 0x82 - Device Connected event
    Controller Index:   <controller id>
    Event parameters:   Address_Type (1 octet)
                        Address (6 octets)
                        Connection Interval (2 octets)
                        Connection Latency (2 octets)
                        Supervision Timeout (2 octets)
---
 src/shared/btp.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/btp.h b/src/shared/btp.h
index f0ac3a1ee..cc71a71df 100644
--- a/src/shared/btp.h
+++ b/src/shared/btp.h
@@ -259,6 +259,9 @@ struct btp_device_found_ev {
 struct btp_gap_device_connected_ev {
 	uint8_t address_type;
 	bdaddr_t address;
+	uint16_t connection_interval;
+	uint16_t connection_latency;
+	uint16_t supervision_timeout;
 } __packed;
 
 #define BTP_EV_GAP_DEVICE_DISCONNECTED		0x83
-- 
2.25.4

