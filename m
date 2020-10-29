Return-Path: <SRS0=NHH5=EE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8FDC4742C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 21:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 157C320838
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 21:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqJHBjH1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbgJ2Vwr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Oct 2020 17:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgJ2Vwr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Oct 2020 17:52:47 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC45C0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 14:52:45 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id e15so3506988pfh.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 14:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t/yjb0YfL4ynVylnSPYAzuysKOPZZiBeMqQRxevbg2U=;
        b=UqJHBjH1K7odCjOpP/8V8YwXrXCxmCiXM7lZIbPLObrAXb5nXxRa3RjDkPDsEjyz6T
         LcCkt7SCpNYdXx7Gv/Y5HTMTynqCWfObYBFnz2UpKJ0CYapOJOefTsyEA700Ga94oNvP
         zIT0HngF3z9UQ5Xo+BDJp1Yul6F++m2Fm78CDTmbUZeeFl63g7yYxiPztOL1ekcwC6dC
         VRPRH7M65TBkZKT/wl+LrMPnSw8v10SyqTNbzEXMVAbTEtdSuicaX9pYzXYdzDlt9IhX
         AOrLPBZpxH6WRSDysLFcVRQPWI1D9VG1CXSWIlN4t5zy9evH/6tHPTGVYs6eKc/6V5m3
         hy5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t/yjb0YfL4ynVylnSPYAzuysKOPZZiBeMqQRxevbg2U=;
        b=fVY1N9Ufgq26GKnXmZDyVIA6UNLeQz+31zHSEaNS66JZZR/P1uDARX55IFftJAYpeR
         JBAQVfiZ9RNEDrtvqliTdFIhbVPF5D9GUw6WiRJW4JMw2/T4IsUD7PdEuMoN5P8rBRCT
         wsjVIZuA98wQNznfwD4mterTFvJDiRuC+VVCjnvSSgEb6V7b6lf81S+eVyOADpnsgwj3
         hgS+zEyrYAR1c2aQsVdcK5MyZFPJjttfwVDd7ViG+OQ3PeyLpbeTDp4T9g5fMRkclN1p
         H/+B3Z7a529iPGzRrceTGuklskZzmxmbttjYs++MQZuTx3PXfi25LPb/086C+XiYTe/D
         vN8A==
X-Gm-Message-State: AOAM5309To3E23C5tKXr2bA145asUnjtPjr+4wVzs+CwyyZudKn4cZht
        RoLSKptLAxtjW8rhlTsIiHuVro12m+B1ag==
X-Google-Smtp-Source: ABdhPJw+nltezJy0YJtjgF1ZjqRybY9gsPz5cZnIuoTN40fikpvKJJEeKpBiyE8K52nUrEfbghyyVA==
X-Received: by 2002:a62:34c7:0:b029:15d:e9de:f618 with SMTP id b190-20020a6234c70000b029015de9def618mr6139216pfa.58.1604008364979;
        Thu, 29 Oct 2020 14:52:44 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id lw12sm780572pjb.5.2020.10.29.14.52.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 14:52:44 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] emulator/btdev: Add debug support
Date:   Thu, 29 Oct 2020 14:52:41 -0700
Message-Id: <20201029215243.888555-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds btdev_set_debug which can be used to debug internals of
btdev.
---
 emulator/btdev.c | 83 ++++++++++++++++++++++++------------------------
 emulator/btdev.h |  5 +++
 2 files changed, 46 insertions(+), 42 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index ca87681a6..8844c9193 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -144,6 +144,10 @@ struct btdev {
 	uint8_t  sync_train_service_data;
 
 	uint16_t le_ext_adv_type;
+
+	btdev_debug_func_t debug_callback;
+	btdev_destroy_func_t debug_destroy;
+	void *debug_data;
 };
 
 struct inquiry_data {
@@ -257,45 +261,6 @@ static inline struct btdev *find_btdev_by_bdaddr_type(const uint8_t *bdaddr,
 	return NULL;
 }
 
-static void hexdump(const unsigned char *buf, uint16_t len)
-{
-	static const char hexdigits[] = "0123456789abcdef";
-	char str[68];
-	uint16_t i;
-
-	if (!len)
-		return;
-
-	for (i = 0; i < len; i++) {
-		str[((i % 16) * 3) + 0] = hexdigits[buf[i] >> 4];
-		str[((i % 16) * 3) + 1] = hexdigits[buf[i] & 0xf];
-		str[((i % 16) * 3) + 2] = ' ';
-		str[(i % 16) + 49] = isprint(buf[i]) ? buf[i] : '.';
-
-		if ((i + 1) % 16 == 0) {
-			str[47] = ' ';
-			str[48] = ' ';
-			str[65] = '\0';
-			printf("%-12c%s\n", ' ', str);
-			str[0] = ' ';
-		}
-	}
-
-	if (i % 16 > 0) {
-		uint16_t j;
-		for (j = (i % 16); j < 16; j++) {
-			str[(j * 3) + 0] = ' ';
-			str[(j * 3) + 1] = ' ';
-			str[(j * 3) + 2] = ' ';
-			str[j + 49] = ' ';
-		}
-		str[47] = ' ';
-		str[48] = ' ';
-		str[65] = '\0';
-		printf("%-12c%s\n", ' ', str);
-	}
-}
-
 static void get_bdaddr(uint16_t id, uint8_t index, uint8_t *bdaddr)
 {
 	bdaddr[0] = id & 0xff;
@@ -768,6 +733,22 @@ void btdev_destroy(struct btdev *btdev)
 	free(btdev);
 }
 
+bool btdev_set_debug(struct btdev *btdev, btdev_debug_func_t callback,
+			void *user_data, btdev_destroy_func_t destroy)
+{
+	if (!btdev)
+		return false;
+
+	if (btdev->debug_destroy)
+		btdev->debug_destroy(btdev->debug_data);
+
+	btdev->debug_callback = callback;
+	btdev->debug_destroy = destroy;
+	btdev->debug_data = user_data;
+
+	return true;
+}
+
 const uint8_t *btdev_get_bdaddr(struct btdev *btdev)
 {
 	return btdev->bdaddr;
@@ -824,9 +805,20 @@ void btdev_set_send_handler(struct btdev *btdev, btdev_send_func handler,
 static void send_packet(struct btdev *btdev, const struct iovec *iov,
 								int iovlen)
 {
+	int i;
+
 	if (!btdev->send_handler)
 		return;
 
+	for (i = 0; i < iovlen; i++) {
+		if (!i)
+			util_hexdump('<', iov[i].iov_base, iov[i].iov_len,
+				btdev->debug_callback, btdev->debug_data);
+		else
+			util_hexdump(' ', iov[i].iov_base, iov[i].iov_len,
+				btdev->debug_callback, btdev->debug_data);
+	}
+
 	btdev->send_handler(iov, iovlen, btdev->send_data);
 }
 
@@ -3952,8 +3944,8 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	return;
 
 unsupported:
-	printf("Unsupported command 0x%4.4x\n", opcode);
-	hexdump(data, len);
+	util_debug(btdev->debug_callback, btdev->debug_data,
+			"Unsupported command 0x%4.4x\n", opcode);
 	cmd_status(btdev, BT_HCI_ERR_UNKNOWN_COMMAND, opcode);
 }
 
@@ -4267,6 +4259,9 @@ static void process_cmd(struct btdev *btdev, const void *data, uint16_t len)
 	callback.data = data + sizeof(*hdr);
 	callback.len = hdr->plen;
 
+	util_debug(btdev->debug_callback, btdev->debug_data,
+				"command 0x%04x", callback.opcode);
+
 	if (btdev->command_handler)
 		btdev->command_handler(callback.opcode,
 					callback.data, callback.len,
@@ -4331,6 +4326,9 @@ void btdev_receive_h4(struct btdev *btdev, const void *data, uint16_t len)
 	if (len < 1)
 		return;
 
+	util_hexdump('>', data, len, btdev->debug_callback,
+					btdev->debug_data);
+
 	pkt_type = ((const uint8_t *) data)[0];
 
 	switch (pkt_type) {
@@ -4348,7 +4346,8 @@ void btdev_receive_h4(struct btdev *btdev, const void *data, uint16_t len)
 			send_iso(btdev->conn, data, len);
 		break;
 	default:
-		printf("Unsupported packet 0x%2.2x\n", pkt_type);
+		util_debug(btdev->debug_callback, btdev->debug_data,
+				"Unsupported packet 0x%2.2x\n", pkt_type);
 		break;
 	}
 }
diff --git a/emulator/btdev.h b/emulator/btdev.h
index 7cb265f1c..f7cba149a 100644
--- a/emulator/btdev.h
+++ b/emulator/btdev.h
@@ -66,6 +66,11 @@ struct btdev;
 struct btdev *btdev_create(enum btdev_type type, uint16_t id);
 void btdev_destroy(struct btdev *btdev);
 
+typedef void (*btdev_debug_func_t)(const char *str, void *user_data);
+typedef void (*btdev_destroy_func_t)(void *user_data);
+bool btdev_set_debug(struct btdev *btdev, btdev_debug_func_t callback,
+			void *user_data, btdev_destroy_func_t destroy);
+
 const uint8_t *btdev_get_bdaddr(struct btdev *btdev);
 uint8_t *btdev_get_features(struct btdev *btdev);
 
-- 
2.26.2

