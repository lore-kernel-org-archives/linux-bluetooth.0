Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2C438E11A
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 19:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920364; cv=none; b=NY58pgVeRJbZamWIclCVuNn2mQ5XE16bFa4ka88alwbzzUObMPwByM94jCLWLoUthd4ywO/KPgo52QoOwz6bgQLSztPZ1gwOV3X9OF3b4KfUwUeAWNdVtotyUN2IkD5mndg3zgWeCmkypCIXl+QivNfoi56JqxSbH3PgBAvejp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920364; c=relaxed/simple;
	bh=OKVI8UFLnIOCkEU/ioiivopbtw68tIgz6x1/W4JCfME=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ncSvm6+nEdMnspe5I+kkLX6/ExWf2865qyL8gZ/JiQ9JLA8zSjmKE5XFAWPZtzMLbrBRTzbOFLsu07Xtptbo0qaB5isP4hU160dgF5XiuVvuyiOsqbmA3vd2d0xiTf7w2FTxxa8mYH14Eli3cgt70yYifBlzxGLZHBR1F7akUjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nj8rGUXN; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nj8rGUXN"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-9725084c547so457553241.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 12:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784920361; x=1785525161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uFNAe9zRbsPJ8wiBsa21kggaEQu7WXsYtei+lBmKTo8=;
        b=Nj8rGUXNipCRBjSO+8B8mEzr93//ep4NNY07rF6EeMqIEp6lo3+n90Zsrl5MdHS3jt
         vvB8S8Xm81AOV2lgvCtiaMiNYogm5jevgdYL62kZE+DCCd+3+wWlODI8I+KNKpY10SaC
         I2B8Of0G/pgJd6V3j9XM7ykI54/0hJ2zbsWIy1g1R0jYQvKgyeOB3MrxeWnoHRVwBmFH
         U+kFkwIw3gnsavIPwrj6TUW1uzNe+bMKVLzra0NorqGijNQ3wMTGc2SCEHT5BkW7Oz7D
         iFXhE016Gu4CYGYEGMFixlyUBGcDA/nttMq3iO/YeRltOsMT931BDnS3YhqtzmmAOD/q
         aJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784920361; x=1785525161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uFNAe9zRbsPJ8wiBsa21kggaEQu7WXsYtei+lBmKTo8=;
        b=jCjJ9gk9+OSOOdvpYFkc/u0Lr15sE17PmSpHq5NXyUANvLXzmwU/0gyAfuBGaoLIoF
         QF0V83fxdrYH1yGnwrNSWgEXVJQoR7g17lq+SMOXtzUIQ058dU+J9DqJgbr1cogiLHdA
         E/zL7bgqv0xMyZ2vALU4xsU4BY9AtMp3CtP002Ugb/NmlvApYPp/xW/Ep4+d7yNdykVG
         u+eK5a/a/yoIHS3+4SCwHRMVrW3ACVPg+CLBOpvdV14oCE/IPEferQdE5UVPSgOBlP6n
         PbKIakkAp1U5HiZ+nN+i4kfPrY7rdaTKJ+Kgx/pYw3rT+Q9NYQh2ABbbkmLp9RrW800f
         eTMw==
X-Gm-Message-State: AOJu0Yx/FIlMaVQ/sa6ThVuU/yLcXQGZYvDKwf6VuzQVRlsG0zDshVrf
	xijQEAS+M63raQvZAQW++Q3CoXmhfkZmqeWNrvzU74bwTPgXWR+LOhidJtNxeUMU
X-Gm-Gg: AR+sD11+eXTRKBzE3KJn8UPsIUEERPeYfXmgE6EBItnUx57/I0g6a2l9fmVpqjZltX4
	e0vm7HhrWBSEeDJv6O2GiXdcFYtV/tWPB97aSkJBCQqlvxHeCRdZl5FhPAUNXIHPm2Ixq8kT7g3
	F0lnmhDgpnwgLBxbQj5Eyca/CunPeYMEBTkRJdU67qRNiUNfhROc+dbBYKD8ESdO5nTdLrum/eD
	39+h5ZCLWvKzm/B2t9CBp7PNjEXkjkbe53ZvBsgxhM1aqtj6fNdO8PAT+Qh9H0ZnBFOMFDbI+F7
	Oy2BiDwdv/+T1GqMUYU0ZDOHPtoryKlrtHCjpudLXqxh1BDFHsG7C09tboJ/OHtShFnxETbPKZD
	7v7IXcMSJBoKmMzzNd7xsP7V/CGjTWx8MfFn+0I8Euw1Ipr/6otUOn6pjlMeDTFp4aBLaAVJzbC
	qPbyKC83iNQcdQL8YsT+nY6uG4G6ytLx369LqvOWJ0W3R3yw4AV0mgEyAHHRzQxZ5Qp4755R3IR
	09ljkzLE/Y=
X-Received: by 2002:a05:6102:3f8a:b0:650:94b2:b209 with SMTP id ada2fe7eead31-74d5d9c36b7mr4597151137.4.1784920361027;
        Fri, 24 Jul 2026 12:12:41 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97774c8b921sm488554241.4.2026.07.24.12.12.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:12:40 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 05/12] adapter: Add support for loading connection subrate parameters
Date: Fri, 24 Jul 2026 15:12:18 -0400
Message-ID: <20260724191225.1815634-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724191225.1815634-1-luiz.dentz@gmail.com>
References: <20260724191225.1815634-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Implement load_conn_subrate() to load per-device connection subrate
parameters via the new MGMT_OP_LOAD_CONN_SUBRATE command. Parameters
are read from the [ConnectionSubrate] section of device info files
and sent to the kernel when the SCI setting is supported.

The subrate parameters include connection interval range, subrate
factor range, max latency, continuation number, and supervision
timeout as defined in the Bluetooth 6.2 SCI feature.
---
 src/adapter.c | 172 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 172 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index a56eafabea78..c21b3e7fbcc2 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -206,6 +206,18 @@ struct conn_param {
 	uint16_t timeout;
 };
 
+struct conn_subrate {
+	bdaddr_t bdaddr;
+	uint8_t  bdaddr_type;
+	uint16_t min_interval;
+	uint16_t max_interval;
+	uint16_t subrate_min;
+	uint16_t subrate_max;
+	uint16_t max_latency;
+	uint16_t cont_num;
+	uint16_t supv_timeout;
+};
+
 struct discovery_filter {
 	uint8_t type;
 	char *pattern;
@@ -4222,6 +4234,46 @@ static struct conn_param *get_conn_param(GKeyFile *key_file, const char *peer,
 	return param;
 }
 
+static struct conn_subrate *get_conn_subrate(GKeyFile *key_file,
+						const char *peer,
+						uint8_t bdaddr_type)
+{
+	struct conn_subrate *subrate;
+
+	if (!g_key_file_has_group(key_file, "ConnectionSubrate"))
+		return NULL;
+
+	subrate = g_new0(struct conn_subrate, 1);
+
+	subrate->min_interval = g_key_file_get_integer(key_file,
+							"ConnectionSubrate",
+							"MinInterval", NULL);
+	subrate->max_interval = g_key_file_get_integer(key_file,
+							"ConnectionSubrate",
+							"MaxInterval", NULL);
+	subrate->subrate_min = g_key_file_get_integer(key_file,
+							"ConnectionSubrate",
+							"SubrateMin", NULL);
+	subrate->subrate_max = g_key_file_get_integer(key_file,
+							"ConnectionSubrate",
+							"SubrateMax", NULL);
+	subrate->max_latency = g_key_file_get_integer(key_file,
+							"ConnectionSubrate",
+							"MaxLatency", NULL);
+	subrate->cont_num = g_key_file_get_integer(key_file,
+							"ConnectionSubrate",
+							"ContinuationNumber",
+							NULL);
+	subrate->supv_timeout = g_key_file_get_integer(key_file,
+							"ConnectionSubrate",
+							"SupervisionTimeout",
+							NULL);
+	str2ba(peer, &subrate->bdaddr);
+	subrate->bdaddr_type = bdaddr_type;
+
+	return subrate;
+}
+
 static int generate_and_write_irk(uint8_t *irk, GKeyFile *key_file,
 							const char *filename)
 {
@@ -4693,6 +4745,75 @@ void btd_adapter_load_conn_param(struct btd_adapter *adapter,
 	g_slist_free(params);
 }
 
+static void load_conn_subrate_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		btd_error(adapter->dev_id,
+			"hci%u Load Connection Subrate failed: %s (0x%02x)",
+				adapter->dev_id, mgmt_errstr(status), status);
+		return;
+	}
+
+	DBG("Connection Subrate loaded for hci%u", adapter->dev_id);
+}
+
+static void load_conn_subrate(struct btd_adapter *adapter,
+						struct queue *subrates)
+{
+	struct mgmt_cp_load_conn_subrate *cp;
+	struct mgmt_conn_subrate *entry;
+	size_t count, cp_size;
+	unsigned int id;
+	const struct queue_entry *e;
+
+	if (!(adapter->supported_settings & MGMT_SETTING_SCI))
+		return;
+
+	count = queue_length(subrates);
+
+	DBG("hci%u conn subrates %zu", adapter->dev_id, count);
+
+	cp_size = sizeof(*cp) + (count * sizeof(*entry));
+
+	cp = g_try_malloc0(cp_size);
+	if (cp == NULL) {
+		btd_error(adapter->dev_id,
+			"Failed to allocate memory for connection subrate");
+		return;
+	}
+
+	cp->param_count = htobs(count);
+
+	entry = cp->params;
+	for (e = queue_get_entries(subrates); e; e = e->next) {
+		struct conn_subrate *info = e->data;
+
+		bacpy(&entry->addr.bdaddr, &info->bdaddr);
+		entry->addr.type = info->bdaddr_type;
+		entry->min_interval = htobs(info->min_interval);
+		entry->max_interval = htobs(info->max_interval);
+		entry->subrate_min = htobs(info->subrate_min);
+		entry->subrate_max = htobs(info->subrate_max);
+		entry->max_latency = htobs(info->max_latency);
+		entry->cont_num = htobs(info->cont_num);
+		entry->supv_timeout = htobs(info->supv_timeout);
+		entry++;
+	}
+
+	id = mgmt_send(adapter->mgmt, MGMT_OP_LOAD_CONN_SUBRATE,
+			adapter->dev_id, cp_size, cp,
+			load_conn_subrate_complete, adapter, NULL);
+
+	g_free(cp);
+
+	if (id == 0)
+		btd_error(adapter->dev_id,
+					"Load connection subrate failed");
+}
+
 static uint8_t get_addr_type(GKeyFile *keyfile)
 {
 	uint8_t addr_type;
@@ -4980,6 +5101,7 @@ static void load_devices(struct btd_adapter *adapter)
 	GSList *ltks = NULL;
 	GSList *irks = NULL;
 	GSList *params = NULL;
+	struct queue *subrates = NULL;
 	GSList *added_devices = NULL;
 	GError *gerr = NULL;
 	DIR *dir;
@@ -5006,6 +5128,7 @@ static void load_devices(struct btd_adapter *adapter)
 		GSList *list;
 		struct irk_info *irk_info;
 		struct conn_param *param;
+		struct conn_subrate *subrate;
 		uint8_t bdaddr_type;
 
 		if (entry->d_type == DT_UNKNOWN)
@@ -5082,6 +5205,14 @@ static void load_devices(struct btd_adapter *adapter)
 		if (param)
 			params = g_slist_append(params, param);
 
+		subrate = get_conn_subrate(key_file, entry->d_name,
+								bdaddr_type);
+		if (subrate) {
+			if (!subrates)
+				subrates = queue_new();
+			queue_push_tail(subrates, subrate);
+		}
+
 		list = g_slist_find_custom(adapter->devices, entry->d_name,
 							device_address_cmp);
 		if (list) {
@@ -5125,6 +5256,8 @@ free:
 	g_slist_free_full(irks, g_free);
 	load_conn_params(adapter, params);
 	g_slist_free_full(params, g_free);
+	load_conn_subrate(adapter, subrates);
+	queue_destroy(subrates, free);
 
 	g_slist_free_full(added_devices, probe_devices);
 }
@@ -9221,6 +9354,40 @@ static void new_conn_param(uint16_t index, uint16_t length,
 					ev->latency, ev->timeout);
 }
 
+static void conn_subrate_evt(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_ev_conn_subrate *ev = param;
+	struct btd_adapter *adapter = user_data;
+	uint16_t interval, subrate, latency, cont_num, supv_timeout;
+	char dst[18];
+
+	if (length < sizeof(*ev)) {
+		btd_error(adapter->dev_id,
+				"Too small Connection Subrate event");
+		return;
+	}
+
+	ba2str(&ev->addr.bdaddr, dst);
+
+	if (ev->status) {
+		DBG("hci%u %s (%u) subrate failed status 0x%02x",
+			adapter->dev_id, dst, ev->addr.type, ev->status);
+		return;
+	}
+
+	interval = btohs(ev->interval);
+	subrate = btohs(ev->subrate);
+	latency = btohs(ev->latency);
+	cont_num = btohs(ev->cont_num);
+	supv_timeout = btohs(ev->supv_timeout);
+
+	DBG("hci%u %s (%u) interval 0x%04x subrate 0x%04x latency 0x%04x "
+		"cont_num 0x%04x timeout 0x%04x", adapter->dev_id, dst,
+		ev->addr.type, interval, subrate, latency, cont_num,
+		supv_timeout);
+}
+
 int adapter_set_io_capability(struct btd_adapter *adapter,
 						enum mgmt_io_capability io_cap)
 {
@@ -10548,6 +10715,11 @@ static void read_info_complete(uint8_t status, uint16_t length,
 						new_conn_param,
 						adapter, NULL);
 
+	mgmt_register(adapter->mgmt, MGMT_EV_CONN_SUBRATE,
+						adapter->dev_id,
+						conn_subrate_evt,
+						adapter, NULL);
+
 	mgmt_register(adapter->mgmt, MGMT_EV_DEVICE_BLOCKED,
 						adapter->dev_id,
 						device_blocked_callback,
-- 
2.54.0

