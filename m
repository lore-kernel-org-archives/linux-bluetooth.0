Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 13/62] Replace bt_get_le64() by get_le64()
Date: Thu, 20 Mar 2014 11:42:38 -0300
Message-Id: <1395326607-27068-14-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/l2cap.c        | 2 +-
 profiles/audio/avrcp.c | 3 ++-
 tools/parser/l2cap.c   | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 75363b5..993aa8b 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -932,7 +932,7 @@ static void sig_info_rsp(const struct l2cap_frame *frame)
 			packet_hexdump(data, size);
 			break;
 		}
-		print_channels(bt_get_le64(data));
+		print_channels(get_le64(data));
 		break;
 	default:
 		packet_hexdump(data, size);
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 4c5ab61..c7f2f0b 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -57,6 +57,7 @@
 #include "src/error.h"
 #include "src/sdpd.h"
 #include "src/dbus-common.h"
+#include "src/shared/util.h"
 
 #include "avctp.h"
 #include "avrcp.h"
@@ -1055,7 +1056,7 @@ static uint8_t avrcp_handle_get_element_attributes(struct avrcp *session,
 {
 	struct avrcp_player *player = target_get_player(session);
 	uint16_t len = ntohs(pdu->params_len);
-	uint64_t identifier = bt_get_le64(&pdu->params[0]);
+	uint64_t identifier = get_le64(&pdu->params[0]);
 	uint16_t pos;
 	uint8_t nattr;
 	GList *attr_ids;
diff --git a/tools/parser/l2cap.c b/tools/parser/l2cap.c
index f1f6a97..53dd726 100644
--- a/tools/parser/l2cap.c
+++ b/tools/parser/l2cap.c
@@ -854,7 +854,7 @@ static void info_opt(int level, int type, void *ptr, int len)
 				}
 		break;
 	case 0x0003:
-		fc_mask = bt_get_le64(ptr);
+		fc_mask = get_le64(ptr);
 		printf("Fixed channel list 0x%8.8" PRIx64 "\n", fc_mask);
 		if (parser.flags & DUMP_VERBOSE)
 			for (i=0; l2cap_fix_chan[i].name; i++)
-- 
1.8.3.1

