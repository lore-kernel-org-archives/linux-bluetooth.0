Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2072D8378
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Oct 2025 17:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759511351; cv=pass; b=dhRZNx1zunnCTbGMVXQC9320FgN3RmyKf1WO+E+3K4p5ZOkMKBRLfP2PQnOK+Zx3COJkfAWEVNXG5fLxIYu6kz3VvAldNdgzZwnNt2QIKsX7El8+50g34lQTMjtFSorQOAyx+TE2dVNBhAtxT6JpjYrHP6WPANLH1LjSmD7JMyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759511351; c=relaxed/simple;
	bh=FEa0IinCtwQfPUatGj96rhTe517HjC5OCh2AaeCwlHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uWxrOlss6YTx7aBZO/hoqPyzEJcKoVtd9NU5kA6TDMi6K9rElvLML7wQnfAfHZHcEwl+1/i5H3Yoe3J9HOfueFe5x6bAvrnqahc1HweKIoIIi1ju01brrnwWUedafRDCUHhbxVlzD7BcxGaVqJFv9nH3Qh/cTVVkwJ0aWCYH0SQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=uDxUZCvh; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="uDxUZCvh"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cdZrV4j1RzyRk;
	Fri,  3 Oct 2025 20:08:58 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1759511338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Jn5QIRoHPX3fhsCs+M7IZe5R0ptNLLVjPhfFCr+81+c=;
	b=uDxUZCvh/dVXPCL6raHSVyl8N3mf8rRWrSv0+0VzSC4szTGSLPiAAtVinqZw1OKLXGNt4D
	xH2u7dEIiYSIZW4D47n7YfNG+Sn9X+3nM8S94vqDK/sHnuZvumUZkoDdWpyRJpFqrbtEDW
	HJnOWpWOnUvW2C+tdDVoM0nULXsIlgs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1759511338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Jn5QIRoHPX3fhsCs+M7IZe5R0ptNLLVjPhfFCr+81+c=;
	b=cvWjv/5cANWfBCbP2LhNY6e0kh5pSz+uQ+tkhjK8ynggOXDU8rlSIC6HKopCqplfS7SjY7
	mn200ZjfV/kYt44YdnPo0wTMbhEv1H6u2G3i5XAQL+xMLUtFkb7hwn01QW/hmMMA2LWg1E
	cBDiXOsZ4jCFZ8lYmjKDowSVnIQ+dBM=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1759511338; a=rsa-sha256; cv=none;
	b=QOl/QrIFw8hNmRoHstGuYq1laJ9+zqtt2e6AGdnPNJu0UgKjk7FDCaAR2tIupre9PjKIeO
	zAPNVkwp4SKWvc/2FQHhZ3oko6JChF8I93h8/8yaKU18sI6rb3SGl+8JkqzI0ErzI3t0EM
	NpDARIMv1XYztpdDq+v9MhZ+Hwj7aiI=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 0/9] Bluetooth: avoid concurrent deletion of hci_conn
Date: Fri,  3 Oct 2025 20:08:43 +0300
Message-ID: <cover.1759511032.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This contains the simpler fixes from
https://lore.kernel.org/linux-bluetooth/cover.1758481869.git.pav@iki.fi/

hdev has two workqueues that run concurrently, and both may delete
hci_conn. hci_conn* pointers then require either (i) hdev/rcu lock
covering lookup and usage, or (ii) hci_conn_get reference held.

If neither is done, it's likely there are corner cases that hit UAF,
especially if controller misbehaves.

Correct code in several places to follow the patterns (1)

    take lock
    conn = hci_conn_hash_lookup(...)
    if (conn)
	do_something(conn)
    release lock

or (2)

    take lock
    conn = hci_conn_hash_lookup(...)
    if (conn)
	conn = hci_conn_get(conn)
    release lock
    do_something_carefully(conn)
    hci_conn_put(conn)

Generally do_something_carefully should do (3)

    take lock
    if (hci_conn_valid(hdev, conn))
	do_something(conn)
    release lock

hci_conn_valid() shouldn't be called unless refcount on conn is known to
be held, as the pointer may otherwise already be freed, and even though
hci_conn_valid() doesn't dereference the comparison of freed pointer it
does is strictly speaking undefined behavior (kalloc is not guaranteed
to not reuse addresses).

Some of the code touched here is missing locks for (3), those need to be
addressed in separate series.

Pauli Virtanen (9):
  Bluetooth: hci_event: extend hdev lock in
    hci_le_remote_conn_param_req_evt
  Bluetooth: hci_conn: take hdev lock in set_cig_params_sync
  Bluetooth: mgmt: take lock and hold reference when handling hci_conn
  Bluetooth: L2CAP: fix hci_conn_valid() usage
  Bluetooth: hci_sync: extend conn_hash lookup RCU critical sections
  Bluetooth: hci_sync: make hci_cmd_sync_run* indicate if item was added
  Bluetooth: hci_sync: hci_cmd_sync_queue_once() return -EEXIST if
    exists
  Bluetooth: hci_conn: hold reference in abort_conn_sync
  Bluetooth: hci_sync: hold references in hci_sync callbacks

 net/bluetooth/hci_conn.c   |  22 +++++-
 net/bluetooth/hci_event.c  |  33 +++++----
 net/bluetooth/hci_sync.c   | 144 ++++++++++++++++++++++++++++++-------
 net/bluetooth/l2cap_core.c |   8 ++-
 net/bluetooth/mgmt.c       |  42 +++++++++--
 5 files changed, 202 insertions(+), 47 deletions(-)

-- 
2.51.0

