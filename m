Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C62282E1
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Sep 2025 19:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758482095; cv=pass; b=Gwqqfl1AkVUwOQEQ/UiMpIWY5183PL4AzhcxW/FG0dx+mIQAN1ZBsg2TN1lNLjQvcN1F6zi3KprC+hm4rqd+TmXz5zL9jaluC3vCRCc5OUVj7G38MEAtcJhS+UbLj+SvPYsmv44IohiE/pzQmXCTs3bSPseC52mKN5dT7xBX5B0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758482095; c=relaxed/simple;
	bh=xYoTsnrEEYWBqVZpfmRUACMb1SLLIerFusWNVFYCfnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EavUU6XFeCcq4mDN+ES7atovKN962Gm+jgNHdsL2hZgLFwUVooTC4Y9FRUjQxKySBlgEof+ce4Pqca/SkDv0PqtgtOM7US7agWTLkLeRgx55D0ly1H4exfg8QcOvub7yZrRMz1g+GxSfQBvquX5po/iI7e+ThMyhao6VfzqvrRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=wEiEJLW/; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="wEiEJLW/"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cVGC95XCYzyYl;
	Sun, 21 Sep 2025 22:14:45 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1758482085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hvGvDEsGRkP6gLHG8w/x+ezWagzY6766qvdydEaK+1U=;
	b=wEiEJLW/3a0HbibRLniTatPmZwOwvpwaYfe7EaLZxx0J5WwmjWE8hqWIC21Piy7oDAcnjY
	h4EQs8XtWfPff9naVC7BT32/AbxnVJtgYtDjK9dFkv9MjFKsGV7Dqgv3+9LvoReKK/JT9I
	rJS8l2GAo+fzXAL7UGdkWxMCK2p6504=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1758482085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hvGvDEsGRkP6gLHG8w/x+ezWagzY6766qvdydEaK+1U=;
	b=Qu4PFqzUBeHEFiOb8KOu+f9KsWKJ5VQhQQRjEyPZXCZhDHpWcy3lORqgb+iDEAZctVEEjn
	p9sjh+xu/blCUuzs3Z/K2TPfMWw+n22rdcn5euOi5O2yEXXLjXWvV5/CFq+ukYKuOTbTFX
	TVkTXxgK6HW5nWsaVxBmV/qfcdvszJM=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1758482085; a=rsa-sha256; cv=none;
	b=h8XNiA3x1LmrVo4Jc5pEiHrgaVK3mERNUSE2AdwDE9XQELmroQK3rfBp7pIqDCr6TJE8n3
	k83ndbLJSe+9IVeaddqnylrbbBYhqaxD78VBsz0oGCZEVkWFZu53m9iaDmLDLgsQESnwVZ
	eYm/3SjQuxDViG0/CuRbWLJmPqIpkEw=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 00/24] Bluetooth: add locks to hci_conn accesses
Date: Sun, 21 Sep 2025 22:14:15 +0300
Message-ID: <cover.1758481869.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

(RFC since this needs to be tested much better.)

Each hdev has two ordered workqueues that run in parallel, in addition
to user tasks and some timers in global workqueues.

Both workqueues may delete hci_conn* and modify their state. The current
situation is there are races and UAF due to this.  In older kernels, it
used to be much of the work was done from a single ordered
hdev->workqueue, so one could be more lax with locking.  I don't think
what used to be safe earlier is necessarily so now, so some simple rules
are probably needed.

Set some rules for hci_conn* locking and try follow them:

- lookups: hdev->lock or rcu_read_lock() shall be held by caller

- field access: hdev->lock shall be held, unless lockless operation is
  explained in comments, in which case rcu_read_lock() is enough

- hci_conn pointers remain valid after exiting critical section only if
  hci_conn_get() refcount remains held

- before field access, if hci_conn* was sustained only by refcount,
  hci_conn_valid() shall be checked before dereferencing

***

Add lockdep asserts to lookup functions and hci_conn_valid() to catch
some bad callsites.

In hci_sync, the critical sections cannot extend across HCI event waits.
There, add helpers hci_dev_lock/unlock_sync(hdev) that release/acquire
hdev->lock before/after the wait.

Following the rules above then means checking hci_conn* validity after
each call to a waiting subroutine.

This series also contains some fixes to ABA issues: if hci_conn pointer
is used across critical sections, one should hold a refcount, and not
use hci_conn_valid() on potentially wild pointer even though it doesn't
dereference.

Pauli Virtanen (24):
  Bluetooth: ISO: free rx_skb if not consumed
  Bluetooth: ISO: don't leak skb in ISO_CONT RX
  Bluetooth: hci_sync: make hci_cmd_sync_run* indicate if item was added
  Bluetooth: hci_sync: hci_cmd_sync_queue_once() return -EEXIST if
    exists
  Bluetooth: hci_conn: avoid ABA error in abort_conn_sync
  Bluetooth: hci_sync: avoid ABA/UAF in hci_sync callbacks
  Bluetooth: hci_event: extend conn_hash lookup RCU critical sections
  Bluetooth: hci_sync: extend conn_hash lookup RCU critical sections
  Bluetooth: mgmt: extend conn_hash lookup RCU critical sections
  Bluetooth: hci_conn: extend conn_hash lookup RCU critical sections
  Bluetooth: hci_core: add lockdep check to hci_conn_hash lookups
  Bluetooth: hci_core: add lockdep check to hci_conn_valid()
  Bluetooth: hci_sync: fix hdev locking in hci_le_create_conn_sync
  Bluetooth: hci_core: hold hdev lock in packet TX scheduler
  Bluetooth: lookup hci_conn on RX path on protocol side
  Bluetooth: L2CAP: fix hci_conn_valid() usage
  Bluetooth: hci_sync: add helper for hdev locking across waits
  Bluetooth: hci_sync: hold lock in hci_acl_create_conn_sync
  Bluetooth: hci_sync: hold lock in hci_le_create_conn_sync
  Bluetooth: hci_sync: add hdev lock lockdep asserts in subroutines
  Bluetooth: fix locking for hci_abort_conn_sync()
  Bluetooth: hci_sync: lock properly in hci_le_pa/big_create_sync
  Bluetooth: hci_sync: fix locking in hci_disconnect_sync
  Bluetooth: hci_conn: fix ABA and locking in hci_enhanced_setup_sync

 include/net/bluetooth/hci_core.h |  66 ++++++-
 include/net/bluetooth/hci_sync.h |   4 +
 net/bluetooth/hci_conn.c         |  83 ++++++--
 net/bluetooth/hci_core.c         | 114 +++++------
 net/bluetooth/hci_event.c        |  33 ++--
 net/bluetooth/hci_sync.c         | 315 ++++++++++++++++++++++++-------
 net/bluetooth/iso.c              |  34 +++-
 net/bluetooth/l2cap_core.c       |  28 ++-
 net/bluetooth/mgmt.c             |  38 +++-
 net/bluetooth/sco.c              |  35 +++-
 10 files changed, 551 insertions(+), 199 deletions(-)

-- 
2.51.0

