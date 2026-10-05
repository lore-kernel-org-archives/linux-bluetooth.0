Received: from mail-ua2-f43.google.com (mail-ua2-f43.google.com [74.125.226.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33433469847
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 20:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791230402; cv=none; b=VZp5US/6SyohTnPvhMs3wfhhtRQKda44/rV3VPu9W9VL2JZvv89XvwA0RsyZ2nII4LnQ1NVY+Vc43vSpwGzM+Tds6Xxaw6pIzxWMrlfSgV1VMBsU41/OWYKhyKkvSmyn/Lvtarr/rzPeJD8uhyFeU0qRHGkj9moJ+Cm6VMZMPdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791230402; c=relaxed/simple;
	bh=wNTWGfu0N0OsPVVopKb38qzKKjISUpDc9wrSlTdtOZ4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TbbNp4+hADXdZOmrUPa7Q2pDGl8Gu9qxzSTYPSNmAXQIFH+kEGGrVKaav+2I4R2tL/m6u7kJWxwOUSIgcPhffzP8y/zF75Ts6Sln8cmrMwFMneowiN2utPDrUTkE7yNlAmZPRs0+CH2lRn5/YICt8Myss//XXb3AeJWRb0Xs5TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njqXoGn5; arc=none smtp.client-ip=74.125.226.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njqXoGn5"
Received: by mail-ua2-f43.google.com with SMTP id a1e0cc1a2514c-98514b4115eso1256725241.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2026 13:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791230400; x=1791835200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KBaSispQRg5EHiU1ZpCNH0FWQcAVDELsDWRCMMlynxM=;
        b=njqXoGn53k5etG6cUa0KqX113Rdf3cznK3mKPOa5lC5rN6pjr9N48lNCNfIeJXBbo/
         MzK86LXzKPSUzpBEyo3/E1Bu674gNcmdYFX3l3TsSY6Llc36I+kfses74wkHJHG2Btmz
         9Orbow31yuqm4G8y/toBGtVcHPT5sm3XYLOKBgyP1E0nnTsItnlNiDv3DS035/Tb0BbP
         iNuHXA2oUPlzwVhigvaEQAY/3+De7d9mQxpm6XuzBcLqOC3xFfhmyxE5rIrucc2iBT3D
         UVKkX3GZNaSg59fsrI0ytJKVOp0QrQb1zIR8WxP5By9sMOP7GW/wxetJXx4x+PE6Z3yn
         U0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791230400; x=1791835200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KBaSispQRg5EHiU1ZpCNH0FWQcAVDELsDWRCMMlynxM=;
        b=OV2XJsMYi9ua7nEuV5jvLs4A3gj5+8I6XJfATTgBJX6ED5+F3ssjbUjC9f4bzK3LU+
         u1G/Z/MG8rk/geNDKQRr4197cWt2X37gkVxFUG/8oJ9BfhoDZU+TTAMcNu57+h/XLRX7
         ot8KIZzvK4BSHNe2D4k1Xx4tI0kIDRnP00xW9+oCWVxb4V71dxxRK/SonLXzxx3dP+cR
         ivQuhxCfVUKB4oxzfsHjoJncGzrRgd37hjgi1zlxjSDBesrigsMSp5p51HrIZZOV9g18
         fp4usZ2rHzUuRoJSDyT/berHkB2vWZj0uocQ+F1CyFcKpbUYquv99AiM1lZUgcFwIetb
         v3Vw==
X-Gm-Message-State: AFq9FYITskRJH9IYDQus/EIksK6kCejn3XiCPpZWvgCidZTypkVkGTem
	U7s9VIQbK1PfJhJKaQTKN1mXbClIgbykEkqw41/NkwwG0nEOR+DKhYidbiAJ7yUH
X-Gm-Gg: AYBFou10hWrt4aWM5D+X8yAuWwDHODtRDrgUVZXyC+GVTVUBrT8MbgahprUvzbd9tNb
	pHzt9I3U7VCBG3fidrjMxUeb2Rkq880uSfOowufI/lmURjxhqy0XsT4OaiHajMPj5iOpiIc4Cs1
	vOLjs1TFSQW0Olf3KIzET9ptOnubvEZXA4paEUoeGSzsJhWxl4v72QVk58zVBzjHwV1NeAVwOU2
	mE6f/FL/Va+Cl25Ia0orgE4hzttO94N2EEHi0T7rxdVaqPpuEojenZH4Db6JvstmGzSuDv7ovSZ
	dixuosXyanuvN/bpxIQkapBCgj2pV7HLeTHTTgIZkmgPx2Iun7VAjN+sgCnJQ/ruhDBPx2cGuBa
	UtsneRxgQcQqy/jGW1w3RupCBjX0+eDF00nUrFy4nzTPsh0cA7YpmLUxzBXzUR0WBIKREwS5ajE
	03TTsgD14GbyzYJ8qh30GOcNoN+cfu8jbE4MwKiWi4Ijc+NmCAnRhzEegRfolt7gvwI/Tb4TKzy
	DRCoV1A+H5VpxhxCQeG+Y6wQfqx0cpb+PY8ZKNlR2c/3rGbRIEtL0d7odpPQb7lPMsJIgGPOYg=
X-Received: by 2002:a05:6102:688f:b0:7a5:391c:37ac with SMTP id ada2fe7eead31-7c0f3d4f016mr3627860137.10.1791230399762;
        Mon, 05 Oct 2026 12:59:59 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7c0ffaeb6d0sm11197180137.6.2026.10.05.12.59.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 12:59:59 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/4] Bluetooth: HCI: Fix tracking of instances sharing handle 0x00
Date: Mon,  5 Oct 2026 15:59:46 -0400
Message-ID: <20261005195948.3616794-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005195948.3616794-1-luiz.dentz@gmail.com>
References: <20261005195948.3616794-1-luiz.dentz@gmail.com>
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
 net/bluetooth/hci_sync.c  | 32 ++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 11 deletions(-)

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
index 19917aa49cb2..5f963e577525 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1413,6 +1413,32 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 		if (err)
 			return err;
 
+		/* Disable any instance sharing the advertising set of
+		 * instance 0 since it is going to be overridden.
+		 *
+		 * Lookup the instance while holding hdev->lock but don't
+		 * hold it while sending the HCI command.
+		 */
+		instance = 0x00;
+
+		hci_dev_lock(hdev);
+		list_for_each_entry(adv, &hdev->adv_instances, list) {
+			if (!adv->handle && adv->enabled) {
+				instance = adv->instance;
+				break;
+			}
+		}
+		hci_dev_unlock(hdev);
+
+		if (instance) {
+			err = hci_disable_ext_adv_instance_sync(hdev,
+								instance);
+			if (err)
+				return err;
+
+			instance = 0x00;
+		}
+
 		adv = NULL;
 	}
 
@@ -1676,6 +1702,12 @@ int hci_enable_ext_advertising_sync(struct hci_dev *hdev, u8 instance)
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

