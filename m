Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA571B7E2
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Feb 2024 05:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708925018; cv=none; b=GbrgRYvLDD2Uilb9cV+Rg/UUDbv52u43ne8mfa9WErYEQYeIIKK6MKQVa8voOptZUZwGfW9l94vQGRjAgS6jKx2T27SZi2ogeq4oEwHb3bAasStU8MPoAMcHVGqc9fUv1NsD8WlvKBMM+sDMd4HlbnIfRyy+L5JDZKsqkJ4EXIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708925018; c=relaxed/simple;
	bh=nLz/CaQBR+ql21DzS+f/hl5SGjBYXmoICN7cLgRR5B8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=I8Nuunobc9QW+U9WA5G2TC7WkgXPgPxHlf561MggujB8qInNzgjQm9mBFMRWuyMOSR+SzNHT0OVzlB1Ky+2mhzUWQ6e5NiAqrALLFSxhs4Qh1WXfr6aoDwsU/YpQ4bn/g2T1+01lut3bnlueR3VdBHMGdOSjtlJbH6r322nHAPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--apusaka.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tI/GmGRS; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--apusaka.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tI/GmGRS"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcbee93a3e1so4163397276.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Feb 2024 21:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708925015; x=1709529815; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mu6pXNb1/DqBMJ0eQwkauETf5vaNxsLxLVHtrs6ruhI=;
        b=tI/GmGRSSo2t1OfMTX2v4LkiEO+ZxN1p0aN2a+NipuNb/2N5l/AMCxWdXt0TLaK5Oy
         R3Eq8aUy3b3KQzAykqRKsOSJeK/sLZBOb/Xa27zmvoOWieOJcIUYXB2pATF1seQB6Ij0
         GK0+ynGZ3LCK1g1afzQ1mYtuiK0Inx2Ty7vLeOT7T2pRI4wO+9EUKEMNF+x0NNBLjvvm
         Kf34h7THtfe7RSFxgb7WlWf9BUjv7gUTzqvGDYuisja3R5l+50hxK4kl3VcMKGaNZRAj
         zqTqYr08vFFlHTAcC3rogLk3Scszw5FNyLm6Q74vqv02cBJL14xRsnk7/pLaAUjLTngi
         7/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708925015; x=1709529815;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mu6pXNb1/DqBMJ0eQwkauETf5vaNxsLxLVHtrs6ruhI=;
        b=Q1aebLgNQC3vckITxSIJJXLiK+4fGbPu5MgdvhgDCbnkCLRI9CgOZqqsrninnwJsym
         UoRyWvCAfJkalgTePUFJnAj36p8ch4Ptqt6YYTFZMRqdio3tF+FFFZ6JsL6ZR7snbvUU
         wy34zIxpkv5scVWCFxkmLxkbiWwc2thglHD2lRd47EHjsfj/5lpNfs9DtSTG0Z/hJiPD
         gXbJqvUryJ/Xo4alkim5xpGv2KSXn9SSa5VSaZlv0CKfu9GiPYIPrZ2T7Xxpy88evcAw
         cIB+tY1pk/DF/sZMZAiVLgLS+wtd9KrpOwrVD+0kdqc9N1PFmqo5eC/GQV74bvLDLdV+
         2ZTg==
X-Gm-Message-State: AOJu0YwazofvYWasIhHbTHyobYDiTTefFCUgZ+rf806lx+ikANGNVgUX
	Bs1BGQot3cAXUNrLOiGMUusCAo0y0Vkx5Kt7WHlLvhHAFsn5RwEwFjPXkfxciz24wgsrW/xZzM7
	aPd5gRnICpS4RLkpkSWlW4IVev5T5pwyb/x2aivSEvQL4gQ+rq8y4lSo4PB1VLCCbxTlt80uVyw
	8spVYI6Xc56sZEjkyVGz+jZMS0va2cWyj9mk9tui1oQMIfQbptjg==
X-Google-Smtp-Source: AGHT+IE1Gx4nGo2Y06rcJlNLMYnHutzH19ihyIFbKp/KpQwZdGsdzMc/jXcHNDXvPaftTT5IwpJ0j8DFMLoU
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:17:9027:7c11:8ff2:b446])
 (user=apusaka job=sendgmr) by 2002:a05:6902:1807:b0:dc8:27e6:cde1 with SMTP
 id cf7-20020a056902180700b00dc827e6cde1mr213710ybb.5.1708925015476; Sun, 25
 Feb 2024 21:23:35 -0800 (PST)
Date: Mon, 26 Feb 2024 13:22:01 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240226132201.Bluez.1.I8d368be0c7f86e8a999fccc33f8c9742b405bcea@changeid>
Subject: [Bluez PATCH] advertising: Fix assigning mgmt callback id when adding advertisement
From: Archie Pusaka <apusaka@google.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>
Cc: CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>, 
	Archie Pusaka <apusaka@chromium.org>, Hsin-chen Chuang <chharry@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Archie Pusaka <apusaka@chromium.org>

A struct member add_adv_id is used to track whether the adv client is
still needed for some mgmt callback. This is checked when freeing the
client to avoid UAF. We currently only set this member if we have a
callback after calling mgmt_send.

In case of extended advertisement, this is always a two-step process:
first to set the params, then the data. It is possible for the client
to be freed when we are pending on setting the params, and if we don't
set the add_adv_id (because we have no callback for setting the data),
the client on the 2nd step of the process will be invalid, leading to
UAF scenario.

This patch always sets the add_adv_id member on the 1st step of adding
an extended advertisement, and adjust the value accordingly on the 2nd
step. Additionally, this patch drops the 3rd parameter of the function
refresh_advertisement since it can always be derived from the 1st and
2nd parameter.

Reviewed-by: Hsin-chen Chuang <chharry@google.com>
---

 src/advertising.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index 2c9a5a4438..b85dbcb504 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -888,8 +888,7 @@ static int get_adv_flags(struct btd_adv_client *client)
 }
 
 static int refresh_legacy_adv(struct btd_adv_client *client,
-				mgmt_request_func_t func,
-				unsigned int *mgmt_id)
+				mgmt_request_func_t func)
 {
 	struct mgmt_cp_add_advertising *cp;
 	uint8_t param_len;
@@ -950,8 +949,8 @@ static int refresh_legacy_adv(struct btd_adv_client *client,
 		free(cp);
 		return -EINVAL;
 	}
-	if (mgmt_id)
-		*mgmt_id = mgmt_ret;
+	if (func)
+		client->add_adv_id = mgmt_ret;
 
 	free(cp);
 
@@ -962,7 +961,7 @@ static void add_adv_params_callback(uint8_t status, uint16_t length,
 				    const void *param, void *user_data);
 
 static int refresh_extended_adv(struct btd_adv_client *client,
-				mgmt_request_func_t func, unsigned int *mgmt_id)
+				mgmt_request_func_t func)
 {
 	struct mgmt_cp_add_ext_adv_params cp;
 	uint32_t flags = 0;
@@ -1015,21 +1014,18 @@ static int refresh_extended_adv(struct btd_adv_client *client,
 
 	/* Store callback, called after we set advertising data */
 	client->refresh_done_func = func;
-
-	if (mgmt_id)
-		*mgmt_id = mgmt_ret;
-
+	client->add_adv_id = mgmt_ret;
 
 	return 0;
 }
 
 static int refresh_advertisement(struct btd_adv_client *client,
-			mgmt_request_func_t func, unsigned int *mgmt_id)
+					mgmt_request_func_t func)
 {
 	if (client->manager->extended_add_cmds)
-		return refresh_extended_adv(client, func, mgmt_id);
+		return refresh_extended_adv(client, func);
 
-	return refresh_legacy_adv(client, func, mgmt_id);
+	return refresh_legacy_adv(client, func);
 }
 
 static bool client_discoverable_timeout(void *user_data)
@@ -1042,7 +1038,7 @@ static bool client_discoverable_timeout(void *user_data)
 
 	bt_ad_clear_flags(client->data);
 
-	refresh_advertisement(client, NULL, NULL);
+	refresh_advertisement(client, NULL);
 
 	return FALSE;
 }
@@ -1250,7 +1246,7 @@ static void properties_changed(GDBusProxy *proxy, const char *name,
 			continue;
 
 		if (parser->func(iter, client)) {
-			refresh_advertisement(client, NULL, NULL);
+			refresh_advertisement(client, NULL);
 
 			break;
 		}
@@ -1329,6 +1325,8 @@ static void add_adv_params_callback(uint8_t status, uint16_t length,
 	unsigned int mgmt_ret;
 	dbus_int16_t tx_power;
 
+	client->add_adv_id = 0;
+
 	if (status)
 		goto fail;
 
@@ -1391,6 +1389,9 @@ static void add_adv_params_callback(uint8_t status, uint16_t length,
 			     client->manager->mgmt_index, param_len, cp,
 			     client->refresh_done_func, client, NULL);
 
+	if (mgmt_ret && client->refresh_done_func)
+		client->add_adv_id = mgmt_ret;
+
 	/* Clear the callback */
 	client->refresh_done_func = NULL;
 
@@ -1399,9 +1400,6 @@ static void add_adv_params_callback(uint8_t status, uint16_t length,
 		goto fail;
 	}
 
-	if (client->add_adv_id)
-		client->add_adv_id = mgmt_ret;
-
 	free(cp);
 	cp = NULL;
 
@@ -1483,8 +1481,7 @@ static DBusMessage *parse_advertisement(struct btd_adv_client *client)
 		goto fail;
 	}
 
-	err = refresh_advertisement(client, add_adv_callback,
-					&client->add_adv_id);
+	err = refresh_advertisement(client, add_adv_callback);
 
 	if (!err)
 		return NULL;
@@ -2017,7 +2014,7 @@ static void manager_refresh(void *data, void *user_data)
 {
 	struct btd_adv_client *client = data;
 
-	refresh_advertisement(client, user_data, NULL);
+	refresh_advertisement(client, NULL);
 }
 
 void btd_adv_manager_refresh(struct btd_adv_manager *manager)
-- 
2.44.0.rc1.240.g4c46232300-goog

