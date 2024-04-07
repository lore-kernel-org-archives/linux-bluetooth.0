Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780DB39AFD
	for <linux-bluetooth@vger.kernel.org>; Sun,  7 Apr 2024 15:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712503129; cv=pass; b=UFLdP84dhEq4ANhkooxXYex0ZshLxg5nLbWJlTg2SOq+ONQVPNHdV2RF+nTRmexeXyptuut54ovQ3VMB3Xhj8XR7jg5zViqvVeRn4eX8eTfssRVXKP1DxQX+TfWO7I8ZaWhyFijG/h7WgZMo84ZdAoVJyUzJg42HpsIJt184ubE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712503129; c=relaxed/simple;
	bh=AgcZoEuJfbZoCjUu/4k/FJuQRHUDvcopkufv/h//C6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gkNc9bhNuA27LzQtvdpbYaynWnzV9CDPw+XqNU9DgRvEW7UuLWYPoeRnMvhkCtAVnm/UlxONW0RkM4GAUthvpNaCHHAm9ZC1Ct4/LZT3pc531mtx5ZQF3/d4t0ySHmkRj7m846RDAv4oUJyCCKkTnCuRHwIfXLWWjFk6BM8hDto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=G+2euRi+; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="G+2euRi+"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4VCG8N74ycz49Q20;
	Sun,  7 Apr 2024 18:18:44 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1712503125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pkyZrSOTT3NvVIPAjUfwU9CnIkZi7NLUach/U+zZUh8=;
	b=G+2euRi+lPrZv8BymJXC4iGDOxAceGeTNl5BPH5y6E7+n3Dv9IivD4ns/PvVFyrt+cNkce
	psfwUWO4osCJqGLxfrXq/KFnord5bfejlfMOC0fTbqodymSnshaILL1pHLSk+C2pHue8IE
	kVH6uztDyv+hPLh7n1nMNH+IcTk8a260PeJglU3YmMhCUw6HvVry3hD6bEjal0OzHAiLL8
	ywmng/pG7mHCu0eO+8apO8/CMb/mY1X36PdKFOTxQRiELftPhiDjyoMT+CNFWrnJLhZLuJ
	BZAnvtk3kTb9PsV5jBeGPNLi9suPh/BlhvS1RneGY6BnuVKJE6la2VtpD5cAIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1712503125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pkyZrSOTT3NvVIPAjUfwU9CnIkZi7NLUach/U+zZUh8=;
	b=amdgStF0c9oS311Mv3ezMln3WqW+LVylv+AliiiYJ/exMYQpGGpjWhbZ3081NaCbyZoyQv
	GUHTM6o/osnQ0wr9wRBbB1hdDorcq5rmw6Giw6/bMI5MaS+j3ZAbdxzUi3NGruV9Cz7UJc
	/jdXy28Yl8Z1HnGffpR41SRP0+DSCkv5P6+rgbSHik4MoBSAQztsYgS4I/DKz78yptILw/
	RRFdJ2JENmn398haBEf95BHY0UxqDR7c676SizkEkoDTyrG3XL5vrFg8VvvsmSBCFumW42
	GsnLekZQfzmHoM/ZRt10BxXLZLlOt3rANEKajTmxLaRlyP1ThYWodVFYMDXqyg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1712503125; a=rsa-sha256;
	cv=none;
	b=risnzhI0B6MmXIBvPZh8FiMs2zi01PqqTez4GGOe+KVC/o9R/m+K1omGu8Ao641VWTgVdX
	nJlRkmU0WorW6LGfdeZyYZb91YmkrPwy1sw/et7i413HNPXVXR4VBHpgBCg+vbFxkzWvmo
	LNg/AZQ+vh1IdOasXfAkZSA48rkzz0qEBGGgtsDzTP5iwAMFW/73OwnRQ6fvEWr/JeXnIn
	N22y07gYfjLwjtdRJdut2g+nCYpGm9qjpbINrdWHfMfVVuc5LYe13eICVQeYSOA8QjNWed
	sqpZ7mKdv6hGesEAwHjdMu15HqkLNt2ClEAyZecplI6340nCSJ6q/95Gip3fyw==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/5] adapter: add support for setting POLL_ERRQUEUE experimental feature
Date: Sun,  7 Apr 2024 18:18:35 +0300
Message-ID: <e7ec5e73b7cbd653de6c33732b87e4055b22b026.1712503074.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712503073.git.pav@iki.fi>
References: <cover.1712503073.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for setting an experimental feature UUID which enables the
use of the BT_POLL_ERRQUEUE socket option.

Change adapter initialization to read and set also INDEX_NONE features.
This may set them multiple times, but this is harmless and it is simpler
to use the same framework.
---
 src/adapter.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++---
 src/adapter.h |  1 +
 src/main.c    |  1 +
 src/main.conf |  1 +
 4 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 017e60233..1a9e28bed 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -148,6 +148,13 @@ static const struct mgmt_exp_uuid iso_socket_uuid = {
 	.str = "6fbaf188-05e0-496a-9885-d6ddfdb4e03e"
 };
 
+/* 69518c4c-b69f-4679-8bc1-c021b47b5733 */
+static const struct mgmt_exp_uuid poll_errqueue_uuid = {
+	.val = { 0x33, 0x57, 0x7b, 0xb4, 0x21, 0xc0, 0xc1, 0x8b,
+		0x79, 0x46, 0x9f, 0xb6, 0x4c, 0x8c, 0x51, 0x69 },
+	.str = "69518c4c-b69f-4679-8bc1-c021b47b5733"
+};
+
 static DBusConnection *dbus_conn = NULL;
 
 static uint32_t kernel_features = 0;
@@ -10027,6 +10034,44 @@ static void iso_socket_func(struct btd_adapter *adapter, uint8_t action)
 	btd_error(adapter->dev_id, "Failed to set ISO Socket");
 }
 
+static void poll_errqueue_complete(uint8_t status, uint16_t len,
+				const void *param, void *user_data)
+{
+	struct exp_pending *pending = user_data;
+	struct btd_adapter *adapter = pending->adapter;
+	uint8_t action;
+
+	if (status != 0) {
+		error("Set Poll Errqueue failed with status 0x%02x (%s)",
+						status, mgmt_errstr(status));
+		return;
+	}
+
+	action = btd_kernel_experimental_enabled(poll_errqueue_uuid.str);
+
+	DBG("Poll Errqueue successfully %s", action ? "set" : "reset");
+
+	if (action)
+		queue_push_tail(adapter->exps,
+					(void *)poll_errqueue_uuid.val);
+}
+
+static void poll_errqueue_func(struct btd_adapter *adapter, uint8_t action)
+{
+	struct mgmt_cp_set_exp_feature cp;
+
+	memset(&cp, 0, sizeof(cp));
+	memcpy(cp.uuid, poll_errqueue_uuid.val, 16);
+	cp.action = action;
+
+	if (exp_mgmt_send(adapter, MGMT_OP_SET_EXP_FEATURE,
+			MGMT_INDEX_NONE, sizeof(cp), &cp,
+			poll_errqueue_complete))
+		return;
+
+	btd_error(adapter->dev_id, "Failed to set Poll Errqueue");
+}
+
 static const struct exp_feat {
 	uint32_t flag;
 	const struct mgmt_exp_uuid *uuid;
@@ -10041,6 +10086,8 @@ static const struct exp_feat {
 	EXP_FEAT(EXP_FEAT_CODEC_OFFLOAD, &codec_offload_uuid,
 		codec_offload_func),
 	EXP_FEAT(EXP_FEAT_ISO_SOCKET, &iso_socket_uuid, iso_socket_func),
+	EXP_FEAT(EXP_FEAT_POLL_ERRQUEUE, &poll_errqueue_uuid,
+							poll_errqueue_func),
 };
 
 static void read_exp_features_complete(uint8_t status, uint16_t length,
@@ -10052,8 +10099,6 @@ static void read_exp_features_complete(uint8_t status, uint16_t length,
 	size_t feature_count = 0;
 	size_t i = 0;
 
-	DBG("index %u status 0x%02x", adapter->dev_id, status);
-
 	if (status != MGMT_STATUS_SUCCESS) {
 		btd_error(adapter->dev_id,
 				"Failed to read exp features info: %s (0x%02x)",
@@ -10105,10 +10150,31 @@ static void read_exp_features_complete(uint8_t status, uint16_t length,
 	}
 }
 
+static void read_exp_features_adapter_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct exp_pending *pending = user_data;
+	struct btd_adapter *adapter = pending->adapter;
+
+	DBG("index %u status 0x%02x", adapter->dev_id, status);
+	return read_exp_features_complete(status, length, param, user_data);
+}
+
+static void read_exp_features_none_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	DBG("index NONE status 0x%02x", status);
+	return read_exp_features_complete(status, length, param, user_data);
+}
+
 static void read_exp_features(struct btd_adapter *adapter)
 {
 	if (exp_mgmt_send(adapter, MGMT_OP_READ_EXP_FEATURES_INFO,
-			adapter->dev_id, 0, NULL, read_exp_features_complete))
+			adapter->dev_id, 0, NULL,
+			read_exp_features_adapter_complete) &&
+	    exp_mgmt_send(adapter, MGMT_OP_READ_EXP_FEATURES_INFO,
+			MGMT_INDEX_NONE, 0, NULL,
+			read_exp_features_none_complete))
 		return;
 
 	btd_error(adapter->dev_id, "Failed to read exp features info");
diff --git a/src/adapter.h b/src/adapter.h
index ca96c1f65..2ca045539 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -268,6 +268,7 @@ enum experimental_features {
 	EXP_FEAT_RPA_RESOLUTION		= 1 << 3,
 	EXP_FEAT_CODEC_OFFLOAD		= 1 << 4,
 	EXP_FEAT_ISO_SOCKET		= 1 << 5,
+	EXP_FEAT_POLL_ERRQUEUE		= 1 << 6,
 };
 
 bool btd_adapter_has_exp_feature(struct btd_adapter *adapter, uint32_t feature);
diff --git a/src/main.c b/src/main.c
index f774670e4..78831ad02 100644
--- a/src/main.c
+++ b/src/main.c
@@ -707,6 +707,7 @@ static const char *valid_uuids[] = {
 	"330859bc-7506-492d-9370-9a6f0614037f",
 	"a6695ace-ee7f-4fb9-881a-5fac66c629af",
 	"6fbaf188-05e0-496a-9885-d6ddfdb4e03e",
+	"69518c4c-b69f-4679-8bc1-c021b47b5733",
 	"*"
 };
 
diff --git a/src/main.conf b/src/main.conf
index 815f1c0f8..49864b5c3 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -136,6 +136,7 @@
 # 330859bc-7506-492d-9370-9a6f0614037f (BlueZ Experimental Bluetooth Quality Report)
 # a6695ace-ee7f-4fb9-881a-5fac66c629af (BlueZ Experimental Offload Codecs)
 # 6fbaf188-05e0-496a-9885-d6ddfdb4e03e (BlueZ Experimental ISO socket)
+# 69518c4c-b69f-4679-8bc1-c021b47b5733 (BlueZ Experimental Poll Errqueue)
 # Defaults to false.
 #KernelExperimental = false
 
-- 
2.44.0

