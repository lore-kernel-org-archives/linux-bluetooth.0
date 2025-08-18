Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9016B1FBEA2
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Aug 2025 20:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550088; cv=none; b=iBnLyJTPNysFnrWy/Tnk9txMa2629zGYzyMRj+hc8jUB+rVqy+KKX75EtA4hlap9P/w1Qc4PSLb0TpG7XD83X9cFFbP5aBfHIBWnMdo1gfRN7qEa9nKS62jTEGZCfvfPdMnXBDIO+sDE7UPK7eJe8FVgUySIH953FdJd30FGVQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550088; c=relaxed/simple;
	bh=esNJlKRt52QKI6EuFR8gx6+dKzpKB407IdphBdtCqJk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eD0FJ0MVZnP74vukh3oUQUX9C2xSqPkw9y311sDEh6Ki+MrPCy/mFjOD1f1xHmFk8cE9NFWDKgtALsC814BJY4oyLebUj0amTFVg7qztzJyQzkd77Kv6u69I1rqnG4B0UVO+Nuo2b7QIvxfaaVxiuEOiV2YGVes78Mw/UqP1ME0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6UUk7hC; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6UUk7hC"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-53b171c1e82so3488409e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Aug 2025 13:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755550085; x=1756154885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NwcvtNnoLdUnFJ1eoRp1h+HNbZ5XMxc2WlYOJOkYyC0=;
        b=d6UUk7hC8ZQiSqrZoHweXYgdzkCHs6ZXZnw7bM1ec40MQNDQjFmnjNCoaWeb3dDNQf
         7F2awj6h1A77NN6916dVKoAksCFCozu3OADHStaTzvCO0mSWEPnGPrq+CzHFQO52io7V
         aCueACicQEb3yCSkchFlKTmS8pqtqQIun9rgcITM3M8+c6E/TWN+eaqRuKE47HdhSoI9
         QEr5DgsLsTD3A9/a4w8sd9I36GOLTmwUXkbYQ+USDe8LYNQ84liJ/uwdqdElw+PhsTa/
         Aod0jO6o0/rDR8Zer/OtUa0RGmHYaaSZEsUdVOTJ2eqO5nzG/zRjClzIwrdsK/ecPMJr
         leAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755550085; x=1756154885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwcvtNnoLdUnFJ1eoRp1h+HNbZ5XMxc2WlYOJOkYyC0=;
        b=Vpokgt2Hsy5YDGmFShvMcFOVgeRkaeMVr4SMnLF6nZe0JEGbd2UsApoBlzoRRDednX
         VGWsWcNYaci4Iit1i41vgQPNNrgQCy99/tMr39dx4fjP+wle51OQm9Qs0zAnmBhWbI5f
         3dp5BPLD+n0j5nFbOVCDus5aNrU+XcS4Bvew5LvEzvvNXeKSBsVhyhWBwQ4ARFigK+r2
         sppTTL+LVmGdsM2kHsfgU1WbD+wdMTh8FVCwtvdYmzTnmxOv6PQRGsMKPfqei9vwIPLa
         IJfmnWGQ+DXucdbAFWnxqiVNzeVQNpiwa8TWA8pvHbTTW9j28cr0MzI6lJas9BO1+Gj4
         jyuw==
X-Gm-Message-State: AOJu0YzEu5aTluidH8gIGBW5fzL0ON8iBzXFHHevQz0XpM/J8Akc3ZJQ
	xfhcBN+1ezNmBOvskkG4tasPd5dWdQQErhOyet1YZ+6sCXQqSsCDjzPWssh8Roxm
X-Gm-Gg: ASbGncsodh732PKW9rDaEZrpSwKxA6r9ph67JjWfP6GWJuF/RqMw1FMSt70DeIq/ay3
	noeydFUgO+xjLC76Q+T0MUIt6cue8AhBb4akrMQR+B61fDCW8BivunRW/CmUgBzNUmevR4pmUH6
	cSPhac0sGMX9Q++4NNp5InAaDFc7YwEYyVhcu+v/21kJm1tljqdFGtT8yyAxvhPXOm6pKkMLc0B
	YTB7pWmbOAKKRRmAeax1eq+mJAWyR7VyQzqg9s1R5ZMsvSvVG++/DxXyg+cGVJVzj6+xTw2Mrfn
	ZxaNqrtgjUKFo96cSVvCScIAkL9Br9/w1ku5YRWYRQ9l18JHoBFYbfQRIa3aQPtJ3M57Kvfu2eY
	YgUfL5pDLSTV2j8uCn97DzzcNlPiAIsDAJSUvvIrVe9BYqHw+0EhMd1sLw0adNn+D8gD8dEWARn
	PsgbSLqtWt8w==
X-Google-Smtp-Source: AGHT+IH8VD5Lh+zQbiomUQmLvtw5/6D4LkihUwwuQgtFins23zf5HF1X/3jIn2uJMW3/nhXwd574bw==
X-Received: by 2002:a05:6122:2a42:b0:535:e35d:49f4 with SMTP id 71dfb90a1353d-53b5d329a88mr82353e0c.11.1755550084757;
        Mon, 18 Aug 2025 13:48:04 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53b2bd553casm2101079e0c.2.2025.08.18.13.48.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 13:48:03 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/8] Bluetooth: hci_event: Convert instances of BT_DBG to bt_dev_dbg
Date: Mon, 18 Aug 2025 16:47:48 -0400
Message-ID: <20250818204753.1203949-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818204753.1203949-1-luiz.dentz@gmail.com>
References: <20250818204753.1203949-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This converts instances of BT_DBG to bt_dev_dbg when logging to a
specific hci_dev this is preferable since it does prints the name by
default.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1686680a38c8..6e0c095ef244 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -947,8 +947,8 @@ static u8 hci_cc_read_buffer_size(struct hci_dev *hdev, void *data,
 	hdev->acl_cnt = hdev->acl_pkts;
 	hdev->sco_cnt = hdev->sco_pkts;
 
-	BT_DBG("%s acl mtu %d:%d sco mtu %d:%d", hdev->name, hdev->acl_mtu,
-	       hdev->acl_pkts, hdev->sco_mtu, hdev->sco_pkts);
+	bt_dev_dbg(hdev, "acl mtu %d:%d sco mtu %d:%d", hdev->acl_mtu,
+		   hdev->acl_pkts, hdev->sco_mtu, hdev->sco_pkts);
 
 	if (!hdev->acl_mtu || !hdev->acl_pkts)
 		return HCI_ERROR_INVALID_PARAMETERS;
@@ -1214,7 +1214,7 @@ static u8 hci_cc_le_read_buffer_size(struct hci_dev *hdev, void *data,
 
 	hdev->le_cnt = hdev->le_pkts;
 
-	BT_DBG("%s le mtu %d:%d", hdev->name, hdev->le_mtu, hdev->le_pkts);
+	bt_dev_dbg(hdev, "le mtu %d:%d", hdev->le_mtu, hdev->le_pkts);
 
 	if (hdev->le_mtu && hdev->le_mtu < HCI_MIN_LE_MTU)
 		return HCI_ERROR_INVALID_PARAMETERS;
@@ -1227,7 +1227,7 @@ static u8 hci_cc_le_read_local_features(struct hci_dev *hdev, void *data,
 {
 	struct hci_rp_le_read_local_features *rp = data;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
 
 	if (rp->status)
 		return rp->status;
@@ -2921,7 +2921,7 @@ static void hci_cs_switch_role(struct hci_dev *hdev, u8 status)
 	struct hci_cp_switch_role *cp;
 	struct hci_conn *conn;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	bt_dev_dbg(hdev, "status 0x%2.2x", status);
 
 	if (!status)
 		return;
@@ -3753,8 +3753,8 @@ static u8 hci_cc_le_read_buffer_size_v2(struct hci_dev *hdev, void *data,
 	hdev->le_cnt  = hdev->le_pkts;
 	hdev->iso_cnt = hdev->iso_pkts;
 
-	BT_DBG("%s acl mtu %d:%d iso mtu %d:%d", hdev->name, hdev->acl_mtu,
-	       hdev->acl_pkts, hdev->iso_mtu, hdev->iso_pkts);
+	bt_dev_dbg(hdev, "acl mtu %d:%d iso mtu %d:%d", hdev->acl_mtu,
+		   hdev->acl_pkts, hdev->iso_mtu, hdev->iso_pkts);
 
 	if (hdev->le_mtu && hdev->le_mtu < HCI_MIN_LE_MTU)
 		return HCI_ERROR_INVALID_PARAMETERS;
@@ -5336,8 +5336,9 @@ static void hci_user_confirm_request_evt(struct hci_dev *hdev, void *data,
 			goto confirm;
 		}
 
-		BT_DBG("Auto-accept of user confirmation with %ums delay",
-		       hdev->auto_accept_delay);
+		bt_dev_dbg(hdev,
+			   "Auto-accept of user confirmation with %ums delay",
+			   hdev->auto_accept_delay);
 
 		if (hdev->auto_accept_delay > 0) {
 			int delay = msecs_to_jiffies(hdev->auto_accept_delay);
@@ -5967,7 +5968,7 @@ static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
 		 */
 		break;
 	default:
-		BT_DBG("Failed to connect: err %ld", PTR_ERR(conn));
+		bt_dev_dbg(hdev, "Failed to connect: err %ld", PTR_ERR(conn));
 		return NULL;
 	}
 
@@ -6861,7 +6862,7 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 	struct hci_conn *conn;
 	__u8 i = 0;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
+	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
 
 	if (!hci_le_ev_skb_pull(hdev, skb, HCI_EVT_LE_CREATE_BIG_COMPLETE,
 				flex_array_size(ev, bis_handle, ev->num_bis)))
@@ -7239,8 +7240,8 @@ static bool hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode,
 		return false;
 
 	if (opcode != __le16_to_cpu(ev->opcode)) {
-		BT_DBG("opcode doesn't match (0x%2.2x != 0x%2.2x)", opcode,
-		       __le16_to_cpu(ev->opcode));
+		bt_dev_dbg(hdev, "opcode doesn't match (0x%2.2x != 0x%2.2x)",
+			   opcode, __le16_to_cpu(ev->opcode));
 		return false;
 	}
 
-- 
2.50.1

