Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463CA2E3378
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 20:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742849162; cv=none; b=noxsSLGUaR9y0+n39gPjECKVnUaUY6pznMIIkmUgGBK1Z7REGEzEdOnfrZIyPbtX2SPuGnmc1HkNg62Z1I29wnDeUcwi9odgByN9LvVT4KOzjOpY5onlPmYOEWMuK7O7yz9drvamlknNmZkqiPjm5eB5POjP14tm0Mv2MRLJPWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742849162; c=relaxed/simple;
	bh=qLHUy6DMQUsoSWiq9BzX7eWvPOkE3lwLqpoHKdzvBT8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMDo0EigK8A4rP4sIsAQYYsHZ994ES0FajnpyeBvUlo4GN4zLRmpv04oISv7IQEIZ7GtrQwpbWlU7nF/DFQxDAGasZVWkchqSFyBFAcjjqGNa/JsbIBzj2B5VwYyCftStnHUZFjQBG9j157pOMg0WkYftZlimeYMIQ/fylv3b+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OePWCkY5; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OePWCkY5"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-523eb86b31aso2052785e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 13:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742849159; x=1743453959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C6Ljw0MbJCo8ibfwHnTywhW14j1Brr/x4Zlhz3lCEDo=;
        b=OePWCkY5/dNykjFZA08rF6YxWLvYjjrTAZvTRFrCtYvfP4HppHiTwtb8JM/DCf6OFz
         nF0oTO7YI9YhKYou/zkNTy/C4UNPPxnKAmiLqOllOdPevAUWDZNTaNiv2oCWkzYCmx1Y
         PJJcQKs01yE38XrVS2uKJ5tBVZ9L5IhsVTtfJD84LDIpJ6f0WdhlEUYdUZuQZXaXl6rX
         gRwLsG99YZv+ef3dnHfmozz9GVGVtGO2g687mdgLeCn0CIrpJ5hzjWzTCb8XNNTuNY+8
         abzXZokBzCoKPUK+BRCWN6yzHa5e88H3Hqb/CqTt+mh3jBYyUHmikfIpFCf4TSorjP4h
         9KEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742849159; x=1743453959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6Ljw0MbJCo8ibfwHnTywhW14j1Brr/x4Zlhz3lCEDo=;
        b=bjo5I8TlvsotIKYX/zjej8Vu+2xh9jIBepdpVOo7z/EZ3Zr3m+gHI2eaJMLvsWKH60
         PwCgs+rTPf9iAOUraxF+CjwHjHSmQEheasTNs+fu/YJ6WtMeNK4Bm6hOlDxi0o7kiG71
         JFU1GUb5q02a+UO4iWCELGRpKXvZTL0QoLuxF8g+hEQ/1uF7WKtzNdSNeogorbtH4EU1
         g0BfZcYGQ757hze1gmoQQjUaE9HUNs7TEGyDeI8euqrmzz3gGo18ZiYIWML6o157uiQG
         hvOxxiZyqLKZMqpiKXIpwR7EhE18pAdefo8SYlSWfkC9D7kZMBfg5CerGg15VpaILZes
         fNWw==
X-Gm-Message-State: AOJu0YyC4jHhEstOshaj5dNK7OGjUud3oShZqBAbMAxJdBRjquuF3kB3
	sF2BWgH7QiFNycfVfHLMb4Y+74yuWrlYpCwUtScaROkBbcPjpUdK+MKDAPGC
X-Gm-Gg: ASbGncuDiLUE/KEvethTCJAJrdDeqn8KBWQaG7Bg4BUiIJ0K6/V+WeLIe2gpVXwEOJa
	MeZ8wE9URa6Fk/bHSfyZg1qvZpQ4lOprVBQm7bwF25dufvSq5vhE0ky/h6DONs2RNl03cfCNRyL
	TPqOULwsfpa81BXtZbiBhiniBEpPEvdUSGXIWBOlfKSk1ukbKZLBCS3TtplE7WLi83MAJqzu410
	5uMW0hso/+TozvlCKGNBvQjp3I4rnmB99Kg9JnhatjQJ47rFF+vP9jAbYgEkdxWr3IuNVYo3X44
	Lk2LP3t4gzq0d1+uLE6ZqJ8mUYQC8gI+vHJr/lYbSRLqX90vQfW15jUSeRnE1OmiJJMKpa55bYG
	vya4ZRfr48D5prOFVombPu3Nw
X-Google-Smtp-Source: AGHT+IH4OORgh9Nv97UOFZnATw6XosanPrSdS5L6QDm8gCHUo+VcW0hAF9lSNPm2wJuCgoQFKh2/gw==
X-Received: by 2002:a05:6102:5241:b0:4c4:dead:59a3 with SMTP id ada2fe7eead31-4c50d496a1cmr11550973137.2.1742849158828;
        Mon, 24 Mar 2025 13:45:58 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c50bc119afsm1690015137.10.2025.03.24.13.45.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 13:45:57 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/2] device: Make Connect and Pair mutually exclusive
Date: Mon, 24 Mar 2025 16:45:50 -0400
Message-ID: <20250324204550.2196697-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324204550.2196697-1-luiz.dentz@gmail.com>
References: <20250324204550.2196697-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes Device.Connect and Device.Pair methods mutually exclusive so
they cannot happen in parallel, so just as Connect:Connect and Pair:Pair
combinations the Connect:Pair and Pair:Connect will now return
org.bluez.Error.InProgress.

Fixes: https://github.com/bluez/bluez/issues/1125
---
 src/device.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index a04eebe1dff6..6d80f86f5fbb 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2620,6 +2620,9 @@ static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
 	struct btd_device *dev = user_data;
 	uint8_t bdaddr_type;
 
+	if (dev->bonding)
+		return btd_error_in_progress(msg);
+
 	if (dev->bredr_state.connected) {
 		/*
 		 * Check if services have been resolved and there is at least
@@ -2639,6 +2642,9 @@ static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
 	if (bdaddr_type != BDADDR_BREDR) {
 		int err;
 
+		if (dev->connect)
+			return btd_error_in_progress(msg);
+
 		if (dev->le_state.connected)
 			return dbus_message_new_method_return(msg);
 
@@ -3124,7 +3130,7 @@ static DBusMessage *pair_device(DBusConnection *conn, DBusMessage *msg,
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_INVALID))
 		return btd_error_invalid_args(msg);
 
-	if (device->bonding)
+	if (device->bonding || device->connect)
 		return btd_error_in_progress(msg);
 
 	/* Only use this selection algorithms when device is combo
-- 
2.48.1

