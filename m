Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4E1289830
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753806312; cv=none; b=r5YtJdQFWPguAiyGKIZco9VL+nhsKTsZqXKshvcIyIg0IZycDKQPJpZKLGgvMCk0J4X/e/IMuCV3VMNtSfsFZ/uWTCo4snmld7UnyMjB75kAjciEZ4ZRbgEFYSSYspjhJG+kqFj+yecEPGcaxgXxnvoYUcnXWMJEX6ww0sQg8Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753806312; c=relaxed/simple;
	bh=Oqou2WzDRfdfjEeGo8nPmezYJyIJVWvwR4YmWPmq4WI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPSV+5pk9F9LOfnFIJCRie1iiq5yh5cQ5VWVZ3RhYMF3pzYbKiyiwPq6rD+ma0cgNExhMiE/jgiE1x2xNgqnYzof3ZuQu4OX0wI3aAB0gldIaNAyZk8M/B3LL+23KwXNFLSbWKgT/5RXJJnrN+eq4qPRWsHEBv30VWQVDp5eDGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WeVdgbi5; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeVdgbi5"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5346b405d1aso3478281e0c.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 09:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753806309; x=1754411109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9FFb97GSV/X3/LHfN4XYeNCb3U7KTCo6t5xV8IWQixw=;
        b=WeVdgbi5C6vPj6UpMWWQz6b0OdOLSnNwdlMKX0VFk/yzqsnBYTd85GA15sF70eat1c
         CEBWfBxeXOFWnEeSL807pmCo76lIok1Z5WxMoLJDRBobC04bdgxCUuL9pE1ezZ+xiA6+
         0B1ixEJDCJ0i+zl3JiqSo0OmnbSRslhuTVsMIR9iNrpb43tNHqxiIayQ/XQvNj+ybfKN
         3hBIyPCJIdSBl7cfOWfsUxQRWlVspAACFdeiLRMQ3B9J1cg4Q2GpElgR4lnVyvvI0MAB
         Uba65aFgMGbRI84fr69yI9pCoHgNVU/nZJbU18F78yhUc9pg9/HIonj6yJkfB8poSkm7
         JOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753806309; x=1754411109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9FFb97GSV/X3/LHfN4XYeNCb3U7KTCo6t5xV8IWQixw=;
        b=iXeoD4BbJhvdv/oAGhIM0EpSYFYrj/NQAIGLlspxkBIP6pyvCcngeWMX4Hanu1kXjX
         IywlwRma99Sjjo1Jc5LsQ1hNnzzD/+KKv9s5yi5ku3YjApmH44Le8wwavsTYSeQf4ohP
         FqT3UFAHf95NZvvsU29jCoso1G/cK5V6vmLc5QG76devJ5bQEiu/TOyM+2Ppl5tgGlvA
         ZXqHx1JVNsQGgHAgF9ylYXsXPeKJnOWdWqizlP41b7oFFKyY9EezsCzYiUNTChwoRTPs
         Bbds4Mpe/obk1vgIF3JJB+Z9vVHxL58Rs+kb1/Xj1ZRdbfP2hBiQnW6ozVvRMgg0p6+W
         XsNQ==
X-Gm-Message-State: AOJu0YzM00x9sjFV7mjJnXkoWDeZspaXk/SKPgt6k+5MHPgQK5CnGRFY
	9FABxPC0MpBmkl4WzFoyC7StvNCvvfLOivYEON3CPjRYaBKBZ3QMiB2x6YAC2WHr
X-Gm-Gg: ASbGnctj79Ugs+RE9+m/oikpSuqe4iIMP2uckzbrnXVje4RZAK1v4hkfiqyB5YntlWj
	hZy+hBm4kRKhCSogQU8nMGl6RB8meyTx6+j0vr9S8nwMsj5C0LdWyOGDhqrtz+DnqhOL0u0bB9S
	oxxLV1JQlSddwzD3YKKYZgu+gAMEuuvsY20od+LqjUJd84pMkVoNtMRYfgcF7nmDaHSO9iGoRVd
	tvRvWrks34L3e5CbqsItvgP+xQv6X4OZPXZ/gtMbBPEBkHUqqX6YUzFGLrZcoR9PNwDZjB23Guk
	qz1I9zqIXnpVJy8lLs7On92WNRu6I6HzfpInKOVbxTaWWkKvwfbm9RQBh2MUGLhBDYa08a3IayO
	v4FpXXqoHCIfF/bp7eLtjyPEP+Wv/m67EbN+Go4PjvgzN4k0oETefA1LBwxXt8G/Z
X-Google-Smtp-Source: AGHT+IEvgJF3E/Tmk/Y1ivmWgK7pjgn2ypOQKnkTIFCcGNZJiskBm6KFR+ohLbMLSvjUuUPnbjtDxg==
X-Received: by 2002:a05:6122:45a8:b0:534:7580:e153 with SMTP id 71dfb90a1353d-5391ceea53fmr421419e0c.6.1753806308588;
        Tue, 29 Jul 2025 09:25:08 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-538e288700bsm2139773e0c.27.2025.07.29.09.25.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 09:25:07 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/4] Bluetooth: hci_conn: Fix running bis_cleanup for hci_conn->type PA_LINK
Date: Tue, 29 Jul 2025 12:24:52 -0400
Message-ID: <20250729162453.221656-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250729162453.221656-1-luiz.dentz@gmail.com>
References: <20250729162453.221656-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Connections with type of PA_LINK shall be considered temporary just to
track the lifetime of PA Sync setup, once the BIG Sync is established
and connection are created with BIS_LINK the existing PA_LINK
connection shall not longer use bis_cleanup otherwise it terminates the
PA Sync when that shall be left to BIS_LINK connection to do it.

Fixes: a7bcffc673de ("Bluetooth: Add PA_LINK to distinguish BIG sync and PA sync connections")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c  | 12 +++++++++++-
 net/bluetooth/hci_event.c |  7 ++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 7d1e79f69cd1..f8b20b609a03 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -830,7 +830,17 @@ static void bis_cleanup(struct hci_conn *conn)
 		/* Check if ISO connection is a BIS and terminate advertising
 		 * set and BIG if there are no other connections using it.
 		 */
-		bis = hci_conn_hash_lookup_big(hdev, conn->iso_qos.bcast.big);
+		bis = hci_conn_hash_lookup_big_state(hdev,
+						     conn->iso_qos.bcast.big,
+						     BT_CONNECTED,
+						     HCI_ROLE_MASTER);
+		if (bis)
+			return;
+
+		bis = hci_conn_hash_lookup_big_state(hdev,
+						     conn->iso_qos.bcast.big,
+						     BT_CONNECT,
+						     HCI_ROLE_MASTER);
 		if (bis)
 			return;
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8aa5039b975a..4f0a6116291e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6957,9 +6957,14 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 				continue;
 		}
 
-		if (ev->status != 0x42)
+		if (ev->status != 0x42) {
 			/* Mark PA sync as established */
 			set_bit(HCI_CONN_PA_SYNC, &bis->flags);
+			/* Reset cleanup callback of PA Sync so it doesn't
+			 * terminate the sync when deleting the connection.
+			 */
+			conn->cleanup = NULL;
+		}
 
 		bis->sync_handle = conn->sync_handle;
 		bis->iso_qos.bcast.big = ev->handle;
-- 
2.50.1

