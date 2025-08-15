Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68A4A926
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Aug 2025 21:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755294264; cv=none; b=hbnEcUAP4nV53irXwH49FZLGetKIYtw/1MMOjrgzqlXzybvLzR+1oy071yAUjldHmtsXxfpWfW9C5ksRZYI29HFDzgIIy2o1usTJ5ZnbIrB+CcIeuyEden+q96EUDWL9x/XWEPo7V9q7/E3vQ0Ul+YPfBI4YstH75lqjxyUFl9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755294264; c=relaxed/simple;
	bh=WY1PXOGbSPQtDTLCnXoO1bvjiENnGDQr+Fkm2rcELNo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAi8fe/qH/kbCKTM4IPF1ceMw4Ltl8hLkTry1mE6uicol0YrTEVbxZEjU3XWZKms4SM4+3UctszuF6XBsFrIDn0rwcW9QfsTky0Qc4YnvTmPnbol5KsXM0ERr3Fm+kBs8fCIKDkrpP3x0vHs0IFQ0UD+oYGFk0gl6f0TYr4wfMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmiRGNU3; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmiRGNU3"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-53b174c9c78so2149176e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Aug 2025 14:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755294261; x=1755899061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j43+LmJvB/8EQsNhH6muwLkmdxA8CcWQHZZj8MrABag=;
        b=CmiRGNU3Fg50d8+kULKDeCrPFra8UX4GOHrxSWSA/eZGtNqvHJHN/+gi30pWhlQSp6
         S2MDY1v+Dks/iCkGAr1AwrBbFvamcFyW52zuUGWAhhSSYXk/QqPLM8h5NxpWehJvWBcA
         YP140uDimyRjV3MyjESDRS11nHnFSPAYPdLO4QuTpiSPkfabYyzjWwZFdjeIK1DUqhUp
         OAThiZy1UdMVKKcILCn2TZIHgXYYGD2Ne36Ng/+6PCJG+CpyN+5gy7rnnUpsEeQqEsSj
         sjsxJbUI+BkGWELtLNybBFV5BsLdnBIFPVevFWjuWy274aqkb3v9sVtyk9Wgmzhv8DZh
         DcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755294261; x=1755899061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j43+LmJvB/8EQsNhH6muwLkmdxA8CcWQHZZj8MrABag=;
        b=GZ+lIuhSYPKXocvUeudHqoivEzgFRKn5IWDdfe263BL3l7mDe5/2Q65Fai/8yuoLNL
         Jm7smwKpAzWTWw7eTSf39Qt3sGrgPnYe5hMWND73Mg00FeepoO1OOELuEXSFrZi/Kdtp
         GdNfQRkGNeuUBKAsPrYXIJgD1tXNutS0b9rpVPSjinmq6wkescUtaELjj+4nwu9CgJqi
         3ajXm8CHxDkqXot4JXYv0jBdVG78fjtHlH+z7wLLo7qFgXRsLNJTPP4HHEksg4C940p3
         s2VUmeVs4jnQqNlIVVoa20rYmh/IcsAKAjC7aoSgI7FtOrkw/eRH8ULvg4ND8tqvRzkd
         pZcA==
X-Gm-Message-State: AOJu0Yz5cbJwieA78sVXixTCR9SCXnI1L5vH5QSU/soGZ7aOyUaLRtlS
	IFpM4Hx+sfa4hobtc8fpav7UhlacVkMEt9Z5he7k6zEiIeNXvfXZCc1rDUTB4tXz
X-Gm-Gg: ASbGnctT4/50fkUCNDmzWrjHjv+pqdnCtvvFb+WB+5x1cPJ/wE/hIIYU+338jagsiEG
	UXy9O4qq6wYNw8S+EFetNllyf84No1d2W/sov+tzErRhXW1Fgwk2h031cLEQOyip28wUQ0szanf
	ocOSI4y4oClMFULnrMCqtRnCtJvTVe+cnkTLFubpkQYkZsCr8R7pjExS1taRZSXRxzT8Gmo0XvM
	OUfCgH1A5VNgaWxX6idAqq8MjsmwqVtyPNldL58CI2e0tBHMKOZF8TPvfNySywwM6bsKO8UC/lH
	objf+fjRXRb0VdzWxa+uaisV71KauWmIJoRB5jOe7VqoEBSvEhsysw4fGMtjV7Owo1yx/XK/RrD
	MUIHjBMw/C+FOa16X+lk8/cFBR5m+kGuyKv+neGsDrywtU1loq8TbrUN8wHDKKGeQGEvVPkiXML
	A=
X-Google-Smtp-Source: AGHT+IFkTAIGkYWH75XKi+awG+5ZFXW04wmuvuE8OaLU4pHQnk4WjS8J1tGehRyetx+00qK4wFEZwg==
X-Received: by 2002:a05:6122:1ad4:b0:531:2906:752d with SMTP id 71dfb90a1353d-53b2b983fc4mr1634790e0c.11.1755294261045;
        Fri, 15 Aug 2025 14:44:21 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53b2beff1c1sm472053e0c.24.2025.08.15.14.44.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 14:44:20 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 3/6] Bluetooth: hci_event: Convert instances of BT_DBG to bt_dev_dbg
Date: Fri, 15 Aug 2025 17:44:02 -0400
Message-ID: <20250815214406.514260-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815214406.514260-1-luiz.dentz@gmail.com>
References: <20250815214406.514260-1-luiz.dentz@gmail.com>
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
index fe7cdd67ad2a..34b243c26bbd 100644
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
@@ -5346,8 +5346,9 @@ static void hci_user_confirm_request_evt(struct hci_dev *hdev, void *data,
 			goto confirm;
 		}
 
-		BT_DBG("Auto-accept of user confirmation with %ums delay",
-		       hdev->auto_accept_delay);
+		bt_dev_dbg(hdev,
+			   "Auto-accept of user confirmation with %ums delay",
+			   hdev->auto_accept_delay);
 
 		if (hdev->auto_accept_delay > 0) {
 			int delay = msecs_to_jiffies(hdev->auto_accept_delay);
@@ -5977,7 +5978,7 @@ static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
 		 */
 		break;
 	default:
-		BT_DBG("Failed to connect: err %ld", PTR_ERR(conn));
+		bt_dev_dbg(hdev, "Failed to connect: err %ld", PTR_ERR(conn));
 		return NULL;
 	}
 
@@ -6871,7 +6872,7 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 	struct hci_conn *conn;
 	__u8 i = 0;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
+	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
 
 	if (!hci_le_ev_skb_pull(hdev, skb, HCI_EVT_LE_CREATE_BIG_COMPLETE,
 				flex_array_size(ev, bis_handle, ev->num_bis)))
@@ -7249,8 +7250,8 @@ static bool hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode,
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

