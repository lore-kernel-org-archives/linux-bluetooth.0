Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85A2C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Nov 2022 15:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbiKIPSH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Nov 2022 10:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbiKIPSG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Nov 2022 10:18:06 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E242B1CFD5
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Nov 2022 07:18:05 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 338171C000F
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Nov 2022 15:18:03 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ 1/2] hostname: Add '' around printed strings
Date:   Wed,  9 Nov 2022 16:17:55 +0100
Message-Id: <20221109151756.96673-1-hadess@hadess.net>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Otherwise we can't see whether the string is nul, or empty.
---
 plugins/hostname.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/plugins/hostname.c b/plugins/hostname.c
index 1a9513adb..14b6450b5 100644
--- a/plugins/hostname.c
+++ b/plugins/hostname.c
@@ -128,7 +128,7 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 
 			dbus_message_iter_get_basic(iter, &str);
 
-			DBG("pretty hostname: %s", str);
+			DBG("pretty hostname: '%s'", str);
 
 			g_free(pretty_hostname);
 			pretty_hostname = g_strdup(str);
@@ -146,7 +146,7 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 
 			dbus_message_iter_get_basic(iter, &str);
 
-			DBG("static hostname: %s", str);
+			DBG("static hostname: '%s'", str);
 
 			g_free(static_hostname);
 			static_hostname = g_strdup(str);
@@ -165,7 +165,7 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 
 			dbus_message_iter_get_basic(iter, &str);
 
-			DBG("chassis: %s", str);
+			DBG("chassis: '%s'", str);
 
 			for (i = 0; chassis_table[i].chassis; i++) {
 				if (strcmp(chassis_table[i].chassis, str))
-- 
2.37.3

