Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB87ECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Sep 2022 20:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiIVUjH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Sep 2022 16:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIVUjF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Sep 2022 16:39:05 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C0A1103C4
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Sep 2022 13:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663879144; x=1695415144;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AU+rtRD7CTXQDrndJ8oGbf/wB3JSyPQjG8Km/9WFCtE=;
  b=PIkVXs5I3Ozl4QSFWTeuiyAdaK4MnpI7lGSPg3ryoB2B8iD7hNq/mqpg
   tPvr/XJ80+9I8nkiKJEyjh1iU0EnFghzMEyTSvAekOxEcwTNK9Vuw3bWR
   3LI+jz1W+nQiCw2tRL1k5G/W51I6XBxlyfcqECCHBMsH+YbV287cDy9I1
   VWeREzsKsj4ALGIhvfbJeF7dgcd4qtgepv4RSZY6M5Jz7IE4dh3ZxQbCK
   BWKu/ESVrQ9d9hGK36UYh7h2tee7QafVOjy/DIVgNut3AJV/qpNvyJfs0
   fYiJKnGilGYaIYUU6K7lLs9U1rSl1J9Nhf2dLLp2afLR0bOd+6+C6WGzh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="301303196"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="301303196"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 13:39:00 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="865028674"
Received: from mobl2.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.23.53])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 13:39:00 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH BlueZ 3/4] mesh: Improve PB-ADV timing for reliability
Date:   Thu, 22 Sep 2022 13:38:51 -0700
Message-Id: <20220922203852.494315-4-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922203852.494315-1-brian.gix@intel.com>
References: <20220922203852.494315-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Because provisioning is not speed dependant, Timing on outbound PB-ADV
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

