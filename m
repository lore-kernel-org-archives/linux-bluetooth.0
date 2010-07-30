Return-Path: <cyrus@holtmann.org>
From: Inga Stotland <ingas@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: rshaffer@codeaurora.org, johan.hedberg@gmail.com,
	marcel@holtmann.org, Inga Stotland <ingas@codeaurora.org>
Subject: [PATCH 3/4] Added command argument "-J" to indicate preference of using AMP vs BR/EDR.
Date: Fri, 30 Jul 2010 11:30:25 -0700
Message-Id: <1280514626-22559-4-git-send-email-ingas@codeaurora.org>
In-Reply-To: <1280514626-22559-1-git-send-email-ingas@codeaurora.org>
References: <1280514626-22559-1-git-send-email-ingas@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Possible values: "require_br_edr", "prefer_amp", "prefer_br_edr"
---
 test/l2test.c |   34 +++++++++++++++++++++++++++++++++-
 1 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/test/l2test.c b/test/l2test.c
index 361f80c..377c12e 100644
--- a/test/l2test.c
+++ b/test/l2test.c
@@ -81,6 +81,9 @@ static int txwin_size = L2CAP_DEFAULT_TX_WINDOW;
 /* Default Max Transmission (number of retries per packet) */
 static int max_transmit = L2CAP_DEFAULT_MAX_TX;
 
+/* Default AMP preference */
+static int amp_pref = L2CAP_AMP_REQUIRE_BR_EDR;
+
 /* Default data size */
 static long data_size = -1;
 static long buffer_size = 2048;
@@ -295,6 +298,14 @@ static int do_connect(char *svr)
 		goto error;
 	}
 
+	/* Set AMP preference */
+	if ((rfcmode == L2CAP_MODE_ERTM || rfcmode == L2CAP_MODE_STREAMING) &&
+		setsockopt(sk, SOL_L2CAP, L2CAP_AMP, &amp_pref, sizeof(amp_pref)) < 0) {
+		syslog(LOG_ERR, "Can't set L2CAP AMP preference: %s (%d)",
+							strerror(errno), errno);
+		goto error;
+	}
+
 	/* Get current options */
 	memset(&opts, 0, sizeof(opts));
 	optlen = sizeof(opts);
@@ -458,6 +469,14 @@ static void do_listen(void (*handler)(int sk))
 		/* Child */
 		close(sk);
 
+		/* Set AMP preference */
+		if ((rfcmode == L2CAP_MODE_ERTM || rfcmode == L2CAP_MODE_STREAMING) &&
+			setsockopt(nsk, SOL_L2CAP, L2CAP_AMP, &amp_pref, sizeof(amp_pref)) < 0) {
+			syslog(LOG_ERR, "Can't set L2CAP AMP preference: %s (%d)",
+				   strerror(errno), errno);
+			goto error;
+		}
+
 		/* Get current options */
 		memset(&opts, 0, sizeof(opts));
 		optlen = sizeof(opts);
@@ -1075,6 +1094,8 @@ static void usage(void)
 		"\t[-F fcs] use CRC16 check (default = 1)\n"
 		"\t[-Q num] Max Transmit value (default = %d)\n"
 		"\t[-Z size] Transmission Window size (default = %d)\n"
+		"\t[-J amp] declare amp preference\n"
+		"\t         (require_br_edr, prefer_amp, prefer_br_edr)\n"
 		"\t[-R] reliable mode\n"
 		"\t[-G] use connectionless channel (datagram)\n"
 		"\t[-U] use sock stream\n"
@@ -1093,7 +1114,7 @@ int main(int argc, char *argv[])
 
 	bacpy(&bdaddr, BDADDR_ANY);
 
-	while ((opt=getopt(argc,argv,"rdscuwmntqxyzpb:i:P:I:O:B:N:L:W:C:D:X:F:Q:Z:RUGAESMT")) != EOF) {
+	while ((opt=getopt(argc,argv,"rdscuwmntqxyzpb:i:P:I:O:B:N:L:W:C:D:X:F:Q:Z:J:RUGAESMT")) != EOF) {
 		switch(opt) {
 		case 'r':
 			mode = RECV;
@@ -1217,6 +1238,17 @@ int main(int argc, char *argv[])
 			fcs = atoi(optarg);
 			break;
 
+		case 'J':
+			if (strcasecmp(optarg, "require_br_edr") == 0)
+				amp_pref = L2CAP_AMP_REQUIRE_BR_EDR;
+			else if (strcasecmp(optarg, "prefer_amp") == 0)
+				amp_pref = L2CAP_AMP_PREFER_AMP;
+			else if (strcasecmp(optarg, "prefer_br_edr") == 0)
+				amp_pref = L2CAP_AMP_PREFER_BR_EDR;
+			else
+				perror("Bad AMP preference");
+			break;
+
 		case 'R':
 			reliable = 1;
 			break;
-- 
1.7.2

--
Inga Stotland
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
