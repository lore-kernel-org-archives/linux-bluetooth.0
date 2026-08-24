Received: from mxb.seznam.cz (mxb.seznam.cz [77.75.78.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2095407CF6;
	Mon, 24 Aug 2026 11:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.78.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787569247; cv=none; b=VP8Ek+BhLBNwGPTafCJ8e85PlGfLMWNS2S8D6h1oeYJKr+Wv69JF2235ZSASb1J4HSP0puXoUvSRg6mPvU8zlpGkJSUtWPcU91vbrwU1trWsaX1WcnuTHwtBwW45SDk13oCCBVPLXe5e8KVfHQcg2t9XoZK5mOo0pYPNhnLH1k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787569247; c=relaxed/simple;
	bh=hDZlmyB+TI5qWwXED7l5E02qmZp59Ezez4/kr+sg2ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nO0+cPEEwfEQBxV+Uv2USCcyVcp/jUlxPTOUNC3vnXX56CzgZ2DxfDs+/fx1K8d6aIa1/yXh9oeVJa9Whx5Db9kIKrjdI0AX4KKO59s6YWcub4QZd+ykOIbmfwlofQDUbPYUkxoYuMJPsbXws24Sd0PN9aE8Yena7smilTEa+Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz; spf=pass smtp.mailfrom=podgorny.cz; dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b=dSLaGTb8; arc=none smtp.client-ip=77.75.78.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b="dSLaGTb8"
Received: from email.seznam.cz
	by smtpc-mxb-846d86b87b-lnqkz
	(smtpc-mxb-846d86b87b-lnqkz [2a02:598:64:8a00::1000:901])
	id 4995070dffafaa144c1a1d45;
	Mon, 24 Aug 2026 13:00:39 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=emailprofi.seznam.cz; s=szn1; t=1787569239;
	bh=oSNPHyPIIsBboNk17musSQJu7c8EBTX5CR3p59Y783s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding;
	b=dSLaGTb8/lKjHWU79bgTtl5lEJnxIr+hGg96ixl8X3pxKW7mktGzRUAk8yMDYZjYH
	 41JeCgavs/250ru+sPXFeus2T07fUVbDaLzyMtbfDmVKsAINFXn/G+bbMijXhm0JHr
	 rhloX/YtGPum+Kc2uEP9k6gBfACTV1yx5i+oVnw3TxNpv+ZoB2VKWzoj+3tXt3S7xr
	 fNvqdVUGahgDT9Hm/yLl8Kj3NALvh7Zunb4C4vMrXo4H9B6SQdXs3mm5XszqSLZJkd
	 ftQafJctSsaIkv//I/kYuXUmWNc23CHg/Trov0d2nQjO5DI3VGdxfB2CsfqZMP9z8w
	 YnAvaRRVtl51A==
Received: from localhost.localdomain ([2a01:9422:904:1ee:272:eeff:feab:4ab4])
	by smtpd-relay-86c88674d5-h5l2p (szn-email-smtpd/2.0.80) with ESMTPA
	id a1d787bb-3cda-4e6a-99ae-dfdc70e4d886;
	Mon, 24 Aug 2026 13:00:29 +0200
From: Radek Podgorny <radek@podgorny.cz>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Radek Podgorny <radek@podgorny.cz>
Subject: [PATCH v2] Bluetooth: do not leak an hci_conn when a second LE connect is rejected
Date: Mon, 24 Aug 2026 13:00:20 +0200
Message-ID: <20260824110020.5423-1-radek@podgorny.cz>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <8ff19217-3b4e-4081-88a8-4bd26c573f8f@podgorny.cz>
References: <8ff19217-3b4e-4081-88a8-4bd26c573f8f@podgorny.cz>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

create_le_conn_complete() decides whether the failed connection is
still pending by comparing it against hci_lookup_le_connect(), which
returns the first LE connection in BT_CONNECT. That is the same
connection only while at most one is pending.

Two can be pending. Connections created on the passive scan path sit
in BT_CONNECT with HCI_CONN_SCANNING set and are invisible to
hci_lookup_le_connect() until hci_le_create_conn_sync() clears the
flag when their command is issued, so the -EBUSY guard in
hci_connect_le() does not prevent a second connection from being
queued while the first is still on the scan path. Whenever two
connections are in BT_CONNECT at once, the lookup may return one
connection while create_le_conn_complete() is reporting the failure
of the other; the early exit then drops the error and hci_conn_failed()
never runs on the connection that failed.

The controller also rejects a second HCI_OP_LE_CREATE_CONN issued
while another connection creation is still outstanding, per Core Spec
Vol 4, Part E. The spec calls for Command Disallowed there; the
bcm43438 observed here answers with an LMP/LL error code instead,
which bt_to_errno() maps to the -EPROTO (-71) in the log below.

The leaked connection stays in BT_CONNECT forever, and because
hci_connect_le() refuses to dial while hci_lookup_le_connect() finds
anything, every subsequent attempt to reach any peer fails with
-EBUSY and no command reaches the controller at all.

Seen on a bcm43438 with two BLE peers polled on the same interval
(state 5 is BT_CONNECT; both handles are UNSET ones, allocated from
the ida above HCI_CONN_HANDLE_MAX):

  Bluetooth: hci1: Opcode 0x2013 failed: -71

  # hcitool con
          < LE 14:9C:EF:03:68:81 handle 3840 state 5 lm CENTRAL
          < LE C4:D3:6A:8C:B5:38 handle 3841 state 5 lm CENTRAL

A btmon capture across the next ten minutes of connect attempts
contains no HCI_OP_LE_CREATE_CONN at all; outgoing LE connections
do not recover until the adapter is reset. With this change the same
scenario fails the rejected connection cleanly and further connects
to both peers go through.

Ask about the connection itself instead of about the device.

Fixes: c9f73a2178c1 ("Bluetooth: hci_conn: Fix hci_connect_le_sync")
Signed-off-by: Radek Podgorny <radek@podgorny.cz>
---

Changes in v2:

- Resend with git send-email; both previous submissions were mangled
  by the mail client and never applied. No change to the patch itself.

 net/bluetooth/hci_sync.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 7150037a864b..24eeb76f7207 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7279,8 +7279,13 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 		goto unlock;
 	}
 
-	/* Check if connection is still pending */
-	if (conn != hci_lookup_le_connect(hdev))
+	/* Check if this connection is still pending.
+	 *
+	 * hci_lookup_le_connect() returns only the first LE connection
+	 * in BT_CONNECT, which is not necessarily this one when two are
+	 * pending at once, so ask the connection itself.
+	 */
+	if (conn->state != BT_CONNECT)
 		goto unlock;
 
 	/* Flush to make sure we send create conn cancel command if needed */
-- 
2.47.3

