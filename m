Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C03D1D54D8
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Sep 2025 19:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758482185; cv=pass; b=eE7E7cVWnbywAgteIMKEJsH/yCrM3Q/u+GDB+pSdzwdwRPtrelDnsTZWyNkEMBKHqgQtulyD47Me21F95h6bTMHg8H9qa6RpJCxcaRO84JyD5SqxcpXTopEr6M9pHibv5ogjA3Fz6pMhX1LGdPS16UEyeYaGhhiERAwCTqYd3l0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758482185; c=relaxed/simple;
	bh=tujJREHcvbBz62V0SCcN2xRWZolJZUcgJQUnkmhKtJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GlOi/H8mD43iYRlHITEDhscQGoBRZW/0D4xm9TmFAXDkAvFSv6/SqzfnBoMdk0BkBWnnZZneNo7PN75RagVxLMqMzWmxjgGkdnA0g8TbmTAzb/KVdWgwsorwDTUfGQ8Qmbj63A7wg8rsi2ccmsx3u1IjWtd+XdeYo1/G7rBh91Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=VrAbTyMS; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="VrAbTyMS"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4cVGF235T5z49QJv;
	Sun, 21 Sep 2025 22:16:22 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1758482182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=467XMl/0NMhXwqXYPssY+GU/HAPe4TaHvNoS04Dstyc=;
	b=VrAbTyMSkQpXQLa7jTwuo+Y30yt7sMYDO+yNg2l2l5v7XiDPuAiYvDSx53VtPd0MtjwHz1
	zOKqjXfbej3ECPFgqnLhqZ80hU17kbCe4D48KDzJjtT9pOWETd5XRKKD4lswB4vpJoDkIo
	w7PKRci7af6eiulHPyyUCKY7PPiuRlJVN78WRaxIo8vxLIJT49cJaGXWdFRpghwsIFEPO2
	tZUpimRWfOSs69aQc21Cj1tgF7QnLSwYydEJzdIW+HSBAcJIfxJANoj4fRNbHwSQ+fD+dx
	uUjXkWp+48pjpntUdzxdsTViL4tHelBop7yoF1xcen+a7dhfRo4LsPH2oSmnEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1758482182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=467XMl/0NMhXwqXYPssY+GU/HAPe4TaHvNoS04Dstyc=;
	b=vykh/hm3pAI7ixIIE5RZ9hngE6575y0SbTjLGHejLhvniWipGoZ0BxobXyBGtHWnuOcbqR
	aLocdN06Oy936xlRcDHkvmvXqNa1+ZgZcQN1XTYG1WzwUmELRw7eJrC/Sj3BE2QPSJlvFY
	qTR9tG9PdfpW4kb3OsT8P+9lR66DZNWs6MQJ+YylSN0g9+TWr7i0s3ZDm9sErHiMAFa8NN
	SD3ki/qhI37iJgUn4AL62PgSBibn4kkdBEIvQsLEPbzTu8HAUkQvRxEuyo/exXEnGCCi4K
	pyVr2kCBQ46bsdLTn7SMm0W4a75jS9mKpZkXz6ZnW1O7fv0wTl78fEsbRSm3Ew==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1758482182; a=rsa-sha256;
	cv=none;
	b=uSG66cvXMkVT7T8ZwrVA+yIWcl3Icn6b1OU0nkiHQvjkAAo6nf/+HsXUr9KCnBKu1vTl0D
	HAwd3iA8Z4q/ENeUPh2UHv7RTSpTqbeoPBEE3gVQuKaz9Q54Sq7Q2ZzYb+vvsyad8psKHA
	hf85oQLumR73AodHARnbynW2/swOwMqQLsErqeBc9e9cdpaM3jUZGgOK/a6dAw0LWtR3ku
	LQPcBnwPByemU6jCRAx7971yiImRb/EkY8etqLTa4btA0BEvD3+G27ttGSYGXAqlPikrxM
	x/07obtu9WyMwPDS6Zda6+cWiXhlodn3lf3TV99SJJFewQLeHkUqFkQRqQ3TKQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 19/24] Bluetooth: hci_sync: hold lock in hci_le_create_conn_sync
Date: Sun, 21 Sep 2025 22:16:03 +0300
Message-ID: <9a6a64b430085b205b9e55a0f3cf13f13b8ea824.1758481869.git.pav@iki.fi>
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

Hold lock in hci_le_create_conn_sync() and after every wait operation,
check the conn is still valid.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_sync.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index f41aec54659b..3f0f9d9d8071 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6594,8 +6594,12 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 	int err;
 	struct hci_conn *conn = data;
 
-	if (!hci_conn_valid(hdev, conn))
+	hci_dev_lock_sync(hdev);
+
+	if (!hci_conn_valid(hdev, conn)) {
+		hci_dev_unlock_sync(hdev);
 		return -ECANCELED;
+	}
 
 	bt_dev_dbg(hdev, "conn %p", conn);
 
@@ -6610,10 +6614,8 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 		if (hci_dev_test_flag(hdev, HCI_LE_SCAN) &&
 		    hdev->le_scan_type == LE_SCAN_ACTIVE &&
 		    !hci_dev_test_flag(hdev, HCI_LE_SIMULTANEOUS_ROLES)) {
-			hci_dev_lock(hdev);
-			if (hci_conn_valid(hdev, conn))
-				hci_conn_del(conn);
-			hci_dev_unlock(hdev);
+			hci_conn_del(conn);
+			hci_dev_unlock_sync(hdev);
 			return -EBUSY;
 		}
 
@@ -6657,6 +6659,8 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 	 */
 	err = hci_update_random_address_sync(hdev, false, conn_use_rpa(conn),
 					     &own_addr_type);
+	if (!err && !hci_conn_valid(hdev, conn))
+		err = -ECANCELED;
 	if (err)
 		goto done;
 	/* Send command LE Extended Create Connection if supported */
@@ -6694,11 +6698,13 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 				       conn->conn_timeout, NULL);
 
 done:
-	if (err == -ETIMEDOUT)
+	if (err == -ETIMEDOUT && hci_conn_valid(hdev, conn))
 		hci_le_connect_cancel_sync(hdev, conn, 0x00);
 
 	/* Re-enable advertising after the connection attempt is finished. */
 	hci_resume_advertising_sync(hdev);
+
+	hci_dev_unlock_sync(hdev);
 	return err;
 }
 
-- 
2.51.0

