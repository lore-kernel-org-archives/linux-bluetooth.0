Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847B94C66
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716220034; cv=none; b=ZXOvCUAIBlVLCZZT0jIkcQHBMVbCuKX3bAVo1DAkLiEqZb3+YtXUPOuezSMMgvf6E188RvBJAib5nA5h9wNHkU6Bqg1pURWHOAFBvIH7gx/+hzBZ9QN7Sbr1v1E1fJprjk/j7B3VqiCRq46WtfacKeAoz8dTjKXOTZLGIAnlu94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716220034; c=relaxed/simple;
	bh=nTKYvyp/3AvcUvoZ4DlZYgKBnIJIqV5KKCNvNsfntFQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L5nnujk1galHKu4PcPEuLw9lfqwsMq1XPSJO+aji9NOaaxrCMCG8CB1t4jdTRjw3w2/DTV7zF9QgBzuoOGWdzeJldHPPPXhRhyQ2hwfBNrg/4HCKGVseQouAgDRixS+WaxdvyWrTvDQic/ebqh+85XnCAFJu4RToWbEMHeV6zEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1IHeHF5; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1IHeHF5"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-47f03844ea3so529683137.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 08:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716220030; x=1716824830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HaPaKbo4SoWIbSz61fdgUloCkUGemC7zJpwNXgKLzp0=;
        b=f1IHeHF5l1QcyH9axvfIFINbGkFAtD/gam6qq7Ft0tYRvcNHzXQNdyaqzgoFGPL0lx
         7nbMC2+oNls6mtHynx3PyK2pEIQng/L3+eeFK7CUR8a8Lr6DVQljo6UxUgJAd/g8DzAL
         nV3PzutSESGOzMoGFeY9rBDvBpyRlVrN4Ga+RjeC5cJKal15JWuSF4NP9OAEjPZFOJQe
         qO2gOhWBZrg+zyZ4XTOiWUsinTKeLV/XIihSf9XIuDfVME/7fE6q110NIgv+NVAJUyyu
         VmfBqjsq/yKH4LxEBMRX/9XOp3rPHZZnAGeBIywlMAMb/fbpCfo3m08seCXxngUtks73
         rDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716220030; x=1716824830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HaPaKbo4SoWIbSz61fdgUloCkUGemC7zJpwNXgKLzp0=;
        b=kIIJDUM94RXDtjy/7wOazSTyIHncRRePk9fEOqT+o6jgya39vOyX8ejac6y5scR5Bj
         TJ2RRh4twKA6I0NWzpNKJEmFzrwOQ9xGghqhAf5HhL4w9yAQKvUW+7NVnY/k66jLW5mc
         Ak3QcYAy7nO2Bend9iNU0rPuBC0Qlj8/kMGmYA0F/cxcPnmgvEH/Fc3SykpOv5zej6uT
         0O+5A54WlTXenqNEzDxOgsmmOL6Uo/+TqXRrSVDXR4T95cWyGGzM0UZ9uOAC6bFtb8AU
         Tu0x51DRIH6iF1+/n+2TSuluxKlZFMh6TZdCaJ/A7VyD3mG+THWy+OOH73t53B3Dq+6S
         TrXg==
X-Gm-Message-State: AOJu0YzH1SxDRUwVMl8njMNJY7Ddox5Jz7fwR+vp/RjscjQxl1C9j19f
	VLOSEjEtzIhB/15CVXZNvz9wTekOPcirXQAVTfClFp5rzHsPJd56xzvCxQ==
X-Google-Smtp-Source: AGHT+IEsdCh9hDYRPxpKXW9NuV854Nt6HbF1XeD6jWD0tueCWz9WGhjg1EsR00M20AaNy43cuNApmg==
X-Received: by 2002:a05:6102:370a:b0:486:6998:d773 with SMTP id ada2fe7eead31-4866998d8f2mr11284167137.9.1716220030388;
        Mon, 20 May 2024 08:47:10 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4806cb008d2sm3370154137.2.2024.05.20.08.47.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 08:47:08 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/3] shared/uhid: Add special handling for non-keyboards
Date: Mon, 20 May 2024 11:47:03 -0400
Message-ID: <20240520154703.1219758-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240520154703.1219758-1-luiz.dentz@gmail.com>
References: <20240520154703.1219758-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds special handling for non-keyboards so they are destroyed when
disconnected rather than keeping their device node around.

Fixes: https://github.com/bluez/bluez/issues/848
---
 profiles/input/device.c  | 20 +++++++++++--------
 profiles/input/hog-lib.c | 43 +++++++++++++++++++++++-----------------
 profiles/input/hog-lib.h |  4 ++--
 profiles/input/hog.c     |  6 ++++--
 src/shared/uhid.c        | 17 ++++++++++++----
 src/shared/uhid.h        | 31 ++++++++++++++++++++++++++---
 6 files changed, 84 insertions(+), 37 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 2145c2da20f0..b162c0bc7572 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -84,6 +84,7 @@ struct input_device {
 	unsigned int		report_req_timer;
 	uint32_t		report_rsp_id;
 	bool			virtual_cable_unplug;
+	uint8_t			type;
 	unsigned int		idle_timer;
 };
 
@@ -174,18 +175,19 @@ static int uhid_disconnect(struct input_device *idev, bool force)
 	if (!bt_uhid_created(idev->uhid))
 		return 0;
 
-	/* Only destroy the node if virtual cable unplug flag has been set */
-	if (!idev->virtual_cable_unplug && !force)
-		return 0;
+	/* Force destroy the node if virtual cable unplug flag has been set */
+	if (idev->virtual_cable_unplug && !force)
+		force = true;
 
-	bt_uhid_unregister_all(idev->uhid);
-
-	err = bt_uhid_destroy(idev->uhid);
+	err = bt_uhid_destroy(idev->uhid, force);
 	if (err < 0) {
 		error("bt_uhid_destroy: %s", strerror(-err));
 		return err;
 	}
 
+	if (!bt_uhid_created(idev->uhid))
+		bt_uhid_unregister_all(idev->uhid);
+
 	return err;
 }
 
@@ -989,7 +991,8 @@ static int uhid_connadd(struct input_device *idev, struct hidp_connadd_req *req)
 
 	err = bt_uhid_create(idev->uhid, req->name, &idev->src, &idev->dst,
 				req->vendor, req->product, req->version,
-				req->country, req->rd_data, req->rd_size);
+				req->country, idev->type,
+				req->rd_data, req->rd_size);
 	if (err < 0) {
 		error("bt_uhid_create: %s", strerror(-err));
 		return err;
@@ -1078,7 +1081,7 @@ static int hidp_add_connection(struct input_device *idev)
 	/* Some platforms may choose to require encryption for all devices */
 	/* Note that this only matters for pre 2.1 devices as otherwise the */
 	/* device is encrypted by default by the lower layers */
-	if (classic_bonded_only || req->subclass & 0x40) {
+	if (classic_bonded_only || idev->type == BT_UHID_KEYBOARD) {
 		if (!bt_io_set(idev->intr_io, &gerr,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 					BT_IO_OPT_INVALID)) {
@@ -1468,6 +1471,7 @@ static struct input_device *input_device_new(struct btd_service *service)
 	idev->service = btd_service_ref(service);
 	idev->device = btd_device_ref(device);
 	idev->path = g_strdup(path);
+	idev->type = bt_uhid_icon_to_type(btd_device_get_icon(device));
 
 	input_device_update_rec(idev);
 
diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 964acc716041..67a0e832dc98 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -73,6 +73,7 @@ struct bt_hog {
 	uint16_t		vendor;
 	uint16_t		product;
 	uint16_t		version;
+	uint8_t			type;
 	struct gatt_db_attribute *attr;
 	struct gatt_primary	*primary;
 	GAttrib			*attrib;
@@ -825,17 +826,18 @@ static void set_report_cb(guint8 status, const guint8 *pdu,
 		error("bt_uhid_set_report_reply: %s", strerror(-err));
 }
 
-static void uhid_destroy(struct bt_hog *hog)
+static void uhid_destroy(struct bt_hog *hog, bool force)
 {
 	int err;
 
-	bt_uhid_unregister_all(hog->uhid);
-
-	err = bt_uhid_destroy(hog->uhid);
+	err = bt_uhid_destroy(hog->uhid, force);
 	if (err < 0) {
 		error("bt_uhid_destroy: %s", strerror(-err));
 		return;
 	}
+
+	if (bt_uhid_created(hog->uhid))
+		bt_uhid_unregister_all(hog->uhid);
 }
 
 static void set_report(struct uhid_event *ev, void *user_data)
@@ -850,7 +852,7 @@ static void set_report(struct uhid_event *ev, void *user_data)
 	 * while disconnected.
 	 */
 	if (hog->attrib == NULL) {
-		uhid_destroy(hog);
+		uhid_destroy(hog, true);
 		return;
 	}
 
@@ -948,7 +950,7 @@ static void get_report(struct uhid_event *ev, void *user_data)
 	 * while disconnected.
 	 */
 	if (hog->attrib == NULL) {
-		uhid_destroy(hog);
+		uhid_destroy(hog, true);
 		return;
 	}
 
@@ -1003,7 +1005,7 @@ static void uhid_create(struct bt_hog *hog, uint8_t *report_map,
 
 	err = bt_uhid_create(hog->uhid, hog->name, &src, &dst,
 				hog->vendor, hog->product, hog->version,
-				hog->bcountrycode, value, vlen);
+				hog->bcountrycode, hog->type, value, vlen);
 	if (err < 0) {
 		error("bt_uhid_create: %s", strerror(-err));
 		return;
@@ -1233,7 +1235,7 @@ static void hog_free(void *data)
 	struct bt_hog *hog = data;
 
 	bt_hog_detach(hog, true);
-	uhid_destroy(hog);
+	uhid_destroy(hog, true);
 
 	queue_destroy(hog->bas, (void *) bt_bas_unref);
 	g_slist_free_full(hog->instances, hog_free);
@@ -1252,9 +1254,9 @@ static void hog_free(void *data)
 
 struct bt_hog *bt_hog_new_default(const char *name, uint16_t vendor,
 					uint16_t product, uint16_t version,
-					struct gatt_db *db)
+					uint8_t type, struct gatt_db *db)
 {
-	return bt_hog_new(-1, name, vendor, product, version, db);
+	return bt_hog_new(-1, name, vendor, product, version, type, db);
 }
 
 static void foreach_hog_report(struct gatt_db_attribute *attr, void *user_data)
@@ -1414,6 +1416,7 @@ static void foreach_hog_chrc(struct gatt_db_attribute *attr, void *user_data)
 
 static struct bt_hog *hog_new(int fd, const char *name, uint16_t vendor,
 					uint16_t product, uint16_t version,
+					uint8_t type,
 					struct gatt_db_attribute *attr)
 {
 	struct bt_hog *hog;
@@ -1441,6 +1444,7 @@ static struct bt_hog *hog_new(int fd, const char *name, uint16_t vendor,
 	hog->vendor = vendor;
 	hog->product = product;
 	hog->version = version;
+	hog->type = type;
 	hog->attr = attr;
 
 	return hog;
@@ -1456,8 +1460,8 @@ static void hog_attach_instance(struct bt_hog *hog,
 		return;
 	}
 
-	instance = hog_new(hog->uhid_fd, hog->name, hog->vendor,
-					hog->product, hog->version, attr);
+	instance = hog_new(hog->uhid_fd, hog->name, hog->vendor, hog->product,
+				hog->version, hog->type, attr);
 	if (!instance)
 		return;
 
@@ -1493,11 +1497,11 @@ static void dis_notify(uint8_t source, uint16_t vendor, uint16_t product,
 
 struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
 					uint16_t product, uint16_t version,
-					struct gatt_db *db)
+					uint8_t type, struct gatt_db *db)
 {
 	struct bt_hog *hog;
 
-	hog = hog_new(fd, name, vendor, product, version, NULL);
+	hog = hog_new(fd, name, vendor, product, version, type, NULL);
 	if (!hog)
 		return NULL;
 
@@ -1620,7 +1624,7 @@ static void hog_attach_hog(struct bt_hog *hog, struct gatt_primary *primary)
 
 	instance = bt_hog_new(hog->uhid_fd, hog->name, hog->vendor,
 					hog->product, hog->version,
-					hog->gatt_db);
+					hog->type, hog->gatt_db);
 	if (!instance)
 		return;
 
@@ -1751,9 +1755,12 @@ void bt_hog_detach(struct bt_hog *hog, bool force)
 {
 	GSList *l;
 
-	if (!hog->attrib)
+	if (!hog)
 		return;
 
+	if (!hog->attrib)
+		goto done;
+
 	queue_foreach(hog->bas, (void *) bt_bas_detach, NULL);
 
 	for (l = hog->instances; l; l = l->next) {
@@ -1781,8 +1788,8 @@ void bt_hog_detach(struct bt_hog *hog, bool force)
 	g_attrib_unref(hog->attrib);
 	hog->attrib = NULL;
 
-	if (force)
-		uhid_destroy(hog);
+done:
+	uhid_destroy(hog, force);
 }
 
 int bt_hog_set_control_point(struct bt_hog *hog, bool suspend)
diff --git a/profiles/input/hog-lib.h b/profiles/input/hog-lib.h
index abca829bee92..41e454642705 100644
--- a/profiles/input/hog-lib.h
+++ b/profiles/input/hog-lib.h
@@ -12,11 +12,11 @@ struct bt_hog;
 
 struct bt_hog *bt_hog_new_default(const char *name, uint16_t vendor,
 					uint16_t product, uint16_t version,
-					struct gatt_db *db);
+					uint8_t type, struct gatt_db *db);
 
 struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
 					uint16_t product, uint16_t version,
-					struct gatt_db *db);
+					uint8_t type, struct gatt_db *db);
 
 struct bt_hog *bt_hog_ref(struct bt_hog *hog);
 void bt_hog_unref(struct bt_hog *hog);
diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 2db52d1a2fcb..bc1b89e57fbd 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -50,6 +50,7 @@
 struct hog_device {
 	struct btd_device	*device;
 	struct bt_hog		*hog;
+	uint8_t			type;
 };
 
 static gboolean suspend_supported = FALSE;
@@ -64,7 +65,7 @@ void input_set_auto_sec(bool state)
 static void hog_device_accept(struct hog_device *dev, struct gatt_db *db)
 {
 	char name[248];
-	uint16_t vendor, product, version;
+	uint16_t vendor, product, version, type;
 
 	if (dev->hog)
 		return;
@@ -77,11 +78,12 @@ static void hog_device_accept(struct hog_device *dev, struct gatt_db *db)
 	vendor = btd_device_get_vendor(dev->device);
 	product = btd_device_get_product(dev->device);
 	version = btd_device_get_version(dev->device);
+	type = bt_uhid_icon_to_type(btd_device_get_icon(dev->device));
 
 	DBG("name=%s vendor=0x%X, product=0x%X, version=0x%X", name, vendor,
 							product, version);
 
-	dev->hog = bt_hog_new_default(name, vendor, product, version, db);
+	dev->hog = bt_hog_new_default(name, vendor, product, version, type, db);
 }
 
 static struct hog_device *hog_device_new(struct btd_device *device)
diff --git a/src/shared/uhid.c b/src/shared/uhid.c
index 1f071b958974..1eddc6122990 100644
--- a/src/shared/uhid.c
+++ b/src/shared/uhid.c
@@ -44,6 +44,7 @@ struct bt_uhid {
 	unsigned int notify_id;
 	struct queue *notify_list;
 	struct queue *input;
+	uint8_t type;
 	bool created;
 	bool started;
 	struct uhid_replay *replay;
@@ -338,8 +339,8 @@ static void uhid_start(struct uhid_event *ev, void *user_data)
 
 int bt_uhid_create(struct bt_uhid *uhid, const char *name, bdaddr_t *src,
 			bdaddr_t *dst, uint32_t vendor, uint32_t product,
-			uint32_t version, uint32_t country, void *rd_data,
-			size_t rd_size)
+			uint32_t version, uint32_t country, uint8_t type,
+			void *rd_data, size_t rd_size)
 {
 	struct uhid_event ev;
 	int err;
@@ -381,6 +382,7 @@ int bt_uhid_create(struct bt_uhid *uhid, const char *name, bdaddr_t *src,
 
 	uhid->created = true;
 	uhid->started = false;
+	uhid->type = type;
 
 	return 0;
 }
@@ -487,7 +489,7 @@ done:
 	return bt_uhid_send(uhid, &ev);
 }
 
-int bt_uhid_destroy(struct bt_uhid *uhid)
+int bt_uhid_destroy(struct bt_uhid *uhid, bool force)
 {
 	struct uhid_event ev;
 	int err;
@@ -495,7 +497,14 @@ int bt_uhid_destroy(struct bt_uhid *uhid)
 	if (!uhid)
 		return -EINVAL;
 
-	if (!uhid->created)
+	/* Force destroy for non-keyboard devices - keyboards are not destroyed
+	 * on disconnect since they can glitch on reconnection losing
+	 * keypresses.
+	 */
+	if (!force && uhid->type != BT_UHID_KEYBOARD)
+		force = true;
+
+	if (!uhid->created || !force)
 		return 0;
 
 	memset(&ev, 0, sizeof(ev));
diff --git a/src/shared/uhid.h b/src/shared/uhid.h
index 4e288cb192aa..e76a6e22bd8e 100644
--- a/src/shared/uhid.h
+++ b/src/shared/uhid.h
@@ -15,6 +15,31 @@
 
 struct bt_uhid;
 
+enum {
+	BT_UHID_NONE = 0,
+	BT_UHID_KEYBOARD,
+	BT_UHID_MOUSE,
+	BT_UHID_GAMING,
+	BT_UHID_TABLET
+};
+
+static inline uint8_t bt_uhid_icon_to_type(const char *icon)
+{
+	if (!icon)
+		return BT_UHID_NONE;
+
+	if (!strcmp(icon, "input-keyboard"))
+		return BT_UHID_KEYBOARD;
+	else if (!strcmp(icon, "input-mouse"))
+		return BT_UHID_MOUSE;
+	else if (!strcmp(icon, "input-gaming"))
+		return BT_UHID_GAMING;
+	else if (!strcmp(icon, "input-tablet"))
+		return BT_UHID_TABLET;
+	else
+		return BT_UHID_NONE;
+}
+
 struct bt_uhid *bt_uhid_new_default(void);
 struct bt_uhid *bt_uhid_new(int fd);
 
@@ -32,8 +57,8 @@ bool bt_uhid_unregister_all(struct bt_uhid *uhid);
 int bt_uhid_send(struct bt_uhid *uhid, const struct uhid_event *ev);
 int bt_uhid_create(struct bt_uhid *uhid, const char *name, bdaddr_t *src,
 			bdaddr_t *dst, uint32_t vendor, uint32_t product,
-			uint32_t version, uint32_t country, void *rd_data,
-			size_t rd_size);
+			uint32_t version, uint32_t country, uint8_t type,
+			void *rd_data, size_t rd_size);
 bool bt_uhid_created(struct bt_uhid *uhid);
 bool bt_uhid_started(struct bt_uhid *uhid);
 int bt_uhid_input(struct bt_uhid *uhid, uint8_t number, const void *data,
@@ -41,5 +66,5 @@ int bt_uhid_input(struct bt_uhid *uhid, uint8_t number, const void *data,
 int bt_uhid_set_report_reply(struct bt_uhid *uhid, uint8_t id, uint8_t status);
 int bt_uhid_get_report_reply(struct bt_uhid *uhid, uint8_t id, uint8_t number,
 				uint8_t status, const void *data, size_t size);
-int bt_uhid_destroy(struct bt_uhid *uhid);
+int bt_uhid_destroy(struct bt_uhid *uhid, bool force);
 int bt_uhid_replay(struct bt_uhid *uhid);
-- 
2.45.1

