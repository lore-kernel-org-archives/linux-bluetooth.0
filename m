Return-Path: <cyrus@holtmann.org>
From: Forrest Zhao <forrest.zhao@intel.com>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org, forrest.zhao@gmail.com,
	Forrest Zhao <forrest.zhao@intel.com>
Subject: [PATCH] Return error when modem_obj_path is NULL
Date: Mon, 29 Mar 2010 17:02:42 -0400
Message-Id: <1269896562-3408-1-git-send-email-forrest.zhao@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This could prevent crash in case modem_obj_path is NULL.
---
 audio/telephony-ofono.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index 45c3905..30f8b27 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -281,6 +281,12 @@ void telephony_dial_number_req(void *telephony_device, const char *number)
 
 	debug("telephony-ofono: dial request to %s", number);
 
+	if (!modem_obj_path) {
+		telephony_dial_number_rsp(telephony_device,
+					CME_ERROR_AG_FAILURE);
+		return;
+	}
+
 	if (!strncmp(number, "*31#", 4)) {
 		number += 4;
 		clir = "enabled";
@@ -311,6 +317,12 @@ void telephony_transmit_dtmf_req(void *telephony_device, char tone)
 
 	debug("telephony-ofono: transmit dtmf: %c", tone);
 
+	if (!modem_obj_path) {
+		telephony_transmit_dtmf_rsp(telephony_device,
+					CME_ERROR_AG_FAILURE);
+		return;
+	}
+
 	tone_string = g_strdup_printf("%c", tone);
 	ret = send_method_call(OFONO_BUS_NAME, modem_obj_path,
 			OFONO_VCMANAGER_INTERFACE,
@@ -531,6 +543,9 @@ done:
 
 static int get_registration_and_signal_status()
 {
+	if (!modem_obj_path)
+		return -ENOENT;
+
 	return send_method_call(OFONO_BUS_NAME, modem_obj_path,
 			OFONO_NETWORKREG_INTERFACE,
 			"GetProperties", get_registration_reply,
-- 
1.6.1.3

