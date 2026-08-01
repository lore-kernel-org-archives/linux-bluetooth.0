Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9993546C8;
	Sat,  1 Aug 2026 18:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785609462; cv=pass; b=lL3gJbZkuhqSiFa2iYSey37B3Xkxg2/xNaURdR3zIINrzZZvm01Do+hB1nDq/Uph3EyWEPB+jM7gMWBPAGAuHPDO/bRZr2agv59GiRSFIe745DxoCKb7QPCmDV0oPWFJESjJzunmoJvgWZ0fh46iBvEaBh4LfjG9HlvvnTUtH/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785609462; c=relaxed/simple;
	bh=XXDFkgFTYdKA+EYqRRMaS8TrzSduZkjER2+Ftw47sao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LTmg+CK+u4qJNyIUZO6/7Ckt0l0iZjEzIS5a+AadF+cVywA/wa3pP7JdUF0KKcRVu3uGUy4OWGs8WHlK2l8Bkc/kJgTb+QV76zNqAmyLq5ht48PerguxsaYYAHnfYjSS/+CnNx2pTYaU+arBEPeKf9JElwkSfE+FedQgFMbxOBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=DwPHzoUM; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="DwPHzoUM"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:5:f011::a05d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hCBWD2FLDzyxN;
	Sat, 01 Aug 2026 21:37:28 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1785609449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xctAWdVs69q8IrnkhM5tY43/8IJY/R844Lzb6UL23eo=;
	b=DwPHzoUMpF+ihrNq9X66xUWoxx8nSFuMtborZumyefURQauDPKvY6fcOiZoCQE2/rkyUCb
	Y2XlVEkGoZ7+8lVXmSy1Z7AWcCZ7xPliNT0RadKzMtdi0j0WmrCHJ50PQt9z3OXG/7Lz61
	NoECuu3veDFOx0i+wLl+uGQjBELbWHA=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1785609449;
	b=wQSfL+xjYfEJEUWymwud8PkA8A+qCwN0Uf3UEZllVBz2tJuyHN1HBg79NvUkDPnp9ufJqt
	H011nG0rEKYG5+ovEOF2TUB27YNqAjx4rnjJ3L/vokvttb6Q1eOTpd6UlrUu2gje/vweY7
	r8v2dJPlt4qoA12IijGTtTWxl6jgpr8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1785609449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xctAWdVs69q8IrnkhM5tY43/8IJY/R844Lzb6UL23eo=;
	b=yxCpRmaQR1gU131Bi6cqtAAcLy+3E5ToyTXdDEkjxh8xTxhKD6DuBPdEhrbPMblvnjVgXZ
	usYVQVNFYz8ihT3ahfWk8VaLZnycrYcWZZW+Ct0YYoSXocCHiPnErnmLKXg6RoGwskN8Te
	IT7afhoHViCCwJGy845dc1fZ3vMyAtQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	syzbot+9c40ad7c6ed7165e46e8@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH 1/2] Bluetooth: L2CAP: use proto_lock for l2cap_data to fix l2cap_disconn_ind
Date: Sat,  1 Aug 2026 21:37:23 +0300
Message-ID: <a672a4ee3d24c93156c51ef84ca4dc3364a18109.1785609341.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_conn::l2cap_data is accessed without locks in l2cap_disconn_ind via
hci_conn_timeout (disc_work) -> hci_proto_disconn_ind ->
l2cap_disconn_ind.  This is UAF if the l2cap_conn is deleted
concurrently.

disc_work is disabled sync in hci_conn_del(), so we cannot take
hci_dev_lock in disc_work.

Fix by using proto_lock to guard l2cap_data, in addition to hdev->lock
which is held in other access paths.

Fixes: ab4eedb790ca ("Bluetooth: L2CAP: Fix corrupted list in hci_chan_del")
Reported-by: syzbot+9c40ad7c6ed7165e46e8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9c40ad7c6ed7165e46e8
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/l2cap_core.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 1156aba4e83c..30d7120d3a15 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1833,7 +1833,10 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 	hci_chan_del(conn->hchan);
 	conn->hchan = NULL;
 
+	spin_lock(&hcon->proto_lock);
 	hcon->l2cap_data = NULL;
+	spin_unlock(&hcon->proto_lock);
+
 	mutex_unlock(&conn->lock);
 	l2cap_conn_put(conn);
 }
@@ -7168,8 +7171,6 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
 	}
 
 	kref_init(&conn->ref);
-	hcon->l2cap_data = conn;
-	conn->hcon = hci_conn_get(hcon);
 	conn->hchan = hchan;
 
 	BT_DBG("hcon %p conn %p hchan %p", hcon, conn, hchan);
@@ -7198,6 +7199,11 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
 
 	conn->disc_reason = HCI_ERROR_REMOTE_USER_TERM;
 
+	spin_lock(&hcon->proto_lock);
+	conn->hcon = hci_conn_get(hcon);
+	hcon->l2cap_data = conn;
+	spin_unlock(&hcon->proto_lock);
+
 	return conn;
 }
 
@@ -7582,13 +7588,18 @@ static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 
 int l2cap_disconn_ind(struct hci_conn *hcon)
 {
-	struct l2cap_conn *conn = hcon->l2cap_data;
+	struct l2cap_conn *conn;
+	int ret = HCI_ERROR_REMOTE_USER_TERM;
 
 	BT_DBG("hcon %p", hcon);
 
-	if (!conn)
-		return HCI_ERROR_REMOTE_USER_TERM;
-	return conn->disc_reason;
+	spin_lock(&hcon->proto_lock);
+	conn = hcon->l2cap_data;
+	if (conn)
+		ret = conn->disc_reason;
+	spin_unlock(&hcon->proto_lock);
+
+	return ret;
 }
 
 static void l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason)
-- 
2.55.0

