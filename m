Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=176.98.248.254
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793793707;
	b=JwkVmdylnltBomOG8aLU719w7IHv+mohWeUT7edBg22uEc3jlTDcDSbqs05xgdveiXEE
	 f7CbSWpmNV6p3f00bPG9hnqCzR4NJQDkPbiEJzTrsmDjh6IbXE7WH/JC/96fqH4AJskZx
	 i4YF+uFvUE/stp1UpXtP/en5KG3deEWWN2yUPTaN2R5FGn5+2ri3iC5RIn9hsTSsfEEum
	 5lCobalwCoSYUcpihlJG94o5MEYPZsSCYUhXAFJ6ETu01YcDXoFSCTgFic527X08YCoav
	 3k0Oo1VUHRL4jq3gm4KMR845iRuQejavBbGpDToh7lX+V3xbbP/4Yccy8dNVtmpO2Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793793707;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YY3r/TXTbSQv2f/8wCPyyqFfjDJfFUaHECdMjCQ3O58=;
	b=zKvENKv2iQM3isB89mwtfT40nbSVx4cUIUstqjHw1rbBiCRDw1NBM+ZZORUX3AObNozW
	 itU+4C1+7xe9kA979nfcfmgQMdIxqw+FlPzssXAoFSrgbwrt49F8NrwMwxm6Dsee4wvgW
	 NedJ1di4l/lZjboD8rkXQ0DBOCG60IbgGHCdiOBOExfLn6g/0ilDwDv1wtJCF0dMAxF/k
	 0WMC/ap4M64BYbinDt35+j2Ni16A2u+51BYOheR6OaJXZZu7ufbdnetaE0+6ME+hZdkeJ
	 HVtgYcq27aOLHMGvsIZ2xEhkAe2e26v8cX09SUwrh37PkkLzdviapRK7x+5epnx2ZQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=podgorny.cz;
	spf=fail smtp.mailfrom=podgorny.cz;
	arc=none smtp.remote-ip=176.98.248.254
Received: from ruprt.localdomain (unknown [176.98.248.254])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751A6606A326;
	Wed,  4 Nov 2026 12:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 751A6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=podgorny.cz
Received: by ruprt.localdomain (Postfix, from userid 1000)
	id 362DF186A9A4; Wed, 04 Nov 2026 13:01:38 +0100 (CET)
From: Radek Podgorny <radek@podgorny.cz>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Radek Podgorny <radek@podgorny.cz>
Subject: [PATCH v2] Bluetooth: find an RPA peer's connection parameters by its identity
Date: Wed,  4 Nov 2026 13:01:38 +0100
Message-ID: <20261104120138.1165715-1-radek@podgorny.cz>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A bonded peer's connection parameters are stored under its identity
address, but hci_conn_params_lookup() matches only the exact address it
is given, so a caller holding the peer's RPA misses the entry.

hci_le_create_conn_sync() is such a caller: hci_connect_le() puts the
peer's cached RPA in conn->dst, and __hci_conn_add() no longer converts
it back when the controller cannot translate an identity address. The
connection is then created with the controller-wide defaults in hdev
instead of the peer's interval, latency and supervision timeout.

Resolve the RPA in hci_conn_params_lookup() when the exact match fails,
so every caller finds the same entry whichever of the peer's addresses
it holds. The exact match is tried first, so an entry stored under an
RPA is still found as before.

hci_conn_params_add() and hci_conn_params_del() look up through the
same function, so given a resolvable RPA they now act on the peer's
identity entry instead of creating or missing a separate one.

Fixes: 4914c4998961 ("Bluetooth: put the peer's on-air address on air when we cannot resolve")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Radek Podgorny <radek@podgorny.cz>
---
Changes in v2:
- Resolve the RPA inside hci_conn_params_lookup() rather than at the
  hci_le_create_conn_sync() call site, as Luiz suggested, so no other
  caller can miss the entry
- Exact match still first, so entries stored under an RPA are unchanged.
  I weighed inlining this as one pass matching either address, but that
  lets list order rather than exactness decide between an RPA entry and
  an identity entry, and resolves the IRK on every RPA lookup; a small
  helper scanned twice seemed cleaner
- Rebased on bluetooth-next
- Link to v1: https://patch.msgid.link/20261101-for-upstream-le-conn-params-rpa-v1-1-988629a09bc9@podgorny.cz

Tested on the author's van (BCM4345C0 against a bonded peer that
rotates RPAs): with v2 the peer's stored connection parameters are used
again. bluetooth-next itself was only build-tested.

Per Documentation/process/generated-content.rst: the patch and this
message were done with the Claude coding assistant (model as in the
Assisted-by trailer). The prompts asked it to fix the lookup miss named
in the on-air address review and, for v2, to move the fix into
hci_conn_params_lookup() per review. The author directed the work,
reviewed the result and tested it on the van.
---
 net/bluetooth/hci_core.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index bfc5bdebc71a2..2dc12c01c4dc1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2285,9 +2285,8 @@ int hci_bdaddr_list_del_with_irk(struct list_head *list, bdaddr_t *bdaddr,
 	return 0;
 }
 
-/* This function requires the caller holds hdev->lock */
-struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
-					       bdaddr_t *addr, u8 addr_type)
+static struct hci_conn_params *conn_params_find(struct hci_dev *hdev,
+						bdaddr_t *addr, u8 addr_type)
 {
 	struct hci_conn_params *params;
 
@@ -2301,6 +2300,27 @@ struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
 	return NULL;
 }
 
+/* This function requires the caller holds hdev->lock */
+struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
+					       bdaddr_t *addr, u8 addr_type)
+{
+	struct hci_conn_params *params;
+	struct smp_irk *irk;
+
+	params = conn_params_find(hdev, addr, addr_type);
+	if (params)
+		return params;
+
+	/* A bonded peer's parameters are stored under its identity address,
+	 * so an RPA that resolves to it finds the same entry.
+	 */
+	irk = hci_get_irk(hdev, addr, addr_type);
+	if (!irk)
+		return NULL;
+
+	return conn_params_find(hdev, &irk->bdaddr, irk->addr_type);
+}
+
 /* This function requires the caller holds hdev->lock or rcu_read_lock */
 struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
 						  bdaddr_t *addr, u8 addr_type)

base-commit: 3f425f95ba3923d605f6a8b382e8fcdc59d479db
-- 
2.56.0

