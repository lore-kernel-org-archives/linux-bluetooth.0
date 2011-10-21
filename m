Return-Path: <cyrus@holtmann.org>
From: Peter Krystad <pkrystad@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: andrei.emeltchenko@intel.com,
	Peter Krystad <pkrystad@codeaurora.org>
Subject: [PATCH 3/4] Add parsing of L2CAP Fixed Channel list
Date: Fri, 21 Oct 2011 16:30:01 -0700
Message-Id: <1319239802-22457-4-git-send-email-pkrystad@codeaurora.org>
In-Reply-To: <1319239802-22457-1-git-send-email-pkrystad@codeaurora.org>
References: <1319239802-22457-1-git-send-email-pkrystad@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add DUMP_VERBOSE display of L2CAP Fixed Channel list.
Example output:

2011-10-21 12:01:50.423246 > ACL data: handle 39 flags 0x02 dlen 20
    L2CAP(s): Info rsp: type 3 result 0
      Fixed channel list
        L2CAP
        CONNLESS
        A2MP
---
 parser/l2cap.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/parser/l2cap.c b/parser/l2cap.c
index 7915788..ce78d05 100644
--- a/parser/l2cap.c
+++ b/parser/l2cap.c
@@ -811,6 +811,7 @@ static void info_opt(int level, int type, void *ptr, int len)
 {
 	uint32_t mask;
 	int i;
+	uint8_t list;
 
 	p_indent(level, 0);
 
@@ -830,6 +831,21 @@ static void info_opt(int level, int type, void *ptr, int len)
 		break;
 	case 0x0003:
 		printf("Fixed channel list\n");
+		list = get_val(ptr, 1);
+		if (parser.flags & DUMP_VERBOSE) {
+			if (list & L2CAP_FC_L2CAP) {
+				p_indent(level + 1, 0);
+				printf("L2CAP\n");
+			}
+			if (list & L2CAP_FC_CONNLESS) {
+				p_indent(level + 1, 0);
+				printf("CONNLESS\n");
+			}
+			if (list & L2CAP_FC_A2MP) {
+				p_indent(level + 1, 0);
+				printf("A2MP\n");
+			}
+		}
 		break;
 	default:
 		printf("Unknown (len %d)\n", len);
-- 
1.7.7

--
Peter Krystad
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
