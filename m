Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Tomasz Gorochowik <tgorochowik@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Tomasz Gorochowik <tgorochowik@gmail.com>
Subject: [PATCH BlueZ] lib/sdp: Remove deprecated VIDEO_CONF profile id
Date: Sat, 10 Dec 2016 23:59:26 +0100
Message-Id: <20161210225926.10179-1-tgorochowik@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Commit 75e0c32af6bf ("lib/sdp: Replace VIDEO_CONF_SVCLASS_ID with
AV_REMOTE_CONTROLLER_SVCLASS_ID") removed the deprecated
VIDEO_CONF_SVCLASS_ID definition, but left the corresponding profile
definition..

According to the specification linked below A/V_RemoteControlController
UUID can only be used as a service class so its profile definition
should be removed.

https://www.bluetooth.org/en-us/specification/assigned-numbers/service-discovery
---
 lib/sdp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/sdp.h b/lib/sdp.h
index cc10e9f..f586eb5 100644
--- a/lib/sdp.h
+++ b/lib/sdp.h
@@ -176,7 +176,6 @@ extern "C" {
 #define AV_REMOTE_TARGET_PROFILE_ID	AV_REMOTE_TARGET_SVCLASS_ID
 #define ADVANCED_AUDIO_PROFILE_ID	ADVANCED_AUDIO_SVCLASS_ID
 #define AV_REMOTE_PROFILE_ID		AV_REMOTE_SVCLASS_ID
-#define VIDEO_CONF_PROFILE_ID		VIDEO_CONF_SVCLASS_ID
 #define INTERCOM_PROFILE_ID		INTERCOM_SVCLASS_ID
 #define FAX_PROFILE_ID			FAX_SVCLASS_ID
 #define HEADSET_AGW_PROFILE_ID		HEADSET_AGW_SVCLASS_ID
-- 
2.10.2

