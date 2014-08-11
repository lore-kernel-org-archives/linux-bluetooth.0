Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 01/10] monitor: Fix segmentation fault with malformed packet
Date: Mon, 11 Aug 2014 10:50:36 +0300
Message-Id: <1407743445-1329-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Do not allow to read more then buffer size.
This fixes segmentation fault reading capture from target (apparently
end of the trace was broken).
---
 monitor/btsnoop.c    | 7 +++++++
 src/shared/btsnoop.c | 5 +++++
 src/shared/btsnoop.h | 2 ++
 3 files changed, 14 insertions(+)

diff --git a/monitor/btsnoop.c b/monitor/btsnoop.c
index fafeff8..ec19812 100644
--- a/monitor/btsnoop.c
+++ b/monitor/btsnoop.c
@@ -304,6 +304,13 @@ int btsnoop_read_hci(struct timeval *tv, uint16_t *index, uint16_t *opcode,
 	}
 
 	toread = be32toh(pkt.size);
+	if (toread > MAX_PACKET_SIZE) {
+		perror("Packet len suspicially big: %u", toread);
+		close(btsnoop_fd);
+		btsnoop_fd = -1;
+		return -1;
+	}
+
 	flags = be32toh(pkt.flags);
 
 	ts = be64toh(pkt.ts) - 0x00E03AB44A676000ll;
diff --git a/src/shared/btsnoop.c b/src/shared/btsnoop.c
index 17a872c..521be10 100644
--- a/src/shared/btsnoop.c
+++ b/src/shared/btsnoop.c
@@ -415,6 +415,11 @@ bool btsnoop_read_hci(struct btsnoop *btsnoop, struct timeval *tv,
 	}
 
 	toread = be32toh(pkt.size);
+	if (toread > MAX_PACKET_SIZE) {
+		btsnoop->aborted = true;
+		return false;
+	}
+
 	flags = be32toh(pkt.flags);
 
 	ts = be64toh(pkt.ts) - 0x00E03AB44A676000ll;
diff --git a/src/shared/btsnoop.h b/src/shared/btsnoop.h
index 2c55d02..9f73913 100644
--- a/src/shared/btsnoop.h
+++ b/src/shared/btsnoop.h
@@ -44,6 +44,8 @@
 #define BTSNOOP_OPCODE_SCO_TX_PKT	6
 #define BTSNOOP_OPCODE_SCO_RX_PKT	7
 
+#define MAX_PACKET_SIZE (1486 + 4)
+
 struct btsnoop_opcode_new_index {
 	uint8_t  type;
 	uint8_t  bus;
-- 
1.9.1

