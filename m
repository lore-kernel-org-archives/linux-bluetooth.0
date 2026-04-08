Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F503D75C9
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Apr 2026 18:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674059; cv=none; b=Ml1AZT39qMhQ27i6kGAMqS+Gsqsi4FhgrxUAV1TzvoYEExHIyxlWNmo2oUfwUIbbt2fKuTqVwcHrL2+KK5P8v0+TeFLOdroIXPfpyrlxZpeFTuapLztxlzAd4tu/QcAmonj1U2ZPO2xhzvm7KalgSeSVsyYqZX6klhqnd2MgOlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674059; c=relaxed/simple;
	bh=DPeRicZoeJwwTklvwGImOReRg6D/xQ+5G/sf11Jp0ak=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eGZA1oiHxQnVmqodyFPAK1emZ6RBK3i6cB8zTAK61nep4BHKrocfH7hGa6LUfIIrInUCIHp8NNl9MgfkpZw8ccx+8veVywUIsmYCOkUJmuGHKZRw6Ncrthn5f1IR9NIrLxBU8c8kxybOfhyIrOjvC0mF729nL8mIi27G69u/Qjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEE6lXpC; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEE6lXpC"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82ce2e2880cso59793b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Apr 2026 11:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775674058; x=1776278858; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yKXHDv9GjAiphNyU5HNZmoO2xChaqQ37Lybj8tpzSnY=;
        b=LEE6lXpCdIFKSKvS8UshGXmSKPGTtPG6umDUxh6Ml5b8nKdXv4ULu2nQDo/1Lt9/W/
         yUhSvagjAA1bTsaM9DSkZfhjhRCnrWRkSOjHHvk9ndnlmEjldfdl/3TKl6wUjwxaU9S9
         WxyrEGeRhg2bM6zhOd7qfC1J8e2wy+Pn2szygRIn9US+ALquJHiU8KUpOhyjxp68zCSN
         B7Q8FlX3N3xEkC4MQgLs6vDkLHfsLzOSw0l+hJiIyF4PF6c9IXwwVfbedLWJri8bFw1r
         v9kMpSvEQDwKU8iJhWbO0AzgDtKf7thxnmsz0k3AsMwz19j7eJXJAkD8eEZLcULPNOS9
         ap0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775674058; x=1776278858;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKXHDv9GjAiphNyU5HNZmoO2xChaqQ37Lybj8tpzSnY=;
        b=ZP+qeqkOfAiJTj9ybLyhpsUlhJY8QtMV9NPuwYyMeTY5uyTzW0c2A2dESULaNYHcP7
         SEcn2LPdBQPCLIbBbf4rDJhARExJJNutKnOr31N7HFIlsAS5v96RU5xO5hTCKMuxC2ZR
         dvSWtHjhmlw7sS+DOLgrtYt1Qlu9r/2hPboTsXbqinfgJeTf7ewfyGffrfNjpOUcl7IT
         SuJbTR/5hCvwTtXLKDlSZ3XWjfwwI1aU/JGWYcF79y9eVcUvothnIRwMj0IyTDbnvoBU
         lNFy+D8+GVcppwZBW9d7ECkbTXURWA5Y8Q78QFWR2mjJShh6ft1XoOdf9U07J9pU1fVY
         hNQQ==
X-Gm-Message-State: AOJu0YwgkRxEIQcNL/Veh0qyXhQyvoaPH6e5NcO5dZ73SoBh7a46U5m7
	nE+fAsmOD+bHqwd24p2BWvyN2qsQSlA+qz48nwlHLRbMw/LVKoqe8cP/UxuZtIkf
X-Gm-Gg: AeBDievCI0fV55pCEdVl8PyUB2d2xFbSUb3g0joNSSBXeB2fDzIggwBhjqRr30vhB0U
	c4lMQBelqexAqguJv3nkaNff8aoRKEafFT7uyzFq3LE9JccmcbOY834JzfNjrl1zT27NPPqcpTC
	2CqUJeDa5jOdxMycJjkOJAxfRzcjD7vah7HLAToPeEtNF1K0cecaSIvG38wmHlmTTeKzwvjmXLu
	yWORQpzUZEk+RgBCZe1MtkC+uNMF+XOA1wBMbwR8KVC4YX33ZCqHJIYeY1Wav48UrOW/3ce8LkB
	ezDQVcoaF1r0Ij3PBfu+cmqC9PxEjTrFEJPiv/ABYLEffguydLaE7qV/uU4nmZBaFV+gGSj6rgo
	G228ENNbT1XNRAu+44uSi1d7QWgVqXrhk4hZwDYWOlMPyWC7tqzB9rGobTfwSnfsOZxmiaDj3Qd
	OpKn+WIsryp9ApXTAjgqtUyEpTLfHv2tQdHFhESf424rfsBP73J8dGyewFwO9QrJlRL8O+JhMYl
	MAH0Et/qANf7bVg
X-Received: by 2002:a05:6a20:6a28:b0:398:a060:a967 with SMTP id adf61e73a8af0-39f2ed92c72mr22857387637.11.1775674057662;
        Wed, 08 Apr 2026 11:47:37 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([103.10.31.106])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c657dfb7sm18725587a12.24.2026.04.08.11.47.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Apr 2026 11:47:37 -0700 (PDT)
From: Shuvam Pandey <shuvampandey1@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject:
 [PATCH] Bluetooth: hci_event: fix potential UAF in SSP passkey handlers
Date: Thu, 09 Apr 2026 00:32:30 +0545
Message-ID: <177567405034.77733.13793767420759611909@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

hci_conn lookup and field access must be covered by hdev lock in
hci_user_passkey_notify_evt() and hci_keypress_notify_evt(), otherwise
the connection can be freed concurrently.

Extend the hci_dev_lock critical section to cover all conn usage in both
handlers.

Keep the existing keypress notification behavior unchanged by routing
the early exits through a common unlock path.

Cc: stable@vger.kernel.org
Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>

---
 net/bluetooth/hci_event.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3ebc5e6d45d9..6500f7a327f6 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5496,39 +5496,46 @@ static void hci_user_passkey_notify_evt(struct hci_de=
v *hdev, void *data,
 	struct hci_ev_user_passkey_notify *ev =3D data;
 	struct hci_conn *conn;
=20
 	bt_dev_dbg(hdev, "");
=20
+	hci_dev_lock(hdev);
+
 	conn =3D hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
 	if (!conn)
-		return;
+		goto unlock;
=20
 	conn->passkey_notify =3D __le32_to_cpu(ev->passkey);
 	conn->passkey_entered =3D 0;
=20
 	if (hci_dev_test_flag(hdev, HCI_MGMT))
 		mgmt_user_passkey_notify(hdev, &conn->dst, conn->type,
 					 conn->dst_type, conn->passkey_notify,
 					 conn->passkey_entered);
+
+unlock:
+	hci_dev_unlock(hdev);
 }
=20
 static void hci_keypress_notify_evt(struct hci_dev *hdev, void *data,
 				    struct sk_buff *skb)
 {
 	struct hci_ev_keypress_notify *ev =3D data;
 	struct hci_conn *conn;
=20
 	bt_dev_dbg(hdev, "");
=20
+	hci_dev_lock(hdev);
+
 	conn =3D hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
 	if (!conn)
-		return;
+		goto unlock;
=20
 	switch (ev->type) {
 	case HCI_KEYPRESS_STARTED:
 		conn->passkey_entered =3D 0;
-		return;
+		goto unlock;
=20
 	case HCI_KEYPRESS_ENTERED:
 		conn->passkey_entered++;
 		break;
=20
@@ -5539,17 +5546,20 @@ static void hci_keypress_notify_evt(struct hci_dev *h=
dev, void *data,
 	case HCI_KEYPRESS_CLEARED:
 		conn->passkey_entered =3D 0;
 		break;
=20
 	case HCI_KEYPRESS_COMPLETED:
-		return;
+		goto unlock;
 	}
=20
 	if (hci_dev_test_flag(hdev, HCI_MGMT))
 		mgmt_user_passkey_notify(hdev, &conn->dst, conn->type,
 					 conn->dst_type, conn->passkey_notify,
 					 conn->passkey_entered);
+
+unlock:
+	hci_dev_unlock(hdev);
 }
=20
 static void hci_simple_pair_complete_evt(struct hci_dev *hdev, void *data,
 					 struct sk_buff *skb)
 {
