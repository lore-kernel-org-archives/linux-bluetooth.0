Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5833B27DF;
	Fri, 24 Jul 2026 20:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924460; cv=pass; b=MYDVHK9GD5ZunomE6Hnbg2h4fkLmueLd8ou5EfECqBA88H9w2NLetYR8iTpqFQHf6DZWONERRZvUH8I08bZgijF5tR1xXSTSeAiVW2kTNoviAS6gd0b9J3Ty5McByIwkVvMp2Gz6Kb37pY/5F41xNGFvQL9JUgpCM/hDYRJdV44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924460; c=relaxed/simple;
	bh=1SpN3PbpJCN8EML1itNSGAUvXEydaaKunkKHi3Z5w+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eh3oPBr9/RrAYETBVmaM8qG3uZGfZDQjY9poeNeqSSGf9uE3YOWuZiE+7I6hdMBwLfndeHU06mNpvleW9DRwzdvn15p1zozoUICogyrb7Z97KHaqvkPJq/4TYxrqGBdfAppiOBI9k2WNpLSTgt+4y5CNLBO7RHaZpoN6EWy9mZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=k4h00+Ue; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="k4h00+Ue"
Received: from monolith.lan (unknown [89.37.63.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4h6KB52KzMzyZH;
	Fri, 24 Jul 2026 23:20:45 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1784924446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k23S5RWRNobKoWy+fSjoSzTYLBv9zc75015Aso7VPxg=;
	b=k4h00+Ue5PK0fKZ/M9QJEMTs40x5fOc0pB+grNUeDRhN7YWehqsIgvIv6EWpsAs8M4H4oG
	MFp9wnriX/WjFLXpuYdr8yddQSXX8hD3KKPLiYpTaXD9U1oJOcBesJFJMFBQZZtECc+8VN
	02JNbAWz89cp0ypXNndUF/jIMcCQaxM=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1784924446;
	b=mQmdP2NpnRBSNqnN7hJQ1sH0TpnCcqIIuKBqeUTgh9Ex4bYD90KR26lCe7qVUgq8QB8Zl2
	gYw6pg/U2MLLT2MF4JEIxJ8PrsJkqp2MI/sqeEJ4P+5TCBlqwZ4c3d5kBj/M5c/Yb4Fag1
	QblKb43jYIt541ChqnMy0TSmqrmNsOU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1784924446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k23S5RWRNobKoWy+fSjoSzTYLBv9zc75015Aso7VPxg=;
	b=ijCG6OrhtoSYZqUVcUyHQNct2TlMuQDK29texEJX6GpA+sei+E3iLV9JNhqzEa6pBJKk4c
	kBBp8RvdziSB2/t+FgpqnWjfFR1QSfSJGOEKegUUvOznYvbPWl/xLKqidCEpDeW0GI/Bj6
	mLnYxeKsx+xtFSFiN94JgSag7hgmJuE=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] Bluetooth: ISO: lock sk in iso_connect_ind
Date: Fri, 24 Jul 2026 23:20:26 +0300
Message-ID: <b7443b1e6093867fab5168677f6474e037e59f97.1784923689.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1784923689.git.pav@iki.fi>
References: <cover.1784923689.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Accessing iso_pi(sk)->conn requires lock_sock, which is not taken in the
"ev3" part of iso_connect_ind.  It may also be NULL if socket has
transitioned away from the LISTEN/CONNECT states before locking.

Fix by adding lock/release. Recheck hcon is valid after lock acquire
where needed.

Fixes: 168d9bf9c7f0 ("Bluetooth: ISO: Reassemble PA data for bcast sink")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/iso.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index dbb8f43052f0..651661833966 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2369,7 +2369,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 
 			lock_sock(sk);
 
-			hcon = iso_pi(sk)->conn->hcon;
+			hcon = iso_pi(sk)->conn ? iso_pi(sk)->conn->hcon : NULL;
 			iso_pi(sk)->qos.bcast.encryption = ev2->encryption;
 
 			if (ev2->num_bis < iso_pi(sk)->bc_num_bis)
@@ -2409,9 +2409,11 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 		if (!sk)
 			goto done;
 
-		hcon = iso_pi(sk)->conn->hcon;
+		lock_sock(sk);
+
+		hcon = iso_pi(sk)->conn ? iso_pi(sk)->conn->hcon : NULL;
 		if (!hcon)
-			goto done;
+			goto release3;
 
 		if (ev3->data_status == LE_PA_DATA_TRUNCATED) {
 			/* The controller was unable to retrieve PA data. */
@@ -2419,12 +2421,12 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 			       HCI_MAX_PER_AD_TOT_LEN);
 			hcon->le_per_adv_data_len = 0;
 			hcon->le_per_adv_data_offset = 0;
-			goto done;
+			goto release3;
 		}
 
 		if (hcon->le_per_adv_data_offset + ev3->length >
 		    HCI_MAX_PER_AD_TOT_LEN)
-			goto done;
+			goto release3;
 
 		memcpy(hcon->le_per_adv_data + hcon->le_per_adv_data_offset,
 		       ev3->data, ev3->length);
@@ -2443,18 +2445,19 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 						    &base_len);
 
 			if (!base || base_len > BASE_MAX_LENGTH)
-				goto done;
+				goto release3;
 
-			lock_sock(sk);
 			memcpy(iso_pi(sk)->base, base, base_len);
 			iso_pi(sk)->base_len = base_len;
-			release_sock(sk);
 		} else {
 			/* This is a PA data fragment. Keep pa_data_len set to 0
 			 * until all data has been reassembled.
 			 */
 			hcon->le_per_adv_data_len = 0;
 		}
+
+release3:
+		release_sock(sk);
 	} else {
 		sk = iso_get_sock(hdev, &hdev->bdaddr, BDADDR_ANY,
 				  BT_LISTEN, iso_match_dst, BDADDR_ANY);
-- 
2.55.0

