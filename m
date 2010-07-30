Return-Path: <cyrus@holtmann.org>
From: Inga Stotland <ingas@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: rshaffer@codeaurora.org, johan.hedberg@gmail.com,
	marcel@holtmann.org, Inga Stotland <ingas@codeaurora.org>
Subject: [PATCH 2/4] Use defines for the default values of txwin_size and max_transmit.
Date: Fri, 30 Jul 2010 11:30:24 -0700
Message-Id: <1280514626-22559-3-git-send-email-ingas@codeaurora.org>
In-Reply-To: <1280514626-22559-1-git-send-email-ingas@codeaurora.org>
References: <1280514626-22559-1-git-send-email-ingas@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/l2test.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/test/l2test.c b/test/l2test.c
index 0bb46f3..361f80c 100644
--- a/test/l2test.c
+++ b/test/l2test.c
@@ -76,10 +76,10 @@ static int omtu = 0;
 static int fcs = 0x01;
 
 /* Default Transmission Window */
-static int txwin_size = 63;
+static int txwin_size = L2CAP_DEFAULT_TX_WINDOW;
 
-/* Default Max Transmission */
-static int max_transmit = 3;
+/* Default Max Transmission (number of retries per packet) */
+static int max_transmit = L2CAP_DEFAULT_MAX_TX;
 
 /* Default data size */
 static long data_size = -1;
@@ -1073,8 +1073,8 @@ static void usage(void)
 		"\t[-D milliseconds] delay after sending num frames (default = 0)\n"
 		"\t[-X mode] select retransmission/flow-control mode\n"
 		"\t[-F fcs] use CRC16 check (default = 1)\n"
-		"\t[-Q num] Max Transmit value (default = 3)\n"
-		"\t[-Z size] Transmission Window size (default = 63)\n"
+		"\t[-Q num] Max Transmit value (default = %d)\n"
+		"\t[-Z size] Transmission Window size (default = %d)\n"
 		"\t[-R] reliable mode\n"
 		"\t[-G] use connectionless channel (datagram)\n"
 		"\t[-U] use sock stream\n"
@@ -1082,7 +1082,8 @@ static void usage(void)
 		"\t[-E] request encryption\n"
 		"\t[-S] secure connection\n"
 		"\t[-M] become master\n"
-		"\t[-T] enable timestamps\n");
+		"\t[-T] enable timestamps\n",
+		L2CAP_DEFAULT_MAX_TX, L2CAP_DEFAULT_TX_WINDOW);
 }
 
 int main(int argc, char *argv[])
-- 
1.7.2

--
Inga Stotland
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
