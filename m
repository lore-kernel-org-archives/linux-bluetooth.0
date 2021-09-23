Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7CEC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 08:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BE146105A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 08:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239796AbhIWIUD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Sep 2021 04:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237996AbhIWIUD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Sep 2021 04:20:03 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1956C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Sep 2021 01:18:30 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id bk33-20020a05620a1a2100b00432fff50d40so17622238qkb.22
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Sep 2021 01:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=NFX6Ufy+PjGqIutBE11cXvd0RCatvytpDZW36kTyeco=;
        b=TGPvUBiovLcaiT2B17XYwtJyzN5p50V2YN8nyd2FJ2XAXOts/3AJaJX6aad6E5GUgX
         YI9l4fFmapSUdlXrbkskRMdERalK3DiqV1QOWkB6iXKDEU37XhJLhQZNkAVXmzxQzjBO
         zwbyY912WyaAWnmicL9hNOLF5xSsnH1lPnQxw7Y+oC6miwJXxljIm5pjxZUiONvp1Ykq
         SMwAmHvaO2ySAuqs3WuRZAHMW/x/YpIdYFYmJEgp3KKwh1K85QG/8UmCCMIMMlFDCUd4
         qrB2yGVIpMK/yzhUUWptGn98/EWi8pmbnYkiODVO7xbeMC08jSK6xCi3oSSn84J+ILDu
         U+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=NFX6Ufy+PjGqIutBE11cXvd0RCatvytpDZW36kTyeco=;
        b=4VCFnVEgafcFGJK62XLk0rcasRPwf3sbGGmN6GE8thr9ga2Md6ZGu8DYqk0bqndTLs
         6pcaX88mSLoepW/dtEHHISAmKOs8oJ4uFiitqd0ALSttV20HlP2Bno/l5SDuYk51xWOF
         3bLQXTF7BQj1AAMQg1x3fVS1hGrFhWZe9afJ9nkI/Gu+4jU/GDSCCyDcWNFOLsYQW8JF
         pmzktQBX2FcqMQYzekG/wtFhWcD1JfpMR5liK7H1SYHE+l/4q47/t3v66ZnQqVRkEpOz
         k4r5j20UXOigQlJaSZV1QhqfM97LsnRbrfriL2R90YxwQoNgsajQY0xmXfqq5fFevIHj
         mYYw==
X-Gm-Message-State: AOAM530RyjH/SwPHCzXYLW3U7/Mx1Ian59z87HadyqO0MWWe5LnIRrM/
        lf6sMwTbEbs/aYvhr3JN/19bW1Voqu6EdEwU5DHyiwGUwxBoxtsx0RfjmRBEj7HmqFYmf0J+RyZ
        Fq4yZzXIDbaDtHAzU7eWScdJP0Bmdai8gvITboyr7LGONM3AiNUyv4CyFAkLjrqdmmG4Umge11B
        cS
X-Google-Smtp-Source: ABdhPJyGWoypS6ZreWutg82iyNGbAIVC19gKFWo9t1rKqZUQOXnBCBVp0Q03EtFazMDQfdrHygZCqloQPYNx
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:c4cc:423b:7aee:e088])
 (user=apusaka job=sendgmr) by 2002:a05:6902:124f:: with SMTP id
 t15mr4249206ybu.161.1632385109679; Thu, 23 Sep 2021 01:18:29 -0700 (PDT)
Date:   Thu, 23 Sep 2021 16:18:23 +0800
Message-Id: <20210923161816.Bluez.1.I2d4be6229452939310ccd165bc949c0f6708dd20@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [Bluez PATCH] device: Check both bearers's paired status upon removal
 of connection
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Because Link Key for BREDR can be transformed into LTK for LE (and
vice versa), there is a possibility of getting 'paired' on either of
BREDR/LE without actually connected using the aforementioned bearer.

When removing the connection, we should check both bearers's paired
and bonded status rather than just the one getting disconnected.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

 src/device.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/src/device.c b/src/device.c
index b29aa195d1..6a66fc9a23 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3010,6 +3010,7 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
 	struct bearer_state *state = get_state(device, bdaddr_type);
 	DBusMessage *reply;
 	bool remove_device = false;
+	bool paired_status_updated = false;
 
 	if (!state->connected)
 		return;
@@ -3048,18 +3049,33 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
 		dbus_message_unref(msg);
 	}
 
-	if (state->paired && !state->bonded) {
-		btd_adapter_remove_bonding(device->adapter, &device->bdaddr,
-								bdaddr_type);
-
-		state->paired = false;
-
-		/* report change only if both bearers are unpaired */
-		if (!device->bredr_state.paired && !device->le_state.paired)
-			g_dbus_emit_property_changed(dbus_conn, device->path,
-							DEVICE_INTERFACE,
-							"Paired");
-	}
+	/* Check paired status of both bearers since it's possible to be
+	 * paired but not connected via link key to LTK conversion.
+	 */
+	if (!device->bredr_state.connected && device->bredr_state.paired &&
+						!device->bredr_state.bonded) {
+		btd_adapter_remove_bonding(device->adapter,
+						&device->bdaddr,
+						BDADDR_BREDR);
+		device->bredr_state.paired = false;
+		paired_status_updated = true;
+	}
+
+	if (!device->le_state.connected && device->le_state.paired &&
+						!device->le_state.bonded) {
+		btd_adapter_remove_bonding(device->adapter,
+						&device->bdaddr,
+						device->bdaddr_type);
+		device->le_state.paired = false;
+		paired_status_updated = true;
+	}
+
+	/* report change only if both bearers are unpaired */
+	if (!device->bredr_state.paired && !device->le_state.paired &&
+							paired_status_updated)
+		g_dbus_emit_property_changed(dbus_conn, device->path,
+						DEVICE_INTERFACE,
+						"Paired");
 
 	if (device->bredr_state.connected || device->le_state.connected)
 		return;
-- 
2.33.0.464.g1972c5931b-goog

