Return-Path: <cyrus@holtmann.org>
From: Forrest Zhao <forrest.zhao@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Forrest Zhao <forrest.zhao@intel.com>
Subject: [PATCH] change OFONO_MANAGER_INTERFACE to get aligned with ofono interface
Date: Wed,  3 Jun 2009 13:23:38 +0800
Message-Id: <1244006618-19952-1-git-send-email-forrest.zhao@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/telephony-ofono.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index d1c9676..4b5f537 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -58,7 +58,7 @@ static GSList *calls = NULL;
 
 #define OFONO_BUS_NAME "org.ofono"
 #define OFONO_PATH "/"
-#define OFONO_MANAGER_INTERFACE "org.ofono.ModemManager"
+#define OFONO_MANAGER_INTERFACE "org.ofono.Manager"
 #define OFONO_NETWORKREG_INTERFACE "org.ofono.NetworkRegistration"
 #define OFONO_VCMANAGER_INTERFACE "org.ofono.VoiceCallManager"
 #define OFONO_VC_INTERFACE "org.ofono.VoiceCall"
-- 
1.5.4.5

