Return-Path: <SRS0=Ypkk=IF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEFCC433DB
	for <linux-bluetooth@archiver.kernel.org>; Sun,  7 Mar 2021 09:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3C5465136
	for <linux-bluetooth@archiver.kernel.org>; Sun,  7 Mar 2021 09:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhCGJPi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 7 Mar 2021 04:15:38 -0500
Received: from mga11.intel.com ([192.55.52.93]:53411 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230451AbhCGJPX (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 7 Mar 2021 04:15:23 -0500
IronPort-SDR: P7B3jWvVic6qWGBWkwNG1mJsB5xefG7DsG+BPfWvSrSvbMtTLvoBDTYRmqmdKi0oRrilwdiRzX
 uIdJ9zugPElA==
X-IronPort-AV: E=McAfee;i="6000,8403,9915"; a="184507820"
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="184507820"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2021 01:15:18 -0800
IronPort-SDR: prKT0yurHber87lbuoZfaF1wc/pWlOSpN3B58Gdutby3VZT7xVNtDq3gHDo9+Pu40An0nJP2l2
 VUacK1EdhZXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="429994479"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga004.fm.intel.com with ESMTP; 07 Mar 2021 01:15:17 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] monitor: Fix decoding Read Local Supported Codec Capabilities
Date:   Sun,  7 Mar 2021 14:48:45 +0530
Message-Id: <20210307091845.13269-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Codec capabilities wern't properly decoded due to wrong offset

< HCI Command: Read Local Supported Codec Capabilities (0x04|0x000e) plen 7
        Codec: A-law log (0x01)
        Logical Transport Type: 0x01
          Codec supported over BR/EDR ACL
        Direction: Input (Host to Controller) (0x00)
> HCI Event: Command Complete (0x0e) plen 18
      Read Local Supported Codec Capabilities (0x04|0x000e) ncmd 1
        Status: Success (0x00)
        Number of codec capabilities: 3
         Capabilities #0:
        aa bb cc dd                                      ....
         Capabilities #1:
        11 22 33 44 55                                   ."3DU
         Capabilities #2:
        ff                                               .
---
 monitor/packet.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index fb265028c213..75b61d57aa7c 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -6032,23 +6032,23 @@ static void read_local_codec_caps_rsp(const void *data, uint8_t size)
 	print_status(rsp->status);
 	print_field("Number of codec capabilities: %d", rsp->num);
 
-	data += sizeof(rsp);
-	size -= sizeof(rsp);
+	data += sizeof(*rsp);
+	size -= sizeof(*rsp);
 
 	for (i = 0; i < rsp->num; i++) {
 		const struct bt_hci_codec_caps *caps = data;
 
-		if (size < sizeof(caps)) {
+		if (size < sizeof(*caps)) {
 			print_field("Invalid capabilities: %u < %zu",
-						size, sizeof(caps));
+						size, sizeof(*caps));
 			return;
 		}
 
 		print_field(" Capabilities #%u:", i);
 		packet_hexdump(caps->data, caps->len);
 
-		data += caps->len;
-		size -= caps->len;
+		data += 1 + caps->len;
+		size -= 1 + caps->len;
 	}
 }
 
-- 
2.17.1

