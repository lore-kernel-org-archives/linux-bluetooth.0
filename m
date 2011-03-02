Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 1/3] hcitool: use defined constants for address type
Date: Wed,  2 Mar 2011 17:29:26 -0300
Message-Id: <1299097768-27237-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/hcitool.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/hcitool.c b/tools/hcitool.c
index e79d76b..3bdd3f5 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -2514,12 +2514,12 @@ static void cmd_lecc(int dev_id, int argc, char **argv)
 	uint16_t min_interval, supervision_timeout, window, handle;
 	uint8_t initiator_filter, own_bdaddr_type, peer_bdaddr_type;
 
-	peer_bdaddr_type = 0x00; /* Public device address */
+	peer_bdaddr_type = LE_PUBLIC_ADDRESS;
 
 	for_each_opt(opt, lecc_options, NULL) {
 		switch (opt) {
 		case 'r':
-			peer_bdaddr_type = 0x01; /* Random */
+			peer_bdaddr_type = LE_RANDOM_ADDRESS;
 			break;
 		default:
 			printf("%s", lecc_help);
-- 
1.7.4.1

