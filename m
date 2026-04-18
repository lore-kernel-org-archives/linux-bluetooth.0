Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F4D2ED870
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Apr 2026 16:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776529624; cv=none; b=ZfU0YBLbA45164Env2bXDJGzpMQrnZ9MJZqSI50zKySzZ22QFar95yxbduODXYeaO+Q8OSqGdvTmzChKb4H+04PCeZZDNNw/VRRFjwyKySEFW8L7HWtxccEN4HWYDra9pgc/1T/P3GBdzkGw/GWkZlABrRCCPnNDzbXGAZwogoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776529624; c=relaxed/simple;
	bh=75SaJH/4818ZH1XMXICkiJ53A7XN1diNK/TCVCvq1uM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GgluR3NlbBNHE0PtzmrNhhysgQW5P9yeJlsS+GAyBVUTJwnvNzr5uXXzO6mQZfHcyS6dNDLL28jqIzpb7hAVOMEMsfBlc2K+MUwUKxmOkd8t/1vRJSoGzz00LYsE6Xuk3lEbozLGC6GU6xelee0rcLTr0kDf+OiNQm91HD/eGpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWwdXBc9; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWwdXBc9"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso15501455e9.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Apr 2026 09:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776529618; x=1777134418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=idx9fu13KE37KbDr/9eNW0Nm/NLHNXIRnsyoiAYhbfw=;
        b=OWwdXBc9HQDvMZ6PqBV3NnRJzCWRiPxHXMcYt+HJ58OFo4KqVHvHI9VJMAWwGpA7lA
         mO+HmRkyP6u0UOohLcjUp2YNFTvpXaNWJOWdsXscnESZbJlzeKRbHeyjimJcWMsD3do+
         QD3v1B3VnC5QD8BFggTeeqMlTY4EJqMeKGCNgQxQ4Emr8I2f4p2qJRjOLUWUd0yl5bF9
         299kPPJibZEQvUb3zDWhZIxixmX9lVWuGh9mYBp09HDcE942bzcBJjgQ3coFGC8hwbG+
         8iTKMjbPdRaE1iUAVcID7DYy6gBhANTGEmWhlZjJt4IH3DXWvzeGdJa7Tgt49+peeuQL
         Hwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776529618; x=1777134418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idx9fu13KE37KbDr/9eNW0Nm/NLHNXIRnsyoiAYhbfw=;
        b=b8XTfakGKvaFUxt0/8WV3rHooGgD90aps+PyOpG2zyq6SosaIsw0xufpaZ2OXdpENR
         CftFVdJ4z0I0I/yA90OHHLBp/XSzY+Cc0o47ocN8W0RWf3x9if65Q98bm3/VW+B5pjJQ
         8D4izBcQN/qAQawDQ1yiGUahopnyxken8shQPdNupST50SZnHUgyw+AIEKvsAlZN3heQ
         oN/ligBF2Mvc3LrrJGFZobIcTPfkzY2iLrhcDqd2Oq+nzKyPzLNfDXmWczWLiN5NkY7w
         NTpYYXjglHwelguY7YadBMNgkO0yl/5K6jSKgIiv8pmByy3DMw51tyFm50Qb4+aVx5b0
         aO3g==
X-Gm-Message-State: AOJu0YwOMSPX04z/TXrUK6J+s2j7lpgCpXzv/AXIIuA5dsrRwpUi1aoL
	0wQXO6zeOrqqjdZwhb5oM2lxG0/ijjOAHJFhGc5300IJOx8+mCpvMKEUf6X+XRsh
X-Gm-Gg: AeBDies2XZS9FkqX55FAgH+5U1+PhjbzAjbYxIOVhauawITinEvz/JiL8XM5n8BIQvy
	34JNqab60A2hoxi1kumXPEUDa6VlwDYRsoQyZ61/+4yQbmtqWytXpViSwy96/2tCR/E77tLbwV2
	tp5zjCO6SMyRRH9yiFF5/J5fgB0J2i9AocpeW7ea8DSyQm44kfOg8Wj9CZyGjdpKkxTlKopyIPZ
	JCjHHORehK8RgOe9OrfUwkB0UmpFt/OdZleV6DweuJIHsx0GfrcH9s8cxzOA6yu3wJIUETR/BcY
	9jDsGvY4EJn4aK7PpeJLaP4/BmE94+CZpuRD9ot2YjASpjQUJCxfRmr2gw3n3W0M/zb/VN6ynKj
	QRzxDT4OOlgFp88RIhpLyGVhfS+tLXWFLjEJFbVo8G7T9z0ogbKzfrgKBbIlaMRMSrDZ6JBPRBg
	O0GwTxO8cOKFqJmAZyximX8OvttciM2sMEbq9x59t0Br7wyus+9RBpOjUnmvKb3b6Q++npxnggP
	pJGwnpBMGGUsOovwsihwhizkwmJJdtGoH/Ek0lSym4aW5al7u9+scjPjCY=
X-Received: by 2002:a05:600c:4652:b0:489:a4:e578 with SMTP id 5b1f17b1804b1-48900a4e944mr27467305e9.14.1776529617891;
        Sat, 18 Apr 2026 09:26:57 -0700 (PDT)
Received: from server ([5.14.142.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc16f93dsm214456115e9.3.2026.04.18.09.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 09:26:57 -0700 (PDT)
From: StefanCondorache <condorachest@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	StefanCondorache <condorachest@gmail.com>
Subject: [PATCH 1/2] adapter: add DisableDiscoveryOnConnect option for combo chip coexistence
Date: Sat, 18 Apr 2026 19:26:51 +0300
Message-ID: <20260418162652.287637-1-condorachest@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On systems with combo chips (shared Wi-Fi/Bluetooth antenna), background
LE scanning for auto-connect devices competes with active connections,
causing audio stuttering and Wi-Fi packet loss due to antenna
multiplexing via Packet Traffic Arbitration (PTA).

Add a DisableDiscoveryOnConnect boolean option to the [General] section
of main.conf. When enabled and an active connection exists, the option
suppresses adding devices to the kernel auto-connect list in
adapter_auto_connect_add() on kernels supporting KERNEL_CONN_CONTROL,
and gates trigger_passive_scanning() on older kernels.

The option defaults to false to preserve existing behavior.

Signed-off-by: StefanCondorache <condorachest@gmail.com>
---
 src/adapter.c | 24 ++++++++++++++++++++++++
 src/btd.h     |  2 ++
 src/main.c    |  4 ++++
 src/main.conf |  6 ++++++
 4 files changed, 36 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 6df66b3e0..4a18adfe0 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1594,6 +1594,18 @@ static void trigger_passive_scanning(struct btd_adapter *adapter)
 	if (!adapter->connect_list)
 		return;
 
+	/*
+	 * If the user has enabled DisableDiscoveryOnConnect, suppress
+	 * passive scanning whenever there is at least one active connection.
+	 * This prevents antenna multiplexing conflicts on combo chips where
+	 * Wi-Fi and Bluetooth share the same 2.4 GHz radio, which causes
+	 * audio drops and Wi-Fi packet loss during background scans.
+	 */
+	if (btd_opts.disable_discovery_on_connect && adapter->connections) {
+		DBG("suppress passive scan: active connection present");
+		return;
+	}
+
 	adapter->passive_scan_timeout = timeout_add_seconds(CONN_SCAN_TIMEOUT,
 					passive_scanning_timeout, adapter,
 					NULL);
@@ -5717,6 +5729,18 @@ void adapter_auto_connect_add(struct btd_adapter *adapter,
 		return;
 	}
 
+	/*
+	 * If DisableDiscoveryOnConnect is enabled, suppress adding devices
+	 * to the kernel auto-connect list while an active connection exists.
+	 * On combo chips (shared Wi-Fi/Bluetooth antenna), the kernel's
+	 * background scanning for auto-connect devices competes with active
+	 * connections, causing audio drops and Wi-Fi packet loss.
+	 */
+	if (btd_opts.disable_discovery_on_connect && adapter->connections) {
+		DBG("suppress kernel auto-connect: active connection present");
+		return;
+	}
+
 	bdaddr = device_get_address(device);
 	bdaddr_type = btd_device_get_bdaddr_type(device);
 
diff --git a/src/btd.h b/src/btd.h
index c84a600d1..07c4d85ba 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -144,6 +144,8 @@ struct btd_opts {
 	bool		experimental;
 	bool		testing;
 	bool		filter_discoverable;
+	bool		disable_discovery_on_connect;
+
 	struct queue	*kernel;
 
 	uint16_t	did_source;
diff --git a/src/main.c b/src/main.c
index 818f7c06e..d7ddf5643 100644
--- a/src/main.c
+++ b/src/main.c
@@ -92,6 +92,7 @@ static const char *supported_options[] = {
 	"KernelExperimental",
 	"RemoteNameRequestRetryDelay",
 	"FilterDiscoverable",
+	"DisableDiscoveryOnConnect",
 	NULL
 };
 
@@ -1072,6 +1073,8 @@ static void parse_general(GKeyFile *config)
 					0, UINT32_MAX);
 	parse_config_bool(config, "General", "FilterDiscoverable",
 						&btd_opts.filter_discoverable);
+	parse_config_bool(config, "General", "DisableDiscoveryOnConnect",
+					&btd_opts.disable_discovery_on_connect);
 }
 
 static void parse_gatt_cache(GKeyFile *config)
@@ -1283,6 +1286,7 @@ static void init_defaults(void)
 	btd_opts.name_request_retry_delay = DEFAULT_NAME_REQUEST_RETRY_DELAY;
 	btd_opts.secure_conn = SC_ON;
 	btd_opts.filter_discoverable = true;
+	btd_opts.disable_discovery_on_connect = false;
 
 	btd_opts.defaults.num_entries = 0;
 	btd_opts.defaults.br.page_scan_type = 0xFFFF;
diff --git a/src/main.conf b/src/main.conf
index d31dd1b8f..22507c465 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -157,6 +157,12 @@
 # some stacks) or when testing bad/unintended behavior.
 #FilterDiscoverable = true
 
+# Disables background LE passive scanning when an active connection is
+# established. Recommended for combo chips (shared Wi-Fi/Bluetooth antenna)
+# to prevent audio stuttering and packet loss caused by antenna multiplexing.
+# Defaults to false.
+#DisableDiscoveryOnConnect = false
+
 [BR]
 # The following values are used to load default adapter parameters for BR/EDR.
 # BlueZ loads the values into the kernel before the adapter is powered if the
-- 
2.53.0

