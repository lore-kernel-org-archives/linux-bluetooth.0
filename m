Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81091C9DE5
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Sep 2024 19:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726687634; cv=none; b=LJAH+rR+1Aarjva0/2n0wX9HGmW1qKZgg2KqPM5+On2ka+n/RutSTsnit9FgpCeT7n8G7SZHOT9/XO78mU7yqnJ4X7sRwt/fOtI9JwZAqjhkf9lTXDkvZHQWvNMcMK704odHIc69jZKkqoa6UCqG48P7/Tq0dlMJNDOnZCKZ3lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726687634; c=relaxed/simple;
	bh=sx9b3zqCdPZWkQy/9GF5QrN3jFW1tJDA9VHNrN2M6aw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pEW+nk1KCcafvJR853En8R1qicu+Q3J7Yyi1IjTvtQnf8Eazj30vZJjHm+QcrK7ubMsGmFwvpt/K5NjhTL7vCVuA6MGW8/izIXKvEX91Dpr/HuIA4hbUTVIeYdCnYppyAXS5Ova/oRi3hTdokKmS5NdyOZ2/1eL5hJDw13pWtXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KS+ZfDZt; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KS+ZfDZt"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-846c5c2a8e9so10129241.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Sep 2024 12:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726687631; x=1727292431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Isf7m2q7P4dR7etwbP6+EUhP9461Y9k9ADedO2eVkGg=;
        b=KS+ZfDZtjL+JPazjwvt6ZmlWK19TCgx9U2sxGGHL8tWraxlf3TR5V5quHmk+Crr04f
         PvIhIxCYhGdmjCvHQoB0ZOljHIKUWMJD7c5BJTFu9Mie4ISO+E0TIcIenJWexw6dGEoe
         vhAEDzu3YcfUr1ACDl6iIkkqu5bTURpH91hjIimRU8Ci8I+wS5offqb6kZOh4u005jLN
         cCXYQDV0DasILEPlRktXTCjcj7gs2Xq7wRvyUjszo234wIN3mPIhCNmZmDrmLsPeF9T/
         GCPCnA1nYefcUAWjR8QoSEgqwA7rpVqYAzYhW/y0BiaqGSxQqN84BgqYC3S01khxWyqf
         CMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726687631; x=1727292431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Isf7m2q7P4dR7etwbP6+EUhP9461Y9k9ADedO2eVkGg=;
        b=kyJc0ptjiPoDGGjS01LwzNkwUdukwBas1P6ZDR1D/Gx9O2iAo+ZZlil/92QzNJxEv3
         edJcZG80K2thFgEgr529od2Hn9avepaV1wyJnf6+VTbmP7LjjjiarClQKH17Z8VeioGw
         Wp9WNkFUP8ADc2s+IcAaz2q+tjmXAYvjXxrG0zVDyKoGE80BnpxBVpB2n3HTzpRQW+EK
         2KLjzBytgb84zPrCKfZSkQ0F3xd6ugeC2cpnwXjfxRAThI3ZLZLqEyymwPU+0ytPpRMw
         6Gm+1jnNsJqW/idqHfYXD/Ii3A3816Cx0RWeDqD5ZosADLbNua7pMZr58ksXf+uWrZYk
         mLQQ==
X-Gm-Message-State: AOJu0YxcjYr7rajPSdJvi86cgV3xbjiFZFwTFTE4HvstGrIqT8Kz4yZb
	6FOTJwjOgA7+qD1DjENOtttUIMAIApIDEGsgLF+hHhx/j4o6HNSwOGQ/QA==
X-Google-Smtp-Source: AGHT+IEW5f10LbwWiwcA+D+LAylAcfAzbpqIUuEGFf9axVfdAw+5Qmwm9N4y5nClQYHvxmyWY7nrXg==
X-Received: by 2002:a05:6102:3712:b0:492:9ca1:d35e with SMTP id ada2fe7eead31-49d4145c022mr17726801137.5.1726687630923;
        Wed, 18 Sep 2024 12:27:10 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-84939a5dd20sm1193902241.40.2024.09.18.12.27.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 12:27:10 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] client/print: Add decoding for UUID properties
Date: Wed, 18 Sep 2024 15:27:07 -0400
Message-ID: <20240918192707.686174-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds proper decoding for UUID properties with usage of
bt_uuidstr_to_str so it can print the 'friendly' name as bellow:

bluetoothctl# transport.show /org/bluez/hci0/dev_94_DB_56_F7_F2_88/sep4/fd0
Transport /org/bluez/hci0/dev_94_DB_56_F7_F2_88/sep4/fd0
	UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)
...
---
 client/main.c  | 33 +++------------------------------
 client/print.c | 33 +++++++++++++++++++++++++++++++++
 client/print.h |  1 +
 3 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/client/main.c b/client/main.c
index a6217e03327b..50aa3e7a6cbe 100644
--- a/client/main.c
+++ b/client/main.c
@@ -221,33 +221,6 @@ done:
 					address, name);
 }
 
-static void print_uuid(const char *label, const char *uuid)
-{
-	const char *text;
-
-	text = bt_uuidstr_to_str(uuid);
-	if (text) {
-		char str[26];
-		unsigned int n;
-
-		str[sizeof(str) - 1] = '\0';
-
-		n = snprintf(str, sizeof(str), "%s", text);
-		if (n > sizeof(str) - 1) {
-			str[sizeof(str) - 2] = '.';
-			str[sizeof(str) - 3] = '.';
-			if (str[sizeof(str) - 4] == ' ')
-				str[sizeof(str) - 4] = '.';
-
-			n = sizeof(str) - 1;
-		}
-
-		bt_shell_printf("\t%s: %s%*c(%s)\n", label, str, 26 - n, ' ',
-									uuid);
-	} else
-		bt_shell_printf("\t%s: %*c(%s)\n", label, 26, ' ', uuid);
-}
-
 static void print_uuids(GDBusProxy *proxy)
 {
 	DBusMessageIter iter, value;
@@ -262,7 +235,7 @@ static void print_uuids(GDBusProxy *proxy)
 
 		dbus_message_iter_get_basic(&value, &uuid);
 
-		print_uuid("UUID", uuid);
+		print_uuid("\t", "UUID", uuid);
 
 		dbus_message_iter_next(&value);
 	}
@@ -283,7 +256,7 @@ static void print_experimental(GDBusProxy *proxy)
 
 		dbus_message_iter_get_basic(&value, &uuid);
 
-		print_uuid("ExperimentalFeatures", uuid);
+		print_uuid("\t", "ExperimentalFeatures", uuid);
 
 		dbus_message_iter_next(&value);
 	}
@@ -1376,7 +1349,7 @@ static void cmd_scan_filter_uuids(int argc, char *argv[])
 		char **uuid;
 
 		for (uuid = filter.uuids; uuid && *uuid; uuid++)
-			print_uuid("UUID", *uuid);
+			print_uuid("\t", "UUID", *uuid);
 
 		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 	}
diff --git a/client/print.c b/client/print.c
index 8d721e21df4b..39f8567eedd3 100644
--- a/client/print.c
+++ b/client/print.c
@@ -116,6 +116,12 @@ void print_iter(const char *label, const char *name, DBusMessageIter *iter)
 		bt_shell_printf("%s%s is invalid\n", label, name);
 		break;
 	case DBUS_TYPE_STRING:
+		if (!strcasecmp(name, "UUID")) {
+			dbus_message_iter_get_basic(iter, &valstr);
+			print_uuid(label, name, valstr);
+			break;
+		}
+		/* fall through */
 	case DBUS_TYPE_OBJECT_PATH:
 		dbus_message_iter_get_basic(iter, &valstr);
 		bt_shell_printf("%s%s: %s\n", label, name, valstr);
@@ -203,3 +209,30 @@ void print_property(GDBusProxy *proxy, const char *name)
 {
 	print_property_with_label(proxy, name, NULL);
 }
+
+void print_uuid(const char *label, const char *name, const char *uuid)
+{
+	const char *text;
+
+	text = bt_uuidstr_to_str(uuid);
+	if (text) {
+		char str[26];
+		unsigned int n;
+
+		str[sizeof(str) - 1] = '\0';
+
+		n = snprintf(str, sizeof(str), "%s", text);
+		if (n > sizeof(str) - 1) {
+			str[sizeof(str) - 2] = '.';
+			str[sizeof(str) - 3] = '.';
+			if (str[sizeof(str) - 4] == ' ')
+				str[sizeof(str) - 4] = '.';
+
+			n = sizeof(str) - 1;
+		}
+
+		bt_shell_printf("%s%s: %s%*c(%s)\n", label, name, str, 26 - n,
+								' ', uuid);
+	} else
+		bt_shell_printf("%s%s: %*c(%s)\n", label, name, 26, ' ', uuid);
+}
diff --git a/client/print.h b/client/print.h
index c0866d06c504..56bcce16a661 100644
--- a/client/print.h
+++ b/client/print.h
@@ -12,3 +12,4 @@ void print_property(GDBusProxy *proxy, const char *name);
 void print_property_with_label(GDBusProxy *proxy, const char *name,
 					const char *label);
 void print_iter(const char *label, const char *name, DBusMessageIter *iter);
+void print_uuid(const char *label, const char *name, const char *uuid);
-- 
2.46.0

