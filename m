Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D734532ED32
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Jun 2026 19:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781983361; cv=none; b=ffllrj3DRuW1s+PA8eaoQSg1nDGxD4xAZOfu86WQhqjFVh7Vt0aLHJdGWu9cMH1Jmm4rVw+l0hvMrjBk7a0jI8IllcqB83XSz+r9D1fO4Hzb+biBqMzyzUKZRKEez27qhYmdPMNAa05XYcpr9qAHnSLiUV+ecuYLYhHzj2arWFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781983361; c=relaxed/simple;
	bh=xR6juoGgNiDwgdBx23TJOz8QMoC1qEe6RvLKEzAVrIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rUjC+5GfJqVBLJKfUGM76LTgbTbkkZyIO5OB3wRFuUI25w+m1puMdLQfqgZ5PLfwTfH0jSCgc/dk5v4ami505MoiCVZIiUF7I3m4S6o9G7ltEApTWMl7DXj+8YYd26JEOe3kql7iOoC1Se9+DykF0r5qdTCDVnKtmc8cYXG8rUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQVMmCjr; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQVMmCjr"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso38133865e9.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Jun 2026 12:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781983357; x=1782588157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SrNvsKbVrJwHont6e8QkspCCnZnzkScFkfDbrdjXYoU=;
        b=EQVMmCjr7wow7BI/1bUv9jVO95I4csQLl9/u1wYkDzN+uQ5lfRk+MlnScEsmpG0WB/
         QjU031ZVS1rSqKDk4lCRfq7rgS3MpYsbmF8vZ3qJ5gapjue9svozs0qfOp86lx2mhO2s
         ga1Q8+cOuxBOp+H58J3LsG2kjHncHltFIw/uyWSE1hyE2vCqA2q/PGmoNKTHoKutc/O0
         ERJ9nnNU0IrJfRGMq8dB7ox/08IHXz5pObSCxKsMQzhzrkOab9ShTDUaQ2Vj2PCtqNoy
         a2020ffTVYbVZSKeVwpbO4hRrqpCvFyxor1pRceRQEf7RvKXpYJUxWWVC1aad7Q+lMVU
         w6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781983357; x=1782588157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrNvsKbVrJwHont6e8QkspCCnZnzkScFkfDbrdjXYoU=;
        b=oEkF1ArE3Ugqp9KUSzbUSmsLV4q3PqzyA+OoUu8tYpkDq49taG+JnxSztzlTO0q6nW
         folk1VGKLWWl1qbbmbWMUMpfWoHoUC4vR36CRorkb0Lgrs+eJHSaEzhAGos0ixqJ6reY
         VWrdPSed/raBLGdiKSMvtv4pwt52Wk87P6vB24Gm6eW6oxtdtVN2Z2eXYJWGfyyjwpkX
         ECM6TSCg7qfku0Dm/AYmf5F+jyBJqRSYjTmh21bp/TTLrIHfL8LYLf8Eq5EITu/qwzVJ
         XqBqbWTHi7477cyjQPSDBFILYFw8ElmLaKoimwD5EgfEy9n3eqnNIuxLWFVca7BT+wIf
         D2Tw==
X-Gm-Message-State: AOJu0YweYCDuCRxal7AKwrGvomNOkPcpOwwvh9SUu0R28HcppRTm3r0o
	Ix3qJRnCz+o/VJNgKvNmpCzTcxGpHcfnYSN+LdUxKh0B8yQDYM82PZ805NAjiQ==
X-Gm-Gg: AfdE7cnRLKTjBlo7oEm6xOd/q31gGJadSCOex9MKEK+Hj6AdeTM90GqrcOtLo6nix49
	KXZW3k4fhYMH1PZuuGHac7rkxcj8q/ViGaXZMEmtt3HyT3nEpR9vwTZN6BfqWd9PTqVmCQFWPpr
	ERfRYzynSZrML3dhoaUkoWf8CkgjxVLBUgXLpMVelR2k0mcWq9SbDUQqGEeZHne5XTHASYpOdA0
	LeSsleQg7OfgPQDyvgEpP/RRC6EHbb6ouKj/K+HcckADcfG+V8aaCkrDBDyMC12m/BYe+rZYMza
	nZjlKmuqz8FAGsLEzknQJdYXaT0jpqAHKWgM89867LFj/KA98JEcpq2P7NwScGnVmT6P+XWsE6h
	qHzA5CVIDUFxloEQShQD5AE9PgksxlVMeJwCIB5yai3qBX3R4EwGtrazl1PM4hPEGh5RDp0mxzd
	q/6MbHGe8vSZ76/+EyzfdCDm0ElL/gNn5OCyOIz4wUF6T13djqHXKLIDdMTuWaJTACBhpsBDMem
	ja0bxlpR+xTV/Mgjg==
X-Received: by 2002:a05:600c:1d19:b0:492:38c9:b265 with SMTP id 5b1f17b1804b1-49240a448edmr114568095e9.15.1781983356964;
        Sat, 20 Jun 2026 12:22:36 -0700 (PDT)
Received: from morpheus01.lan (93-38-64-42.ip69.fastwebnet.it. [93.38.64.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492492338dasm81751085e9.1.2026.06.20.12.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 12:22:36 -0700 (PDT)
From: Geraldo Netto <geraldonetto@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Geraldo Netto <geraldonetto@gmail.com>
Subject: [PATCH BlueZ 1/2] shared: harden btsnoop trace parsing
Date: Sat, 20 Jun 2026 21:22:27 +0200
Message-ID: <20260620192228.2692610-1-geraldonetto@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 Makefile.am          |   6 +
 monitor/analyze.c    |   4 +-
 monitor/control.c    |   2 +-
 src/shared/btsnoop.c | 303 +++++++++++------
 src/shared/btsnoop.h |   6 +-
 unit/test-btsnoop.c  | 794 +++++++++++++++++++++++++++++++++++++++++++
 unit/test-btsnoop.h  |   3 +
 7 files changed, 1009 insertions(+), 109 deletions(-)
 create mode 100644 unit/test-btsnoop.c
 create mode 100644 unit/test-btsnoop.h

diff --git a/Makefile.am b/Makefile.am
index 76c4ab5d4..4887934a9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -587,6 +587,12 @@ unit_tests += unit/test-textfile
 unit_test_textfile_SOURCES = unit/test-textfile.c src/textfile.h src/textfile.c
 unit_test_textfile_LDADD = src/libshared-glib.la $(GLIB_LIBS)
 
+unit_tests += unit/test-btsnoop
+
+unit_test_btsnoop_SOURCES = unit/test-btsnoop.c \
+				src/shared/btsnoop.h src/shared/btsnoop.c
+unit_test_btsnoop_LDADD = src/libshared-glib.la $(GLIB_LIBS)
+
 unit_tests += unit/test-crc
 
 unit_test_crc_SOURCES = unit/test-crc.c monitor/crc.h monitor/crc.c
diff --git a/monitor/analyze.c b/monitor/analyze.c
index de9c23603..c9400ceb3 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -1404,8 +1404,8 @@ void analyze_trace(const char *path)
 		struct timeval tv;
 		uint16_t index, opcode, pktlen;
 
-		if (!btsnoop_read_hci(btsnoop_file, &tv, &index, &opcode,
-								buf, &pktlen))
+		if (!btsnoop_read_hci(btsnoop_file, &tv, &index,
+					&opcode, buf, sizeof(buf), &pktlen))
 			break;
 
 		switch (opcode) {
diff --git a/monitor/control.c b/monitor/control.c
index 83347d5db..975e1d117 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -1564,7 +1564,7 @@ void control_reader(const char *path, bool pager)
 			uint16_t index, opcode;
 
 			if (!btsnoop_read_hci(btsnoop_file, &tv, &index,
-							&opcode, buf, &pktlen))
+					&opcode, buf, sizeof(buf), &pktlen))
 				break;
 
 			if (opcode == 0xffff)
diff --git a/src/shared/btsnoop.c b/src/shared/btsnoop.c
index 9ce2f2655..39960c4b8 100644
--- a/src/shared/btsnoop.c
+++ b/src/shared/btsnoop.c
@@ -13,6 +13,7 @@
 #endif
 
 #define _GNU_SOURCE
+#include <errno.h>
 #include <endian.h>
 #include <fcntl.h>
 #include <unistd.h>
@@ -47,12 +48,16 @@ static const uint8_t btsnoop_id[] = { 0x62, 0x74, 0x73, 0x6e,
 
 static const uint32_t btsnoop_version = 1;
 
+#define BTSNOOP_EPOCH_OFFSET 0x00E03AB44A676000ull
+#define BTSNOOP_UNIX_TIME_OFFSET 946684800ll
+
 struct pklg_pkt {
 	uint32_t	len;
 	uint64_t	ts;
 	uint8_t		type;
 } __attribute__ ((packed));
 #define PKLG_PKT_SIZE (sizeof(struct pklg_pkt))
+#define PKLG_PAYLOAD_OFFSET (PKLG_PKT_SIZE - sizeof(uint32_t))
 
 struct btsnoop {
 	int ref_count;
@@ -271,13 +276,14 @@ bool btsnoop_write(struct btsnoop *btsnoop, struct timeval *tv,
 		if (!btsnoop_rotate(btsnoop))
 			return false;
 
-	ts = (tv->tv_sec - 946684800ll) * 1000000ll + tv->tv_usec;
+	ts = (tv->tv_sec - BTSNOOP_UNIX_TIME_OFFSET) * 1000000ll +
+								tv->tv_usec;
 
 	pkt.size  = htobe32(size);
 	pkt.len   = htobe32(size);
 	pkt.flags = htobe32(flags);
 	pkt.drops = htobe32(drops);
-	pkt.ts    = htobe64(ts + 0x00E03AB44A676000ll);
+	pkt.ts    = htobe64(ts + BTSNOOP_EPOCH_OFFSET);
 
 	written = write(btsnoop->fd, &pkt, BTSNOOP_PKT_SIZE);
 	if (written < 0)
@@ -324,6 +330,121 @@ static uint32_t get_flags_from_opcode(uint16_t opcode)
 	return 0xff;
 }
 
+static ssize_t read_exact(int fd, void *data, size_t size)
+{
+	uint8_t *ptr = data;
+	size_t offset = 0;
+
+	while (offset < size) {
+		ssize_t len;
+
+		len = read(fd, ptr + offset, size - offset);
+		if (len < 0) {
+			if (errno == EINTR)
+				continue;
+			return -1;
+		}
+
+		if (len == 0)
+			break;
+
+		offset += len;
+	}
+
+	return offset;
+}
+
+static bool read_packet_data(struct btsnoop *btsnoop, void *data,
+				uint16_t data_size, uint32_t toread,
+				uint16_t *size)
+{
+	ssize_t len;
+
+	if (!size || (!data && toread)) {
+		btsnoop->aborted = true;
+		return false;
+	}
+
+	if (toread > data_size) {
+		btsnoop->aborted = true;
+		return false;
+	}
+
+	len = read_exact(btsnoop->fd, data, toread);
+	if (len != (ssize_t) toread) {
+		btsnoop->aborted = true;
+		return false;
+	}
+
+	*size = toread;
+
+	return true;
+}
+
+static bool decode_btsnoop_timestamp(uint64_t raw_ts, struct timeval *tv)
+{
+	uint64_t ts;
+
+	if (raw_ts < BTSNOOP_EPOCH_OFFSET)
+		return false;
+
+	ts = raw_ts - BTSNOOP_EPOCH_OFFSET;
+	tv->tv_sec = (ts / 1000000ll) + BTSNOOP_UNIX_TIME_OFFSET;
+	tv->tv_usec = ts % 1000000ll;
+
+	return true;
+}
+
+static void get_pklg_opcode(uint8_t type, uint16_t *index, uint16_t *opcode)
+{
+	switch (type) {
+	case 0x00:
+		*index = 0x0000;
+		*opcode = BTSNOOP_OPCODE_COMMAND_PKT;
+		break;
+	case 0x01:
+		*index = 0x0000;
+		*opcode = BTSNOOP_OPCODE_EVENT_PKT;
+		break;
+	case 0x02:
+		*index = 0x0000;
+		*opcode = BTSNOOP_OPCODE_ACL_TX_PKT;
+		break;
+	case 0x03:
+		*index = 0x0000;
+		*opcode = BTSNOOP_OPCODE_ACL_RX_PKT;
+		break;
+	case 0x08:
+		*index = 0x0000;
+		*opcode = BTSNOOP_OPCODE_SCO_TX_PKT;
+		break;
+	case 0x09:
+		*index = 0x0000;
+		*opcode = BTSNOOP_OPCODE_SCO_RX_PKT;
+		break;
+	case 0x12:
+		*index = 0x0000;
+		*opcode = BTSNOOP_OPCODE_ISO_TX_PKT;
+		break;
+	case 0x13:
+		*index = 0x0000;
+		*opcode = BTSNOOP_OPCODE_ISO_RX_PKT;
+		break;
+	case 0x0b:
+		*index = 0x0000;
+		*opcode = BTSNOOP_OPCODE_VENDOR_DIAG;
+		break;
+	case 0xfc:
+		*index = 0xffff;
+		*opcode = BTSNOOP_OPCODE_SYSTEM_NOTE;
+		break;
+	default:
+		*index = 0xffff;
+		*opcode = 0xffff;
+		break;
+	}
+}
+
 bool btsnoop_write_hci(struct btsnoop *btsnoop, struct timeval *tv,
 			uint16_t index, uint16_t opcode, uint32_t drops,
 			const void *data, uint16_t size)
@@ -377,99 +498,53 @@ bool btsnoop_write_phy(struct btsnoop *btsnoop, struct timeval *tv,
 	return btsnoop_write(btsnoop, tv, flags, 0, data, size);
 }
 
-static bool pklg_read_hci(struct btsnoop *btsnoop, struct timeval *tv,
-					uint16_t *index, uint16_t *opcode,
-					void *data, uint16_t *size)
+static bool pklg_read_hci(struct btsnoop *btsnoop,
+			struct timeval *tv, uint16_t *index, uint16_t *opcode,
+			void *data, uint16_t data_size, uint16_t *size)
 {
 	struct pklg_pkt pkt;
+	uint32_t pkt_len;
 	uint32_t toread;
 	uint64_t ts;
 	ssize_t len;
 
-	len = read(btsnoop->fd, &pkt, PKLG_PKT_SIZE);
+	len = read_exact(btsnoop->fd, &pkt, PKLG_PKT_SIZE);
 	if (len == 0)
 		return false;
 
-	if (len < 0 || len != PKLG_PKT_SIZE) {
+	if (len != PKLG_PKT_SIZE) {
 		btsnoop->aborted = true;
 		return false;
 	}
 
 	if (btsnoop->pklg_v2) {
-		toread = le32toh(pkt.len) - (PKLG_PKT_SIZE - 4);
+		pkt_len = le32toh(pkt.len);
 
 		ts = le64toh(pkt.ts);
 		tv->tv_sec = ts & 0xffffffff;
 		tv->tv_usec = ts >> 32;
 	} else {
-		toread = be32toh(pkt.len) - (PKLG_PKT_SIZE - 4);
+		pkt_len = be32toh(pkt.len);
 
 		ts = be64toh(pkt.ts);
 		tv->tv_sec = ts >> 32;
 		tv->tv_usec = ts & 0xffffffff;
 	}
 
-	if (toread > BTSNOOP_MAX_PACKET_SIZE) {
-                btsnoop->aborted = true;
-                return false;
-        }
-
-	switch (pkt.type) {
-	case 0x00:
-		*index = 0x0000;
-		*opcode = BTSNOOP_OPCODE_COMMAND_PKT;
-		break;
-	case 0x01:
-		*index = 0x0000;
-		*opcode = BTSNOOP_OPCODE_EVENT_PKT;
-		break;
-	case 0x02:
-		*index = 0x0000;
-		*opcode = BTSNOOP_OPCODE_ACL_TX_PKT;
-		break;
-	case 0x03:
-		*index = 0x0000;
-		*opcode = BTSNOOP_OPCODE_ACL_RX_PKT;
-		break;
-	case 0x08:
-		*index = 0x0000;
-		*opcode = BTSNOOP_OPCODE_SCO_TX_PKT;
-		break;
-	case 0x09:
-		*index = 0x0000;
-		*opcode = BTSNOOP_OPCODE_SCO_RX_PKT;
-		break;
-	case 0x12:
-		*index = 0x0000;
-		*opcode = BTSNOOP_OPCODE_ISO_TX_PKT;
-		break;
-	case 0x13:
-		*index = 0x0000;
-		*opcode = BTSNOOP_OPCODE_ISO_RX_PKT;
-		break;
-	case 0x0b:
-		*index = 0x0000;
-		*opcode = BTSNOOP_OPCODE_VENDOR_DIAG;
-		break;
-	case 0xfc:
-		*index = 0xffff;
-		*opcode = BTSNOOP_OPCODE_SYSTEM_NOTE;
-		break;
-	default:
-		*index = 0xffff;
-		*opcode = 0xffff;
-		break;
+	if (pkt_len < PKLG_PAYLOAD_OFFSET) {
+		btsnoop->aborted = true;
+		return false;
 	}
 
-	len = read(btsnoop->fd, data, toread);
-	if (len < 0) {
+	toread = pkt_len - PKLG_PAYLOAD_OFFSET;
+	if (toread > BTSNOOP_MAX_PACKET_SIZE) {
 		btsnoop->aborted = true;
 		return false;
 	}
 
-	*size = toread;
+	get_pklg_opcode(pkt.type, index, opcode);
 
-	return true;
+	return read_packet_data(btsnoop, data, data_size, toread, size);
 }
 
 static uint16_t get_opcode_from_flags(uint8_t type, uint32_t flags)
@@ -512,84 +587,106 @@ static uint16_t get_opcode_from_flags(uint8_t type, uint32_t flags)
 	return 0xffff;
 }
 
-bool btsnoop_read_hci(struct btsnoop *btsnoop, struct timeval *tv,
-					uint16_t *index, uint16_t *opcode,
-					void *data, uint16_t *size)
+static bool read_uart_type(struct btsnoop *btsnoop, uint32_t *toread,
+								uint8_t *type)
 {
-	struct btsnoop_pkt pkt;
-	uint32_t toread, flags;
-	uint64_t ts;
-	uint8_t pkt_type;
 	ssize_t len;
 
-	if (!btsnoop || btsnoop->aborted)
-		return false;
-
-	if (btsnoop->pklg_format)
-		return pklg_read_hci(btsnoop, tv, index, opcode, data, size);
-
-	len = read(btsnoop->fd, &pkt, BTSNOOP_PKT_SIZE);
-	if (len == 0)
-		return false;
-
-	if (len < 0 || len != BTSNOOP_PKT_SIZE) {
+	if (!*toread) {
 		btsnoop->aborted = true;
 		return false;
 	}
 
-	toread = be32toh(pkt.len);
-	if (toread > BTSNOOP_MAX_PACKET_SIZE) {
+	len = read_exact(btsnoop->fd, type, 1);
+	if (len != 1) {
 		btsnoop->aborted = true;
 		return false;
 	}
 
-	flags = be32toh(pkt.flags);
+	(*toread)--;
 
-	ts = be64toh(pkt.ts) - 0x00E03AB44A676000ll;
-	tv->tv_sec = (ts / 1000000ll) + 946684800ll;
-	tv->tv_usec = ts % 1000000ll;
+	return true;
+}
+
+static bool decode_btsnoop_record(struct btsnoop *btsnoop, uint32_t flags,
+					uint32_t *toread, uint16_t *index,
+					uint16_t *opcode)
+{
+	uint8_t pkt_type;
 
 	switch (btsnoop->format) {
 	case BTSNOOP_FORMAT_HCI:
 		*index = 0;
 		*opcode = get_opcode_from_flags(0xff, flags);
-		break;
-
+		return true;
 	case BTSNOOP_FORMAT_UART:
-		len = read(btsnoop->fd, &pkt_type, 1);
-		if (len < 0) {
-			btsnoop->aborted = true;
+		if (!read_uart_type(btsnoop, toread, &pkt_type))
 			return false;
-		}
-		toread--;
 
 		*index = 0;
 		*opcode = get_opcode_from_flags(pkt_type, flags);
-		break;
-
+		return true;
 	case BTSNOOP_FORMAT_MONITOR:
 		*index = flags >> 16;
 		*opcode = flags & 0xffff;
-		break;
-
+		return true;
 	default:
 		btsnoop->aborted = true;
 		return false;
 	}
+}
 
-	len = read(btsnoop->fd, data, toread);
-	if (len < 0) {
+bool btsnoop_read_hci(struct btsnoop *btsnoop,
+			struct timeval *tv, uint16_t *index, uint16_t *opcode,
+			void *data, uint16_t data_size, uint16_t *size)
+{
+	struct btsnoop_pkt pkt;
+	uint32_t toread, flags;
+	ssize_t len;
+
+	if (!btsnoop || !tv || !index || !opcode || !size || btsnoop->aborted)
+		return false;
+
+	if (btsnoop->pklg_format)
+		return pklg_read_hci(btsnoop, tv, index, opcode,
+							data, data_size, size);
+
+	len = read_exact(btsnoop->fd, &pkt, BTSNOOP_PKT_SIZE);
+	if (len == 0)
+		return false;
+
+	if (len != BTSNOOP_PKT_SIZE) {
 		btsnoop->aborted = true;
 		return false;
 	}
 
-	*size = toread;
+	toread = be32toh(pkt.len);
+	if (toread > BTSNOOP_MAX_PACKET_SIZE) {
+		btsnoop->aborted = true;
+		return false;
+	}
 
-	return true;
+	flags = be32toh(pkt.flags);
+
+	if (!decode_btsnoop_timestamp(be64toh(pkt.ts), tv)) {
+		btsnoop->aborted = true;
+		return false;
+	}
+
+	if (!decode_btsnoop_record(btsnoop, flags, &toread, index, opcode))
+		return false;
+
+	return read_packet_data(btsnoop, data, data_size, toread, size);
 }
 
 bool btsnoop_read_phy(struct btsnoop *btsnoop, struct timeval *tv,
-			uint16_t *frequency, void *data, uint16_t *size)
+				uint16_t *frequency, void *data, uint16_t *size)
 {
+	(void) btsnoop;
+	(void) tv;
+	(void) frequency;
+	(void) data;
+	(void) size;
+
 	return false;
 }
diff --git a/src/shared/btsnoop.h b/src/shared/btsnoop.h
index c24755d56..796604c58 100644
--- a/src/shared/btsnoop.h
+++ b/src/shared/btsnoop.h
@@ -106,8 +106,8 @@ bool btsnoop_write_hci(struct btsnoop *btsnoop, struct timeval *tv,
 bool btsnoop_write_phy(struct btsnoop *btsnoop, struct timeval *tv,
 			uint16_t frequency, const void *data, uint16_t size);
 
-bool btsnoop_read_hci(struct btsnoop *btsnoop, struct timeval *tv,
-					uint16_t *index, uint16_t *opcode,
-					void *data, uint16_t *size);
+bool btsnoop_read_hci(struct btsnoop *btsnoop,
+			struct timeval *tv, uint16_t *index, uint16_t *opcode,
+			void *data, uint16_t data_size, uint16_t *size);
 bool btsnoop_read_phy(struct btsnoop *btsnoop, struct timeval *tv,
 			uint16_t *frequency, void *data, uint16_t *size);
diff --git a/unit/test-btsnoop.c b/unit/test-btsnoop.c
new file mode 100644
index 000000000..710209097
--- /dev/null
+++ b/unit/test-btsnoop.c
@@ -0,0 +1,794 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <endian.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <glib.h>
+
+#include "src/shared/att-types.h"
+#include "src/shared/btsnoop.h"
+#include "unit/test-btsnoop.h"
+
+#define BTSNOOP_EPOCH_OFFSET 0x00E03AB44A676000ull
+#define PKLG_PAYLOAD_OFFSET 9
+
+struct test_btsnoop_hdr {
+	uint8_t id[8];
+	uint32_t version;
+	uint32_t type;
+} __packed;
+
+struct test_btsnoop_pkt {
+	uint32_t size;
+	uint32_t len;
+	uint32_t flags;
+	uint32_t drops;
+	uint64_t ts;
+} __packed;
+
+struct test_pklg_pkt {
+	uint32_t len;
+	uint64_t ts;
+	uint8_t type;
+} __packed;
+
+static const uint8_t btsnoop_id[] = {
+	0x62, 0x74, 0x73, 0x6e, 0x6f, 0x6f, 0x70, 0x00
+};
+
+static void append_bytes(GByteArray *array, const void *data, size_t size)
+{
+	if (!size)
+		return;
+
+	g_byte_array_append(array, data, size);
+}
+
+static void append_btsnoop_header(GByteArray *array, uint32_t format)
+{
+	struct test_btsnoop_hdr hdr;
+
+	memcpy(hdr.id, btsnoop_id, sizeof(btsnoop_id));
+	hdr.version = htobe32(1);
+	hdr.type = htobe32(format);
+
+	append_bytes(array, &hdr, sizeof(hdr));
+}
+
+static void append_btsnoop_packet(GByteArray *array, uint32_t len,
+					uint32_t flags, uint64_t ts,
+					const void *data, size_t data_len)
+{
+	struct test_btsnoop_pkt pkt;
+
+	pkt.size = htobe32(len);
+	pkt.len = htobe32(len);
+	pkt.flags = htobe32(flags);
+	pkt.drops = 0;
+	pkt.ts = htobe64(ts);
+
+	append_bytes(array, &pkt, sizeof(pkt));
+	append_bytes(array, data, data_len);
+}
+
+static void append_pklg_packet(GByteArray *array, bool little_endian,
+				uint32_t payload_len, uint64_t ts,
+				uint8_t type, const void *data, size_t data_len)
+{
+	struct test_pklg_pkt pkt;
+	uint32_t len = PKLG_PAYLOAD_OFFSET + payload_len;
+
+	pkt.len = little_endian ? htole32(len) : htobe32(len);
+	pkt.ts = little_endian ? htole64(ts) : htobe64(ts);
+	pkt.type = type;
+
+	append_bytes(array, &pkt, sizeof(pkt));
+	append_bytes(array, data, data_len);
+}
+
+static char *write_tmp_trace(const void *data, size_t size)
+{
+	char *path = NULL;
+	ssize_t written;
+	int fd;
+
+	fd = g_file_open_tmp("bluez-btsnoop-XXXXXX", &path, NULL);
+	g_assert(fd >= 0);
+	written = write(fd, data, size);
+	g_assert_cmpint(written, ==, (ssize_t) size);
+	g_assert_cmpint(close(fd), ==, 0);
+
+	return path;
+}
+
+static char *new_tmp_path(void)
+{
+	char *path = NULL;
+	int fd;
+
+	fd = g_file_open_tmp("bluez-btsnoop-XXXXXX", &path, NULL);
+	g_assert(fd >= 0);
+	g_assert_cmpint(close(fd), ==, 0);
+	unlink(path);
+
+	return path;
+}
+
+static void unlink_rotated(const char *path, unsigned int count)
+{
+	unsigned int i;
+
+	for (i = 0; i <= count; i++) {
+		char *name;
+
+		name = g_strdup_printf("%s.%u", path, i);
+		unlink(name);
+		g_free(name);
+	}
+}
+
+static bool read_tmp_trace(const void *trace, size_t trace_len,
+				unsigned long flags, uint16_t data_size,
+				uint8_t *data, uint16_t *size,
+				uint16_t *index, uint16_t *opcode,
+				struct timeval *tv)
+{
+	struct btsnoop *btsnoop;
+	char *path;
+	bool result;
+
+	path = write_tmp_trace(trace, trace_len);
+	btsnoop = btsnoop_open(path, flags);
+	unlink(path);
+	g_free(path);
+
+	if (!btsnoop)
+		return false;
+
+	result = btsnoop_read_hci(btsnoop, tv, index, opcode, data,
+							data_size, size);
+	btsnoop_unref(btsnoop);
+
+	return result;
+}
+
+static bool read_trace_file(const char *path, unsigned long flags,
+				uint8_t *data, uint16_t data_size,
+				uint16_t *size, uint16_t *index,
+				uint16_t *opcode, struct timeval *tv)
+{
+	struct btsnoop *btsnoop;
+	bool result;
+
+	btsnoop = btsnoop_open(path, flags);
+	g_assert_nonnull(btsnoop);
+
+	result = btsnoop_read_hci(btsnoop, tv, index, opcode, data,
+							data_size, size);
+	btsnoop_unref(btsnoop);
+
+	return result;
+}
+
+static void test_btsnoop_hci_valid(void)
+{
+	GByteArray *trace = g_byte_array_new();
+	const uint8_t payload[] = { 0x01, 0x02, 0x03 };
+	uint8_t data[sizeof(payload)];
+	struct timeval tv;
+	uint16_t size = 0;
+	uint16_t index = 0xffff;
+	uint16_t opcode = 0xffff;
+
+	append_btsnoop_header(trace, BTSNOOP_FORMAT_HCI);
+	append_btsnoop_packet(trace, sizeof(payload), 0x02,
+			BTSNOOP_EPOCH_OFFSET + 1234567, payload,
+			sizeof(payload));
+
+	g_assert_true(read_tmp_trace(trace->data, trace->len, 0, sizeof(data),
+					data, &size, &index, &opcode, &tv));
+	g_assert_cmpint(index, ==, 0);
+	g_assert_cmpint(opcode, ==, BTSNOOP_OPCODE_COMMAND_PKT);
+	g_assert_cmpint(size, ==, sizeof(payload));
+	g_assert_cmpint(memcmp(data, payload, sizeof(payload)), ==, 0);
+	g_assert_cmpint(tv.tv_sec, ==, 946684801);
+	g_assert_cmpint(tv.tv_usec, ==, 234567);
+
+	g_byte_array_unref(trace);
+}
+
+static void test_btsnoop_create_invalid_args(void)
+{
+	char *path = new_tmp_path();
+
+	g_assert_null(btsnoop_create(path, 0, 1, BTSNOOP_FORMAT_HCI));
+	g_assert_null(btsnoop_create("/tmp/bluez/no/such/path", 0, 0,
+							BTSNOOP_FORMAT_HCI));
+	g_assert_null(btsnoop_ref(NULL));
+	btsnoop_unref(NULL);
+	g_assert_cmpint(btsnoop_get_format(NULL), ==, BTSNOOP_FORMAT_INVALID);
+
+	g_free(path);
+}
+
+static void test_btsnoop_open_invalid_headers(void)
+{
+	GByteArray *trace = g_byte_array_new();
+	struct test_btsnoop_hdr hdr;
+	char *path;
+
+	append_btsnoop_header(trace, BTSNOOP_FORMAT_HCI);
+	((struct test_btsnoop_hdr *) trace->data)->version = htobe32(2);
+	path = write_tmp_trace(trace->data, trace->len);
+	g_assert_null(btsnoop_open(path, 0));
+	unlink(path);
+	g_free(path);
+	g_byte_array_set_size(trace, 0);
+
+	memset(&hdr, 0x55, sizeof(hdr));
+	append_bytes(trace, &hdr, sizeof(hdr));
+	path = write_tmp_trace(trace->data, trace->len);
+	g_assert_null(btsnoop_open(path, 0));
+	g_assert_null(btsnoop_open(path, BTSNOOP_FLAG_PKLG_SUPPORT));
+	unlink(path);
+	g_free(path);
+	g_byte_array_unref(trace);
+}
+
+static void test_btsnoop_write_hci_roundtrip(void)
+{
+	const uint8_t command[] = { 0x01, 0x02, 0x03 };
+	const uint8_t event[] = { 0x04, 0x05 };
+	uint8_t data[sizeof(command)];
+	struct btsnoop *btsnoop;
+	struct timeval tv = { .tv_sec = 946684802, .tv_usec = 345678 };
+	uint16_t size = 0;
+	uint16_t index = 0;
+	uint16_t opcode = 0;
+	char *path = new_tmp_path();
+
+	btsnoop = btsnoop_create(path, 0, 0, BTSNOOP_FORMAT_HCI);
+	g_assert_nonnull(btsnoop);
+	g_assert_cmpint(btsnoop_get_format(btsnoop), ==, BTSNOOP_FORMAT_HCI);
+	g_assert_true(btsnoop_write_hci(btsnoop, &tv, 0,
+					BTSNOOP_OPCODE_COMMAND_PKT, 0,
+					command, sizeof(command)));
+	g_assert_true(btsnoop_write_hci(btsnoop, &tv, 0,
+					BTSNOOP_OPCODE_EVENT_PKT, 0,
+					event, sizeof(event)));
+	g_assert_false(btsnoop_write_hci(btsnoop, &tv, 1,
+					BTSNOOP_OPCODE_COMMAND_PKT, 0,
+					command, sizeof(command)));
+	g_assert_false(btsnoop_write_hci(btsnoop, &tv, 0,
+					BTSNOOP_OPCODE_NEW_INDEX, 0,
+					command, sizeof(command)));
+	btsnoop_unref(btsnoop);
+
+	g_assert_true(read_trace_file(path, 0, data, sizeof(data), &size,
+						&index, &opcode, &tv));
+	g_assert_cmpint(index, ==, 0);
+	g_assert_cmpint(opcode, ==, BTSNOOP_OPCODE_COMMAND_PKT);
+	g_assert_cmpint(size, ==, sizeof(command));
+	g_assert_cmpint(memcmp(data, command, sizeof(command)), ==, 0);
+
+	btsnoop = btsnoop_open(path, 0);
+	g_assert_nonnull(btsnoop);
+	g_assert_true(btsnoop_read_hci(btsnoop, &tv, &index, &opcode, data,
+							sizeof(data), &size));
+	g_assert_true(btsnoop_read_hci(btsnoop, &tv, &index, &opcode, data,
+							sizeof(data), &size));
+	g_assert_cmpint(opcode, ==, BTSNOOP_OPCODE_EVENT_PKT);
+	g_assert_cmpint(size, ==, sizeof(event));
+	g_assert_cmpint(memcmp(data, event, sizeof(event)), ==, 0);
+	g_assert_false(btsnoop_read_hci(btsnoop, &tv, &index, &opcode, data,
+							sizeof(data), &size));
+	btsnoop_unref(btsnoop);
+
+	unlink(path);
+	g_free(path);
+}
+
+static void test_btsnoop_write_monitor_roundtrip(void)
+{
+	const uint8_t payload[] = { 0xaa, 0xbb };
+	uint8_t data[sizeof(payload)];
+	struct btsnoop *btsnoop;
+	struct timeval tv = { .tv_sec = 946684800, .tv_usec = 0 };
+	uint16_t size = 0;
+	uint16_t index = 0;
+	uint16_t opcode = 0;
+	char *path = new_tmp_path();
+
+	btsnoop = btsnoop_create(path, 0, 0, BTSNOOP_FORMAT_MONITOR);
+	g_assert_nonnull(btsnoop);
+	g_assert_true(btsnoop_write_hci(btsnoop, &tv, 7, 0x1234, 0,
+						payload, sizeof(payload)));
+	btsnoop_unref(btsnoop);
+
+	g_assert_true(read_trace_file(path, 0, data, sizeof(data), &size,
+						&index, &opcode, &tv));
+	g_assert_cmpint(index, ==, 7);
+	g_assert_cmpint(opcode, ==, 0x1234);
+	g_assert_cmpint(size, ==, sizeof(payload));
+	g_assert_cmpint(memcmp(data, payload, sizeof(payload)), ==, 0);
+
+	unlink(path);
+	g_free(path);
+}
+
+static void test_btsnoop_write_phy_and_rotate(void)
+{
+	const uint8_t payload[] = { 0x01 };
+	struct btsnoop *btsnoop;
+	struct timeval tv = { .tv_sec = 946684800, .tv_usec = 0 };
+	char *path = new_tmp_path();
+
+	g_assert_false(btsnoop_write(NULL, &tv, 0, 0, payload,
+							sizeof(payload)));
+
+	btsnoop = btsnoop_create(path, 24, 1, BTSNOOP_FORMAT_SIMULATOR);
+	g_assert_nonnull(btsnoop);
+	g_assert_true(btsnoop_write_phy(btsnoop, &tv, 2402, payload,
+							sizeof(payload)));
+	btsnoop_unref(btsnoop);
+
+	btsnoop = btsnoop_create(path, 0, 0, BTSNOOP_FORMAT_HCI);
+	g_assert_nonnull(btsnoop);
+	g_assert_false(btsnoop_write_phy(btsnoop, &tv, 2402, payload,
+							sizeof(payload)));
+	btsnoop_unref(btsnoop);
+
+	unlink(path);
+	unlink_rotated(path, 1);
+	g_free(path);
+}
+
+static void test_btsnoop_monitor_valid(void)
+{
+	GByteArray *trace = g_byte_array_new();
+	const uint8_t payload[] = { 0xaa, 0xbb };
+	uint8_t data[sizeof(payload)];
+	struct timeval tv;
+	uint16_t size = 0;
+	uint16_t index = 0xffff;
+	uint16_t opcode = 0xffff;
+
+	append_btsnoop_header(trace, BTSNOOP_FORMAT_MONITOR);
+	append_btsnoop_packet(trace, sizeof(payload), 0x00051234,
+			BTSNOOP_EPOCH_OFFSET, payload, sizeof(payload));
+
+	g_assert_true(read_tmp_trace(trace->data, trace->len, 0, sizeof(data),
+					data, &size, &index, &opcode, &tv));
+	g_assert_cmpint(index, ==, 5);
+	g_assert_cmpint(opcode, ==, 0x1234);
+	g_assert_cmpint(size, ==, sizeof(payload));
+	g_assert_cmpint(memcmp(data, payload, sizeof(payload)), ==, 0);
+
+	g_byte_array_unref(trace);
+}
+
+static void test_btsnoop_uart_valid(void)
+{
+	GByteArray *trace = g_byte_array_new();
+	const uint8_t payload[] = { 0x04, 0x0e, 0x01, 0x00 };
+	uint8_t data[sizeof(payload) - 1];
+	struct timeval tv;
+	uint16_t size = 0;
+	uint16_t index = 0xffff;
+	uint16_t opcode = 0xffff;
+
+	append_btsnoop_header(trace, BTSNOOP_FORMAT_UART);
+	append_btsnoop_packet(trace, sizeof(payload), 0,
+			BTSNOOP_EPOCH_OFFSET, payload, sizeof(payload));
+
+	g_assert_true(read_tmp_trace(trace->data, trace->len, 0, sizeof(data),
+					data, &size, &index, &opcode, &tv));
+	g_assert_cmpint(index, ==, 0);
+	g_assert_cmpint(opcode, ==, BTSNOOP_OPCODE_EVENT_PKT);
+	g_assert_cmpint(size, ==, sizeof(payload) - 1);
+	g_assert_cmpint(memcmp(data, payload + 1, sizeof(data)), ==, 0);
+
+	g_byte_array_unref(trace);
+}
+
+static void test_btsnoop_uart_opcode_map(void)
+{
+	static const struct {
+		uint8_t type;
+		uint32_t flags;
+		uint16_t opcode;
+	} cases[] = {
+		{ 0x01, 0x00, BTSNOOP_OPCODE_COMMAND_PKT },
+		{ 0x02, 0x00, BTSNOOP_OPCODE_ACL_TX_PKT },
+		{ 0x02, 0x01, BTSNOOP_OPCODE_ACL_RX_PKT },
+		{ 0x03, 0x00, BTSNOOP_OPCODE_SCO_TX_PKT },
+		{ 0x03, 0x01, BTSNOOP_OPCODE_SCO_RX_PKT },
+		{ 0x05, 0x00, BTSNOOP_OPCODE_ISO_TX_PKT },
+		{ 0x05, 0x01, BTSNOOP_OPCODE_ISO_RX_PKT },
+		{ 0x99, 0x00, 0xffff },
+	};
+	unsigned int i;
+
+	for (i = 0; i < G_N_ELEMENTS(cases); i++) {
+		GByteArray *trace = g_byte_array_new();
+		const uint8_t payload[] = { cases[i].type, 0x00 };
+		uint8_t data[1];
+		struct timeval tv;
+		uint16_t size = 0;
+		uint16_t index = 0;
+		uint16_t opcode = 0;
+
+		append_btsnoop_header(trace, BTSNOOP_FORMAT_UART);
+		append_btsnoop_packet(trace, sizeof(payload), cases[i].flags,
+				BTSNOOP_EPOCH_OFFSET, payload, sizeof(payload));
+
+		g_assert_true(read_tmp_trace(trace->data, trace->len, 0,
+						sizeof(data), data, &size,
+						&index, &opcode, &tv));
+		g_assert_cmpint(opcode, ==, cases[i].opcode);
+		g_byte_array_unref(trace);
+	}
+}
+
+static void test_btsnoop_rejects_small_capacity(void)
+{
+	GByteArray *trace = g_byte_array_new();
+	const uint8_t payload[] = { 0x01, 0x02, 0x03 };
+	uint8_t data[4] = { 0xa5, 0xa5, 0xa5, 0xa5 };
+	struct timeval tv;
+	uint16_t size = 0;
+	uint16_t index = 0;
+	uint16_t opcode = 0;
+
+	append_btsnoop_header(trace, BTSNOOP_FORMAT_HCI);
+	append_btsnoop_packet(trace, sizeof(payload), 0x02,
+			BTSNOOP_EPOCH_OFFSET, payload, sizeof(payload));
+
+	g_assert_false(read_tmp_trace(trace->data, trace->len, 0, 2, data,
+						&size, &index, &opcode, &tv));
+	g_assert_cmpint(data[0], ==, 0xa5);
+	g_assert_cmpint(data[1], ==, 0xa5);
+	g_assert_cmpint(data[2], ==, 0xa5);
+	g_assert_cmpint(data[3], ==, 0xa5);
+
+	g_byte_array_unref(trace);
+}
+
+static void test_btsnoop_rejects_timestamp_underflow(void)
+{
+	GByteArray *trace = g_byte_array_new();
+	struct timeval tv;
+	uint16_t size = 0;
+	uint16_t index = 0;
+	uint16_t opcode = 0;
+
+	append_btsnoop_header(trace, BTSNOOP_FORMAT_HCI);
+	append_btsnoop_packet(trace, 0, 0x02, BTSNOOP_EPOCH_OFFSET - 1,
+								NULL, 0);
+
+	g_assert_false(read_tmp_trace(trace->data, trace->len, 0, 0, NULL,
+						&size, &index, &opcode, &tv));
+
+	g_byte_array_unref(trace);
+}
+
+static void test_btsnoop_rejects_uart_zero_length(void)
+{
+	GByteArray *trace = g_byte_array_new();
+	struct timeval tv;
+	uint16_t size = 0;
+	uint16_t index = 0;
+	uint16_t opcode = 0;
+
+	append_btsnoop_header(trace, BTSNOOP_FORMAT_UART);
+	append_btsnoop_packet(trace, 0, 0, BTSNOOP_EPOCH_OFFSET, NULL, 0);
+
+	g_assert_false(read_tmp_trace(trace->data, trace->len, 0, 0, NULL,
+						&size, &index, &opcode, &tv));
+
+	g_byte_array_unref(trace);
+}
+
+static void test_btsnoop_rejects_uart_short_type(void)
+{
+	GByteArray *trace = g_byte_array_new();
+	struct timeval tv;
+	uint16_t size = 0;
+	uint16_t index = 0;
+	uint16_t opcode = 0;
+
+	append_btsnoop_header(trace, BTSNOOP_FORMAT_UART);
+	append_btsnoop_packet(trace, 1, 0, BTSNOOP_EPOCH_OFFSET, NULL, 0);
+
+	g_assert_false(read_tmp_trace(trace->data, trace->len, 0, 0, NULL,
+						&size, &index, &opcode, &tv));
+
+	g_byte_array_unref(trace);
+}
+
+static void test_btsnoop_rejects_short_payload(void)
+{
+	GByteArray *trace = g_byte_array_new();
+	const uint8_t payload[] = { 0x01, 0x02 };
+	uint8_t data[3];
+	struct timeval tv;
+	uint16_t size = 0;
+	uint16_t index = 0;
+	uint16_t opcode = 0;
+
+	append_btsnoop_header(trace, BTSNOOP_FORMAT_HCI);
+	append_btsnoop_packet(trace, 3, 0x02, BTSNOOP_EPOCH_OFFSET,
+					payload, sizeof(payload));
+
+	g_assert_false(read_tmp_trace(trace->data, trace->len, 0,
+					sizeof(data), data, &size,
+					&index, &opcode, &tv));
+
+	g_byte_array_unref(trace);
+}
+
+static void test_pklg_big_endian_valid(void)
+{
+	GByteArray *trace = g_byte_array_new();
+	const uint8_t payload[] = { 0x0e, 0x01, 0x00 };
+	uint8_t data[sizeof(payload)];
+	struct timeval tv;
+	uint16_t size = 0;
+	uint16_t index = 0xffff;
+	uint16_t opcode = 0xffff;
+
+	append_pklg_packet(trace, false, sizeof(payload),
+			((uint64_t) 123 << 32) | 456, 0x01, payload,
+			sizeof(payload));
+
+	g_assert_true(read_tmp_trace(trace->data, trace->len,
+					BTSNOOP_FLAG_PKLG_SUPPORT, sizeof(data),
+					data, &size, &index, &opcode, &tv));
+	g_assert_cmpint(index, ==, 0);
+	g_assert_cmpint(opcode, ==, BTSNOOP_OPCODE_EVENT_PKT);
+	g_assert_cmpint(size, ==, sizeof(payload));
+	g_assert_cmpint(memcmp(data, payload, sizeof(payload)), ==, 0);
+	g_assert_cmpint(tv.tv_sec, ==, 123);
+	g_assert_cmpint(tv.tv_usec, ==, 456);
+
+	g_byte_array_unref(trace);
+}
+
+static void test_pklg_little_endian_valid(void)
+{
+	GByteArray *trace = g_byte_array_new();
+	const uint8_t payload[] = { 0x01, 0x02, 0x03 };
+	uint8_t data[sizeof(payload)];
+	struct timeval tv;
+	uint16_t size = 0;
+	uint16_t index = 0xffff;
+	uint16_t opcode = 0xffff;
+
+	append_pklg_packet(trace, true, sizeof(payload),
+			((uint64_t) 456 << 32) | 123, 0x00, payload,
+			sizeof(payload));
+
+	g_assert_true(read_tmp_trace(trace->data, trace->len,
+					BTSNOOP_FLAG_PKLG_SUPPORT, sizeof(data),
+					data, &size, &index, &opcode, &tv));
+	g_assert_cmpint(index, ==, 0);
+	g_assert_cmpint(opcode, ==, BTSNOOP_OPCODE_COMMAND_PKT);
+	g_assert_cmpint(size, ==, sizeof(payload));
+	g_assert_cmpint(data[0], ==, payload[0]);
+	g_assert_cmpint(tv.tv_sec, ==, 123);
+	g_assert_cmpint(tv.tv_usec, ==, 456);
+
+	g_byte_array_unref(trace);
+}
+
+static void test_pklg_rejects_short_length(void)
+{
+	GByteArray *trace = g_byte_array_new();
+	struct test_pklg_pkt pkt;
+	const uint8_t padding[] = { 0x00, 0x00, 0x00 };
+	struct timeval tv;
+	uint16_t size = 0;
+	uint16_t index = 0;
+	uint16_t opcode = 0;
+
+	pkt.len = htobe32(PKLG_PAYLOAD_OFFSET - 1);
+	pkt.ts = 0;
+	pkt.type = 0x01;
+
+	append_bytes(trace, &pkt, sizeof(pkt));
+	append_bytes(trace, padding, sizeof(padding));
+
+	g_assert_false(read_tmp_trace(trace->data, trace->len,
+					BTSNOOP_FLAG_PKLG_SUPPORT, 0, NULL,
+					&size, &index, &opcode, &tv));
+
+	g_byte_array_unref(trace);
+}
+
+static void test_pklg_rejects_small_capacity(void)
+{
+	GByteArray *trace = g_byte_array_new();
+	const uint8_t payload[] = { 0x01, 0x02, 0x03 };
+	uint8_t data[4] = { 0xa5, 0xa5, 0xa5, 0xa5 };
+	struct timeval tv;
+	uint16_t size = 0;
+	uint16_t index = 0;
+	uint16_t opcode = 0;
+
+	append_pklg_packet(trace, false, sizeof(payload), 0, 0x01, payload,
+							sizeof(payload));
+
+	g_assert_false(read_tmp_trace(trace->data, trace->len,
+					BTSNOOP_FLAG_PKLG_SUPPORT, 2, data,
+					&size, &index, &opcode, &tv));
+	g_assert_cmpint(data[0], ==, 0xa5);
+	g_assert_cmpint(data[1], ==, 0xa5);
+	g_assert_cmpint(data[2], ==, 0xa5);
+	g_assert_cmpint(data[3], ==, 0xa5);
+
+	g_byte_array_unref(trace);
+}
+
+static void test_pklg_rejects_short_payload(void)
+{
+	GByteArray *trace = g_byte_array_new();
+	const uint8_t payload[] = { 0x01, 0x02, 0x03 };
+	uint8_t data[4];
+	struct timeval tv;
+	uint16_t size = 0;
+	uint16_t index = 0;
+	uint16_t opcode = 0;
+
+	append_pklg_packet(trace, false, 4, 0, 0x01, payload,
+							sizeof(payload));
+
+	g_assert_false(read_tmp_trace(trace->data, trace->len,
+					BTSNOOP_FLAG_PKLG_SUPPORT, sizeof(data),
+					data, &size, &index, &opcode, &tv));
+
+	g_byte_array_unref(trace);
+}
+
+static void test_pklg_type_map(void)
+{
+	static const struct {
+		uint8_t type;
+		uint16_t index;
+		uint16_t opcode;
+	} cases[] = {
+		{ 0x02, 0x0000, BTSNOOP_OPCODE_ACL_TX_PKT },
+		{ 0x03, 0x0000, BTSNOOP_OPCODE_ACL_RX_PKT },
+		{ 0x08, 0x0000, BTSNOOP_OPCODE_SCO_TX_PKT },
+		{ 0x09, 0x0000, BTSNOOP_OPCODE_SCO_RX_PKT },
+		{ 0x12, 0x0000, BTSNOOP_OPCODE_ISO_TX_PKT },
+		{ 0x13, 0x0000, BTSNOOP_OPCODE_ISO_RX_PKT },
+		{ 0x0b, 0x0000, BTSNOOP_OPCODE_VENDOR_DIAG },
+		{ 0xfc, 0xffff, BTSNOOP_OPCODE_SYSTEM_NOTE },
+		{ 0xaa, 0xffff, 0xffff },
+	};
+	const uint8_t payload[] = { 0x00, 0x01, 0x02 };
+	unsigned int i;
+
+	for (i = 0; i < G_N_ELEMENTS(cases); i++) {
+		GByteArray *trace = g_byte_array_new();
+		uint8_t data[sizeof(payload)];
+		struct timeval tv;
+		uint16_t size = 0;
+		uint16_t index = 0;
+		uint16_t opcode = 0;
+
+		append_pklg_packet(trace, false, sizeof(payload), 0,
+						cases[i].type, payload,
+						sizeof(payload));
+
+		g_assert_true(read_tmp_trace(trace->data, trace->len,
+						BTSNOOP_FLAG_PKLG_SUPPORT,
+						sizeof(data), data, &size,
+						&index, &opcode, &tv));
+		g_assert_cmpint(index, ==, cases[i].index);
+		g_assert_cmpint(opcode, ==, cases[i].opcode);
+		g_byte_array_unref(trace);
+	}
+}
+
+static void test_btsnoop_truncation_fuzz(void)
+{
+	GByteArray *trace = g_byte_array_new();
+	const uint8_t payload[] = { 0x01, 0x02, 0x03 };
+	size_t len;
+
+	append_btsnoop_header(trace, BTSNOOP_FORMAT_HCI);
+	append_btsnoop_packet(trace, sizeof(payload), 0x02,
+			BTSNOOP_EPOCH_OFFSET, payload, sizeof(payload));
+
+	for (len = 0; len < trace->len; len++) {
+		uint8_t data[sizeof(payload)];
+		struct timeval tv;
+		uint16_t size = 0;
+		uint16_t index = 0;
+		uint16_t opcode = 0;
+
+		g_assert_false(read_tmp_trace(trace->data, len, 0,
+						sizeof(data), data, &size,
+						&index, &opcode, &tv));
+	}
+
+	g_byte_array_unref(trace);
+}
+
+static void test_pklg_truncation_fuzz(void)
+{
+	GByteArray *trace = g_byte_array_new();
+	const uint8_t payload[] = { 0x01, 0x02, 0x03 };
+	size_t len;
+
+	append_pklg_packet(trace, false, sizeof(payload), 0, 0x01, payload,
+							sizeof(payload));
+
+	for (len = 0; len < trace->len; len++) {
+		uint8_t data[sizeof(payload)];
+		struct timeval tv;
+		uint16_t size = 0;
+		uint16_t index = 0;
+		uint16_t opcode = 0;
+
+		g_assert_false(read_tmp_trace(trace->data, len,
+						BTSNOOP_FLAG_PKLG_SUPPORT,
+						sizeof(data), data, &size,
+						&index, &opcode, &tv));
+	}
+
+	g_byte_array_unref(trace);
+}
+
+int main(int argc, char *argv[])
+{
+	g_test_init(&argc, &argv, NULL);
+
+	g_test_add_func("/btsnoop/hci/valid", test_btsnoop_hci_valid);
+	g_test_add_func("/btsnoop/create/invalid",
+			test_btsnoop_create_invalid_args);
+	g_test_add_func("/btsnoop/open/invalid",
+			test_btsnoop_open_invalid_headers);
+	g_test_add_func("/btsnoop/write/hci-roundtrip",
+			test_btsnoop_write_hci_roundtrip);
+	g_test_add_func("/btsnoop/write/monitor-roundtrip",
+			test_btsnoop_write_monitor_roundtrip);
+	g_test_add_func("/btsnoop/write/phy-and-rotate",
+			test_btsnoop_write_phy_and_rotate);
+	g_test_add_func("/btsnoop/monitor/valid", test_btsnoop_monitor_valid);
+	g_test_add_func("/btsnoop/uart/valid", test_btsnoop_uart_valid);
+	g_test_add_func("/btsnoop/uart/opcode-map",
+			test_btsnoop_uart_opcode_map);
+	g_test_add_func("/btsnoop/capacity/reject",
+			test_btsnoop_rejects_small_capacity);
+	g_test_add_func("/btsnoop/timestamp/underflow",
+			test_btsnoop_rejects_timestamp_underflow);
+	g_test_add_func("/btsnoop/uart/zero-length",
+			test_btsnoop_rejects_uart_zero_length);
+	g_test_add_func("/btsnoop/uart/short-type",
+			test_btsnoop_rejects_uart_short_type);
+	g_test_add_func("/btsnoop/payload/short",
+			test_btsnoop_rejects_short_payload);
+	g_test_add_func("/pklg/big-endian/valid", test_pklg_big_endian_valid);
+	g_test_add_func("/pklg/little-endian/valid",
+			test_pklg_little_endian_valid);
+	g_test_add_func("/pklg/length/short", test_pklg_rejects_short_length);
+	g_test_add_func("/pklg/capacity/reject",
+			test_pklg_rejects_small_capacity);
+	g_test_add_func("/pklg/payload/short", test_pklg_rejects_short_payload);
+	g_test_add_func("/pklg/type-map", test_pklg_type_map);
+	g_test_add_func("/btsnoop/fuzz/truncation",
+			test_btsnoop_truncation_fuzz);
+	g_test_add_func("/pklg/fuzz/truncation", test_pklg_truncation_fuzz);
+
+	return g_test_run();
+}
diff --git a/unit/test-btsnoop.h b/unit/test-btsnoop.h
new file mode 100644
index 000000000..9a12f3e71
--- /dev/null
+++ b/unit/test-btsnoop.h
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+void add_pklg_tests(void);
-- 
2.43.0

