Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE63C135A5F
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 11:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712142367; cv=none; b=IkklL541AJI68bWEGpxiLiaa5bXVqMREuvT5zNBf9cWdB51J/qsfq3ANVaUjQFMNDlWUGUsqLmkxnAiIZmkTSoqWkDaepZ6mdNsMjJq7pfjZkLxyt/nQYZMcNgOohu6CxAwAdXdLWRc6n+hEl297KDF0ZxYMZLferY25pwe75Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712142367; c=relaxed/simple;
	bh=nRe/wETT3GoccC8/NHzrzA4Fr0YQHwGN0wBDbKaeT4I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C0q1O6liumTw3oEP5E8+MSTJxBCafT3X3e6o+f8fZQc9pBENH1IMlvJFrdM6UVsgWDBz4sRLapaslGHC3NfuIfptvh7RDjNYmJkoSgmdk74MapUe4UAxq6nqlvx7AisAEFc+rvKChw98wyWtzeyUxg4AoIkVwfOELSM+adqq1Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--howardchung.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rX5IXSA0; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--howardchung.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rX5IXSA0"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2a240c417d9so2271154a91.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Apr 2024 04:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712142365; x=1712747165; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=glw929onVloHIzkV4CzTiQn/5/sv/I7vwWdsFQcS7ks=;
        b=rX5IXSA0hzXhoUct6ZXRnGPQEWutOaUxgiJlLJmsJY87LsWCOgbljcI7IQiaQzCUoR
         pIRfpcoDgcyXdcNZZB0RR/qD+zIXH0I32JT6omIw0bXS0BWKAFO6VjHxVlobGWBQGJn3
         8Z0ekBl2y31tLyt1LMTH8BLUJgetD3jW2VgK6OgG3J4E8T1dMYb51d9BG3pdGEPqSRTp
         58qEpTnBpxlT1UCWWFYW73jIuIILRMdJmeSOrOIxg8JEWBDPrTmT7zqLM4GxlRcGpROU
         rX9qPbtvo193pPL7H1w4KpOwek+87nhUxPSKQOgI9DVAdUHEqGj14fTj+QJbRN37dOnd
         cm0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712142365; x=1712747165;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=glw929onVloHIzkV4CzTiQn/5/sv/I7vwWdsFQcS7ks=;
        b=ZetSimY6a1NpkunZEacCDZPEUu8wiObO1g+1edpCbPdUVaZgB/tjPsJrdvpUBrnjub
         rfFlWB0O4bJYwtJQQRsr82M1qHrhZWlkUvCEmVsai1IpeERX9AdjtIMsPhyrUkN9QBR8
         YjcO2CcTjm5jeQ5YPxbDCmSN9pYLrT4eCj4/66qO2pcroA56UZHGBr/2azmzpZWrZRGJ
         /SXCqqEFqORKti6uk0J1qRyKbSh3qFzVQ74b31alUe6pin8LGf79OnQUnL6Q6VXCcUlj
         XZO92nzIbEtJj3km+/5Vilhf3F51CvMz6SOJ2c8BvCNcTc1vLeUcCgmQnF04iOpotII3
         oCrg==
X-Gm-Message-State: AOJu0Yx3eQ7iJF+Bwg1kuAEpLF9QGxGMsgdVUUfYOQodahNRiXWs+g2+
	JuO5YknIHmjXoYCZ2Xr4XzLkzgzYaQpdIjuUiImG9zGTAHY+EUC4Lir+ZBMe1nx4bE/QPq892v3
	nw4RJvPs4KVONQlBAXH1RYoZhyZxw9o5A6CmPLYInAELFI9uHoJGMjuEbgLFFKQae96F1+gcktv
	zC+xLR6N3R+B46rQNlhXdwv/fD/kDD451/zdf3mXpvBbV2w1Ny/AqhVsgvROfOTe7f9rUIEZY=
X-Google-Smtp-Source: AGHT+IHeZaUixcjdUU+ABUEhjgeirmfEMJFNfknmACMhmjXyC0KPJ4PVUsCRbO9xKCGKvA8AN+0UYDhbz4fxyt+yGg==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:17:a99c:36f2:1a05:fa42])
 (user=howardchung job=sendgmr) by 2002:a17:90a:e54d:b0:2a2:b250:9817 with
 SMTP id ei13-20020a17090ae54d00b002a2b2509817mr1038pjb.8.1712142364621; Wed,
 03 Apr 2024 04:06:04 -0700 (PDT)
Date: Wed,  3 Apr 2024 19:05:12 +0800
In-Reply-To: <20240403110549.75516-1-howardchung@google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240403110549.75516-1-howardchung@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240403110549.75516-2-howardchung@google.com>
Subject: [Bluez PATCH 2/2] shared/gatt: Add descriptor insert function
From: Howard Chung <howardchung@google.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>
Cc: CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>, 
	Howard Chung <howardchung@google.com>, Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"

service->attributes has an assumption that it should look like:
|char_uuid|char_1|desc_1_1|desc_1_2|char_uuid|char_2|desc_2_1|char_uuid|...
where desc_x_y means a descriptor of char_x.

In monitor, an attribute is inserted as soon as it is found. It is not
guranteed that all the descriptors of a characteristic would be found
before another characteristic is found.

This adds a function to insert the descriptor with the given handle to
an appropriate place in its service attribute list and make monitor to
use this function when a descripter is found.

Reviewed-by: Archie Pusaka <apusaka@chromium.org>
---

 monitor/att.c        |  2 +-
 src/shared/gatt-db.c | 66 ++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-db.h |  9 ++++++
 3 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/monitor/att.c b/monitor/att.c
index ddeb54d9e..503099745 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -4153,7 +4153,7 @@ static struct gatt_db_attribute *insert_desc(const struct l2cap_frame *frame,
 	if (!db)
 		return NULL;
 
-	return gatt_db_append_descriptor(db, handle, uuid, 0, NULL, NULL, NULL);
+	return gatt_db_insert_descriptor(db, handle, uuid, 0, NULL, NULL, NULL);
 }
 
 static void att_find_info_rsp_16(const struct l2cap_frame *frame)
diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 39bba9b54..f08c5afaa 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -1002,6 +1002,72 @@ service_append_descriptor(struct gatt_db_service *service,
 	return service->attributes[i];
 }
 
+struct gatt_db_attribute *
+gatt_db_insert_descriptor(struct gatt_db *db,
+					uint16_t handle,
+					const bt_uuid_t *uuid,
+					uint32_t permissions,
+					gatt_db_read_t read_func,
+					gatt_db_write_t write_func,
+					void *user_data)
+{
+	struct gatt_db_attribute *attrib, *iter_attr, *char_attr = NULL;
+	struct gatt_db_service *service;
+	int i, j, num_index, char_index;
+
+	attrib = gatt_db_get_service(db, handle);
+	if (!attrib)
+		return NULL;
+
+	service = attrib->service;
+	num_index = get_attribute_index(service, 0);
+	if (!num_index)
+		return NULL;
+
+	// Find the characteristic the descriptor belongs to.
+	for (i = 0; i < num_index; i++) {
+		iter_attr = service->attributes[i];
+		if (bt_uuid_cmp(&characteristic_uuid, &iter_attr->uuid))
+			continue;
+
+		if (iter_attr->handle > handle)
+			continue;
+
+		// Find the characteristic with the largest handle among those
+		// with handles less than the descriptor's handle.
+		if (!char_attr || iter_attr->handle > char_attr->handle) {
+			char_attr = iter_attr;
+			char_index = i;
+		}
+	}
+
+	// There is no characteristic contain this descriptor. Something went
+	// wrong
+	if (!char_attr)
+		return NULL;
+
+	// Find the end of this characteristic
+	for (i = char_index + 1; i < num_index; i++) {
+		iter_attr = service->attributes[i];
+
+		if (!bt_uuid_cmp(&characteristic_uuid, &iter_attr->uuid) ||
+			!bt_uuid_cmp(&included_service_uuid, &iter_attr->uuid))
+			break;
+	}
+
+	// Move all of the attributes after the end of this characteristic to
+	// its next index.
+	for (j = num_index; j > i; j--)
+		service->attributes[j] = service->attributes[j - 1];
+
+	service->attributes[i] = new_attribute(service, handle, uuid, NULL, 0);
+
+	set_attribute_data(service->attributes[i], read_func, write_func,
+							permissions, user_data);
+
+	return service->attributes[i];
+}
+
 struct gatt_db_attribute *
 gatt_db_append_descriptor(struct gatt_db *db,
 					uint16_t handle,
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index ec0eccdfc..4c4e88d87 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -80,6 +80,15 @@ gatt_db_append_characteristic(struct gatt_db *db,
 					gatt_db_write_t write_func,
 					void *user_data);
 
+struct gatt_db_attribute *
+gatt_db_insert_descriptor(struct gatt_db *db,
+					uint16_t handle,
+					const bt_uuid_t *uuid,
+					uint32_t permissions,
+					gatt_db_read_t read_func,
+					gatt_db_write_t write_func,
+					void *user_data);
+
 struct gatt_db_attribute *
 gatt_db_append_descriptor(struct gatt_db *db,
 					uint16_t handle,
-- 
2.44.0.478.gd926399ef9-goog

