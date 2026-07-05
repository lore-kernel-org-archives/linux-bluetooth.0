Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1C0376A08;
	Sun,  5 Jul 2026 22:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783291394; cv=pass; b=N79AfIBGW9yeAXTior4jD40vQgsb7zjXZ/ipbJ6erWIbVPOg05OC1m5zkAg5bagfnVFNdupf2RAhOLalXER3rCcKQXPToYSecv6cMmLQADiHTalGqC0/fhOEEBFl5tB2+YYLD10M/tv1nKe2QwX39GxifJ4skms/SYGK92j9FT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783291394; c=relaxed/simple;
	bh=jFrG/eIWrh1ZE+bc0Z7f0BUan3g9L2gTzf2hW3iweJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=foosqGH1/4T6u85k0oC4+E/sq6iqBvVPiOEeAPJp1YB3mkZTAcdYq5tYcQofrsBOA0mEbBsyiZf+dEFWVfOC1AvS+z7mzTNa4HMIoYe+5o5sTzf7Wxv7rpj9PoalmM9ahhW58W9erzhk9ifAOtA60BbPKtvyi1OcFgpNXUh/Ef4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=nfySPKXV; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="nfySPKXV"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gtjF73z48zygf;
	Mon, 06 Jul 2026 01:43:07 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1783291388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Lw1soUPi+Suc2tEMoGXa+M/QgzVmXm8theeEwhotJs=;
	b=nfySPKXVPNRvElaaA8aYPHVs4qIK/Nmm7pRtXdpXVctdA7E65GvMG79V/vC34nIQCeS1Tr
	Hk0uyFRyIvVv2bB+YNRonQrMjPp+O15EDwh+ewYQyGJdA0nVR6jYsr7Fb/jj3wOs3K7Z5z
	vLcnwwQmWmW2f/pvASN5QSx+Hy5+6GU=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1783291388;
	b=U5tCUx5Ol/Cg9baF2gYVifCZTmBNa2r8WNjSHHvAxocBXY6r4J3d6euT/Vh07KPRr8TVe8
	+/Lc4mrR7NMOKyV0CKBuNx4MronfCuMNJEr16Vq4l9z1omcTPzQJ4f0PO7T349W0vvXSg4
	B5p/lza5KveFeArzHMAGichFWy3roCA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1783291388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Lw1soUPi+Suc2tEMoGXa+M/QgzVmXm8theeEwhotJs=;
	b=U/RE80Qv4FjJtKgvIN5UAzyZIicmEFmN1IpDtRmpge3cGCZ6KopT+FCF2xudOMU0kmIp3U
	1FSsiCnRCgnrAxpBVR/b4bK0d8PN5lBRvGYwsz+kaWWXL+bikhEHcanYPIX3j7/2hm86t3
	49lK0qqy8yye/3UiUGrWTdpPIaubjkU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] Bluetooth: hci_sync: hold hdev->lock for hci_conn_params lookups
Date: Mon,  6 Jul 2026 01:42:47 +0300
Message-ID: <23725f0f3ad51aeece0501017e901d673876bc27.1783275015.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1783275015.git.pav@iki.fi>
References: <cover.1783275015.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_conn_params_lookup requires hdev->lock be held, otherwise the list
iteration or param access is not safe.

Hold hdev->lock for params lookups in hci_sync.

Fixes: c530569adc19 ("Bluetooth: hci_core: Introduce HCI_CONN_FLAG_PAST")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v2:
    - no change

 net/bluetooth/hci_sync.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 5dddeed11372..edcaf72baf87 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6677,6 +6677,8 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 	if (!hci_dev_test_flag(hdev, HCI_LE_SIMULTANEOUS_ROLES))
 		hci_pause_advertising_sync(hdev);
 
+	hci_dev_lock(hdev);
+
 	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
 	if (params) {
 		conn->le_conn_min_interval = params->conn_min_interval;
@@ -6690,6 +6692,8 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 		conn->le_supv_timeout = hdev->le_supv_timeout;
 	}
 
+	hci_dev_unlock(hdev);
+
 	/* If controller is scanning, we stop it since some controllers are
 	 * not able to scan and connect at the same time. Also set the
 	 * HCI_LE_SCAN_INTERRUPTED flag so that the command complete
@@ -7247,13 +7251,13 @@ static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
 }
 
 static int hci_le_past_params_sync(struct hci_dev *hdev, struct hci_conn *conn,
-				   struct hci_conn *acl, struct bt_iso_qos *qos)
+				   u16 acl_handle, struct bt_iso_qos *qos)
 {
 	struct hci_cp_le_past_params cp;
 	int err;
 
 	memset(&cp, 0, sizeof(cp));
-	cp.handle = cpu_to_le16(acl->handle);
+	cp.handle = cpu_to_le16(acl_handle);
 	/* An HCI_LE_Periodic_Advertising_Sync_Transfer_Received event is sent
 	 * to the Host. HCI_LE_Periodic_Advertising_Report events will be
 	 * enabled with duplicate filtering enabled.
@@ -7318,16 +7322,26 @@ static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
 	 * 2. Check if that HCI_CONN_FLAG_PAST has been set which indicates that
 	 *    user really intended to use PAST.
 	 */
+	hci_dev_lock(hdev);
+
 	le = hci_conn_hash_lookup_le(hdev, &conn->dst, conn->dst_type);
 	if (le) {
 		struct hci_conn_params *params;
+		u16 le_handle = le->handle;
 
 		params = hci_conn_params_lookup(hdev, &le->dst, le->dst_type);
 		if (params && params->flags & HCI_CONN_FLAG_PAST) {
-			err = hci_le_past_params_sync(hdev, conn, le, qos);
+			hci_dev_unlock(hdev);
+
+			err = hci_le_past_params_sync(hdev, conn, le_handle,
+						      qos);
 			if (!err)
 				goto done;
+		} else {
+			hci_dev_unlock(hdev);
 		}
+	} else {
+		hci_dev_unlock(hdev);
 	}
 
 	/* SID has not been set listen for HCI_EV_LE_EXT_ADV_REPORT to update
-- 
2.55.0

