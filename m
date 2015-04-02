Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 3/3] btattach: Increase timeout for raw user channel creation
Date: Thu,  2 Apr 2015 16:38:03 +0200
Message-Id: <1427985483-31580-4-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1427985483-31580-1-git-send-email-frederic.danis@linux.intel.com>
References: <1427985483-31580-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As Bluetooth controller initialization is now performed in kernel, it can
take longer time to get user channel socket.
So move timeout from 1.5 seconds to 6 seconds.
---
 tools/btattach.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/btattach.c b/tools/btattach.c
index d97429e..8fc5868 100644
--- a/tools/btattach.c
+++ b/tools/btattach.c
@@ -153,7 +153,7 @@ static int attach_proto(const char *path, unsigned int proto,
 	printf("Device index %d attached\n", dev_id);
 
 	if (flags & (1 << HCI_UART_RAW_DEVICE)) {
-		unsigned int attempts = 6;
+		unsigned int attempts = 24;
 		struct bt_hci *hci;
 
 		while (attempts-- > 0) {
-- 
1.9.1

