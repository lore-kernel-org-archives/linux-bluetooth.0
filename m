Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790FD39FCDB;
	Sun, 28 Jun 2026 12:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782648775; cv=pass; b=MbKUmGl2tp1W2/hyAIIsYO00K4b976jQEB+kKg2HDdPUBK9SDsEJGURAn52iEIEYWGtMIQNtwLBEyeLwgN4KrgL9dKRrs3r8W9t8hqsKQyKpVaBStIG9ydD/zaZdl3sB+/TInJy3dqevrEnZqQQxHVA5/ZvsQe0zUgfzW2kn+1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782648775; c=relaxed/simple;
	bh=7RyyZgf2CgSd7mw2O6rGgbH96zzazhJ+oJTUg0y745M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NmscbK7nPiX4Sz2nhN/t2nWJYIPb61BYqDaL+/xnw6GliNI3MoYsnjhnj0Aw0Jqy05yq61QxHd/QsmULXrT2m+MVjIk/OtziAoNchdsU7kLv61JxDTtv4xtmPxXtrojXyHXfQTcpJW0FGsszoB04ePEqJGNmj1nRSplyeu+GAlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=UFKhpFO7; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="UFKhpFO7"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gp7b22VN6zytg;
	Sun, 28 Jun 2026 15:12:46 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1782648767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kry5Xe22ZwK4sLgQag0U+GC9Dcl+PCxSKudwF5Tqg7A=;
	b=UFKhpFO77SoXnb7WtARZkOImEO2cpGrZpoRyRzzGVH7ORG7WqifIdfYegSC7FwkOgZU0Qv
	5JuXItORfoatfVV+zXdTB4bvB6TYP+m82ge44VHk6tQ5kArzRvb0VGgrz6ax7SZ/hAi+fd
	tjl4pBQwukG3/3Sfsh8wRYOpqixjMSA=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1782648767;
	b=Yy4SN837NEo1Ls6D96SLtJnLsgXL6RLNWO4hZf0SvovUJo6udD06KI/HtSSla1WR3D0ufQ
	xOe5J8zOqrkRL58YtUymJmx4EATijSZNaXDWUvcQyEzuLFxya78rrl7ZkTYjs3qdFDibO6
	KjzHoTSv6AROjPGH8pMO6pNcIIWK9l4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1782648767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kry5Xe22ZwK4sLgQag0U+GC9Dcl+PCxSKudwF5Tqg7A=;
	b=ff/qh4ffWyUfnhkYD8SJ7FrT/cSIVUyWsWBi0XfTfqNF2h/XAceT6v5kaRKX/+3nHish3t
	K43LGN1iFLhlhBPtm8ee4q96/Q5p0bWfPn0DEzJw9uUXnzJqgM2IuD/HfA+FL1poSu1+lP
	NQB9NbfatXQTfuIpPwICFZ2z2+N8FzA=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	oss@fourdim.xyz,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/7] Bluetooth: hci_sync: hold conn in hci_connect_big_sync() callback
Date: Sun, 28 Jun 2026 15:12:34 +0300
Message-ID: <f2ec5f0d1e39d7fce1949bc957657ce1c53f29eb.1782645211.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <7a22e9136652bfc95b52bacc146e5ac461b82ec2.1782645211.git.pav@iki.fi>
References: <7a22e9136652bfc95b52bacc146e5ac461b82ec2.1782645211.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is theoretical UAF if the conn is freed while the hci_sync task is
running.

Hold refcount to avoid that.

Also hold RCU for hci_conn_valid(), otherwise the return value is
meaningless.

Fixes: 024421cf3992 ("Bluetooth: hci_conn: Fix not setting timeout for BIG Create Sync")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v3:
    - split to multiple patches per different Fixes:
    - hold RCU instead of hdev->lock

 net/bluetooth/hci_sync.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 66f42a3dc5a1..1ec37f6db213 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7372,10 +7372,17 @@ static void create_big_complete(struct hci_dev *hdev, void *data, int err)
 	bt_dev_dbg(hdev, "err %d", err);
 
 	if (err == -ECANCELED)
-		return;
+		goto done;
+
+	rcu_read_lock();
 
 	if (hci_conn_valid(hdev, conn))
 		clear_bit(HCI_CONN_CREATE_BIG_SYNC, &conn->flags);
+
+	rcu_read_unlock();
+
+done:
+	hci_conn_put(conn);
 }
 
 static int hci_le_big_create_sync(struct hci_dev *hdev, void *data)
@@ -7427,8 +7434,11 @@ int hci_connect_big_sync(struct hci_dev *hdev, struct hci_conn *conn)
 {
 	int err;
 
-	err = hci_cmd_sync_queue_once(hdev, hci_le_big_create_sync, conn,
+	err = hci_cmd_sync_queue_once(hdev, hci_le_big_create_sync,
+				      hci_conn_get(conn),
 				      create_big_complete);
+	if (err)
+		hci_conn_put(conn);
 	return (err == -EEXIST) ? 0 : err;
 }
 
-- 
2.54.0

