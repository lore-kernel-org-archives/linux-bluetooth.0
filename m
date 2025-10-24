Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90652F7AC4
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 20:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338464; cv=none; b=E0ymuVTfvJMFSOLdXenZCQcaVekGIXeP9XVaL6CokWvbwoIYdvFfpJl2kEsVHbX8wBjYlrbQalMMJxZdvwsnLzN10gnluezu8IDg8vIZnoqWCMJGJvT7z3445rDbmhHhGmlAr3QwJdMT41EAxLOgfUmv4YuijamlPObz2qGBJl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338464; c=relaxed/simple;
	bh=7trz3xUvtb/Ve8icmn1LkB09Tf0pwVltuoyViYUMIp0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHWMt+WGmYxetcZWIS+U5hDpEtXCKC5Hd8LMlvKVBvCLFFS7brU7pj3ttdFCsmAiKFWDsNanbofE8L18HGusuiOjPi0OL6HsjLSDFK5Rp3SrsLzzoIKjfaMhPKCM/xlGBPmtDRAn0ZpVl6wfwct00OPRuuWfqL5BUe85aRMWezY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3Uzs0qN; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3Uzs0qN"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-934a3f11a44so2018433241.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 13:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761338460; x=1761943260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=osxLypg02uEY3loO6nURiV153bLVW4LM2c+mKbTzvFU=;
        b=f3Uzs0qNpBiNF8i1H/PC6H5SP0w3MRb4xqFJT0iP6Q/AcFEFhYtht5KxShag3i75KO
         9DWrzSplRnbJZ60X3ksfzsRQ8OOIXclbubWXlMKAFqV3ShfgBBU3BCEdWi1JawNmfU6a
         4IQWEaQSwXeTxO/ngRNVH1MyD4LKUsVgX/9/chKHC5HqyofAOE9JXVl15HBtoJHBLxIL
         IG0FlU0/ey0wVEzm5Oo2G7DzEHrkAqtEcO3J6zerT83JeWGUyiTpoHaBhNncRelqa8ZL
         XxDur5jUwG33JGK2ppvJN5w21+wMzF0hG6KG8fmFvkw0CBGywRvPfKwBElCJEIqGKuV6
         K9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761338460; x=1761943260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=osxLypg02uEY3loO6nURiV153bLVW4LM2c+mKbTzvFU=;
        b=cO65Xmzjon+pfvxwTXHhDawvp4OoEsLZlAfWjznjEjy/hdy1NNYvZ5U16DKMEUGifO
         cMZo9iiYrPTXL7H4OOL3D4vOpge8ueJsTvhtZZ/vdk6krLDANb/mzz+Lq4X9dHS6NrJm
         ILs7ho/u+oBWzhEZKIPrbFChl7gk770eyzowRfWJsicWdOSLMC9hS9X0PUJBcpvhYl1t
         iqQs9w77FVQwDO7wJqDRyCtAuRcqYz+MgIO19J4nxxli06tsuspHEa8K/Oeo4UPezLFO
         rXmIIrt/2soIwNqXbu+V5Vg39sg0eKuaE0gC0VEp/DIL9LISbC6L3908hUo2ww5iQ/8m
         4jAA==
X-Gm-Message-State: AOJu0YzPFAGtLzY1HX6wQoTU9wl2ffyjFsqGEx/X0vJ/H9fysXFujZo5
	s7ZZ86vTgqlqGmWKf0IkfODJ6LDOpm29f5CHq/V3Ra9d05eG+E7tNbPBFOiTEw==
X-Gm-Gg: ASbGnctFeZzJJZV3u0wAo9V+zt/x97D3OoX4u3Jtpqm63UNHcd/2V63UUoaaHjzn3A+
	z8aV7qK/c8cjfSR4C2H5WXFndZ2QkeQcGDrkyXnAj6EPhNMq5aebAHQDuqlsFc+AcHucV0x9AIS
	VhL3sG9Pq8v0sYYqFBa/cPg+tpXYXFyvOgUntdyBdgwKE4bt1Wht0n03U5l+iZTJ/aThTKu09jU
	ukja8Iw+OAiERFs/t4NEuwewrHhipNxU9St9hoxJeu9TRc508mbhOs5GAETDW3WgozWZOGkhL3I
	R+UUDr/Ik/iFQkGxlf8SE7hUdkPKtY0EBvlTDEhmG5+j2PQrZ0w0lUUnrbbMMw8i+MZk79ClEKp
	CHGkx7Bh2IYV9pjlNFrnABSbM82R+EFOmRbQOgXg36eL4XWUrW97no5UxI+WEPsiD8GAuWfUYIW
	J9t08=
X-Google-Smtp-Source: AGHT+IHmzJ4PirnLHHxz1nFShe6HZTeci46oEWMyEUBVWFf6ksO5xE/TZ9oZtMse20BsJNThLq3c0A==
X-Received: by 2002:a05:6122:20a2:b0:54a:9fc0:40ab with SMTP id 71dfb90a1353d-5564ee2f377mr9591020e0c.2.1761338460535;
        Fri, 24 Oct 2025 13:41:00 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557ddb2f98asm73501e0c.10.2025.10.24.13.40.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 13:40:59 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 07/12] gatt-database: Add btd_gatt_database_get and btd_gatt_database_get_adapter
Date: Fri, 24 Oct 2025 16:40:34 -0400
Message-ID: <20251024204039.693918-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024204039.693918-1-luiz.dentz@gmail.com>
References: <20251024204039.693918-1-luiz.dentz@gmail.com>
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

