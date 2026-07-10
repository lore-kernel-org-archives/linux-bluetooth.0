Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09513E123C;
	Fri, 10 Jul 2026 08:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671845; cv=pass; b=iON+T+nx8Og961e1ITRoVnvsdjhOIY7RtwpWyyQ+JS9dnoTLE5oIArI1WWBGZwq/NCxxhbVdCHiw+Z/z2SR3JgyPF2nCSt8aKkCsGccYYwH/n7LTlgm36YsyivlB7umZMP7R/Z52xEukO35Ybu/XpPj0ov4u8eeoS579YWeeAuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671845; c=relaxed/simple;
	bh=DyPXXondcoJjNIyhmhzboSdVju7GluiDnFeOKzmRq1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PtwFmLjqLrCzvHJMec8dfAjhphd4AKN67nIKmM4+ttmAZC0drA6kzfisT7/bm8IrW81LellgQByXWAosc/yQosbFnYkWtbfINlP/T6apeEalM6zyVH1zsj18iUqe4iseqKMMspZKelhAbfsWXlh9a5Y6ShFox0vkLC4P2bAZpHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=fM/6EP36; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="fM/6EP36"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gxPxQ3ljGzyQw;
	Fri, 10 Jul 2026 11:23:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1783671835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mPuYuBoZ9Q+WnVTIgAUQvPui+pR+T3J0OKDYU8ozSrw=;
	b=fM/6EP36axIzWewa3tfhUa/wvDD/cZhQQbA/dhz6htiaj0ijmmUcah4cxTcFntH7rRhquP
	enoivg+C+wZxB06rvX40KduU/gzQqZwSWKu6r6o0rHZO6pP+3nn7B42vHDPo2xSix4FKs/
	p8ssXjC6IjDsLhO/WSHV6VS8IcfVVrM=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1783671835;
	b=pV+Sd3rWxUAHNmlGPgNm+km9PhSYEigv0kLrtKI7cYGP5jW79GS7LruXcQG6qYnbZOml1z
	KFQgRHv5QyLhvQXG5QCFk39kis7es0ZYA7clrIPB3dPZk5++FHltHhj5Uhm+NNPMLx30qY
	yukcKG5wOdBFHlOMVrp7ElVUv7S9+f0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1783671835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mPuYuBoZ9Q+WnVTIgAUQvPui+pR+T3J0OKDYU8ozSrw=;
	b=zS9NgJrH9R7E0SeeJLKaeKjxN0dLfVlSBUVnc3OxKRx0mzw09pAZ+x3NsFbG7prEg5iNHM
	nx05QNqh2h+A4wEJFwKt+Wm9PNZnvBYYOsypOMDHPYSfif3i80pS8xZZWgfAw9GW00tTBT
	ZxOYNT5LSG7r+zp9sCbyMPaPM43XyEQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] Bluetooth: fix hci_conn lookup RCU usage + holding refcounts
Date: Fri, 10 Jul 2026 11:23:39 +0300
Message-ID: <cover.1783671570.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resending parts of
https://lore.kernel.org/linux-bluetooth/cover.1762100290.git.pav@iki.fi/
plus additional hci_conn_params usage fix.

v3
- Copy params->flags in hci_le_pa_create_sync() to reduce number of
  unlocks in branches.

- Don't convert hci_conn_params to RCU here, as it appears to require
  sorting out eg. data race vs MGMT_OP_LOAD_CONN_PARAM in field access,
  and is more complex change than memory safety fix.

  To my understanding it would be performance optimization and it's
  unclear that it is significant: these are on Create LE Connection and
  Create PA Sync code paths which take hdev->lock in several places eg.
  in completion callback in any case.

v2:
- Take hdev->lock instead of RCU in hci_update_scan_sync() to
  guard also the hdev->accept_list access.

- In unpair_device/disconnect_sync, take hdev->lock instead of RCU.
  This avoids potential access to uninitialized struct device.

  In __hci_conn_add() it looks like we should move
  hci_conn_hash_add(hdev, conn); after hci_conn_init_sysfs(conn);
  so that the pattern

    conn = hci_conn_lookup(...)
    if (conn)
	    hci_conn_get(conn)

  can be done with RCU without needing hdev->lock.
  But better done in separate patch series.

Pauli Virtanen (4):
  Bluetooth: hci_sync: extend conn_hash lookup critical sections
  Bluetooth: mgmt: fix locking in unpair_device/disconnect_sync
  Bluetooth: mgmt: hold reference for hci_conn in mgmt_pending_cmds
  Bluetooth: hci_sync: hold hdev->lock for hci_conn_params lookups

 net/bluetooth/hci_sync.c | 66 +++++++++++++++++++++++++++++++++++-----
 net/bluetooth/mgmt.c     | 42 ++++++++++++++++++++++---
 2 files changed, 97 insertions(+), 11 deletions(-)

-- 
2.55.0

