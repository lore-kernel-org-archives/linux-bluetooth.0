Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EF312E1DE
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 17:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570715; cv=none; b=nrwOTgu7/B1UW3FFk71QMnejOaaN2RHNS5sfG05mJtIUCk0l+BBWsrGngEYGl513MGhhGAwe7hjqQPkEmAOktD7qMVpQ8UgvuyxCjClDYibgRDF/9bait9QwrvFHZjn4hF70DqzxJWun7BOFmD/f5+9Qo8WbAZbCCT40yw/YI0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570715; c=relaxed/simple;
	bh=kkcVm0s7sXwSpFq2JNi67OCg/OZxDC4zT0wLCc8FK/8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqd36epDegWbkSICJ6fBBk39Mk3lWfWsjfrKQsFJ75J6jLxnxNrFkKE1k1Xhod8I8z24utxatuVcwZoXp3h049v3GH2WSXczG8mpbUJ/meF7i4f0+IDAAz8FCdvADedmfhj27l8e+bC4+XGsbNIcpYt1LzIMqre+o/YHPVGHib0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgBp2ejm; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgBp2ejm"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6f0ef6bee72so4445213a34.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 10:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716570712; x=1717175512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+2G4fh1U2AG7YPtyqS0H3AcZdTJpV1UkkKB/mA255g=;
        b=hgBp2ejmUZ/khnn+dvnQkx0iT1J1OoU06iyOouwqiPH73z1xwq3n9K9KKRZiJLXQMV
         sa9/MwqfCn/55UfhYMAyeu20i/wIFZMWNLoLi9CFSnwM8MEu0qwP7WBJlXkz7yvMSOJG
         1uVhMtK6CekhdPICbNV0qvJx79iu/ac6WII3Ui3WP47nMLDcawOCV7nr7LTwLNO9F782
         0sJvEMHfkDymF9vQnIv1Wxlxbx+tPUO7CLYUX4LZxoYx94NQ0YstH84X7J1F+eaHOfVb
         tGpqXJzI4TUIiWOcJfkMspX1VZ1+5uaSCuHh+3Ad+nUtp30U2hTYBMlYCJu/kwUt8/Av
         2o7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716570712; x=1717175512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+2G4fh1U2AG7YPtyqS0H3AcZdTJpV1UkkKB/mA255g=;
        b=rfzhKBiSIeLUNYT3aKLdv7G8ZKzvpyrX6TR8tu06zvePshSx/g6svtG4J99jz/JAe4
         evd7/k4oYPnW6YR3HNycCxr3hgzUzIY//nkAJaY/mT7/nhjgZZS6DVs3gqTmPS7JzuKj
         rTvgzh0mt21S+gvk25Fd9D/+EwinxsBX1/iQBHHLyn2++khQNPcsX4FXdIOn1iCiB0vW
         mo3dmLN7UrV3p9TnmSQX4Xu6nrHhHhyCWjp3GfYn7rNxnEdk4aCYqg42SkleMNQ4Vi+x
         ht5XZjwCZuMudaOtqkPMM4UjKmRaXcgUPsUp5/yDy5YcwtOSIWJBAbPM8wtryq7GMmFK
         xMMA==
X-Gm-Message-State: AOJu0YwZ/Pi+0RQrEJOwNsJVGVCh3lgH2+UnsG0Fcay0wOGKaP944O4b
	1boVyZXZaIMbpy+IpHDUHa2tLytWvXgL/qIGa646V7LWBLwir+SpNKOLLw==
X-Google-Smtp-Source: AGHT+IH3ng4awri9zOLJN7ite4FDJMuuRtiT1HZXj3EpLfTzoQrKXKUbtKj/J47aJvY5ponKSh1aFQ==
X-Received: by 2002:a05:6870:e2d0:b0:234:581d:28e0 with SMTP id 586e51a60fabf-24ca11d1fabmr3250655fac.10.1716570711593;
        Fri, 24 May 2024 10:11:51 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-804cc1158ebsm256676241.29.2024.05.24.10.11.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 10:11:50 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/3] shared/gatt-db: Introduce gatt_db_clone
Date: Fri, 24 May 2024 13:11:46 -0400
Message-ID: <20240524171147.2733570-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524171147.2733570-1-luiz.dentz@gmail.com>
References: <20240524171147.2733570-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces gatt_db_clone which can be used to clonse/deep copy and
existing database.
---
 src/shared/gatt-db.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-db.h |  1 +
 2 files changed, 43 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 2c8e7d31eda1..28da9488fedf 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -260,6 +260,48 @@ struct gatt_db *gatt_db_new(void)
 	return gatt_db_ref(db);
 }
 
+static void service_clone(void *data, void *user_data)
+{
+	struct gatt_db_service *service = data;
+	struct gatt_db *db = user_data;
+	struct gatt_db_service *clone;
+	int i;
+
+	clone = new0(struct gatt_db_service, 1);
+	clone->db = db;
+	clone->active = service->active;
+	clone->num_handles = service->num_handles;
+	clone->attributes = new0(struct gatt_db_attribute *,
+					service->num_handles);
+
+	/* Clone attributes */
+	for (i = 0; i < service->num_handles; i++) {
+		struct gatt_db_attribute *attribute = service->attributes[i];
+
+		clone->attributes[i] = new_attribute(clone, attribute->handle,
+							&attribute->uuid,
+							NULL, 0);
+	}
+
+	queue_push_tail(db->services, clone);
+}
+
+struct gatt_db *gatt_db_clone(struct gatt_db *db)
+{
+	struct gatt_db *clone;
+
+	if (!db)
+		return NULL;
+
+	clone = gatt_db_new();
+	if (!clone)
+		return NULL;
+
+	queue_foreach(db->services, service_clone, clone);
+
+	return clone;
+}
+
 static void notify_destroy(void *data)
 {
 	struct notify *notify = data;
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index f7596e33529a..dc2daf7fc1ba 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -12,6 +12,7 @@ struct gatt_db;
 struct gatt_db_attribute;
 
 struct gatt_db *gatt_db_new(void);
+struct gatt_db *gatt_db_clone(struct gatt_db *db);
 
 struct gatt_db *gatt_db_ref(struct gatt_db *db);
 void gatt_db_unref(struct gatt_db *db);
-- 
2.45.1

