Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE151FC3
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 20:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753388678; cv=none; b=UP4iVBQ2PoF7RMcYvYKpYmHE/x+3uz7zprAZOokTxmDsTqXV/RjBwIgCvNMSYUDifCqtJm1/9gYUI+BYLWsc0/v+PjIlWMGaOWno5c0RJV2f1X1d9+EbFca3lA8miVsXSkJq5YFjaBd8OYOBvRvWLXWk0ntFjypJzROL80CvTK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753388678; c=relaxed/simple;
	bh=8A7yxMFcPFtXcNk+qIki8GHIQveTexh7IxXYJFzQqQQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NRs1hq67OWCpMdjASoXVGW3/99l5UYbV7Piy1rYiOBPtjgBohyRziffLpqJHoii3aYvwf3tX+FRRi3jWcG8XOe7H/oL/ZPQUWmwibYjo60RkX0PVaD9ubYmFRAXCW1J8XSvaOaqzJZvWuHyg1R+iSBc38MCAC9Vx1LWM3AJyuCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/sePhas; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/sePhas"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-52d9a275c27so994368e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 13:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753388672; x=1753993472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4yypNQ3y8u+PMkLOMsK4HMGBhYizh4INhPXVAthmRkk=;
        b=i/sePhastnt4IVfHNiJm3I17QNdMa6zZiqCWzLdRy1sf6MSYbcnc6y3k0LOoApAOqo
         VzPuEIHSD3mnYvmEc28YxoXbGxrfwPKpFVwkiPKi9GRdOQ55PKfPklAq3Z0YznqMSAbB
         XsLJsdH+mcxXkQT2fTHk/bY1SHPy3PBjpwkyMY2+4fNlP1VTVyX1KOpy0l+d8tJ85w4x
         hAcpcn+h5CVLzHUqXI3u6WfihfbZhyTrVi+HNM17jN4RY4aMfyWp7ypRB3nrVCiXRET+
         9vUV8pm0ek9+xPARTp1uramGgqWDrG4s6hfsDITcpkE7tiLObAqkdRKMf+xSD1fFHBHF
         vAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753388672; x=1753993472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4yypNQ3y8u+PMkLOMsK4HMGBhYizh4INhPXVAthmRkk=;
        b=qLIGd9paScHjA9R0V4UmH40Ze1RKHW2K9pohZ9svphG/o+5rG5RUISB87fLnc5s1NH
         AzhMOM8ink4OuSo7tAi8BFNBv5Lst61E6TfzwwhKatrzB/a4C7Yh+Ncr93MkOcAZCBZl
         N6ysw4BHcvLggkO/FklgLIMrKxsCYJ8TksbUvdIc/ByWN/Gti2TMu/u2I6tvjyLeYNEK
         dX9qGNuf0gjKrxtOa/HWSR14kbn7TzQV+b+lBcKLdWzNvu2l/9QKdR1XYL8tgpFhdCNP
         LcDH3razrOqLa11yWX21tGUgt3VG7j3zrolPf/Z6+0xXYPzU6mMpqU7HJ8z9zy/knWzx
         3TXA==
X-Gm-Message-State: AOJu0YyhmGvoOr0X8Xx9Zzl3AH/h7bU4rFqIixsl/CgFsRSTWPrwROv+
	lOhyc73dv6+W/7UKNtf031KTnIGWxG5wLJtSdbHQtFE+v5nrNQO/YdaZBHl3jw==
X-Gm-Gg: ASbGncvfPOV/gXXXvUN6+k+3LY+pJGsKJuIdn6KSpyxpGyfyOYY3RpH/U/FfzbSEmXm
	3RCSr0ID/XlkHft7wLMKBAvOd7dBVPShEJGpHbA3IMFAJW5CSpfhWSIy4ZhOVIeI9bBn+EeQloy
	vr9gDp5QcKMsscHvqSKNSxsCuVgA8KJ/OIZ5VlmUocgIyLhYlF2cVljVbFG5dkFdNdaaZhOC6UQ
	26xmlNPsL5Ml1tmkYlKN0Thg1Blj8kC7qECiEvK6aWBzw2wAGupFPGNxG9Z/n9nxPlQj1sghtlI
	6EHD8tkR7MJvIu0ezKLp9zlD5jAl/CdP5xx5stFWhphm2fOldun9MLuEgkfPZcYjWdQVtkOGOQN
	KWLqCYy7sgPlI76zePF/hR94HpXqNvrbjJp1NxHzUw1MdccROPbnWBGGZMnJC1Wil
X-Google-Smtp-Source: AGHT+IGFUyCLWzyby9t2mRmTcoAgaFd8a9kEpaKG4ny3FZbOs8TNzGWMC/k01aotf180U2MI3RcBcQ==
X-Received: by 2002:a05:6122:1804:b0:535:e35d:49f4 with SMTP id 71dfb90a1353d-537af60ba14mr4953027e0c.11.1753388672328;
        Thu, 24 Jul 2025 13:24:32 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-537bf89e500sm593413e0c.33.2025.07.24.13.24.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 13:24:31 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/3] btdev: Add le_big on BT_HCI_CMD_LE_CREATE_BIG
Date: Thu, 24 Jul 2025 16:24:22 -0400
Message-ID: <20250724202424.6978-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When handling BT_HCI_CMD_LE_CREATE_BIG create a struct le_big to
represent it otherwise the likes of BT_HCI_CMD_LE_TERM_BIG will not be
able to detect a BIG was created.
---
 emulator/btdev.c | 77 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 57 insertions(+), 20 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index cc844fc3a8ec..7293e2f2e5f1 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -6417,16 +6417,59 @@ static int cmd_reject_cis(struct btdev *dev, const void *data, uint8_t len)
 
 static int cmd_create_big(struct btdev *dev, const void *data, uint8_t len)
 {
-	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_LE_CREATE_BIG);
+	const struct bt_hci_cmd_le_big_create_sync *cmd = data;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	/* If the Advertising_Handle does not identify a periodic advertising
+	 * train,, the Controller shall return the error code Unknown
+	 * Advertising Identifier (0x42).
+	 */
+	if (!dev->le_pa_enable) {
+		status = BT_HCI_ERR_UNKNOWN_ADVERTISING_ID;
+		goto done;
+	}
+
+	/* If the Host sends this command with a BIG_Handle that is already
+	 * allocated, the Controller shall return the error code Command
+	 * Disallowed (0x0C).
+	 */
+	if (queue_find(dev->le_big, match_big_handle,
+				UINT_TO_PTR(cmd->handle))) {
+		status = BT_HCI_ERR_COMMAND_DISALLOWED;
+		goto done;
+	}
+
+done:
+	cmd_status(dev, status, BT_HCI_CMD_LE_CREATE_BIG);
 
 	return 0;
 }
 
+static struct le_big *le_big_new(struct btdev *btdev, uint8_t handle)
+{
+	struct le_big *big;
+
+	big = new0(struct le_big, 1);
+
+	big->dev = btdev;
+	big->handle = handle;
+	big->bis = queue_new();
+
+	/* Add to queue */
+	if (!queue_push_tail(btdev->le_big, big)) {
+		le_big_free(big);
+		return NULL;
+	}
+
+	return big;
+}
+
 static int cmd_create_big_complete(struct btdev *dev, const void *data,
 							uint8_t len)
 {
 	const struct bt_hci_cmd_le_create_big *cmd = data;
 	const struct bt_hci_bis *bis = &cmd->bis;
+	struct le_big *big;
 	int i;
 	struct bt_hci_evt_le_big_complete evt;
 	uint16_t *bis_handle;
@@ -6439,6 +6482,16 @@ static int cmd_create_big_complete(struct btdev *dev, const void *data,
 	if (!pdu)
 		return -ENOMEM;
 
+	/* If the Controller cannot create all BISes of the BIG or if Num_BIS
+	 * exceeds the maximum value supported by the Controller, then it shall
+	 * return the error code Rejected due to Limited Resources (0x0D).
+	 */
+	big = le_big_new(dev, cmd->handle);
+	if (!big) {
+		evt.status = BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
+		goto done;
+	}
+
 	bis_handle = (uint16_t *)(pdu + sizeof(evt));
 
 	memset(&evt, 0, sizeof(evt));
@@ -6448,10 +6501,13 @@ static int cmd_create_big_complete(struct btdev *dev, const void *data,
 
 		conn = conn_add_bis(dev, ISO_HANDLE + i, bis);
 		if (!conn) {
+			queue_remove(dev->le_big, big);
+			le_big_free(big);
 			evt.status = BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
 			goto done;
 		}
 
+		queue_push_tail(big->bis, conn);
 		*bis_handle = cpu_to_le16(conn->handle);
 		bis_handle++;
 	}
@@ -6540,25 +6596,6 @@ done:
 	return 0;
 }
 
-static struct le_big *le_big_new(struct btdev *btdev, uint8_t handle)
-{
-	struct le_big *big;
-
-	big = new0(struct le_big, 1);
-
-	big->dev = btdev;
-	big->handle = handle;
-	big->bis = queue_new();
-
-	/* Add to queue */
-	if (!queue_push_tail(btdev->le_big, big)) {
-		le_big_free(big);
-		return NULL;
-	}
-
-	return big;
-}
-
 static int cmd_big_create_sync_complete(struct btdev *dev, const void *data,
 							uint8_t len)
 {
-- 
2.50.1

