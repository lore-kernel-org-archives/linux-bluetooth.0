Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D20E299A81
	for <linux-bluetooth@vger.kernel.org>; Sun, 29 Mar 2026 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774791793; cv=pass; b=q4U3j2ubq2T7GSptK9ZkwEbSceO51dUZ4mp7YxFlGjY3Uoawiu9f+lp4LtwC+bsVafaUvW+dzmEigKsPc0ZkZW6BQyqn0BQK0/NdxZUm5H8cvewVvVkJmnKxHt7ESUPsyjPsMBwInXI5OyOoY6GdsSN32UMAOMe5dE2oMr/nBEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774791793; c=relaxed/simple;
	bh=ujjOmUZ/zUe06d5ZwTyzhHvO9mlo7wW/RHbUsMCREzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uJQWMHEWRwqt4Zs24oQGbvfwekKryUsCnV3bUjw92FVSGcP4PPNLvIuuqrv+7lMfgP/OtFlc1hyIFJ90jmipFYXuNkfxNCtYTOZxclU89DS851FvTTPmw0Jx/URIdKYBikzY3sSErsx+LFLmIkg2CF/EDtWi2Wf2X5B2ZMHRzpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=KwOK0dgH; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="KwOK0dgH"
Received: from monolith.lan (unknown [IPv6:2a02:6ea0:1508:6::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fkFvJ3BtlzyPs;
	Sun, 29 Mar 2026 16:43:08 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774791788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5a6fUpBdLa2WXp68sWAorTSqPufAUPx9TywN9EJi7h0=;
	b=KwOK0dgH9jr7Yqnxnwy1fD5njqez7WLc76Ty4YKZ2p4JK5zXyftYrFafGl+1HC2jx6vLwN
	R0zonfk57qYXX1lUcJxRojFHIMwXa82GpBlMJrKN9ujHGqUTwwybzWyypUtPKfkmicpEe1
	3CLkf3f43A7u7ZTXKrAbXCVZIWQZ6lM=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774791788;
	b=TNsFAxLMPElBdOxamtaVDf+rN8f8rW0APym6Ue6GGhLYkxdaGpdADmergQFmgsMJG6LB5k
	Y1Rq/7aH5kwAqSZwz7PkrhN14TAsLMcar5bUroIGnQenOKj++z5JG0kW4I8thRnVAzdfWf
	N3a+8mDdK0OIpgv9AqIrVVuKW5o++I8=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774791788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5a6fUpBdLa2WXp68sWAorTSqPufAUPx9TywN9EJi7h0=;
	b=Yg+P/qt0tZrpdhbMOt2Da9jQr/Z+ALaWwiSy+d5uFk6iJ8WY0tDe+9TwsiEZ3bMLBknGzr
	etOiM6cu48bE1NTb25KY2WYqiUhcAsXaCDBB9MVuzFromCAuZthd8Twn7wuQE8qXrh6iiE
	5NyEADm0SZNcHciae4Oc4uNEs43vUbw=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH] Bluetooth: fix locking in hci_conn_request_evt() with HCI_PROTO_DEFER
Date: Sun, 29 Mar 2026 16:42:59 +0300
Message-ID: <089f435fb4668921bb416a3d60fa0f232456e054.1774791296.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When protocol sets HCI_PROTO_DEFER, hci_conn_request_evt() calls
hci_connect_cfm(conn) without hdev->lock. Generally hci_connect_cfm()
assumes it is held, and if conn is deleted concurrently -> UAF.

Only SCO and ISO set HCI_PROTO_DEFER and only for defer setup listen,
and HCI_EV_CONN_REQUEST is not generated for ISO.  In the non-deferred
listening socket code paths, hci_connect_cfm(conn) is called with
hdev->lock held.

Fix by holding the lock.

Fixes: 70c464256310 ("Bluetooth: Refactor connection request handling")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    This defer listen code path is covered by sco-tester
    SCO CVSD Listen Defer - Success

 net/bluetooth/hci_event.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3ebc5e6d45d9..83248085dd4f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3340,8 +3340,6 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
 
 	memcpy(conn->dev_class, ev->dev_class, 3);
 
-	hci_dev_unlock(hdev);
-
 	if (ev->link_type == ACL_LINK ||
 	    (!(flags & HCI_PROTO_DEFER) && !lmp_esco_capable(hdev))) {
 		struct hci_cp_accept_conn_req cp;
@@ -3375,7 +3373,6 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
 		hci_connect_cfm(conn, 0);
 	}
 
-	return;
 unlock:
 	hci_dev_unlock(hdev);
 }
-- 
2.53.0

