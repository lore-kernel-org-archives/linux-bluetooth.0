Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D70637F72E
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Apr 2026 20:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776025762; cv=none; b=GHUD7QbfaSi73tU2TXh6/wSrtHPYn4lsOlCShBVPuTsU9kHj1TistFTcUavYGSsfA6R3S3PbkYBFEySEGvekDh2+sxuZyFXHGxWJa6kzE7z+4didtGC6oPoRd0ZdYnCwIuUJZ2TMBnLD5kd33/fNSan0nyoXIHcP2zZhbsf95as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776025762; c=relaxed/simple;
	bh=3rqtvqqZTGtxKH38oOYjEvWW5C96W0zbTJWPHwN4xk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GHatCSnIqOvTp6fGez/i7PwEEFmogC0R64sTG8oTYZoyQp6qYWThwfP7VOHsdAPpxl5qXgu7BXiiqsyGb5CFkkFHVKgxZbLgAOj/5k9Iw5am5x95SxXJayfuPylXxFy69IN3Z65DK0IePrciHlnxCA9C3RFpdnommc3GtAe7NMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OocIG0p7; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OocIG0p7"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43cfac48bc7so2473962f8f.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Apr 2026 13:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776025760; x=1776630560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Id0UBUp6u8lf/UjsSjAE4ozbDe+gUA5wuiQY3ynuDI=;
        b=OocIG0p7aC5kRfRhxgeD3Vsh+UwI/7SPAYzgDpHG/r773+jDcRxzVj4R2r/lMEZLSi
         W6lyWeSuQOHQHVZIoYrN18O5LRk4uC1gJz/h18KMh42UBIH7wmISfUipKxSrV1RodkU5
         ONRqYN66YN7GzIUwGSiLzEW/M6MHn0SpSdYpCPkyLyZZKQMP6Nsnd/NTvqlV75LOMoV5
         K3vF41vtWneAIJakbaMT+G7gfds8m0BZbWE0uBTHilIEjCXbUdnLqknSUptz9QAM4mXa
         qhoJBlhF/eG/E4uAaVX9SND3SI5RnYOb93lpgsgZGKAMaEpjwC5hyG5FGWjkfjurdWK4
         FVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776025760; x=1776630560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Id0UBUp6u8lf/UjsSjAE4ozbDe+gUA5wuiQY3ynuDI=;
        b=IW3RyhZ/K2WCk4FqIfZDsIVgOzPGP7K+ME+5DG2OAPDBEL8FinMKYyX3vnP/XjuuLl
         P735Fx5c4HDsWOSlmCj+3893NbLKP03LyCUjmcXZSwvinbs1qXQop6CSOtBM+tAI5lX5
         dtp0Ryr7UUQcXkWSE80tExQYMOPSYjTDIugnv63H2J/rWjjjxUptLbx+uFPOWv2C/KvQ
         ET7j583oGI7L9WSrv3jq28SCNerMEVIanNno1IWhWjH8LF+4umlDbL8z1kf9qbyx0V5f
         nIqrGxMyrk0eRhtARHCSCTT+vwpXd0+OnS89XuSmkwAPqVVRzZar3o2fc87GUOZUe0qe
         YJNA==
X-Forwarded-Encrypted: i=1; AFNElJ/rWyEt8YdTkxX6pewGFlCthoJdjV1aV3SU12wpmIDLchGz9cyi5Wlhzd6z9IS2b10W3Js0MGHk7ZwEzgiih6g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Y89KjHctGkZqSTZ8Aj6Y4GRlz2ZRlhw30lKb0jY5RPZwMIW9
	QmTAX5mMoEaoAmnbwX5dbqhJxpxXr0PbReFrNsVuHw6tqXsXdPpYrHWz
X-Gm-Gg: AeBDiesrXo0Mzo+JF+qGWWnM5O7ChjgbftSfAanOdfiyTc9s+73JXBPAbsIaGdkyMDL
	IyMIHkjvFLWfA5f4M/fiGY+r29Qz1+jZd198TinKTMPUeIxYbAztRSQFoQxUdML6Xu5TNv6MF5t
	rBh6o/FxY+WOn6JMPWkabf19HM6JugN3XxUt41N/Q4SqK4sioj9r6wQmYTl1ghd9PEuTSoB8+z6
	DXYAStvSpgbrkOdVYOoX9YapROLJs2Lrt1blVpJ3vBOPCB0akv/MzFFbs9t6qKdhB9enHN4TEZ4
	XkpADWbQStnK3bJm4H2OX5x5cwFrLwsUyVjxZh7nlnsND4auSsTVv8spA337h1W1o1xACyR0/eQ
	GfMGsoxnzJGs0GLoZyHMdJmSPdLRyMOnTDdDM0CssrWQMGWjO5ReF+9ZiRPIlNcIVHfs1kR9eRh
	2PjQsEijXcRJ0j02T2HUfn/ytmt+8Yt3QNHLDYcCk1QswCUlue4kVC4KIatbJ2t/r6cq1R3YYwc
	KRD41KwYO+P
X-Received: by 2002:a5d:5d10:0:b0:43d:1bf6:930 with SMTP id ffacd0b85a97d-43d642dd09bmr16220327f8f.47.1776025759377;
        Sun, 12 Apr 2026 13:29:19 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63de2a69sm27240736f8f.4.2026.04.12.13.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 13:29:18 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Pauli Virtanen <pav@iki.fi>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH v4] Bluetooth: hci_conn: fix potential UAF in create_big_sync
Date: Sun, 12 Apr 2026 21:29:16 +0100
Message-ID: <20260412202916.196282-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add hci_conn_valid() check in create_big_sync() to detect stale
connections before proceeding with BIG creation. Handle the
resulting -ECANCELED in create_big_complete() and re-validate the
connection under hci_dev_lock() before dereferencing, matching the
pattern used by create_le_conn_complete() and create_pa_complete().

Keep the hci_conn object alive across the async boundary by taking
a reference via hci_conn_get() when queueing create_big_sync(), and
dropping it in the completion callback. The refcount and the lock
are complementary: the refcount keeps the object allocated, while
hci_dev_lock() serializes hci_conn_hash_del()'s list_del_rcu() on
hdev->conn_hash, as required by hci_conn_del().

hci_conn_put() is called outside hci_dev_unlock() so the final put
(which resolves to kfree() via bt_link_release) does not run under
hdev->lock, though the release path would be safe either way.

Without this, create_big_complete() would unconditionally
dereference the conn pointer on error, causing a use-after-free
via hci_connect_cfm() and hci_conn_del().

Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connections")
Cc: stable@vger.kernel.org
Co-developed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: David Carlier <devnexen@gmail.com>
---

v3 -> v4: combine v2's hci_dev_lock() wrapping in
  create_big_complete() with v3's refcount. hci_conn_del() now runs
  under hdev->lock as required by hci_conn_hash_del()'s
  list_del_rcu() on hdev->conn_hash (Pauli Virtanen review).
  hci_conn_put() is placed outside hci_dev_unlock() via a two-label
  unlock/done pattern so the final put (which resolves to kfree()
  via bt_link_release) does not nest under hdev->lock.
v2 -> v3 (Luiz): keep object alive across the async boundary via
  hci_conn_get() at the queue site and hci_conn_put() in the
  completion callback.
v1 -> v2: handle -ECANCELED and validate conn under hci_dev_lock()
  in create_big_complete().
v3: https://lore.kernel.org/r/20260410201343.229470-1-luiz.dentz@gmail.com
v1: https://lore.kernel.org/r/20260408155638.95927-1-devnexen@gmail.com
 net/bluetooth/hci_conn.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 11d3ad8d2551..9fa6901aae9f 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2130,6 +2130,9 @@ static int create_big_sync(struct hci_dev *hdev, void *data)
 	u32 flags = 0;
 	int err;
 
+	if (!hci_conn_valid(hdev, conn))
+		return -ECANCELED;
+
 	if (qos->bcast.out.phys == BIT(1))
 		flags |= MGMT_ADV_FLAG_SEC_2M;
 
@@ -2204,11 +2207,24 @@ static void create_big_complete(struct hci_dev *hdev, void *data, int err)
 
 	bt_dev_dbg(hdev, "conn %p", conn);
 
+	if (err == -ECANCELED)
+		goto done;
+
+	hci_dev_lock(hdev);
+
+	if (!hci_conn_valid(hdev, conn))
+		goto unlock;
+
 	if (err) {
 		bt_dev_err(hdev, "Unable to create BIG: %d", err);
 		hci_connect_cfm(conn, err);
 		hci_conn_del(conn);
 	}
+
+unlock:
+	hci_dev_unlock(hdev);
+done:
+	hci_conn_put(conn);
 }
 
 struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst, __u8 sid,
@@ -2336,10 +2352,11 @@ struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
 				 BT_BOUND, &data);
 
 	/* Queue start periodic advertising and create BIG */
-	err = hci_cmd_sync_queue(hdev, create_big_sync, conn,
+	err = hci_cmd_sync_queue(hdev, create_big_sync, hci_conn_get(conn),
 				 create_big_complete);
 	if (err < 0) {
 		hci_conn_drop(conn);
+		hci_conn_put(conn);
 		return ERR_PTR(err);
 	}
 
-- 
2.53.0

