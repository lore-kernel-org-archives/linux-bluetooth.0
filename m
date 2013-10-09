Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/7] lib/sdp: Replace VIDEO_CONF_SVCLASS_ID with AV_REMOTE_CONTROLLER_SVCLASS_ID
Date: Wed,  9 Oct 2013 14:11:42 +0300
Message-Id: <1381317105-10729-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1381317105-10729-1-git-send-email-luiz.dentz@gmail.com>
References: <1381317105-10729-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

VCP apparently was never adopted so 0x110f was latter reused by AVRCP 1.3
controller as per current assigned numbers page:

https://www.bluetooth.org/en-us/specification/assigned-numbers/service-discovery
---
 lib/sdp.c         | 2 +-
 lib/sdp.h         | 2 +-
 src/glib-helper.c | 1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 1405c50..cbdf15e 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -125,7 +125,7 @@ static struct tupla ServiceClass[] = {
 	{ AV_REMOTE_TARGET_SVCLASS_ID,		"AV Remote Target"		},
 	{ ADVANCED_AUDIO_SVCLASS_ID,		"Advanced Audio"		},
 	{ AV_REMOTE_SVCLASS_ID,			"AV Remote"			},
-	{ VIDEO_CONF_SVCLASS_ID,		"Video Conferencing"		},
+	{ AV_REMOTE_CONTROLLER_SVCLASS_ID,	"AV Remote Controller"		},
 	{ INTERCOM_SVCLASS_ID,			"Intercom"			},
 	{ FAX_SVCLASS_ID,			"Fax"				},
 	{ HEADSET_AGW_SVCLASS_ID,		"Headset Audio Gateway"		},
diff --git a/lib/sdp.h b/lib/sdp.h
index 4ef2176..f2f2484 100644
--- a/lib/sdp.h
+++ b/lib/sdp.h
@@ -95,7 +95,7 @@ extern "C" {
 #define AV_REMOTE_TARGET_SVCLASS_ID	0x110c
 #define ADVANCED_AUDIO_SVCLASS_ID	0x110d
 #define AV_REMOTE_SVCLASS_ID		0x110e
-#define VIDEO_CONF_SVCLASS_ID		0x110f
+#define AV_REMOTE_CONTROLLER_SVCLASS_ID	0x110f
 #define INTERCOM_SVCLASS_ID		0x1110
 #define FAX_SVCLASS_ID			0x1111
 #define HEADSET_AGW_SVCLASS_ID		0x1112
diff --git a/src/glib-helper.c b/src/glib-helper.c
index a9a9a6e..4a020e9 100644
--- a/src/glib-helper.c
+++ b/src/glib-helper.c
@@ -103,7 +103,6 @@ static struct {
 	const char	*name;
 	uint16_t	class;
 } bt_services[] = {
-	{ "vcp",	VIDEO_CONF_SVCLASS_ID		},
 	{ "pbap",	PBAP_SVCLASS_ID			},
 	{ "sap",	SAP_SVCLASS_ID			},
 	{ "ftp",	OBEX_FILETRANS_SVCLASS_ID	},
-- 
1.8.3.1

