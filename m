Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0B11925BC
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 May 2025 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747934999; cv=none; b=DS3WsTHCgSlMJQjol2JwArIm8pVJ5Yx2ROQ6inTTChycbnBuSSCWOLCEG+qr8FVtL2LcHUxekmUZ3duNEkWPEE2FzRDqNyoUMcmBOvCZbM5f6sTdMCztt6kyOIKjpM/g2GaV9haQiGR2/QPe2MPqhhyI29zHomFoXdbdcL2TtTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747934999; c=relaxed/simple;
	bh=1eZrw/AwTuL/+T6HbZsLPlOG2fnve87biyVLFhY7Q5c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kvjc54tEKQeHgHSq4rfQc/y8iinnUc7m9p6nXP1M9ZaQPyPvc5ieEvopQHG8jtGoQo0zXb4xmRYWvAGfn81YYsnGenHFpUg9V6JGoDvV9Uehi5djXchEJ80JbzamRMDVMKGdNSht1ZdLL/Tgp5sflV+BOul5x172OtGoRQXJ4S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fO0B0fgP; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fO0B0fgP"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-52f036ef186so615315e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 May 2025 10:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747934996; x=1748539796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SSwpShzqkrEEWLovRcsJUJPukGlflT/Ls8V7hd/Y1gs=;
        b=fO0B0fgP03L0qWYK7C2GqRnSE0Fp0LzONqN3pq9VMSy5TuR/X+bLpXgGSWLvGu6RMf
         tqjFYoDtkB3llB8qBiHHzLDqPRY+L3LgicPZbJv6xtWgtdfj6IZ3go2go2N/WpbNkxup
         o2vqLluVZPXlpqO4YO5Tk2+KNMCqPRTu0BzgQC4Yn7QTS9uBGY9P7vMFiPu0yawJvA0p
         H+Wy2ATuAokzlXQg4Q/Poj9QHtzO9zBs19l71AhpzkJZEnY4DcyNdW+hmcYg734Wf0Yj
         1i55KEsXsT8xPmUPSX18UqZq5onyPQS0tSqfqCj2IbooHZlB7tQh78+4P9hqGsjUuTs7
         bJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747934996; x=1748539796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSwpShzqkrEEWLovRcsJUJPukGlflT/Ls8V7hd/Y1gs=;
        b=xBjE13VZmGgodJWyW0Sqb3G7MhTcRb/Dv/TTHKV+sL4oze0JetTBwBYGTNWJe9Eyzv
         4Q0FTsdymKMjcpfCgHy5BH6hgzdsoL7QHOwUwtorRFcjVyoaxnsROX9Xzn+w9ciGSWQw
         IFUOZffNvzCuAVILdmM4FJ1PFhJtGZhHb8uUDjUzgH+zodAgdwBqGWIQs1uJmy/uDx/h
         zB9dn916AkTNzcjQBZO9xIgMvpCcJ/ZxIDTQI5n/O9cEs2xoG4iUFAfOsRT5gYJyaehm
         AiUueYFTuuMRC0u8iS39wdoG8p6u8/F2Oqn9Kr3triy9aTCdZAH/kj3bdy9+GOi0vBgx
         957w==
X-Gm-Message-State: AOJu0YyH52DmXeUBFepBgpJ7lMS1eAaNrJZrbAvlgcy8I92fqvGSC2cG
	EM6QRkcyFWIoC5NMNDNhdXk9UUqg17GCXDtUqmfacX0zV4zTsC9d+ydVkBjY5yli
X-Gm-Gg: ASbGncsEHe1K7dlLeZnBzn7dA3chR9etmpCfg16vgj9EOlF12ZSziyifWhAoTsqfRVO
	7SRzVnbN1lqxcxxW4VNbGSlR6GTpjJAk5r07PPNZiSoTvCK40pgdF8I+WoElpIOlHYY+SQNbGge
	arVbPanyTHROjCyd1VEA4OJriMWWGkyi9QajL5ACk/2/X9qgrPUiVlbssLi41T4UuIejAiOM+YI
	sE1MbAKV74DPhUVxFXaXrVQ0cyrKJRj8eRv8PSd23DZ6EgVnpvhwrpSr5tssaouU5tCOMR04UGI
	4k9z5itNF1qmiebjA4BZEIP/VBp45HsAE5QUNZLWgsvDkOZg4nMCx/ib96XelwbqM5C1RFqz+gn
	6ElNLwkz5eUwwF5CAjTpC
X-Google-Smtp-Source: AGHT+IGJoounHWcW1aSgTWFDKUCKh2bt5nAUH3/b7E3KvfYYDslbkMpSDIZg7xbG16n3xZOPZX+8+Q==
X-Received: by 2002:a05:6122:46a7:b0:52a:cdfb:7ff9 with SMTP id 71dfb90a1353d-52dba866824mr23295309e0c.4.1747934995985;
        Thu, 22 May 2025 10:29:55 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52dba91076esm12220321e0c.3.2025.05.22.10.29.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 10:29:55 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/4] adapter: Implement SetFilterPolicy AutoConnect filter
Date: Thu, 22 May 2025 13:29:50 -0400
Message-ID: <20250522172952.3312270-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250522172952.3312270-1-luiz.dentz@gmail.com>
References: <20250522172952.3312270-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implements AutoConnect filter option in SetFilterPolicy method
according to its documentation.
---
 src/adapter.c | 42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index fd425e6d2fe4..328a6baa54d7 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -214,6 +214,7 @@ struct discovery_filter {
 	GSList *uuids;
 	bool duplicate;
 	bool discoverable;
+	bool auto_connect;
 };
 
 struct discovery_client {
@@ -2697,6 +2698,21 @@ static bool parse_pattern(DBusMessageIter *value,
 	return true;
 }
 
+static bool parse_auto_connect(DBusMessageIter *value,
+					struct discovery_filter *filter)
+{
+	dbus_bool_t connect;
+
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BOOLEAN)
+		return false;
+
+	dbus_message_iter_get_basic(value, &connect);
+
+	filter->auto_connect = connect;
+
+	return true;
+}
+
 struct filter_parser {
 	const char *name;
 	bool (*func)(DBusMessageIter *iter, struct discovery_filter *filter);
@@ -2708,6 +2724,7 @@ struct filter_parser {
 	{ "DuplicateData", parse_duplicate_data },
 	{ "Discoverable", parse_discoverable },
 	{ "Pattern", parse_pattern },
+	{ "AutoConnect", parse_auto_connect },
 	{ }
 };
 
@@ -7212,7 +7229,7 @@ static void filter_duplicate_data(void *data, void *user_data)
 
 static bool device_is_discoverable(struct btd_adapter *adapter,
 					struct eir_data *eir, const char *addr,
-					uint8_t bdaddr_type)
+					uint8_t bdaddr_type, bool *auto_connect)
 {
 	GSList *l;
 	bool discoverable;
@@ -7242,15 +7259,21 @@ static bool device_is_discoverable(struct btd_adapter *adapter,
 		discoverable = false;
 
 		pattern_len = strlen(filter->pattern);
-		if (!pattern_len)
+		if (!pattern_len) {
+			*auto_connect = filter->auto_connect;
 			return true;
+		}
 
-		if (!strncmp(filter->pattern, addr, pattern_len))
+		if (!strncmp(filter->pattern, addr, pattern_len)) {
+			*auto_connect = filter->auto_connect;
 			return true;
+		}
 
 		if (eir->name && !strncmp(filter->pattern, eir->name,
-							pattern_len))
+							pattern_len)) {
+			*auto_connect = filter->auto_connect;
 			return true;
+		}
 	}
 
 	return discoverable;
@@ -7274,6 +7297,7 @@ void btd_adapter_device_found(struct btd_adapter *adapter,
 	bool name_resolve_failed;
 	bool scan_rsp;
 	bool duplicate = false;
+	bool auto_connect = false;
 	struct queue *matched_monitors = NULL;
 
 	confirm = (flags & MGMT_DEV_FOUND_CONFIRM_NAME);
@@ -7310,7 +7334,7 @@ void btd_adapter_device_found(struct btd_adapter *adapter,
 	ba2str(bdaddr, addr);
 
 	discoverable = device_is_discoverable(adapter, &eir_data, addr,
-							bdaddr_type);
+						bdaddr_type, &auto_connect);
 
 	dev = btd_adapter_find_device(adapter, bdaddr, bdaddr_type);
 	if (!dev) {
@@ -7483,6 +7507,14 @@ connect_le:
 	if (adapter->connect_le)
 		return;
 
+	/* If device has a pattern match and it also set auto-connect then
+	 * attempt to connect.
+	 */
+	if (auto_connect) {
+		device_connect_le(dev);
+		return;
+	}
+
 	/*
 	 * If kernel background scan is used then the kernel is
 	 * responsible for connecting.
-- 
2.49.0

