Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3623A1D2
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Oct 2025 22:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759876334; cv=none; b=suOfyfkOPKs+kOpFI/GVm2e6/xVSgPNkIB3yaycYnI65rW2SxbEoMgHPOi8koiAOg0FQnVAksJ9lAUxYcBzWPC/LvKh1x9kBFnd8yXgJIU/EeogOPa9kei5x/X50e70mWmUYDHsz5NCI+75aggTDMnu2BF68Iril9sGs5Klz7RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759876334; c=relaxed/simple;
	bh=BquCFfq7uOWbSG/G1lJaNvYAz/zW5IYi2LUZhBCG6ns=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rDB0L6HNojTKR9HgzcD8rdulhkZtkBXrZdTTFnGSXbbA1699Fanu2PjRJKNRkHBenOblSJQ70ASTxvS17Cv6fryHC11BztJki5CeNf/7Ni37H4Ylp7x8BY32a1E+cZKckmbwrgRSgc3JDmrFywIttVetJrKNCspH8I1Irs85GAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXcWvYTn; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXcWvYTn"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-8e3d93c0626so263486241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Oct 2025 15:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759876330; x=1760481130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yFZ/dZGY3W4K0m0eKwmb4Sa9B6xoAJjJc2FgTgcc0Z0=;
        b=NXcWvYTnxFYqS3pyHCR03TGjP3hFnmwSqozG42MFMRJaPwFLXystqU19Qfjm7rVjyb
         kkLlFeUAfL/1R9FfogUnh5jiB0MciNyq8qsPrYbxsCO9xRBCIc034ePjl2lNtInazS/q
         6WfL1XwZzdaHmybwVNg+y2VLQ9/hQi96g4AVb03oJhCu7Imn2BpeLBvxb1/OuBUFIAa5
         +hDZ4sZBWR2Mv4NIB//H33Ejef8sHR5n7Rc1VL7OIcFQhK1+YR4Q7JUSIRso1KVcCZqt
         2Rz7KV/VKIeG53ADmBsZgFI5QRgiT8MGt+Ov5si2X54psI/jIFpIt2ykb9EhWtAuBLtx
         tsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759876330; x=1760481130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFZ/dZGY3W4K0m0eKwmb4Sa9B6xoAJjJc2FgTgcc0Z0=;
        b=Zx4AwpHOy3ki22WlVVdEifJST1NUnEsQgfWKOWlY25J0Ho4s1Oz2S911SGl64VMfo8
         PvCJsOI2qMabTapXwG8eUD00mQx/CHSNYFjvzHrieqRahZAP06VQVDkXht5D529bHZk8
         9Mfr6I/fn7s6MMO24kNqltYS6hMx0+FGdRvy40GUudGN67l5YnJDRZNPYRu4omPtXHMg
         bbhsVYVn9q4/pf6v/pdOtzof+wWxHWRPK62A6dRt9V6IrmWC3Dbw+ybCYk/q2Pchhy7m
         U1nvy/fQ0iRJ7xpiICpWWXtr6zItDIGMjwefwh/AoMoh9DcgvOKxPS0HdKFeHdm6v0eg
         kadw==
X-Gm-Message-State: AOJu0Yw4jYf3gVEHIbK2aclK/kICDPqHWMRYmPCspeX1JEnsQNscqZ0B
	WiVOPxEQWaR3ssH2+cIE1/0ZmtJlxDxLJAKc6bTTpAVkAqM33Khwrnj6q/g1vB//
X-Gm-Gg: ASbGncux1g9lBcBiau30JQh5YYEYf9TPARmi1u+AdWIVCr8aftduSRVUOzRqmhakrJP
	NAHKfspjB7yH0MO1PfA4LXC7ec1f11Dwxap52PO34+tFKt7k1CgL4XOhkHZp3YStfj3D/FdaF2S
	K5Q29gHiXDX6c97yPmNugj7PWuFD+9rX3yMuwcgl+mfM7e3TJQeoBGcYhHiBw4sldKYXc0/ZC70
	fVY3PGkIDMiyWAdR9XD9CJfV2hJ6J8VXijlpeCIIPBeXXDJhvRCf56vOf8LxWRJJs+/r7LzEiJR
	Xlmuo9EFrPXuPzG+3rRRsuFmwYQfiv2B/NpYyupE1J0EgywCZvNdorJUEhAC7/3+DiLMLmbBoez
	gRpTa5FhuVBbmNtT9ZVMpeCFagIOdcJP502/E/QpCC1mwZpJeAmlC23Q5i4djdj9M7jaOu+7z7Y
	6n5fAvJdz3/DVvFQ==
X-Google-Smtp-Source: AGHT+IGpjies92rU49anKzU0onTRG8nEu992kQjreCTDqNfaM3X83KQw/Qborf6K0pmk1PWlLOHYbQ==
X-Received: by 2002:a05:6102:5c11:b0:5b8:e08f:eb38 with SMTP id ada2fe7eead31-5d5d4ddfb86mr1942765137.14.1759876330106;
        Tue, 07 Oct 2025 15:32:10 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-92eb4da21c3sm3859567241.7.2025.10.07.15.32.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 15:32:08 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/8] Bluetooth: hci_core: Introduce HCI_CONN_FLAG_PAST
Date: Tue,  7 Oct 2025 18:31:49 -0400
Message-ID: <20251007223155.1539954-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007223155.1539954-1-luiz.dentz@gmail.com>
References: <20251007223155.1539954-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces a new device flag so userspace can indicate if it
wants to enable PAST Receiver for a specific device.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_sync.c         | 55 +++++++++++++++++++++++++++++++-
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 894e01717b55..2a765a0521b4 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -166,6 +166,7 @@ enum hci_conn_flags {
 	HCI_CONN_FLAG_REMOTE_WAKEUP = BIT(0),
 	HCI_CONN_FLAG_DEVICE_PRIVACY = BIT(1),
 	HCI_CONN_FLAG_ADDRESS_RESOLUTION = BIT(2),
+	HCI_CONN_FLAG_PAST = BIT(3),
 };
 typedef u8 hci_conn_flags_t;
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 277b2c096195..5051413f1a97 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4324,6 +4324,10 @@ static int hci_le_set_event_mask_sync(struct hci_dev *hdev)
 	if (ll_privacy_capable(hdev))
 		hdev->conn_flags |= HCI_CONN_FLAG_ADDRESS_RESOLUTION;
 
+	/* Mark PAST if supported */
+	if (past_capable(hdev))
+		hdev->conn_flags |= HCI_CONN_FLAG_PAST;
+
 	/* If the controller supports Extended Scanner Filter
 	 * Policies, enable the corresponding event.
 	 */
@@ -7024,10 +7028,41 @@ static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
 	hci_dev_unlock(hdev);
 }
 
+static int hci_le_past_params_sync(struct hci_dev *hdev, struct hci_conn *conn,
+				   struct hci_conn *acl, struct bt_iso_qos *qos)
+{
+	struct hci_cp_le_past_params cp;
+	int err;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.handle = cpu_to_le16(acl->handle);
+	/* An HCI_LE_Periodic_Advertising_Sync_Transfer_Received event is sent
+	 * to the Host. HCI_LE_Periodic_Advertising_Report events will be
+	 * enabled with duplicate filtering enabled.
+	 */
+	cp.mode = 0x03;
+	cp.skip = cpu_to_le16(qos->bcast.skip);
+	cp.sync_timeout = cpu_to_le16(qos->bcast.sync_timeout);
+	cp.cte_type = qos->bcast.sync_cte_type;
+
+	/* HCI_LE_PAST_PARAMS command returns a command complete event so it
+	 * cannot wait for HCI_EV_LE_PAST_RECEIVED.
+	 */
+	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_PAST_PARAMS,
+				    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	if (err)
+		return err;
+
+	/* Wait for HCI_EV_LE_PAST_RECEIVED event */
+	return __hci_cmd_sync_status_sk(hdev, HCI_OP_NOP, 0, NULL,
+					HCI_EV_LE_PAST_RECEIVED,
+					conn->conn_timeout, NULL);
+}
+
 static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
 {
 	struct hci_cp_le_pa_create_sync cp;
-	struct hci_conn *conn = data;
+	struct hci_conn *conn = data, *le;
 	struct bt_iso_qos *qos = &conn->iso_qos;
 	int err;
 
@@ -7059,6 +7094,24 @@ static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
 
 	hci_update_passive_scan_sync(hdev);
 
+	/* Check if PAST is possible:
+	 *
+	 * 1. Check if an ACL connection with the destination address exists
+	 * 2. Check if that HCI_CONN_FLAG_PAST has been set which indicates that
+	 *    user really intended to use PAST.
+	 */
+	le = hci_conn_hash_lookup_le(hdev, &conn->dst, conn->dst_type);
+	if (le) {
+		struct hci_conn_params *params;
+
+		params = hci_conn_params_lookup(hdev, &le->dst, le->dst_type);
+		if (params && params->flags & HCI_CONN_FLAG_PAST) {
+			err = hci_le_past_params_sync(hdev, conn, le, qos);
+			if (!err)
+				goto done;
+		}
+	}
+
 	/* SID has not been set listen for HCI_EV_LE_EXT_ADV_REPORT to update
 	 * it.
 	 */
-- 
2.51.0

