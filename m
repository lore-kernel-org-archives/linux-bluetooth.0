Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=77.75.78.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795649838;
	b=ZI/7BwYMpOy3brRl/UbpkthJQGUve05DlO7CNlD5sgpQrelkgsdfN9J1gXjqdNOdjdTp
	 ZtfDKIkxZhKsVET1ffuO51vyJEOlkHnZElHh2X5FJpdECfnZH2P0EXKUenS7XFidjOERe
	 l3phtPUPTMyySqSsZEEYhqaD4vtvL0rZW2Wcuz7Uh8qwJ9Qy6YxK6rwseMquuVqjagmNG
	 Gr246I/gnXNlpFTpw/9aD5K318TaiSRpdwQkGgltBWoXFknl56NiJyV8kktbSWfY6IGL1
	 UuKdurbdVLRvq3hjDjMwwZyv1db+Qd/5nEYHKtH5ySSBX5VINurPbg5tXG4ozh224/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795649838;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=az3pf6ZKU0+YdyqUH/rVdd5Mz08oZMkFsFpzAKyDL2M=;
	b=KHNwrR9NnOqTnYA6+MQopy0XCrIkgzLR9VB6ezh3cZaRZiXcc2XQ3XcTev1TNyqqJy3E
	 4Uvnhd3gvfelwDax2dqWH81zz+/ULO7lD8TLsQpJByrEtnlXPd1nHas1PkazKzFOYWTRp
	 FIB/zo87pTM6DmRdsexm/aUvbZnnCk0Sz/3QJhVo0xfasPNBwlxAnC4erBcRxOlCEFNFm
	 fSSSl9wwknJN8NZLUh1Z125Y0WSBXpO7DxV7Z9ET/zpXVzQ+fyu8uXPJm79FZU2gnp2J/
	 FwmjDQ/Aw/q9dmOQTKV6wAi9djb7Rb21vOPzjf9mKlt9zj8cVMpyJ+g7NtGjEyFQlCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=podgorny.cz;
	spf=pass smtp.mailfrom=podgorny.cz;
	dkim=pass header.d=podgorny.cz header.i=@podgorny.cz header.a=rsa-sha256 header.s=szn1 header.b=pJsvVhWx;
	arc=none smtp.remote-ip=77.75.78.89
Received: from mxb.seznam.cz (mxb.seznam.cz [77.75.78.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0F1606A329;
	Wed, 25 Nov 2026 23:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B0F1606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=podgorny.cz header.i=@podgorny.cz header.a=rsa-sha256 header.s=szn1 header.b=pJsvVhWx
Received: from email.seznam.cz
	by smtpc-mxb-5bd84c9575-nc5th
	(smtpc-mxb-5bd84c9575-nc5th [2a02:598:64:8a00::1000:947])
	id 53e6bc5be5dc11425669a613;
	Thu, 26 Nov 2026 00:37:06 +0100 (CET)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=podgorny.cz; s=szn1;
	t=1795649826; bh=az3pf6ZKU0+YdyqUH/rVdd5Mz08oZMkFsFpzAKyDL2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc;
	b=pJsvVhWxIdS2q3nu61uq1TR+nimbNNRphLZ6ITsYbQTWFohQpYnR8aD5xgztCFFQM
	 tS6jHz+D5kwlY7MXl3xxpBKW5PS8f150zoEN0pqXbhlqAucNYhG4JRegc2bP4uMM7V
	 X8uHRq0wQ3kBQ+3u2HkPOHovVSvEl81T+9iuqURWLjPbzKTltDwEeoVoQNWjg6ZBp6
	 NG5SFVKXneN77XUS15OL1BLhS5QmTXc16G4kOWlJvRoqfahM6oVW4EVj/ByeZYlRm1
	 1I8Zw/ws1wOFUUsKqPysnOFhMAqklo+Hd2gLGAQdAuHkY4CWvUgu0+pKlYV4/0nAPN
	 gqC+WS9BotalQ==
Received: from [192.168.31.57] ([2a01:9422:904:1ee:e65e:37ff:feee:e29c])
	by smtpd-relay-86b589c786-pdzw7 (szn-email-smtpd/2.0.97) with ESMTPA
	id 9aee33ef-4dd5-4215-807d-e33641008801;
	Thu, 26 Nov 2026 00:36:53 +0100
From: Radek Podgorny <radek@podgorny.cz>
Date: Thu, 26 Nov 2026 00:36:50 +0100
Subject: [PATCH v5 3/4] Bluetooth: connect to an RPA as to the identity
 behind it
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-for-upstream-le-conn-params-rpa-v5-3-b7f015a35023@podgorny.cz>
References: <20261126-for-upstream-le-conn-params-rpa-v5-0-b7f015a35023@podgorny.cz>
In-Reply-To: <20261126-for-upstream-le-conn-params-rpa-v5-0-b7f015a35023@podgorny.cz>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 Johan Hedberg <johan.hedberg@intel.com>, 
 Jakub Pawlowski <jpawlowski@google.com>, linux-bluetooth@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Radek Podgorny <radek@podgorny.cz>
X-Mailer: b4 0.15.2

A connect made to a peer's RPA through hci_connect_le_scan(), from Pair
Device, an L2CAP socket or a CIS, looks for an existing connection by
that RPA only. A bonded peer's established connection is kept under its
identity, so the lookup misses it and a second hci_conn is created under
the RPA. An L2CAP connect to the RPA of a connected peer does exactly
that on v7.3.5. The connect also marks params under the RPA for itself,
while the peer's advertising reports are resolved to its identity before
check_pending_le_conn() looks params up, so it is never started and
waits until it is cancelled.

Resolve an RPA to the identity first, through a new
hci_rpa_to_identity(), so the connect proceeds as one made to the
identity: it finds the peer's connection, also one hci_connect_le() is
still creating under an RPA, through the fallback by IRK the previous
patch adds to hci_conn_hash_lookup_le(), and marks the identity's
params.
hci_connect_le() still puts the RPA on air when the controller cannot
resolve it. SMP can free the IRK without hdev->lock, so the identity is
copied out under rcu_read_lock().

An L2CAP channel keeps the address it was connected to, here the RPA,
also when its connection is under the identity, as it already does when
le_conn_complete_evt() moves a new connection to the identity.

Fixes: f75113a26008 ("Bluetooth: add hci_connect_le_scan")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Radek Podgorny <radek@podgorny.cz>
---
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_conn.c         |  7 +++++++
 net/bluetooth/hci_core.c         | 22 ++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 071131f08c0a..fa2d139574d2 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1904,6 +1904,8 @@ int hci_bdaddr_list_del_with_irk(struct list_head *list, bdaddr_t *bdaddr,
 				 u8 type);
 void hci_bdaddr_list_clear(struct list_head *list);
 
+void hci_rpa_to_identity(struct hci_dev *hdev, bdaddr_t **addr,
+			 u8 *addr_type, bdaddr_t *id_addr);
 struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
 					       bdaddr_t *addr, u8 addr_type);
 struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 5676671d813c..fdebaf3c1982 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1851,6 +1851,7 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
 				     enum conn_reasons conn_reason)
 {
 	struct hci_conn *conn;
+	bdaddr_t id_addr;
 
 	/* Let's make sure that le is enabled.*/
 	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED)) {
@@ -1860,6 +1861,12 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
 		return ERR_PTR(-EOPNOTSUPP);
 	}
 
+	/* Connect to the peer as if by its identity, under which its
+	 * connection and parameters are kept. hci_connect_le() puts its RPA
+	 * on air when the controller cannot resolve it.
+	 */
+	hci_rpa_to_identity(hdev, &dst, &dst_type, &id_addr);
+
 	/* Some devices send ATT messages as soon as the physical link is
 	 * established. To be able to handle these ATT messages, the user-
 	 * space first establishes the connection and then starts the pairing
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 024960e9af66..eb48488ab395 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2359,6 +2359,28 @@ int hci_bdaddr_list_del_with_irk(struct list_head *list, bdaddr_t *bdaddr,
 	return 0;
 }
 
+/* A peer we hold the IRK of is tracked under its identity address, so
+ * point *addr and *addr_type at the identity behind an RPA we can resolve.
+ * SMP can free the IRK without hdev->lock, so the identity is copied to
+ * @id_addr before leaving the RCU read-side section.
+ *
+ * This function requires the caller holds hdev->lock.
+ */
+void hci_rpa_to_identity(struct hci_dev *hdev, bdaddr_t **addr,
+			 u8 *addr_type, bdaddr_t *id_addr)
+{
+	struct smp_irk *irk;
+
+	rcu_read_lock();
+	irk = hci_get_irk(hdev, *addr, *addr_type);
+	if (irk) {
+		bacpy(id_addr, &irk->bdaddr);
+		*addr = id_addr;
+		*addr_type = irk->addr_type;
+	}
+	rcu_read_unlock();
+}
+
 /* This function requires the caller holds hdev->lock */
 struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
 					       bdaddr_t *addr, u8 addr_type)

-- 
2.56.1

