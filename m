Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75696188A3A
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 01:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760405616; cv=none; b=cyYTDMI/KUH3+DpnsdeMT6aVwlqxFHiDtsAQrrn9m2AN34p4vVOEFaNa0OLYM+ul38jfN2TuHNJQm4FADxqmhQYVDmUKCLl6NF1h0JtZ0nkaBjBCUX5OX3rfyX/ekRb9JGG3Tl6W3mlwYE/T/7YRjMqPL05UdFzbY1PzqmnoCiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760405616; c=relaxed/simple;
	bh=UBMRp6Jjh660XtjlwTTcai7RutsCR9QowRCiUNMYKrs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbVRHg//sg8kHFQddWVcihZ4yRgagET2cglUgAaT+/Ci/qm3jvw3uUWZElleJ3xgwNvEsRpcfIpp6DvDY5WtbVjLLLo3Nos+/JeB9BcnHJxiASjdq4sD5oXQO4b4IzMKXHuLJgCvxHnKzpt52q8HNpEmLho3SNE9q9wXdSDIK7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RjsTYksh; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjsTYksh"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-8e364003538so3284763241.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 18:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760405613; x=1761010413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JLYAKgggyCmXjc/RkTJJori6OrmTTwYiWBrru3y6AEI=;
        b=RjsTYkshRfDESvIDGIw4dkJ/OP973TsYEMCjjBqS+IIMW5cbV1n/yB9hSjJyg32zLa
         6ham9NIYJcAkn+jH//l3sSvaBwdbybcDHG6EFiWu6a3UYpO2pUqWKvlGOEoJxGE5f25J
         xJsT0ORiy4t4C3B3YoCI5MigAb7jJ5PycyyIo6V/CKOK+xcHP6Mt9uoacEYK9HFYNH0m
         LnGk08VMgV7m1IVtITncRHHSgwjWwviyeD/rejU31eihSNQuUushEPWDwm7qjgEengIv
         iy2gnZHC6Ei6HSC2IE8WYgiK+emCizDhU0V98plimq8bAMtCEwM8hS6/AD+DXCcdfuyX
         ON8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760405613; x=1761010413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLYAKgggyCmXjc/RkTJJori6OrmTTwYiWBrru3y6AEI=;
        b=N217rbl6NP0RKsyfr3fmFM5pnXwLLGC9O+3H/ntmKwtKXPwKNn2LGETDQ/AlFDNXlx
         aZBYMELqRsNiZsAl99NVsmZXfURfM3VfqkI7V07PCh9KiRyuQym2imR64G6jJKllKlkT
         AfJMwevx+iP4dXn7n8gSp2o2M6joMW/w5PDQMPbdIWLEYBvo3/opAguOoisE7j+FEkX4
         LHD0ZdV6MV736ZEFCtdOSIAK93LvjD9z39LTJ2tFBQCy3l1eLamdY9HI1UF6jIRMEpns
         Ow9GdGJyTh40GJtJOsywT4RbgnAViXTmuRg/nlKoKLXSsEOUGg7NMyelu7TK5t5854VV
         qn4g==
X-Gm-Message-State: AOJu0Yw5L5t4HzqsGqppWe/mUVdG9NwuJcUMaElob3Thz61wkXpCtIHU
	SNMiN2EkdpmUeIGA+z0llCLJ58jxcSAUmO7nEsAJOPTs2ueWdlcD03SkNDAMHdyz
X-Gm-Gg: ASbGnctGjWeQNaFyEO4aOLHfsD26RKmDpVYDPDV/uvzAkUBf6dwUCNKpM0w+PFn2z/L
	tsK4GIMbT0/St9CYwq8fZzLLKHToji+/8w8TTHK1RXltYp+QGzqx38b8Fq6rxTjxRst9iLyZyst
	ndMGSi19V4bd0+E8Jy1hNdRkSdTpm3IbYArrIn/JQZhYpbt/1MXsDVsObYi/zL28w7EImcIebN6
	bvccGEjMAL2gBeXWBcrUJsrLfo2K/RCU59tN3otb/vbEdhzsj0YHZLfistWZ9PAFBTRBWntQo5t
	RMvnGRlFFokVi8Hxv5fGHyhtvlBZGpt51JtYDjrrj3gANvh/kBYyYcpLVanNtYQIfnBbGwQNUJL
	lYuYybI8A6BdF3//of//ZOKSEfKWYSCJyGiofJGRK3pWNyNHpbdQ7tDyFSjj8xWW2wk9UU+cw/d
	9Vmp4J1cBs
X-Google-Smtp-Source: AGHT+IFWAV36yLQdH3/453HcDn1ml21/9avZTIgR3KppPTgvDpiIcbWtP+z31YWXe1o4PyD8CPYCwg==
X-Received: by 2002:a05:6102:4187:b0:5d3:fef5:8724 with SMTP id ada2fe7eead31-5d5e2352439mr9270129137.26.1760405612694;
        Mon, 13 Oct 2025 18:33:32 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d5fc7126c7sm3985806137.5.2025.10.13.18.33.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 18:33:32 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 6/8] Bluetooth: MGMT: Allow use of Set Device Flags without Add Device
Date: Mon, 13 Oct 2025 21:33:06 -0400
Message-ID: <20251014013308.174151-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014013308.174151-1-luiz.dentz@gmail.com>
References: <20251014013308.174151-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In certain cases setting devices flags like HCI_CONN_FLAG_PAST it
shouldn't require to do Add Device first since it may not need to add
an auto-connect policy, so this instead just automatically creates
a hci_conn_params if one cannot be found using HCI_AUTO_CONN_DISABLED.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 148 ++++++++++++++++++++++---------------------
 1 file changed, 76 insertions(+), 72 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 740ecb60219c..78b7af8bf45f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5122,6 +5122,69 @@ static void device_flags_changed(struct sock *sk, struct hci_dev *hdev,
 	mgmt_event(MGMT_EV_DEVICE_FLAGS_CHANGED, hdev, &ev, sizeof(ev), sk);
 }
 
+static bool is_connected(struct hci_dev *hdev, bdaddr_t *addr, u8 type)
+{
+	struct hci_conn *conn;
+
+	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, addr);
+	if (!conn)
+		return false;
+
+	if (conn->dst_type != type)
+		return false;
+
+	if (conn->state != BT_CONNECTED)
+		return false;
+
+	return true;
+}
+
+/* This function requires the caller holds hdev->lock */
+static struct hci_conn_params *hci_conn_params_set(struct hci_dev *hdev,
+						   bdaddr_t *addr, u8 addr_type,
+						   u8 auto_connect)
+{
+	struct hci_conn_params *params;
+
+	params = hci_conn_params_add(hdev, addr, addr_type);
+	if (!params)
+		return NULL;
+
+	if (params->auto_connect == auto_connect)
+		return params;
+
+	hci_pend_le_list_del_init(params);
+
+	switch (auto_connect) {
+	case HCI_AUTO_CONN_DISABLED:
+	case HCI_AUTO_CONN_LINK_LOSS:
+		/* If auto connect is being disabled when we're trying to
+		 * connect to device, keep connecting.
+		 */
+		if (params->explicit_connect)
+			hci_pend_le_list_add(params, &hdev->pend_le_conns);
+		break;
+	case HCI_AUTO_CONN_REPORT:
+		if (params->explicit_connect)
+			hci_pend_le_list_add(params, &hdev->pend_le_conns);
+		else
+			hci_pend_le_list_add(params, &hdev->pend_le_reports);
+		break;
+	case HCI_AUTO_CONN_DIRECT:
+	case HCI_AUTO_CONN_ALWAYS:
+		if (!is_connected(hdev, addr, addr_type))
+			hci_pend_le_list_add(params, &hdev->pend_le_conns);
+		break;
+	}
+
+	params->auto_connect = auto_connect;
+
+	bt_dev_dbg(hdev, "addr %pMR (type %u) auto_connect %u",
+		   addr, addr_type, auto_connect);
+
+	return params;
+}
+
 static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 			    u16 len)
 {
@@ -5165,9 +5228,16 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 	params = hci_conn_params_lookup(hdev, &cp->addr.bdaddr,
 					le_addr_type(cp->addr.type));
 	if (!params) {
-		bt_dev_warn(hdev, "No such LE device %pMR (0x%x)",
-			    &cp->addr.bdaddr, le_addr_type(cp->addr.type));
-		goto unlock;
+		/* Create a new hci_conn_params if it doesn't exist */
+		params = hci_conn_params_set(hdev, &cp->addr.bdaddr,
+					     le_addr_type(cp->addr.type),
+					     HCI_AUTO_CONN_DISABLED);
+		if (!params) {
+			bt_dev_warn(hdev, "No such LE device %pMR (0x%x)",
+				    &cp->addr.bdaddr,
+				    le_addr_type(cp->addr.type));
+			goto unlock;
+		}
 	}
 
 	supported_flags = hdev->conn_flags;
@@ -7554,68 +7624,6 @@ static int get_clock_info(struct sock *sk, struct hci_dev *hdev, void *data,
 	return err;
 }
 
-static bool is_connected(struct hci_dev *hdev, bdaddr_t *addr, u8 type)
-{
-	struct hci_conn *conn;
-
-	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, addr);
-	if (!conn)
-		return false;
-
-	if (conn->dst_type != type)
-		return false;
-
-	if (conn->state != BT_CONNECTED)
-		return false;
-
-	return true;
-}
-
-/* This function requires the caller holds hdev->lock */
-static int hci_conn_params_set(struct hci_dev *hdev, bdaddr_t *addr,
-			       u8 addr_type, u8 auto_connect)
-{
-	struct hci_conn_params *params;
-
-	params = hci_conn_params_add(hdev, addr, addr_type);
-	if (!params)
-		return -EIO;
-
-	if (params->auto_connect == auto_connect)
-		return 0;
-
-	hci_pend_le_list_del_init(params);
-
-	switch (auto_connect) {
-	case HCI_AUTO_CONN_DISABLED:
-	case HCI_AUTO_CONN_LINK_LOSS:
-		/* If auto connect is being disabled when we're trying to
-		 * connect to device, keep connecting.
-		 */
-		if (params->explicit_connect)
-			hci_pend_le_list_add(params, &hdev->pend_le_conns);
-		break;
-	case HCI_AUTO_CONN_REPORT:
-		if (params->explicit_connect)
-			hci_pend_le_list_add(params, &hdev->pend_le_conns);
-		else
-			hci_pend_le_list_add(params, &hdev->pend_le_reports);
-		break;
-	case HCI_AUTO_CONN_DIRECT:
-	case HCI_AUTO_CONN_ALWAYS:
-		if (!is_connected(hdev, addr, addr_type))
-			hci_pend_le_list_add(params, &hdev->pend_le_conns);
-		break;
-	}
-
-	params->auto_connect = auto_connect;
-
-	bt_dev_dbg(hdev, "addr %pMR (type %u) auto_connect %u",
-		   addr, addr_type, auto_connect);
-
-	return 0;
-}
-
 static void device_added(struct sock *sk, struct hci_dev *hdev,
 			 bdaddr_t *bdaddr, u8 type, u8 action)
 {
@@ -7727,17 +7735,13 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 	/* If the connection parameters don't exist for this device,
 	 * they will be created and configured with defaults.
 	 */
-	if (hci_conn_params_set(hdev, &cp->addr.bdaddr, addr_type,
-				auto_conn) < 0) {
+	params = hci_conn_params_set(hdev, &cp->addr.bdaddr, addr_type,
+				     auto_conn);
+	if (!params) {
 		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_ADD_DEVICE,
 					MGMT_STATUS_FAILED, &cp->addr,
 					sizeof(cp->addr));
 		goto unlock;
-	} else {
-		params = hci_conn_params_lookup(hdev, &cp->addr.bdaddr,
-						addr_type);
-		if (params)
-			current_flags = params->flags;
 	}
 
 	cmd = mgmt_pending_new(sk, MGMT_OP_ADD_DEVICE, hdev, data, len);
-- 
2.51.0

