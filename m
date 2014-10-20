Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	luiz.dentz@gmail.com, Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH 2/3] src/profile: Add feature bits to MAS SDP record
Date: Mon, 20 Oct 2014 20:34:28 +0530
Message-id: <1413817469-4255-2-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1413817469-4255-1-git-send-email-gowtham.ab@samsung.com>
References: <1413817469-4255-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add MAP supported features bits to MAS SDP record
as per the MAP 1.2 specs section 7.1.1.

Fix the PTS 5.3 test-cases:
TC_MSE_MFB_BV_02_I
TC_MSE_MFB_BV_05_I
---
 src/profile.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/profile.c b/src/profile.c
index 7aca3be..bccb145 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -439,6 +439,9 @@
 		<attribute id=\"0x0316\">				\
 			<uint8 value=\"0x0F\"/>				\
 		</attribute>						\
+		<attribute id=\"0x0317\">				\
+			<uint32 value=\"0x0000007f\"/>			\
+		</attribute>						\
 	</record>"
 
 #define MNS_RECORD							\
-- 
1.9.1

