Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF6F2472A2;
	Sun,  5 Jul 2026 22:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783291387; cv=pass; b=GZ386+WvPSLVD/BXZTkkxMGCpzdfO8DySQLPVFHXw8mQVjKtzzfvpReaHmi/bzNKDRGzNfqsXPSLYFrX7zr0y5YXrgUTKE0VTaJmcl/QbVUZzEV1JOsNCNK5md5JPgDi9y3GzuKikln9F/qfP2p+QZmjxMZV84WMGyhM6hQmSGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783291387; c=relaxed/simple;
	bh=etocJXQNf1/VrWxvwqqrHrzoKHPYUi0R5Y2KEVIRtaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N6wTrQ58HDMEPZ/51BVw0t3+p31AkVjSba1x/9QXeUxeb9n2EiQYJizn8ZqfCVuPRgmnWO+d1+udbB3csGhQjpHuFXAH7wMswAAe8hPb4VQITHvODTZl39khw5rQuFcXLtOPOb8F41H5is0n5fp8PV/bdeawEgYDPpaVQVITUrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=jEfTpghO; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="jEfTpghO"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gtjF15P7zzyNV;
	Mon, 06 Jul 2026 01:43:01 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1783291382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8GnoGjbworScue1IHoa4aw13pT2bjV8uYoGXooZhEU4=;
	b=jEfTpghO8T/oK6yxAoC+BIlPND9j5jRMDzrpxNBp7pTgFpOD4JlhT6VmKwDNkvpX13iwpB
	XOM+3z1UaHUR5Zztz/3W0xYltq6hY7hMn/yBp/6vRORn02y6ae8OJGYYuVAUIf9fDSKFye
	lE3al169OK9kkmCqxGM90RKUMHTauew=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1783291382;
	b=DnAsSsCPfyDgs3Mff9+hXFSpPIYtKbZEyXr8SC4+e8ZsJDWcW68qpxIyROvLVLNvJwPjO2
	3rGhhZu1nerSqowOcx7NFQ4PHAWDN0snWIvvj4ah/K//4Qt7TultjBlk6H2BOMGB7WyoQF
	+d9CI6/d1RZyoC3KGbB8jDPyVqhB1FI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1783291382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8GnoGjbworScue1IHoa4aw13pT2bjV8uYoGXooZhEU4=;
	b=EsCCA5ZneVb0Tqr7rY4cacsPAgEHw4BToXKZ+zP+Ea4Gu03TtpoQU5ogHyPJDZX3yfm/j4
	661t5Ra23oaX82QdUZsxBYRzaSQrfmjbbfiNKOB+LavV/6EWb2R4ybryo8XYbJWQqZzPOp
	boQcBlSe2VqXq72z3kY2t/qt4gP9YQA=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] Bluetooth: fix hci_conn lookup RCU usage + holding refcounts
Date: Mon,  6 Jul 2026 01:42:43 +0300
Message-ID: <cover.1783275015.git.pav@iki.fi>
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

 net/bluetooth/hci_sync.c | 62 ++++++++++++++++++++++++++++++++++++----
 net/bluetooth/mgmt.c     | 42 ++++++++++++++++++++++++---
 2 files changed, 94 insertions(+), 10 deletions(-)

-- 
2.55.0

