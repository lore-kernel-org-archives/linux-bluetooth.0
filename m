Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump 2/2] core: set HCI channel explicitly when bind
Date: Wed, 22 Aug 2012 18:20:45 +0900
Message-id: <1345627245-19333-2-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1345627245-19333-1-git-send-email-chanyeol.park@samsung.com>
References: <1345627245-19333-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

---
 src/hcidump.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/hcidump.c b/src/hcidump.c
index 089d444..7423cdd 100644
--- a/src/hcidump.c
+++ b/src/hcidump.c
@@ -590,8 +590,10 @@ static int open_socket(int dev, unsigned long flags)
 	memset(&addr, 0, sizeof(addr));
 	addr.hci_family = AF_BLUETOOTH;
 	addr.hci_dev = dev;
+	addr.hci_channel = HCI_CHANNEL_RAW;
+
 	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-		printf("Can't attach to device hci%d. %s(%d)\n", 
+		printf("Can't attach to device hci%d. %s(%d)\n",
 					dev, strerror(errno), errno);
 		return -1;
 	}
-- 
1.7.9.5

