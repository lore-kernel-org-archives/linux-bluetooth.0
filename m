Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AC4C6FA91
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Sep 2022 21:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiIVVin (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Sep 2022 17:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiIVVie (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Sep 2022 17:38:34 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4885C10253C
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Sep 2022 14:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663882714; x=1695418714;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9H6d1ONWK3k8OR3wG0HJOT/hTMJSmzyN5XEkJOLo2yo=;
  b=m63cTqwMrBHFPtn+Eo5mTPdCXCUWxeLEpdKYILRibmEmpbebNspTpli8
   ob5DoBT8oI5u2KZUExRdlJIBcW8TzarbEMtgzbNWKFInwfbqStney/UQ8
   iZx3RoaZYrNt6Nu61tMjBqpUZCaTn53P4CCF+V36PEMXQNKXXF/Gedhcn
   2Qds0n3y7DAITZDSsB9Fzm/C7BoJBVwmJUKFicGcVOahz5NU3Sn1Omyi1
   f5mtQYVKHZZPCiRVo0z4a5m8BZFEgH+aR2n7jC6s9vFgR/iXL0+Hpl9e3
   ucLJV41f5HYrZepfgbWayfzG/5BqUH+Y47zMW18V9ADi0V5ERTiUDhpc2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="364450478"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="364450478"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 14:38:33 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="571141907"
Received: from avarhadk-mobl1.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.213.161.147])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 14:38:33 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH BlueZ v2 1/2] mesh: Improve PB-ADV timing for reliability
Date:   Thu, 22 Sep 2022 14:38:21 -0700
Message-Id: <20220922213822.600692-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922213822.600692-1-brian.gix@intel.com>
References: <20220922213822.600692-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Because provisioning is not speed dependent, Timing on outbound PB-ADV
packets have been modified to be less likely missed by remote controlers
with looser timing capabilities.
---
 mesh/pb-adv.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mesh/pb-adv.c b/mesh/pb-adv.c
index 83f922aa8..180b16258 100644
--- a/mesh/pb-adv.c
+++ b/mesh/pb-adv.c
@@ -23,6 +23,8 @@
 #include "mesh/provision.h"
 #include "mesh/pb-adv.h"
 
+#include "mesh/util.h"
+
 
 struct pb_adv_session {
 	mesh_prov_open_func_t open_cb;
@@ -158,7 +160,7 @@ static void send_adv_segs(struct pb_adv_session *session, const uint8_t *data,
 	l_debug("max_seg: %2.2x", max_seg);
 	l_debug("size: %2.2x, CRC: %2.2x", size, buf[9]);
 
-	pb_adv_send(session, MESH_IO_TX_COUNT_UNLIMITED, 200,
+	pb_adv_send(session, MESH_IO_TX_COUNT_UNLIMITED, 500,
 							buf, init_size + 10);
 
 	consumed = init_size;
@@ -174,7 +176,7 @@ static void send_adv_segs(struct pb_adv_session *session, const uint8_t *data,
 		buf[6] = (i << 2) | 0x02;
 		memcpy(buf + 7, data + consumed, seg_size);
 
-		pb_adv_send(session, MESH_IO_TX_COUNT_UNLIMITED, 200,
+		pb_adv_send(session, MESH_IO_TX_COUNT_UNLIMITED, 500,
 							buf, seg_size + 7);
 
 		consumed += seg_size;
@@ -270,7 +272,8 @@ static void send_ack(struct pb_adv_session *session, uint8_t trans_num)
 	ack.trans_num = trans_num;
 	ack.opcode = PB_ADV_ACK;
 
-	pb_adv_send(session, 1, 100, &ack, sizeof(ack));
+	pb_adv_send(session, MESH_IO_TX_COUNT_UNLIMITED, 500,
+							&ack, sizeof(ack));
 }
 
 static void send_close_ind(struct pb_adv_session *session, uint8_t reason)
-- 
2.37.3

