Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AC546D551
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791296114; cv=none; b=bsepDmRitMJ/Gj0EXn34zAaDWu63JJoGwiy+jxlIUZbKPKIRQh6c8Hf7YPLbM7aPXcl5OvTwCMbQZDcfLOhq9J+TJ6Rz8S/xQ3ly8F+g/GFy7JBko/qnOEQfz/KvncyxSJRahjoc3q3RcxQtY9yi2NFq1MTu9vGG7x36UYDGkic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791296114; c=relaxed/simple;
	bh=84YWTtmEyGAC+3Z54LGlb7hNO1WzMqeQ1fVCZ2tTmwY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mkDBxiGfIIs1M0onXppMOv14SFq2wLs+P5/tgQtS4L6Y6WAhRtt7AVNrwCMMqGb7h4cdMuw9x3D9rWRuoNU82HEKKI3ybtQN1sayprkW6lqoLXgnscrJKeVMqv5FeZkMi9fYofr7atquykCz/sXkU1aiYzIheMABsx+oT/S7eTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvNbKxl1; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvNbKxl1"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7c337cd6694so483671137.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2026 07:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791296111; x=1791900911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=x7PlCVDJgl9TiaCfyqY/MQHJiMHo/D/yJZESFU+qZNY=;
        b=hvNbKxl1wAUF6P1MR2sWsZJHtyLf3nnTXJcdb2aYLfCknrdzJuvOSxU0LawpQYYWDH
         gF8AS1BhpgptwUGubj5sD2MXllfJGWyjjYb6dTOj9D6hpOIZVhSmwsrDH2En9ndJmMI/
         0skSRbWV1qQs3903nrFwTuiYZHTT1Jd/scp0ZONFzuxrK/B5uvFi9aTV6dlzWrgtCtZl
         R86r0l3r+fgubE0hcPznZdvxCp7rl5NSs9HyRNd21IoTKZBR6iFCPZNTii5d6XpmYcaU
         UIqjpARiyPIIKuYvyu3dI27ZKhImPh0KWFjaF3FVVXHMLwIeuuqLUXEdxII5RJ8FU9M1
         ZQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791296111; x=1791900911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=x7PlCVDJgl9TiaCfyqY/MQHJiMHo/D/yJZESFU+qZNY=;
        b=sanKOl90D3n0BbHHFMYTr5D83+ifO0FKLJWME4ieQ03YGBAhmUI2QXDzr2eT9HbSLr
         CGNoyTSwgIKysC+2c9dm3QJyHHceuA7yfYXfhKeHtoZwWu6SrDAtnQZ9f+xJTIN1qakI
         Wdw3JhjT7QIdjMWYO0TiFKKnScLA7xpGfH01ON3OkqbNv45ItpZgwwFSmXC1sqyInMKI
         lUq3Co1sJ8cLuyZ+auEAonRHE6kmkcC7tk+EV95ugKogb7i8Z0u8GPDRHi+2Ysqni9di
         bRWjUYXhJs202gTIVh/4Tri9Uj6qLBw+qwNBZurMiMso+03evR35EOJPqAmvucOFrgqe
         NUDg==
X-Gm-Message-State: AFq9FYJO4fgrQMjmavVmTmXYzPEoY7gPAMZ9UPLaEEPco5dDqqz4rPqb
	qZNnfjCarKmIE63BDZWRUsq74Po/4dLe0XjIh3zoEIzKIIeSKx9tkmcFqGlZBFFE
X-Gm-Gg: AYBFou1WS9I/4fePlaeMtChwEb4k6/iG27WJB9UZkZfJdSXJSZJk0ZQun4AOl9+NeX7
	31S2p66pKAOvDa2KNJDgQp3vlWHXB8fFeLyniAznP2W8WcFSSvVSRB5t+IuyztS1HtLroqJvbLY
	63pYL4pNyS5cM6c69TTDuTi3CbkSnNGT49zPpQe+kC300j1yl/rIp81+mRK7TH7eeWEHF67DXUd
	y84GCABK+hXN6Dfjly7dbSiXEpi8fjHx2qzZ6co7ebWdsnCgykZ879tlcybJthKZSMwxMajPN4D
	xXHBDurBC1C+IGG+wd2+UlJSNAwVElVBigA5Ly6ePu3eJ3pDZX4juJtlvj9HQ02eStDpryOWaXe
	nbzsKnO2YPKdgR3WrCuqFaoV6WdVzcBjAYFzklJEGZqI6CU0s1Ix5vYmO3Xjih38rHnXQ79G6vF
	IMOVyB4ZVKBE8ZtKpm/lAXlN6+lHj+w9jFKGI58RZ+uPIdNMLerUDBLMyj0/nYMhsvT0b6zU38I
	3vwBoHGGAjaJrB4saGLD5GpG966eyvPqKFaDak9L0s/fJL6v8pVIgInUl32+XMGDEzQnJKFpeU=
X-Received: by 2002:a05:6102:1628:b0:7c1:bc57:c7f3 with SMTP id ada2fe7eead31-7c877ced06fmr442116137.5.1791296110419;
        Tue, 06 Oct 2026 07:15:10 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7c0ff5c49a9sm13235132137.4.2026.10.06.07.15.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 07:15:09 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 2/4] Bluetooth: HCI: Fix tracking of instances sharing handle 0x00
Date: Tue,  6 Oct 2026 10:15:00 -0400
Message-ID: <20261006141502.3789138-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006141502.3789138-1-luiz.dentz@gmail.com>
References: <20261006141502.3789138-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When the controller supports a single advertising set, instance 1 uses
handle 0x00 which is the same handle used by instance 0 (Global
Advertising), but hci_cc_le_set_ext_adv_enable would lookup the instance
using the handle as instance identifier, marking instance 0 as
enabled/disabled instead of instance 1, leaving its state out of sync.

Fix this by matching instances by handle and, for handle 0x00, using
hdev->cur_adv_instance, now set when enabling an instance, to determine
which instance owns the set. Also disable the instance sharing the
advertising set of instance 0 before overriding it.

Fixes: e77f43d531af ("Bluetooth: hci_core: Fix not handling hdev->le_num_of_adv_sets=1")
Assisted-by: OpenCode:claude-opus-5.5
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 47 ++++++++++++++++++++++++++++++---------
 net/bluetooth/hci_sync.c  | 35 ++++++++++++++++++++++++++++-
 2 files changed, 70 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2c8f6f22a4ee..9ec6c3c22fbd 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1639,6 +1639,39 @@ static u8 hci_cc_le_set_adv_enable(struct hci_dev *hdev, void *data,
 	return rp->status;
 }
 
+/* Update the enabled state of the instance(s) using the advertising set
+ * identified by handle.
+ *
+ * Instances may share handle 0x00 with instance 0 (Global Advertising), e.g.
+ * when the controller supports a single advertising set, in which case the
+ * set is owned by the instance last enabled (hdev->cur_adv_instance) and any
+ * other instance sharing it shall be considered disabled.
+ */
+static void hci_le_ext_adv_set_enabled(struct hci_dev *hdev, u8 handle,
+				       bool enable)
+{
+	struct adv_info *adv;
+	bool owned = false;
+
+	list_for_each_entry(adv, &hdev->adv_instances, list) {
+		if (adv->handle != handle)
+			continue;
+
+		adv->enabled = enable &&
+			       (handle ||
+				adv->instance == hdev->cur_adv_instance);
+		owned |= adv->enabled;
+	}
+
+	if (handle)
+		return;
+
+	if (enable && !owned)
+		hci_dev_set_flag(hdev, HCI_LE_ADV_0);
+	else
+		hci_dev_clear_flag(hdev, HCI_LE_ADV_0);
+}
+
 static u8 hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev, void *data,
 				       struct sk_buff *skb)
 {
@@ -1660,18 +1693,13 @@ static u8 hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
-	if (cp->num_of_sets)
-		adv = hci_find_adv_instance(hdev, set->handle);
-
 	if (cp->enable) {
 		struct hci_conn *conn;
 
 		hci_dev_set_flag(hdev, HCI_LE_ADV);
 
-		if (adv)
-			adv->enabled = true;
-		else if (!set->handle)
-			hci_dev_set_flag(hdev, HCI_LE_ADV_0);
+		if (cp->num_of_sets)
+			hci_le_ext_adv_set_enabled(hdev, set->handle, true);
 
 		conn = hci_lookup_le_connect(hdev);
 		if (conn)
@@ -1680,10 +1708,7 @@ static u8 hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev, void *data,
 					   conn->conn_timeout);
 	} else {
 		if (cp->num_of_sets) {
-			if (adv)
-				adv->enabled = false;
-			else if (!set->handle)
-				hci_dev_clear_flag(hdev, HCI_LE_ADV_0);
+			hci_le_ext_adv_set_enabled(hdev, set->handle, false);
 
 			/* If just one instance was disabled check if there are
 			 * any other instance enabled, including instance 0,
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 19917aa49cb2..c5768069ee39 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1156,6 +1156,30 @@ int hci_update_random_address_sync(struct hci_dev *hdev, bool require_privacy,
 	return 0;
 }
 
+/* Check if the advertising set with handle 0x00 is in use, either by instance
+ * 0 or by an instance sharing its advertising set.
+ */
+static bool hci_ext_adv_handle_0_enabled(struct hci_dev *hdev)
+{
+	struct adv_info *adv;
+	bool enabled;
+
+	hci_dev_lock(hdev);
+
+	enabled = hci_dev_test_flag(hdev, HCI_LE_ADV_0);
+
+	list_for_each_entry(adv, &hdev->adv_instances, list) {
+		if (!adv->handle && adv->enabled) {
+			enabled = true;
+			break;
+		}
+	}
+
+	hci_dev_unlock(hdev);
+
+	return enabled;
+}
+
 int hci_disable_ext_adv_legacy_instance_sync(struct hci_dev *hdev)
 {
 	struct hci_cp_le_set_ext_adv_enable *cp;
@@ -1163,7 +1187,7 @@ int hci_disable_ext_adv_legacy_instance_sync(struct hci_dev *hdev)
 	u8 data[sizeof(*cp) + sizeof(*set) * 1];
 	u8 size;
 
-	if (!hci_dev_test_flag(hdev, HCI_LE_ADV_0))
+	if (!hci_ext_adv_handle_0_enabled(hdev))
 		return 0;
 
 	memset(data, 0, sizeof(data));
@@ -1409,6 +1433,9 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 			return -EINVAL;
 		}
 	} else {
+		/* Disable the advertising set with handle 0x00, including any
+		 * instance sharing it, since it is going to be overridden.
+		 */
 		err = hci_disable_ext_adv_legacy_instance_sync(hdev);
 		if (err)
 			return err;
@@ -1676,6 +1703,12 @@ int hci_enable_ext_advertising_sync(struct hci_dev *hdev, u8 instance)
 		set->duration = cpu_to_le16(duration / 10);
 	}
 
+	/* Track which instance owns the advertising set since the handle
+	 * alone is ambiguous when instances share handle 0x00, see
+	 * hci_cc_le_set_ext_adv_enable.
+	 */
+	hdev->cur_adv_instance = instance;
+
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_ENABLE,
 				     sizeof(*cp) +
 				     sizeof(*set) * cp->num_of_sets,
-- 
2.55.0

