Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  1/3] monitor/packet: Fix ERROR CODES as per core_v4.2
Date: Wed, 10 Dec 2014 17:16:46 +0530
Message-id: <1418212008-8594-2-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1418212008-8594-1-git-send-email-gowtham.ab@samsung.com>
References: <1418212008-8594-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Modified the error codes as per core V4.2, Vol 2, Part D.
---
 monitor/packet.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 885c4b1..87b97ad 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -317,9 +317,10 @@ static const struct {
 	{ 0x1b, "SCO Offset Rejected"					},
 	{ 0x1c, "SCO Interval Rejected"					},
 	{ 0x1d, "SCO Air Mode Rejected"					},
-	{ 0x1e, "Invalid LMP Parameters"				},
+	{ 0x1e, "Invalid LMP Parameters / Invalid LL Parameters"	},
 	{ 0x1f, "Unspecified Error"					},
-	{ 0x20, "Unsupported LMP Parameter Value"			},
+	{ 0x20, "Unsupported LMP Parameter Value / "
+		"Unsupported LL Parameter Value"			},
 	{ 0x21, "Role Change Not Allowed"				},
 	{ 0x22, "LMP Response Timeout / LL Response Timeout"		},
 	{ 0x23, "LMP Error Transaction Collision"			},
@@ -346,7 +347,7 @@ static const struct {
 	{ 0x38, "Host Busy - Pairing"					},
 	{ 0x39, "Connection Rejected due to No Suitable Channel Found"	},
 	{ 0x3a, "Controller Busy"					},
-	{ 0x3b, "Unacceptable Connection Interval"			},
+	{ 0x3b, "Unacceptable Connection Parameters"			},
 	{ 0x3c, "Directed Advertising Timeout"				},
 	{ 0x3d, "Connection Terminated due to MIC Failure"		},
 	{ 0x3e, "Connection Failed to be Established"			},
-- 
1.9.1

