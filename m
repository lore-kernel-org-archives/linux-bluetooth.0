Return-Path: <cyrus@holtmann.org>
From: Michael Knudsen <michaelknudsendk@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Knudsen <m.knudsen@samsung.com>
Subject: [PATCH v2 3/3] Doco:  List the read codecs operation
Date: Fri, 23 Nov 2012 14:59:30 +0100
Message-Id: <1353679170-3738-4-git-send-email-m.knudsen@samsung.com>
In-Reply-To: <1353679170-3738-1-git-send-email-m.knudsen@samsung.com>
References: <1353679170-3738-1-git-send-email-m.knudsen@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 202c055..42af2d6 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -847,6 +847,26 @@ Set Device ID Command
 	a Command Status event on failure.
 
 
+Read Codecs Command
+====================
+
+	Command Code:		0x0029
+	Controller Index:	<controller id>
+	Command Parameters:
+	Return Parameters:
+				Num_Of_Codecs (1 Octet)
+				Codec1 (1 Octet)
+				Codec2 (1 Octet)
+				...
+
+	This command is used to read out the list of codecs that are
+	supported by the given controller.
+
+	This command generates a Command Complete event on success
+	or failure.
+
+
+
 Command Complete Event
 ======================
 
-- 
1.7.9.5

