Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Wm+IYhIz"
X-Greylist: delayed 905 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Dec 2023 04:05:29 PST
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8CBFC9
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Dec 2023 04:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=vu8T2
	TCXz0geYnte+TI1CLSHhL5rzZMCnz+mFaaX8As=; b=Wm+IYhIzuoraNYf7C8R4m
	fVuL87AlcWTu+Sxso6yusxG5ODLOpXLcKCw3b8+k4PE+VpuWPloTPv1F3mRlhLT3
	w/c5IU61WuhR81nVnKqxCPfv5I59PRc23M9X9OF5xt3W68iGukFiOJNOsgOM9rDp
	FN2qhQAAM0L4qXKUnMWUf0=
Received: from localhost.localdomain (unknown [58.22.7.114])
	by zwqz-smtp-mta-g4-1 (Coremail) with SMTP id _____wDXX8JGDm9lTerODQ--.49009S2;
	Tue, 05 Dec 2023 19:49:27 +0800 (CST)
From: Xiao Yao <xiaokeqinhealth@126.com>
To: linux-bluetooth@vger.kernel.org
Cc: xiaoyao@rock-chips.com
Subject: [PATCH] Bluetooth: MGMT/SMP: Fix address type when using smp over BREDR
Date: Tue,  5 Dec 2023 19:49:24 +0800
Message-Id: <20231205114924.834626-1-xiaokeqinhealth@126.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXX8JGDm9lTerODQ--.49009S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GFW8Gw4rXFWkZw15ur48JFb_yoWxWrWfpF
	yUta4rCw48Gr17ur17t34UZa4YqrWvvry7C3y0v3yYkF1IvrWkJF18CrW2qwn3uFWktr1a
	kF40qr4Ig34kAwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07USzuAUUUUU=
X-CM-SenderInfo: 50ld0yhhtl0xhhdo3xa6rslhhfrp/1tbiEAo91WVLYtdxugAAsi

From: Xiao Yao <xiaoyao@rock-chips.com>

When using SMP over BREDR, the identity address(irk/ltk/csrk) is
distributed during the SMP key distribution phase.

> ACL Data RX: Handle 11 flags 0x02 dlen 12
	BR/EDR SMP: Identity Address Information (0x09) len 7
	Address: F8:7D:76:XX:XX:XX (OUI F8-7D-76)
@ MGMT Event: New Identity Resolving Key (0x0018) plen 30
	Store hint: Yes (0x01)
	Random address: 00:00:00:00:00:00 (Non-Resolvable)
	BR/EDR Address: F8:7D:76:XX:XX:XX (OUI F8-7D-76)
	Key: 30cac11ec2bbc046a3658f62xxxxxxxx
@ MGMT Event: New Long Term Key (0x000a) plen 37
        Store hint: Yes (0x01)
        LE Address: F8:7D:76:XX:XX:XX (OUI F8-7D-76)
        Key type: Authenticated key from P-256 (0x03)
        Central: 0x00
        Encryption size: 16
        Diversifier: 0000
        Randomizer: 0000000000000000
        Key: a3ca3f9e06cfa8c512edc13axxxxxxxx

In the mgmt_new_irk/ltk/csrk() function, addr.type is forcefully converted
to BDADDR_LE_PUBLIC using link_to_bdaddr(LE_LINK, irk/ltk/csrk->addr_type).
However, the actual address type should be BDADDR_BREDR. Therefore, let's
pass the actual link type to determine the address type.

Signed-off-by: Xiao Yao <xiaoyao@rock-chips.com>
---
 include/net/bluetooth/hci_core.h |  8 +++++---
 net/bluetooth/mgmt.c             | 14 ++++++++------
 net/bluetooth/smp.c              | 10 +++++-----
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index eed6c9f37b12..5088fbf4c7f5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2278,10 +2278,12 @@ void mgmt_suspending(struct hci_dev *hdev, u8 state);
 void mgmt_resuming(struct hci_dev *hdev, u8 reason, bdaddr_t *bdaddr,
 		   u8 addr_type);
 bool mgmt_powering_down(struct hci_dev *hdev);
-void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent);
-void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk, bool persistent);
+void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent,
+		  u8 link_type);
+void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk, bool persistent,
+		  u8 link_type);
 void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk,
-		   bool persistent);
+		   bool persistent, u8 link_type);
 void mgmt_new_conn_param(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			 u8 bdaddr_type, u8 store_hint, u16 min_interval,
 			 u16 max_interval, u16 latency, u16 timeout);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index da79a2369dd7..fdfb395e29ba 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9550,7 +9550,8 @@ static u8 mgmt_ltk_type(struct smp_ltk *ltk)
 	return MGMT_LTK_UNAUTHENTICATED;
 }
 
-void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent)
+void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent,
+		  u8 link_type)
 {
 	struct mgmt_ev_new_long_term_key ev;
 
@@ -9574,7 +9575,7 @@ void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent)
 		ev.store_hint = persistent;
 
 	bacpy(&ev.key.addr.bdaddr, &key->bdaddr);
-	ev.key.addr.type = link_to_bdaddr(LE_LINK, key->bdaddr_type);
+	ev.key.addr.type = link_to_bdaddr(link_type, key->bdaddr_type);
 	ev.key.type = mgmt_ltk_type(key);
 	ev.key.enc_size = key->enc_size;
 	ev.key.ediv = key->ediv;
@@ -9593,7 +9594,8 @@ void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent)
 	mgmt_event(MGMT_EV_NEW_LONG_TERM_KEY, hdev, &ev, sizeof(ev), NULL);
 }
 
-void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk, bool persistent)
+void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk, bool persistent,
+		  u8 link_type)
 {
 	struct mgmt_ev_new_irk ev;
 
@@ -9603,14 +9605,14 @@ void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk, bool persistent)
 
 	bacpy(&ev.rpa, &irk->rpa);
 	bacpy(&ev.irk.addr.bdaddr, &irk->bdaddr);
-	ev.irk.addr.type = link_to_bdaddr(LE_LINK, irk->addr_type);
+	ev.irk.addr.type = link_to_bdaddr(link_type, irk->addr_type);
 	memcpy(ev.irk.val, irk->val, sizeof(irk->val));
 
 	mgmt_event(MGMT_EV_NEW_IRK, hdev, &ev, sizeof(ev), NULL);
 }
 
 void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk,
-		   bool persistent)
+		   bool persistent, u8 link_type)
 {
 	struct mgmt_ev_new_csrk ev;
 
@@ -9632,7 +9634,7 @@ void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk,
 		ev.store_hint = persistent;
 
 	bacpy(&ev.key.addr.bdaddr, &csrk->bdaddr);
-	ev.key.addr.type = link_to_bdaddr(LE_LINK, csrk->bdaddr_type);
+	ev.key.addr.type = link_to_bdaddr(link_type, csrk->bdaddr_type);
 	ev.key.type = csrk->type;
 	memcpy(ev.key.val, csrk->val, sizeof(csrk->val));
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index f1a9fc0012f0..3f640741e07b 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1060,7 +1060,7 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 	}
 
 	if (smp->remote_irk) {
-		mgmt_new_irk(hdev, smp->remote_irk, persistent);
+		mgmt_new_irk(hdev, smp->remote_irk, persistent, hcon->type);
 
 		/* Now that user space can be considered to know the
 		 * identity address track the connection based on it
@@ -1081,25 +1081,25 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 	if (smp->csrk) {
 		smp->csrk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->csrk->bdaddr, &hcon->dst);
-		mgmt_new_csrk(hdev, smp->csrk, persistent);
+		mgmt_new_csrk(hdev, smp->csrk, persistent, hcon->type);
 	}
 
 	if (smp->responder_csrk) {
 		smp->responder_csrk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->responder_csrk->bdaddr, &hcon->dst);
-		mgmt_new_csrk(hdev, smp->responder_csrk, persistent);
+		mgmt_new_csrk(hdev, smp->responder_csrk, persistent, hcon->type);
 	}
 
 	if (smp->ltk) {
 		smp->ltk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->ltk->bdaddr, &hcon->dst);
-		mgmt_new_ltk(hdev, smp->ltk, persistent);
+		mgmt_new_ltk(hdev, smp->ltk, persistent, hcon->type);
 	}
 
 	if (smp->responder_ltk) {
 		smp->responder_ltk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->responder_ltk->bdaddr, &hcon->dst);
-		mgmt_new_ltk(hdev, smp->responder_ltk, persistent);
+		mgmt_new_ltk(hdev, smp->responder_ltk, persistent, hcon->type);
 	}
 
 	if (smp->link_key) {
-- 
2.34.1

