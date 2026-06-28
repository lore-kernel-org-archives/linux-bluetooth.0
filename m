Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CDD35E1BC;
	Sun, 28 Jun 2026 12:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782648777; cv=pass; b=rBctdr6QUbdbMlZ3MBCxcY05l20xIs3MSINNtXepxhok5y1KDd358TG/Xld72iecHK+6eAnlJ+ovb5mZrwSVmfGZKTUAYiVvHIpQo5gWPyCBLlZYD8ViA8b++V6kM4CJorv7M93URdh2rp+4g2e+rb7kSWjYlXZnijPaOGnBbJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782648777; c=relaxed/simple;
	bh=xedlEtGtFH6R2OLzCNxPyiJPtw+xijgg3Zs+yIF8+4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mstjhm9p28r+bt4unYWEN3e3m3cCOXNI4cGJSe6kD0fst6tsdAdxFWYJGl97Ek0nfcjTbFAze1QHxHJgGs1P5apc8wF6BBqcWkvJvyk8IVatuPS+ETm3DeeaB79GH+GDLHrMXQltVyK/g7+EySnkK4CzqrmRiG8evdiLSqyKNyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=vcQXQ7W4; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="vcQXQ7W4"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gp7b5535zzyvg;
	Sun, 28 Jun 2026 15:12:49 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1782648770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ezAMRKJdo5soQ3f47WGeFqZ+sr8sNGYskRdMcWdyZR0=;
	b=vcQXQ7W4f/2SsljetEx2zMsoqBykRZVHDGnu60s2NTTlgRb4WXcDTmbVh0QTeSu08F6G7m
	QIqgBhCyJ5XfO23ucUT8Dh9GGKCVY2V7FsjpaGRF44mIEGqktPESjof6CB+mD2gACbNgKw
	piyek9fL5RXSRHbKKipnnF3bIshF/Tc=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1782648770;
	b=MyE8ea2q1+2jugN7Ag3YjCHkfszGkLMnS7oO2NxCtrgNh2aRyCB9ZwvWXUSs3H89tbXEEE
	Y9kRH3bogJtxOzmtZea+fSDLFR04OC2rF2gUC+JfqSr1tj/4gh9C2meiN7ASJTosISskEG
	RAd1AND1PD0KnPg7aIRr5Wa7PNgWgf4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1782648770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ezAMRKJdo5soQ3f47WGeFqZ+sr8sNGYskRdMcWdyZR0=;
	b=W7HYVPOdcdusGQx9aVN6Md+4D1GOnLOvhSpk/6/+dTYOWinrHrSqD9X4W9FdNyVliMVaot
	roEGNPjTfyAxnIrpfXhHwGiXduwIbCit2ZnoWm8MOoyaGpQtImHrr3up1i7DH6/acemncX
	o/bblWEk4ceqEhb1tHwt5xzXyt+gI20=
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
Subject: [PATCH v3 6/7] Bluetooth: hci_sync: fix hci_conn_del() use in hci_le_create_conn_sync
Date: Sun, 28 Jun 2026 15:12:37 +0300
Message-ID: <ecc243d6be25f1bad13861f138ea3b4710cb7fbe.1782645211.git.pav@iki.fi>
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

hci_conn_del() caller must hold hdev->lock, check the conn was not
concurrently deleted, and usually inform socket the conn is going to be
deleted.

Use hci_abort_conn_sync() instead of calling hci_conn_del() without
locks etc.

Fixes: 8e8b92ee60de5 ("Bluetooth: hci_sync: Add hci_le_create_conn_sync")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v3:
    - use hci_abort_conn_sync instead of lock + hci_conn_valid + hci_conn_del

 net/bluetooth/hci_sync.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 0bbc57792206..ab5436e548f9 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6623,7 +6623,9 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
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
2.54.0

