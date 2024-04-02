Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883182AD1E
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 16:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076273; cv=pass; b=eA7oel9JVTlOPDvnLgUmpu+mxEHA3osRkmlB1Hye4uqdgxPIO8cQUX/AV/LBiTuVsbePUvGT8Q8Kscfat7SaVK2drDJN1HbF8ktZtNpfhDqHKgpTQD/EA5K5VfhkSOEse1KYSWEEBVz9wcN8kdoP+uOkC+Y72Eq0gX+0GnrfQFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076273; c=relaxed/simple;
	bh=+na/k3gX9RqgJGI6JXoQM+57o1y3rJyTyZTO92kufns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kbwywuaX0VlKINpko0uOjHBuDB8nlWbLMlNAFNDkaV7Lal7nfy5q3FHbrhVF5kahtWo7ljnN7YxO6ilBAWD4P5r5fgiko2KeHu3bKAzgKkRdnmi3fi4wU0q6iWlv05koJKdoJPqp87Fh7TDeBybelB6n7YWyKZe1M3DxcJ8+ZSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Yh/EJjRn; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Yh/EJjRn"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4V8DHd2DbKz101C;
	Tue,  2 Apr 2024 19:44:29 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1712076269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k8CK2DupyQK2t/NQPfgw02/xliGnaLtSyxt3UvVowHY=;
	b=Yh/EJjRn7DsGPgYhKEFf5ivOQHrTJLWd5+1/GV+sYrgMmxekKljvDPH45GjSsseObIb+D6
	trsnfEE+WbhK0iYSzB30bSZRyw0UDlVHGuu++4EagIUuzSfqG5PZ+ebKiIlhAjjSCQUf3q
	fb+Q72A2K196r2N50zCyJwYfljd8sIQ=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1712076269; a=rsa-sha256; cv=none;
	b=XBtY2EdBT0cHTBhl3B299hWeYvSM2w99L7Dj5u/mi5onZ+THKTE3FejJ672CuLxj/AmqyT
	sqn3QwWDiskWDQ7bGW3i1pPJThc7GMAz4QtPbsOxhat8EGilQOkWVmZoL1EzwXUjvwyR+c
	qWjWZ+0hq8XaLD8Uc0hDR5jy3t7z9Is=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1712076269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k8CK2DupyQK2t/NQPfgw02/xliGnaLtSyxt3UvVowHY=;
	b=RrR2IizoQwq6VdJhHxuR9Ho6qOuQxikjLvdvz3o99SIauzjxg3ARYaddqmskVWgYp9h2sB
	YduQupj9N4S5Zmlrlsr13ENvbC7Qw5DDzCGhfz6eMNNX/UTk4x7rLPYAvbmmOG78qutMNb
	Yoqce0uWWP1xuSq7K5/BFl+YkGLEUoc=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] adapter: add support for setting NO_ERRQUEUE_POLL experimental feature
Date: Tue,  2 Apr 2024 19:44:26 +0300
Message-ID: <abbf81af1d80d8a2863f1b441b5c39bad8e89fa2.1712076220.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for setting No Errqueue Poll experimental UUID which enables
the use of the BT_NO_ERRQUEUE_POLL socket option.
---
 src/adapter.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 src/adapter.h |  1 +
 src/main.c    |  1 +
 src/main.conf |  1 +
 4 files changed, 50 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 4bcc464de..2bd6e57a8 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -148,6 +148,13 @@ static const struct mgmt_exp_uuid iso_socket_uuid = {
 	.str = "6fbaf188-05e0-496a-9885-d6ddfdb4e03e"
 };
 
+/* 69518c4c-b69f-4679-8bc1-c021b47b5733 */
+static const struct mgmt_exp_uuid no_errqueue_poll_uuid = {
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
 
+static void no_errqueue_poll_complete(uint8_t status, uint16_t len,
+				const void *param, void *user_data)
+{
+	struct exp_pending *pending = user_data;
+	struct btd_adapter *adapter = pending->adapter;
+	uint8_t action;
+
+	if (status != 0) {
+		error("Set No Errqueue Poll failed with status 0x%02x (%s)",
+						status, mgmt_errstr(status));
+		return;
+	}
+
+	action = btd_kernel_experimental_enabled(no_errqueue_poll_uuid.str);
+
+	DBG("No Errqueue Poll successfully %s", action ? "set" : "reset");
+
+	if (action)
+		queue_push_tail(adapter->exps,
+					(void *)no_errqueue_poll_uuid.val);
+}
+
+static void no_errqueue_poll_func(struct btd_adapter *adapter, uint8_t action)
+{
+	struct mgmt_cp_set_exp_feature cp;
+
+	memset(&cp, 0, sizeof(cp));
+	memcpy(cp.uuid, no_errqueue_poll_uuid.val, 16);
+	cp.action = action;
+
+	if (exp_mgmt_send(adapter, MGMT_OP_SET_EXP_FEATURE,
+			MGMT_INDEX_NONE, sizeof(cp), &cp,
+			no_errqueue_poll_complete))
+		return;
+
+	btd_error(adapter->dev_id, "Failed to set No Errqueue Poll");
+}
+
 static const struct exp_feat {
 	uint32_t flag;
 	const struct mgmt_exp_uuid *uuid;
@@ -10041,6 +10086,8 @@ static const struct exp_feat {
 	EXP_FEAT(EXP_FEAT_CODEC_OFFLOAD, &codec_offload_uuid,
 		codec_offload_func),
 	EXP_FEAT(EXP_FEAT_ISO_SOCKET, &iso_socket_uuid, iso_socket_func),
+	EXP_FEAT(EXP_FEAT_NO_ERRQUEUE_POLL, &no_errqueue_poll_uuid,
+							no_errqueue_poll_func),
 };
 
 static void read_exp_features_complete(uint8_t status, uint16_t length,
diff --git a/src/adapter.h b/src/adapter.h
index ca96c1f65..738b62976 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -268,6 +268,7 @@ enum experimental_features {
 	EXP_FEAT_RPA_RESOLUTION		= 1 << 3,
 	EXP_FEAT_CODEC_OFFLOAD		= 1 << 4,
 	EXP_FEAT_ISO_SOCKET		= 1 << 5,
+	EXP_FEAT_NO_ERRQUEUE_POLL	= 1 << 6,
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
index 815f1c0f8..7708e4dda 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -136,6 +136,7 @@
 # 330859bc-7506-492d-9370-9a6f0614037f (BlueZ Experimental Bluetooth Quality Report)
 # a6695ace-ee7f-4fb9-881a-5fac66c629af (BlueZ Experimental Offload Codecs)
 # 6fbaf188-05e0-496a-9885-d6ddfdb4e03e (BlueZ Experimental ISO socket)
+# 69518c4c-b69f-4679-8bc1-c021b47b5733 (BlueZ Experimental No Errqueue Poll)
 # Defaults to false.
 #KernelExperimental = false
 
-- 
2.44.0

