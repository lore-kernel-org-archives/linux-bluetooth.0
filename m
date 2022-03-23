Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9DBC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 21:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbiCWVIM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 17:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiCWVIM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 17:08:12 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943FF716ED
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 14:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648069601; x=1679605601;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4tX2VHvCiEXMor7xN+p2Vue9XuYmp1IO2BWlpO7tBH8=;
  b=PazrWbbiZ4f6SgFPQPbeO+ukFInwhLbll8z0v3Q7sDkOXzSscERPhW2I
   nFrDLnvOuRpj6vctVJ4zNuteXGFMWkPIVTFRnYXVZnqamh50PiYrwrXCi
   aASn2sInxk/2SRptuCIjyIpB9pBNaE6aHvSDj59Irj0trdgWCWWGVWIkR
   KjV4tQFqqPpUiQwbm1xnL4LUi7ES9ed0yU9DvndrdWpE+KfyTSgcxnd6M
   hWGDhUg1r4n6u2leFD2iPZBqK+4ueBFBvw/TAWKXNrETIlx6r1dHR5F4t
   53N4Cg7BbTuxftqW3cF23KIH/BfSsZLM86hKuzRfU4T8mlkJYTla5nm3r
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="238167068"
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="238167068"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 14:06:41 -0700
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="601450895"
Received: from nishthas-mobl.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.212.134.104])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 14:06:41 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Fix address overrun error in rx filter
Date:   Wed, 23 Mar 2022 14:06:29 -0700
Message-Id: <20220323210629.17274-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes the following error for invalid read access when registering
filter for incoming messages:

140632==ERROR: AddressSanitizer: stack-buffer-overflow on address...
 #0 0x7f60c185741d in MemcmpInterceptorCommon(...
    #1 0x7f60c1857af8 in __interceptor_memcmp (/lib64/libasan.so...
    #2 0x55a10101536e in find_by_filter mesh/mesh-io-unit.c:494
    #3 0x55a1010d8c46 in l_queue_remove_if ell/queue.c:517
    #4 0x55a101014ebd in recv_register mesh/mesh-io-unit.c:506
    #5 0x55a10102946f in mesh_net_attach mesh/net.c:2885
    #6 0x55a101086f64 in send_reply mesh/dbus.c:153
    #7 0x55a101124c3d in handle_method_return ell/dbus.c:216
    #8 0x55a10112c8ef in message_read_handler ell/dbus.c:276
    #9 0x55a1010dae20 in io_callback ell/io.c:120
    #10 0x55a1010dff7e in l_main_iterate ell/main.c:478
    #11 0x55a1010e06e3 in l_main_run ell/main.c:525
    #12 0x55a1010e06e3 in l_main_run ell/main.c:507
    #13 0x55a1010e0bfc in l_main_run_with_signal ell/main.c:647
    #14 0x55a10100316e in main mesh/main.c:292
    #15 0x7f60c0c6855f in __libc_start_call_main (/lib64/libc.so.6+...
    #16 0x7f60c0c6860b in __libc_start_main_alias_1 (/lib64/libc.so.6+...
    #17 0x55a101003ce4 in _start (/home/istotlan/bluez/mesh/bluetooth-m...
---
 mesh/mesh-io-generic.c | 25 ++++++++++++++++---------
 mesh/mesh-io-unit.c    | 18 +++++++++++-------
 2 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/mesh/mesh-io-generic.c b/mesh/mesh-io-generic.c
index 6c0b8f0fd..364e363a6 100644
--- a/mesh/mesh-io-generic.c
+++ b/mesh/mesh-io-generic.c
@@ -810,10 +810,13 @@ static bool tx_cancel(struct mesh_io *io, const uint8_t *data, uint8_t len)
 
 static bool find_by_filter(const void *a, const void *b)
 {
-	const struct pvt_rx_reg *rx_reg = a;
-	const uint8_t *filter = b;
+	const struct pvt_rx_reg *rx_reg_old = a;
+	const struct pvt_rx_reg *rx_reg = b;
+
+	if (rx_reg_old->len != rx_reg->len)
+		return false;
 
-	return !memcmp(rx_reg->filter, filter, rx_reg->len);
+	return !memcmp(rx_reg_old->filter, rx_reg->filter, rx_reg->len);
 }
 
 static bool recv_register(struct mesh_io *io, const uint8_t *filter,
@@ -821,16 +824,13 @@ static bool recv_register(struct mesh_io *io, const uint8_t *filter,
 {
 	struct bt_hci_cmd_le_set_scan_enable cmd;
 	struct mesh_io_private *pvt = io->pvt;
-	struct pvt_rx_reg *rx_reg;
+	struct pvt_rx_reg *rx_reg, *rx_reg_old;
 	bool already_scanning;
 	bool active = false;
 
 	if (!cb || !filter || !len)
 		return false;
 
-	rx_reg = l_queue_remove_if(pvt->rx_regs, find_by_filter, filter);
-
-	l_free(rx_reg);
 	rx_reg = l_malloc(sizeof(*rx_reg) + len);
 
 	memcpy(rx_reg->filter, filter, len);
@@ -838,6 +838,10 @@ static bool recv_register(struct mesh_io *io, const uint8_t *filter,
 	rx_reg->cb = cb;
 	rx_reg->user_data = user_data;
 
+	rx_reg_old = l_queue_remove_if(pvt->rx_regs, find_by_filter, rx_reg);
+
+	l_free(rx_reg_old);
+
 	already_scanning = !l_queue_isempty(pvt->rx_regs);
 
 	l_queue_push_head(pvt->rx_regs, rx_reg);
@@ -863,10 +867,13 @@ static bool recv_deregister(struct mesh_io *io, const uint8_t *filter,
 {
 	struct bt_hci_cmd_le_set_scan_enable cmd = {0, 0};
 	struct mesh_io_private *pvt = io->pvt;
-	struct pvt_rx_reg *rx_reg;
+	struct pvt_rx_reg *rx_reg, rx_reg_tmp;
 	bool active = false;
 
-	rx_reg = l_queue_remove_if(pvt->rx_regs, find_by_filter, filter);
+	memcpy(&rx_reg_tmp.filter, filter, len);
+	rx_reg_tmp.len = len;
+
+	rx_reg = l_queue_remove_if(pvt->rx_regs, find_by_filter, &rx_reg_tmp);
 
 	if (rx_reg)
 		l_free(rx_reg);
diff --git a/mesh/mesh-io-unit.c b/mesh/mesh-io-unit.c
index f4b615ac8..bf3f808e4 100644
--- a/mesh/mesh-io-unit.c
+++ b/mesh/mesh-io-unit.c
@@ -488,24 +488,24 @@ static bool tx_cancel(struct mesh_io *io, const uint8_t *data, uint8_t len)
 
 static bool find_by_filter(const void *a, const void *b)
 {
-	const struct pvt_rx_reg *rx_reg = a;
-	const uint8_t *filter = b;
+	const struct pvt_rx_reg *rx_reg_old = a;
+	const struct pvt_rx_reg *rx_reg = b;
 
-	return !memcmp(rx_reg->filter, filter, rx_reg->len);
+	if (rx_reg_old->len != rx_reg->len)
+		return false;
+
+	return !memcmp(rx_reg_old->filter, rx_reg->filter, rx_reg->len);
 }
 
 static bool recv_register(struct mesh_io *io, const uint8_t *filter,
 			uint8_t len, mesh_io_recv_func_t cb, void *user_data)
 {
 	struct mesh_io_private *pvt = io->pvt;
-	struct pvt_rx_reg *rx_reg;
+	struct pvt_rx_reg *rx_reg, *rx_reg_old;
 
 	if (!cb || !filter || !len)
 		return false;
 
-	rx_reg = l_queue_remove_if(pvt->rx_regs, find_by_filter, filter);
-
-	l_free(rx_reg);
 	rx_reg = l_malloc(sizeof(*rx_reg) + len);
 
 	memcpy(rx_reg->filter, filter, len);
@@ -513,6 +513,10 @@ static bool recv_register(struct mesh_io *io, const uint8_t *filter,
 	rx_reg->cb = cb;
 	rx_reg->user_data = user_data;
 
+	rx_reg_old = l_queue_remove_if(pvt->rx_regs, find_by_filter, rx_reg);
+
+	l_free(rx_reg_old);
+
 	l_queue_push_head(pvt->rx_regs, rx_reg);
 
 	return true;
-- 
2.35.1

