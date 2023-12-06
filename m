Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcvlAmtM"
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29C3A8
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Dec 2023 14:04:33 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5d400779f16so160657b3.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Dec 2023 14:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701900272; x=1702505072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6upnpqTlW+iZFYTit77VVWgM6XmMcEzcNwLUe7bMQiM=;
        b=EcvlAmtMgwSDCZ5Vu4dvGgOT3oF+Vj5c6TuGYrk+HY5gLRhh2fheFk1JsYXOI2MPzs
         nq2IEOrOBjO2ZmFESMFvfEmCYU3WB7kTGjLtKLjpin1uPM3tLAqTqEiy8RtSplNLpY+i
         iVuBeO/D8pfRoCRKxhKMNjqrgN/XDtpsk38a+2e9q9RvR1uKEE0Sv1Om47sYtcIHagRq
         fdQiNIp31IHJ48RwwWyGQrvJAVuqVB2k7IA9vgcpa9aWVM4YRVvB3YkXDwanK7swaQe6
         DhMnbUL7rFPGcdU6eaVdTFtGtCqgCi/zZciyYn64dXJ+7+XUTaD3cKV0WQkGb/d+UsQN
         pa2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701900272; x=1702505072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6upnpqTlW+iZFYTit77VVWgM6XmMcEzcNwLUe7bMQiM=;
        b=FWJdA5iPakj6mqu1QdFE8lrLUBWAFCNeJ8IzA7xhhyu1rJ6NsyovvwUIdeUM1hfF6V
         KvU758rN6baSVB+rN0x4aNbRFd+gV6fofnLhfS6A8ugo6+ub/C7JC3PZaODNCOnl89PF
         A3xL2RwNpJ1vV5kQ3UtN9Ol20dlr94b2IiKoP7PQm1vNX97D0kO/ESVoBSTEds0XRvQ4
         ft4kdDInt0Zh0mouNdrItRaweXKTXfKWTuB74A2e/tn/ql5Po89t0ZqXs2aHGoweuWRG
         6lR6dNH3kvc2aLBzh5bt/DK18m7ckWV0UTt77W8HDZU0zTsUNtGK7nHPd1PNJad4gaiW
         BVoQ==
X-Gm-Message-State: AOJu0YyjdVedQpw3ANbtw0bDWHUWKDC+TYV44ubfaDQ3zXKbareQjuE9
	mtXzTFkBmwg+kyga0eci1q5iS92oEyM=
X-Google-Smtp-Source: AGHT+IE2bSf7Wa7CLcR7CjTfqj3GQDxWMbXZoLBAL+vbM0FHYHrKgG63WQ7BD4cMGj0aH3+Kyf53DQ==
X-Received: by 2002:a05:690c:908:b0:5d4:2057:650e with SMTP id cb8-20020a05690c090800b005d42057650emr1152055ywb.16.1701900272136;
        Wed, 06 Dec 2023 14:04:32 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id l127-20020a0de285000000b005d79fce2daasm277513ywe.22.2023.12.06.14.04.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 14:04:31 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] test-vcp: Fix CCC value endianness
Date: Wed,  6 Dec 2023 17:04:30 -0500
Message-ID: <20231206220430.3713081-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

CCC value is 2 octects long so it needs to be converted using
cpu_to_le16 in order to not fail in Big Endian architectures.
---
 unit/test-vcp.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/unit/test-vcp.c b/unit/test-vcp.c
index ea1bc98766dd..2a08dca480b9 100644
--- a/unit/test-vcp.c
+++ b/unit/test-vcp.c
@@ -130,18 +130,10 @@ static void gatt_notify_cb(struct gatt_db_attribute *attrib,
 					struct bt_att *att, void *user_data)
 {
 	struct test_data *data = user_data;
-	struct notify notify;
-
-	memset(&notify, 0, sizeof(notify));
-
-	notify.handle = gatt_db_attribute_get_handle(attrib);
-	notify.ccc_handle = gatt_db_attribute_get_handle(ccc);
-	notify.value = (void *) value;
-	notify.len = len;
+	uint16_t handle = gatt_db_attribute_get_handle(attrib);
 
 	if (!bt_gatt_server_send_notification(data->server,
-			notify.handle, notify.value,
-			notify.len, false))
+			handle, value, len, false))
 		printf("%s: Failed to send notification\n", __func__);
 }
 
@@ -154,8 +146,7 @@ static void gatt_ccc_read_cb(struct gatt_db_attribute *attrib,
 	struct ccc_state *ccc;
 	uint16_t handle;
 	uint8_t ecode = 0;
-	const uint8_t *value = NULL;
-	size_t len = 0;
+	uint16_t value = 0;
 
 	handle = gatt_db_attribute_get_handle(attrib);
 
@@ -165,11 +156,11 @@ static void gatt_ccc_read_cb(struct gatt_db_attribute *attrib,
 		goto done;
 	}
 
-	len = sizeof(ccc->value);
-	value = (void *) &ccc->value;
+	value = cpu_to_le16(ccc->value);
 
 done:
-	gatt_db_attribute_read_result(attrib, id, ecode, value, len);
+	gatt_db_attribute_read_result(attrib, id, ecode, (void *)&value,
+							sizeof(value));
 }
 
 static void test_server(const void *user_data)
-- 
2.43.0

