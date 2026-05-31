Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BA5357D08
	for <linux-bluetooth@vger.kernel.org>; Sun, 31 May 2026 10:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780222714; cv=none; b=hJ6KMPyzt0UXFATLVNf2G0t6MA+fCOryjBqTvFH7WhtEmdk7JvMuqYVQvxTFkjalkj3aZyz6i4KMlmhfD9zwKnN4Z1h5iU/AKf6Rqv55yKBHQ2GnRg+EazQNNVkUumanaSqEnica0yBF9xP4v1pHtGEhRLIhP975Cr2YgNXAvR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780222714; c=relaxed/simple;
	bh=IsEX/hDfWZyshcQBTnJuRyog88rGXJKwHyGT35wTy7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAqLgCtOaBv0ohoAfwqDloGsG3jQqmIOHgC+2HVtV1J4Vi4sPy1ITIA2ztdZdK8Z5Xj1AR8x5WUcwbzfx9JShQQs/GR9D7GdfRzrrE6p75qf5mSpSyfWqnOQx8vYPSTW+dAbOsOL40YLthVhjIVwjDFmjCFuuk2HD11P7s+0FFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=Slx3Zq2K; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="Slx3Zq2K"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-68bfcf11050so3713482a12.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 31 May 2026 03:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1780222711; x=1780827511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TruFQ04jpJzDR2tOoER8hX/WAJYQFKOFixaXP2lTO0c=;
        b=Slx3Zq2KPmaBBjBB6xEgiRw6g/pUGq6XbGmJnl4l/h8SMv7wq/4z6Wa3bySgYd3kLz
         tP6hScsl8GcSeEndZAprr2vOFcY40k0tlxyVOIi9pUrJoiOmF6zJR79r2hDnVkPVMx6G
         2gU+S/rZwbwctaHztsslhkjMZ74bi/3c9iB4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780222711; x=1780827511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TruFQ04jpJzDR2tOoER8hX/WAJYQFKOFixaXP2lTO0c=;
        b=sG9S1sJ3GL81rB083HoRAlMz4PLakGCXZRt72Pngj5xfg+HljZEBJYdlUL+15XZkUw
         Q0lCKU8PLICDHr+8Db8krwDO/WHrvVT+Yf4vOtrdxF/TGM2v4ywJrEcQwdmiZng1afTT
         eD9qy30o4R143gEsc/Jz+fESYFJQwS3heeanvExdHypWDk7zEKAXv13XZrx8bwAyPlLP
         8SiBJm0gn08nhrUHWmx6m6d/X6+LmCHNYGwQneshmx8MYIAQwvAHOa+5Dg0SSf0/Zp4m
         ZPibCvuTQNpOoBlSBK+K3MhCpwyL3cZGo0k9yEa5BjQZ0Po1bBbhSFP/TOu7SE7KVzTs
         Fghw==
X-Gm-Message-State: AOJu0YwWLNnoEfF0uv7DNmMki8/YYIw/AazuDcrlcqDeYmv9F8KLcdn/
	fQz7u5TlRx1QlGD74HwdmAlIhOMfOxXzPb65qauSJoqKEdqwWtT1giTJU2n/T+EY4j9eFXMf265
	OsEh5ZA==
X-Gm-Gg: Acq92OEWVK8/u8ueSfMYH4ddnqR4572yJCWod7aqHf7EmBDZ4RIjwp2Al7yhJ6KM2n/
	aIZPMWlYmdz8jcfaJrCQGJ9rHvB8vtZGjDfBV+43iYWQcdNiwMXL8gi/gOxJW0PMvv10okp9uui
	/FhXP0s6On8YFn/Xhatna81udsfqnAWmun78dk7OoPbsxAujL2A7A0UFro3V/n7/+ed/20zJvG0
	6UhQw9oGk0vpslhFoVv9zq6ia83+BKscQfB3g05nWuz11PhFOIkRVs9aA8koS4zHE0ElXAwTJqO
	xd4hMbVE61OJKv/gRuufeczaQNBQODJQqsWdhUTS1R1CrgiZwIchxhd/WoyD0Hud7CGp1Ej6ACP
	kpa6AD2qBlzqEGxiQlELZzWv2/0W6KsuQR9UtSGkn+rkvO4jiHOoSSjzkSSBivLTZpzVj+binOg
	ah2aBnzwFjb1lOXTNEG+mN5u2ioAR3EwCxpQdEf1nFnYZY09xkMCw/5emOZBcQ2JxbLtX2PYl7W
	4O8JhVI5W1cA6Xgl50ejR8=
X-Received: by 2002:a05:6402:1a41:b0:676:9c6d:5c4d with SMTP id 4fb4d7f45d1cf-68c8c93e7efmr2588219a12.17.1780222710523;
        Sun, 31 May 2026 03:18:30 -0700 (PDT)
Received: from great-eastern2.. (user-46-113-6-2.play-internet.pl. [46.113.6.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68ceb6f98f8sm974823a12.0.2026.05.31.03.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 03:18:30 -0700 (PDT)
From: Michal Dzik <michal.dzik@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michal Dzik <michal.dzik@streamunlimited.com>
Subject: [PATCH BlueZ v2 2/2] client: add advertisement instance support
Date: Sun, 31 May 2026 12:17:54 +0200
Message-ID: <20260531101754.3325247-3-michal.dzik@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260531101754.3325247-1-michal.dzik@streamunlimited.com>
References: <20260531101754.3325247-1-michal.dzik@streamunlimited.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 client/advertising.c | 38 ++++++++++++++++++++++++++++++++++++++
 client/advertising.h |  1 +
 client/main.c        |  7 +++++++
 3 files changed, 46 insertions(+)

diff --git a/client/advertising.c b/client/advertising.c
index 5ca391635..a64d1895a 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -67,6 +67,7 @@ static struct ad {
 	uint16_t duration;
 	uint16_t timeout;
 	uint16_t discoverable_to;
+	uint8_t instance;
 	char **uuids[AD_TYPE_COUNT];
 	size_t uuids_len[AD_TYPE_COUNT];
 	char **solicit[AD_TYPE_COUNT];
@@ -233,6 +234,9 @@ static void print_ad(void)
 	if (ad.min_interval)
 		bt_shell_printf("Interval: %u-%u msec\n", ad.min_interval,
 					ad.max_interval);
+
+	if (ad.instance)
+		bt_shell_printf("Instance: %u\n", ad.instance);
 }
 
 static void register_reply(DBusMessage *message, void *user_data)
@@ -640,6 +644,32 @@ static gboolean get_secondary(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean get_instance(const GDBusPropertyTable *property,
+				DBusMessageIter *iter, void *user_data)
+{
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &ad.instance);
+
+	return TRUE;
+}
+
+static void set_instance(const GDBusPropertyTable *property,
+				DBusMessageIter *iter,
+				GDBusPendingPropertySet id, void *user_data)
+{
+	uint8_t value;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BYTE) {
+		g_dbus_pending_property_error(id,
+					"org.bluez.Error.InvalidArguments",
+					"Invalid argument type");
+		return;
+	}
+
+	dbus_message_iter_get_basic(iter, &value);
+	ad.instance = value;
+	g_dbus_pending_property_success(id);
+}
+
 static gboolean min_interval_exists(const GDBusPropertyTable *property,
 							void *data)
 {
@@ -700,6 +730,7 @@ static const GDBusPropertyTable ad_props[] = {
 	{ "MinInterval", "u", get_min_interval, NULL, min_interval_exists },
 	{ "MaxInterval", "u", get_max_interval, NULL, max_interval_exists },
 	{ "SecondaryChannel", "s", get_secondary, NULL, secondary_exists },
+	{ "Instance", "y", get_instance, set_instance, NULL },
 	{ }
 };
 
@@ -1446,3 +1477,10 @@ void ad_advertise_rsi(DBusConnection *conn, dbus_bool_t *value)
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
+
+void ad_advertise_instance(void)
+{
+	bt_shell_printf("Instance: %u\n", ad.instance);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
diff --git a/client/advertising.h b/client/advertising.h
index 8c3fd041b..89d95d67e 100644
--- a/client/advertising.h
+++ b/client/advertising.h
@@ -42,3 +42,4 @@ void ad_advertise_discoverable_timeout(DBusConnection *conn, long int *value);
 void ad_advertise_secondary(DBusConnection *conn, const char *value);
 void ad_advertise_interval(DBusConnection *conn, uint32_t *min, uint32_t *max);
 void ad_advertise_rsi(DBusConnection *conn, dbus_bool_t *value);
+void ad_advertise_instance(void);
diff --git a/client/main.c b/client/main.c
index 6fb399277..9d9ac8b14 100644
--- a/client/main.c
+++ b/client/main.c
@@ -3206,6 +3206,11 @@ static void cmd_advertise_rsi(int argc, char *argv[])
 	ad_advertise_rsi(dbus_conn, &value);
 }
 
+static void cmd_advertise_instance(int argc, char *argv[])
+{
+	ad_advertise_instance();
+}
+
 static void ad_clear_uuids(void)
 {
 	ad_disable_uuids(dbus_conn, AD_TYPE_AD);
@@ -3705,6 +3710,8 @@ static const struct bt_shell_menu advertise_menu = {
 			"Set/Get advertise interval range" },
 	{ "rsi", "[on/off]", cmd_advertise_rsi,
 			"Show/Enable/Disable RSI to be advertised", NULL },
+	{ "instance", NULL, cmd_advertise_instance,
+					"Show advertisement instance number" },
 	{ "clear", "[uuids/service/manufacturer/config-name...]", cmd_ad_clear,
 			"Clear advertise config" },
 	{ } },
-- 
2.43.0

