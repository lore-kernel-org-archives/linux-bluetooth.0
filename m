Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9BB38F950
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 20:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677959; cv=none; b=jnj2vSCHTiwN9KA/RCi7jH19nRBCMt6YcwyFFrAzs5Ye0voYEZkVfjCEBl56Dn58QmlVvrw14v+5BnLMLQgzDYpOCIbexisfKjx/jQ3NP6w68/WtNreatrmMxNYu3J7LdTbEz2OK4WQWAaYCoWqPpGumbPoDxDh6Ya0WQlSWnYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677959; c=relaxed/simple;
	bh=l/lrHxuGVQJg/HofRMG2oe+FafUr8+li7s3dw56yZaY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIkkU5FkkMXHpTAEEy3kTdHrT9LhbDrqJoaMXUDsHQBnDpZSmKcB9/RgTqPwUy6kGJhKDqTxkeA21WLrjrxTYaj0CEh0Fwc3JFtVbxidfo0zgrVVoS6OUu5FP0kih8VH3EOcBwzeMBUw2sOj7ZzATqrJDc7De5EIL9UimGPH1UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jh/5l2pX; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jh/5l2pX"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e7c7bac31so756564241.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 13:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789677954; x=1790282754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=p1z55IascskBSFplI6tSA8bIFyC9iaRkOowl+aCAbwE=;
        b=jh/5l2pXEzpdJtwNKFZTn8otRBsl836hefNSV9LoII+oM6LrCs+NCf9GraZQEdeVE1
         kgkXrupinjwNkIZAYmZ+Oh44rfVtXSKynAYYUzvVq6HNPf8leFKJJ/FYnnPI3h1WWpj9
         uM80uOc/TcfDWSzd66ytClY0rnhscHpMJlDibNSKJY9Uyr88TFTmPeG338h01xoIb0Ze
         IypO8lT/tETX0LNLJeMdzNwUQ7nqpa8HVrgHupDLcY0PapwunjFcWXxDMQf1ofz2sEHK
         rlj+8UkEWV8xQxhTq8sdSlS0RePt9eSYJm++Osbvs4UicY0TLSDSfMC1f469zo3UEofH
         Ue2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789677954; x=1790282754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=p1z55IascskBSFplI6tSA8bIFyC9iaRkOowl+aCAbwE=;
        b=fMrGcP1cUUJyf47Z3HUv9J2t5yA6Hh92szDGyPlI/qo4x97+wPfVxmiUWEGUW3pWWi
         IqRWJy6IUj8ELuMBYmPhyuLUpbKChBdRpxWIGk5ZxI7jeJpoDRX0CEIWRjyZBuyb3NKO
         +f+cQicrNnIRbZfi3J3tnecP+JKj+lzFHHYggU2biGQz72m2KzLYsVVjFHYUCn3cYu2S
         B+thDDapKyO2+FM751sfuaCe3Y5KATZiplWY1HFZgQoXx4gHlyr5vdgWlbDj1HMToE7M
         Xh4umZylAosLmb3cpvcPCsCc6vkTi8Jjk0VC5OlisLFZfTl1B3+5QNPYshiR+KTkz+fO
         it9w==
X-Gm-Message-State: AFuF++kI/UGxE4rlZwsBsdAmjTiVY2yuiuivHpzZy6bI50sfiIitqrA4
	yxzAH4ygSP5QMBm57K5sCsnmBwX2edGqYFs/RCI+k+4nsJPJVQoa+n6PpKduSQs5hgWfpQ==
X-Gm-Gg: AYBFou2G4eYr+O5i20ay0Ry+8KroIYY9droUhOAv1E5HQN1uS+b3a7GtIvvacL45dvP
	4gF7R9RXVZr4Mq4hdBafLa1I2goV00V3kGIFS7qWc09rB/27BGIl5Dvw/en0m8y24DyQSXbDHwF
	zkPGITSeTAKHaylri1Xd3yHnS+FqhM9Z3+qkANK4hS+2f1GEHbdM8zBr1VkAfrNVrWAhDutKGzr
	bD0yO8cbl2TH8NknMzfDnLSLWMILB2chRjUAl8hyLI0NbBqDh6W3omy+JxL91d8f8R9Ebl8Scd+
	NE3Y4yZQwMf79LMfbIwdMbKaAbSvMZIHIhEhCycfy9PxRlOo4wGRyOazwCALOgzZroZQMalxfkZ
	0mKDZEN6TqxuAUIWMrmnEXlnrOYZoLnMqtU8krAhrTSv03f0ZGiTc1RnTLUkcpeEC51LXuW5ct6
	QrsBGlheXy4YPHKsWHQn19rofb6AvNKPrIxj8bs56a+8LF9Q60Y7Zn2JTxJRFTa6D2YAX+sHWwl
	9Z6LbC2cUx8JLu0dp1bYsDlnXNwOBoVDkZT+AL91mxROOeuAVgMPyehDCyUk9SDyg==
X-Received: by 2002:a05:6102:4192:b0:7a1:f7c3:3a45 with SMTP id ada2fe7eead31-7a55c886d2emr179430137.18.1789677954154;
        Thu, 17 Sep 2026 13:45:54 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7a1dcea8a67sm4584833137.0.2026.09.17.13.45.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 13:45:53 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/6] monitor: Separate the frames for a pager reading records
Date: Thu, 17 Sep 2026 16:45:37 -0400
Message-ID: <20260917204541.2176720-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917204541.2176720-1-luiz.dentz@gmail.com>
References: <20260917204541.2176720-1-luiz.dentz@gmail.com>
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

The model wrote this, which the author reviewed and verified by counting
the separators against the frames, by checking that a pager reading lines
still receives none, and that the output is unchanged when neither is
asked for.

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
index 8ed221e08a02..4be6a4687005 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -39,6 +39,7 @@
 #include "src/shared/mainloop.h"
 
 #include "display.h"
+#include "find.h"
 #include "packet.h"
 #include "hcidump.h"
 #include "ellisys.h"
@@ -962,8 +963,10 @@ static void data_callback(int fd, uint32_t events, void *user_data)
 
 		switch (data->channel) {
 		case HCI_CHANNEL_CONTROL:
+			find_frame_begin();
 			packet_control(tv, cred, index, opcode,
 							data->buf, pktlen);
+			find_frame_end();
 			break;
 		case HCI_CHANNEL_MONITOR:
 			if (pktlen > (len - MGMT_HDR_SIZE))
@@ -973,8 +976,10 @@ static void data_callback(int fd, uint32_t events, void *user_data)
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
@@ -1120,8 +1125,10 @@ static void kmsg_callback(int fd, uint32_t events, void *user_data)
 
 	btsnoop_write_hci(btsnoop_file, &tv, HCI_DEV_NONE,
 				BTSNOOP_OPCODE_SYSTEM_NOTE, 0, msg, len);
+	find_frame_begin();
 	packet_monitor(&tv, NULL, HCI_DEV_NONE,
 				BTSNOOP_OPCODE_SYSTEM_NOTE, msg, len);
+	find_frame_end();
 }
 
 static int open_kmsg(void)
@@ -1168,8 +1175,10 @@ static void client_callback(int fd, uint32_t events, void *user_data)
 		opcode = le16_to_cpu(hdr->opcode);
 		index = le16_to_cpu(hdr->index);
 
+		find_frame_begin();
 		packet_monitor(NULL, NULL, index, opcode,
 					data->buf + MGMT_HDR_SIZE, pktlen);
+		find_frame_end();
 
 		data->offset -= pktlen + MGMT_HDR_SIZE;
 
@@ -1386,8 +1395,10 @@ static void process_data(struct control_data *data)
 					hdr->ext_hdr + hdr->hdr_len, pktlen);
 		ellisys_inject_hci(tv, 0, opcode, hdr->ext_hdr + hdr->hdr_len,
 					pktlen);
+		find_frame_begin();
 		packet_monitor(tv, NULL, 0, opcode,
 					hdr->ext_hdr + hdr->hdr_len, pktlen);
+		find_frame_end();
 
 		data->offset -= 2 + data_len;
 
@@ -1573,7 +1584,9 @@ void control_reader(const char *path, bool pager)
 			if (opcode == 0xffff)
 				continue;
 
+			find_frame_begin();
 			packet_monitor(&tv, NULL, index, opcode, buf, pktlen);
+			find_frame_end();
 			ellisys_inject_hci(&tv, index, opcode, buf, pktlen);
 		}
 		break;
@@ -1586,7 +1599,9 @@ void control_reader(const char *path, bool pager)
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

