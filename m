Received: from mail-vs2-f36.google.com (mail-vs2-f36.google.com [74.125.227.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCA43A961B
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 20:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791233073; cv=none; b=dimr1dFmr4hlLbCrTxKu4zaPSjl6qFZZY7nH6CNJ2e18bwkRVqmZjG83U7vrEhtg2flUlu4nbOLGtUcSR7+7qTTK1dfa1RsQUHFDvc3IgACFwojnljC46M9F+nq0/TDuuOaTUtafxdW5s6Hbx3Vx4ebYI7TPeMFJeHK0FibXRuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791233073; c=relaxed/simple;
	bh=wNTWGfu0N0OsPVVopKb38qzKKjISUpDc9wrSlTdtOZ4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqr9nB+VUCjdRb0m2Nl0QK3PjARiKs/ruqaC68sLeXcR2R1Qok033vGa+AH/6TEpWurF23LUec8BDrlLM3HSESbJQXeaZqpK9+7qp3F5j8RTT69TDLOaq6qipJg3cQxdTjhxnf9LlJsZUj2z2pScZPgpTXEfFpepcAhgAFEkoKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drhpJgGD; arc=none smtp.client-ip=74.125.227.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drhpJgGD"
Received: by mail-vs2-f36.google.com with SMTP id ada2fe7eead31-7bf43e81472so747516137.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2026 13:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791233070; x=1791837870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KBaSispQRg5EHiU1ZpCNH0FWQcAVDELsDWRCMMlynxM=;
        b=drhpJgGDBr9UjjkU2CYQ5220tV3uBG61+ejK1lAY+1c/NrLu/Dpu+Cx53i47/PqQdJ
         yX3a3iWqqh4YUZe+vDlRzTCo2r+5bUh4wrDMt+R7EcjXTdVG9n7Z6+BMgH22jSWqbClt
         05j5PeUeZAN5ItYGXOeH+CsQR4J3A0Eqnhy0asuVEoQvstuSre3x0TrFuw9u9VkvfQTx
         WH0XZDSn3AFJ8Fzqhaen4gTndDaCQsOIHv7deL5LLzVC0hHrSojHP414+F4j3jKOTJ5e
         qZv5h2IPPP1hmk1z7qj0OKKmPXRIwZE+2T5A+dQ9xXSZjFKQEofhxAruEtcJc11V55S7
         vv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791233070; x=1791837870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KBaSispQRg5EHiU1ZpCNH0FWQcAVDELsDWRCMMlynxM=;
        b=Pf/z22Mo1Nrx2Y3EgMomiHzo4w06X5kqcn4Zox3ySj/KE4JqRQjzsN1Eepcezjgvwa
         vXC25xbrJHIn0rZnuM7H7JxW0Z/+bxB+1ev24zlaOk4Se1ttSt3abT6fZ28A6dR4AzUZ
         7/uEnzkdKNBAYrexop99WmOyfvXa8qdHrpfGPcMotvg/iQNExB8IoUe+xKKJfnQmhI05
         4n3LCHH3ZuH9Ov9qaFcYC7P4HTRwXBM8zUk9Ayto0DvSQNIkKZZWZJ3oshELbsv+cmBU
         rvXkrL0BQhQxLOyB+7HfwCxxU/FgK5vNs8f0sb90R3kBSDAHEDTEPAl73Nijn7F6y0En
         nY+g==
X-Gm-Message-State: AFq9FYI+FS/Fw6qfpcF5EECXaMt5tKc8tEPGRV6ZyMJUtsK10t6aybfX
	C5ZP3ZQMXllCeVpZgux2UeHh0JP84R2rL5lt5AcMFL871o3+QKkp3jtdozzd1Q6S
X-Gm-Gg: AYBFou0M10F5VpWa0BMwPKWQPcQqJS/KV+xXICH268TQiMCj/2IpuItqiZSHqngxxFE
	TUCbYXWBoExlgsZLJzy04CKZCJyOm/Wk4nQ/BU0LGe5wQZpTVzjstkdHkztYIF5xMcvtyg0N737
	C3ZLP2MjZ9TeaDJpT6R/qKm0Yfh3aTHJSBH5CpDlVyG1LgRjjirI5hSlR6cNt/rdjhYTvK4wU10
	9lR+dBqEA+lb/qpn2N5S64elBfB57kJEUUAgqO1DjOcZk11l3bYyCj/hg9QZcsYcXHB0m280Njw
	5kfhFVBeAH2/rK5JggQbqT1DAP/WHhmNMYRzaiL4+ewvQwR0QuAkj0TKPybsl2O2pW9AxtnCtcb
	E9TS636ldGrBROnwgliCTnCCQl+QuiQZMn4fD65ISdoExkuXbKerZGTeneFK34eKTboShVZvfhl
	2Ng+uz00u3VBbznUkpd6IyozMD2Dvny/qCGcE1ykT+BkwvXuCu86lw+1FqLWAlRQ4XATrNhbz9U
	UUtwfm9ZzZu5lc19AOuoOZDz7ggqfsydptH+zr6IIFRcyI8n1o3Zb8xVbbfCV1+09kUwp3OFoo=
X-Received: by 2002:a05:6102:c13:b0:7b3:2a2b:ca0c with SMTP id ada2fe7eead31-7c0f4c9c15bmr2310577137.21.1791233070216;
        Mon, 05 Oct 2026 13:44:30 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5e54ffb92a5sm531789e0c.18.2026.10.05.13.44.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 13:44:29 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 2/4] Bluetooth: HCI: Fix tracking of instances sharing handle 0x00
Date: Mon,  5 Oct 2026 16:44:18 -0400
Message-ID: <20261005204420.3684587-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005204420.3684587-1-luiz.dentz@gmail.com>
References: <20261005204420.3684587-1-luiz.dentz@gmail.com>
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

