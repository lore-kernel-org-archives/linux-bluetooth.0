Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CBB4AF16C
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 21:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789506949; cv=none; b=i7KqFGNGZwVbVZFJLaQ5B74KQyzKP4xK5YiMAdX5zsQ4KSPPzeaA/HVWYz57gfPTxKOcgf7JHt2mjo2f5myE3YX1CeYtnTwhdb728jKZZ1vl6rXyJPSXKULo//jH3G5sStrfsib6090fBLf/klzJSJ4KTnQaV8HrOsZKfsaDpJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789506949; c=relaxed/simple;
	bh=gUixbaexFuG8ero8KpQ1BVJhxhe1Re6Ehv4BE5CE7WI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J13D7vZ7gNqJQ0yX9IgbNzzq1gfYZu7h8cBo5WPPlFViRZOUWCN0K3gw4462EegKLVv1674PRhAdeZ5HkzG/QShwHqDaDJ4ioKnYNzoP3bZKcvZ8vnFH9fFdP1QremfBshAwiFZE42nGbhGm4ocMbmSnBkN+834etDylyWJQffY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhaN92iU; arc=none smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhaN92iU"
Received: by mail-vs2-f43.google.com with SMTP id ada2fe7eead31-78565a41a19so75952137.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 14:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789506947; x=1790111747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BV78T/MGxHgJaQpXEkvyJfejpUkGE0EamrfVrb2uFh8=;
        b=RhaN92iUOml7x742N61XXT1ev++DHmUi7j1y+J8mGIyxaLVaOPPJNNAOsYXRdSv1aJ
         l0DOyHBIr5AnwkYjTFk6yndOo6ahIbam/yEC9jWHT7j2myFo729A6kk5T3AtMpxTFjrL
         bik+z7hSpNcsXDYXlNgU6IYInlGkkLPP0Wo2oOgOYqVPc5VMruVJ93zOlBw7VXWnGxqh
         +D3IUDv9dgjXhU/WHGbSuun/YLose8+TaiTNktWPbevWzCWYCvjZCUKLjqHfhppPym/H
         GuYFz7eHrS1fZPFwwkNfOo5Q6o8QCLDRzRjh1MOl7Ty3q3O/Y/DgSCWu5bLi+RTAzB+U
         MFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789506947; x=1790111747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BV78T/MGxHgJaQpXEkvyJfejpUkGE0EamrfVrb2uFh8=;
        b=J4giJKS6Mf6bReWVJXG/M3DnaQavXRRsUicYtQh6vVsf0MdazDspsXvoeUZKt076hZ
         u9NioqFgNXvzGyfhR2X9fXIBox0fIPFWwPfiiIYTuy0UWmTxW0AzTdng23sXcMxVrnyW
         LP0pNMFsCnWnql3pu9phHu1BvZDrU9uivGYKYodN0YjqFQHObxWuuT3ZjE46KKtllTCT
         ockv2MrLsUfj5ruL0l5afYl9DFZpJgbv1XD9wSmb5a1PyBIPvQGAKLczNIImFROD0Nge
         skA/GltnQEmLEfCIDrZDtooZTs2J7EchEBfF789iig73G23+yz9QJ9Em6dU8rnIM3tof
         J6yA==
X-Gm-Message-State: AFuF++mTy+CNiTo3doRAIkpRws6W7EqPkAp/iyCAjcUvuN34ebFbiPWq
	g32sREurLc6tJhGDSVjTQWoSN1wT4n9PTiZ+D5c2Cq7U9zi3f2j0ivNKq48NWDND
X-Gm-Gg: AYBFou0FOq6mvlAm2aEDjM99yR7xKdeSZrTkM3wxQBzOHgkJeeZIWNZs7FY63nvDlCw
	gSpoibtIP1vYS7ysPBrPOFoHkgMtRn/HWhIP0AU+Wu58AFZYAvIlO/5vp1K5LlTYW80Kqqo8IWG
	kdFCzamxcRnlE6yc5RlmkttEUeGFppyATDLTVR2nsBL5INz7OR4iGSJUwxf7CTCCSrHw4f7gZOh
	7T/KR46Ieq1IpACQBUsErUC9lql2AuAKGLRpzM+oOFsJNFgHpwxEmMMKngnXhGhyohNOfb2K41i
	aJqGQRIrjkLIzWACwK0y0lL/K01h/T6UbjwT7YoGC54jv5gYcM4ht9qXRsgODU/plinE4y++87q
	6Tw6uGi/E+6GvVcbNjwuJ9LtFpSkyv/Cpxld8BSOtcq9LbP9esyftEeOdfoHqiDGoB/zelGa2F/
	uLsLuSIXOsRqp6ve7CPsACdoNk6Se03GSLWqY32brJwA6PBwM7BlHf+b3J4ow29DG4s7mz3EC/g
	+dlh5aKxDWknUNgMIwC+xn1DgHpg3CLI1tpJjxiIMGEJVEJ9fp+19usi+BkE/EXhQ==
X-Received: by 2002:a05:6102:41a0:b0:79b:b389:d6d6 with SMTP id ada2fe7eead31-7a029f09437mr436689137.11.1789506946909;
        Tue, 15 Sep 2026 14:15:46 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98314dd7ceasm746860241.1.2026.09.15.14.15.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 14:15:46 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 08/11] device: keep the long term key of both roles
Date: Tue, 15 Sep 2026 17:15:25 -0400
Message-ID: <20260915211528.1223784-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915211528.1223784-1-luiz.dentz@gmail.com>
References: <20260915211528.1223784-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

LE legacy pairing distributes one long term key per role: each side
generates its own and gives it to the peer, which uses it to encrypt
the link when that side is the peripheral. Secure Connections derives a
single key instead, so there is only one to keep.

Only one key was kept though, whichever arrived last, so the key ending
up on each side of a legacy bond was not necessarily the same one.

Encrypting the SIRK of a coordinated set then gave a value the other
side was unable to decrypt, as sef() is only symmetric when both sides
use the same key, and the set was resolved under a SIRK that is not the
one the members were configured with.

Keep the key of each role and select the one matching the role of the
link, so both sides use the key the peripheral distributed.

Assisted-by: opencode:claude-opus-5
---
 src/device.c | 45 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/src/device.c b/src/device.c
index 8da576ec5932..c63cc80856bb 100644
--- a/src/device.c
+++ b/src/device.c
@@ -282,7 +282,10 @@ struct btd_device {
 
 	struct csrk_info *local_csrk;
 	struct csrk_info *remote_csrk;
-	struct ltk_info *ltk;
+	struct ltk_info *ltk;		/* Used when acting as central */
+	struct ltk_info *peripheral_ltk;	/* Used when acting as
+						 * peripheral
+						 */
 	struct queue	*sirks;
 
 	sdp_list_t	*tmp_records;
@@ -957,6 +960,7 @@ static void device_free(gpointer user_data)
 	g_free(device->local_csrk);
 	g_free(device->remote_csrk);
 	free(device->ltk);
+	free(device->peripheral_ltk);
 	g_free(device->path);
 	g_free(device->alias);
 	free(device->modalias);
@@ -2132,12 +2136,19 @@ static void add_set(void *data, void *user_data)
 void device_set_ltk(struct btd_device *device, const uint8_t val[16],
 				bool central, uint8_t enc_size)
 {
-	if (!device->ltk)
-		device->ltk = new0(struct ltk_info, 1);
+	struct ltk_info **ltk;
 
-	memcpy(device->ltk->key, val, sizeof(device->ltk->key));
-	device->ltk->central = central;
-	device->ltk->enc_size = enc_size;
+	/* Legacy pairing distributes one key per role, so both are kept
+	 * to let each of them be selected by the role of the link.
+	 */
+	ltk = central ? &device->ltk : &device->peripheral_ltk;
+
+	if (!*ltk)
+		*ltk = new0(struct ltk_info, 1);
+
+	memcpy((*ltk)->key, val, sizeof((*ltk)->key));
+	(*ltk)->central = central;
+	(*ltk)->enc_size = enc_size;
 	bt_att_set_enc_key_size(device->att, enc_size);
 
 	/* Check if there is any set/sirk that needs decryption */
@@ -2147,16 +2158,27 @@ void device_set_ltk(struct btd_device *device, const uint8_t val[16],
 bool btd_device_get_ltk(struct btd_device *device, uint8_t key[16],
 				bool *central, uint8_t *enc_size)
 {
-	if (!device || !device->ltk || !key)
+	struct ltk_info *ltk;
+
+	if (!device || !key)
 		return false;
 
-	memcpy(key, device->ltk->key, sizeof(device->ltk->key));
+	/* The key securing the link is the one distributed by the
+	 * peripheral, so each side has to select the one matching its
+	 * role for both to use the same key.
+	 */
+	ltk = btd_device_is_initiator(device) ? device->ltk :
+						device->peripheral_ltk;
+	if (!ltk)
+		return false;
+
+	memcpy(key, ltk->key, sizeof(ltk->key));
 
 	if (central)
-		*central = device->ltk->central;
+		*central = ltk->central;
 
 	if (enc_size)
-		*enc_size = device->ltk->enc_size;
+		*enc_size = ltk->enc_size;
 
 	return true;
 }
@@ -6426,6 +6448,9 @@ static void gatt_server_init(struct btd_device *device,
 
 	if (device->ltk)
 		bt_att_set_enc_key_size(device->att, device->ltk->enc_size);
+	else if (device->peripheral_ltk)
+		bt_att_set_enc_key_size(device->att,
+					device->peripheral_ltk->enc_size);
 
 	if (btd_opts.gatt_seclevel == BT_ATT_SECURITY_LOW)
 		bt_gatt_server_set_permissions(device->server, false);
-- 
2.55.0

