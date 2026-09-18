Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com [74.125.227.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43877515890
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 16:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789748071; cv=none; b=D6ynmzLLZvp85CvBtVDviS7c9ywiCjME4BDVtNy0k+QvHY3U/8gMrakDyI16tOf/uHM3LL1KT61kkbUgaehiAN/h1y54vN8uFK6LgPilfTXXz1BLi7J1IYBr3JHdAQrQv5gyKXbX3OcuHqKEpyQSnSDVsqm9xQNOj6aFPzzvKU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789748071; c=relaxed/simple;
	bh=mZhQJYXCJ3SksMmKUNhOqB5Vde32Ffzu6fFJfRtdcTA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSOMmAT45lf0+m4xY4WtkfeXfi579TwyrYUHlhSktcx1p4lpfSkoURDNYPWZj+xi4JqaOj+hX1qTdB+12VWbs5bJ4eAAR+U1WV3sStNm7Ryc9C11Te7aeQocNotOEsXVN/YSSdCDwlYTleEoH+89es6yqqolf61sy4S5NXqa+3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ruIN3zTi; arc=none smtp.client-ip=74.125.227.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ruIN3zTi"
Received: by mail-vs2-f41.google.com with SMTP id ada2fe7eead31-78564319a92so264050137.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 09:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789748067; x=1790352867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2HSmg9KAdLUpovy1PFOuCIWQ1f/EUXfkajtYdqg1o5g=;
        b=ruIN3zTiRdlxYoy/dE5zPQwsH1P1Q99xdAvv2+6OK92jBR3JT373z9WBVAWb4f8YwS
         ki43MDXfyLuN7RQtRof1CZJK/MsRRBLQqC6MYaZlcipO2c2u7DgNF2/KwbCX4GKyMO0E
         86e1ny61fZFkfyifLQ/yrTHkp8ARRrPRORiG+SXklQXy6Luu+f/xBHJ7bI9sQu1+en+L
         eF8ALgPltSvmNj8PWiI30jGun8yllicaV99PqiSXqG8Pp1tGMLZaJPAUXa6criJ5fzsg
         df2iV+q2sZhOwm3tKyL4YtzKtCiXehb3mtpCIUNwOvyDfh/t1b3qozT2RhudwbM2xTCE
         pcNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789748067; x=1790352867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2HSmg9KAdLUpovy1PFOuCIWQ1f/EUXfkajtYdqg1o5g=;
        b=13o9sHsQ3rdji/FhZNZEBAETX3g023uFYxxdRL2UdLXRZFIxPYDuTWMWRVC8Pe6hY8
         AcNudP6DRo+nA7OPE+3VNXjIieZvDSAVFM3nb0/3n5hB4Rn8KNHyLK7y277+xwx+1NyW
         x8jiiHsoeYE/oU5SVD33TlCeFjVRYTVez0lGdlJc3pCKgJskMr84WlpUyHI2jec/Iiiy
         gdmflW7hBXDVhzEQafioLDG7zI0KRSk3Fz3S6VJkFsEAVqK5MggASmwAkSspspjm6Tat
         uRk85NOTjH6t1owd8cYWJgnw31vgfl7ZVI+0Xo0aM7fKcUk7hYNAy4Hbbkv85yPLdxic
         sEng==
X-Gm-Message-State: AFuF++keoPpTqHaG4pZ1MLCl/giUkmdVCJcgFk7dOQ/UbVjKJPpVAmLD
	7FE5LQ65osRLYDkxnx3WDmPYkLuQ5QkbUnDLlclUscP9X5FLRDv7ExX1K7mgo7Ri
X-Gm-Gg: AYBFou3Etdy15Lvd/iw1++r1xDZxvTZsORDgQlgndvv6MzKW+Rb32Y1qAg1RVtuoXEw
	RzK+pmqcIQnhzUQ/ht3LJedMq7nWTZ2NoNhtebeSLOV2bhPj8zDWJrLF1FKxrI6SWmipS7BsAWM
	HrJ5ED3UCfFIXa/RTMIPVOa5mI9YI4IJXuw1wLeoRe2Nu5uCBJSbe/GM21eGHODawW4/5lrrX3/
	vA7583RxCQXySsvWDGrZhEDV9LLWwEIecgWsaMz2sbioWabmUbzvVP7r0GvFHbZr+oGQ27XdGOD
	c7rnAdI7ibKXbvaQ/jTVApW22I3VNvfR+9UKsQW3i2TSsiSWC13OyGt22eVjUJ5fJpTQcBl6Isg
	n9HD01WQF7S3JpGJWbeQ2aGsn+vyLweJWGM5nxPmTizHNsmN4E4ulB3+YMVv5OX+UE8zt7CHEno
	aLr8KTgZIg0YhQqy+gPaQzLWsSM6cNGzusI7l/1dNglELp+AYSod1RWcsT5LtTPgchmpTSL9/+q
	FxqX0AfOH6tuaU5gvWCyBoR77wRmQx1fp6+/E59e7/wNRBAZvI6lgcDyUthRbXw
X-Received: by 2002:a05:6102:6896:b0:7a1:f7d2:e842 with SMTP id ada2fe7eead31-7a55d28b47cmr1329616137.18.1789748066638;
        Fri, 18 Sep 2026 09:14:26 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7a59c569181sm2104078137.11.2026.09.18.09.14.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 09:14:25 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 5/9] monitor: Separate the frames for a pager reading records
Date: Fri, 18 Sep 2026 12:14:04 -0400
Message-ID: <20260918161408.2464981-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918161408.2464981-1-luiz.dentz@gmail.com>
References: <20260918161408.2464981-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

A frame spans several lines, so a pager that works on records rather than
lines has no way of telling where one ends. Feeding a trace to fzf with
--read0 makes the whole of it a single entry, and without --read0 each
line becomes an entry of its own, so searching finds the line reporting
an error without the header saying which controller, handle and time it
belongs to.

Separate the frames with a NUL when the pager is going to read records,
which is asked for either by --print0 or by --read0 already being in
PAGER:

  $ PAGER='fzf --read0' btmon -r hcidump.log
  $ btmon -r hcidump.log --print0 | fzf --read0

Nothing is separated unless it was asked for, so the output is unchanged
for a pager reading lines, which would otherwise show the separator as a
stray character between the frames.

Assisted-by: opencode:claude-opus-5
---
 Makefile.tools    |   1 +
 monitor/control.c |  15 ++++++
 monitor/find.c    | 128 ++++++++++++++++++++++++++++++++++++++++++++++
 monitor/find.h    |  19 +++++++
 monitor/main.c    |  15 +++++-
 5 files changed, 177 insertions(+), 1 deletion(-)
 create mode 100644 monitor/find.c
 create mode 100644 monitor/find.h

diff --git a/Makefile.tools b/Makefile.tools
index 6844a52ac739..671b40fb0e42 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -58,6 +58,7 @@ monitor_btmon_SOURCES = monitor/main.c monitor/bt.h \
 				monitor/jlink.h monitor/jlink.c \
 				monitor/tty.h monitor/emulator.h \
 				monitor/att.h monitor/att.c \
+				monitor/find.h monitor/find.c \
 				src/log.h src/log.c \
 				src/textfile.h src/textfile.c \
 				src/settings.h src/settings.c
diff --git a/monitor/control.c b/monitor/control.c
index bff70c0cce75..b07cb3bd5e2b 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -39,6 +39,7 @@
 #include "src/shared/mainloop.h"
 
 #include "display.h"
+#include "find.h"
 #include "packet.h"
 #include "hcidump.h"
 #include "ellisys.h"
@@ -973,8 +974,10 @@ static void data_callback(int fd, uint32_t events, void *user_data)
 
 		switch (data->channel) {
 		case HCI_CHANNEL_CONTROL:
+			find_frame_begin();
 			packet_control(tv, cred, index, opcode,
 							data->buf, pktlen);
+			find_frame_end();
 			break;
 		case HCI_CHANNEL_MONITOR:
 			if (pktlen > (len - MGMT_HDR_SIZE))
@@ -984,8 +987,10 @@ static void data_callback(int fd, uint32_t events, void *user_data)
 							data->buf, pktlen);
 			ellisys_inject_hci(tv, index, opcode,
 							data->buf, pktlen);
+			find_frame_begin();
 			packet_monitor(tv, cred, index, opcode,
 							data->buf, pktlen);
+			find_frame_end();
 			break;
 		}
 	}
@@ -1131,8 +1136,10 @@ static void kmsg_callback(int fd, uint32_t events, void *user_data)
 
 	btsnoop_write_hci(btsnoop_file, &tv, HCI_DEV_NONE,
 				BTSNOOP_OPCODE_SYSTEM_NOTE, 0, msg, len);
+	find_frame_begin();
 	packet_monitor(&tv, NULL, HCI_DEV_NONE,
 				BTSNOOP_OPCODE_SYSTEM_NOTE, msg, len);
+	find_frame_end();
 }
 
 static int open_kmsg(void)
@@ -1179,8 +1186,10 @@ static void client_callback(int fd, uint32_t events, void *user_data)
 		opcode = le16_to_cpu(hdr->opcode);
 		index = le16_to_cpu(hdr->index);
 
+		find_frame_begin();
 		packet_monitor(NULL, NULL, index, opcode,
 					data->buf + MGMT_HDR_SIZE, pktlen);
+		find_frame_end();
 
 		data->offset -= pktlen + MGMT_HDR_SIZE;
 
@@ -1399,8 +1408,10 @@ static void process_data(struct control_data *data)
 					hdr->ext_hdr + hdr->hdr_len, pktlen);
 		ellisys_inject_hci(tv, 0, opcode, hdr->ext_hdr + hdr->hdr_len,
 					pktlen);
+		find_frame_begin();
 		packet_monitor(tv, NULL, 0, opcode,
 					hdr->ext_hdr + hdr->hdr_len, pktlen);
+		find_frame_end();
 
 		data->offset -= 2 + data_len;
 
@@ -1586,7 +1597,9 @@ void control_reader(const char *path, bool pager)
 			if (opcode == 0xffff)
 				continue;
 
+			find_frame_begin();
 			packet_monitor(&tv, NULL, index, opcode, buf, pktlen);
+			find_frame_end();
 			ellisys_inject_hci(&tv, index, opcode, buf, pktlen);
 		}
 		break;
@@ -1599,7 +1612,9 @@ void control_reader(const char *path, bool pager)
 								buf, &pktlen))
 				break;
 
+			find_frame_begin();
 			packet_simulator(&tv, frequency, buf, pktlen);
+			find_frame_end();
 		}
 		break;
 	}
diff --git a/monitor/find.c b/monitor/find.c
new file mode 100644
index 000000000000..649d722ee197
--- /dev/null
+++ b/monitor/find.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2026  Intel Corporation
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include "monitor/display.h"
+#include "monitor/find.h"
+
+static bool enabled;
+static bool records;	/* Separate the frames with a NUL */
+static bool printed;	/* Something has been written out already */
+static bool print0;
+
+static char *capture_buf;
+static size_t capture_len;
+static FILE *capture;
+
+void find_set_print0(void)
+{
+	print0 = true;
+}
+
+/*
+ * A frame spans several lines, so a pager that works on records rather
+ * than lines has to be told where one ends. The request is already in
+ * PAGER, so take it from there as well as from the command line.
+ */
+static bool want_records(void)
+{
+	const char *pager;
+
+	if (print0)
+		return true;
+
+	pager = getenv("PAGER");
+
+	return pager && strstr(pager, "--read0");
+}
+
+void find_setup(void)
+{
+	records = want_records();
+
+	/*
+	 * Nothing is kept, but the output still has to be seen to know
+	 * where one frame ends and the next begins.
+	 */
+	if (records)
+		enabled = true;
+}
+
+void find_frame_begin(void)
+{
+	if (!enabled)
+		return;
+
+	capture_buf = NULL;
+	capture_len = 0;
+
+	capture = open_memstream(&capture_buf, &capture_len);
+	if (!capture)
+		return;
+
+	display_set_output(capture);
+}
+
+void find_frame_end(void)
+{
+	if (!enabled || !capture)
+		return;
+
+	display_set_output(NULL);
+	fclose(capture);
+	capture = NULL;
+
+	/* A frame that was filtered out produces no output */
+	if (!capture_len) {
+		free(capture_buf);
+		capture_buf = NULL;
+		return;
+	}
+
+	if (records) {
+		const char nul = '\0';
+		size_t len = capture_len;
+
+		/*
+		 * The newline ending the frame is what separates the lines
+		 * within it, so leave it out of a record or it shows as a
+		 * blank line at the end of the entry.
+		 */
+		if (len && capture_buf[len - 1] == '\n')
+			len--;
+
+		if (printed)
+			fwrite(&nul, 1, 1, stdout);
+
+		fwrite(capture_buf, 1, len, stdout);
+	} else {
+		fwrite(capture_buf, 1, capture_len, stdout);
+	}
+
+	fflush(stdout);
+	printed = true;
+
+	free(capture_buf);
+	capture_buf = NULL;
+}
+
+void find_cleanup(void)
+{
+	enabled = false;
+}
diff --git a/monitor/find.h b/monitor/find.h
new file mode 100644
index 000000000000..c6b2036ba3a6
--- /dev/null
+++ b/monitor/find.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2026  Intel Corporation
+ *
+ *
+ */
+
+#include <stdbool.h>
+
+void find_set_print0(void);
+void find_setup(void);
+
+void find_frame_begin(void);
+void find_frame_end(void);
+
+void find_cleanup(void);
diff --git a/monitor/main.c b/monitor/main.c
index dc37294c5c27..ce7bae7f5cae 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -31,6 +31,7 @@
 #include "ellisys.h"
 #include "control.h"
 #include "display.h"
+#include "find.h"
 
 static void signal_callback(int signum, void *user_data)
 {
@@ -69,6 +70,8 @@ static void usage(void)
 		"\t-I, --iso              Dump ISO traffic\n"
 		"\t-E, --ellisys [ip]     Send Ellisys HCI Injection\n"
 		"\t-P, --no-pager         Disable pager usage\n"
+		"\t-0, --print0           Separate frames with a NUL, for a\n"
+		"\t                       pager reading records\n"
 		"\t-J  --jlink <device>,[<serialno>],[<interface>],[<speed>]\n"
 		"\t                       Read data from RTT\n"
 		"\t-R  --rtt [<address>],[<area>],[<name>]\n"
@@ -98,6 +101,7 @@ static const struct option main_options[] = {
 	{ "iso",       no_argument,       NULL, 'I' },
 	{ "ellisys",   required_argument, NULL, 'E' },
 	{ "no-pager",  no_argument,       NULL, 'P' },
+	{ "print0",    no_argument,       NULL, '0' },
 	{ "jlink",     required_argument, NULL, 'J' },
 	{ "rtt",       required_argument, NULL, 'R' },
 	{ "columns",   required_argument, NULL, 'C' },
@@ -133,7 +137,7 @@ int main(int argc, char *argv[])
 		struct sockaddr_un addr;
 
 		opt = getopt_long(argc, argv,
-				"r:w:a:s:p:i:d:B:V:MKNtTSAIE:PJ:R:C:c:vh",
+				"r:w:a:s:p:i:d:B:V:MKNtTSAIE:P0J:R:C:c:vh",
 				main_options, NULL);
 		if (opt < 0)
 			break;
@@ -217,6 +221,9 @@ int main(int argc, char *argv[])
 		case 'P':
 			use_pager = false;
 			break;
+		case '0':
+			find_set_print0();
+			break;
 		case 'J':
 			jlink = optarg;
 			break;
@@ -279,6 +286,8 @@ int main(int argc, char *argv[])
 		if (ellisys_server)
 			ellisys_enable(ellisys_server, ellisys_port);
 
+		find_setup();
+
 		control_reader(reader_path, use_pager);
 		return EXIT_SUCCESS;
 	}
@@ -300,8 +309,12 @@ int main(int argc, char *argv[])
 	if (jlink && control_rtt(jlink, rtt) < 0)
 		return EXIT_FAILURE;
 
+	find_setup();
+
 	exit_status = mainloop_run_with_signal(signal_callback, NULL);
 
+	find_cleanup();
+
 	keys_cleanup();
 
 	return exit_status;
-- 
2.55.0

