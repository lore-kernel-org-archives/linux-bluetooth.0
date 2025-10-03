Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3AA22259D
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Oct 2025 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759505682; cv=none; b=iqygMsgTEY8Gy8mivoVDOge3ZAQ1MaQM7karZky9jVMW0fz7PojQ9ug85ES2nG+6nItNQWYJEqP3xIaRirv5UCR9ejzxp/EYlLMPGaKzRUcLWuxjeFmWCLn5O9GUZgz5RWQjn4D0l8JM5GlmTaWHUkFw6Zc25sGKokHaowRd6AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759505682; c=relaxed/simple;
	bh=BquCFfq7uOWbSG/G1lJaNvYAz/zW5IYi2LUZhBCG6ns=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLgwRv1+mmqz5SvhR79QGL+PQ6tXdKZTU0r/si+ytEAJK5liO9vwMFVrKyy/RekjpcylBwo1/uN91pP2JNrXFHKKeoQ76yX4bgJ1C/7C2Mn1FfufXuWXpS1G11VJqZgjfbN7bVloDZHpavf0iMHRFr+8BrdUoE1BEQ1wJoxXGjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsKKVfHA; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsKKVfHA"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5522bd69e14so1388604e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Oct 2025 08:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759505679; x=1760110479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yFZ/dZGY3W4K0m0eKwmb4Sa9B6xoAJjJc2FgTgcc0Z0=;
        b=XsKKVfHAHYtqHOFf0k+s0uZ2I5KaUgNJn/vtSMzyuwHi1Ko0Oke/mwlW632QJVSNg0
         kNMXPgevGdkj+sca9Guf3ksW/1ENF86jUeiBnu7ej0dFIQ915fCBSa3dcMiGtOQZqp9V
         JwmsciiuHBuLAKvvGNm1+hEWgZFsgZPtkhO9y7M7sgOCInPVqAy7LlsdZJZKp88VbtvE
         jQ2f+e7lNXDhtHa39w7y/V5EIxS4nwfTnejLn1TERRcDz6wKrHUwU5xBuxtrXBTI5ajw
         Xp+9QHBuLDk0joWxzDWW4OWIEefV1SMbKzhI35M0p0RKEDlzJ1G9F+Q/xl+d1tNcOfa8
         3H9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759505679; x=1760110479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFZ/dZGY3W4K0m0eKwmb4Sa9B6xoAJjJc2FgTgcc0Z0=;
        b=eNOcs8eg5MSjT3cgGNp2e9HKOzTsemAhlPi1Equ6rkj/GGFpqYg+wBDPAgFhn0UIVY
         Oze+N6ua5L2jbySmDwf84GYqU2GyeZg456zJECjRE397qno5mLjeSkhz7hkBjLirCufv
         ZftaNt+hW+Wxu/YGtFNIvxd2Sya+21enBdNTK1It8cwAmQ/xIlQ38/Jbz49eeNrRkKeu
         enjxJtpf8vAougoM5AkX3y10pHNc78dVr6pds+LydpVQDs+np/2VmyBo+yzmh0MeROOZ
         Tfo4vGhX+x9sSFe1wubEntn7KfMKsnN+zpEIwCs/KFW2WQ8DvTbgTELgNHgvZJiZflTx
         VIFg==
X-Gm-Message-State: AOJu0Ywv4F0qMvi3VyLEWsgt2pKfxqebHREnHMgkuZA7NxTbn6Fd131s
	zx6Nxiz5Lt52T21d/63qZWoExBL9ooxzuGUVJQlgte49a3t9dLxlZ6k8KjcKzUEH
X-Gm-Gg: ASbGncuVdNbKPl/eup28TdV0crA4APhOEe75zLEriAh6yLneAyPzXamhNSt3J5tCU7c
	Q6uqcqQPh/E2ZlMIo4j0hUf52mh86jaJ3qrd03mj265x2uY50GV7kgz6/Bo7v7Mw89qn9V2g3tB
	DG6ceYW2r3G0G9MBaa19zF8URWunkDln6094DAZ6DB1nSZVx5qLNdWAP7mmM/h72H3/b4+kwc4d
	6LKbX+ZHbEpend4kGyye0ek5PTgYgbzObYnkADywgrrlrtA1hj5413Xeyz9/RtDSnyibB+qbNm9
	U45mJCpu1AeGvuiTfQjamJhaI4qitCSdYXJkCd7NB0vHlWh1tWvEgxMZaRu8Rliwn2lF+CN/Sh5
	+icxw/rYNdl+TWkNRQQbLXUa7utv7aMkH4kmEGF6lA3RTg8AQFxtfRGCsKoWQ0X67uM8TEYMr3D
	kNHowuRbecUqVtXGuxAtvosbm8
X-Google-Smtp-Source: AGHT+IFL9LHTQKtTShH6PHAAaoGCaiohP775Z0/EILBfB8N+v3vuJpHIqiJiNU7Ar1IWiZqVuZwhww==
X-Received: by 2002:a05:6102:6881:b0:5b2:d28a:8937 with SMTP id ada2fe7eead31-5d41cffa5f8mr1466722137.12.1759505679270;
        Fri, 03 Oct 2025 08:34:39 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-92eb67dec87sm994090241.11.2025.10.03.08.34.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 08:34:34 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 2/5] Bluetooth: hci_core: Introduce HCI_CONN_FLAG_PAST
Date: Fri,  3 Oct 2025 11:34:21 -0400
Message-ID: <20251003153424.470938-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003153424.470938-1-luiz.dentz@gmail.com>
References: <20251003153424.470938-1-luiz.dentz@gmail.com>
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

