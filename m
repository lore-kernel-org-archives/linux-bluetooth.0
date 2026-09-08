Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FF75921E5
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 17:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887207; cv=none; b=Q3OsbviWrybKL5h6L4kv1F0TnTqTcsATA+jS+nA3bU6ldMBE9ajk0dWV0VzZkSI73Ln5E4jcgO6wNOVpwWX0BoSouE5IwDIy2SnGBi8QndC7ynErLM6oS4X6l62LKf8Vjt1+vPsZjpZC+T9Xnaty188HxbPsB1xru+a3AGpqX80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887207; c=relaxed/simple;
	bh=ptGdvL7fExvdXOs8jU6Tw4eP3cZhdWorcAirlvFadG0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cGUmDKJS5qeYGyLbqX1DrS1HG/iQ47ARoI98CPnQ9XWo0qYV0FVOvcGkJA2pxEQfCrAVU4QXCAiSCXMFnieYD1bu39TfjVmMVpArNDwx7BL4A+Emeai3E5Y4Qu0m1f0IGUm3rvHgl4SH3H9rGJ2tU/htRdpc/LD/MLwphy9cefE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WSb12Qsn; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WSb12Qsn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788887200;
	bh=ptGdvL7fExvdXOs8jU6Tw4eP3cZhdWorcAirlvFadG0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WSb12QsnUndULBj1Z0YH94mi1N9+6YNL6h9C/FkbgZauG+4Tc9rz1RCEDGjD4ezLO
	 NZwnHf/CAyPdw7ZRf+wNasQwEejn8iP4Ybgsj5h1eY6UowU3hUnAva6/nFBIFY6pWn
	 pCv/1PfhkkplY96QusGDaIGLtTykLynt9Da9x1wk51pS/ckjs+RxK9wxrzrMUIwKwY
	 lGcNnuwVikVFqRm21LbywNwMHPFMXf2Gale1JrEPtMDdnk716BNoGJPXpXarlBXX7M
	 GA0HidRQ359FnDMhnA8VUxBsY30PMCkkwjXflK6Rr0Qd/N31o0Xm0s8cf+8t5bB1Ab
	 b0ANvBYYqujjw==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9394B17E0FE2
	for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2026 19:06:40 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 7/8] client/btpclient: Defer CIG/CIS assignment based on Client/Server role
Date: Tue,  8 Sep 2026 19:06:32 +0200
Message-ID: <20260908170633.510244-8-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908170633.510244-1-frederic.danis@collabora.com>
References: <20260908170633.510244-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Previously, CIG/CIS ids were eagerly assigned to each ASE as soon as
it was discovered (CIG 0, next available CIS), regardless of whether
the btpclient was acting as the Unicast Client or Server for that ASE.
This did not match how CIG/CIS ids are actually negotiated, nor what
auto-pts expects: unicast client tests expect CIG/CIS to start at 0/0,
while unicast server tests expect them to start at 1/1.

- As Unicast Client, the CIG/CIS ids are chosen locally when building
  the QoS properties returned from SelectProperties(), starting at 0.
- As Unicast Server, the CIG/CIS ids are only known once the transport
  reports them; if not yet available, all of the device's ASEs should
  share a common CIG (1) with CIS ids starting at 1 as well.

Move get_next_cis() from bap.c to ascs.c and extend it to take a base
CIS value, so it can be reused both for the Client and Server code
paths (base 0 and base 1 respectively) and skips ASEs whose CIS id is
still unset. Leave ase->cig_id and ase->cis_id unset
(BT_ISO_QOS_CIG_UNSET/BT_ISO_QOS_CIS_UNSET) at ASE discovery time, and
resolve them lazily:

- In get_properties_reply(), assign CIG 0 and the next CIS starting at
  0 when building the QoS reply for SelectProperties() (Client role).
- In ascs_proxy_added(), when the transport does not yet report a
  CIG/CIS, assign CIG 1 to all of the device's ASEs and derive CIS ids
  starting at 1 via the new set_cig_cis()/set_cig_cis_data helpers
  (Server role).
---
 client/btpclient/ascs.c | 144 ++++++++++++++++++++++++++++++++++------
 client/btpclient/bap.c  |  74 ++-------------------
 2 files changed, 127 insertions(+), 91 deletions(-)

diff --git a/client/btpclient/ascs.c b/client/btpclient/ascs.c
index 85f6f171a..6b6154614 100644
--- a/client/btpclient/ascs.c
+++ b/client/btpclient/ascs.c
@@ -918,6 +918,76 @@ static void ltv_find(size_t i, uint8_t l, uint8_t t, uint8_t *v,
 	*found = true;
 }
 
+static uint8_t get_next_cis(struct btp_device *device, uint8_t dir,
+							uint8_t base)
+{
+	const struct l_queue_entry *adapter_entry;
+	const struct l_queue_entry *ase_entry;
+	uint8_t cis = base;
+	bool found = false;
+
+	/* For the same device, reuse the opposite cis_id if there is no ASE
+	 * in the requested direction already using that same cis_id
+	 */
+	for (ase_entry = l_queue_get_entries(device->ases); ase_entry;
+					ase_entry = ase_entry->next) {
+		struct btp_ase *ase = ase_entry->data;
+		const struct l_queue_entry *entry;
+		bool has_same_dir = false;
+
+		if (ase->dir == dir)
+			continue;
+
+		for (entry = l_queue_get_entries(device->ases); entry;
+					entry = entry->next) {
+			struct btp_ase *peer = entry->data;
+
+			if (peer->dir == dir && peer->cis_id == ase->cis_id) {
+				has_same_dir = true;
+				break;
+			}
+		}
+
+		if (!has_same_dir)
+			return ase->cis_id;
+	}
+
+	/* Else returns the global highest cis_id + 1 across all ASEs of all
+	 * devices, or 'base' if none has already been assigned
+	 */
+	for (adapter_entry = l_queue_get_entries(get_adapters_list());
+					adapter_entry;
+					adapter_entry = adapter_entry->next) {
+		struct btp_adapter *adapter = adapter_entry->data;
+		const struct l_queue_entry *device_entry;
+
+		for (device_entry = l_queue_get_entries(adapter->devices);
+					device_entry;
+					device_entry = device_entry->next) {
+			struct btp_device *dev = device_entry->data;
+
+			for (ase_entry = l_queue_get_entries(dev->ases);
+						ase_entry;
+						ase_entry = ase_entry->next) {
+				struct btp_ase *ase = ase_entry->data;
+
+				if (ase->cis_id == BT_ISO_QOS_CIS_UNSET)
+					continue;
+
+				if (!found || ase->cis_id > cis)
+					cis = ase->cis_id;
+
+				found = true;
+			}
+		}
+	}
+
+	if (!found)
+		return cis;
+
+	return cis + 1;
+}
+
 static struct l_dbus_message *get_properties_reply(
 						struct l_dbus_message *message,
 						struct btp_adapter *adapter,
@@ -1019,27 +1089,31 @@ static struct l_dbus_message *get_properties_reply(
 	l_dbus_message_builder_enter_variant(builder, "a{sv}");
 	l_dbus_message_builder_enter_array(builder, "{sv}");
 
-	if (ase->cig_id != BT_ISO_QOS_CIG_UNSET) {
-		l_dbus_message_builder_enter_dict(builder, "sv");
-		l_dbus_message_builder_append_basic(builder, 's',
-						"CIG");
-		l_dbus_message_builder_enter_variant(builder, "y");
-		l_dbus_message_builder_append_basic(builder, 'y',
-						&ase->cig_id);
-		l_dbus_message_builder_leave_variant(builder);
-		l_dbus_message_builder_leave_dict(builder);
-	}
+	/* SelectProperties() is only invoked when acting as the Unicast Client,
+	 * so assign CIG 0 here and pick the next available CIS for this ASE.
+	 */
+	if (ase->cig_id == BT_ISO_QOS_CIG_UNSET)
+		ase->cig_id = 0;
+	if (ase->cis_id == BT_ISO_QOS_CIS_UNSET)
+		ase->cis_id = get_next_cis(ase->device, ase->dir, 0);
 
-	if (ase->cis_id != BT_ISO_QOS_CIS_UNSET) {
-		l_dbus_message_builder_enter_dict(builder, "sv");
-		l_dbus_message_builder_append_basic(builder, 's',
-						"CIS");
-		l_dbus_message_builder_enter_variant(builder, "y");
-		l_dbus_message_builder_append_basic(builder, 'y',
-						&ase->cis_id);
-		l_dbus_message_builder_leave_variant(builder);
-		l_dbus_message_builder_leave_dict(builder);
-	}
+	l_dbus_message_builder_enter_dict(builder, "sv");
+	l_dbus_message_builder_append_basic(builder, 's',
+					"CIG");
+	l_dbus_message_builder_enter_variant(builder, "y");
+	l_dbus_message_builder_append_basic(builder, 'y',
+					&ase->cig_id);
+	l_dbus_message_builder_leave_variant(builder);
+	l_dbus_message_builder_leave_dict(builder);
+
+	l_dbus_message_builder_enter_dict(builder, "sv");
+	l_dbus_message_builder_append_basic(builder, 's',
+					"CIS");
+	l_dbus_message_builder_enter_variant(builder, "y");
+	l_dbus_message_builder_append_basic(builder, 'y',
+					&ase->cis_id);
+	l_dbus_message_builder_leave_variant(builder);
+	l_dbus_message_builder_leave_dict(builder);
 
 	l_dbus_message_builder_enter_dict(builder, "sv");
 	l_dbus_message_builder_append_basic(builder, 's',
@@ -1283,6 +1357,24 @@ static bool transport_get_cig_cis(struct l_dbus_proxy *proxy, uint8_t *cig,
 	return true;
 }
 
+struct set_cig_cis_data {
+	struct btp_device *device;
+	uint8_t cig;
+};
+
+static void set_cig_cis(void *data, void *user_data)
+{
+	struct btp_ase *ase = data;
+	struct set_cig_cis_data *param = user_data;
+	uint8_t cis = get_next_cis(param->device, ase->dir, 1);
+
+	if (ase->cig_id != BT_ISO_QOS_CIG_UNSET)
+		return;
+
+	ase->cig_id = param->cig;
+	ase->cis_id = cis;
+}
+
 void ascs_proxy_added(struct l_dbus_proxy *proxy, void *user_data)
 {
 	char *str, *state;
@@ -1307,8 +1399,18 @@ void ascs_proxy_added(struct l_dbus_proxy *proxy, void *user_data)
 	else
 		dir = BTP_BAP_DIR_SINK;
 
-	if (!transport_get_cig_cis(proxy, &cig, &cis))
+	if (!transport_get_cig_cis(proxy, &cig, &cis)) {
+		struct set_cig_cis_data data;
+
+		/* No CIG/CIS reported on the transport yet, meaning this ASE
+		 * is acting as the Unicast Server: assign CIG 1 to all of the
+		 * device's ASEs and let set_cig_cis() derive their CIS ids.
+		 */
+		data.device = device;
+		data.cig = 1;
+		l_queue_foreach(device->ases, set_cig_cis, &data);
 		return;
+	}
 
 	ase = find_ase(device, cig, cis, dir);
 	if (!ase)
diff --git a/client/btpclient/bap.c b/client/btpclient/bap.c
index b1d70a50d..edb220f54 100644
--- a/client/btpclient/bap.c
+++ b/client/btpclient/bap.c
@@ -317,72 +317,6 @@ failed:
 	btp_send_error(btp, BTP_BAP_SERVICE, adapter->index, BTP_ERROR_FAIL);
 }
 
-static uint8_t get_next_cis(struct btp_device *device, uint8_t dir)
-{
-	const struct l_queue_entry *adapter_entry;
-	const struct l_queue_entry *ase_entry;
-	uint8_t cis = 0;
-	bool found = false;
-
-	/* For the same device, reuse the opposite cis_id if there is no ASE
-	 * in the requested direction already using that same cis_id
-	 */
-	for (ase_entry = l_queue_get_entries(device->ases); ase_entry;
-					ase_entry = ase_entry->next) {
-		struct btp_ase *ase = ase_entry->data;
-		const struct l_queue_entry *entry;
-		bool has_same_dir = false;
-
-		if (ase->dir == dir)
-			continue;
-
-		for (entry = l_queue_get_entries(device->ases); entry;
-					entry = entry->next) {
-			struct btp_ase *peer = entry->data;
-
-			if (peer->dir == dir && peer->cis_id == ase->cis_id) {
-				has_same_dir = true;
-				break;
-			}
-		}
-
-		if (!has_same_dir)
-			return ase->cis_id;
-	}
-
-	/* Else returns the global highest cis_id + 1 across all ASEs of all
-	 * devices, or 0 if no ASE exists
-	 */
-	for (adapter_entry = l_queue_get_entries(get_adapters_list());
-					adapter_entry;
-					adapter_entry = adapter_entry->next) {
-		struct btp_adapter *adapter = adapter_entry->data;
-		const struct l_queue_entry *device_entry;
-
-		for (device_entry = l_queue_get_entries(adapter->devices);
-					device_entry;
-					device_entry = device_entry->next) {
-			struct btp_device *dev = device_entry->data;
-
-			for (ase_entry = l_queue_get_entries(dev->ases);
-						ase_entry;
-						ase_entry = ase_entry->next) {
-				struct btp_ase *ase = ase_entry->data;
-
-				if (!found || ase->cis_id > cis)
-					cis = ase->cis_id;
-
-				found = true;
-			}
-		}
-	}
-
-	if (!found)
-		return 0;
-
-	return cis + 1;
-}
-
 void bap_proxy_added(struct l_dbus_proxy *proxy, void *user_data)
 {
 	struct btp_device *device = user_data;
@@ -403,8 +337,8 @@ void bap_proxy_added(struct l_dbus_proxy *proxy, void *user_data)
 			ase->device = device;
 			ase->dir = BTP_BAP_DIR_SINK;
 			ase->uuid = uuid;
-			ase->cig_id = 0;
-			ase->cis_id = get_next_cis(device, ase->dir);
+			ase->cig_id = BT_ISO_QOS_CIG_UNSET;
+			ase->cis_id = BT_ISO_QOS_CIS_UNSET;
 			l_queue_push_tail(device->ases, ase);
 
 			l_dbus_proxy_method_call(proxy, "ReadValue",
@@ -420,8 +354,8 @@ void bap_proxy_added(struct l_dbus_proxy *proxy, void *user_data)
 			ase->device = device;
 			ase->dir = BTP_BAP_DIR_SOURCE;
 			ase->uuid = uuid;
-			ase->cig_id = 0;
-			ase->cis_id = get_next_cis(device, ase->dir);
+			ase->cig_id = BT_ISO_QOS_CIG_UNSET;
+			ase->cis_id = BT_ISO_QOS_CIS_UNSET;
 			l_queue_push_tail(device->ases, ase);
 
 			l_dbus_proxy_method_call(proxy, "ReadValue",
-- 
2.43.0

