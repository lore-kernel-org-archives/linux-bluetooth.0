Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515869;
	b=oj/5oQxC30ZYGDrFisZplciLm+F38VC812ziGJ0Pjafj6NDCoKQfnDSMXymP5AHVDKqI
	 aGZNvykz6f0KVWPEutCYccRNQy8cJtoN8z/qgF26dYYT7U9JRyfJV/DjOAeDxbPYSbd8l
	 AM5VTFK2Wh2wL7NarPQfNtdY3fgu/eykaiRGRLZ+n8R/CW+/5Dax6uCH0hEjePvAeyb/k
	 9Yh+MaciHJvC2TYG9NlS3xfsCn1bUCcvVdalK0yYRodS7/w6Ud6DLTNkIyHsMkLAdOq0j
	 6mBCMik4YllN3EBGfDXX8eNW3AoZBdMUJ1WwUohzkLoGvSrVboK+z/uFbhwozzhQZIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515869;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MS4BVrAatFI2pIIKsYtpuHHigeSrBF3sT2Hx9JJi8UE=;
	b=gcdFrwRprcS7PizLwD8ECEKTmuJHl0jBG6bXrsQVA6PxICgg3dShtIfggRaQ2lFkDg04
	 S6KIcwe1F1NEDYaqQWkXvadpgNFyrn/AhuTOHxaspEJ+LyGIPhJQ95xnZrG73SP+IyXnp
	 mbMUuXOI7DJxN1yA7VcNs/wnMQaxFfFoRSzPMgTqkDId/BmTCQ46E5SFn+1lKYIeqabdw
	 J7aS2Vj2U4G+LGBdVY+/DBfiy39dC8Ce6NwHCpIFiz/QajQ7Tq8seRZayfiz0IdlSvxJR
	 s01Ar+BU5+1OqnPv7os5LFpB2PVXdAlXXjrTgusHss9iEyJH/DQOpjbCcNqrqVF0v0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xcAXYUAG;
	arc=none smtp.remote-ip=209.85.217.50
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE93606A33B
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 20:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCE93606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xcAXYUAG
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7cc013095d4so53049137.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 12:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794515868; x=1795120668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MS4BVrAatFI2pIIKsYtpuHHigeSrBF3sT2Hx9JJi8UE=;
        b=xcAXYUAG2cEExr+/F6OpbaE5Jem9nN2rNmPERhxNcQU8B6XWECYSx0ktO8UFaFuzf8
         dP+fFnbuTwozA0moDBcaq0xB/4PBbR30VeHinQkjFm1Ybzw/aFG+q2aa0b0VDk/5kRjm
         WR0GJUgrlxeD9tdTZmi4qRNXGozCgQNC2K8DCrSzICLDgZDFE7R65RIWLdrj+xPWzG++
         NT8+iMsFRqZqPjcJNoIAAbbfzhGOtBTbAMKGBDBLDnqmmPiFKtXVroP+s1x9ZJJKSOi+
         F8bCGH/MsGpyldM0aqUKnUcGjmsR17FsN+tKP3AtAJQDVxYqtrf8Is+G6dbON+XHTyZk
         6KYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794515868; x=1795120668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=MS4BVrAatFI2pIIKsYtpuHHigeSrBF3sT2Hx9JJi8UE=;
        b=kYZFcEIAGjyv54P55Vfkf6QFxZKl1M9zkpWJhWN5JYRc3aOWFd5rVZnkTq/wuB5+2+
         fybo7XYa5JHmAWq9u7GOtw9Ik+b3r6az24swLdFOk2vC+OYNPYScfMsSoBgQqAj0YMJp
         xnYx+32q1ztQY5jshRSfRlPNx1YyzBm2l8FRArz8DdkrvsRaUly0ngiaTBNrk9694+PF
         Vm/A01ITZ48XhdKcFhOxYlTZHWYALJfpkYdIE7phy9JGTkTW4Kg7ftkYkM1IWhzGwAgd
         tNRXzQFBVscU/Rq5OqaQiSOVsDEAOTAe/JrtzXDxNdAOy/PCxHtrbqsRP/Sn1OrIbqy5
         wVzA==
X-Gm-Message-State: APuU4Z96qq3BRKBkzEulophNqNacCpmq46C2zk0jVdTC2N3j2/P7ZE59
	c8NQ2yraSS6Z04SMOTwjvTd3FH3r7af7EpQMGn59eUTJAbqKIYpFz9Hx22B9dg==
X-Gm-Gg: AYBFou3p9/eKK9OBJ/BWduyZiuObt4eTkRLySL0AZtYtdikqdDW+By2vfouIYA6bbbv
	9gC1z613Cw/6yTken2p+UjdDMFRdQeVdtl7T4pS5lWDQRwZE5GeAwXT/pZ3gtBlwBuf8vrL35Cb
	S+d2KLxqhdoVor0sZL76vXzhv9YWPgk7kUeEoIXKcrbYBotrt52kRom4VBI/UisLtf0i2OzfnQ2
	9H0dd0uzMerDCYq58uIZuiejxL47+kLBc4ZC9r5UErehUSxPr7mND5OG4xz6ZwXcMCmT4apWm7y
	aA26h/+0wYL+cr4GvLB7JUIOlkMEUDbkH8QdkEgSVqXihJv62WYuc/YiVO/Q1Pd/jSz0qVYIV9M
	naeWuBx6Dou2I2sosoe/EYkI3xXpDtABPd4slBUS20Pe0KuJqMdOfnDgipGp/JVAsP8MvWMizLH
	iGxqqe+FwJyriqtd/OzweodhrLD9hSw/egks+KiChbLo24TNNzlqLCEiAdTaluB5XKnuszYAKlL
	ZV7qIVkYi4RQyXn5PTXwk8dUNPM6aeQ1fOii2Ry3LFKoE+2fRsUjih48wdaDufg0Kzw97NutFyx
	9ziMLO5cSBTJbkxtrdwDJvnuvGWjMOtp1yOEvv95+9PE5IY5uYoUNhxbAgrhIDUHufn5A3Zd544
	Ey50f4eRfeSf8jtlLCOZ/q6SIlgk5Z7KsJznQdiTojfAHFqRoo3USqmSHtY9ThowXwJ6jZwxpWs
	XuF/FI
X-Received: by 2002:a05:6102:2922:b0:7a7:198a:c2c6 with SMTP id ada2fe7eead31-7d64db3c827mr105430137.36.1794515867872;
        Thu, 12 Nov 2026 12:37:47 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee34bff0d2sm145765e0c.0.2026.11.12.12.37.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:37:47 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 4/6] client/player: Add endpoint.clear command
Date: Thu, 12 Nov 2026 15:37:41 -0500
Message-ID: <b80bd69e15055425c70643766603b4f232c4fd03.1794515788.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794515788.git.luiz.von.dentz@intel.com>
References: <cover.1794515788.git.luiz.von.dentz@intel.com>
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

