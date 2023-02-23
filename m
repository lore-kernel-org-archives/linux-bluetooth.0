Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9A4C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Feb 2023 19:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjBWTS3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Feb 2023 14:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjBWTS3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Feb 2023 14:18:29 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911157AB6
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Feb 2023 11:17:56 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 38D1B2406C4
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Feb 2023 20:14:46 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PN2lT5HYWz9rxH;
        Thu, 23 Feb 2023 20:14:45 +0100 (CET)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] device: wait GATT client ready before service accept() if no cache
Date:   Thu, 23 Feb 2023 19:14:44 +0000
Message-Id: <6387d20af8252ea1198c81afe728a9f67cd6bf77.1677179059.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On device ATT attach, do not immediately call accept() for profiles, if
there is no cached data in GATT database. Instead, wait for service
resolution to complete, as likely accept() cannot succeed before that.

Several profiles (bap, vcp, midi, deviceinfo) assume that GATT
attributes are available when their accept() is called, returning
success even if not.  In this case, the services never find the remote
attributes and are not operable.  Other profiles (hog, batt, ...) fail
their accept which prompts core to retry after discovery, and work
correctly also in this case.

Fix the failing services by waiting for service resolution as necessary,
so profiles can assume the GATT DB has some content.
---

Notes:
    This fixes the issue with BAP client being broken when there is no GATT
    cache.
    
    On my setup, btd_settings_gatt_db_load often fails with EIO, even though
    the files are there. Apparently, in some cases the saved cache data is
    not loadable, need to figure out later why it happens.

 src/device.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/device.c b/src/device.c
index 28b93eb9a..d270421cc 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5155,10 +5155,11 @@ static void gatt_client_init(struct btd_device *device)
 	g_attrib_attach_client(device->attrib, device->client);
 
 	/*
-	 * Notify notify existing service about the new connection so they can
-	 * react to notifications while discovering services
+	 * If we have cache, notify existing service about the new connection
+	 * so they can react to notifications while discovering services
 	 */
-	device_accept_gatt_profiles(device);
+	if (!gatt_db_isempty(device->db))
+		device_accept_gatt_profiles(device);
 
 	device->gatt_ready_id = bt_gatt_client_ready_register(device->client,
 							gatt_client_ready_cb,
-- 
2.39.2

