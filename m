Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  1/3] src/profile: Add pbapsupportedfeatures to PSE
Date: Wed, 12 Nov 2014 14:31:35 +0530
Message-id: <1415782897-11667-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add PbapSupportedFeatures(0x0317) to PSE Record.

PTS Test case passed:
TP/SSM/BV-11-C [PSE Shares PbapSupportedFeatures bits].
---
 src/profile.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/profile.c b/src/profile.c
index bccb145..252063b 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -393,6 +393,9 @@
 		<attribute id=\"0x0314\">				\
 			<uint8 value=\"0x01\"/>				\
 		</attribute>						\
+		<attribute id=\"0x0317\">				\
+			<uint32 value=\"0x00000003\"/>			\
+		</attribute>						\
 	</record>"
 
 #define MAS_RECORD							\
-- 
1.9.1

