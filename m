Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2F81DDC35
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 01:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760405603; cv=none; b=l1oBoIzg80sqtYQSTly/u0HD40zo22Sdo850nNYkjgUNB0vTzOByYyLYzE36+Vem5YvjTtfyT+s7OzWx84w0paY6db69wh1/xFIVQWQO10ZbOaeXUfDaNBcTi1rj0HILGvPFBZ0aT8M71mMACB9JZLHu6SSxMnSSX8bCw11xK4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760405603; c=relaxed/simple;
	bh=BquCFfq7uOWbSG/G1lJaNvYAz/zW5IYi2LUZhBCG6ns=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EFV5VSSybnEG685v6dA0rlDyctIljHt4+ikb+N+eS+idSe7ZAQA9EyYwP+9DrgVS0eryttALBVUv9yYzw37g0L0XoVkpGY7R7+GeEyw/hvGSEJqgximRms5tjKGKlru2o3AHFr+3kCnL34Vq0DgFjR1OiNO5lCZX57n3wBnsuqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXQX/Vat; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXQX/Vat"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-55784771e9dso2128054137.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 18:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760405600; x=1761010400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yFZ/dZGY3W4K0m0eKwmb4Sa9B6xoAJjJc2FgTgcc0Z0=;
        b=OXQX/Vat7S15WC566W2MhsZCGsxDte5PiQatSNkSAub4fEo64TNjFr3w55xJ96X6Tg
         gyThDFbrDH4huih2G1/NRXIkly1Evr1l0ateQOtABZsgq84d0rDsK80koOT3rRxZuFkn
         JA9QqlpT3zlFPx0Vppk3JTpWPGz7oi+xWKBjQx8z+6DWgIgSVmLPqgRiPinmt5JQGOTf
         js4eG2xD4QEACtsc7zdRRyAoUBD2PpSD868vVYiVD7r8rL4QWc86kUWdBH2Q3wkVlncb
         dQRRjMDXPCF6UR/ex86xJgURMXfnSAj6P9T5qn/KnBeIxcrLQI31RD3nNNFzbHxS2DyA
         oPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760405600; x=1761010400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFZ/dZGY3W4K0m0eKwmb4Sa9B6xoAJjJc2FgTgcc0Z0=;
        b=X4VJTT8MAoNK6bJ7pKsLYfCzLMA5E0WSuBG98tOEo6fgtERk/txK2lHed6RN3QwyNW
         zPTiwPVq2HqFAL0JFqgPL4d1C4P3h3doda6Jbq7hqBCIfwXjBEgjX4IF4moi0kQWA4Wl
         BPUWZ62zhvPgGSUeBDbqEA0gx7CY29I+LHx5nVMgbZD1PYLyZshJcDtTmgMb1PW9/VZ1
         OsBHBuwd/g5IoUjF162MEU1PXg/efYuPv3h8gGDwF5I4iC9d41Pbbz9GmqPIrYiSsw2Y
         I6qyFeGAn/uWg8xSJPhJagbtnwJaWu9a5JpVKOJ5IZvNaSwexV2UmEPYuPDVQohwe6ho
         WPYA==
X-Gm-Message-State: AOJu0YyPHa6kvVux+EtZ1hrdAUkk+yeL4ozxzwHIIIGlAtu2+SeZSeik
	PkwjPV0Oy+Tn6U8dZ7igOS0nzGLGoxmBvnwg2Hc4xpoTbwrNXh161b8NqjVFn5fF
X-Gm-Gg: ASbGncvJXmkHLSa5wat1kum94wsSCuR26tnrm3L6pXfRYjM0QM7dFqII7rXoN51Ycwa
	pHgJM4gyqro030bYAnZCN0BWI9KD1zb44S7vgNvrBVtKeT5rP/THNA1iBCL4o+U5g4V6ze2UrDj
	nK3WM86A3wiX3mWFenXYgfYpp9ZGiTvKownPQcu1L4r//hpc7Igsx0lEFy+6gLN+S/uuFld01tF
	GBTWZ45WcHnQZTf0ztXJ9L9ODXIhvAtSFHkOa6oIAnEwKbiuppnHvz7xxiCLDUR51Va9xGT9BbM
	P3FQWkP6S5nL+A4hTiiLLwkHujdfSpNeRmYHGWDglZWenSRDTQqxp7KYMW1qcAvi0oX5Ni3H+p4
	OhBp9RnpA9BNO4gDF0fWQyqZPGWtcQ5NsILDFXrgM6WbvRZVpw0TE5AruYKErMNWH4/klJsuOk3
	7qFzkw9F0pgfyUCiHabOg=
X-Google-Smtp-Source: AGHT+IE8VJPclBlBqOZGMssGxpp/uyHnAHRZExN93Ce+nsmYfbjk5GYY7hqlsX2uCq6Bcsk6sTqgwA==
X-Received: by 2002:a05:6102:5494:b0:52a:c340:11db with SMTP id ada2fe7eead31-5d5e237bb6amr7842429137.27.1760405599964;
        Mon, 13 Oct 2025 18:33:19 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d5fc7126c7sm3985806137.5.2025.10.13.18.33.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 18:33:18 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 2/8] Bluetooth: hci_core: Introduce HCI_CONN_FLAG_PAST
Date: Mon, 13 Oct 2025 21:33:02 -0400
Message-ID: <20251014013308.174151-2-luiz.dentz@gmail.com>
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

