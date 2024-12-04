Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDF63DABE5
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Dec 2024 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331537; cv=none; b=eD1ZxPq26Jln0SUOQ6Ms0G4DxIQM/U8hWIuKSC8I0DxAV1N2mzEas7GhTorwHHPdPokbj+3uSX4QQyyadiHfixLtlZ8SL6OQAHy5klH2cW6k7WoCqIzWasCKPSRPQBfzMfYj6DhaexGwbzXgv77+vxQ6l904xF6/Lo/bUn6wySg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331537; c=relaxed/simple;
	bh=9BRE+vxoVdclxN7Y7usin/T18R1bqMQipel32CaeZME=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EzAo093oeTcfSeUZk9uNWUiObbIKNkWGccZw1W8gG13izkhl8y1CtXLE2Z+TawZmzK7iwjmqtz3kf4s0fqu9svvTCn0dWL9IYtLHQvhxc8OsTgpVeXVOvf6V5Ctnc1FvbP8FNcRo8RLlq9UYOKhrmnOYp+gbrt3/Ay3wQvJrsqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxF0Vp2D; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxF0Vp2D"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-515e1d6b63bso89521e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Dec 2024 08:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733331533; x=1733936333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3NqBtOAx4Gv7qCuHUOTXzvIfnPxkNUKSt7rN5i4yWb4=;
        b=TxF0Vp2DmYCv46ihWCY/QabjKoFdHQ5ALz6QwkTBZTtj/uJFcfFSyqkyvRxwsp1L5B
         6MBpCxLsaHVoUoXHKmYAxH91eBDUC2t7fbPKuZ9ClqpUyrov/ogxR3AZgYKNQ2egm1U3
         /nMjXfSeAyVsWZAPsp4bPsEIRmywiFgDfpN+9feYgi3DkCUsxB3l+pT/4dMnTjgZ8k1V
         g7RWsAwXTEcoTG5OTwUP9xqf3i16hCs0szsQiBiJBpP1Whn2Bh0Zkkm6vkL9mPpZSamY
         34DgUGVt/Cd4ZnWHlCgHqqStlHZhELlJpNmbxhL3y28wDZGAtXhSLkBv7OEpLQyB+n5z
         XI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733331533; x=1733936333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3NqBtOAx4Gv7qCuHUOTXzvIfnPxkNUKSt7rN5i4yWb4=;
        b=q0uSfLrrWWm9z+vXOtt6mdd6WL1rP6bAkt5KnVu5s07yDeTHOsXJBuA7A0rr1zrXB7
         dLoO8+Ep5U8wUR3oZYTgVakELWZ+aaMoH+oYTrcqF3WQrfdQ4ID6Lm247vtZnAptDyUO
         Gc/+/Epup/WyOh8RQ05/88y+es3r76GdCvO39DZ79iIWQERMK5Ue9KOD52NFKm/6sb6Q
         yXGoMyimGHGvPVbaw7bBlZ7yyQso9v673cOC/YirtlTX+26V7w68cC8dUh5kp/sw1gcj
         XM9EyiR5hTFCSMETuRINQhfLo110hTO/hyuv0evc0hUnSosu023B/lYUJRN1/W7+4dMP
         Lqow==
X-Gm-Message-State: AOJu0YwpTSOAskmmGyY56ygjSOVfI/kTMAOh0n/NHj4dPvR0WGhDLjcA
	XJHt+ipo4fHHL/R/vToos0I05iEFC8oog9MkruzGh15Pz0f5bJrZ6htD+g==
X-Gm-Gg: ASbGncuCjKQSnn2FBLtbziIxEz5poYHo/n7vU6w0D9cHZyp6ObTcy4t5xJ/Gheq35rN
	YNpZR3/6gkIGN8afhaRoKG+KDjeGQbrLRTTo/3C2mLezjZkN6Bg4CvAKkPrVOhYJyeOzt/Zc+dZ
	zNMosNxYMVKqz5V2w5FnVk8y8QQOwLwDh+9G5aYiAzuXT0j51F5+aXX/KODPDHasfwfyzb7BfcM
	eFVZSOaOwJRrO+apD71ml+RLoFMyGc19mYWODaeTUhmdVRnshf2gUKeEd6fMugv1JLMieGSp9rt
	Agm2Ha/Agn+YjH8OuUPB9A==
X-Google-Smtp-Source: AGHT+IFx0wgQLqrgsQLGzQJ9rfwmr6uMAeJ3Iib5uqbxYL8pW5RrxiH5pZTS8ENDjKGh6IKR3+QZ6Q==
X-Received: by 2002:a05:6122:65a0:b0:50b:e9a5:cd7b with SMTP id 71dfb90a1353d-515bf526dc7mr8063022e0c.9.1733331533078;
        Wed, 04 Dec 2024 08:58:53 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85b82a0e475sm2449898241.7.2024.12.04.08.58.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 08:58:51 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_event: Fix using rcu_read_(un)lock while iterating
Date: Wed,  4 Dec 2024 11:58:48 -0500
Message-ID: <20241204165849.392564-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The usage of rcu_read_(un)lock while inside list_for_each_entry_rcu is
not safe since for the most part entries fetched this way shall be
treated as rcu_dereference:

	Note that the value returned by rcu_dereference() is valid
	only within the enclosing RCU read-side critical section [1]_.
	For example, the following is **not** legal::

		rcu_read_lock();
		p = rcu_dereference(head.next);
		rcu_read_unlock();
		x = p->address;	/* BUG!!! */
		rcu_read_lock();
		y = p->data;	/* BUG!!! */
		rcu_read_unlock();

Fixes: a0bfde167b50 ("Bluetooth: ISO: Add support for connecting multiple BISes")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index aca121408369..0d59f2cfb9a4 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6872,38 +6872,27 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 		return;
 
 	hci_dev_lock(hdev);
-	rcu_read_lock();
 
 	/* Connect all BISes that are bound to the BIG */
-	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
-		if (bacmp(&conn->dst, BDADDR_ANY) ||
-		    conn->type != ISO_LINK ||
-		    conn->iso_qos.bcast.big != ev->handle)
+	while ((conn = hci_conn_hash_lookup_big_state(hdev, ev->handle,
+						      BT_BOUND))) {
+		if (ev->status) {
+			hci_connect_cfm(conn, ev->status);
+			hci_conn_del(conn);
 			continue;
+		}
 
 		if (hci_conn_set_handle(conn,
 					__le16_to_cpu(ev->bis_handle[i++])))
 			continue;
 
-		if (!ev->status) {
-			conn->state = BT_CONNECTED;
-			set_bit(HCI_CONN_BIG_CREATED, &conn->flags);
-			rcu_read_unlock();
-			hci_debugfs_create_conn(conn);
-			hci_conn_add_sysfs(conn);
-			hci_iso_setup_path(conn);
-			rcu_read_lock();
-			continue;
-		}
-
-		hci_connect_cfm(conn, ev->status);
-		rcu_read_unlock();
-		hci_conn_del(conn);
-		rcu_read_lock();
+		conn->state = BT_CONNECTED;
+		set_bit(HCI_CONN_BIG_CREATED, &conn->flags);
+		hci_debugfs_create_conn(conn);
+		hci_conn_add_sysfs(conn);
+		hci_iso_setup_path(conn);
 	}
 
-	rcu_read_unlock();
-
 	if (!ev->status && !i)
 		/* If no BISes have been connected for the BIG,
 		 * terminate. This is in case all bound connections
-- 
2.47.1

