Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF777AE5D
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 May 2024 20:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715631973; cv=none; b=Ar2IWal2qRoZOVmcw0vXNUCaRu0x0CJK764PVIqVKUUa/ODcyJjE+VZ3fvJJuDDQAvtvSXEB4T+fifSKZE8GM+Ew3NPPb5lvJOC30hKtaNI7bLZaXbFalR4/YLBrQTiSozlikXtHF7JnNoexI99E5qPlrXuIGhInZ3gEl4mSNOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715631973; c=relaxed/simple;
	bh=itZrT/vVKcTN9oZia70hkWQPE23/dAFZpZ23HetOtMI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Or/zk3N4LaDH+5452EmLId8nAqyxlc0lkCNL75wIlSUdpd5dRT2PzlwYdJuthyCIcTMnDZFUbHWUeQM3H/BuElDtEmuuOhzqt/Y1X1fOUwnKlqROKWGsFsHmzCzUllHq6wg6AOylub0nAUX8BjpEmUqjYFNK+PJmMqGGeIOzzek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQIk7vhr; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQIk7vhr"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7f170dc5f70so1140920241.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 May 2024 13:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715631970; x=1716236770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cQxhqLRfiTarluPXitdCveLT6HBxHPNH02D78QNLlNg=;
        b=EQIk7vhrx79l9MVGW9gvTk4WPZDzvRWa9Y7oLVGCdeJfdayE8XvTcq2Z37bTir2m9f
         39T57ye4PG/wdn2X4pyNcghOydzhp45NMuDYQHfXWXsSXVs4YYs9teoWqh+mzF+5qJQu
         GGZd9Ma+fhRtAzT5zyC5h58cRU/szvyjINjrQYabAaqjSTPJApUPzi36qQFAa2huel81
         nQrO6mt8xfrK2rANyFLwSWLwSMxfTnvDbu91LsqHS3/JqoSDSefJuaap++GuieD9snE3
         tlqKo9mNJntR3GBXfwKyx3VsbN1HbbSepzoMt3f6vOK7ykyNv1VEkrUvAa/+e8D1d8Oe
         lvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715631970; x=1716236770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQxhqLRfiTarluPXitdCveLT6HBxHPNH02D78QNLlNg=;
        b=WLumZhowFq09P720x2KL6q/E+aBx+UxDW0FuxtmfUIaQ79gZdWstZBhjd6x5zK3XyY
         Qc28FwYB6cvd0YBKC0vs9VS8PmQXyNdHTguq69LkrckrukZ7holsY8DwhVEls5KdyKxq
         ijRlTokWJzQ5Aj+AaPhlLpRbpWhG5DczYm/+ffNEY8Bg4OvhcI0H9murjIx6TF45Pdhg
         9J3hLVu7jTdk/1DVzX1F80iZSMv4wA6hTMT+hMBo+/KQLbnb+jeV6Zy0cMmqD/jHISp+
         gf9COXBe/1SIVuekwadv7IB+GEL33kMuzGBfBsrqUhnniIH6oBz8lZJRxRaIuazgYGK/
         50lA==
X-Gm-Message-State: AOJu0YxcKeZZjm6ohv9XssPQFkfrQrYs+Rid1lt26vVAYeRWjwcUtBMy
	T52A6phufKXphmsrIAHn48e07ImOXai3G+1pBDG3ds01y/mWbcrOapdYwQ==
X-Google-Smtp-Source: AGHT+IH6UdDGdqb+0i9MGUanwdolB51qyn2c9wE+vrdFkNi7ys6w9gPMkUz0LCO5ByCKaoEWId3IQA==
X-Received: by 2002:a05:6102:3a13:b0:47b:b993:340 with SMTP id ada2fe7eead31-48077dcc884mr11661517137.13.1715631969514;
        Mon, 13 May 2024 13:26:09 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4806cc568b3sm1450909137.33.2024.05.13.13.26.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 13:26:08 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_core: Fix not handling hdev->le_num_of_adv_sets=1
Date: Mon, 13 May 2024 16:26:07 -0400
Message-ID: <20240513202607.369337-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If hdev->le_num_of_adv_sets is set to 1 it means that only handle 0x00
can be used, but since the MGMT interface instances start from 1
(instance 0 means all instances in case of MGMT_OP_REMOVE_ADVERTISING)
the code needs to map the instance to handle otherwise users will not be
able to advertise as instance 1 would attempt to use handle 0x01.

Fixes: 1d0fac2c38ed ("Bluetooth: Use controller sets when available")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         |  9 +++++++++
 net/bluetooth/hci_sync.c         | 17 ++++++++---------
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 68eeecf5229c..5ff89005c9ca 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -246,6 +246,7 @@ struct adv_info {
 	bool	periodic;
 	__u8	mesh;
 	__u8	instance;
+	__u8	handle;
 	__u32	flags;
 	__u16	timeout;
 	__u16	remaining_time;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index adfd53a9fcd4..aab980aa8613 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1765,6 +1765,15 @@ struct adv_info *hci_add_adv_instance(struct hci_dev *hdev, u8 instance,
 
 		adv->pending = true;
 		adv->instance = instance;
+
+		/* If controller support only one set and the instance is set to
+		 * 1 then there is no option other than using handle 0x00.
+		 */
+		if (hdev->le_num_of_adv_sets == 1 && instance == 1)
+			adv->handle = 0x00;
+		else
+			adv->handle = instance;
+
 		list_add(&adv->list, &hdev->adv_instances);
 		hdev->adv_instance_cnt++;
 	}
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 891cae8a30da..16daa79b7981 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1043,11 +1043,10 @@ static int hci_disable_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 	struct hci_cp_ext_adv_set *set;
 	u8 data[sizeof(*cp) + sizeof(*set) * 1];
 	u8 size;
+	struct adv_info *adv = NULL;
 
 	/* If request specifies an instance that doesn't exist, fail */
 	if (instance > 0) {
-		struct adv_info *adv;
-
 		adv = hci_find_adv_instance(hdev, instance);
 		if (!adv)
 			return -EINVAL;
@@ -1066,7 +1065,7 @@ static int hci_disable_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 	cp->num_of_sets = !!instance;
 	cp->enable = 0x00;
 
-	set->handle = instance;
+	set->handle = adv ? adv->handle : instance;
 
 	size = sizeof(*cp) + sizeof(*set) * cp->num_of_sets;
 
@@ -1249,7 +1248,7 @@ static int hci_set_ext_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
 
 	len = eir_create_scan_rsp(hdev, instance, pdu->data);
 
-	pdu->handle = instance;
+	pdu->handle = adv ? adv->handle : instance;
 	pdu->length = len;
 	pdu->operation = LE_SET_ADV_DATA_OP_COMPLETE;
 	pdu->frag_pref = LE_SET_ADV_DATA_NO_FRAG;
@@ -1331,7 +1330,7 @@ int hci_enable_ext_advertising_sync(struct hci_dev *hdev, u8 instance)
 
 	memset(set, 0, sizeof(*set));
 
-	set->handle = instance;
+	set->handle = adv ? adv->handle : instance;
 
 	/* Set duration per instance since controller is responsible for
 	 * scheduling it.
@@ -1410,10 +1409,10 @@ static int hci_set_per_adv_data_sync(struct hci_dev *hdev, u8 instance)
 	DEFINE_FLEX(struct hci_cp_le_set_per_adv_data, pdu, data, length,
 		    HCI_MAX_PER_AD_LENGTH);
 	u8 len;
+	struct adv_info *adv = NULL;
 
 	if (instance) {
-		struct adv_info *adv = hci_find_adv_instance(hdev, instance);
-
+		adv = hci_find_adv_instance(hdev, instance);
 		if (!adv || !adv->periodic)
 			return 0;
 	}
@@ -1421,7 +1420,7 @@ static int hci_set_per_adv_data_sync(struct hci_dev *hdev, u8 instance)
 	len = eir_create_per_adv_data(hdev, instance, pdu->data);
 
 	pdu->length = len;
-	pdu->handle = instance;
+	pdu->handle = adv ? adv->handle : instance;
 	pdu->operation = LE_SET_ADV_DATA_OP_COMPLETE;
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_PER_ADV_DATA,
@@ -1734,7 +1733,7 @@ static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
 	len = eir_create_adv_data(hdev, instance, pdu->data);
 
 	pdu->length = len;
-	pdu->handle = instance;
+	pdu->handle = adv ? adv->handle : instance;
 	pdu->operation = LE_SET_ADV_DATA_OP_COMPLETE;
 	pdu->frag_pref = LE_SET_ADV_DATA_NO_FRAG;
 
-- 
2.45.0

