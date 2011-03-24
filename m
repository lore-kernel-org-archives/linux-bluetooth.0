Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v6 5/6] Update mgmt-api.txt with OOB commands
Date: Thu, 24 Mar 2011 14:47:38 +0100
Message-ID: <1300974459-24076-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1300974459-24076-1-git-send-email-szymon.janc@tieto.com>
References: <1300974459-24076-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index dd179ee..f02738e 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -274,6 +274,36 @@ Set Local Name Command
 	Command Parameters:	Name (249 Octets)
 	Return Paramters:	Name (249 Octets)
 
+Read Local Out Of Band Data Command
+========================================
+
+	Command Code:		0x0018
+	Controller Index:	<controller id>
+	Command Parameters:
+	Return Paramters:	Hash (16 Octets)
+				Randomizer (16 Octets)
+
+
+Add Remote Out Of Band Data Command
+========================================
+
+	Command Code:		0x0019
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
+	Command Code:		0x001A
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
+	Return Paramters:
+
+
 Read Tracing Buffer Size Command
 ================================
 
-- 
1.7.0.4

