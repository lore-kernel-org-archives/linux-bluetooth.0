Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC78F175A77
	for <linux-bluetooth@vger.kernel.org>; Sun, 29 Mar 2026 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774798821; cv=pass; b=afAiv6/8yjb4CfWCr7uRGjXhzvoZEzWnGWPdKOSNLRnZKPaYizrAcQ3UcqoBKIOa6wAzcpdRvmKhC62W+YTyr1v23kbYUxJWReTjej8Xta8MrotDgrMt8oosvwoj9jNIvzoVeWYJyMlQFVA0s43YBkozPa3zthbtWf7Po93BZHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774798821; c=relaxed/simple;
	bh=g8fhRLLeDPukBh7ydK9jCXIVf/bSf/hChwc2l2HRCF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c17kAc6RENO/PzChWM+KnZtUlfzJ8HbudytUrpW+9JzYOcS76XYiyPqQjM0Pd19immHabFGLyDL9YqvKOowXgdISo7KIwTDEwAnKBUeMzD1emHjoZpMEd5pVQNwe+adjgN/nR7ICOi6Pg3NbdNpGW6/M0kU0fIJBLIMtAPe+5aU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Tl3cI2XW; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Tl3cI2XW"
Received: from monolith.lan (unknown [IPv6:2a02:6ea0:1508:6::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fkJVT10S1zyR8;
	Sun, 29 Mar 2026 18:40:16 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774798817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q+zFey+oH0FrmZ0KRwR4ymQPu/2I4Y/uG4vd+t4Advg=;
	b=Tl3cI2XWKBPNPu7cadLZ6SjmCdw+aNYCVk8NhkVlVSK4RJyFzPYDt6Xjqv52Av39+gN9nu
	C1HXqYYAA/Q457SWnMyMdWx6NN6tTS+cYmnpEKtEIn37nioz2rccxYIuwG1Y9NcbSp4K7j
	2aDwNMQQfAXt4Z4BGdiRRYVEqR5bRYg=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774798817;
	b=A/T4VjfaYCijiYNoduZY26LW13MiWyjzTn7Fxh9Tw7aFN3bO8P4oSjK/vB+HgzOBmnL8AT
	6KCcQ7qVW4peAy68vx3ww5K2pu5oKwWXdC6baszoqC1rrbYkZY8aJ+/fihGL78XT84o1kW
	q7rLfu4SQn8uKgfI2Vk6cHjVH3d9Htg=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774798817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q+zFey+oH0FrmZ0KRwR4ymQPu/2I4Y/uG4vd+t4Advg=;
	b=bkBo8IvG/cay18TIjlbL5qQlwKuVTTqq6dmaJby18tKqV6lvMTAdTfg5G/kyy+71bhJdGo
	0Gz4umGOkLeUXJ/avKZ+3r7Dg0v0fERlIPKr19TyBj/Xk/C8qvsAI66JAoT8gfSAa0cXD5
	YY6/jTRCMHvD4WGItA/A6RzAsAKAT94=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH v2] Bluetooth: hci_sync: fix refcounting in le_read_features_complete
Date: Sun, 29 Mar 2026 18:40:02 +0300
Message-ID: <160b4c8732c904a6e3d52c192a7620ac131f9511.1774798184.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_conn_get() refcount acquired in hci_le_read_remote_features() must
be unconditionally released in the destructor, or it leaks.  The
destructor is always called if hci_cmd_sync_queue_once() returned with
success.

It also looks like removing the hold/drop logical refcounting here by
commit 60562bebb651 ("Bluetooth: hci_sync: Fix UAF in le_read_features_complete")
caused a behavior change (mgmt-tester Adv. / Ext. Adv. test failures).

Fix the destructor le_read_features_complete() to always release the
refcount.

Also restore the logical hold/drop refcount, preventing the hci_conn
from timing out during this command.

Fixes: 60562bebb651 ("Bluetooth: hci_sync: Fix UAF in le_read_features_complete")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v2:
    - restore also the hold/drop refcounting
    
    This probably should be fixup in bluetooth-next/master if it wasn't
    pulled yet.
    
    Restoring the hold/drop makes the following mgmt-tester tests pass
    again:
    
    Adv. connectable & connected (central) - Success
    Adv. non-connectable & connected (central) - Success
    Ext Adv. connectable & connected (central)
    Ext Adv. non-connectable & connected (central)
    
    It's not clear to me whether there is something wrong with these tests,
    but probably the behavior change was unintended so it's better to
    restore it.

 net/bluetooth/hci_sync.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 91d0252ae661..0c6baba4e69c 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7390,9 +7390,7 @@ static void le_read_features_complete(struct hci_dev *hdev, void *data, int err)
 
 	bt_dev_dbg(hdev, "err %d", err);
 
-	if (err == -ECANCELED)
-		return;
-
+	hci_conn_drop(conn);
 	hci_conn_put(conn);
 }
 
@@ -7463,10 +7461,12 @@ int hci_le_read_remote_features(struct hci_conn *conn)
 	if (conn->out || (hdev->le_features[0] & HCI_LE_PERIPHERAL_FEATURES)) {
 		err = hci_cmd_sync_queue_once(hdev,
 					      hci_le_read_remote_features_sync,
-					      hci_conn_get(conn),
+					      hci_conn_hold(hci_conn_get(conn)),
 					      le_read_features_complete);
-		if (err)
+		if (err) {
+			hci_conn_drop(conn);
 			hci_conn_put(conn);
+		}
 	} else {
 		err = -EOPNOTSUPP;
 	}
-- 
2.53.0

