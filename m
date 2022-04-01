Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311B7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Apr 2022 07:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343949AbiDAHso (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Apr 2022 03:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343943AbiDAHso (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Apr 2022 03:48:44 -0400
Received: from mxout03.lancloud.ru (mxout03.lancloud.ru [45.84.86.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD5025F65A
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Apr 2022 00:46:52 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 7403E20A7B7F
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Ildar Kamaletdinov <i.kamaletdinov@omp.ru>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Ildar Kamaletdinov <i.kamaletdinov@omp.ru>
Subject: [PATCH BlueZ 7/7] gatt: Fix double free and freed memory dereference
Date:   Fri, 1 Apr 2022 10:46:40 +0300
Message-ID: <20220401074640.3956695-8-i.kamaletdinov@omp.ru>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220401074640.3956695-1-i.kamaletdinov@omp.ru>
References: <20220401074640.3956695-1-i.kamaletdinov@omp.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1910.lancloud.ru (fd00:f066::80)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In condition where device no longer exist or not paired when sending
notification it is possible to to occure double free and dereference of
already freed memory.

To avoid this we need to recheck the state of device after sending
notification.

Found by Linux Verification Center (linuxtesting.org) with the SVACE
static analysis tool.
---
 src/gatt-database.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index d6c94058c..d32f616a9 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -3877,6 +3877,10 @@ void btd_gatt_database_server_connected(struct btd_gatt_database *database,
 
 	send_notification_to_device(state, state->pending);
 
+	state = find_device_state(database, &bdaddr, bdaddr_type);
+	if (!state || !state->pending)
+		return;
+
 	free(state->pending->value);
 	free(state->pending);
 	state->pending = NULL;
-- 
2.34.0

