Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408DC26CE0A
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Dec 2025 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765018906; cv=pass; b=ZPihp7+hke8jrg6LDGIBKPKmbdDyIT2fRc7PC6nclrKVUqcoYW6b7JBXUA4811Uu1y8jtGlSOpDDQeMTKfGim4mSx+N9R4rdRU1kEpZeRxl4VkPsqLQlJ8smdb2gmFDTGhkqlkhq7/+l91YsSbW/gkDJFC32wHbL8aNzcPliToo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765018906; c=relaxed/simple;
	bh=8kDDpXsFQXLd+IvWOE+oRimFHrPdGMtMcD4R64rwcLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=er0OWbmpztuJXJsDtSG+edxJnFwjm+31yZt4yjVVlRj2ahFd/g9YD4eEmrw9gN5M2wljINcdn+0Q7MpE4odlucK4uQmvGniKNgtBs+DBVwA9WDBCmcYdrJqei576YYiG0ERCeEK3WzS6Uff+gABwj7qhXNCcY1z5ZChf5O9ueNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=gV7SrLe2; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="gV7SrLe2"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dNlg634Bgz105L;
	Sat,  6 Dec 2025 13:01:38 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765018899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I2iZJ0fCvUjJ/TXjcWp9VxHkjcLe1goda/Po4srIpr0=;
	b=gV7SrLe2JljXLs0NslreTwkPSLTaOn11we+fPG0H684Udj81MkTPhHRMr9xMLNyYwwgfCX
	42Hq4GUU+ZddoknzdZhMMQfG5vmghMxDh3OZQh1cXYhGJKe7qL6WMerlbEBRbX0HSSDiy7
	9pMCd69NKC+3PIp/AjKF/dVEFxKosx4=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765018899;
	b=tdmctBiAQ+j4tq9Tzd1s512C1TluqPINgwb7Zq2Gog2ZFNaR1CyLpmJd944/9aPEtDmPVi
	7ystbcCleJAkrCOhcCoyKHcbvwhP6o/86N/G2xpkp5nVlc69q61/bZADzDvwQsJaLetD0g
	reVLmLxUNGH5GdM8OwN2bRyqIjaam9c=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765018899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I2iZJ0fCvUjJ/TXjcWp9VxHkjcLe1goda/Po4srIpr0=;
	b=RYxiu0DPIbOaIFzCrGb6DsYkwDKnE9ik9Vl+JF/d+j2Vop4HiEII61ey6CtKPBEcNePNHx
	WlZtoitFNERhplNT/M+OPz7BBYd2HEJ/QgiL33fwuu/YCbh8JViEQaxxCQnL1+9FY1hN7d
	/PfgPrvFUmh9Wn8+TCC4i3KwzAstVwg=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 06/11] shared/gmap: deactivate service or remove feature chrc if role removed
Date: Sat,  6 Dec 2025 13:01:22 +0200
Message-ID: <85a61bd53ede5c07cd07d616506218e9cb5099e3.1765018766.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765018766.git.pav@iki.fi>
References: <cover.1765018766.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When role is removed, the associated feature chrc must be removed too as
it's then Excluded in spec.  If all roles are removed, deactivate the
service instead to avoid consuming ATT handles.

Reserve exactly the right number of handles for the service.

Also add null checks to the feature set routines for convenience.
---
 src/shared/gmap.c | 57 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 14 deletions(-)

diff --git a/src/shared/gmap.c b/src/shared/gmap.c
index f571f3270..291135db3 100644
--- a/src/shared/gmap.c
+++ b/src/shared/gmap.c
@@ -345,10 +345,27 @@ static void gmap_update_chrc(struct bt_gmap *gmap)
 	}
 }
 
+static void gmap_init_service(struct bt_gmas_db *db)
+{
+	bt_uuid_t uuid;
+
+	if (db->service) {
+		gatt_db_remove_service(db->db, db->service);
+		db->service = NULL;
+		db->role.attr = NULL;
+		db->ugg.attr = NULL;
+		db->ugt.attr = NULL;
+		db->bgs.attr = NULL;
+		db->bgr.attr = NULL;
+	}
+
+	bt_uuid16_create(&uuid, GMAS_UUID);
+	db->service = gatt_db_add_service(db->db, &uuid, true, 5*2 + 1);
+}
+
 struct bt_gmap *bt_gmap_add_db(struct gatt_db *db)
 {
 	struct bt_gmap *gmap;
-	bt_uuid_t uuid;
 
 	if (!db || queue_find(instances, match_db, db))
 		return NULL;
@@ -356,8 +373,7 @@ struct bt_gmap *bt_gmap_add_db(struct gatt_db *db)
 	gmap = new0(struct bt_gmap, 1);
 	gmap->db.db = gatt_db_ref(db);
 
-	bt_uuid16_create(&uuid, GMAS_UUID);
-	gmap->db.service = gatt_db_add_service(db, &uuid, true, 5*3);
+	gmap_init_service(&gmap->db);
 
 	if (!instances)
 		instances = queue_new();
@@ -368,23 +384,41 @@ struct bt_gmap *bt_gmap_add_db(struct gatt_db *db)
 
 void bt_gmap_set_role(struct bt_gmap *gmap, uint8_t role)
 {
-	if (gmap->client)
+	if (!gmap || gmap->client)
 		return;
 
-	gmap->db.role.value = role & BT_GMAP_ROLE_MASK;
+	role &= BT_GMAP_ROLE_MASK;
+	if (role == gmap->db.role.value)
+		return;
+
+	DBG(gmap, "set role 0x%02x", role);
+
+	gmap->db.role.value = role;
+
+	/* Removing role must remove feature chrc too; reset svc if needed */
+	if (role && ((!(role & BT_GMAP_ROLE_UGG) && gmap->db.ugg.attr) ||
+			(!(role & BT_GMAP_ROLE_UGT) && gmap->db.ugt.attr) ||
+			(!(role & BT_GMAP_ROLE_BGS) && gmap->db.bgs.attr) ||
+			(!(role & BT_GMAP_ROLE_BGR) && gmap->db.bgr.attr)))
+		gmap_init_service(&gmap->db);
 
 	gmap_update_chrc(gmap);
 
-	/* Expose values only when first set */
-	gatt_db_service_set_active(gmap->db.service, true);
+	/* Expose values only when first set and active */
+	gatt_db_service_set_active(gmap->db.service, role != 0);
 }
 
-
 void bt_gmap_set_features(struct bt_gmap *gmap, uint32_t features)
 {
-	if (gmap->client)
+	if (!gmap || gmap->client)
 		return;
 
+	features &= BT_GMAP_FEATURE_MASK;
+	if (features == bt_gmap_get_features(gmap))
+		return;
+
+	DBG(gmap, "set features 0x%08x", features);
+
 	gmap->db.ugg.value = (features & BT_GMAP_UGG_FEATURE_MASK)
 						>> BT_GMAP_UGG_FEATURE_SHIFT;
 	gmap->db.ugt.value = (features & BT_GMAP_UGT_FEATURE_MASK)
@@ -393,9 +427,4 @@ void bt_gmap_set_features(struct bt_gmap *gmap, uint32_t features)
 						>> BT_GMAP_BGS_FEATURE_SHIFT;
 	gmap->db.bgr.value = (features & BT_GMAP_BGR_FEATURE_MASK)
 						>> BT_GMAP_BGR_FEATURE_SHIFT;
-
-	gmap_update_chrc(gmap);
-
-	/* Expose values only when first set */
-	gatt_db_service_set_active(gmap->db.service, true);
 }
-- 
2.51.1

