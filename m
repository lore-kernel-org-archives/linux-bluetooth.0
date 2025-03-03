Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6A7235362
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Mar 2025 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741031514; cv=none; b=TqEQL9yL643Qvy0FC8fLuo1vXeL8P5Pg5CEndM/aD8RxmxCLyD7z9Peg/jIwvjxJBxJ10P9o6WEl3dL2MdVFPJcuZ420mACAUgWNKUpcJTRTk5LhZSD2m/oGWvab9J/lOlCi7RattOBND/jCdhK9htwH86Eafo0tXSB6V71rPpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741031514; c=relaxed/simple;
	bh=YGJKguHTfBgvmcSTUKAsdjy24R5ytyTK3ChrVHENf84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dqDCDMnbgaE6oItjSpjc5CPiCknOhaNhxslWgrApK/10w5ENr3mL3nzNIJqhb6BQvw8VY0eoWGpfy3iTklbut9lnU4sAsxGjxRGWVXdxmaMtwz6ZzH0NNImOBzudtzzYvbU+bmrNvMvaqgfHcndRJTWx5bBZUW8sezM8UvR4swA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDM9hxYo; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDM9hxYo"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e4c0c12bccso8528198a12.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Mar 2025 11:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741031510; x=1741636310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74PkvpzjSCXfCcGRtx4XfG/LFKUWr4izPBAV9lHvqb0=;
        b=PDM9hxYopvT3cm703dA4VRVHXabe48mxrcaPaOxryAz5p+MXd5AKmJCGtwo38sv0RT
         znpcHObAxaHF4WTqv0Mv/bfsDsctoP2BoiTAimeY+b9eaB9gUuMUpAzPjfKwuHoxfkHK
         5QbWwglUvVRhAzdalBdwCUCXbU0rzBc7wmToKB+rLfby2cXb0HxwZBTqNd/71gWsng4U
         qFxndGYbFTfA0bXe4se2gcdKs04mzXa/lfGP77xwqxwTlw9KLscL4HmLPdvl7bZA1l3R
         hiZQ3Z9sYMlhmBQLxjFKzJzWcWrXfgiNwKIKr3fnN4R2g1amW7SsoiwgNZcNuo08PdLc
         0DAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741031510; x=1741636310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74PkvpzjSCXfCcGRtx4XfG/LFKUWr4izPBAV9lHvqb0=;
        b=p9ZSTJZ2lTMKwIa/tyyfRXdvETJjl6mXATKMlHpetqca7zFenwwz/1aFQz5aA81LGN
         rwzK9t3H/gJR8tRYpenTIyY3WQbwtwJnQf/MSno1WtRS4r7/wBQliXySY9He7nFFWy3F
         bnm8sUi4UAq9NuJfGiRMrddmUAXDydZO6trFj3Q70fPVY7Tw8VsIZ3WBHoIlAzRQ1B5O
         jvI81WN4nJjvGdJloTif5mZ5oSHr66OBrScWAaDyVmHOTz+Gs/uxFd1QgzsT+LD2lAsV
         KogFiDkS6CF9oe963NdMhXFoXPKXrFHMmbCWcGO4jdWTKTHK0xTKxjZ2Fn/e+Xe0BDqt
         q08A==
X-Forwarded-Encrypted: i=1; AJvYcCWoV+WB49031bBoIQtC5eJu5iXL7xpUozHzC1TX1ZMg91BHJRtbTpas/Lnqjs9Di4Nl+C6eqb1ELAWYhko5MXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5K0Ax0bG6tiPbcmIPF6UdHBNmWeC9RT3+0zVg8Y1Tnck+lLyS
	LIr8eCpPevmTJJMtf6zljOiVwEDy7swNAjPuQGPixJ7fxrU2Y7m4
X-Gm-Gg: ASbGncsLvELou8LvcDIqwKtdkkBjQqI0076spyqSnFc5NcNmqbBargnUFRqZufNmcLR
	caa430Itn4O1t4sDcjbkwfHdr3h3ID2u4hEBgfGxaMFonRp+muT241QON/JnicPiZXBPMOV0pfe
	vjG36MmgofqibPLx6bZmDfYogBLglW9yxRIKT2rIhyXxlaZOHdSk6Ytpr2BS2CLYs86PmfoCMEd
	XJbK7Q8KGcOo0iQZSpBkrUnERMyRbpdjALE3I/XkwRg98qwB+zVA0B3Z2F/OUnkhftx+1lB2QXA
	FCV//cR6mwt35Ju0T5Lhf08/WjS6EupNOGk+LNBewWhtRHqFc1izlPyEGz+mKX8jqPNgrNC9RT5
	oxd1H+tIMm2DbIPV9+/Gm03ZdW3QUJVbibUPRBw==
X-Google-Smtp-Source: AGHT+IEGx8vc5e9ATBG9tNdf6U6kEc34jc6HA/3PthnOYhZjMnuSHS/Go+EgbI0dodl02wfBhZ/F+w==
X-Received: by 2002:a17:907:6d0b:b0:ac1:db49:99b7 with SMTP id a640c23a62f3a-ac1db49a9fdmr373858966b.51.1741031509862;
        Mon, 03 Mar 2025 11:51:49 -0800 (PST)
Received: from localhost.localdomain (46.205.201.86.nat.ftth.dynamic.t-mobile.pl. [46.205.201.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf6da2d659sm316744866b.6.2025.03.03.11.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 11:51:49 -0800 (PST)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: luiz.dentz@gmail.com
Cc: arkadiusz.bokowy@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] client: Support single profile connection/disconnection
Date: Mon,  3 Mar 2025 20:51:40 +0100
Message-Id: <20250303195140.30908-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CABBYNZJNHZ0RGA793bqhK_3VEyW-RQw+zwgLu7xgKNqpmMzYag@mail.gmail.com>
References: <CABBYNZJNHZ0RGA793bqhK_3VEyW-RQw+zwgLu7xgKNqpmMzYag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 client/bluetoothctl.rst | 20 +++++++--
 client/main.c           | 93 +++++++++++++++++++++++++++++++++++------
 src/uuid-helper.c       | 32 +++++++-------
 3 files changed, 114 insertions(+), 31 deletions(-)

diff --git a/client/bluetoothctl.rst b/client/bluetoothctl.rst
index b6c2efa35..c60bf719f 100644
--- a/client/bluetoothctl.rst
+++ b/client/bluetoothctl.rst
@@ -9,7 +9,7 @@ Bluetooth Control Command Line Tool
 :Version: BlueZ
 :Copyright: Free use of this software is granted under the terms of the GNU
             Lesser General Public Licenses (LGPL).
-:Date: November 2022
+:Date: March 2024
 :Manual section: 1
 :Manual group: Linux System Administration
 
@@ -262,6 +262,13 @@ Connect device.
 
 This will initiate a connection to a device.
 
+By default this commands tries to connect all the profiles the remote device
+supports and have been flagged as auto-connectable. In case when the UUID of
+the remote service is given only that service will be connected. The UUID can
+be either a short form (16-bit UUID) or a long form (128-bit UUID). There are
+also some special values for well-known profiles like "a2dp-sink",
+"a2dp-source", "hfp-hf", "hfp-ag", "ftp" or "spp".
+
 To connect with an LE device the controller must have an active scan report of
 the device it wants to connect to.
 
@@ -269,17 +276,24 @@ If no advertising report is received before the timeout a
 le-connection-abort-by-local error will be issued. In that case either try
 again to connect assuming the device is advertising.
 
-:Usage: **> connect <dev>**
+:Usage: **> connect <dev> [uuid]**
+:Example: **> connect 1C:48:F9:9D:81:5C hsp-hs**
+:Example: **> connect 1C:48:F9:9D:81:5C 00001108-0000-1000-8000-00805f9b34fb**
+:Example: **> connect 1C:48:F9:9D:81:5C 0x1108**
 
 disconnect
 ----------
 
 Disconnect device.
 
+By default this commands disconnects all profiles and then terminates the
+connection. In case when the UUID of the remote service is given only that
+service will be disconnected.
+
 For LE when disconnecting from an active connection the device address is not
 needed.
 
-:Usage: **> disconnect <dev>**
+:Usage: **> disconnect <dev> [uuid]**
 
 info
 ----
diff --git a/client/main.c b/client/main.c
index 6b938da3f..3f2bfcf6b 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1981,13 +1981,44 @@ static void cmd_remove(int argc, char *argv[])
 	remove_device(proxy);
 }
 
+struct connection_data {
+	GDBusProxy *proxy;
+	char *uuid;
+};
+
+static void connection_setup(DBusMessageIter *iter, void *user_data)
+{
+	struct connection_data *data = user_data;
+
+	if (!data->uuid)
+		return;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &data->uuid);
+}
+
+static void format_connection_profile(char *output, size_t size,
+							const char *uuid)
+{
+	const char *text;
+
+	text = bt_uuidstr_to_str(uuid);
+	if (!text)
+		text = uuid;
+
+	snprintf(output, size, " profile \"%s\"", text);
+}
+
 static void connect_reply(DBusMessage *message, void *user_data)
 {
-	GDBusProxy *proxy = user_data;
+	struct connection_data *data = user_data;
+	GDBusProxy *proxy = data->proxy;
 	DBusError error;
 
 	dbus_error_init(&error);
 
+	g_free(data->uuid);
+	g_free(data);
+
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
 		bt_shell_printf("Failed to connect: %s %s\n", error.name,
 				error.message);
@@ -2003,6 +2034,9 @@ static void connect_reply(DBusMessage *message, void *user_data)
 
 static void cmd_connect(int argc, char *argv[])
 {
+	struct connection_data *data;
+	const char *method = "Connect";
+	char profile[128] = "";
 	GDBusProxy *proxy;
 
 	if (check_default_ctrl() == FALSE)
@@ -2014,31 +2048,49 @@ static void cmd_connect(int argc, char *argv[])
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	if (g_dbus_proxy_method_call(proxy, "Connect", NULL, connect_reply,
-							proxy, NULL) == FALSE) {
+	data = new0(struct connection_data, 1);
+	data->proxy = proxy;
+
+	if (argc == 3) {
+		method = "ConnectProfile";
+		data->uuid = g_strdup(argv[2]);
+		format_connection_profile(profile, sizeof(profile), argv[2]);
+	}
+
+	if (g_dbus_proxy_method_call(proxy, method, connection_setup,
+					connect_reply, data, NULL) == FALSE) {
 		bt_shell_printf("Failed to connect\n");
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	bt_shell_printf("Attempting to connect to %s\n", argv[1]);
+	bt_shell_printf("Attempting to connect%s to %s\n", profile, argv[1]);
 }
 
 static void disconn_reply(DBusMessage *message, void *user_data)
 {
-	GDBusProxy *proxy = user_data;
+	struct connection_data *data = user_data;
+	const bool profile_disconnected = data->uuid != NULL;
+	GDBusProxy *proxy = data->proxy;
 	DBusError error;
 
 	dbus_error_init(&error);
 
+	g_free(data->uuid);
+	g_free(data);
+
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
 		bt_shell_printf("Failed to disconnect: %s\n", error.name);
 		dbus_error_free(&error);
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	bt_shell_printf("Successful disconnected\n");
+	bt_shell_printf("Disconnection successful\n");
 
-	if (proxy == default_dev)
+	/* If only a single profile was disconnected, the device itself might
+	 * still be connected. In that case, let the property change handler
+	 * take care of setting the default device to NULL.
+	 */
+	if (proxy == default_dev && !profile_disconnected)
 		set_default_device(NULL, NULL);
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
@@ -2046,19 +2098,31 @@ static void disconn_reply(DBusMessage *message, void *user_data)
 
 static void cmd_disconn(int argc, char *argv[])
 {
+	struct connection_data *data;
+	const char *method = "Disconnect";
+	char profile[128] = "";
 	GDBusProxy *proxy;
 
 	proxy = find_device(argc, argv);
 	if (!proxy)
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
-	if (g_dbus_proxy_method_call(proxy, "Disconnect", NULL, disconn_reply,
-							proxy, NULL) == FALSE) {
+	data = new0(struct connection_data, 1);
+	data->proxy = proxy;
+
+	if (argc == 3) {
+		method = "DisconnectProfile";
+		data->uuid = g_strdup(argv[2]);
+		format_connection_profile(profile, sizeof(profile), argv[2]);
+	}
+
+	if (g_dbus_proxy_method_call(proxy, method, connection_setup,
+					disconn_reply, data, NULL) == FALSE) {
 		bt_shell_printf("Failed to disconnect\n");
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	bt_shell_printf("Attempting to disconnect from %s\n",
+	bt_shell_printf("Attempting to disconnect%s from %s\n", profile,
 						proxy_address(proxy));
 }
 
@@ -3253,10 +3317,13 @@ static const struct bt_shell_menu main_menu = {
 								dev_generator },
 	{ "remove",       "<dev>",    cmd_remove, "Remove device",
 							dev_generator },
-	{ "connect",      "<dev>",    cmd_connect, "Connect device",
-							dev_generator },
-	{ "disconnect",   "[dev]",    cmd_disconn, "Disconnect device",
+	{ "connect",      "<dev> [uuid]", cmd_connect,
+				"Connect a device and all its profiles or "
+				"optionally connect a single profile only",
 							dev_generator },
+	{ "disconnect",   "[dev] [uuid]", cmd_disconn,
+				"Disconnect a device or optionally disconnect "
+				"a single profile only", dev_generator },
 	{ "wake",         "[dev] [on/off]",    cmd_wake, "Get/Set wake support",
 							dev_generator },
 	{ } },
diff --git a/src/uuid-helper.c b/src/uuid-helper.c
index f32ee0a85..640592fd2 100644
--- a/src/uuid-helper.c
+++ b/src/uuid-helper.c
@@ -101,29 +101,31 @@ static struct {
 	const char	*name;
 	uint16_t	class;
 } bt_services[] = {
-	{ "pbap",	PBAP_SVCLASS_ID			},
-	{ "sap",	SAP_SVCLASS_ID			},
-	{ "ftp",	OBEX_FILETRANS_SVCLASS_ID	},
-	{ "bpp",	BASIC_PRINTING_SVCLASS_ID	},
+	{ "a2dp-sink",	AUDIO_SINK_SVCLASS_ID		},
+	{ "a2dp-source",AUDIO_SOURCE_SVCLASS_ID		},
 	{ "bip",	IMAGING_SVCLASS_ID		},
-	{ "synch",	IRMC_SYNC_SVCLASS_ID		},
+	{ "bpp",	BASIC_PRINTING_SVCLASS_ID	},
 	{ "dun",	DIALUP_NET_SVCLASS_ID		},
-	{ "opp",	OBEX_OBJPUSH_SVCLASS_ID		},
 	{ "fax",	FAX_SVCLASS_ID			},
-	{ "spp",	SERIAL_PORT_SVCLASS_ID		},
-	{ "hsp",	HEADSET_SVCLASS_ID		},
-	{ "hsp-hs",	HEADSET_SVCLASS_ID		},
-	{ "hsp-ag",	HEADSET_AGW_SVCLASS_ID		},
+	{ "ftp",	OBEX_FILETRANS_SVCLASS_ID	},
+	{ "gnss",	GNSS_SERVER_SVCLASS_ID		},
 	{ "hfp",	HANDSFREE_SVCLASS_ID		},
-	{ "hfp-hf",	HANDSFREE_SVCLASS_ID		},
 	{ "hfp-ag",	HANDSFREE_AGW_SVCLASS_ID	},
-	{ "pbap-pce",	PBAP_PCE_SVCLASS_ID		},
-	{ "pbap-pse",	PBAP_PSE_SVCLASS_ID		},
-	{ "map-mse",	MAP_MSE_SVCLASS_ID		},
+	{ "hfp-hf",	HANDSFREE_SVCLASS_ID		},
+	{ "hsp",	HEADSET_SVCLASS_ID		},
+	{ "hsp-ag",	HEADSET_AGW_SVCLASS_ID		},
+	{ "hsp-hs",	HEADSET_SVCLASS_ID		},
 	{ "map-mas",	MAP_MSE_SVCLASS_ID		},
 	{ "map-mce",	MAP_MCE_SVCLASS_ID		},
 	{ "map-mns",	MAP_MCE_SVCLASS_ID		},
-	{ "gnss",	GNSS_SERVER_SVCLASS_ID		},
+	{ "map-mse",	MAP_MSE_SVCLASS_ID		},
+	{ "opp",	OBEX_OBJPUSH_SVCLASS_ID		},
+	{ "pbap",	PBAP_SVCLASS_ID			},
+	{ "pbap-pce",	PBAP_PCE_SVCLASS_ID		},
+	{ "pbap-pse",	PBAP_PSE_SVCLASS_ID		},
+	{ "sap",	SAP_SVCLASS_ID			},
+	{ "spp",	SERIAL_PORT_SVCLASS_ID		},
+	{ "synch",	IRMC_SYNC_SVCLASS_ID		},
 	{ }
 };
 
-- 
2.39.5

