Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244AAC4332B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Jan 2021 19:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02F9C22D58
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Jan 2021 19:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732367AbhAZFcu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728597AbhAZBbv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Jan 2021 20:31:51 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0652CC061A86
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Jan 2021 17:11:43 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id o16so540517pgg.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Jan 2021 17:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rd61baDo1O8agTqfKzI1LVnjDA9xt1ECM38/G+bIWJ4=;
        b=RzKcQ5oVCP6kxQQptiP4bMvEGBoaa3Dg0+VkY9pws24AaEmhezUUF4Z2GlgxYYoHiW
         qFhWGsI+HAmtQjzCO//8uQOA1mMG1Vc8CakpiPRdhgNCQTFATBCT5HfoUsL52bAK0nba
         Xt/r2ptbey0nQ4w3NJLV/ieiiSWuYAKaAqWj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rd61baDo1O8agTqfKzI1LVnjDA9xt1ECM38/G+bIWJ4=;
        b=YIoYLxpYNkBqO0ZioleiiQn2KOUJdua9P/VgvU+OVamqpLQXHGFzyiL8vvragEidWW
         bMVx504umLUaURcHMP7kLTrIuENp4v/oWGsN8oYqWQXsiYU8sqyrKMc3Fj3XxxNYG8dL
         IYBtwZ2/Lj42y4uwXvL8MkQqAxMlQ2iAB6bZi8Xle/Jly17c7ZPHSNw++kj2zkHD1Buo
         kJB2WRJb+wXhxqFiAvEYx7KmIhJzwAw2Q3amVjQuhomqHghcg1hBZRbB2INZk1poWlFi
         Yg6/EewF1IqvmNIadSy8D4NT1nF8a8oO5a8PFI8gRtlB2Oe1eMv9CxLNg4SN2BgMPMVD
         V9Pg==
X-Gm-Message-State: AOAM533O6Acq3rEJRxMQcmKQTJF4b5cgEnrJmiWhlexESSiI5hUgdYX7
        itr7YKaEhMHqo2HbF5RnUH9HS5srrmTM0A==
X-Google-Smtp-Source: ABdhPJw6DT2NVWSz/fwB+JVdInE0tl/SKLYNLx3U4Xbe0bxAPCVPrCpvq95Z3ieNEEblaQkxYhyfHw==
X-Received: by 2002:aa7:909a:0:b029:1bc:22d3:9e58 with SMTP id i26-20020aa7909a0000b02901bc22d39e58mr2837675pfa.29.1611623502288;
        Mon, 25 Jan 2021 17:11:42 -0800 (PST)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:7c08:2ccf:8f7c:2eed])
        by smtp.gmail.com with ESMTPSA id d76sm17776543pfd.193.2021.01.25.17.11.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2021 17:11:41 -0800 (PST)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH BlueZ] input/hog: Fix crashes of UAF of hog->attr
Date:   Mon, 25 Jan 2021 17:11:30 -0800
Message-Id: <20210126011130.5233-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

hog->attr does not own pointer, so it may be invalid when hog object
gets re-attached at bt_hog_attach(). To solve this, this patch
intentionally clears hog->attr at bt_hog_detach() to mark it as invalid
so that it can be repopulated with the valid pointer at bt_hog_attach().
The same applies to all sub-instances.

Sample stack trace:
* thread #1, stop reason = signal SIGSEGV
  * frame #0: 0x05ad49f2 bluetoothd`<name omitted> at gatt-db.c:1428
    frame #1: 0x05a91922 bluetoothd`bt_hog_attach at hog-lib.c:1694
    frame #2: 0x05a9160e bluetoothd`hog_accept at hog.c:212
    frame #3: 0x05ab4784 bluetoothd`service_accept at service.c:203
    frame #4: 0x05aba1e6 bluetoothd`device_attach_att at device.c:4542
    frame #5: 0x05a9c4a2 bluetoothd`connect_cb at gatt-database.c:656
    frame #6: 0x05a98e8c bluetoothd`server_cb at btio.c:264
    frame #7: 0xec8e6a1a libglib-2.0.so.0`g_main_context_dispatch at gmain.c:3325
    frame #8: 0xec8e6c58 libglib-2.0.so.0`g_main_context_iterate at gmain.c:4119
    frame #9: 0xec8e6e52 libglib-2.0.so.0`g_main_loop_run at gmain.c:4317
    frame #10: 0x05ad582e bluetoothd`mainloop_run at mainloop-glib.c:79
    frame #11: 0x05ad5a64 bluetoothd`mainloop_run_with_signal at mainloop-notify.c:201
    frame #12: 0x05ac35ac bluetoothd`main at main.c:1103
    frame #13: 0xec6ed0a2 libc.so.6`__libc_start_main at libc-start.c:308

---
 profiles/input/hog-lib.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 1f132aa4c..7d1ea53bd 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -1651,12 +1651,19 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
 bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 {
 	GSList *l;
+	bt_uuid_t uuid;
 
 	if (hog->attrib)
 		return false;
 
 	hog->attrib = g_attrib_ref(gatt);
 
+	if (!hog->attr && hog->gatt_db) {
+		bt_uuid16_create(&uuid, HOG_UUID16);
+		gatt_db_foreach_service(hog->gatt_db, &uuid,
+					foreach_hog_service, hog);
+	}
+
 	if (!hog->attr && !hog->primary) {
 		discover_primary(hog, hog->attrib, NULL, primary_cb, hog);
 		return true;
@@ -1744,6 +1751,14 @@ void bt_hog_detach(struct bt_hog *hog)
 		bt_hog_detach(instance);
 	}
 
+	/* hog->attr doesn't own pointer, so it may be invalid when this hog
+	 * object gets re-attached with bt_hog_attach(). So intentionally mark
+	 * it as invalid and remove all instances so that the instances can be
+	 * re-attached at bt_hog_attach().
+	 */
+	hog->attr = NULL;
+	g_slist_free_full(hog->instances, hog_free);
+
 	for (l = hog->reports; l; l = l->next) {
 		struct report *r = l->data;
 
-- 
2.29.2

