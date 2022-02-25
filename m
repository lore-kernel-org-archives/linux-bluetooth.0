Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC8FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Feb 2022 21:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbiBYVzl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Feb 2022 16:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiBYVzk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Feb 2022 16:55:40 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96775218CC0
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Feb 2022 13:55:07 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id z16so5841178pfh.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Feb 2022 13:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=efSHLIuyp9nORYTDxZrbN9z7MaGl1mVXIcp2UWETDz4=;
        b=Oej3QimVm9eIDBp5unTRXMn7paE9FM8BDnzjz2QZkoDxppq37oCS69BzV7V8cojuuP
         okrPV5FfXMfyH38lPDBeamr2UDFRYfEsB+s866/74Gaeo5hX69dQQ8xB8W/3l2qolOIa
         x933hxvat+NcstlSUzMQVjZjK97pVgVYIQO2InUHiNL5upIPKlKYI4cly7FEJFOE/h/z
         BOv52Rqh3t1u4vVnRk7/2bDJlbnuRykJX6I6JWrAFvDGaCRpJ9AYLHfdeK6tZ9nHWxs2
         wBPv2CsG1cdbUaAliViPVQpm+h/e74TFQzUaprFZdLpfz+zpvTqfOS0Rwv8bRjU70f60
         woUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=efSHLIuyp9nORYTDxZrbN9z7MaGl1mVXIcp2UWETDz4=;
        b=ISPVb1NlV1ukWVlLlnMwFzqyT7IuZ7M9O4ywijumrMV5SmWIlInDsQYzLA2egMCwno
         CZ6iUhtlR3cMxylHr8IJt8BpzFvrm9tjEp8rpluyoevwILz9H8nP4YedTwZ2d1jHcQR1
         dhZH36M/5UjYZnGTgsGyjdF1lzlqFQff+Dm2AmR14V7d5Phuy8nLW4+joeauuV7DtB7K
         eRkMWmiZ3m7/6Lcvxe7r774yQyC5USmzFJ5pfcJx7G7xpOZG7hTr0vR1GYenlyCK/2YO
         7gi3cnaldx9iHudDmY06VbAivgU8ZmPojWH34Dn/vaAeG+/7IMxVNQrPwVoLEVtplqeJ
         rUzA==
X-Gm-Message-State: AOAM5337gOpAJMoOzxb+UnGDGGV2pZRHccaz3xcrhD7nDve5iV0i4NNC
        OFf1VzDAjjTNESlkHMX8RcNhkWNnSWU=
X-Google-Smtp-Source: ABdhPJxFFy5mY2Bx2sre9BjASyM4E/vDoXbM2Vai5up6ITsuhjuACzIa0HQXYcDzLQwlZI670Um0uw==
X-Received: by 2002:a63:be0e:0:b0:363:e0be:613f with SMTP id l14-20020a63be0e000000b00363e0be613fmr7719033pgf.448.1645826106791;
        Fri, 25 Feb 2022 13:55:06 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id w17-20020a056a0014d100b004f1063290basm4404082pfu.15.2022.02.25.13.55.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 13:55:06 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] btproxy: Attempt to bind the next index
Date:   Fri, 25 Feb 2022 13:55:05 -0800
Message-Id: <20220225215505.560382-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If no specific index is given attempt to bind the next index if the
current one is already in use.
---
 tools/btproxy.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/btproxy.c b/tools/btproxy.c
index f6143038c..94ca1c7fd 100644
--- a/tools/btproxy.c
+++ b/tools/btproxy.c
@@ -47,8 +47,9 @@ struct sockaddr_hci {
 	unsigned short  hci_channel;
 };
 #define HCI_CHANNEL_USER	1
+#define HCI_INDEX_NONE		0xffff
 
-static uint16_t hci_index = 0;
+static uint16_t hci_index = HCI_INDEX_NONE;
 static bool client_active = false;
 static bool debug_enabled = false;
 static bool emulate_ecc = false;
@@ -535,9 +536,12 @@ static bool setup_proxy(int host_fd, bool host_shutdown,
 static int open_channel(uint16_t index)
 {
 	struct sockaddr_hci addr;
-	int fd;
+	int fd, err;
+
+	if (index == HCI_INDEX_NONE)
+		index = 0;
 
-	printf("Opening user channel for hci%u\n", hci_index);
+	printf("Opening user channel for hci%u\n", index);
 
 	fd = socket(PF_BLUETOOTH, SOCK_RAW | SOCK_CLOEXEC, BTPROTO_HCI);
 	if (fd < 0) {
@@ -551,7 +555,16 @@ static int open_channel(uint16_t index)
 	addr.hci_channel = HCI_CHANNEL_USER;
 
 	if (bind(fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		err = -errno;
 		close(fd);
+
+		/* Open next available controller if no specific index was
+		 * provided and the error indicates that the controller.
+		 */
+		if (hci_index == HCI_INDEX_NONE &&
+				(err == -EBUSY || err == -EUSERS))
+			return open_channel(++index);
+
 		perror("Failed to bind Bluetooth socket");
 		return -1;
 	}
@@ -588,7 +601,7 @@ static void server_callback(int fd, uint32_t events, void *user_data)
 		return;
 	}
 
-	if (client_active) {
+	if (client_active && hci_index != HCI_INDEX_NONE) {
 		fprintf(stderr, "Active client already present\n");
 		close(host_fd);
 		return;
-- 
2.35.1

