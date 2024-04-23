Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543D81C6BE
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Apr 2024 22:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713912369; cv=none; b=li3ubQ7oGus+IW4xxx0UMj4oa1SmPjcfrzyYp0zv1MfFGrhfQ8elici2WDVce9QpsL5INbQPI53UY5k/VXrAywnCdNciHfPgX83if0WmfF/TDfh7n6xF3auI60CnlyUf1IeirPvjKtTA0axPYW809gXYtMCL9sjyZrQrgkhdSqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713912369; c=relaxed/simple;
	bh=8zzL+YorLdTupfWty8DAlRNEvHb92NK+t3Md+ROTeiA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=j8D4qEfi3JwPZzqQVB35phJTN8zvQc2i18S+4pIsMLadt62Fh4Cr29sainftE0oAZsl2DwecFLjC3+4gCe4pAEo0TArRegjhTn/7E03IdtWnfgIOhtsmL67YPekmMk/TerbgWR4pr7ExlM4kvacFfcEtBq0Pa2pMo9Jf9DxzlY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OeP2oxEV; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeP2oxEV"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7e978e12390so1622826241.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Apr 2024 15:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713912366; x=1714517166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aJBFb5PmsKrQZkqLRjnvOTfrso1ZVWn55h9+2y2Dxrc=;
        b=OeP2oxEVCCJxa+MrkvO8bLB23BBilZUv+qklN/UOzwsAdrMybvMSeiuDZ9yXwKDvsc
         uNq6IRATS8dIIoHbqyM3u7PlfGb/4q8X12XcB9JyTaYNY5WSsLrNQge2OXMFTC3LNqSt
         xugGhtS3v82163DACUNMWp+gKesH6s575dVDBiW2GlgwXeXdwqChK3XeKFTdGjYEFIGk
         D10M6PtSVHhVF84jDZFBNNXqfiswrpnq1Djjufs2tLTF7QTmR4cku+MfzeIuJNF+5hvD
         Lo1l5pUyLrttAxbUYDDhPMgkdjYUMdTqq3FAjqdSosN4q4UhyJfzy5CEcLRpjuMKCmZI
         yMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713912366; x=1714517166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aJBFb5PmsKrQZkqLRjnvOTfrso1ZVWn55h9+2y2Dxrc=;
        b=tb9wWjvtDsR9NGvOVuR3tHlwyBgLk0C9kJIVtEZPo6bXTt8eXdqC+tq0RoWousr1JU
         zrHIpNmTKnQxwHKDHysedaRgq9UyqCeUptSY7vGhjfdlsfVaCSveOtGY4fFrSAniCdIK
         yFMsEqXrqtDFMC6mnf7wQRg6EQaXtPWCMBqSus9/Byxh5B7Eu7CQrcNq8o/4jGiV6t6O
         E0N6xvYeaxdSx0PBHu1OBrHZ9YBSIhNJomqlYzmV6azgUakOixF9BPG/wlvF+MUzZr3C
         H6fEI0jj09aORf12CukcSJcg8RzDjH6YEi4F7Yb1J2Xne281nMb123BGacvjf0WtsD/6
         B/bQ==
X-Gm-Message-State: AOJu0Yzz/wUsAYh5QOe3ZH0t3t6y0hG0j0uCkP4J0rjD5x546FU8sZir
	UohVl1sOEXIr8m8n5ipFZYuHArHa7lL8Hcll7Q3zdyW9sFfT/oxtgsgvDA==
X-Google-Smtp-Source: AGHT+IEF3FcL10ydo6R3OcwufYTN+qISdSLQyxTCfvNLnG/GPpcUqTe9uN0hBJwraPlxhf6vS7wtjQ==
X-Received: by 2002:a05:6102:44e:b0:47a:71fc:bf78 with SMTP id e14-20020a056102044e00b0047a71fcbf78mr896952vsq.16.1713912366416;
        Tue, 23 Apr 2024 15:46:06 -0700 (PDT)
Received: from lvondent-mobl4.. ([107.146.107.67])
        by smtp.gmail.com with ESMTPSA id g20-20020a05610209d400b0047b8ee9674dsm2196056vsi.1.2024.04.23.15.46.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 15:46:05 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/3] gdbus: Add testing flags
Date: Tue, 23 Apr 2024 18:46:01 -0400
Message-ID: <20240423224603.2124790-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds testing flags which are similar to experimental but are only
available for testing.
---
 gdbus/gdbus.h  | 23 +++++++++++++++++++++++
 gdbus/object.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 28b80229646c..6fe09b743221 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -72,6 +72,7 @@ typedef void (* GDBusSecurityFunction) (DBusConnection *connection,
 
 enum GDBusFlags {
 	G_DBUS_FLAG_ENABLE_EXPERIMENTAL = (1 << 0),
+	G_DBUS_FLAG_ENABLE_TESTING      = (1 << 1),
 };
 
 enum GDBusMethodFlags {
@@ -79,16 +80,19 @@ enum GDBusMethodFlags {
 	G_DBUS_METHOD_FLAG_NOREPLY      = (1 << 1),
 	G_DBUS_METHOD_FLAG_ASYNC        = (1 << 2),
 	G_DBUS_METHOD_FLAG_EXPERIMENTAL = (1 << 3),
+	G_DBUS_METHOD_FLAG_TESTING      = (1 << 4),
 };
 
 enum GDBusSignalFlags {
 	G_DBUS_SIGNAL_FLAG_DEPRECATED   = (1 << 0),
 	G_DBUS_SIGNAL_FLAG_EXPERIMENTAL = (1 << 1),
+	G_DBUS_SIGNAL_FLAG_TESTING      = (1 << 2),
 };
 
 enum GDBusPropertyFlags {
 	G_DBUS_PROPERTY_FLAG_DEPRECATED   = (1 << 0),
 	G_DBUS_PROPERTY_FLAG_EXPERIMENTAL = (1 << 1),
+	G_DBUS_PROPERTY_FLAG_TESTING      = (1 << 2),
 };
 
 enum GDBusSecurityFlags {
@@ -186,6 +190,20 @@ struct GDBusSecurityTable {
 	.function = _function, \
 	.flags = G_DBUS_METHOD_FLAG_ASYNC | G_DBUS_METHOD_FLAG_EXPERIMENTAL
 
+#define GDBUS_TESTING_METHOD(_name, _in_args, _out_args, _function) \
+	.name = _name, \
+	.in_args = _in_args, \
+	.out_args = _out_args, \
+	.function = _function, \
+	.flags = G_DBUS_METHOD_FLAG_TESTING
+
+#define GDBUS_TESTING_ASYNC_METHOD(_name, _in_args, _out_args, _function) \
+	.name = _name, \
+	.in_args = _in_args, \
+	.out_args = _out_args, \
+	.function = _function, \
+	.flags = G_DBUS_METHOD_FLAG_ASYNC | G_DBUS_METHOD_FLAG_TESTING
+
 #define GDBUS_NOREPLY_METHOD(_name, _in_args, _out_args, _function) \
 	.name = _name, \
 	.in_args = _in_args, \
@@ -207,6 +225,11 @@ struct GDBusSecurityTable {
 	.args = _args, \
 	.flags = G_DBUS_SIGNAL_FLAG_EXPERIMENTAL
 
+#define GDBUS_TESTING_SIGNAL(_name, _args) \
+	.name = _name, \
+	.args = _args, \
+	.flags = G_DBUS_SIGNAL_FLAG_EXPERIMENTAL
+
 void g_dbus_set_flags(int flags);
 int g_dbus_get_flags(void);
 
diff --git a/gdbus/object.c b/gdbus/object.c
index f7c8c2be5d87..72d2d46e30ef 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -14,6 +14,7 @@
 
 #include <stdio.h>
 #include <string.h>
+#include <stdbool.h>
 
 #include <glib.h>
 #include <dbus/dbus.h>
@@ -115,6 +116,14 @@ static gboolean check_experimental(int flags, int flag)
 	return !(global_flags & G_DBUS_FLAG_ENABLE_EXPERIMENTAL);
 }
 
+static bool check_testing(int flags, int flag)
+{
+	if (!(flags & flag))
+		return false;
+
+	return !(global_flags & G_DBUS_FLAG_ENABLE_TESTING);
+}
+
 static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 {
 	const GDBusMethodTable *method;
@@ -126,6 +135,9 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 					G_DBUS_METHOD_FLAG_EXPERIMENTAL))
 			continue;
 
+		if (check_testing(method->flags, G_DBUS_METHOD_FLAG_TESTING))
+			continue;
+
 		g_string_append_printf(gstr, "<method name=\"%s\">",
 								method->name);
 		print_arguments(gstr, method->in_args, "in");
@@ -146,6 +158,9 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 					G_DBUS_SIGNAL_FLAG_EXPERIMENTAL))
 			continue;
 
+		if (check_testing(signal->flags, G_DBUS_SIGNAL_FLAG_TESTING))
+			continue;
+
 		g_string_append_printf(gstr, "<signal name=\"%s\">",
 								signal->name);
 		print_arguments(gstr, signal->args, NULL);
@@ -163,6 +178,10 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL))
 			continue;
 
+		if (check_testing(property->flags,
+					G_DBUS_PROPERTY_FLAG_TESTING))
+			continue;
+
 		g_string_append_printf(gstr, "<property name=\"%s\""
 					" type=\"%s\" access=\"%s%s\">",
 					property->name,	property->type,
@@ -518,6 +537,9 @@ static void append_properties(struct interface_data *data,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL))
 			continue;
 
+		if (check_testing(p->flags, G_DBUS_PROPERTY_FLAG_TESTING))
+			continue;
+
 		if (p->get == NULL)
 			continue;
 
@@ -749,6 +771,9 @@ static inline const GDBusPropertyTable *find_property(const GDBusPropertyTable *
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL))
 			break;
 
+		if (check_testing(p->flags, G_DBUS_PROPERTY_FLAG_TESTING))
+			break;
+
 		return p;
 	}
 
@@ -1061,6 +1086,9 @@ static DBusHandlerResult generic_message(DBusConnection *connection,
 					G_DBUS_METHOD_FLAG_EXPERIMENTAL))
 			return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 
+		if (check_testing(method->flags, G_DBUS_METHOD_FLAG_TESTING))
+			return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+
 		if (g_dbus_args_have_signature(method->in_args,
 							message) == FALSE)
 			continue;
@@ -1190,18 +1218,26 @@ static gboolean add_interface(struct generic_data *data,
 		if (!check_experimental(method->flags,
 					G_DBUS_METHOD_FLAG_EXPERIMENTAL))
 			goto done;
+
+		if (!check_testing(method->flags, G_DBUS_METHOD_FLAG_TESTING))
+			goto done;
 	}
 
 	for (signal = signals; signal && signal->name; signal++) {
 		if (!check_experimental(signal->flags,
 					G_DBUS_SIGNAL_FLAG_EXPERIMENTAL))
 			goto done;
+		if (!check_testing(signal->flags, G_DBUS_SIGNAL_FLAG_TESTING))
+			goto done;
 	}
 
 	for (property = properties; property && property->name; property++) {
 		if (!check_experimental(property->flags,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL))
 			goto done;
+		if (!check_testing(property->flags,
+					G_DBUS_PROPERTY_FLAG_TESTING))
+			goto done;
 	}
 
 	/* Nothing to register */
-- 
2.44.0

