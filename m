Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E803A7839;
	Sat, 25 Jul 2026 09:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784973581; cv=pass; b=qrJBagdBmE/66U+xUkTt14SivFewCbV0PhNoplh/iZCoJwDkpasehQVqd5j93pOwQtdqNXpaWfcpSQ3L9ONfqkeGE2SXwM/qimx2xN77r9OTGd5hqZu6Yh3z7WSOHASLDBFJOdWeDA3MyKwP/LzBX0+XzFHOu8Cs9mwReUtvZFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784973581; c=relaxed/simple;
	bh=p+xbCcSZGjs83JQ/J/CHEvZSQAHrTwh0B7nBpyLjqm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJ+JZDbWhDADvBvAuF5IZYsJ3zZiVfVaBXdcThMVHi9GKY1IsIoQkKh7ZZyEPnWElKVK8ZEmlYhfWyVhKl3Olv+P8YBm+jsClC8ZSbbRt8EBYb8OQ0FSYsZ4KUiCESAl4AoSOFsGZ2k1iEyU9F9SfxVAnwm76NO8fljcIPbtmA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=BdOTc2B7; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="BdOTc2B7"
Received: from monolith.lan (unknown [185.65.133.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4h6gLv4ly3zyx1;
	Sat, 25 Jul 2026 12:59:35 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1784973577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j1exFO9ctdPW2+XsY+nkx9iVjmRiDk7TBFzagyTBcWA=;
	b=BdOTc2B7Z1aqx3NnHLyi3hIzvuL6kCg6IyS5WLiYqQvx4blZGXLLoRzE7wBDbUBZp4clpy
	fJuGoJ4zeCXUCTq/dEI99CEawGtQHH7NcP28N/M1ISmdejVTvJqwNOCIo7GsDgCU2IJA8z
	9REKf+30M/DEHHWLTaQi6gR4LItIdgI=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1784973577;
	b=i0ZIYkU5CBnbJdTF6zqFLXFNMSdy1opOV/IYwuG7DJxx6RCKY/4L1hOZS3TiL684YN2ei2
	pA4MFzklxd6wu9da/GNUyWLQcsIWn6c7r8eAu18rZo661YAwUtNdBbnS5rCPBz8WiF0WMi
	POIDXjf0vw15an9f9IoJ1OsQifKDJ5I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1784973577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j1exFO9ctdPW2+XsY+nkx9iVjmRiDk7TBFzagyTBcWA=;
	b=hrge0QUVLxsWL/CJjMmiIUdRJgVb7R0FIOFmAvekAvps4np+gC5gRnOXadeBxNq+I3bLgG
	6hysLR+4WJ8PWg4XEOVOkvOIOexD6o2nv82EFW+hN08tACkMOm+ITTaNFsU4Zt2lbLzi0w
	GXEcwe9rjfM/0bxBW+vDrAwbqVObh2M=
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
Subject: [PATCH v5 6/7] Bluetooth: hci_sync: fix hci_conn_del() use in hci_le_create_conn_sync
Date: Sat, 25 Jul 2026 12:59:22 +0300
Message-ID: <1eec9846016f6f25d4d7451ad864ef0b485cf0b9.1784973264.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1784973264.git.pav@iki.fi>
References: <cover.1784973264.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_conn_del() caller must hold hdev->lock, check the conn was not
concurrently deleted, and usually inform socket the conn is going to be
deleted.

Use hci_abort_conn_sync() instead of calling hci_conn_del() without
locks etc.

Fixes: 8e8b92ee60de5 ("Bluetooth: hci_sync: Add hci_le_create_conn_sync")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v5:
    - no change
    v4:
    - no change
    v3:
    - use hci_abort_conn_sync instead of lock + hci_conn_valid + hci_conn_del

 net/bluetooth/hci_sync.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 63d0b89a88f3..0f76221db2bd 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6733,7 +6733,9 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 		if (hci_dev_test_flag(hdev, HCI_LE_SCAN) &&
 		    hdev->le_scan_type == LE_SCAN_ACTIVE &&
 		    !hci_dev_test_flag(hdev, HCI_LE_SIMULTANEOUS_ROLES)) {
-			hci_conn_del(conn);
+			conn->state = BT_OPEN;
+			hci_abort_conn_sync(hdev, conn,
+					    HCI_ERROR_REJ_LIMITED_RESOURCES);
 			hci_conn_put(conn);
 			return -EBUSY;
 		}
-- 
2.55.0

