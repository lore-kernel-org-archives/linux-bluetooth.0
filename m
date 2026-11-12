Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794507279;
	b=XPD55rQcSvyvLFLW9LlVZDCACPRXHI0URm0NIUhVF5SqBLISo526MYzQDsJIgZQX93YC
	 qNB18FGEm1cESno5jUro2fEd3Btmml+6EFF9JY/WbJSiVPJK9z/oKMsVCRBqasjzy3DFO
	 RybFRlmu9nF79HEyS99qQcZoxGWThsv12tQFBoezxgX7zQG5z729io9jll5j4TX3YpjQx
	 LUB8pzD+sgmU1v0uBZOwl5dgLgMjWTQXRbq/3Ge0taZ2n2LhpNLMV5OnnDw5KtVe3Vvn+
	 UoZRAkr5549DLr33rA5JQJvvUHWMqMJezqSog91O5Nnj76Ixu57wCUJQ0MOmG4EOVeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794507279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MS4BVrAatFI2pIIKsYtpuHHigeSrBF3sT2Hx9JJi8UE=;
	b=ReBmU5rEnqERO5ZiwxbGARAlSjcVDONZm0CwzQx4YFyZDffmwNRtaKLn8zogxW3aPXaa
	 qtX/gI9K2uvVfUPUteteLtpp27ROClNwKvxv7zIBc5iDUgjC2izOjoGOqSOEBCIl7We/p
	 lWDryrPUygiXvYjZMhB9zvy6rIYY34ffVj3qDGsmlCzM3oFjW3bOBdQHiTRAVRlMTuNPM
	 Z526igGG1Dsa6u8R1xe24DnFZvaPqLWmtD/W4mfg0ZWlzOuN+pLhU78M70rLUPFGZr6hr
	 kIpuflVskwKxB8gdsEqNpbxSckNcEle6y25uv0FUXYcSA0xqsuGk7sV6U0BmuzX4lFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=plzM3EEx;
	arc=none smtp.remote-ip=209.85.222.43
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62858606A32E
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 18:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62858606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=plzM3EEx
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-99be54f9c14so783862241.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 10:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794507278; x=1795112078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MS4BVrAatFI2pIIKsYtpuHHigeSrBF3sT2Hx9JJi8UE=;
        b=plzM3EEx9ZYMMdwGDBTbxO6Lg0VLWhjahVfZVfyy4o+o1vS/534CxhYVk4oA19VV7Z
         FVQIhBMFYrjwXFfsbGT6wSFUHUQWZp7UK1a1s6cM/23viu9snBHWSWnBNs4kGaJgtdZW
         Keiemz8V6+yx6RtZvX5kGJ6MP7JGy7efaOdZ5NhwHosmQFdU1Sc0yZE36ZG1tUbGr6tr
         NrI2L6KkKK8mPhAAZpdwQTrbFL+zpyUbctr9YtYHlc7hsNMMFu8zyWh9+XAA/levWc2P
         C+/VcXNPgX/9MZc7CbsWQ6yr8To3FtxXSo/NbBOt5XcA17PQX++6UYtYbpeN7ELwJbz6
         LeYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794507278; x=1795112078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=MS4BVrAatFI2pIIKsYtpuHHigeSrBF3sT2Hx9JJi8UE=;
        b=lcWZ8W7yOfZmtxbXu3sVDCnG8rXvYGF5ruU36DRfjNaSZBVbuw43rcCNBz/BpV0cHX
         oObCOQq0hmB0cScEUdU/jk69adZg9RXMsoyv7Pq0j8sdXfUjqVLvebmBipP5RT/FfWI7
         0xtl4ca9IJXQlBf7lKPDpXIAA3U7t7xtzYOqKkoH53ey28/OfdhLD11li8kmRTe0g/pA
         Aq8ey0CUTtQ92jaZCgGsGsKPcmc1AE5cZClcHtKb1Fb/5QqKlYpKGE1CtJkbvwHcNdI1
         OrXLORI5HYLJIALp3Tca/X/jyqfLub/krq98kLVmwW1wJh7jA1xSBEj/F374VyLmSBQU
         0UaA==
X-Gm-Message-State: APuU4Z/XXp0uAhtGMDxuBStm3zwfEDs+MuajdA1y0JcxWbYQhxjZ4ohr
	fe8WavbYPSvCDoFRJ38a08jc8D1cjPl0OAMbqqrfcdw28wfSGrn/kATYFdImIQ==
X-Gm-Gg: AYBFou3Z/DoVM7ZJx7riVh52g2cyzQCt9NCY9N/KHCsHV5zjJqwgmB9VKi8VUsVMoc9
	48ovqesoFo0Pf03SITGl6m8LoVN6NGlNItdDD6nwQLCahtcM/MRRbRd80kM8OuhoZkli9FiTLIb
	x+eqNuk6+LBNsCl2uwmw0Dy+W8dcppaOAvjYkcZejt/338/L8jL+RcNJMZn6BlFbHvpd6FHXcKC
	1M2hrH5LYzqe/7Gum/ECZqqSKMO+nB6OZSK5+/T6SEbSiZe53sOeMZ+CMELket1NQi9HZDeXQJt
	L0jhfN2Sd1DTsCjbA/CmQF+XKJOxR6W2BLyuxbChMcJAYz86rYlIHHr4twKfW9BEyl2KzWH14VJ
	XIbPnRnGVZDMNrVGsT+qldSSaxv0hkXC9Xlk+EhQTpGqBbm0PzK8+eJOjfISy8FOvyB5ywhnrzW
	Ey2bgG6ISB1BDApzuG805eKh7obamRYbWf88qeOr5zUvgWN7VwwXgxp42m6C2xu04hU4PHuSrk9
	1bEMs5jnXEeT23UK4tbOfhuvJvPYXJlW/RLujY4CvMOZ2hEf/T7v47UShpDihbu8Wp+ESwumuvS
	Ayzb2g2yalXX6M5p1E+T7oPVjQIgtDdRK79dIOWnl6qyuFutCd2dwSSS1WzYyVM3+QEYGk58XmT
	PFwypkicMDBQNRckY55HIGpkk6MyEDFmQ+pE9FWdyoSRWN2Mcqd0/2sIWFX6pOUfqqiJdFOj8W7
	puCkI=
X-Received: by 2002:a05:6102:6a92:b0:7c3:874d:60bb with SMTP id ada2fe7eead31-7d64d6c4928mr6357137.5.1794507278326;
        Thu, 12 Nov 2026 10:14:38 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d64c1b33eesm178749137.2.2026.11.12.10.14.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:14:37 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 4/6] client/player: Add endpoint.clear command
Date: Thu, 12 Nov 2026 13:14:29 -0500
Message-ID: <df3a804182ce6111ff366307d02a64be446bcffb.1794504552.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794504552.git.luiz.von.dentz@intel.com>
References: <cover.1794504552.git.luiz.von.dentz@intel.com>
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

