Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6B5DF59;
	Fri, 24 Jul 2026 20:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924450; cv=pass; b=qQMKMeqjcc60VD63pZzf4MsCuJ1KcwzTZ+w+qA6d4jGh8LMiPElnmv+MtQ8HvlgLKLpuSbnKO6KLJA9IMGAXWLm+PYtTDTX64NIDCInK/y7reMsBDp9fjSQJlisZa7xW7oMMbFVvxA+ephf+7X1dp0Htka0noYomiGDWZBYTYwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924450; c=relaxed/simple;
	bh=GWrBnQIPkOAt6xFzLtc6KpNPC82paWIxXdI4xcCnLo4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eqQwUcI1M5UeBAXKMwJVXI38ddxHevHRp8xgjkusjDvo/m/kgaGkQ23/0kMvtMaq4MBeNLf22E/i7RbYzbppN0sIbA2kifO0gwV0rM/o/P2tJ3VjedXwV6oUT6n/HURFF+eHUYP6AYPSNoXJsQ5EK4SFIfM9rV90/rQ+5vGR4T8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=oYtK9RsT; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="oYtK9RsT"
Received: from monolith.lan (unknown [89.37.63.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4h6K9z4gkgzyPm;
	Fri, 24 Jul 2026 23:20:39 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1784924441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Lz5uf4iZDicoYHWK0dQGDLw4b6YPpUi6bt5WDhf/+v0=;
	b=oYtK9RsTsOhiDBigM39BDJew1TWiNhpe6L2N8HluRY0zUhlEy/wPlGBBnGKVwNHYDHZw7a
	onfV+5PqMSQ7H3Hf/VyZk5RSff+G0bCWYwOHggl/h1aSq6KkilhHLLcazDzk8wxjSpCXs8
	65luL5rbjvwlagM5Eqhq7l/KzvJWeYk=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1784924441;
	b=slIAtMelDWwUGm8TMKPsv4vxIzbUsoDtCy4LIdac8Zv4LhkmV8/tx+/5/79l/FkLDrCXxD
	nW9LUbGg7mwC/WS6GEGazU4ASdps2ST659KfE1H+7wNUmJtlc2A/6juyYYNL18DFQwBH1X
	HAJWif+GbdXZdKIDStcC3AUV+wy8wuI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1784924441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Lz5uf4iZDicoYHWK0dQGDLw4b6YPpUi6bt5WDhf/+v0=;
	b=M31eM2QI+EjIEFeMSaPyMzm/yB7WPKiyAqG7sB5kY5P9u9RlLi0H+PyhUKhUN6lsgsUGBX
	y1fT7Imq2hIBO5iH5wqbs6VuXq+swZih9Z4iVMGwYwgLIGSQripZQZz3sPXy+NL+oGXI52
	gwlu0HqL0a+Ca/7V8pGfo1FDk15NaYM=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] Bluetooth: ISO: fix HUP on socket release/shutdown + UAF/locking fixes
Date: Fri, 24 Jul 2026 23:20:23 +0300
Message-ID: <cover.1784923689.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The retracted patch in commit e824c0bbe0ec9 ("Bluetooth: ISO: clear
iso_data always when detaching conn from hcon") merged in
bluetooth-next/master broke ISO socket transition to BT_CLOSED so they
don't send POLLHUP properly any more, as seen in "ISO Disconnect -
Success" test.

This is rebased version of and supercedes
https://lore.kernel.org/linux-bluetooth/fbd9dd573bb1ce5f38370128dd35447e2ddfed9c.1784625576.git.pav@iki.fi/

The first commit in this series fixes that, and subsequent mostly
independent commits other minor issues found looking at the ISO socket
code.

The last three fix UAF issues. The locking/lifetime of iso_conn
complicates the code here and the last three patches can be replaced by
somewhat simpler solution with bigger diff that removes iso_conn
https://github.com/pv/linux/commit/e4b460b5f7aaba060b958229aaec6b2217642178

Fixed issues aside BT_CONNECT, these appear to be pre-existing in
several previous kernel releases:

- sk is always leaked on socket release

- timeout_work may deadlock under certain conditions

- correctness of iso_conn_del() vs UAF requires somewhat too complex
  reasoning about race conditions, and it's not quite correct

        [Task 1]                      [Task hdev->workqueue]
        iso_sock_timeout              iso_conn_del
          iso_conn_hold_unless_zero     iso_chan_del
                           `------------> iso_conn_put
                                      caller frees hcon
          iso_conn_put
            iso_conn_free
              conn->hcon->iso_data = NULL; /* UAF */

- attempt to free iso_conn in iso_conn_del() races with iso_conn_del
  with potential UAF

- iso_sock_ready() gets conn->sk without requisite locks, this should
  be done like in sco.c

- iso_sock_getname, iso_connect_ind are missing lock_sock and NULL
  checks

- kref_get_unless_zero(&((struct iso_conn *)hcon->iso_data)->ref)
  requires synchronization primitive.

Tested vs iso-tester, Pipewire Qemu ucast/bcast audio tests, and real
ucast audio streaming, which pass without KASAN/locking splats. Also
checked iso-tester produces balanced iso_sock_init / iso_sock_destruct
kprints.

Pauli Virtanen (11):
  Bluetooth: ISO: fix CONNECTED -> CLOSED transition on shutdown/release
  Bluetooth: ISO: lock sk in iso_sock_getname
  Bluetooth: ISO: lock sk in iso_connect_ind
  Bluetooth: ISO: fix timeout vs sync_timeout typo in check_bcast_qos
  Bluetooth: ISO: validate sockaddr_iso first in iso_sock_rebind_bis()
  Bluetooth: ISO: hold sk properly in iso_conn_ready
  Bluetooth: ISO: fix leaking sk after socket release
  Bluetooth: ISO: avoid deadlocks in iso_sock_timeout
  Bluetooth: ISO: ensure no dangling hcon references in iso_conn
  Bluetooth: ISO: fix refcounting of iso_conn
  Bluetooth: ISO: fix race of kfree vs kref_get_unless_zero

 include/net/bluetooth/hci_core.h |   4 +-
 net/bluetooth/hci_conn.c         |   2 +
 net/bluetooth/iso.c              | 274 ++++++++++++++++++++++---------
 3 files changed, 197 insertions(+), 83 deletions(-)

-- 
2.55.0

