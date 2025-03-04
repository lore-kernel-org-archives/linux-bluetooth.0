Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6BF1F0E44
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Mar 2025 06:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741069212; cv=none; b=l+H5/FFEeZCKDouEAu0OAgAGr0DNmQ5oBDc6TwuCDGoJqXngbhb29Om5Ojw9LTWxb/aeGTISqr3v9pDd4LWemKxGiyobJYs/02ZY93VPrupY40xEbM9Etwap3cDgAG6IVkl0Jp0/0oqrNADQgKUT6dnM42ipj7vMdoJeNlYcm+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741069212; c=relaxed/simple;
	bh=z7k6KGzKdoEkjHN6WXxvhPHBotba9sqIsz9HfxEazLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uQr1ILlelreIhYBQM4odwgOWv/Mgj280CoIgfh/zcqfq0LdKtI5lsyT05yjmwlD3RqaOZpl0WXvibtBgugHuFqBjbvGibDuisJVzoruWndK4EaljPdhB72F0khXOd9nhqyGJPpXGqEl6t7r3vFaUxsF+aJAbtSQXc2U5/005Z3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKZ6AqID; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKZ6AqID"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abf4d756135so473314766b.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Mar 2025 22:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741069208; x=1741674008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b39WrI6vUPh0WkeXTTdeenAvSXvRzkf3VetqRtxw+z4=;
        b=mKZ6AqIDpiMghoCn+KCnX1Tlz/Eg9ugbcFuC4oudzHQO9wh7gfF1eRvo7q9y+RJTKg
         UzL1DgC88WXn2VN2KDAwdvgPjOPLYhkMz1Fo+cPFJPlvlo/bjuz6Lkj9IpgNa8mCYV70
         VopBvCL7GzQxkCDmsPAprLQtCjfkGPrNRo+zPMxdlugSKiUVvjcHPwFMDn0SfSRDVMhR
         SZzzIc1eY/DJO9u1fCrKdFnRrkaMpDsHP21f6OR2ehFiJxFUfxUUH877ho8OzxDtWAFf
         R1KLRQdAqFb6Ep8dJwS1ns3uXIPTK9VXZAl7YS2C4r4PaqY+fPdi5bAcjwMw/o/a0GK9
         BaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741069208; x=1741674008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b39WrI6vUPh0WkeXTTdeenAvSXvRzkf3VetqRtxw+z4=;
        b=bFEW/oLi/2DHgWGPORC2q5BStUQeZe8ZLVRhfypX7gVtd3/3tssRJeXy+XRzsuZqsJ
         Qx8Rw73U/cFbBWL0U99zbMXcd3oBW4olFObdxKXLO475g1ww3ybM8bUAX/+yVbHh0JTt
         FN9r0pLwBiHzqgV/PQl3r1U09RmL0byNi5cql5FSRgOBgj80lox90HTBpxoWb/s/z+V+
         JFsyoV722cXDw1M5DAmm4rkHXjxANuDf60cYXITB6O/b4/lgV7qgt3le8qm3CZMP2Joj
         aXhV0UFk57FCcV7CxLZqAAU/MzYXfcOQKEpRJkdVFhOw5nlPfJsRXTLGIKJfcbkEceMW
         jNZA==
X-Forwarded-Encrypted: i=1; AJvYcCUJXGl/B8wL/zT6ePIyoZjq46l2FhIwpaJWzxkF2DOlPLS70td6xrpRjvJQX0tKJN3QQT54rA3zb3ceF2NYqVk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1CYsHIboPHrxN6V45X/isUkpk0UzudghzINUnilkWpLzl55s4
	XnXkeEhX/62hFZHLeND35sCPRz/IkUTozxJDnKm3gv08MUvP1QV1HMJjBcr+w+I=
X-Gm-Gg: ASbGncsCv9UT+kNqotVwg3pk6PXReCNi/yRBgpkQ7WrXAedB8cloqHH9JQIAbLZewJj
	WchEHt+fvdOPsh8X66oLH+IoEYOrGfrcXSZXtxccHooSfOnfM9GW/3Ore0aBmVLuq2CwUKyVqWN
	KhF6I9IGhyvykT2g9qNPOGzMdWCp8rTDwfIzbielqGpufR7hMU/3nxAHxO5HIhwS0C5dUf/le7+
	aUW4KECfQL/KaF8MsAjdA3SozboUIgWt9s+1kHFyHRVxB5ossyGjunzdBtArDFzqpjFsXcN0lc/
	I2+HdA7MRnxQGHqs6emp0g/9Hyufhx76+UjY6BD6U81MyZbd0+JfFsKIK0kFmjciO4EIRZormKn
	n6U6nYtLRlITqbtqxBFcwKVB6hUBpzd5iARN7Xw==
X-Google-Smtp-Source: AGHT+IFBzw1GMzczjWnqB115k6UwQfZPFUiIzCvW8L/GFzswJYhJ+EXUyXbMWz/c9DAPehGIwKqLFg==
X-Received: by 2002:a17:906:1285:b0:abf:40a2:40c8 with SMTP id a640c23a62f3a-abf40a24526mr1420900766b.28.1741069208169;
        Mon, 03 Mar 2025 22:20:08 -0800 (PST)
Received: from localhost.localdomain (46.205.201.86.nat.ftth.dynamic.t-mobile.pl. [46.205.201.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c6f5363sm892708666b.123.2025.03.03.22.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 22:20:07 -0800 (PST)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: luiz.dentz@gmail.com
Cc: arkadiusz.bokowy@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/3] client: Support single profile connection/disconnection
Date: Tue,  4 Mar 2025 07:19:58 +0100
Message-Id: <20250304061959.34839-2-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304061959.34839-1-arkadiusz.bokowy@gmail.com>
References: <CABBYNZL3UsEQk7t2rff8gz7f=-=VbrbAvWGPkx5Kn5Mq79rfuQ@mail.gmail.com>
 <20250304061959.34839-1-arkadiusz.bokowy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 client/main.c | 93 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 80 insertions(+), 13 deletions(-)

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
-- 
2.39.5

