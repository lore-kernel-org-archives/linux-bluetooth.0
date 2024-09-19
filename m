Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07AB194C8D
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Sep 2024 16:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726764781; cv=none; b=IdxQst2g2IKSYFdK+cGh53s2neQL40PmTRhCq0/qy7wTUdKkX0yI1HSvcRiVttsYhEF+25jL5hWpyM4Y1wobQXzAzMhqsUENNdAFxotoam/uRh2v0xkBjkmTK3lw+e5ALhzbrlwd9rLG3+qdsY6VBw1qbkn0/KVqUVJRhm7nMwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726764781; c=relaxed/simple;
	bh=kDyYXVgw/rAXkMjUwd6DTUX8psO3Dx8KmFrueCUyDXw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ao0DmMaJq4oZcQoCkt9dGkHGdyyUO5X360PaKHTdfqzjTF+wI8bRNhfNyhgsM3BTap4AtFJnPpKIjqfPV1aVdAX3pvf5VIhwmPBaRZNPHHL5w1/1w6AeoXlSj7ykr2WMq2yhir1RIUGO0PfjcM7s9gosa2Kee8lzPQKSEkWReE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2QknTCf; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2QknTCf"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-502b8d7033cso290248e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Sep 2024 09:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726764778; x=1727369578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BeO1of9jnGxn3CNuuSitFF7RnUCzuirgxNUzc3gzsoo=;
        b=g2QknTCfbFpefeiXEh2+K63xmTWuGdrVYlZJaWdpRPMbE1PYsSXh1GLcaUNeHCY046
         0MJcEolVI2pm7JuUHWiSRRUdx9E4n9yjFfZijNKHUIO9+EKf94dL/yl3g9eYjW26A2bW
         IwOMIeJ2IwKdR0M6PCfnpDJbZlsAokp+73tWjV9xerhoGlU9NvG/elDQtyjvUhKNke0d
         F323lnWwMWZktjIifJmYqyd6edE5uYZsuBtoolYEGInme7vw/fxTPOClOwfB0q4B3l9R
         2pVBGswDP0qTlUmPZAUXGJ4FH7shFQ0MTF94Oq1Gp0otSZjyAa3LxbeHBX1yzVeTYST2
         /xCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726764778; x=1727369578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BeO1of9jnGxn3CNuuSitFF7RnUCzuirgxNUzc3gzsoo=;
        b=Nh+hFyOR2xml/fmttfF9+acvrYomDm+TPen/Paa+HR6XY3J+1Z5xu3R0BXNyGmU2S+
         fCrZrO7lBZ01lYQOwYnoMiHtVJzUQhQ8cflueFDYz/5aNNe9egBJZS2GH9EU0jN5kgqv
         Lq24j0y5zuCnHPIKqQ2LBzVIl7t5+av/fDTxidwQn+p8tpFAK1cPkneZGToaVdIM44Ah
         Be8NCXOo2kVIrwsMjWuPQKQqwVcBbiUZ0w6uStpECl7ucbp/i8MQzDJXdg+CvaltNdlF
         KxPFJjoEuVrwEEustpyCprBUSmd2uME8K2YI6tf4rF7Qul1hSHycPVYDasXaOnUCQIcY
         S/1Q==
X-Gm-Message-State: AOJu0YyMiyHm9cPdUbubBN/DkVERJzUJGWXcV+sr2Os2+pdkwFOxCRpt
	OD9A9+VzOxSWjK8t2q/Uj3qYLoJusfPOlKTs/pUN+BOeeJSoNz6G+OC75Q==
X-Google-Smtp-Source: AGHT+IHjY25bRMlykPrr3o2zIBxzzqf0BezuwFbbCN4+1xAHV1uFcdRfFUnfIbN7HkNFL+dxoYS5yA==
X-Received: by 2002:a05:6122:d9f:b0:4f6:aa3e:aa4c with SMTP id 71dfb90a1353d-503e03df19fmr367052e0c.3.1726764777765;
        Thu, 19 Sep 2024 09:52:57 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5035ba9a40dsm1266544e0c.32.2024.09.19.09.52.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 09:52:55 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_event: Fix re-enabling passive scan when disconnecting a CIS
Date: Thu, 19 Sep 2024 12:52:53 -0400
Message-ID: <20240919165253.847475-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The code was re-enabling passive scan regardless of the link type and
role, so this instead only re-enable when the link type is an LE_LINK
and the role is HCI_ROLE_MASTER.

Fixes: 9fcb18ef3acb ("Bluetooth: Introduce LE auto connect options")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1c82dcdf6e8f..6f6547772ec8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3393,23 +3393,30 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, void *data,
 		hci_update_scan(hdev);
 	}
 
-	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
-	if (params) {
-		switch (params->auto_connect) {
-		case HCI_AUTO_CONN_LINK_LOSS:
-			if (ev->reason != HCI_ERROR_CONNECTION_TIMEOUT)
+	/* Re-enable passive scanning if necessary, since it migth have been
+	 * disabled by a connection.
+	 */
+	if (conn->type == LE_LINK && conn->role == HCI_ROLE_MASTER) {
+		params = hci_conn_params_lookup(hdev, &conn->dst,
+						conn->dst_type);
+		if (params) {
+			switch (params->auto_connect) {
+			case HCI_AUTO_CONN_LINK_LOSS:
+				if (ev->reason != HCI_ERROR_CONNECTION_TIMEOUT)
+					break;
+				fallthrough;
+
+			case HCI_AUTO_CONN_DIRECT:
+			case HCI_AUTO_CONN_ALWAYS:
+				hci_pend_le_list_del_init(params);
+				hci_pend_le_list_add(params,
+						     &hdev->pend_le_conns);
+				hci_update_passive_scan(hdev);
 				break;
-			fallthrough;
 
-		case HCI_AUTO_CONN_DIRECT:
-		case HCI_AUTO_CONN_ALWAYS:
-			hci_pend_le_list_del_init(params);
-			hci_pend_le_list_add(params, &hdev->pend_le_conns);
-			hci_update_passive_scan(hdev);
-			break;
-
-		default:
-			break;
+			default:
+				break;
+			}
 		}
 	}
 
-- 
2.46.0

