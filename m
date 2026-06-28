Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C563A4F35;
	Sun, 28 Jun 2026 13:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782652849; cv=pass; b=aDVzDaeKQZGalihHa77u1TpqAc1NhIBO2lEPuT8pz19gnoqqlfOneEE6EBlUUHFDJ/80M//RnPQNjJ/g3fJwnF3ZGfsePrOOEPGhdch4MV45nEjwZmW9VP5PJcMt6Cz/vKmkgMBs7tYezJ2Jx8TwiHLyI7Mhq5+G74a6xL1MzKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782652849; c=relaxed/simple;
	bh=oTnCTypYMecsIOUCaLsqctw5KL0MzQRy/8KPGi5UA1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVYohm4zULTCgCDVeGcmm4+LNqoB6RDTj33PjtH5D1VggqKUyo7gPAItTcPAetivOjU/0TphLzB3w5C3W8evzUP6stXcB5N69WK3VXmGpUAiJumfB2gyws1wGDBHkfGGwuJlQkNrKgjZFjLDiKXkBsQjBDEAmAv5nOwH3N5uP60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=wMvmZaXg; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="wMvmZaXg"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gp95V0p7dzyvg;
	Sun, 28 Jun 2026 16:20:46 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1782652846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ANm0/CMSSxy4yokVd/WD3RmryAuxAai8wuzpUuovXiA=;
	b=wMvmZaXgNL00EhhUNVnXdyztRcbf8qH/3iB/+6x65FUp1S+9seoxhPBrqeOxQSyjoLWHq3
	hQElECl2JQEjyjDvDa5GRur2CGHuBw7ojbpvDaispAtg1hvVDtnQD8pnTuG6fLn9qurpoF
	KN/3qC9boLmUgNMXVKtdrMw9wYc7xBY=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1782652846;
	b=PFCCAyxMMOPDT4XxC7dmpMFJNsUjmLOt5b6jvZIX4PpJCY/m8FAtfnlP5fL3YkLgBGnIrI
	9Bd/0yNPBuoHqgy0UVGviOybhnsFsrcFWRm5Zc/ezxYfoEJdJpvdbTARkYxRlKclU8jvt9
	29XxV7e7pV1ddiRr7tZlPDzMchBnl4M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1782652846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ANm0/CMSSxy4yokVd/WD3RmryAuxAai8wuzpUuovXiA=;
	b=b66U3nqyZTggOXn0MHSS9Yx6Rp5E9owxP+hbTiMXRsgKBBuRXqSSXSDTfACkSaVYZpZ+kn
	LGhmiT2qQDw1gKwxLB0zlcR5zzdzRPqfZBKhcN+odlBoa2mNgqr+Ym90GCajMeuPdPcH8+
	MKmug/y0rD2X0cK8EbZ3ZKHBgADm/YY=
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
Subject: [PATCH v4 7/7] Bluetooth: hci_sync: remove unnecessary hci_conn_get in create_conn_sync
Date: Sun, 28 Jun 2026 16:20:32 +0300
Message-ID: <d36f4736c7b825ae8e34bfdc91f493758eb0e7b1.1782652695.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782652695.git.pav@iki.fi>
References: <cover.1782652695.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_conn_get() without already held reference is data race against
concurrent deletion.

In previous patches, the refcount has been changed to be taken before
starting the hci_sync task, so remove these extra get() + put() as they
are not needed.

Fixes: 76c2d047410ba ("Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v4:
    - no change

 net/bluetooth/hci_sync.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 11d0c2033c6a..7cc3cb12436d 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6607,11 +6607,6 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 
 	bt_dev_dbg(hdev, "conn %p", conn);
 
-	/* Hold a reference so conn stays valid for the HCI_CONN_CREATE
-	 * clear_bit() at done.
-	 */
-	hci_conn_get(conn);
-
 	clear_bit(HCI_CONN_SCANNING, &conn->flags);
 	conn->state = BT_CONNECT;
 
@@ -6626,7 +6621,6 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 			conn->state = BT_OPEN;
 			hci_abort_conn_sync(hdev, conn,
 					    HCI_ERROR_REJ_LIMITED_RESOURCES);
-			hci_conn_put(conn);
 			return -EBUSY;
 		}
 
@@ -6720,7 +6714,6 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 
 	/* Re-enable advertising after the connection attempt is finished. */
 	hci_resume_advertising_sync(hdev);
-	hci_conn_put(conn);
 	return err;
 }
 
@@ -6995,11 +6988,6 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 	else
 		cp.role_switch = 0x00;
 
-	/* Hold a reference so conn stays valid for the HCI_CONN_CREATE
-	 * clear_bit() below.
-	 */
-	hci_conn_get(conn);
-
 	/* Mark create connection in flight so hci_cancel_connect_sync() can
 	 * cancel it while blocking on the connection complete event.
 	 */
@@ -7011,7 +6999,6 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 				       conn->conn_timeout, NULL);
 
 	clear_bit(HCI_CONN_CREATE, &conn->flags);
-	hci_conn_put(conn);
 
 	return err;
 }
-- 
2.54.0

