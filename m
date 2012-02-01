Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 2/3] tools: Make test-client use ERTM
Date: Tue, 31 Jan 2012 17:25:35 -0800
Message-Id: <1328059536-6379-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1328059536-6379-1-git-send-email-luiz.dentz@gmail.com>
References: <1328059536-6379-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If port is bigger than 31 and stream mode is selected then use ERTM
---
 tools/test-client.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/test-client.c b/tools/test-client.c
index e27cd3c..8484000 100644
--- a/tools/test-client.c
+++ b/tools/test-client.c
@@ -354,8 +354,8 @@ static GIOChannel *bluetooth_connect(GObexTransportType transport)
 	if (option_dest == NULL || option_channel < 0)
 		return NULL;
 
-	if (transport == G_OBEX_TRANSPORT_PACKET || option_channel > 31) {
-		type = BT_IO_L2CAP;
+	if (option_channel > 31) {
+		type = option_packet ? BT_IO_L2CAP : BT_IO_L2ERTM;
 		option = BT_IO_OPT_PSM;
 	} else {
 		type = BT_IO_RFCOMM;
-- 
1.7.7.6

