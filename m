Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463885C96
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Sep 2025 19:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758311240; cv=none; b=F/ic/sEPAM6ahyNYl/JYKZZ1cHUtBrm3EB/GG9PTlyimirzhhiIr8J0doiJTQQeO8pwmkAM+vXXZHQewJMZrb0wL9DyyuGrQPV+gAsf4mN2NJaqlw1S5lwKw8UQ46dhjND0KXSangpM6XZbfVYZrCfXoFeLigmoWwNMgxiFNd2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758311240; c=relaxed/simple;
	bh=SgM87T3uhbC6p4DSdFsOh7SbFFc+iLeuUHCprKpOrIY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=o+YfTplxe0B+Upp08Q/jET24KOE4mSV2X0Oj3+pWyGtsnpiCz4R4gzcsxCH5j/Hq1Ln7WYJZtMgpCqCxOy3nlv1G+zGydaJgVDdyCuhuLy4k63PtCzJ2WTRrBUlRQHdU+b3SlQi3VQ+K2gKDxbAaHyxKR8XmOxkTyktkiGILXtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bi964R2I; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bi964R2I"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-51d14932f27so928481137.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Sep 2025 12:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758311235; x=1758916035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CRUiHDx7N2hxU1hPc7AkoVh0mqY7+3R0O0ZkjY5doCA=;
        b=bi964R2Io74BpbRd//ZNySMxqKGGcbQScmi+zkVRB+YJVZEfsoCYNOPqTeVLDU4BKr
         m4LgAvXSigSPYZt6+gZrEg51jEiq0cYen/QDevjeI10N8M8oTXBECFgJF3ERbOxugQuz
         jZn5WLsGWe4ZZYy7hzsQUOw9W/ve6HD53K/hR2M1okPK8EGzMlBA8GWYU3vNrt04KLT7
         mtFInE+Nxw1MsojWybcQkaXRipwUzsPTSsNZ9pedvOhsSYx0WICKWHYlrlHo77HCWm0H
         d1z+nCXRisnCSsr7CVSFNXoj8n7rVgD5ues1rOnI/4h5CDCx+4Yf4bMF+zkRpSnCc26Z
         LUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758311235; x=1758916035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CRUiHDx7N2hxU1hPc7AkoVh0mqY7+3R0O0ZkjY5doCA=;
        b=lo0LWOJ0x3lE39tzjPiYxICL95jMGLorejY4JZjE4qlXIjIYETgyoTxTlhIdPAyXMm
         27caGBoezziHvS8sbDopqIFtBCFCqQlBgYooaW7nClSyVySC09JpwcpYi5SFTwkpPSyK
         47EUvqRdnCG9rMz3hq2S+fypnY+nA86HqLzdqOCpLiRnd1jWVDI46Uk0hjrNn0uteNjA
         777zysWg9aDV6eNutbOgSGJlzGmC94dqzQy5fE4Ur7oQa2uXtIw/u57XLBSnA+ULkL41
         U4BIKZIk5bTRUbR5ZF/ZSBcsXkc4Ipy1+7zlZqII5DeP8t1zoVqujpRgnxAwZMORAbjR
         o5CA==
X-Gm-Message-State: AOJu0YykIvaUsej4uZbhIh9Zrw4Yyi1/aqJUbnaOYH3pzBpp1IMCrqzi
	TOTcf4C26FQ+y5AEIybFf5iwTuCfUFRKJccrHNnPdFw5k4x4wQGYRidUReQN4g==
X-Gm-Gg: ASbGncvcXM80h4LitlXDOA+I652CZUSSDgR8+nHEq+xhl21PxlawhL8vPEZBcjnkRq4
	T3OeKwAaDXl6hU9c4TSshfCK8C3U2Q3VKigXocDTp3ORGz9Jl1B/L7cRKvxmUOioZKflZ3aaDdy
	uODGAA7CX78HJLKi+ICW4Y/yMOBfLMHDULlsoAhoJl38hQEsTOLvOs6W4jqGABZWxY/cuZlVbP+
	54opU8cM8sSgpnBGytCNNGRqgz+RtJiAc3HmRDvlylcYnKRndkiBjkyiqysn6L4CjZS8r6GPqpm
	1loVl5tP2mA9cH7jSFQq7gbyVVIOegej9T5peD/9pzNeqebCtXijiGxN1y1b50E2j+rw2OaHgYP
	3/at0uIN1+Ur6miHOk2B7Bkm+5OdJnUqjKBOQeahO0zswgREjfEcKzZlsUEGkLFyCpg==
X-Google-Smtp-Source: AGHT+IFK3c9OaJ1NlHHYPNaWhwOWM5jeBmq0m227TVUoJAhd2CPNT8qqq/ExvKU57FEAuesDShk+yg==
X-Received: by 2002:a05:6102:3c8d:b0:519:534a:6c20 with SMTP id ada2fe7eead31-588f5e88e22mr1579265137.30.1758311234822;
        Fri, 19 Sep 2025 12:47:14 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-57efc591e29sm1308692137.14.2025.09.19.12.47.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 12:47:14 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] fixup! Bluetooth: MGMT: Fix possible UAFs
Date: Fri, 19 Sep 2025 15:47:05 -0400
Message-ID: <20250919194705.2390282-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c      | 81 ++++++++++++++++++++++++++-------------
 net/bluetooth/mgmt_util.c |  7 ++--
 net/bluetooth/mgmt_util.h |  2 +-
 3 files changed, 59 insertions(+), 31 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b9c53810bf06..ee7068fb9fb5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1356,17 +1356,19 @@ static void mgmt_set_powered_complete(struct hci_dev *hdev, void *data, int err)
 static int set_powered_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_pending_cmd *cmd = data;
-	struct mgmt_mode *cp;
+	struct mgmt_mode cp;
 
 	/* Make sure cmd still outstanding. */
 	if (!mgmt_pending_valid(hdev, cmd, false))
 		return -ECANCELED;
 
-	cp = cmd->param;
+	memcpy(&cp, cmd->param, sizeof(cp));
+
+	mutex_unlock(&hdev->mgmt_pending_lock);
 
 	BT_DBG("%s", hdev->name);
 
-	return hci_set_powered_sync(hdev, cp->val);
+	return hci_set_powered_sync(hdev, cp.val);
 }
 
 static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
@@ -1546,6 +1548,8 @@ static int set_discoverable_sync(struct hci_dev *hdev, void *data)
 	if (!mgmt_pending_valid(hdev, data, false))
 		return -ECANCELED;
 
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
 	BT_DBG("%s", hdev->name);
 
 	return hci_update_discoverable_sync(hdev);
@@ -1746,6 +1750,8 @@ static int set_connectable_sync(struct hci_dev *hdev, void *data)
 	if (!mgmt_pending_valid(hdev, data, false))
 		return -ECANCELED;
 
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
 	BT_DBG("%s", hdev->name);
 
 	return hci_update_connectable_sync(hdev);
@@ -1965,19 +1971,21 @@ static void set_ssp_complete(struct hci_dev *hdev, void *data, int err)
 static int set_ssp_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_pending_cmd *cmd = data;
-	struct mgmt_mode *cp;
+	struct mgmt_mode cp;
 	bool changed = false;
 	int err;
 
 	if (!mgmt_pending_valid(hdev, cmd, false))
 		return -ECANCELED;
 
-	cp = cmd->param;
+	memcpy(&cp, cmd->param, sizeof(cp));
 
-	if (cp->val)
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
+	if (cp.val)
 		changed = !hci_dev_test_and_set_flag(hdev, HCI_SSP_ENABLED);
 
-	err = hci_write_ssp_mode_sync(hdev, cp->val);
+	err = hci_write_ssp_mode_sync(hdev, cp.val);
 
 	if (!err && changed)
 		hci_dev_clear_flag(hdev, HCI_SSP_ENABLED);
@@ -2098,15 +2106,17 @@ static void set_le_complete(struct hci_dev *hdev, void *data, int err)
 static int set_le_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_pending_cmd *cmd = data;
-	struct mgmt_mode *cp;
+	struct mgmt_mode cp;
 	u8 val;
 	int err;
 
 	if (!mgmt_pending_valid(hdev, cmd, false))
 		return -ECANCELED;
 
-	cp = cmd->param;
-	val = !!cp->val;
+	memcpy(&cp, cmd->param, sizeof(cp));
+	val = !!cp.val;
+
+	mutex_unlock(&hdev->mgmt_pending_lock);
 
 	if (!val) {
 		hci_clear_adv_instance_sync(hdev, NULL, 0x00, true);
@@ -2169,30 +2179,33 @@ static void set_mesh_complete(struct hci_dev *hdev, void *data, int err)
 static int set_mesh_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_pending_cmd *cmd = data;
-	struct mgmt_cp_set_mesh *cp;
+	struct mgmt_cp_set_mesh cp;
 	size_t len;
 
 	if (!mgmt_pending_valid(hdev, cmd, false))
 		return -ECANCELED;
 
-	cp = cmd->param;
+	memcpy(&cp, cmd->param, sizeof(cp));
+
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
 	len = cmd->param_len;
 
 	memset(hdev->mesh_ad_types, 0, sizeof(hdev->mesh_ad_types));
 
-	if (cp->enable)
+	if (cp.enable)
 		hci_dev_set_flag(hdev, HCI_MESH);
 	else
 		hci_dev_clear_flag(hdev, HCI_MESH);
 
-	hdev->le_scan_interval = __le16_to_cpu(cp->period);
-	hdev->le_scan_window = __le16_to_cpu(cp->window);
+	hdev->le_scan_interval = __le16_to_cpu(cp.period);
+	hdev->le_scan_window = __le16_to_cpu(cp.window);
 
-	len -= sizeof(*cp);
+	len -= sizeof(cp);
 
 	/* If filters don't fit, forward all adv pkts */
 	if (len <= sizeof(hdev->mesh_ad_types))
-		memcpy(hdev->mesh_ad_types, cp->ad_types, len);
+		memcpy(hdev->mesh_ad_types, cp.ad_types, len);
 
 	hci_update_passive_scan_sync(hdev);
 	return 0;
@@ -3927,15 +3940,17 @@ static void set_name_complete(struct hci_dev *hdev, void *data, int err)
 static int set_name_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_pending_cmd *cmd = data;
-	struct mgmt_cp_set_local_name *cp;
+	struct mgmt_cp_set_local_name cp;
 
 	if (!mgmt_pending_valid(hdev, cmd, false))
 		return -ECANCELED;
 
-	cp = cmd->param;
+	memcpy(&cp, cmd->param, sizeof(cp));
+
+	mutex_unlock(&hdev->mgmt_pending_lock);
 
 	if (lmp_bredr_capable(hdev)) {
-		hci_update_name_sync(hdev, cp->name);
+		hci_update_name_sync(hdev, cp.name);
 		hci_update_eir_sync(hdev);
 	}
 
@@ -4126,15 +4141,18 @@ static void set_default_phy_complete(struct hci_dev *hdev, void *data, int err)
 static int set_default_phy_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_pending_cmd *cmd = data;
-	struct mgmt_cp_set_phy_configuration *cp;
+	struct mgmt_cp_set_phy_configuration cp;
 	struct hci_cp_le_set_default_phy cp_phy;
 	u32 selected_phys;
 
 	if (!mgmt_pending_valid(hdev, cmd, false))
 		return -ECANCELED;
 
-	cp = cmd->param;
-	selected_phys = __le32_to_cpu(cp->selected_phys);
+	memcpy(&cp, cmd->param, sizeof(cp));
+
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
+	selected_phys = __le32_to_cpu(cp.selected_phys);
 
 	memset(&cp_phy, 0, sizeof(cp_phy));
 
@@ -5273,6 +5291,8 @@ static int mgmt_add_adv_patterns_monitor_sync(struct hci_dev *hdev, void *data)
 	if (!mgmt_pending_valid(hdev, cmd, false))
 		return -ECANCELED;
 
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
 	return hci_add_adv_monitor(hdev, cmd->user_data);
 }
 
@@ -5860,6 +5880,8 @@ static int start_discovery_sync(struct hci_dev *hdev, void *data)
 	if (!mgmt_pending_valid(hdev, data, false))
 		return -ECANCELED;
 
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
 	return hci_start_discovery_sync(hdev);
 }
 
@@ -6083,6 +6105,8 @@ static int stop_discovery_sync(struct hci_dev *hdev, void *data)
 	if (!mgmt_pending_valid(hdev, data, false))
 		return -ECANCELED;
 
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
 	return hci_stop_discovery_sync(hdev);
 }
 
@@ -6344,16 +6368,19 @@ static void set_advertising_complete(struct hci_dev *hdev, void *data, int err)
 static int set_adv_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_pending_cmd *cmd = data;
-	struct mgmt_mode *cp;
+	struct mgmt_mode cp;
 	u8 val;
 
 	if (!mgmt_pending_valid(hdev, cmd, false))
 		return -ECANCELED;
 
-	cp = cmd->param;
-	val = !!cp->val;
+	memcpy(&cp, cmd->param, sizeof(cp));
 
-	if (cp->val == 0x02)
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
+	val = !!cp.val;
+
+	if (cp.val == 0x02)
 		hci_dev_set_flag(hdev, HCI_ADVERTISING_CONNECTABLE);
 	else
 		hci_dev_clear_flag(hdev, HCI_ADVERTISING_CONNECTABLE);
diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
index be6d9b8db51b..258c22d38809 100644
--- a/net/bluetooth/mgmt_util.c
+++ b/net/bluetooth/mgmt_util.c
@@ -321,7 +321,7 @@ void mgmt_pending_remove(struct mgmt_pending_cmd *cmd)
 }
 
 bool mgmt_pending_valid(struct hci_dev *hdev, struct mgmt_pending_cmd *cmd,
-			bool remove)
+			bool remove_unlock)
 {
 	struct mgmt_pending_cmd *tmp;
 
@@ -332,9 +332,10 @@ bool mgmt_pending_valid(struct hci_dev *hdev, struct mgmt_pending_cmd *cmd,
 
 	list_for_each_entry(tmp, &hdev->mgmt_pending, list) {
 		if (cmd == tmp) {
-			if (remove)
+			if (remove_unlock) {
 				list_del(&cmd->list);
-			mutex_unlock(&hdev->mgmt_pending_lock);
+				mutex_unlock(&hdev->mgmt_pending_lock);
+			}
 			return true;
 		}
 	}
diff --git a/net/bluetooth/mgmt_util.h b/net/bluetooth/mgmt_util.h
index 5aeba4c7b07f..e94738d99290 100644
--- a/net/bluetooth/mgmt_util.h
+++ b/net/bluetooth/mgmt_util.h
@@ -66,7 +66,7 @@ struct mgmt_pending_cmd *mgmt_pending_new(struct sock *sk, u16 opcode,
 void mgmt_pending_free(struct mgmt_pending_cmd *cmd);
 void mgmt_pending_remove(struct mgmt_pending_cmd *cmd);
 bool mgmt_pending_valid(struct hci_dev *hdev, struct mgmt_pending_cmd *cmd,
-			bool remove);
+			bool remove_unlock);
 void mgmt_mesh_foreach(struct hci_dev *hdev,
 		       void (*cb)(struct mgmt_mesh_tx *mesh_tx, void *data),
 		       void *data, struct sock *sk);
-- 
2.51.0

