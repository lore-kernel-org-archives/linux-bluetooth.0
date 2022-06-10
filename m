Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB30AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jun 2022 15:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244611AbiFJPaL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jun 2022 11:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237844AbiFJPaJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jun 2022 11:30:09 -0400
Received: from sender4-op-o13.zoho.com (sender4-op-o13.zoho.com [136.143.188.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3010DFF9
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 08:30:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1654875007; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=OKHls988t4Mvr4IEWqAmjBuJhL5WKo9wXlEZrhdPxbUQjL/S0Spq6772GcG11JOvhc4rp6BPzOUqdfDFGPWericsqZ8dkKCGeKk0AAyZTp0RmaFn+kO2TAOU6d0VHvFlfuX3RRPFYM8ufFJ6rxEIbEWqj3Ec19T6vIgZUw8ymKg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1654875007; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=4kS1pi947nXQQFN2ndEcRfeWV/JS6OnGl2KBu5Hg+is=; 
        b=YsgQjBe7hJL++rhSugFqz6qPPfE6u8kKin8eQZDlTUvm/EeEHqJit9dkNHvZDCfFTvB8fnq263rzbsFWXgJZuFk4RdLR87grxBhIV93kIaY9cPGyAvOUL/JhBRvH0w3hgA0XbT4z1BLS2MLkv9Noz6SGx/S7RdNt+0RgR0mxnyQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=dptechnics.com;
        spf=pass  smtp.mailfrom=jonas@dptechnics.com;
        dmarc=pass header.from=<jonas@dptechnics.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1654875007;
        s=zoho; d=dptechnics.com; i=jonas@dptechnics.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=4kS1pi947nXQQFN2ndEcRfeWV/JS6OnGl2KBu5Hg+is=;
        b=IfpU0AU3EJ70cFUNCXMUc3ua1Zpb1wq9jzLERszzLO7wSyvmYmhbG9WlUr1x9wmM
        2uFzNuQEPCxSuGKSQPsAGS7R0hS/STBMbyIrwsp5ZJEzjiwe7nU6AyiycuZi1kT8+vU
        OpMbsJLQg62D5Y22vRJhmtN7t/Dl7mWY5LW7C6AU=
Received: from lilith.dptechnics.local (178-116-74-88.access.telenet.be [178.116.74.88]) by mx.zohomail.com
        with SMTPS id 1654875004909492.82336920813896; Fri, 10 Jun 2022 08:30:04 -0700 (PDT)
From:   Jonas Maes <jonas@dptechnics.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Jonas Maes <jonas@dptechnics.com>
Subject: [PATCH BlueZ 1/1] Fix bug where bluetooth-meshd stops sending
Date:   Fri, 10 Jun 2022 17:29:02 +0200
Message-Id: <20220610152902.21677-2-jonas@dptechnics.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220610152902.21677-1-jonas@dptechnics.com>
References: <20220610152902.21677-1-jonas@dptechnics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When there is a backlog of mesh packets to be sent, the packet sender
Fix bug where bluetooth-meshd stops sending

When there is a backlog of mesh packets to be sent, the packet sender
incorrectly infers that the tx worker thread is already running
and therefore needn't be invoked. As a result, the mesh daemon will
sometimes stop broadcasting while there are still packets in the queue.
It will not resume broadcasting.

This patch will invoke the tx worker thread correctly in that case.

The logic to send packets at least twice when the transmitter is idle
was slightly modified accordingly, and should behave the same way as
before.

UPDATE: long line split in 2 lines now
---
 mesh/mesh-io-generic.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/mesh/mesh-io-generic.c b/mesh/mesh-io-generic.c
index 50a2a6a86..2d7ef261e 100644
--- a/mesh/mesh-io-generic.c
+++ b/mesh/mesh-io-generic.c
@@ -725,7 +725,6 @@ static bool send_tx(struct mesh_io *io, struct mesh_io_send_info *info,
 {
 	struct mesh_io_private *pvt = io->pvt;
 	struct tx_pkt *tx;
-	bool sending = false;
 
 	if (!info || !data || !len || len > sizeof(tx->pkt))
 		return false;
@@ -739,23 +738,21 @@ static bool send_tx(struct mesh_io *io, struct mesh_io_send_info *info,
 	if (info->type == MESH_IO_TIMING_TYPE_POLL_RSP)
 		l_queue_push_head(pvt->tx_pkts, tx);
 	else {
-		if (pvt->tx)
-			sending = true;
-		else
-			sending = !l_queue_isempty(pvt->tx_pkts);
-
-		l_queue_push_tail(pvt->tx_pkts, tx);
-
 		/*
 		 * If transmitter is idle, send packets at least twice to
 		 * guard against in-line cancelation of HCI command chain.
 		 */
-		if (info->type == MESH_IO_TIMING_TYPE_GENERAL && !sending &&
-							tx->info.u.gen.cnt == 1)
+		if (info->type == MESH_IO_TIMING_TYPE_GENERAL &&
+					!pvt->tx &&
+					l_queue_isempty(pvt->tx_pkts) &&
+					tx->info.u.gen.cnt == 1)
 			tx->info.u.gen.cnt++;
+
+		l_queue_push_tail(pvt->tx_pkts, tx);
 	}
 
-	if (!sending) {
+    /* If not already sending, schedule the tx worker */
+	if (!pvt->tx) {
 		l_timeout_remove(pvt->tx_timeout);
 		pvt->tx_timeout = NULL;
 		l_idle_oneshot(tx_worker, pvt, NULL);
-- 
2.35.1

