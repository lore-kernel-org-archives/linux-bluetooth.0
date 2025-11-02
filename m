Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18472D948F;
	Sun,  2 Nov 2025 16:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762100592; cv=pass; b=NNl4YPynrKOJmusk2OXLzK3lIyfkJ5JN0/yzZkpEVeYo3xtY2xN5GwqFcuZPvbMnbRBxEzm803kMwWvcMfvBDD0jF+7FJfVyfNeEiIA/MsuvlyYYDWHeRITJx46iVQjapAMWYrY3Y5v0YRjCElbkysGVI3UcQGpVV0n+gNLz+I8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762100592; c=relaxed/simple;
	bh=EI8nyFkNdAzKa7QP9/aX4Z9aNZKLosqPaqVUYHw6d+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmFUrksYFIVc66GnMV2+TBfs2/5q80+pyK0AWe2GAUt70hhc98AywHrks/7+2jaCRsHWNfha14kB+c9e9CR4lkB75Uts041J/OaUZcy+0t++YnOqJtZ32Q5QOiRquahVfmfMPv32ODBegiTMyQ9pF0uLmAZqAUbGyBCSoSlZqr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=LAE6iOln; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="LAE6iOln"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d00Pf246Sz105l;
	Sun,  2 Nov 2025 18:23:02 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1762100582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mVE0LXmXYSdd0UYV2f1XCqgHhiUbio9FQUz6BG0KDiQ=;
	b=LAE6iOln3HkeVFGGBLScdcdSZCW6XmF5XAC3sxasxWtHvoJTr5R8w6MLWMz8XP7ytpT9Ph
	11LoGdyaO3dqS2rtoxdiaG8CiqPRa+XIibmk5jHAz0YchhDnhuVAJtb9f7rxbWeVui36aV
	LD7nXOPBXRqw6lPYbDUl86lzBRLWpC4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1762100582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mVE0LXmXYSdd0UYV2f1XCqgHhiUbio9FQUz6BG0KDiQ=;
	b=nkgcaxslpbicSkDJPcw4u2ETAwPaoDTU4LEFvXqKOUAyYftM5hiAYPHHoUZ+8TCwRXY6hr
	CZoRbvAYtQNX1d6PD3CubCAeILeYPaUISB30eJnVIXVz7A5NOEKp1JgIiRwxEMrNa98Enr
	AhoFOxHOU/IZjCtHfLDOcSx8oVHEej0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1762100582; a=rsa-sha256; cv=none;
	b=B2YzjTq/5aR7y7WoPFC7DlP7O25XPWtJd1HXpbQwp8REXkTlvJGcnoeil7uM+j9DLEYrdC
	eiWluPrJUjFR67i8bQXLzArM4soGG/ntMEZDFP7NwunUySgoC2kLvlUD3ofmQaUuGlGvBd
	QXOtH7bi6yIWUBWdvH4lh/AczVwTDYk=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] Bluetooth: hci_conn: hold reference in abort_conn_sync
Date: Sun,  2 Nov 2025 18:19:39 +0200
Message-ID: <0d75210630e1f71b18dfc5cd97610a41effb1789.1762100290.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1762100290.git.pav@iki.fi>
References: <cover.1762100290.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_conn_valid() should not be used on potentially freed hci_conn
pointers, as relying on kmalloc not reusing addresses is bad practice.

Hold a hci_conn reference for the queue job so the pointer is not freed
too early.

This also avoids potential UAF during abort_conn_sync().

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v2:
    - no change

 net/bluetooth/hci_conn.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 214fa6ec832b..64066f6a0af8 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2956,6 +2956,13 @@ static int abort_conn_sync(struct hci_dev *hdev, void *data)
 	return hci_abort_conn_sync(hdev, conn, conn->abort_reason);
 }
 
+static void abort_conn_destroy(struct hci_dev *hdev, void *data, int err)
+{
+	struct hci_conn *conn = data;
+
+	hci_conn_put(conn);
+}
+
 int hci_abort_conn(struct hci_conn *conn, u8 reason)
 {
 	struct hci_dev *hdev = conn->hdev;
@@ -2996,7 +3003,10 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 	 * as a result to MGMT_OP_DISCONNECT/MGMT_OP_UNPAIR which does
 	 * already queue its callback on cmd_sync_work.
 	 */
-	err = hci_cmd_sync_run_once(hdev, abort_conn_sync, conn, NULL);
+	err = hci_cmd_sync_run_once(hdev, abort_conn_sync, hci_conn_get(conn),
+				    abort_conn_destroy);
+	if (err)
+		hci_conn_put(conn);
 	return (err == -EEXIST) ? 0 : err;
 }
 
-- 
2.51.1

