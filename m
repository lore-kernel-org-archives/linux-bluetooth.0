Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF489C433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Jan 2021 06:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9574464DC4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Jan 2021 06:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhA1Gjz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Jan 2021 01:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhA1Gjx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Jan 2021 01:39:53 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C775C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jan 2021 22:39:13 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id m6so3376591pfk.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jan 2021 22:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QtwsPaMPoT2nuohE1Nsiyx6iLrV6QyMIYSjUhf+SD8g=;
        b=mgh+Uiw3ZwBiSLZhQRyC3sAQBXsZdQTiz0KhID5U0riGG6r789JxUJbQB/ug5zLiX4
         iMWz9DDy6gl/262dUeYxJIN39DlKSTB6vGLL8M21qFzmPSiAs5ZAg9vv6OK89v6jwFCw
         XYC3ZldAhWRTcNlv53HMzskZ3pdkNFTWJ9URo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QtwsPaMPoT2nuohE1Nsiyx6iLrV6QyMIYSjUhf+SD8g=;
        b=IKclvnlj+FcU8d4QLKYkPPk9z7C4/vitY8/u8C1wAzoCOs24vJDxj7IzCRvmJFSyCW
         V+Me6v9Hr9HV4UXD2okbkapl7BWDLZZRpCA1g66vR+1xAglKjL8RBRJkdLOJiSe4HxdV
         dDFVT9c1nlW7n733AQ0J8jOo9uTkuZLsbi9WzeCkn+fOR8P3+jaDfLHrEOZrL2f+Wutx
         IO5fSRDiyarU2Sj1OBu/eO4dIHn9G+t5WERd1WAOr0GsZftYw/vzYQ6x+A/s5tqZld7V
         SwFTLaqjtP9Vdzpt/N8v2Zgl4c9mC2gFlY8fBRJUFYRVLiIZNzKjiUhkKO2dI+l3Glsq
         T7Fg==
X-Gm-Message-State: AOAM5333QzYGC6TK2gu8ZPcW/n/I1+bQfIMp5uS4kiTI09hpHjpfGrZJ
        ouqR5PH5hMlEc9orgeQDYWQeJs22cyh7Pw==
X-Google-Smtp-Source: ABdhPJwdGAPep3WGUJnh5Tu9BqTJOkNPgJ4hBBW6LJtVgtfJrO0VvKaRtdbTeyzU9e26u1/a+2deJQ==
X-Received: by 2002:a63:48b:: with SMTP id 133mr14891490pge.139.1611815952103;
        Wed, 27 Jan 2021 22:39:12 -0800 (PST)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:3844:c07e:2372:ef64])
        by smtp.gmail.com with ESMTPSA id v19sm3575145pjg.50.2021.01.27.22.39.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 22:39:11 -0800 (PST)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH BlueZ v2] input/hog: Fix crashes of UAF of hog->attr
Date:   Wed, 27 Jan 2021 22:39:01 -0800
Message-Id: <20210128063901.1362-1-sonnysasaka@chromium.org>
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
 profiles/input/hog-lib.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 1f132aa4c..711bda73c 100644
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
@@ -1744,6 +1751,15 @@ void bt_hog_detach(struct bt_hog *hog)
 		bt_hog_detach(instance);
 	}
 
+	/* hog->attr doesn't own pointer, so it may be invalid when this hog
+	 * object gets re-attached with bt_hog_attach(). So intentionally mark
+	 * it as invalid and remove all instances so that the instances can be
+	 * re-attached at bt_hog_attach().
+	 */
+	hog->attr = NULL;
+	g_slist_free_full(hog->instances, hog_free);
+	hog->instances = NULL;
+
 	for (l = hog->reports; l; l = l->next) {
 		struct report *r = l->data;
 
-- 
2.29.2

