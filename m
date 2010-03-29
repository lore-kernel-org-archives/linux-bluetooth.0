Return-Path: <cyrus@holtmann.org>
From: Forrest Zhao <forrest.zhao@intel.com>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org, forrest.zhao@gmail.com,
	Forrest Zhao <forrest.zhao@intel.com>
Subject: [PATCH] Check modem_obj_path is not NULL
Date: Mon, 29 Mar 2010 16:32:54 -0400
Message-Id: <1269894774-3193-1-git-send-email-forrest.zhao@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This could prevent crash in case modem_obj_path is NULL.
---
 audio/telephony-ofono.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index 45c3905..c145e87 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -281,6 +281,10 @@ void telephony_dial_number_req(void *telephony_device, const char *number)
 
 	debug("telephony-ofono: dial request to %s", number);
 
+	if (!modem_obj_path)
+		telephony_dial_number_rsp(telephony_device,
+					CME_ERROR_AG_FAILURE);
+
 	if (!strncmp(number, "*31#", 4)) {
 		number += 4;
 		clir = "enabled";
@@ -311,6 +315,10 @@ void telephony_transmit_dtmf_req(void *telephony_device, char tone)
 
 	debug("telephony-ofono: transmit dtmf: %c", tone);
 
+	if (!modem_obj_path)
+		telephony_transmit_dtmf_rsp(telephony_device,
+					CME_ERROR_AG_FAILURE);
+
 	tone_string = g_strdup_printf("%c", tone);
 	ret = send_method_call(OFONO_BUS_NAME, modem_obj_path,
 			OFONO_VCMANAGER_INTERFACE,
@@ -531,6 +539,9 @@ done:
 
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

