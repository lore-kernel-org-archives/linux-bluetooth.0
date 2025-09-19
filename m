Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83F7256C70
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Sep 2025 19:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758309748; cv=none; b=s5CT48sG3UMdUFDtma0VsGnpSCmerhRSDSmQgJ+KeA5jTMVMYelWJ+kcPdFEjztve1rDEDYDmUEuOgCh7qghc6vIf+DoUMp6JrujGeKk5E3K4hzD1J1x24VeQKdUQt8rjGj/LMlK+j6TlbE3NRNgN4NApPRRUFFhXiIuPSRqJaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758309748; c=relaxed/simple;
	bh=ea3ivsncHmFrHJRfs/pN/L3lYIBA+nVAtNBD8y7he3Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Un0RiOxv3Ytao5sYDAnVYxuq1+C2rN/a1KGOZoRQMhAVrpXdtnVSdGi4EykXgzoI7v0hbwC5tFtW5jiKgqRKnXjZzost5ApgtDD9ZZ5Hv9rgEJPBsCfUknXKDkLehTKtlvEk5dXLgMbCOYLJ6dTslhyA7/1kDVN7f+9c5wBtrhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OB7nLHPh; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OB7nLHPh"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-50f8bf5c518so1851115137.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Sep 2025 12:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758309745; x=1758914545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=e1P0RtEa6t27SoGABOnQMD5mcT/MYHJwExqh2nCz0Os=;
        b=OB7nLHPh2eZab0KX2ZZLp/1J3HrwL0vebK59zVKdmLtDO3y46cLGPI1dOBz41vnAJf
         Vs+zTbQqY7L/22N7MU7J0+vVJJbFL+A9QADVLa+QtYk8WvswHD8j2/ezztp4tm65gl8n
         iSxcDLC0LjdazjWmxZ86n94zXrJeCDhn8aXJNLHdCiomv9kG5RvJJPqsiYoNmtkb9cCm
         oQIk2UG9drN1oBO6y571XKDZWv0qBZHyoyenpixczt7prWyAeriwGtk9D5OOUwGd08wS
         xRv0dyUTcvOK1RcLVRtd3KZmXCLKXSYN8RMP1YOqbYumXSbzdIoqRVCM2TRSiXF6+7KZ
         gpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758309745; x=1758914545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e1P0RtEa6t27SoGABOnQMD5mcT/MYHJwExqh2nCz0Os=;
        b=mPwoJoqeA7WtWz+AlBzSbvp0AT063nP8gwxW8ZPDRxsCAp4yiAqOkLN8o0B7Rz5U+i
         V5lx2t1I9PAbMEjbzomVFvVlzQZKtL/zLM1PNCU0gZWGTKwoWluJ/pr03AFNWgPw9cp1
         fQAXBxydv31qsdOS2K+43md0j74rMBzrSSgMhYyGN41MN8fPFRJvfv2ZZNHi6fTDbX82
         qlG9eaowcRyExvo84yqLtuMLMQW8Eq+Xog234EAB71g+Y8jS4YSU/f3Kx08RtYBN10Jy
         Ad0fDmNL0Sjp6vw17E102/rZqqZ/INHmSvRWivwR6UGh+AH/ZMlAv+yBZ8yrlGRJGcM3
         e/Gw==
X-Gm-Message-State: AOJu0Ywjs+pIHCaBbPXvwpJQyhYR0GGJRAzHyEDORgaDyk9K2aAkv/qM
	xByTA9FDMQ6ghp62MPX68AYjOLrFaxmnl/ypcbYQGSrrGt3icCHM9pIU1hF3wVZE
X-Gm-Gg: ASbGnctI2xnEvSWJcN+MYnJIo7Fl6bFvHGfmuO9vmquEep3cwRS7kyFVQH/gf2oUaAL
	Kye26mnTKy+hsaioHJAWEOyaSlPeX+FpamY7KLoCS4D8L7kv4WnvuQkrwGsdJ+PHmKeGDKNd9Q5
	6vGbRJRNf6FmTgklgFOcMSAR6CxFmhL2Lb7z7CshK810ECQEagzfzDp/SIykKjiEkNRvSD/NaeY
	utYggGfHB0l/jEey5WNGTmYIC+BIYlVXHWclIZPYfJqBHDf0eW9i8Nxk8eq8GVSQ4pEz4PfiyKa
	PAnnLesH6eDbyV9arFypmArOXCXFOPsGX6x2lbHgGf2ofAeCLMAQedmyhvA8tqe9maAY+TJTDab
	NFP3gihY5O4PCK89vi6dHRAELv3638zmPWCRtGwgftejoBMusqsb+DUkMB8dDEKdyLw==
X-Google-Smtp-Source: AGHT+IF+NctWTN94P3HF+fudV+ffOtIo8R0qfV6HibFkBT2zAg3THGJQOaCM1nspZUR1ogDtyR8T5w==
X-Received: by 2002:a05:6102:3ec4:b0:52f:12b3:4505 with SMTP id ada2fe7eead31-588f0af3c22mr1539257137.23.1758309744879;
        Fri, 19 Sep 2025 12:22:24 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-57a05ef52b3sm1559865137.13.2025.09.19.12.22.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 12:22:24 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] fixup! Bluetooth: MGMT: Fix possible UAFs
Date: Fri, 19 Sep 2025 15:22:13 -0400
Message-ID: <20250919192213.2371373-1-luiz.dentz@gmail.com>
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
 net/bluetooth/mgmt.c      | 29 ++++++++++++++++++++++++++++-
 net/bluetooth/mgmt_util.c |  7 ++++---
 net/bluetooth/mgmt_util.h |  2 +-
 3 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b9c53810bf06..91920584a551 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1357,6 +1357,7 @@ static int set_powered_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_pending_cmd *cmd = data;
 	struct mgmt_mode *cp;
+	int err;
 
 	/* Make sure cmd still outstanding. */
 	if (!mgmt_pending_valid(hdev, cmd, false))
@@ -1366,7 +1367,11 @@ static int set_powered_sync(struct hci_dev *hdev, void *data)
 
 	BT_DBG("%s", hdev->name);
 
-	return hci_set_powered_sync(hdev, cp->val);
+	err = hci_set_powered_sync(hdev, cp->val);
+
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
+	return err;
 }
 
 static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
@@ -1546,6 +1551,8 @@ static int set_discoverable_sync(struct hci_dev *hdev, void *data)
 	if (!mgmt_pending_valid(hdev, data, false))
 		return -ECANCELED;
 
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
 	BT_DBG("%s", hdev->name);
 
 	return hci_update_discoverable_sync(hdev);
@@ -1746,6 +1753,8 @@ static int set_connectable_sync(struct hci_dev *hdev, void *data)
 	if (!mgmt_pending_valid(hdev, data, false))
 		return -ECANCELED;
 
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
 	BT_DBG("%s", hdev->name);
 
 	return hci_update_connectable_sync(hdev);
@@ -1979,6 +1988,8 @@ static int set_ssp_sync(struct hci_dev *hdev, void *data)
 
 	err = hci_write_ssp_mode_sync(hdev, cp->val);
 
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
 	if (!err && changed)
 		hci_dev_clear_flag(hdev, HCI_SSP_ENABLED);
 
@@ -2108,6 +2119,8 @@ static int set_le_sync(struct hci_dev *hdev, void *data)
 	cp = cmd->param;
 	val = !!cp->val;
 
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
 	if (!val) {
 		hci_clear_adv_instance_sync(hdev, NULL, 0x00, true);
 
@@ -2190,6 +2203,8 @@ static int set_mesh_sync(struct hci_dev *hdev, void *data)
 
 	len -= sizeof(*cp);
 
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
 	/* If filters don't fit, forward all adv pkts */
 	if (len <= sizeof(hdev->mesh_ad_types))
 		memcpy(hdev->mesh_ad_types, cp->ad_types, len);
@@ -3939,6 +3954,8 @@ static int set_name_sync(struct hci_dev *hdev, void *data)
 		hci_update_eir_sync(hdev);
 	}
 
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
 	/* The name is stored in the scan response data and so
 	 * no need to update the advertising data here.
 	 */
@@ -4162,6 +4179,8 @@ static int set_default_phy_sync(struct hci_dev *hdev, void *data)
 	if (selected_phys & MGMT_PHY_LE_CODED_RX)
 		cp_phy.rx_phys |= HCI_LE_SET_PHY_CODED;
 
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
 	cmd->skb =  __hci_cmd_sync(hdev, HCI_OP_LE_SET_DEFAULT_PHY,
 				   sizeof(cp_phy), &cp_phy, HCI_CMD_TIMEOUT);
 
@@ -5273,6 +5292,8 @@ static int mgmt_add_adv_patterns_monitor_sync(struct hci_dev *hdev, void *data)
 	if (!mgmt_pending_valid(hdev, cmd, false))
 		return -ECANCELED;
 
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
 	return hci_add_adv_monitor(hdev, cmd->user_data);
 }
 
@@ -5860,6 +5881,8 @@ static int start_discovery_sync(struct hci_dev *hdev, void *data)
 	if (!mgmt_pending_valid(hdev, data, false))
 		return -ECANCELED;
 
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
 	return hci_start_discovery_sync(hdev);
 }
 
@@ -6083,6 +6106,8 @@ static int stop_discovery_sync(struct hci_dev *hdev, void *data)
 	if (!mgmt_pending_valid(hdev, data, false))
 		return -ECANCELED;
 
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
 	return hci_stop_discovery_sync(hdev);
 }
 
@@ -6358,6 +6383,8 @@ static int set_adv_sync(struct hci_dev *hdev, void *data)
 	else
 		hci_dev_clear_flag(hdev, HCI_ADVERTISING_CONNECTABLE);
 
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
 	cancel_adv_timeout(hdev);
 
 	if (val) {
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

