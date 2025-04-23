Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B415528B4F4
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420985; cv=none; b=sphkovAhazKtwq8uFr0r6ny8bDfPNg3HiuR8+tlkBsnwnPIahIq2IV/9dw8tsOi1hEk5thItojHWtJpOkL7b5VpEXzu/PKqV9vg3M5G80p0Gr0cAdneI1WFgSnGocNzTd66mSKMPyV30xI0EKWh1AH6yf5nVHwoIkcW5E23qkBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420985; c=relaxed/simple;
	bh=UO7xT63uttbpBnaCw8lb3fncOxdmQ3/d2XV/QJGxPT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGVvXyib+DOoxmCxpLU6Y0YAcgrU7Ojr9cG/IaP2Tmi3s2Io92++Bx5HZiItds6Hgg1+6vMX2WQVkEMNikuSKEoy5c9JTELedK+NHFAXjMabv3gNLeSzRxSetmQwjAmZuI0MwFPUrjUDSpODgxzB7MY32QJxZi8pYz2n3j1Rc9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=XIC6AK1y; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="XIC6AK1y"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-47677b77725so72446451cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 08:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1745420982; x=1746025782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdAQgJGh6L8DgG96ysAv4TN+nxAzuWJNdtJrdyEhb5w=;
        b=XIC6AK1yU87x0aMaIHi2T1xbGpWImM/eNrPj+zOMg8uRu9HQQczD3IIgCSNpcqUW43
         rbUlTdZqfmFcqoGIzK43cGq3PMsLmxSWM1R7+rx5HXxhAx1gSiFsBGjKVyq7BX8UA19v
         PpCMFfq11XdnpS4GQYIhZ/c9TlQUlPfqZ8swsgN7tU0V0sbPa+jht7RkB1pfg9fd1mZM
         0FQq096p5YGS8y7klLRqAJ6GX9SjNVCpJdErrMK4WarsfWKlCsSwrrK8neLp+J7fErGC
         LuVN9rEDJkMpEYybNqd8i02Y7cIJdLTeb2oQNjW5chLxnBZ51aMiCJGPonirBukNTQd3
         oMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745420982; x=1746025782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdAQgJGh6L8DgG96ysAv4TN+nxAzuWJNdtJrdyEhb5w=;
        b=QchFVlHhdq330b9SL/ka2KvqkvLyKnvww4mElvJ306cXZifmC7kBTOVdmmP6ddV4e/
         JR2SFSqVSi8MD/0MsesUVEsy1zqbOyZhOLDB8ijSlaqVDF6VQlFh/5qBkMr3wH8v2i7c
         Q6mY8RbbeQ0AK+G430M8DhC3NfM0Uf6XVNHt/eeReGLe5cBTioL+FuWUuBP1KXL+h3tA
         LSMi/iVaGp4l8yBtmLnysBawYOQGhgHBKaPTinNt5A5tI3I5zysepc6KDuwgVVUJjaGM
         BBvdb/2KZU/hPwvI/ItFBCwWtuEIc2KLy3hz4nIYGWa+n/XLPNtXpyKBcnoL7iskg9pl
         t5WQ==
X-Gm-Message-State: AOJu0YwxnvZJB+6VuwC+aZnl7nPR1vb+ojiDOYfySC/xrxbJVlrL17rl
	EmGPoUcsKVrMThPM70kRC7nNE/LqSn4wH85/VjeUjySHO6dFXbGpgBqupF1h79cBzwr4LG2h09h
	M
X-Gm-Gg: ASbGncsesbHr0LcPFL0E1k9G3HmiaqqmwQsI6dW2XtFm2CDlW9thry7T231mkCD7ffV
	utpznrnzdA1QemUoMBIsrCUPNnXePflwctxF+NMeimj7IxKg5ezg8qZ+gbgMuS0GMVzSWMUYBFN
	NfEODC3BcJDbCR5vXC3bMeUJ8F7Dbz6sx2dHqoEAnpbhMbDvCK6PwdXZVb+ofEg4QGhJsWNs0q8
	0RH9pR+R95OmbTzpxLN9S9npQz0FjTZiAmRSzUI4KEElAiAYmj0gtPx8kocjjIvUhGxpaU4fz3j
	Bdmm5LmYwtj5ae9K16bUhuka0vR1Nz5nmt68Kg==
X-Google-Smtp-Source: AGHT+IGlZtvxNSpPdsWriPMWYaPAeUPfEicjUI6pUMer+e+wMtDnJA4Md29xnVdp9dlEYVGOKotGWw==
X-Received: by 2002:a05:622a:11c7:b0:476:ae71:eabe with SMTP id d75a77b69052e-47aec4bd58emr396743931cf.50.1745420981538;
        Wed, 23 Apr 2025 08:09:41 -0700 (PDT)
Received: from andromeda.lan ([74.15.9.135])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9cfa3f1sm68953601cf.79.2025.04.23.08.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 08:09:41 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>,
	sanchayan@asymptotic.io
Subject: [PATCH BlueZ v2 2/3] profiles/audio: asha: Only expose device after we have attributes
Date: Wed, 23 Apr 2025 11:07:41 -0400
Message-ID: <20250423150742.319463-3-arun@asymptotic.io>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423150742.319463-1-arun@asymptotic.io>
References: <20250423150742.319463-1-arun@asymptotic.io>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's get the PSM and read-only properties before we expose the device
and transport. While we're at it, rename "probe" as "attach" for
consistency.
---
 profiles/audio/asha.c |  6 +++---
 src/shared/asha.c     | 31 +++++++++++++++++++++++++++++--
 src/shared/asha.h     |  9 +++++++--
 3 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/profiles/audio/asha.c b/profiles/audio/asha.c
index 10115b92d..9e32822c9 100644
--- a/profiles/audio/asha.c
+++ b/profiles/audio/asha.c
@@ -458,10 +458,10 @@ static int asha_source_accept(struct btd_service *service)
 		return -1;
 	}
 
-	if (!bt_asha_probe(asha_dev->asha, db, client))
+	if (!bt_asha_attach(asha_dev->asha, db, client,
+		(bt_asha_attach_cb_t) asha_source_endpoint_register, asha_dev)) {
 		return -1;
-
-	asha_source_endpoint_register(asha_dev);
+	}
 
 	btd_service_connecting_complete(service, 0);
 
diff --git a/src/shared/asha.c b/src/shared/asha.c
index fa6b489d6..d99ae4d8b 100644
--- a/src/shared/asha.c
+++ b/src/shared/asha.c
@@ -177,6 +177,10 @@ void bt_asha_reset(struct bt_asha *asha)
 	bt_asha_state_reset(asha);
 
 	asha->psm = 0;
+	memset(asha->hisyncid, 0, sizeof(asha->hisyncid));
+
+	asha->attach_cb = NULL;
+	asha->attach_cb_data = NULL;
 
 	update_asha_set(asha, false);
 }
@@ -335,6 +339,21 @@ static bool uuid_cmp(const char *uuid1, const bt_uuid_t *uuid2)
 	return bt_uuid_cmp(&lhs, uuid2) == 0;
 }
 
+static void check_probe_done(struct bt_asha *asha)
+{
+	uint8_t zeroes[8] = { 0, };
+
+	/* Once we have ROPs & PSM, we should be good to go */
+	if (asha->psm == 0 || memcmp(asha->hisyncid, zeroes, sizeof(zeroes) == 0))
+		return;
+
+	if (asha->attach_cb) {
+		asha->attach_cb(asha->attach_cb_data);
+		asha->attach_cb = NULL;
+		asha->attach_cb_data = NULL;
+	}
+}
+
 static void read_psm(bool success,
 			uint8_t att_ecode,
 			const uint8_t *value,
@@ -356,6 +375,8 @@ static void read_psm(bool success,
 	asha->psm = get_le16(value);
 
 	DBG("Got PSM: %u", asha->psm);
+
+	check_probe_done(asha);
 }
 
 static void read_rops(bool success,
@@ -400,6 +421,8 @@ static void read_rops(bool success,
 			asha->render_delay, asha->codec_ids);
 
 	update_asha_set(asha, true);
+
+	check_probe_done(asha);
 }
 
 static void audio_status_register(uint16_t att_ecode, void *user_data)
@@ -501,14 +524,18 @@ static void foreach_asha_service(struct gatt_db_attribute *attr,
 	gatt_db_service_foreach_char(asha->attr, handle_characteristic, asha);
 }
 
-bool bt_asha_probe(struct bt_asha *asha, struct gatt_db *db,
-						struct bt_gatt_client *client)
+bool bt_asha_attach(struct bt_asha *asha, struct gatt_db *db,
+		struct bt_gatt_client *client, bt_asha_attach_cb_t attach_cb,
+							void *cb_user_data)
 {
 	bt_uuid_t asha_uuid;
 
 	asha->db = gatt_db_ref(db);
 	asha->client = bt_gatt_client_clone(client);
 
+	asha->attach_cb = attach_cb;
+	asha->attach_cb_data = cb_user_data;
+
 	bt_uuid16_create(&asha_uuid, ASHA_SERVICE);
 	gatt_db_foreach_service(db, &asha_uuid, foreach_asha_service, asha);
 
diff --git a/src/shared/asha.h b/src/shared/asha.h
index e87a9fc3f..39e55f22e 100644
--- a/src/shared/asha.h
+++ b/src/shared/asha.h
@@ -23,6 +23,7 @@ enum bt_asha_state_t {
 };
 
 typedef void (*bt_asha_cb_t)(int status, void *data);
+typedef void (*bt_asha_attach_cb_t)(void *data);
 
 struct bt_asha {
 	struct bt_gatt_client *client;
@@ -45,6 +46,9 @@ struct bt_asha {
 	enum bt_asha_state_t state;
 	bt_asha_cb_t cb;
 	void *cb_user_data;
+
+	bt_asha_attach_cb_t attach_cb;
+	void *attach_cb_data;
 };
 
 struct bt_asha_set {
@@ -65,5 +69,6 @@ unsigned int bt_asha_stop(struct bt_asha *asha, bt_asha_cb_t cb,
 
 bool bt_asha_set_volume(struct bt_asha *asha, int8_t volume);
 
-bool bt_asha_probe(struct bt_asha *asha, struct gatt_db *db,
-						struct bt_gatt_client *client);
+bool bt_asha_attach(struct bt_asha *asha, struct gatt_db *db,
+		struct bt_gatt_client *client, bt_asha_attach_cb_t probe_cb,
+							void *cb_user_data);
-- 
2.49.0

