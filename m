Received: from mxb.seznam.cz (mxb.seznam.cz [77.75.76.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D651B3F4116;
	Mon, 24 Aug 2026 09:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.76.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787564104; cv=none; b=CKCAEJPkrIPiuqWZPjhbQvReH6UmqqP7UMxvzAMMcnFudppcWeveBJxwWPh6ZjmnCWy1XyTasjWs86FXGYeIvTMr52/1gokf8ntnMuMGz/QwfUkJWckdzX3DnmbT6kh03kooZbKtfVmU/3NhXwsXVsXPq0LjwZ3yfoL6y/hyoFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787564104; c=relaxed/simple;
	bh=bxFGomsyJNo6zN1h4CJsYSqAgdKL+JHwl3jVsH0nzTw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=hPy0iYXWn5ianrswcW0qxC8cc6Sy5Q9InXQBSbyZoRCdNT+0sGsfN+/ei5f7RDFObj5Mw785frZdLhXSz3PhqIkU7Krq7bw+rV0fciD7VfC6c4aH1tkSup+b+OcvkgN8IUEAEdfdIU86PNf+Z/FrnS3iGQJoZQ4GuYYxeZb/FJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz; spf=pass smtp.mailfrom=podgorny.cz; dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b=byh+kjug; arc=none smtp.client-ip=77.75.76.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b="byh+kjug"
Received: from email.seznam.cz
	by smtpc-mxb-846d86b87b-xjzvj
	(smtpc-mxb-846d86b87b-xjzvj [2a02:598:96:8a00::1200:501])
	id 54a89334e2923e2d5127897c;
	Mon, 24 Aug 2026 11:34:54 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=emailprofi.seznam.cz; s=szn1; t=1787564094;
	bh=civz/GAsNd1uxHWzyca2Ek4tBnllOfabbdDHx/vwIzI=;
	h=Message-ID:Date:MIME-Version:User-Agent:From:Subject:To:Cc:
	 Content-Language:Content-Type:Content-Transfer-Encoding;
	b=byh+kjug/B3BibRgL7zId1cra6iyS9BTequzAsDX3RPfwf3t5y6jsxC64gnoMdMWZ
	 N2U1q6ik9R//h0xVgeksxbZcI2CPlrzRcf7mgHbcMnUh/twJWfPea1NFuLMIwpT05s
	 /4JhaU2t/njVhSPJ6Xae//GDgy+neqImkla6b4Dhkq715PPUOvCPF9nOO96RX3tKV9
	 omSkYLFXYJ4NaS1qOmvk1+CSL7u2iO26VAMWekAe+znXLuF9XJhdRkJtlQaB1QMt9y
	 lS3woy6cvkUWVUJudex5hSw/GzW9BBEL6sPcnNCRvQi/KKDY0awLhC0N0kOmVNeAv0
	 bqoSSFo+7Qa6g==
Received: from [IPV6:2a01:9422:904:1ee:272:eeff:feab:4ab4]
	([2a01:9422:904:1ee:272:eeff:feab:4ab4])
	by smtpd-relay-86c88674d5-v9m66 (szn-email-smtpd/2.0.80) with ESMTPA
	id 3220d576-f224-47ff-bca5-535e8e2fd673;
	Mon, 24 Aug 2026 11:32:19 +0200
Message-ID: <483d88b5-138c-46a0-b377-a6ebb43609f2@podgorny.cz>
Date: Mon, 24 Aug 2026 11:32:18 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
From: Radek Podgorny <radek@podgorny.cz>
Subject: [PATCH] Bluetooth: do not leak an hci_conn when a second LE connect
 is rejected
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

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
net/bluetooth/hci_sync.c | 9 +++++++--
1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 7150037a864b..24eeb76f7207 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7279,8 +7279,13 @@ static void create_le_conn_complete(struct
hci_dev *hdev, void *data, int err)
goto unlock;
}
- /* Check if connection is still pending */
- if (conn != hci_lookup_le_connect(hdev))
+ /* Check if this connection is still pending.
+ *
+ * hci_lookup_le_connect() returns only the first LE connection
+ * in BT_CONNECT, which is not necessarily this one when two are
+ * pending at once, so ask the connection itself.
+ */
+ if (conn->state != BT_CONNECT)
goto unlock;
/* Flush to make sure we send create conn cancel command if needed */

-- 
2.47.3

