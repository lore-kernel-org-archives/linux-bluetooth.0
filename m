Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] add more features mask options to l2test
Date: Sun, 19 Apr 2009 17:10:01 -0300
Message-Id: <1240171801-16432-1-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add Enhanced Retransmission mode, Streaming mode and FCS Option.
---
 test/l2test.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/test/l2test.c b/test/l2test.c
index 57e0931..6276036 100644
--- a/test/l2test.c
+++ b/test/l2test.c
@@ -908,6 +908,12 @@ static void info_request(char *svr)
 			printf("  Retransmission mode\n");
 		if (mask & 0x04)
 			printf("  Bi-directional QoS\n");
+		if (mask & 0x08)
+			printf("  Enhanced Retransmission mode\n");
+		if (mask & 0x10)
+			printf("  Streaming mode\n");
+		if (mask & 0x20)
+			printf("  FCS Option\n");
 		break;
 	case 0x0001:
 		printf("Extended feature mask is not supported\n");
-- 
1.6.0.6

