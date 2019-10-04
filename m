Return-Path: <SRS0=a/5L=X5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19383C4360C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Oct 2019 05:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9ED22133F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Oct 2019 05:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="NNamySZa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731603AbfJDFnr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Oct 2019 01:43:47 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41523 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731524AbfJDFnr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Oct 2019 01:43:47 -0400
Received: by mail-lf1-f66.google.com with SMTP id r2so3550503lfn.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Oct 2019 22:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lXdBVZqEttn0Ybzz7whd5WOsCciO5jy6QL5YDPoKVqw=;
        b=NNamySZaJnRiSpXLN89llK48vMrLcSHgDYtaKirpkKjMUspTIZOybVOvgH/eLQGoku
         XMJImcY13DS79vYYPqPKmrSIULSCpRudW3MGWbLtOBDn32XzY0rU/eWTxToBp2lBMR6x
         9VT9XlUbOXVpbryFjlExKWj2VdNtdaH8sCbyXGxUVl13sOF74xV5R+tvjthyvl9zOuGZ
         XsijQKKBiHbQ0J25vj05tIEt+oIVvhdBmhKcKhzC/MU6x+3l8QRHs7cxjxoUYeAEGaYe
         BV5PIOCxvQwFgI9+kQLKfD3rT9ok8I3S7xSQ3pqxAJIr+eVLPsFUn5Mms9r4pzZ+E4Ks
         +7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lXdBVZqEttn0Ybzz7whd5WOsCciO5jy6QL5YDPoKVqw=;
        b=tcraBPlwzkYuqjULHTRsw/vha4U6zUn1X+WtpHJ2CULQ1rIAUGEkfnJStL2tsyF05B
         acreE4/vC3edTYGZLXy+Nl1+S4jq7uGD9RSn0Kc+K8hiPL70fjNyESgfimsgygkL9mkE
         QikpYMTLo11FhU9B5hKmP40rovn2LhWGmbsGZ8qBtPl7TUJgk7dW3weUMHLP7T6GrDyn
         /fI0OKIDc2vChM2myNh7pcfDnnOvEzRF0I1+X4DoVONTmBc+c7lZX+Ged9hXrr33NLUe
         wW1rsy/ZjmhTXbXYzPJWJCtT+wRP+I/JWnUFxaIlokM3UEKinCYbyGA+Nb+IodfNgH5C
         cujA==
X-Gm-Message-State: APjAAAXz7T7abrecKHF3aTz734FRvILafmgxB6ITdcoLKvu/VSDDbI+T
        QHXbobpNB21+MJ0UVejZyWJ/TqvJZqE=
X-Google-Smtp-Source: APXvYqy7pE/1XxclOYMvLwgLp9q2O6stodGgRoGW9A6sErHl1veu52Dgkt8yx9YH4igTQBjCSV9Dxw==
X-Received: by 2002:a19:7715:: with SMTP id s21mr7579694lfc.98.1570167822988;
        Thu, 03 Oct 2019 22:43:42 -0700 (PDT)
Received: from ix.int.codecoup.pl ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id q88sm1024828lje.57.2019.10.03.22.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 22:43:42 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH V3 2/3] monitor: Add interface for J-Link library
Date:   Fri,  4 Oct 2019 07:43:33 +0200
Message-Id: <20191004054334.5479-2-szymon.janc@codecoup.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191004054334.5479-1-szymon.janc@codecoup.pl>
References: <20191004054334.5479-1-szymon.janc@codecoup.pl>
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
index 000000000..afa9d9323
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
+	if (strlen(tok))
+		serial_no = atoi(tok);
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

