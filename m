Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794587886;
	b=0PETYhgdY4Xvr1ECPzvSQLVVC2E0uXfXpQamGeyd9y1j1R9PiYjnZAi9RM9LHdpaSPdT
	 HlTL5l37cd4DqTdWQ95cSBNcNNNLEj1nI0fZ6xn27hA9Ct4bV63ahUXLE/9VIYRLTOOvV
	 Es6sKRdYwCiwV5mgkRg7IB8CjfjsAmaUFLtg5VfEUVgli3jzvR07cfc+/YK3B+iCVgZc0
	 9UN0SwnAp8/thSfjw4D4nJQRuE3jD5QkwgrYq7a9luQmjjYkx3bUXLLuW1OdJG2XfTZnY
	 QanJhwU5XKo8Yx/mhffyYsH2hRhXrfcPZEx8bHA6lHsUWZwDsaXjXQsdpsezizfd6Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587886;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MS4BVrAatFI2pIIKsYtpuHHigeSrBF3sT2Hx9JJi8UE=;
	b=znHENbOZg1TLmUXm39o98vigu9bympsLZ9TTGDwFG+NvyBYXhXJ/E8uRxbN4sQMLJrBZ
	 togKaEttZqu+d9HInLkk7U0uVeEKo7Je9KtBt6TsAqpQLit1IkyyfkGQiDMQZIk8VeNYf
	 tGBUw9EYFGYAuUq8VQ0JSNpb3jyONR6VGS3oFvFkm5DAuESUVDNUVw9Q9DKWsI/9Vi2m+
	 dnBvRGRKzj96JYLi4F/PlHrJ+yWiGlc5J6SKR2+laDIy+chtMkPS0raB3UIukZgmlumBT
	 FR3ZqSdKcAMRJm21aaGrJ/gErOuROLwpkYdKWNcQuDbjaaLuWJtbXSMqDzz5WK049aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nh9mi7yY;
	arc=none smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A44606A33B
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 16:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46A44606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nh9mi7yY
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-9912c47367cso1559046241.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 08:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794587885; x=1795192685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MS4BVrAatFI2pIIKsYtpuHHigeSrBF3sT2Hx9JJi8UE=;
        b=Nh9mi7yYJRKl/4/tRdF5u1E9gHm55/+cOqI8Sc5FkMppuaPnRbkkvRnUE2a/qqWSZI
         1ZxWu4OVFOqBInV/XQfSOyR496+4JonEsmeLI4OR1y0nWxxAsXyIhbt1Bp7DINosE4HQ
         8ZpS+w4wyKQ5kGqbSAR+OJ0Dg5u5XiYDOnvw24Csuys8f7mo0o7aZD2OH2n3Ey8gya+c
         r2nUP+U6ka98r3MP0gW7yqL87aMetA4kSMqgRGH4W/rfYrJbnTLG8IB5npsi1IS4RuOB
         HqOsaJIrQxWbT//mpjmyFQweSPFOAF7EaP65gI1TZ5z9C5x2wGi36qAvAxxj6C8E9VhF
         i76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794587885; x=1795192685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=MS4BVrAatFI2pIIKsYtpuHHigeSrBF3sT2Hx9JJi8UE=;
        b=rNZrDKPoUGbBn9+zlHWaMmrVKXoaXkdHRAftX/0G0G9usodzgcEuATiiIvfB8xVbHp
         lmOCkNG1yPPDb84wedHbJ/25pAxEMXXJn3Bcc6Payy6uhELgpwUcNlX/Uy339dCkk3ab
         RzEicYnO1r6CQdbi1ij4GAJv78TKMHGmL9nkcEEDDK040JP+4rmitwFFTiTDOeEuPYgW
         4ehMSqfxQGAXPgEpmreq082Qj7US2BBvSnQYUHZu7CK1CDpbChNjYfoYRw1hLotceW1L
         ZwO60K13NUCLp2qyvYcLxl0rEdBf9xR8vxBPx51Yb5ZEo8n5vvatD4P92lJU9qV+REyv
         2Hzw==
X-Gm-Message-State: APuU4Z+Jb5Wz8v3Xx2m89Jnv7bzlieabkWNV8Alg2pywNZpF59aC+V/z
	BR2ZzusIvbkpcazIeCT2+nUO40dXIal+xhYgVWsmf3J9Hf6N32vG4nShrrL8kIx0uds=
X-Gm-Gg: AYBFou3Tn+XyTqMqDhOH8gMRMthNLOHIyJrI3jYE+eW38A79aNdKg2Gpm9qoKYdbiFc
	rMYYCYTkK7VCwY5E+jHsT+gx+uGNA0JofWeJeoJdVE9702/Q5TpyWy+r034kwjlCgZj+A+LEiGZ
	j2foL+goZKwmp4tNRC2iCT51PUXmki3ebI1UH9pvEqFD+F/pyq5NpW+DFyFYXbwEENet+mk4+UZ
	9LdIV6v6CxMogQmvjVojTA3gsWBlKO2toeK+RMFq0w0hS1E+TYmz17nJOxaidtv0JVdO2h5SW8N
	8xdobrdGRAZ2o+0Xz0k6Ck/j28IfSfmnqAtNftyZLRIs/uUYjWRoqPdha6XsT54fMj2sC4cjE0U
	MT41rqVoGrNLJw0n3vtNKWwZk6KbxIejJ7WIEngNVXBfUyz1nSQO/+oFKUJvmXg+etMPidW9oyF
	NnLIxUnwywfaRMNXKQbUcuDi9hPB13u9e9pctXbi5rqY7cFtvel5IshskRrTLOVnpw3w02yWEvw
	vIx4QOTqq3Wy7uK2q3EC/HR8J8Wvb4Fn1WLds8gWDc2QiXCyS2hUSQ10EuOu8xgvw8QPECcrx8a
	opR0HlYLiM2/XxzDUVcoQ6XegFo0j+NJpwxAhecMqpw0Dvq43ztEvUOm076kogLRvR8IBsIKOuq
	ZTem21tkXJFzV7zKJWR/TIYa8wqU8nW+CB3KoXhfsNaak+OocEJtFI0J2ZP5OpolbvWFmbAq5A5
	+9BLc=
X-Received: by 2002:a05:6102:c07:b0:7b1:3ecd:3d8d with SMTP id ada2fe7eead31-7d631755ee9mr1974208137.7.1794587885091;
        Fri, 13 Nov 2026 08:38:05 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c842ac652sm1746701241.10.2026.11.13.08.38.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:38:04 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 4/6] client/player: Add endpoint.clear command
Date: Fri, 13 Nov 2026 11:37:56 -0500
Message-ID: <3a89c9c5c7a0defa721d9e4920e947994cdedda6.1794586887.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794586887.git.luiz.von.dentz@intel.com>
References: <cover.1794586887.git.luiz.von.dentz@intel.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add a command calling ClearConfiguration on a remote endpoint, to close
the stream of a given transport or all the streams of the endpoint.

Assisted-by: Claude:claude-opus-5-5
---
 client/player.c               | 57 +++++++++++++++++++++++++++++++++++
 doc/bluetoothctl-endpoint.rst | 20 ++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/client/player.c b/client/player.c
index 88221076c1e0..932338ef53a2 100644
--- a/client/player.c
+++ b/client/player.c
@@ -4030,6 +4030,60 @@ static void endpoint_set_config_bcast(struct endpoint_config *cfg)
 		config_endpoint_iso_group, cfg);
 }
 
+static void clear_endpoint_setup(DBusMessageIter *iter, void *user_data)
+{
+	const char *path = user_data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
+}
+
+static void clear_endpoint_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message)) {
+		bt_shell_printf("Failed to clear configuration: %s\n",
+								error.name);
+		dbus_error_free(&error);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Configuration cleared\n");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_clear_endpoint(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+	const char *path;
+
+	proxy = g_dbus_proxy_lookup(endpoints, NULL, argv[1],
+						BLUEZ_MEDIA_ENDPOINT_INTERFACE);
+	if (!proxy) {
+		bt_shell_printf("Endpoint %s not found\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	/* The path of the endpoint itself clears all its transports */
+	path = argc > 2 ? argv[2] : g_dbus_proxy_get_path(proxy);
+
+	if (!dbus_validate_path(path, NULL)) {
+		bt_shell_printf("Invalid transport path %s\n", path);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (!g_dbus_proxy_method_call(proxy, "ClearConfiguration",
+					clear_endpoint_setup,
+					clear_endpoint_reply,
+					(void *) path, NULL)) {
+		bt_shell_printf("Failed to clear configuration\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+}
+
 static void cmd_config_endpoint(int argc, char *argv[])
 {
 	struct endpoint_config *cfg;
@@ -4625,6 +4679,9 @@ static const struct bt_shell_menu endpoint_menu = {
 						cmd_config_endpoint,
 						"Configure Endpoint",
 						endpoint_generator },
+	{ "clear",        "<endpoint> [transport]", cmd_clear_endpoint,
+						"Clear Endpoint Configuration",
+						endpoint_generator },
 	{ "presets",      "<endpoint>/<UUID> [codec[:company]] [preset] "
 						"[codec config] [metadata]",
 						cmd_presets_endpoint,
diff --git a/doc/bluetoothctl-endpoint.rst b/doc/bluetoothctl-endpoint.rst
index 019e64e38452..ba30ef769ec4 100644
--- a/doc/bluetoothctl-endpoint.rst
+++ b/doc/bluetoothctl-endpoint.rst
@@ -154,6 +154,26 @@ Note:
 If the endpoint was registered by an audio server, it can't be configured from bluetoothctl.
 This must be done by the audio server as well.
 
+clear
+-----
+
+Clear Endpoint Configuration.
+
+:Usage: **> clear <endpoint> [transport]**
+:Uses: **org.bluez.MediaEndpoint(5)** method **ClearConfiguration**
+:<endpoint>: Path to the remote endpoint to clear
+:[transport]: Path to the transport whose stream to close (optional, all the
+	streams of the endpoint are closed if omitted)
+:Example Release all the streams of a remote endpoint:
+	| **> clear /org/bluez/hci0/dev_00_11_22_33_44_55/pac_sink0**
+:Example Release the stream of a single transport:
+	| **> clear /org/bluez/hci0/dev_00_11_22_33_44_55/pac_sink0 /org/bluez/hci0/dev_00_11_22_33_44_55/pac_sink0/fd0**
+
+Note:
+
+Clearing an endpoint whose codec configuration was cached by the remote, after
+its streams were released, releases them again.
+
 presets
 -------
 
-- 
2.56.0

