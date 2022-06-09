Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C171C43334
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jun 2022 09:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238364AbiFIJZx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Jun 2022 05:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238397AbiFIJZw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Jun 2022 05:25:52 -0400
Received: from sender4-op-o13.zoho.com (sender4-op-o13.zoho.com [136.143.188.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562C47A83A
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jun 2022 02:25:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1654765844; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=iraJ4h55if8le92v3dSsYETNBwqGm4AQJcosf4YXHJDCo8d07sPTkcCJMYJClOUXfV8fOJGlFlfofkDjpiSFg0WGpCb5buQWP9qt9j9EQG9Hic67xU3wm8ETXozJWXXQMqVCUfmn+oqV5BNtCPnwy5pB6UohUcIcluKWukilph0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1654765844; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=IWF+B3DIlCVfyfSUGRivFZRxPep+w1vQ7RPITZof3wQ=; 
        b=ABQ4vggGwg2d8AUnRajYth/VqrULHt4+cqGfAbFjhICB2aTjRe8bozSx4LXdmEPzATKCu8izvzVG+ATbaUm6s3adxqZsdJb060Jo1X3F6QNC3TU/glIe1cC8f4NN0OXLqt0SceR3uFHqwiMF3SUJJ1lXJePHd05lZ26a+7bhzHU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=dptechnics.com;
        spf=pass  smtp.mailfrom=jonas@dptechnics.com;
        dmarc=pass header.from=<jonas@dptechnics.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1654765844;
        s=zoho; d=dptechnics.com; i=jonas@dptechnics.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=IWF+B3DIlCVfyfSUGRivFZRxPep+w1vQ7RPITZof3wQ=;
        b=Q2YR/OKwelRAqMrRGvmMxc3RksrtSVjEhalShLEx9DNRHU+yZvkMJYT89vxF8hnu
        06rF7UTXfcEyjOPxYso5ilpTjviCFIqho/fN2M4vA3gnx4liH6Hn9IS2uzrKtWiYH/+
        gkwy1UevCeDGA2ggeUdPgfjpWrcDyX6CEsF6s1AA=
Received: from lilith.dptechnics.local (178-116-74-88.access.telenet.be [178.116.74.88]) by mx.zohomail.com
        with SMTPS id 1654765841707981.9104936864159; Thu, 9 Jun 2022 02:10:41 -0700 (PDT)
From:   Jonas Maes <jonas@dptechnics.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Jonas Maes <jonas@dptechnics.com>
Subject: [PATCH BlueZ 1/1] Fix bug where bluetooth-meshd stops sending
Date:   Thu,  9 Jun 2022 11:08:32 +0200
Message-Id: <20220609090832.9945-2-jonas@dptechnics.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220609090832.9945-1-jonas@dptechnics.com>
References: <20220609090832.9945-1-jonas@dptechnics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When there is a backlog of mesh packets to be sent, the packet sender
incorrectly infers that the tx worker thread is already running
and therefore needn't be invoked. As a result, the mesh daemon will
sometimes stop broadcasting while there are still packets in the queue.
It will not resume broadcasting.

This patch will invoke the tx worker thread correctly in that case.

The logic to send packets at least twice when the transmitter is idle
was slightly modified accordingly, and should behave the same way as
before.
---
 mesh/mesh-io-generic.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/mesh/mesh-io-generic.c b/mesh/mesh-io-generic.c
index 50a2a6a86..eed77a7a8 100644
--- a/mesh/mesh-io-generic.c
+++ b/mesh/mesh-io-generic.c
@@ -725,7 +725,6 @@ static bool send_tx(struct mesh_io *io, struct mesh_io_send_info *info,
 {
 	struct mesh_io_private *pvt = io->pvt;
 	struct tx_pkt *tx;
-	bool sending = false;
 
 	if (!info || !data || !len || len > sizeof(tx->pkt))
 		return false;
@@ -739,23 +738,20 @@ static bool send_tx(struct mesh_io *io, struct mesh_io_send_info *info,
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
+		if (info->type == MESH_IO_TIMING_TYPE_GENERAL && !pvt->tx &&
+							l_queue_isempty(pvt->tx_pkts) &&
 							tx->info.u.gen.cnt == 1)
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
2.34.1

