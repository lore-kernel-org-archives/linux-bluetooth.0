Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH 2/2] monitor: Add handling of nop opcode
Date: Fri,  1 Sep 2017 10:07:44 +0200
Message-Id: <20170901080744.11544-2-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <20170901080744.11544-1-andrzej.kaczmarek@codecoup.pl>
References: <20170901080744.11544-1-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/packet.c     | 2 ++
 src/shared/btsnoop.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index f214790ac..3145b075b 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -4110,6 +4110,8 @@ void packet_monitor(struct timeval *tv, struct ucred *cred,
 	case BTSNOOP_OPCODE_CTRL_EVENT:
 		packet_ctrl_event(tv, cred, index, data, size);
 		break;
+	case BTSNOOP_OPCODE_NOP:
+		break;
 	default:
 		sprintf(extra_str, "(code %d len %d)", opcode, size);
 		print_packet(tv, cred, '*', index, NULL, COLOR_ERROR,
diff --git a/src/shared/btsnoop.h b/src/shared/btsnoop.h
index 3df8998a3..0038117ad 100644
--- a/src/shared/btsnoop.h
+++ b/src/shared/btsnoop.h
@@ -53,6 +53,7 @@
 #define BTSNOOP_OPCODE_CTRL_CLOSE	15
 #define BTSNOOP_OPCODE_CTRL_COMMAND	16
 #define BTSNOOP_OPCODE_CTRL_EVENT	17
+#define BTSNOOP_OPCODE_NOP		65535
 
 #define BTSNOOP_MAX_PACKET_SIZE		(1486 + 4)
 
-- 
2.14.1

