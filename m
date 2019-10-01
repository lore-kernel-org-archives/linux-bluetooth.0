Return-Path: <SRS0=34D5=X2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641C0ECE587
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Oct 2019 14:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C82B20815
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Oct 2019 14:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="icSYiPho"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388790AbfJAOKD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:10:03 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39403 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388223AbfJAOKD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Oct 2019 10:10:03 -0400
Received: by mail-lf1-f67.google.com with SMTP id 72so9986231lfh.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Oct 2019 07:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7fbNY59KQ3SFIhICq/UcestqwOZ7NUgD7N5WPbYPWbY=;
        b=icSYiPhoM6U2dsZZ+OV03RC9O9d/0PWeB0tA+X1MiNDscKAilmP1rOxs5HAJ79e7cl
         HONGAiAvtpUUO2k8BSVJNz8ZT/ln0Qco7EgnpFbcQJvKYtrB2TtFNyTPUJbuq7rM9hcb
         aIErqXrT6+PWudKWOqOZ0/bzZwDgK1UJTZXeW7Prn+hRvqMp9k3Zeqg+7/E3o7ANRzIU
         /cEHXSyrQ/GMXOR6vUuyIfDpGfmMg0ltYQUiUMekOlXnS9/NcHaiT7344tb8cPdPO5BS
         DYmMTBKG6KmH06OADarLadNEwzHK+H7XllBNG1S7FSymyAVTB0pBeTL1Eyrp8HdUb7WH
         f0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7fbNY59KQ3SFIhICq/UcestqwOZ7NUgD7N5WPbYPWbY=;
        b=WCMCY+1TWxGQ0K+Lavc2G3xoSexzcoMuY9LzvMrtGyY4jxkYCtmRlfT7QqKx79Pz4O
         IRT2AEl8lvNiPDJijG5LcACYi5NCNb9p/1s+Zlt8Q5DQlCXkPkyU7FdrIlqbX/3bBLBq
         IkBXxx0zybA1LRQuajg53yKLGIPu2qIa6aTtqBjJjbps5NTRW1Rt9B4k9sGAvyjZzzNs
         YP0zeuFqsbRsyZ3NKHwCUoTKmjkz9wKMJkaPvVT7WSJ8f3OivdyT7ZrZem1J6GsJKIPh
         psC89kvZr5LjAXuzb+C9/hAeeFjbesX//Zf4wbHV0Ka5mVDLq3c9QTVoiFpKxnMZL5/A
         7zEQ==
X-Gm-Message-State: APjAAAWzZIADy00zJsd+8MtnQmwKuni5tD7/l+WUXB+IHlBD4/wBkAau
        ZQtthWisoHj8+rTJTVqmjzIFPQ69Nqc=
X-Google-Smtp-Source: APXvYqy9LNmwbsH1wkIxQ2tpTOS2RPrkyJJ9MpKOu27xGFnkb5z45vMMNjTxgDecLDejJVw8FPBdLA==
X-Received: by 2002:ac2:5e9e:: with SMTP id b30mr14991453lfq.5.1569939000900;
        Tue, 01 Oct 2019 07:10:00 -0700 (PDT)
Received: from ix.int.codecoup.pl ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id k15sm4117794ljg.65.2019.10.01.07.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 07:10:00 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH V2 2/3] monitor: Add interface for J-Link library
Date:   Tue,  1 Oct 2019 16:09:40 +0200
Message-Id: <20191001140941.8005-2-szymon.janc@codecoup.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191001140941.8005-1-szymon.janc@codecoup.pl>
References: <20191001140941.8005-1-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>

This adds simple interface to libjlinkarm.so which will be used to read
data from RTT buffer. It was mostly made by trial and error since there
is no public documentation for this library so it may lack something,
but seems to work fine with few Cortex-M devices I tried.
---
 monitor/jlink.c | 283 ++++++++++++++++++++++++++++++++++++++++++++++++
 monitor/jlink.h |  27 +++++
 2 files changed, 310 insertions(+)
 create mode 100644 monitor/jlink.c
 create mode 100644 monitor/jlink.h

diff --git a/monitor/jlink.c b/monitor/jlink.c
new file mode 100644
index 000000000..956a25159
--- /dev/null
+++ b/monitor/jlink.c
@@ -0,0 +1,283 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2018  Codecoup
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <dlfcn.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include "jlink.h"
+
+#define RTT_CONTROL_START		0
+#define RTT_CONTROL_STOP		1
+#define RTT_CONTROL_GET_DESC		2
+#define RTT_CONTROL_GET_NUM_BUF		3
+#define RTT_CONTROL_GET_STAT		4
+
+#define RTT_DIRECTION_UP		0
+#define RTT_DIRECTION_DOWN		1
+
+static const char * const jlink_so_name[] = {
+	"/usr/lib/libjlinkarm.so",
+	"/usr/lib/libjlinkarm.so.6",
+	"/opt/SEGGER/JLink/libjlinkarm.so",
+	"/opt/SEGGER/JLink/libjlinkarm.so.6",
+};
+
+struct rtt_desc {
+	uint32_t index;
+	uint32_t direction;
+	char name[32];
+	uint32_t size;
+	uint32_t flags;
+};
+
+static struct rtt_desc rtt_desc;
+
+typedef int (*jlink_emu_selectbyusbsn_func) (unsigned int sn);
+typedef int (*jlink_open_func) (void);
+typedef int (*jlink_execcommand_func) (char *in, char *out, int size);
+typedef int (*jlink_tif_select_func) (int);
+typedef void (*jlink_setspeed_func) (long int speed);
+typedef int (*jlink_connect_func) (void);
+typedef unsigned int (*jlink_getsn_func) (void);
+typedef void (*jlink_emu_getproductname_func) (char *out, int size);
+typedef int (*jlink_rtterminal_control_func) (int cmd, void *data);
+typedef int (*jlink_rtterminal_read_func) (int cmd, char *buf, int size);
+
+struct jlink {
+	jlink_emu_selectbyusbsn_func emu_selectbyusbsn;
+	jlink_open_func open;
+	jlink_execcommand_func execcommand;
+	jlink_tif_select_func tif_select;
+	jlink_setspeed_func setspeed;
+	jlink_connect_func connect;
+	jlink_getsn_func getsn;
+	jlink_emu_getproductname_func emu_getproductname;
+	jlink_rtterminal_control_func rtterminal_control;
+	jlink_rtterminal_read_func rtterminal_read;
+};
+
+static struct jlink jlink;
+
+#ifndef NELEM
+#define NELEM(x) (sizeof(x) / sizeof((x)[0]))
+#endif
+
+int jlink_init(void)
+{
+	void *so;
+	unsigned int i;
+
+	for (i = 0; i < NELEM(jlink_so_name); i++) {
+		so = dlopen(jlink_so_name[i], RTLD_LAZY);
+		if (so)
+			break;
+	}
+
+	if (!so)
+		return -EIO;
+
+	jlink.emu_selectbyusbsn = dlsym(so, "JLINK_EMU_SelectByUSBSN");
+	jlink.open = dlsym(so, "JLINK_Open");
+	jlink.execcommand = dlsym(so, "JLINK_ExecCommand");
+	jlink.tif_select = dlsym(so, "JLINK_TIF_Select");
+	jlink.setspeed = dlsym(so, "JLINK_SetSpeed");
+	jlink.connect = dlsym(so, "JLINK_Connect");
+	jlink.getsn = dlsym(so, "JLINK_GetSN");
+	jlink.emu_getproductname = dlsym(so, "JLINK_EMU_GetProductName");
+	jlink.rtterminal_control = dlsym(so, "JLINK_RTTERMINAL_Control");
+	jlink.rtterminal_read = dlsym(so, "JLINK_RTTERMINAL_Read");
+
+	if (!jlink.emu_selectbyusbsn || !jlink.open || !jlink.execcommand ||
+			!jlink.tif_select || !jlink.setspeed ||
+			!jlink.connect || !jlink.getsn ||
+			!jlink.emu_getproductname ||
+			!jlink.rtterminal_control || !jlink.rtterminal_read)
+		return -EIO;
+
+	return 0;
+}
+
+int jlink_connect(char *cfg)
+{
+	const char *device = NULL;
+	int tif = 1;
+	unsigned int speed = 1000;
+	unsigned int serial_no = 0;
+	char *tok;
+	char buf[64];
+
+	tok = strtok(cfg, ",");
+	device = tok;
+
+	tok = strtok(NULL, ",");
+	if (!tok)
+		goto connect;
+	if (strlen(tok)) {
+		if (!strcasecmp("swd", tok))
+			tif = 1;
+		else
+			return -EINVAL;
+	}
+
+	tok = strtok(NULL, ",");
+	if (!tok)
+		goto connect;
+	if (strlen(tok))
+		speed = atoi(tok);
+
+	tok = strtok(NULL, ",");
+	if (!tok)
+		goto connect;
+	if (strlen(tok))
+		serial_no = atoi(tok);
+
+connect:
+	if (serial_no)
+		if (jlink.emu_selectbyusbsn(serial_no) < 0) {
+			fprintf(stderr, "Failed to select emu by SN\n");
+			return -ENODEV;
+		}
+
+	if (jlink.open() < 0) {
+		fprintf(stderr, "Failed to open J-Link\n");
+		return -ENODEV;
+	}
+
+	snprintf(buf, sizeof(buf), "device=%s", device);
+	if (jlink.execcommand(buf, NULL, 0) < 0) {
+		fprintf(stderr, "Failed to select target device\n");
+		return -ENODEV;
+	}
+
+	if (jlink.tif_select(tif) < 0) {
+		fprintf(stderr, "Failed to select target interface\n");
+		return -ENODEV;
+	}
+
+	jlink.setspeed(speed);
+
+	if (jlink.connect() < 0) {
+		fprintf(stderr, "Failed to open target\n");
+		return -EIO;
+	}
+
+	serial_no = jlink.getsn();
+	jlink.emu_getproductname(buf, sizeof(buf));
+
+	printf("Connected to %s (S/N: %u)\n", buf, serial_no);
+
+	return 0;
+}
+
+int jlink_start_rtt(char *cfg)
+{
+	unsigned int address = 0;
+	unsigned int area_size = 0;
+	const char *buffer = "btmonitor";
+	char *tok;
+	char cmd[64];
+	int rtt_dir;
+	int count;
+	int i;
+
+	if (!cfg)
+		goto find_rttcb;
+
+	tok = strtok(cfg, ",");
+	if (strlen(tok)) {
+		address = strtol(tok, NULL, 0);
+		area_size = 0x1000;
+	}
+
+	tok = strtok(NULL, ",");
+	if (!tok)
+		goto find_rttcb;
+	if (strlen(tok))
+		area_size = strtol(tok, NULL, 0);
+
+	tok = strtok(NULL, ",");
+	if (!tok)
+		goto find_rttcb;
+	if (strlen(tok))
+		buffer = tok;
+
+find_rttcb:
+	if (address || area_size) {
+		if (!area_size)
+			snprintf(cmd, sizeof(cmd), "SetRTTAddr 0x%x", address);
+		else
+			snprintf(cmd, sizeof(cmd),
+						"SetRTTSearchRanges 0x%x 0x%x",
+						address, area_size);
+
+		if (jlink.execcommand(cmd, NULL, 0) < 0)
+			return -EIO;
+	}
+
+	if (jlink.rtterminal_control(RTT_CONTROL_START, NULL) < 0) {
+		fprintf(stderr, "Failed to initialize RTT\n");
+		return -1;
+	}
+
+	/* RTT may need some time to find control block so we need to wait */
+	do {
+		usleep(100);
+		rtt_dir = RTT_DIRECTION_UP;
+		count = jlink.rtterminal_control(RTT_CONTROL_GET_NUM_BUF,
+								&rtt_dir);
+	} while (count < 0);
+
+	for (i = 0; i < count; i++) {
+		memset(&rtt_desc, 0, sizeof(rtt_desc));
+		rtt_desc.index = i;
+		rtt_desc.direction = RTT_DIRECTION_UP;
+
+		if (jlink.rtterminal_control(RTT_CONTROL_GET_DESC,
+								&rtt_desc) < 0)
+			continue;
+
+		if (rtt_desc.size > 0 && !strcmp(buffer, rtt_desc.name))
+			break;
+	}
+
+	if (i == count)
+		return -ENODEV;
+
+	printf("Using RTT up buffer #%d (size: %d)\n", i, rtt_desc.size);
+
+	return 0;
+}
+
+int jlink_rtt_read(void *buf, size_t size)
+{
+	return jlink.rtterminal_read(rtt_desc.index, buf, size);
+}
diff --git a/monitor/jlink.h b/monitor/jlink.h
new file mode 100644
index 000000000..d7c76704c
--- /dev/null
+++ b/monitor/jlink.h
@@ -0,0 +1,27 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2018  Codecoup
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+int jlink_init(void);
+int jlink_connect(char *cfg);
+int jlink_start_rtt(char *cfg);
+int jlink_rtt_read(void *buf, size_t size);
-- 
2.21.0

