Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D803C04A95
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 18:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbiIWSAt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 14:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbiIWSAs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 14:00:48 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A03F74DCD
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 11:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663956046; x=1695492046;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9H6d1ONWK3k8OR3wG0HJOT/hTMJSmzyN5XEkJOLo2yo=;
  b=T0j3AuQInpyzHSpbx7HKvVllciuxBQQ5V0xJvbbQCsjSFdCCMwOlFcte
   8pawvEzv/u3dw6JHLlz/p8puZGA/H8CG0UjHX8V1A1wPcmTYUdgp7rJJf
   Q9TenBc0hlqrsjmI4G36PpZKhyBwIbGBtgFs5w40MrxEWYp/Ttu3HNlH3
   dWH920V9xna05LgHFv1PGofnA8jyeyoMTh2hZKCvE/TmOimQ9x7ijNv81
   7LYG6cQhjeHVjuwjD00JpkXr2EUIaHjyE9BYwdLNUieU8HyF835T4Gi4u
   STgcwxgB3N345wGWsGbb65GlPfQfoh5+kXTkE5Y4bTZ2ohB6zr028NRW2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="300633803"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="300633803"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 11:00:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="745878195"
Received: from cramirez-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.82.81])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 11:00:30 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH BlueZ v5 1/2] mesh: Improve PB-ADV timing for reliability
Date:   Fri, 23 Sep 2022 11:00:17 -0700
Message-Id: <20220923180018.815614-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220923180018.815614-1-brian.gix@intel.com>
References: <20220923180018.815614-1-brian.gix@intel.com>
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

