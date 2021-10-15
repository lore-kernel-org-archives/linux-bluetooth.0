Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C381C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Oct 2021 05:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7214F611C3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Oct 2021 05:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbhJOFLl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Oct 2021 01:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235357AbhJOFLl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Oct 2021 01:11:41 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F955C061753
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Oct 2021 22:09:35 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n11so5681158plf.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Oct 2021 22:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AePu4jDw8vHfpqCCbcIKyprS1+J+zFV+kSsnf1glXXw=;
        b=dUGZ/7fId+yAP7/QILMyWiTFeZGkk47+p73GxGQVztGdgwSWbAlfZKQCjbuWzh1eII
         i3uRur7Y1ShamPR0Or3OSeI0yVlhOBzYt4r/Y/zhoMJfit7SM0NpSOpaqPMuJIsb9e51
         R4Xwbr6IjxCTeOnZhFL4lKhhvCkijC7LRyN8BYou7uM6mC7sPc6lRT7/CCaviPWO4TMW
         X7LfMdZS3AefmqF97B8DNcQ+/VkVcMkE7IdI+tso+yN3VLYlgM5IsuFtHpagdfnf2oZp
         vMuBK0Rk1yzDxA+gM47azqkADs5wmfAcnTT7LJFmIKrxx1itbKz4rNWL/iF/J72lUMdp
         MfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AePu4jDw8vHfpqCCbcIKyprS1+J+zFV+kSsnf1glXXw=;
        b=VCvRlG99h7QtaavOU44IMOreyKUBbbkCml6yxoR//cghW4KgVjKAjK1iBFgd+4U5lA
         4EEc5n9865InhkkRm14+nUCj2Vov6D7TYubOFjAeW50KPlFZsVFBzdfDvYqCt72D5aEa
         py4+SvWEcVrZLkGOxk6GXzsYJr5Bv7IeniX7P2fwAdm/o03aMhLPE2Gp2y0H75HvbIOj
         3uAd6yuYTa71tsAx2+XbWDIns+ySe9yYHLhqXyy8+P0oxBu8SADiWnJqLKjoZuQMrjYg
         LjOJkz3Mf/47lJUhdZOj+9khhOKyhMzUn5Ai293izvDOw3OUDCslpECwQpdN7FFGVb7y
         ZaPw==
X-Gm-Message-State: AOAM532iK1x7lunAhFSbssC22K4bUNbr1ROoX0hyVwd3E60TGJ/8BGcI
        0uizKeSnafnoMklksJxHjSiiw64GaA0=
X-Google-Smtp-Source: ABdhPJwtz2AIK7MLK8ete6lp9COFxgx94m7YLyxT9BFCJUxT33NDiDZFxg/yMbALP2GsUNCebhDIuw==
X-Received: by 2002:a17:90b:1806:: with SMTP id lw6mr11130133pjb.222.1634274574551;
        Thu, 14 Oct 2021 22:09:34 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p17sm10347510pju.34.2021.10.14.22.09.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 22:09:34 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/7] vhci: Read the controller index
Date:   Thu, 14 Oct 2021 22:09:25 -0700
Message-Id: <20211015050929.3130100-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211015050929.3130100-1-luiz.dentz@gmail.com>
References: <20211015050929.3130100-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes vhci instance read its controller index assigned by the
kernel and also introduces vhci_get_btdev so it can be used by the
likes of hciemu.
---
 emulator/main.c | 12 ++++----
 emulator/vhci.c | 75 +++++++++++++++++++++++++++++--------------------
 emulator/vhci.h | 11 ++------
 3 files changed, 54 insertions(+), 44 deletions(-)

diff --git a/emulator/main.c b/emulator/main.c
index aa269c3f0..f64d46a5e 100644
--- a/emulator/main.c
+++ b/emulator/main.c
@@ -17,12 +17,14 @@
 #include <stdlib.h>
 #include <stdbool.h>
 #include <getopt.h>
+#include <sys/uio.h>
 
 #include "src/shared/mainloop.h"
 #include "src/shared/util.h"
 
 #include "serial.h"
 #include "server.h"
+#include "btdev.h"
 #include "vhci.h"
 #include "amp.h"
 #include "le.h"
@@ -90,7 +92,7 @@ int main(int argc, char *argv[])
 	int letest_count = 0;
 	int amptest_count = 0;
 	int vhci_count = 0;
-	enum vhci_type vhci_type = VHCI_TYPE_BREDRLE;
+	enum btdev_type type = BTDEV_TYPE_BREDRLE52;
 	int i;
 
 	mainloop_init();
@@ -120,13 +122,13 @@ int main(int argc, char *argv[])
 				vhci_count = 1;
 			break;
 		case 'L':
-			vhci_type = VHCI_TYPE_LE;
+			type = BTDEV_TYPE_LE;
 			break;
 		case 'B':
-			vhci_type = VHCI_TYPE_BREDR;
+			type = BTDEV_TYPE_BREDR;
 			break;
 		case 'A':
-			vhci_type = VHCI_TYPE_AMP;
+			type = BTDEV_TYPE_AMP;
 			break;
 		case 'U':
 			if (optarg)
@@ -182,7 +184,7 @@ int main(int argc, char *argv[])
 	for (i = 0; i < vhci_count; i++) {
 		struct vhci *vhci;
 
-		vhci = vhci_open(vhci_type);
+		vhci = vhci_open(type);
 		if (!vhci) {
 			fprintf(stderr, "Failed to open Virtual HCI device\n");
 			return EXIT_FAILURE;
diff --git a/emulator/vhci.c b/emulator/vhci.c
index 33f674d79..28cdef633 100644
--- a/emulator/vhci.c
+++ b/emulator/vhci.c
@@ -29,10 +29,8 @@
 #include "btdev.h"
 #include "vhci.h"
 
-#define uninitialized_var(x) x = x
-
 struct vhci {
-	enum vhci_type type;
+	enum btdev_type type;
 	int fd;
 	struct btdev *btdev;
 };
@@ -91,32 +89,22 @@ bool vhci_set_debug(struct vhci *vhci, vhci_debug_func_t callback,
 	return btdev_set_debug(vhci->btdev, callback, user_data, destroy);
 }
 
-struct vhci *vhci_open(enum vhci_type type)
+struct vhci_create_req {
+	uint8_t  pkt_type;
+	uint8_t  opcode;
+} __attribute__((packed));
+
+struct vhci_create_rsp {
+	uint8_t  pkt_type;
+	uint8_t  opcode;
+	uint16_t index;
+} __attribute__((packed));
+
+struct vhci *vhci_open(uint8_t type)
 {
 	struct vhci *vhci;
-	enum btdev_type uninitialized_var(btdev_type);
-	unsigned char uninitialized_var(ctrl_type);
-	unsigned char setup_cmd[2];
-	static uint8_t id = 0x23;
-
-	switch (type) {
-	case VHCI_TYPE_BREDRLE:
-		btdev_type = BTDEV_TYPE_BREDRLE52;
-		ctrl_type = HCI_PRIMARY;
-		break;
-	case VHCI_TYPE_BREDR:
-		btdev_type = BTDEV_TYPE_BREDR;
-		ctrl_type = HCI_PRIMARY;
-		break;
-	case VHCI_TYPE_LE:
-		btdev_type = BTDEV_TYPE_LE;
-		ctrl_type = HCI_PRIMARY;
-		break;
-	case VHCI_TYPE_AMP:
-		btdev_type = BTDEV_TYPE_AMP;
-		ctrl_type = HCI_AMP;
-		break;
-	}
+	struct vhci_create_req req;
+	struct vhci_create_rsp rsp;
 
 	vhci = malloc(sizeof(*vhci));
 	if (!vhci)
@@ -131,16 +119,33 @@ struct vhci *vhci_open(enum vhci_type type)
 		return NULL;
 	}
 
-	setup_cmd[0] = HCI_VENDOR_PKT;
-	setup_cmd[1] = ctrl_type;
+	memset(&req, 0, sizeof(req));
+	req.pkt_type = HCI_VENDOR_PKT;
 
-	if (write(vhci->fd, setup_cmd, sizeof(setup_cmd)) < 0) {
+	switch (type) {
+	case BTDEV_TYPE_AMP:
+		req.opcode = HCI_AMP;
+		break;
+	default:
+		req.opcode = HCI_PRIMARY;
+		break;
+	}
+
+	if (write(vhci->fd, &req, sizeof(req)) < 0) {
+		close(vhci->fd);
+		free(vhci);
+		return NULL;
+	}
+
+	memset(&rsp, 0, sizeof(rsp));
+
+	if (read(vhci->fd, &rsp, sizeof(rsp)) < 0) {
 		close(vhci->fd);
 		free(vhci);
 		return NULL;
 	}
 
-	vhci->btdev = btdev_create(btdev_type, id++);
+	vhci->btdev = btdev_create(type, rsp.index);
 	if (!vhci->btdev) {
 		close(vhci->fd);
 		free(vhci);
@@ -167,3 +172,11 @@ void vhci_close(struct vhci *vhci)
 
 	mainloop_remove_fd(vhci->fd);
 }
+
+struct btdev *vhci_get_btdev(struct vhci *vhci)
+{
+	if (!vhci)
+		return NULL;
+
+	return vhci->btdev;
+}
diff --git a/emulator/vhci.h b/emulator/vhci.h
index 7dfea25df..0554121e8 100644
--- a/emulator/vhci.h
+++ b/emulator/vhci.h
@@ -11,13 +11,6 @@
 
 #include <stdint.h>
 
-enum vhci_type {
-	VHCI_TYPE_BREDRLE,
-	VHCI_TYPE_BREDR,
-	VHCI_TYPE_LE,
-	VHCI_TYPE_AMP,
-};
-
 struct vhci;
 
 typedef void (*vhci_debug_func_t)(const char *str, void *user_data);
@@ -25,5 +18,7 @@ typedef void (*vhci_destroy_func_t)(void *user_data);
 bool vhci_set_debug(struct vhci *vhci, vhci_debug_func_t callback,
 			void *user_data, vhci_destroy_func_t destroy);
 
-struct vhci *vhci_open(enum vhci_type type);
+struct vhci *vhci_open(uint8_t type);
 void vhci_close(struct vhci *vhci);
+
+struct btdev *vhci_get_btdev(struct vhci *vhci);
-- 
2.31.1

