Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D214C43217
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 02:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiBXCHM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Feb 2022 21:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiBXCHK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Feb 2022 21:07:10 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1A4BC14
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 18:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645668401; x=1677204401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XLo09VOnrfXFZDVVxDI4lAY3LPFNp9RKr5Q5sFswc5k=;
  b=HL5hybJHPAPQhKzW6tR3e+mq7UwC0IDN02grkGcg6w+EQZDmED+IdGiF
   p2LCurcvajP9G+5Gh0TCUhzQveF1WxmcPtxGp3a1VEkhb1jYe2zOMn+Ca
   QjWPU/H9Eza1AKe7Qctm8MeUs9mniFxZ7TvVqzSemzzFQ0OcrUvOus7H8
   g+merrdUFeJJqctNyJS1FG8D0QSaWFmT2uY6cDeR9A04yw6HPvanYaFpX
   X4M6iEPvlthTxi5nm4SNkrSlT92bcSiUVlUV2FAzD9NJLBz+yuP8mmhG7
   SANwey4b4KQ3TvGHmiLV+gejiaXlbCWl3gJlaeVjpfQJnQJ7iJXAslSuN
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="239525008"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="239525008"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 18:06:34 -0800
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="607268582"
Received: from tjsmith-mobl1.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.209.34.213])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 18:06:34 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH 7/7] mesh: Make Provisioning requests more IO compatible
Date:   Wed, 23 Feb 2022 18:06:24 -0800
Message-Id: <20220224020624.159247-8-brian.gix@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224020624.159247-1-brian.gix@intel.com>
References: <20220224020624.159247-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Requests longer (half second) periods between discrete PB-ADV
transmissions. This prevents the controller from being overwhelmed
by PB-ADV packets when daemon is also an active mesh network member.
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
2.35.1

