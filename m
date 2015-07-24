Return-Path: <cyrus@holtmann.org>
From: abhirup.ghosh@intel.com
To: linux-bluetooth@vger.kernel.org
Cc: Abhirup Ghosh <abhirup.ghosh@intel.com>
Subject: [PATCH] Add support for ACL data transfer in emulator
Date: Fri, 24 Jul 2015 14:45:50 +0530
Message-Id: <1437729350-8852-1-git-send-email-abhirup.ghosh@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Abhirup Ghosh <abhirup.ghosh@intel.com>

---
 emulator/server.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/emulator/server.c b/emulator/server.c
index 76998d9..c28b15e 100644
--- a/emulator/server.c
+++ b/emulator/server.c
@@ -130,6 +130,7 @@ again:
 
 	while (count > 0) {
 		hci_command_hdr *cmd_hdr;
+		hci_acl_hdr *acl_hdr;
 
 		if (!client->pkt_data) {
 			client->pkt_type = ptr[0];
@@ -146,6 +147,12 @@ again:
 				client->pkt_data = malloc(client->pkt_expect);
 				client->pkt_len = 0;
 				break;
+			case HCI_ACLDATA_PKT:
+				acl_hdr = (hci_acl_hdr*)(ptr + 1);
+				client->pkt_expect = HCI_ACL_HDR_SIZE + acl_hdr->dlen + 1;
+				client->pkt_data = malloc(client->pkt_expect);
+				client->pkt_len = 0;
+				break;
 			default:
 				printf("packet error\n");
 				return;
-- 
1.9.1

