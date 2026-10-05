Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5684A4CDA39
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 18:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791224055; cv=pass; b=h2mbLnzPZznOhPGHD0OE2o58g1t6kOPaDk0/RLA9KClOLR3067WuuMTRjT7JZ7SZA+n8uVeGSq947vpTc90Ji9O1v9dXjeDxQFWGIO/4Zu5fU0vNoEOIqxDpzNPQG6+cvYuYEoF19WeBPr0iCV0BHtuRl0u2gfU1l9fN+RRfGdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791224055; c=relaxed/simple;
	bh=x1vilmEy2GEwvled0ktXKkfHX5fL32Rc2SQFlcmwTe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S5u/PRCbTJN5L1Ffs8eINEV453cYH6p/rp6lxrAku9PAJ8V15VykFMSL3zKL6pwk3QCKBKwk/2mejtI8bEA2mvrihxpTCc9/yWLpDSZZrva19tpJOpro4n3pJhNsZJ+w1bIfeCKec+8ucuES1XVfY+cXw8/RWw0/YtDcp2ROAMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=CUGuj3ds; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="CUGuj3ds"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hz6wG2wLPz117Q;
	Mon, 05 Oct 2026 21:14:06 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1791224046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rb6LWkoUQ7C2LhkfGIomWrSX0XUg3giQrR7BvpW+ExY=;
	b=CUGuj3dsItUJYFHwHE//VNcFzekKDR+/gRYPomwPvhJCGOjSaHFne4rTdJ4XUFtCjgVNvr
	tbpCYWsnfkqiRy8TQUJAlkeHp74KUtN0Z2sfelQhYefCH3LnUXDUvk8P5TJ9/xRzT9wTvk
	M1jo++0gkPJlfXlg+xHen4jPjjtp3tY=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1791224046;
	b=HJJnajoNJeIDaOKomfzLkRkBajNCaqq1yoj9yUk6JpsxciIrvBNAuyVIDPWrPkIMXB/QpD
	PqqGEfuTFVFZ87stzlhFOHnyIZmXOR/ioUQh/ywJ9kKwBLngNmcn8oREk5CehJAFgBKPjy
	pjnFZmZEKwsuE0LNtBRWuhEBWs1lxnw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1791224046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rb6LWkoUQ7C2LhkfGIomWrSX0XUg3giQrR7BvpW+ExY=;
	b=TsACQKc6B5mRuRB5jwnLxoCQCC+/FxpX4aPxwruJDNFxiPk8OWxwtsvjVlbevICYiS+784
	asTs40bhkU7zBjK5RN4dqQZfQKRwSgNdAboHuTc3J5XC8pMO3dtNFGwC0L2SBB3BFG+iGM
	kIw8dBQ5tkdJ0HNe/Fk8WYEjIVb1Qxo=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 1/2] Bluetooth: hci_sync: fix mesh adv timeout units
Date: Mon,  5 Oct 2026 21:13:54 +0300
Message-ID: <6f193617ad11dce997d5f97c4a0879343d1d23d9.1791223958.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791223958.git.pav@iki.fi>
References: <cover.1791223958.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mesh adv instance timeout and duration are in milliseconds, see
mesh_send_sync, hci_add_adv_instance.  hci_schedule_adv_instance_sync()
and hci_enable_ext_advertising_sync() ignore this, and scale the timeout
wrong.

Fix for mesh instances by using msecs_to_jiffies() in
hci_schedule_adv_instance_sync and fixing the scaling in
hci_enable_ext_advertising_sync.

Fixes BlueZ "Mesh - Send cancel" test failures.

Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Assisted-by: opencode:qwen3.8-flash-next sashiko
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_sync.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 1fe11d3ef1aa..94dcbbc767e5 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1670,7 +1670,8 @@ int hci_enable_ext_advertising_sync(struct hci_dev *hdev, u8 instance)
 	 * scheduling it.
 	 */
 	if (adv && adv->timeout) {
-		u16 duration = adv->timeout * MSEC_PER_SEC;
+		u16 duration = adv->mesh ? adv->timeout :
+					   adv->timeout * MSEC_PER_SEC;
 
 		/* Time = N * 10 ms */
 		set->duration = cpu_to_le16(duration / 10);
@@ -2101,7 +2102,8 @@ int hci_schedule_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 		hdev->adv_instance_timeout = timeout;
 		queue_delayed_work(hdev->req_workqueue,
 				   &hdev->adv_instance_expire,
-				   secs_to_jiffies(timeout));
+				   adv->mesh ? msecs_to_jiffies(timeout) :
+					       secs_to_jiffies(timeout));
 	}
 
 	/* If we're just re-scheduling the same instance again then do not
-- 
2.55.0

