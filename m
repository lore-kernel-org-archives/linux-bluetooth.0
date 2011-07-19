Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [RFC 09/19] avrcp: handle InformBatteryStatusOfCT pdu
Date: Tue, 19 Jul 2011 16:49:20 -0300
Message-Id: <1311104970-18600-10-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/control.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 2825e6c..866a558 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -120,6 +120,7 @@
 #define AVRCP_GET_PLAYER_ATTRIBUTE_TEXT	0x15
 #define AVRCP_GET_PLAYER_VALUE_TEXT	0x16
 #define AVRCP_DISPLAYABLE_CHARSET	0x17
+#define AVRCP_CT_BATTERY_STATUS		0x18
 
 /* Capabilities for AVRCP_GET_CAPABILITIES pdu */
 #define CAP_COMPANY_ID		0x02
@@ -158,6 +159,14 @@ enum scan_mode {
 	SCAN_MODE_GROUP =	3,
 };
 
+enum battery_status {
+	BATTERY_STATUS_NORMAL =		0,
+	BATTERY_STATUS_WARNING =	1,
+	BATTERY_STATUS_CRITICAL =	2,
+	BATTERY_STATUS_EXTERNAL =	3,
+	BATTERY_STATUS_FULL_CHARGE =	4,
+};
+
 static DBusConnection *connection = NULL;
 
 static GSList *servers = NULL;
@@ -585,6 +594,24 @@ static const char *setting_to_string(enum player_setting setting)
 	return NULL;
 }
 
+static const char *battery_status_to_string(enum battery_status status)
+{
+	switch (status) {
+	case (BATTERY_STATUS_NORMAL):
+		return "normal";
+	case (BATTERY_STATUS_WARNING):
+		return "warning";
+	case (BATTERY_STATUS_CRITICAL):
+		return "critical";
+	case (BATTERY_STATUS_EXTERNAL):
+		return "external";
+	case (BATTERY_STATUS_FULL_CHARGE):
+		return "fullcharge";
+	}
+
+	return NULL;
+}
+
 static void append_variant(DBusMessageIter *iter, int type, void *val)
 {
 	DBusMessageIter value;
@@ -853,6 +880,29 @@ static int handle_vendordep_pdu(struct control *control,
 
 		return AVRCP_HEADER_LENGTH +
 			AVRCP_SPECAVCPDU_HEADER_LENGTH;
+	case AVRCP_CT_BATTERY_STATUS:
+		if (len == 1 && avrcp->code == CTYPE_STATUS) {
+			const char *value;
+
+			value = battery_status_to_string(pdu->params[0]);
+			if (value == NULL) {
+				pdu->params[0] = E_INVALID_PARAM;
+				goto err_metadata;
+			}
+
+			emit_setting_changed(control->dev->conn,
+						control->dev->path,
+						AUDIO_CONTROL_INTERFACE,
+						"Battery",
+						DBUS_TYPE_STRING, &value);
+
+			pdu->params_len = 0;
+
+			return AVRCP_HEADER_LENGTH +
+				AVRCP_SPECAVCPDU_HEADER_LENGTH;
+		}
+
+		break;
 	}
 
 	/*
@@ -1682,6 +1732,7 @@ static GDBusSignalTable control_signals[] = {
 	{ "Connected",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED},
 	{ "Disconnected",		"",	G_DBUS_SIGNAL_FLAG_DEPRECATED},
 	{ "PropertyChanged",		"sv"	},
+	{ "SettingChanged",		"sv"	},
 	{ NULL, NULL }
 };
 
-- 
1.7.6

