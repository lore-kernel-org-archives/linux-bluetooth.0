Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8172F4A
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Sep 2025 19:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758482185; cv=pass; b=BZeMqUDsJ9t5QHFRtmtLQg2SboLzmzp93RZJjaqAr1B6+rl1DfmvNdjrvirFazjj6DcKL95UMshipNf5LOX5x23CTkBxUNUwMgyApXzV6SdI0QFanZijjvDCQHGPIZA8JVBpIPyxrod2uiDd+WR5dUmPjUG9c23uPQuDxMnTTDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758482185; c=relaxed/simple;
	bh=5vEcUzAXmroJGGYEeFA+LhhMKytedrjn3cE0Yiqg5kY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGpaxrsFsT1R1XojG8EpazYwy7vWw3vhZfgIR6RfSWthXvZoo7RfMXGhjAQxOr8IwQ3uHjkGRQtDwe1/79OsPIX7jAYvaWm75PInmgnGIDBnRdxM1wQvLLxtaYpo8OZKslBJzmavvh1UoNAKTSwRJ/Dr90u2OMQZHgo6e37LfaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=nwxrZNor; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="nwxrZNor"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4cVGF21jnHz49QJk;
	Sun, 21 Sep 2025 22:16:22 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1758482182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ZV8z0vHxDO+YdH4NtxNS5mZPnWoVh148swurSLNttE=;
	b=nwxrZNor3ZvoRqHRMM4RKVrYRY+pojI7i9WcboYOiPLw393axRGAgYgi29tPzDzqlG1scC
	BeippDwrbaGUevonMrOnN7eTr1HVi4AmXwFVfwu1hH67Wymgd2ZvBpSMua4vvFywQIx03q
	Pp8vvcowD+WQ/Us3nl3Y2tGbDeuuhOrDydrvkpKMDXG15JHzPI3eHaG2zu/Sh7sy1ALy8z
	vKt1Sffq/rZPdKVzeY8WfdZ2ZsATQj9eCAro2ZZsupD3y/ULSUeqd1iwmbwilZQCXDaAxv
	4zt55snjI4xQKalvA85Br8/OhygKZMBsJcvvIHl+jmaUPCKQcsyHAjlUbXUcPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1758482182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ZV8z0vHxDO+YdH4NtxNS5mZPnWoVh148swurSLNttE=;
	b=dWhYASRvEnljpToZBg2VWsLqT2vV5kje1eTcUnSsErurx5CpqoaHt+4k7xbdhPABrg6h/y
	nduo47LxfhCru7n84zG37dDQaB0Fz8q2f580IVGgfvKNYQUL1NDHuDpQclfiI/DHzYwqah
	fhdGhJDBDY5Lg0pQXZZLJB15bCIaD/rlMiZ5ouJeRMBnRz2yM8SMVnOsSzNsltgWoJDqAm
	XmihuHPeY4ybiK0FvcWLnNK2QEhAzLdcyK0ki0pFwPhNpFT1ZL1XjDPoxU2thU3YH+pSIv
	nsZiYcIczGBEWbxVvVbh1VITAj9/KcanKHcKlH5fLZIEEwKvsYXHM9x3ZVLNnQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1758482182; a=rsa-sha256;
	cv=none;
	b=Bw0fRj08cCoGgxI1nLZoc3fXq7HoEdWQitfcHmDvtST/6prkAh5fR2CYCpBayZgSL3fk4j
	TaodrpL/aA04oyHbzsQ1kl79phHwq/UbL9Lyr+iT3MrHoi8iPFtR5Vc9XTPx52veLWD3+P
	XIZAsnLzTKnnkvCQMet4vCzFp9rRP5PRxMXT7z98K+qYoicIX9bhwZEd0KN6KWlWm/DGb4
	szYcAjT3RYatTnxQITEFHYuYd2QMqtdA4nvN5p4qnJEhCe91xp95UPgLlUyx0X+PC8wgoZ
	AjfkmXZe22aARwGT54Jkoy/l2hZY4kE7gCOtgDwPs5hGXL7//dHIIepeCAzQng==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 18/24] Bluetooth: hci_sync: hold lock in hci_acl_create_conn_sync
Date: Sun, 21 Sep 2025 22:16:02 +0300
Message-ID: <110f03a72b145408198c1e2fccdae3c73b8f5cb6.1758481869.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758481869.git.pav@iki.fi>
References: <cover.1758481869.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hold hdev->lock in hci_acl_create_conn_sync() when accessing hci_conn
fields.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_sync.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 5391c1bb17f0..f41aec54659b 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6923,10 +6923,15 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 	struct hci_conn *conn = data;
 	struct inquiry_entry *ie;
 	struct hci_cp_create_conn cp;
+	u32 timeout;
 	int err;
 
-	if (!hci_conn_valid(hdev, conn))
+	hci_dev_lock_sync(hdev);
+
+	if (!hci_conn_valid(hdev, conn)) {
+		hci_dev_unlock_sync(hdev);
 		return -ECANCELED;
+	}
 
 	/* Many controllers disallow HCI Create Connection while it is doing
 	 * HCI Inquiry. So we cancel the Inquiry first before issuing HCI Create
@@ -6941,6 +6946,11 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 					    NULL, HCI_CMD_TIMEOUT);
 		if (err)
 			bt_dev_warn(hdev, "Failed to cancel inquiry %d", err);
+
+		if (!hci_conn_valid(hdev, conn)) {
+			hci_dev_unlock_sync(hdev);
+			return -ECANCELED;
+		}
 	}
 
 	conn->state = BT_CONNECT;
@@ -6973,10 +6983,14 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 	else
 		cp.role_switch = 0x00;
 
+	timeout = conn->conn_timeout;
+
+	hci_dev_unlock_sync(hdev);
+
 	return __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN,
 					sizeof(cp), &cp,
 					HCI_EV_CONN_COMPLETE,
-					conn->conn_timeout, NULL);
+					timeout, NULL);
 }
 
 static void hci_acl_create_conn_sync_complete(struct hci_dev *hdev, void *data,
-- 
2.51.0

