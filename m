Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>, <szymon.janc@tieto.com>,
	<luiz.dentz@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 1/2] sdp: Add MAP_PROFILE_ID
Date: Thu, 2 Jan 2014 13:54:45 +0100
Message-ID: <1388667286-28993-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/sdp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/sdp.h b/lib/sdp.h
index f2f2484..c6dfc27 100644
--- a/lib/sdp.h
+++ b/lib/sdp.h
@@ -207,6 +207,7 @@ extern "C" {
 #define PBAP_PCE_PROFILE_ID		PBAP_PCE_SVCLASS_ID
 #define PBAP_PSE_PROFILE_ID		PBAP_PSE_SVCLASS_ID
 #define PBAP_PROFILE_ID			PBAP_SVCLASS_ID
+#define MAP_PROFILE_ID			MAP_SVCLASS_ID
 #define PNP_INFO_PROFILE_ID		PNP_INFO_SVCLASS_ID
 #define GENERIC_NETWORKING_PROFILE_ID	GENERIC_NETWORKING_SVCLASS_ID
 #define GENERIC_FILETRANS_PROFILE_ID	GENERIC_FILETRANS_SVCLASS_ID
-- 
1.8.4

