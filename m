Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v5 5/6] Update mgmt-api.txt with OOB commands
Date: Fri, 4 Mar 2011 16:08:34 +0100
Message-ID: <1299251315-2041-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1299251315-2041-1-git-send-email-szymon.janc@tieto.com>
References: <1299251315-2041-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 8e0e83b..34fdd1e 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -266,6 +266,36 @@ User Confirmation Negative Reply Command
 				Status (1 Octet)
 
 
+Read Local Out Of Band Data Command
+========================================
+
+	Command Code:		0x0017
+	Controller Index:	<controller id>
+	Command Parameters:
+	Return Paramters:	Hash (16 Octets)
+				Randomizer (16 Octets)
+
+
+Add Remote Out Of Band Data Command
+========================================
+
+	Command Code:		0x0018
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
+				Hash (16 Octets)
+				Randomizer (16 Octets)
+	Return Paramters:
+
+
+Remove Remote Out Of Band Data Command
+========================================
+
+	Command Code:		0x0019
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
+	Return Paramters:
+
+
 Read Tracing Buffer Size Command
 ================================
 
-- 
1.7.0.4

