Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4071DC198;
	Sun,  2 Nov 2025 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762100589; cv=pass; b=jgK3+O5W9g8gA2+UUgnCNZxLDBHtf4eCsYELfMe3dvapKQUXk0Vs5eoNjPvfhc6Nn7dIXpuJrysNlyScH1FRxOddhQn5/lHBy8+Nbzd6HW1aDw3PT8BoZTezGeYGyAs8UMPoOFRpnArYNG/4iqoEdHoq+rSgU9ThrvPU8KoIP2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762100589; c=relaxed/simple;
	bh=AOfntXi7LyDj1wSJH2j2FMe9t8NC5p7xPruqrOYsLTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hjwXZM+M/oJsqXUTM6WP0CxTmgyKzgER5Cje0zdzQpGHV44hXNfJlwhgQ4FwCnpY/uNMARSdC7OQqS7kvmN6hPwR0XJKhD4ATZz9dYlGubSrH5eSSRFISK9o3gyOkkxMZfZdBrifqGiwogRVv18NJkw+fCzkpt3ZMh84scU/Kc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=n/qggkrF; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="n/qggkrF"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d00PV5jK3zyR8;
	Sun,  2 Nov 2025 18:22:54 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1762100575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=54g/XPt7YVag98RqBuk/IZxBaGKIzf4fNk2CBSsrZ38=;
	b=n/qggkrFpf1pxt+PZyFjOPkTCxmFGT6gwbEuvA9FYIGtCB77F8jLv1bxMruIl8pl23x5JT
	dwqoZ3zH8G0yRozhozL14sZAsPMjKWctzUIb0toYz6hf6T+8ZuC46PPWGBJOIqKvQRIDuZ
	Jqrf0kppLLG7K4GBMckuQPZhC0FzLs0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1762100575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=54g/XPt7YVag98RqBuk/IZxBaGKIzf4fNk2CBSsrZ38=;
	b=fG/FBNPwrrrbgCRN5auR9rwxuPFjfcR8xn+yOs67ce8nsGeqqzbb+t0VokvbD3WNBmOws6
	5erra+AbnWcF58i5VaWS7tLG05FZ5fIi7icY2Gt97WKjFvPqUr5KSMb5LtpRV8X95WABQJ
	P+Qv6FUNp4vgl4CHYguabixoQpHnW+s=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1762100575; a=rsa-sha256; cv=none;
	b=fu0hYzD62Gty2t+GQrFGcnqoa1Ysa4yG72jHjsWD37X87bBgiVI2lbxFWCtmvye97hT1Nq
	+gLhkPO6MbDvv9O93qrVwqRq45fISAjOrdMT11TrZydLiMAY//0ILYNxY1epLZYJ6Id7Dm
	10ZNTRfCSlOCvuVHZE6goVai2Xp1mac=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] Bluetooth: avoid concurrent deletion of hci_conn
Date: Sun,  2 Nov 2025 18:19:32 +0200
Message-ID: <cover.1762100290.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This contains the simpler fixes from
https://lore.kernel.org/linux-bluetooth/cover.1758481869.git.pav@iki.fi/

Changes:
  v2:
  - Fix also hci_past_sync()
  - Drop "Bluetooth: L2CAP: fix hci_conn_valid() usage".
    This does not fix the race completely, as conn->hchan also
    can race, so leave for later.

hdev has two workqueues that run concurrently, and both may delete
hci_conn. hci_conn* pointers then require either (i) hdev/rcu lock
covering lookup and usage, (ii) hci_conn_get reference held, or (iii)
other more complex invariant.

If none applies, it's likely there are corner cases that hit UAF,
especially if controller misbehaves.

Trying to protect access with "other invariants" is quite error prone,
and I don't think there are such in most of this series.

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
does is strictly speaking undefined behavior (kmalloc is not guaranteed
to not reuse addresses).

Some of the existing code is missing locks for (3), those need to be
addressed in separate series.

Pauli Virtanen (8):
  Bluetooth: hci_event: extend hdev lock in
    hci_le_remote_conn_param_req_evt
  Bluetooth: hci_conn: take hdev lock in set_cig_params_sync
  Bluetooth: mgmt: take lock and hold reference when handling hci_conn
  Bluetooth: hci_sync: extend conn_hash lookup RCU critical sections
  Bluetooth: hci_sync: make hci_cmd_sync_run* return -EEXIST if not run
  Bluetooth: hci_sync: hci_cmd_sync_queue_once() return -EEXIST if
    exists
  Bluetooth: hci_conn: hold reference in abort_conn_sync
  Bluetooth: hci_sync: hold references in hci_sync callbacks

 net/bluetooth/hci_conn.c  |  22 +++++-
 net/bluetooth/hci_event.c |  33 ++++----
 net/bluetooth/hci_sync.c  | 157 ++++++++++++++++++++++++++++++--------
 net/bluetooth/mgmt.c      |  42 +++++++++-
 4 files changed, 204 insertions(+), 50 deletions(-)

-- 
2.51.1

