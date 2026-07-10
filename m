Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B5F3EFD24;
	Fri, 10 Jul 2026 08:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671846; cv=pass; b=eFPryiXONzVBCkg0sGSf1KiItImL7FU/CYGf+EjTh9Q/MBcTrG6L8OwPuT14XwkFnyPkqo85zdiK58HzJcVPE2xunkZ+Lf/7Qzq41stIj1XNBx6dwpHaEkx4O0mFXOMXIR9K1vTJn1WzaWU+NRUNN7QBBuEHIxE9DnCUvXfIwcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671846; c=relaxed/simple;
	bh=qp0LG+dtJvvKhzg73t44YNka2xRXHC8fRZsBriQRA8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NgMv5hilfUTawjQNiAC07aOTeaxdf9aoNthIdhm49CE5C7WrYGx2cwZaQg0J2sR2yZpu6T67vsyNUTfXfz+8gviT7D11n+JovAePBDG9o9CXknla+JWJdq3YnGYosbJZuoqeCz9kTP4emEd4PUK9AhlZKwfdEthVoZf8TlmPclQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=P+NYFwok; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="P+NYFwok"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gxPxT1fPhzytg;
	Fri, 10 Jul 2026 11:23:57 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1783671837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b1VEWul+HyxrXWU8hZyHnEDDT4MJtjTgusKZVWDnfrQ=;
	b=P+NYFwokOwr+orldZ2spD11y3QdgMoCDjwgxK1F4GqhVyJTGbAEBarIMxcNRW28CZ6Hkxv
	inr6YFmXOljeAgKsfldXqsrtl+Q/UwWjUI5x/Yjdru8s2Z/z7fkYy3cmTc++8lFkQ1ALzD
	m2bKcWl5vs9xahI7V7KvF3Est5D9Wcw=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1783671837;
	b=OdFp2CFi4iySuy4L63hpaDAIA/chRAjNqxL5Qs3KX5CchzX57mYoQGcFZsJVmQbbgu9DqL
	YBM6pJZaGZ6W94xAgjEutACdsvWqmAVPDbWRLljKR9zTalwJyzQ7JAbRTRpUS4h8tuis/S
	5HVRJDRzVmyTYv8PkZrO5QtMikwn6Xk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1783671837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b1VEWul+HyxrXWU8hZyHnEDDT4MJtjTgusKZVWDnfrQ=;
	b=y7GC/vOimeCYk0g1vlNnz1o4dA6r928iXs38wBuqb/9ksnLuWxQD5/f1DeUx9ASxTVj9Mq
	/+5EUkbmARXDz37oMdbCK1sgDlEEhOMOWCVNeQuPnd/Ns1nALWzDTK2smoT5F+pl19lAAt
	kUkagGf+seWj4o2lJsY0PlgaDbGhec4=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] Bluetooth: hci_sync: hold hdev->lock for hci_conn_params lookups
Date: Fri, 10 Jul 2026 11:23:43 +0300
Message-ID: <50fcbacc691eaffe08a6e3828be372840e1fdf80.1783671570.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1783671570.git.pav@iki.fi>
References: <cover.1783671570.git.pav@iki.fi>
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
    v3:
    - copy params->flags in hci_le_pa_create_sync() to reduce number of
      unlocks in branches. Note the lock also protects the `le` hci_conn.
    v2:
    - no change

 net/bluetooth/hci_sync.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 5dddeed11372..b4ca34abe032 100644
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
@@ -7318,16 +7322,28 @@ static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
 	 * 2. Check if that HCI_CONN_FLAG_PAST has been set which indicates that
 	 *    user really intended to use PAST.
 	 */
+	hci_dev_lock(hdev);
+
 	le = hci_conn_hash_lookup_le(hdev, &conn->dst, conn->dst_type);
 	if (le) {
 		struct hci_conn_params *params;
+		hci_conn_flags_t flags = 0;
+		u16 le_handle = le->handle;
 
 		params = hci_conn_params_lookup(hdev, &le->dst, le->dst_type);
-		if (params && params->flags & HCI_CONN_FLAG_PAST) {
-			err = hci_le_past_params_sync(hdev, conn, le, qos);
+		if (params)
+			flags = params->flags;
+
+		hci_dev_unlock(hdev);
+
+		if (flags & HCI_CONN_FLAG_PAST) {
+			err = hci_le_past_params_sync(hdev, conn, le_handle,
+						      qos);
 			if (!err)
 				goto done;
 		}
+	} else {
+		hci_dev_unlock(hdev);
 	}
 
 	/* SID has not been set listen for HCI_EV_LE_EXT_ADV_REPORT to update
-- 
2.55.0

