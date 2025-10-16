Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB842E03F3
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 21:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760648447; cv=none; b=osiPnGptYY9zTIv+qojCLG97wmjMvtKHAHaOHlyY4iPpPmaDokpN+chjm5s/Jc8R8KlMtt5QjFuh/dj4hVYSHirk9lsdvKK5LM9YjQDMh7W1jnDt7GNFjsvisgaC9mG/USBrGlC+XZEq07qEyysTaueTJ7MDteV3dqhPhsCphQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760648447; c=relaxed/simple;
	bh=7trz3xUvtb/Ve8icmn1LkB09Tf0pwVltuoyViYUMIp0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hseRibylh6mWtrnpFM8MPiKejN0QPTdkptytu/Ps6rhPpZp0MBjOzHipNj94jxpRp9G+9QiwYQnaEt9IhU2aD5SoKzUymNKh3qRAlxk2yjWNxD+FZlUark6NvJ85kqJplfwrX2u+fvxerGlMz3lehncaT7h4Jh+GjaNVC4bExpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5k3Qqub; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5k3Qqub"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-54a880e2858so776157e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 14:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760648444; x=1761253244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=osxLypg02uEY3loO6nURiV153bLVW4LM2c+mKbTzvFU=;
        b=P5k3QqubpxRw+XEEpwlzIDXP8QIfHZ1Es1rC1mFaqqmDZvgf8LDiTUWBM2NBV0bfX0
         PIspE/BWwWONq7a8muj1Jweugl/pKfqNQvzckmpYgZYvT5YGmOtzjmcIRHR8xEFcGI6P
         /+Fi9xo8TwVl4li8vXfbma7Wiu8h0DT4KmjPO4619hJfTJAoyIIPnec0M5CXYKlYdDT9
         btyYxuUTNhy7P6YFL6gn88VZ/OIY2tnyK/h1hqRUE4WX6HgwqefqMJwbseMDnpyar51G
         0IA4QawSsBHMjyRGlFw5AFpFk2EbLsCvADIwBQXR9w8y6t5eD+t8VG8cIgZMZT/Svny4
         atLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760648444; x=1761253244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=osxLypg02uEY3loO6nURiV153bLVW4LM2c+mKbTzvFU=;
        b=I6ZbtmlUDO8oaWxZNbZLYF65RjfD0L0bBQzWRfp+04fqEit2QfjJRSf/TrF4vfXuI6
         03GBjMRrQba/MioKb9U51SYpbYnkLRR4z6SZIUniANMMo+rlnRU9LIxdW9LHzQdePsvE
         YJ2BUZOdukmw6lhz8XxWiQ3Nok8TDkYUYxm2fMQoZ839W1BMjyb8jToucM/WXhIrhb5f
         ZwP/jwTnOS08BOZQojv74vbsGhmKtDoI87sqirNJnE0iXgBYKMAY8LM43TqzM0Mu+qzx
         6Pj20qehB8QXLW9uWi6VSbFK92IfvCHFOrVBpUs5WLVgj9PmeNecOKpjyaGnEU5oeSBT
         efHg==
X-Gm-Message-State: AOJu0Ywvyp8iw9dL0Fzd4wnJrEUqViNBIW9KWqOHfd/wdIgz424JXaKS
	Fv2xlfsfFXcgzB7DJj9RQVuv8n9OdHMtqzmVE4Ce1Csql3NEJujeZnHAu+EieLK2
X-Gm-Gg: ASbGncsEJ9DIv33LS+GrncMR2LBWc5RAmpWq7jf59CHQfoDehF8I8i1t4vgh9ccJfCH
	Btc/RVqKhvnGYISwYLFLOXAHAxE/n28Zd+PaQHCGKOg6FCmUCfg1Kj7G00yTRv+ir/nlTAn5Ddy
	ShUd1+caib4oNXcqP0LAxuEDrxWY1rmAfcdoIvDjcRd9u89tf+genJiQ5QyJZscZxf8YHv7cNgp
	svJ1T2JxcwTRIGAfFuEqQL70VjfF+4xLGH4h8piBhsebV1oPaFP4yr1yZWuRzkThkTiapvJvw+L
	M9Vzk8mrBTGf1RuPkeAC8qrIILk9c/I+iv1j8VkshdRBBp3uTew3mCw/HpEHtQU+uFdVOuOyDsi
	tiO7iKhnUVH98/4XurfqzUSQbqc0AaCDCwfqPakYE/b+3UD10eQRxCjVRHSw0Wr8ijwO31QJeNa
	fYJX0P+i3XPYsgAA==
X-Google-Smtp-Source: AGHT+IF47KxKqI6oWbxJo8OYGlaoNG1/kqgqP8FQdMERsJpEIHMpxZ8cVRWjgLxCaQ9fBxIa2ZqowA==
X-Received: by 2002:a05:6122:221c:b0:54b:bf4d:558b with SMTP id 71dfb90a1353d-5564ef30b1bmr844347e0c.10.1760648444177;
        Thu, 16 Oct 2025 14:00:44 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d80d9bf0sm6590304e0c.18.2025.10.16.14.00.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 14:00:42 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 08/13] gatt-database: Add btd_gatt_database_get and btd_gatt_database_get_adapter
Date: Thu, 16 Oct 2025 17:00:14 -0400
Message-ID: <20251016210019.191878-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016210019.191878-1-luiz.dentz@gmail.com>
References: <20251016210019.191878-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds btd_gatt_database_get and btd_gatt_database_get_adapter
that makes it possible to resolve the btd_gatt_database and btd_adapter
respectively when only the gatt_db is available.
---
 src/gatt-database.c | 35 +++++++++++++++++++++++++++++++++++
 src/gatt-database.h |  4 ++++
 2 files changed, 39 insertions(+)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index eea3f600a8b0..ff5fa3bcc8b2 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -209,6 +209,8 @@ struct device_info {
 	uint8_t bdaddr_type;
 };
 
+static struct queue *dbs = NULL;
+
 static void ccc_cb_free(void *data)
 {
 	struct ccc_cb_data *ccc_cb = data;
@@ -4123,6 +4125,11 @@ bredr:
 	if (!database->db_id)
 		goto fail;
 
+	if (!dbs)
+		dbs = queue_new();
+
+	queue_push_tail(dbs, database);
+
 	return database;
 
 fail:
@@ -4143,6 +4150,34 @@ void btd_gatt_database_destroy(struct btd_gatt_database *database)
 	gatt_database_free(database);
 }
 
+static bool match_db(const void *data, const void *user_data)
+{
+	const struct btd_gatt_database *database = data;
+	const struct gatt_db *db = user_data;
+
+	return database->db == db;
+}
+
+struct btd_gatt_database *btd_gatt_database_get(struct gatt_db *db)
+{
+	struct btd_gatt_database *database;
+
+	database = queue_find(dbs, match_db, db);
+	if (!database)
+		return NULL;
+
+	return database;
+}
+
+struct btd_adapter *
+btd_gatt_database_get_adapter(struct btd_gatt_database *database)
+{
+	if (!database)
+		return NULL;
+
+	return database->adapter;
+}
+
 struct gatt_db *btd_gatt_database_get_db(struct btd_gatt_database *database)
 {
 	if (!database)
diff --git a/src/gatt-database.h b/src/gatt-database.h
index 30ae68e7e9a0..998e3c452b16 100644
--- a/src/gatt-database.h
+++ b/src/gatt-database.h
@@ -13,7 +13,11 @@ struct btd_gatt_database;
 struct btd_gatt_database *btd_gatt_database_new(struct btd_adapter *adapter);
 void btd_gatt_database_destroy(struct btd_gatt_database *database);
 
+struct btd_gatt_database *btd_gatt_database_get(struct gatt_db *db);
 struct gatt_db *btd_gatt_database_get_db(struct btd_gatt_database *database);
+struct btd_adapter *
+btd_gatt_database_get_adapter(struct btd_gatt_database *database);
+
 void btd_gatt_database_att_disconnected(struct btd_gatt_database *database,
 						struct btd_device *device);
 void btd_gatt_database_server_connected(struct btd_gatt_database *database,
-- 
2.51.0

