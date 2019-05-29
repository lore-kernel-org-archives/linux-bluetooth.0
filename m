Return-Path: <SRS0=mLwb=T5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877FAC28CC0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 May 2019 12:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB1B20665
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 May 2019 12:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWHdphVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfE2MOL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 May 2019 08:14:11 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:37399 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfE2MOK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 May 2019 08:14:10 -0400
Received: by mail-ed1-f50.google.com with SMTP id w37so3462881edw.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 May 2019 05:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SJa36yPDhsNmkNDMwhqfa+9YipPE75TgdRJ3n4aL3cs=;
        b=KWHdphVDXI/ExggsxfGapmwGoS1RfHZeC7E9eFK8bAJ6VWLaeK3x0bX7paWcXaY+3Z
         ZNM8JNBySr0c0k82yiAzQETlff4Gceo/XStvhyTChpllLZ5ShSQ1tNEMMoQgGHZAdvSB
         6fbd/bA7tJ2n9sLzlvO0bW7KcJKYKejT0q48PnQOWAHY94QVUHA8jU4lUmnEYvG7ZAO8
         kdFodilKVBt9YSEi5XUMEQbccSrtmhZap2jBOI0gEFJx2ithplehoKGio+CwJm9Yke8q
         C0Zi1cDmtrRZLb3JBGIYPt34wrUkex4OL3rV2rNQLa6SxPVLfVK2nmDJTtBjtCHMcjgL
         R3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SJa36yPDhsNmkNDMwhqfa+9YipPE75TgdRJ3n4aL3cs=;
        b=BbmITBU7tgU2isfPR4HYsRBVfUusGKH9VGXUOJLdx0NcUtZLOA39uliAgg1JFdzjvL
         LbGg/sVYOfD8Y9hoQdbvkhDNl2Eve11USNGa4SYMAWM/Iize4tT0uDQlNYvEjm57Aqvj
         uoXNdJhfo9VFgGTz3LOh4MhuEeu87YuoMgsXRqaA28XY+TrUu0cbTK41FKSoEQcbHavt
         0sZIzd6qIohi1t/zERg2XJ1WCGvGMgR3zmd33l3NAxn7uULBQ09JnaGFOsFS2FIyUojm
         o8DK9eojebskfEnjYa1KQpakQdwddiH5X1g/CZ8eyljLbEa/o2xTy8NOpY86S2vo2+8Q
         1ZeQ==
X-Gm-Message-State: APjAAAVuEWShCKKsxU4NbhPMlfcdRbee1r1BDObgetjPiGdUR/0eQXXu
        f9OJx4BwiXM6UvLW6plfsswPf06N6Lk=
X-Google-Smtp-Source: APXvYqxdaxCdgINLzksvcL+VUF0iranhG/kLfh+zOxIePSzrt156yfat1jhTyM2/8ZpEMqintr/XsQ==
X-Received: by 2002:a50:cac1:: with SMTP id f1mr131023040edi.97.1559132048217;
        Wed, 29 May 2019 05:14:08 -0700 (PDT)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id g18sm5113381edh.13.2019.05.29.05.14.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 29 May 2019 05:14:07 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] main.conf: Make ReverseServiceDiscovery work with LE
Date:   Wed, 29 May 2019 15:14:05 +0300
Message-Id: <20190529121405.18357-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes ReverseServiceDiscovery work properly with LE connection by
disabling the GATT client functionality which makes one able to setup a
system to operate in peripheral role only mode.
---
 src/device.c  | 9 +++++++--
 src/hcid.h    | 2 +-
 src/main.c    | 4 ++--
 src/main.conf | 8 +++++---
 4 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/src/device.c b/src/device.c
index 8ddfa28ff..263f60aea 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4933,6 +4933,11 @@ static void gatt_client_init(struct btd_device *device)
 {
 	gatt_client_cleanup(device);
 
+	if (!device->connect && !main_opts.reverse_discovery) {
+		DBG("Reverse service discovery disabled: skipping GATT client");
+		return;
+	}
+
 	device->client = bt_gatt_client_new(device->db, device->att,
 							device->att_mtu);
 	if (!device->client) {
@@ -5814,7 +5819,7 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 		bonding_request_free(bonding);
 	} else if (!state->svc_resolved) {
 		if (!device->browse && !device->discov_timer &&
-				main_opts.reverse_sdp) {
+				main_opts.reverse_discovery) {
 			/* If we are not initiators and there is no currently
 			 * active discovery or discovery timer, set discovery
 			 * timer */
@@ -5858,7 +5863,7 @@ unsigned int device_wait_for_svc_complete(struct btd_device *dev,
 
 	dev->svc_callbacks = g_slist_prepend(dev->svc_callbacks, cb);
 
-	if (state->svc_resolved || !main_opts.reverse_sdp)
+	if (state->svc_resolved || !main_opts.reverse_discovery)
 		cb->idle_id = g_idle_add(svc_idle_cb, cb);
 	else if (dev->discov_timer > 0) {
 		g_source_remove(dev->discov_timer);
diff --git a/src/hcid.h b/src/hcid.h
index 1eb3c5ac2..adea85ce2 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -43,7 +43,7 @@ struct main_opts {
 	uint32_t	discovto;
 	uint8_t		privacy;
 
-	gboolean	reverse_sdp;
+	gboolean	reverse_discovery;
 	gboolean	name_resolv;
 	gboolean	debug_keys;
 	gboolean	fast_conn;
diff --git a/src/main.c b/src/main.c
index 696728320..1a6ab36a3 100644
--- a/src/main.c
+++ b/src/main.c
@@ -367,7 +367,7 @@ static void parse_config(GKeyFile *config)
 		DBG("%s", err->message);
 		g_clear_error(&err);
 	} else
-		main_opts.reverse_sdp = boolean;
+		main_opts.reverse_discovery = boolean;
 
 	boolean = g_key_file_get_boolean(config, "General",
 						"NameResolving", &err);
@@ -456,7 +456,7 @@ static void init_defaults(void)
 	main_opts.class = 0x000000;
 	main_opts.pairto = DEFAULT_PAIRABLE_TIMEOUT;
 	main_opts.discovto = DEFAULT_DISCOVERABLE_TIMEOUT;
-	main_opts.reverse_sdp = TRUE;
+	main_opts.reverse_discovery = TRUE;
 	main_opts.name_resolv = TRUE;
 	main_opts.debug_keys = FALSE;
 
diff --git a/src/main.conf b/src/main.conf
index b2f843c75..40687a755 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -30,9 +30,11 @@
 #DeviceID = bluetooth:1234:5678:abcd
 
 # Do reverse service discovery for previously unknown devices that connect to
-# us. This option is really only needed for qualification since the BITE tester
-# doesn't like us doing reverse SDP for some test cases (though there could in
-# theory be other useful purposes for this too). Defaults to 'true'.
+# us. For BR/EDR this option is really only needed for qualification since the
+# BITE tester doesn't like us doing reverse SDP for some test cases, for LE
+# this disables the GATT client functionally so it can be used in system which
+# can only operate as peripheral.
+# Defaults to 'true'.
 #ReverseServiceDiscovery = true
 
 # Enable name resolving after inquiry. Set it to 'false' if you don't need
-- 
2.21.0

