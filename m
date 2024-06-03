Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E22139D03
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Jun 2024 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717440799; cv=none; b=N1zEAyakgIe9PV1b11QyNbIWlhEUGBw4/Ry9U/i5TZhvldGefheu+N4POWUDo7k29aYjYcReic8TOcxSfntQ7rMf5X9JS1k4K4Quaj6z5HkaFsOYNWvqdrwVf6DIuLrFJOKG6WbrgB5190r63ZQ9jeX/3+L6nQ6+paZFZ7vNmog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717440799; c=relaxed/simple;
	bh=BlMQ+hgTxxVK9SiYt7DjZJcwexb5fb9X1HYYnXHRsa0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jsF2JSf78jKXh35oMug25sLxoX/CknZrA9oDRkBa3bdaLgx6HYNuE5zd9ElMMhERk74mLpHqIseN95ySXRHjU1d4aYXi3MDBApThSC6UYcPo6tIbFOswgRhbTW2HH1Blb3mZhHDTsuf4GM71aLgTxT/SYqXa9Jhd73j7CObXxAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ql7Jcqrz; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ql7Jcqrz"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4eaf67ad82dso1354490e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Jun 2024 11:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717440796; x=1718045596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Euucq6IfSWE4jNGcSdYkP4D/Lw58XowlpkSXFe+Qksw=;
        b=Ql7JcqrzaAtbc3PwjRqNKaxpK3ukw4fn7ZdWjeUWYg6lqwre95UAaSAfYsi5A7JeoF
         5SbKLGnhZphJ4GZieUyaVNalNUVuIk43LDRN4y8MssYeIRTTBSFQTdCYh56SZ7W34w0/
         7CbqqOfDj0tU6nl0A0Xmi1Z3sUtSdupr+rdbNMeLe+EErHIopp3Vrjqu2Tl2mrl9SscR
         QDLCJ5QgEU+ICXqQEWU/viBne7oLUo8l2qULxW9/xgsW0unkXgfCdyQT7JqhPTtD69VF
         tV/V5e+nGYYINNX28FHD7M0bAhC0lu3OfuY4uR3ekckz1s/3Qla640qn0fHj14RCUIte
         7xmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717440796; x=1718045596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Euucq6IfSWE4jNGcSdYkP4D/Lw58XowlpkSXFe+Qksw=;
        b=DMaDVG8FlmLn16TeScm8Zqby/yrJLTqW7wQdX2D46s6NgFqWWU6hvGV4ElNlv+xiWv
         rHgrj8emysdTJ8cP6ki6fn1uDPNGozgNKZsNfPTvJhmKSry/117cNraFtyibjkN7sM4F
         QFXAFVRvZ/5mIx4mARhzNqbDxME50RtWtG3llhp+U5quX0Uxmkjmr062yye/HVwLAFTq
         BWvfT2QJSUnJfrdL5gAx6xuTBgpS38eSKMg+gh6gZfZpHC5GX1ZUGLSYMWH48jfnbO33
         TG4/+dCOxw1IY4N38NfdacGJLP3lX9z76VS2OPKvQSIrK2UoZJv5ue6guXUw4bm3Qxzq
         SObw==
X-Gm-Message-State: AOJu0YxNPo3lCgbGixAY9gL0o6z24GO6+JeTbSlHgScTUCAYCVK/NfGv
	g3sMLt8WZ3XEqvre78MMQ5mBHpuSrN6SZxL6fbRNRebOZ05CmzgAOia6wQ==
X-Google-Smtp-Source: AGHT+IEZyYeLjouf704dFtN3nUdzC+78nwqNTc9ovbFF2d+sG4i0XJnUWfAntzLWui78TopmZtsTIw==
X-Received: by 2002:ac5:c888:0:b0:4c9:2540:8520 with SMTP id 71dfb90a1353d-4eb02d7c90amr8709989e0c.1.1717440796231;
        Mon, 03 Jun 2024 11:53:16 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4eafecbab81sm1231658e0c.0.2024.06.03.11.53.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 11:53:15 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/3] shared/gatt-db: Introduce gatt_db_clone
Date: Mon,  3 Jun 2024 14:53:11 -0400
Message-ID: <20240603185312.162337-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603185312.162337-1-luiz.dentz@gmail.com>
References: <20240603185312.162337-1-luiz.dentz@gmail.com>
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
 src/shared/gatt-db.c | 54 ++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-db.h |  1 +
 2 files changed, 55 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 2c8e7d31eda1..d8d21392fee6 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -260,6 +260,60 @@ struct gatt_db *gatt_db_new(void)
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
+		struct gatt_db_attribute *attr = service->attributes[i];
+
+		/* Only clone values for characteristics since that is
+		 * cacheable.
+		 */
+		if (bt_uuid_len(&attr->uuid) == 2 &&
+				attr->uuid.value.u16 == GATT_CHARAC_UUID)
+			clone->attributes[i] = new_attribute(clone,
+							attr->handle,
+							&attr->uuid,
+							attr->value,
+							attr->value_len);
+		else
+			clone->attributes[i] = new_attribute(clone,
+							attr->handle,
+							&attr->uuid,
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

