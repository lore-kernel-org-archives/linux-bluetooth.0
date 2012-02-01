Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 3/3] tools: Make test-server to use ERTM
Date: Tue, 31 Jan 2012 17:25:36 -0800
Message-Id: <1328059536-6379-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1328059536-6379-1-git-send-email-luiz.dentz@gmail.com>
References: <1328059536-6379-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If port is bigger than 31 and stream mode is selected then use ERTM
---
 tools/test-server.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tools/test-server.c b/tools/test-server.c
index 7db153e..07d1328 100644
--- a/tools/test-server.c
+++ b/tools/test-server.c
@@ -324,7 +324,7 @@ static guint bluetooth_listen(void)
 	}
 
 	if (option_packet || option_channel > 31) {
-		type = BT_IO_L2CAP;
+		type = option_packet ? BT_IO_L2CAP : BT_IO_L2ERTM;
 		option = BT_IO_OPT_PSM;
 	} else {
 		type = BT_IO_RFCOMM;
-- 
1.7.7.6

