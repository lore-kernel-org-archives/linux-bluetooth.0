Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDB7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 May 2022 15:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446574AbiEGPLF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 7 May 2022 11:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446607AbiEGPLA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 7 May 2022 11:11:00 -0400
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7824B25289
        for <linux-bluetooth@vger.kernel.org>; Sat,  7 May 2022 08:07:05 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 5B4B52097CDC
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Ildar Kamaletdinov <i.kamaletdinov@omp.ru>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Ildar Kamaletdinov <i.kamaletdinov@omp.ru>
Subject: [PATCH BlueZ 4/4] device: Fix uninitialized value usage
Date:   Sat, 7 May 2022 18:06:57 +0300
Message-ID: <20220507150657.28240-5-i.kamaletdinov@omp.ru>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220507150657.28240-1-i.kamaletdinov@omp.ru>
References: <20220507150657.28240-1-i.kamaletdinov@omp.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1910.lancloud.ru (fd00:f066::80)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Definitely `dbus_bool_t b;` must be initialized before comparing it
with current value.

Found by Linux Verification Center (linuxtesting.org) with the SVACE
static analysis tool.
---
 src/device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 6da5c380b..7114e1b3e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1568,6 +1568,8 @@ static void dev_property_set_wake_allowed(const GDBusPropertyTable *property,
 		return;
 	}
 
+	dbus_message_iter_get_basic(value, &b);
+
 	/* Emit busy or success depending on current value. */
 	if (b == device->pending_wake_allowed) {
 		if (device->wake_allowed == device->pending_wake_allowed)
@@ -1580,7 +1582,6 @@ static void dev_property_set_wake_allowed(const GDBusPropertyTable *property,
 		return;
 	}
 
-	dbus_message_iter_get_basic(value, &b);
 	device_set_wake_override(device, b);
 	device_set_wake_allowed(device, b, id);
 }
-- 
2.35.3

