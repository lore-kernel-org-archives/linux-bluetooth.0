Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] audio/AVCTP: Add keys that can be mapped to uinput
Date: Wed,  5 Feb 2014 16:24:31 +0200
Message-Id: <1391610272-12991-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the remaining AV/C keys that can be mapped to uinput.
---
 android/avctp.c        | 28 ++++++++++++++++++++++++++++
 android/avctp.h        | 29 +++++++++++++++++++++++++++++
 profiles/audio/avctp.c | 28 ++++++++++++++++++++++++++++
 profiles/audio/avctp.h | 29 +++++++++++++++++++++++++++++
 4 files changed, 114 insertions(+)

diff --git a/android/avctp.c b/android/avctp.c
index 8f35403..f7544a2 100644
--- a/android/avctp.c
+++ b/android/avctp.c
@@ -215,25 +215,53 @@ static struct {
 	{ "ROOT MENU",		AVC_ROOT_MENU,		KEY_MENU },
 	{ "CONTENTS MENU",	AVC_CONTENTS_MENU,	KEY_PROGRAM },
 	{ "FAVORITE MENU",	AVC_FAVORITE_MENU,	KEY_FAVORITES },
+	{ "EXIT",		AVC_EXIT,		KEY_EXIT },
+	{ "ON DEMAND MENU",	AVC_ON_DEMAND_MENU,	KEY_MENU },
+	{ "APPS MENU",		AVC_APPS_MENU,		KEY_MENU },
+	{ "0",			AVC_0,			KEY_0 },
+	{ "1",			AVC_1,			KEY_1 },
+	{ "2",			AVC_2,			KEY_2 },
+	{ "3",			AVC_3,			KEY_3 },
+	{ "4",			AVC_4,			KEY_4 },
+	{ "5",			AVC_5,			KEY_5 },
+	{ "6",			AVC_6,			KEY_6 },
+	{ "7",			AVC_7,			KEY_7 },
+	{ "8",			AVC_8,			KEY_8 },
+	{ "9",			AVC_9,			KEY_9 },
+	{ "DOT",		AVC_DOT,		KEY_DOT },
 	{ "ENTER",		AVC_ENTER,		KEY_ENTER },
 	{ "CHANNEL UP",		AVC_CHANNEL_UP,		KEY_CHANNELUP },
 	{ "CHANNEL DOWN",	AVC_CHANNEL_DOWN,	KEY_CHANNELDOWN },
+	{ "CHANNEL PREVIOUS",	AVC_CHANNEL_PREVIOUS,	KEY_LAST },
 	{ "INPUT SELECT",	AVC_INPUT_SELECT,	KEY_CONFIG },
+	{ "INFO",		AVC_INFO,		KEY_INFO },
 	{ "HELP",		AVC_HELP,		KEY_HELP },
 	{ "POWER",		AVC_POWER,		KEY_POWER2 },
 	{ "VOLUME UP",		AVC_VOLUME_UP,		KEY_VOLUMEUP },
 	{ "VOLUME DOWN",	AVC_VOLUME_DOWN,	KEY_VOLUMEDOWN },
+	{ "MUTE",		AVC_MUTE,		KEY_MUTE },
 	{ "PLAY",		AVC_PLAY,		KEY_PLAYCD },
 	{ "STOP",		AVC_STOP,		KEY_STOPCD },
 	{ "PAUSE",		AVC_PAUSE,		KEY_PAUSECD },
 	{ "FORWARD",		AVC_FORWARD,		KEY_NEXTSONG },
 	{ "BACKWARD",		AVC_BACKWARD,		KEY_PREVIOUSSONG },
+	{ "RECORD",		AVC_RECORD,		KEY_RECORD },
 	{ "REWIND",		AVC_REWIND,		KEY_REWIND },
 	{ "FAST FORWARD",	AVC_FAST_FORWARD,	KEY_FASTFORWARD },
+	{ "LIST",		AVC_LIST,		KEY_LIST },
 	{ "F1",			AVC_F1,			KEY_F1 },
 	{ "F2",			AVC_F2,			KEY_F2 },
 	{ "F3",			AVC_F3,			KEY_F3 },
 	{ "F4",			AVC_F4,			KEY_F4 },
+	{ "F5",			AVC_F5,			KEY_F5 },
+	{ "F6",			AVC_F6,			KEY_F6 },
+	{ "F7",			AVC_F7,			KEY_F7 },
+	{ "F8",			AVC_F8,			KEY_F8 },
+	{ "F9",			AVC_F9,			KEY_F9 },
+	{ "RED",		AVC_RED,		KEY_RED },
+	{ "GREEN",		AVC_GREEN,		KEY_GREEN },
+	{ "BLUE",		AVC_BLUE,		KEY_BLUE },
+	{ "YELLOW",		AVC_YELLOW,		KEY_YELLOW },
 	{ NULL }
 };
 
diff --git a/android/avctp.h b/android/avctp.h
index e7e0277..dfa0ca6 100644
--- a/android/avctp.h
+++ b/android/avctp.h
@@ -56,11 +56,30 @@
 #define AVC_ROOT_MENU			0x09
 #define AVC_CONTENTS_MENU		0x0b
 #define AVC_FAVORITE_MENU		0x0c
+#define AVC_EXIT			0x0d
+#define AVC_ON_DEMAND_MENU		0x0e
+#define AVC_APPS_MENU			0x0f
+#define AVC_0				0x20
+#define AVC_1				0x21
+#define AVC_2				0x22
+#define AVC_3				0x23
+#define AVC_4				0x24
+#define AVC_5				0x25
+#define AVC_6				0x26
+#define AVC_7				0x27
+#define AVC_8				0x28
+#define AVC_9				0x29
+#define AVC_DOT				0x2a
 #define AVC_ENTER			0x2b
 #define AVC_CHANNEL_UP			0x30
 #define AVC_CHANNEL_DOWN		0x31
+#define AVC_CHANNEL_PREVIOUS		0x32
 #define AVC_INPUT_SELECT		0x34
+#define AVC_INFO			0x35
 #define AVC_HELP			0x36
+#define AVC_PAGE_UP			0x37
+#define AVC_PAGE_DOWN			0x38
+#define AVC_LOCK			0x3a
 #define AVC_POWER			0x40
 #define AVC_VOLUME_UP			0x41
 #define AVC_VOLUME_DOWN			0x42
@@ -74,10 +93,20 @@
 #define AVC_EJECT			0x4a
 #define AVC_FORWARD			0x4b
 #define AVC_BACKWARD			0x4c
+#define AVC_LIST			0x4d
 #define AVC_F1				0x71
 #define AVC_F2				0x72
 #define AVC_F3				0x73
 #define AVC_F4				0x74
+#define AVC_F5				0x75
+#define AVC_F6				0x76
+#define AVC_F7				0x77
+#define AVC_F8				0x78
+#define AVC_F9				0x79
+#define AVC_RED				0x7a
+#define AVC_GREEN			0x7b
+#define AVC_BLUE			0x7c
+#define AVC_YELLOW			0x7c
 
 struct avctp;
 
diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 9f87859..ae142bd 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -238,25 +238,53 @@ static struct {
 	{ "ROOT MENU",		AVC_ROOT_MENU,		KEY_MENU },
 	{ "CONTENTS MENU",	AVC_CONTENTS_MENU,	KEY_PROGRAM },
 	{ "FAVORITE MENU",	AVC_FAVORITE_MENU,	KEY_FAVORITES },
+	{ "EXIT",		AVC_EXIT,		KEY_EXIT },
+	{ "ON DEMAND MENU",	AVC_ON_DEMAND_MENU,	KEY_MENU },
+	{ "APPS MENU",		AVC_APPS_MENU,		KEY_MENU },
+	{ "0",			AVC_0,			KEY_0 },
+	{ "1",			AVC_1,			KEY_1 },
+	{ "2",			AVC_2,			KEY_2 },
+	{ "3",			AVC_3,			KEY_3 },
+	{ "4",			AVC_4,			KEY_4 },
+	{ "5",			AVC_5,			KEY_5 },
+	{ "6",			AVC_6,			KEY_6 },
+	{ "7",			AVC_7,			KEY_7 },
+	{ "8",			AVC_8,			KEY_8 },
+	{ "9",			AVC_9,			KEY_9 },
+	{ "DOT",		AVC_DOT,		KEY_DOT },
 	{ "ENTER",		AVC_ENTER,		KEY_ENTER },
 	{ "CHANNEL UP",		AVC_CHANNEL_UP,		KEY_CHANNELUP },
 	{ "CHANNEL DOWN",	AVC_CHANNEL_DOWN,	KEY_CHANNELDOWN },
+	{ "CHANNEL PREVIOUS",	AVC_CHANNEL_PREVIOUS,	KEY_LAST },
 	{ "INPUT SELECT",	AVC_INPUT_SELECT,	KEY_CONFIG },
+	{ "INFO",		AVC_INFO,		KEY_INFO },
 	{ "HELP",		AVC_HELP,		KEY_HELP },
 	{ "POWER",		AVC_POWER,		KEY_POWER2 },
 	{ "VOLUME UP",		AVC_VOLUME_UP,		KEY_VOLUMEUP },
 	{ "VOLUME DOWN",	AVC_VOLUME_DOWN,	KEY_VOLUMEDOWN },
+	{ "MUTE",		AVC_MUTE,		KEY_MUTE },
 	{ "PLAY",		AVC_PLAY,		KEY_PLAYCD },
 	{ "STOP",		AVC_STOP,		KEY_STOPCD },
 	{ "PAUSE",		AVC_PAUSE,		KEY_PAUSECD },
 	{ "FORWARD",		AVC_FORWARD,		KEY_NEXTSONG },
 	{ "BACKWARD",		AVC_BACKWARD,		KEY_PREVIOUSSONG },
+	{ "RECORD",		AVC_RECORD,		KEY_RECORD },
 	{ "REWIND",		AVC_REWIND,		KEY_REWIND },
 	{ "FAST FORWARD",	AVC_FAST_FORWARD,	KEY_FASTFORWARD },
+	{ "LIST",		AVC_LIST,		KEY_LIST },
 	{ "F1",			AVC_F1,			KEY_F1 },
 	{ "F2",			AVC_F2,			KEY_F2 },
 	{ "F3",			AVC_F3,			KEY_F3 },
 	{ "F4",			AVC_F4,			KEY_F4 },
+	{ "F5",			AVC_F5,			KEY_F5 },
+	{ "F6",			AVC_F6,			KEY_F6 },
+	{ "F7",			AVC_F7,			KEY_F7 },
+	{ "F8",			AVC_F8,			KEY_F8 },
+	{ "F9",			AVC_F9,			KEY_F9 },
+	{ "RED",		AVC_RED,		KEY_RED },
+	{ "GREEN",		AVC_GREEN,		KEY_GREEN },
+	{ "BLUE",		AVC_BLUE,		KEY_BLUE },
+	{ "YELLOW",		AVC_YELLOW,		KEY_YELLOW },
 	{ NULL }
 };
 
diff --git a/profiles/audio/avctp.h b/profiles/audio/avctp.h
index f9c665e..05fceb4 100644
--- a/profiles/audio/avctp.h
+++ b/profiles/audio/avctp.h
@@ -57,11 +57,30 @@
 #define AVC_ROOT_MENU			0x09
 #define AVC_CONTENTS_MENU		0x0b
 #define AVC_FAVORITE_MENU		0x0c
+#define AVC_EXIT			0x0d
+#define AVC_ON_DEMAND_MENU		0x0e
+#define AVC_APPS_MENU			0x0f
+#define AVC_0				0x20
+#define AVC_1				0x21
+#define AVC_2				0x22
+#define AVC_3				0x23
+#define AVC_4				0x24
+#define AVC_5				0x25
+#define AVC_6				0x26
+#define AVC_7				0x27
+#define AVC_8				0x28
+#define AVC_9				0x29
+#define AVC_DOT				0x2a
 #define AVC_ENTER			0x2b
 #define AVC_CHANNEL_UP			0x30
 #define AVC_CHANNEL_DOWN		0x31
+#define AVC_CHANNEL_PREVIOUS		0x32
 #define AVC_INPUT_SELECT		0x34
+#define AVC_INFO			0x35
 #define AVC_HELP			0x36
+#define AVC_PAGE_UP			0x37
+#define AVC_PAGE_DOWN			0x38
+#define AVC_LOCK			0x3a
 #define AVC_POWER			0x40
 #define AVC_VOLUME_UP			0x41
 #define AVC_VOLUME_DOWN			0x42
@@ -75,10 +94,20 @@
 #define AVC_EJECT			0x4a
 #define AVC_FORWARD			0x4b
 #define AVC_BACKWARD			0x4c
+#define AVC_LIST			0x4d
 #define AVC_F1				0x71
 #define AVC_F2				0x72
 #define AVC_F3				0x73
 #define AVC_F4				0x74
+#define AVC_F5				0x75
+#define AVC_F6				0x76
+#define AVC_F7				0x77
+#define AVC_F8				0x78
+#define AVC_F9				0x79
+#define AVC_RED				0x7a
+#define AVC_GREEN			0x7b
+#define AVC_BLUE			0x7c
+#define AVC_YELLOW			0x7c
 
 struct avctp;
 
-- 
1.8.5.3

