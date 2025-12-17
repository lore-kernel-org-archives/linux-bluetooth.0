Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E57296BDB
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 20:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766004105; cv=none; b=XvG6hSdms98D4QF2ncA3Le7BPy3BsojIV/uS259rkbVMkR878KPWvcmow4gW89ddbFkQBD3IHpXGCwvjwL4PCeVoba4M2n8/5BOB5WL8zi7fcR7NjyEz+bMTNusr7U9VaXRIiuOEwIFRPqFZNVgAvI9C1Z814aXqRYXyeNV9QbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766004105; c=relaxed/simple;
	bh=9aAJZ1cEWpC3mhYS8n+8+t+jGBsvP550sKGW92mMh3g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=c80w4IkeHv18+K0UyvbRr1iCvpJ5FiuXSisE6DRR8ayiZVdvo0J/bswmnB8ZFcVC807/ODp6rzKmZMhtfTU+cTopCP+WWV/ekRPADbFqgxUXcvFnVPNKkmML/42tiPJq5U9GkaD5QwI4GOWAGMUL6ziBtjfv4jeJOBWlAlSAd2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfEMZ9zT; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfEMZ9zT"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5dfd0101905so1989737137.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 12:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766004102; x=1766608902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=96xxpAMLCSEcb/3suquLSa5DVca/OqtGmzHrBWScTuk=;
        b=nfEMZ9zTt14HVImGnenNdoxHozkYzJDqIrjRPOXLgBbrXs6fnnPuoMUj0/UFmw52aa
         ZknezoxDTloikOErxYLJmmVMrein4CVG9aGIL58WkxCmWxNQvok7WZfbx9rD7OnTjfxL
         kYXbnci87e5K8evW1u8YZUl5WJqAAkzXh7spdrpUbW6VD6KKryzP8qVg+0q7kkupCz8U
         tSquYSsuiTSPoNikBWzFYgLguHuqdRpOuyHbdm9JUNzqeZr+V7NalCri6kE08a/HL7hI
         LPAGBnig/RGiYfiEcWDKlAITEnaCAv7xMLytSfoInnAwMgo3KqVrVMUyDoIBxeXZPtcO
         QFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766004102; x=1766608902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=96xxpAMLCSEcb/3suquLSa5DVca/OqtGmzHrBWScTuk=;
        b=uJBSia7+HKTRHoLpI2JbIUAO9E9jEj2yZx7NAhNonxTiHD8xMRLoq1jt8ONf15ArCa
         S+5YuY/2HpFN6P/PbIyGaxtwHmjM9CcPgmRxA+d7k4GU+xkIIYtN6cBD70N+IKvscs+m
         dlyUPqA9LQa2kkTYvnhfkt3ImSmjcdR97lid7PWUi/Y4eYfBgnw5nSFB3mz1ho2WrYRY
         EP9u4p9gzOE4atAia17xZmEaMM7xdrO/NmJu/ELY94wbL8w/pg4YdSBetKSCNWwJMCoC
         /YKilG/TM/FsWEDI7YekL4t+ouhL/z4va24X5fq/ljl+rPZ8xIZvgxXTgCekCba2/r68
         4/Yw==
X-Gm-Message-State: AOJu0YwceV6bZcFPkk0N7LwE59vROKuVUHsECIXtJjGgHtzG8SEeGxQl
	BY+51RaaL4x9oJeXlw1yQizwD1WqNiV0czQQSMIadGXqI21cw4REX5hoxt2oYBov
X-Gm-Gg: AY/fxX56xVC9z1ECvFZrS7PKIdXPiJE1RzwFzgi+ZRozGicG9ahQm+w+lc/+5LP6iCY
	YmXuKmTlEYLpLNBzB/zL3jka+R4Zrbzq5AzrPPIow4AABrHHbDbyKUjUZLZNvJEkhzG8JtVscV2
	xMTcc14aa6JprnlIcsC8vaGa9La6Ecy4e/pD72XzQYIh8IUzMhj11swfTTJS0xaHFtCK3wjY8wC
	KoXvCCwEbLrRXVhOVFt+Vj7IiptPIm7BPlW2ZaIyqgAiQxiD3Rg7aDuXO6H3pO4uzO/m/HehZ2z
	PoRGgo7NcCS06FVRlXQY4iY9xxKJ9/5q1UG6nLA41PRMpn+rz2I59+Ycur5AE3UsCl8cSo2uE/O
	+9Ciq681wAZiwFBwrbCx2KhvAKfR0OPYKCYMF6uRAg4OLiCZWGFAiGbqAqhrdlrqWyEpV4fUybg
	7Fp/0UZBOwYcAvWw==
X-Google-Smtp-Source: AGHT+IFyG9gJlYLTnhJJIZTU4HoZfKUh3ebmKi2Nw5oXaYg9zhtI5CxLkH4tHB7eBmfijr5dswO2eQ==
X-Received: by 2002:a05:6102:5487:b0:5db:e1ad:770f with SMTP id ada2fe7eead31-5e827474f8amr6254875137.2.1766004102356;
        Wed, 17 Dec 2025 12:41:42 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5eb057e3f0bsm119217137.4.2025.12.17.12.41.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 12:41:41 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/3] emulator: Add support for BT_HCI_CMD_CHANGE_CONN_PKT_TYPE
Date: Wed, 17 Dec 2025 15:41:31 -0500
Message-ID: <20251217204133.282359-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for BT_HCI_CMD_CHANGE_CONN_PKT_TYPE as well as
emit BT_HCI_EVT_CONN_PKT_TYPE_CHANGED when it completes.
---
 emulator/btdev.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index c84bcf783658..41e9c68f5f45 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -1928,6 +1928,45 @@ static int cmd_pin_code_neg_reply_complete(struct btdev *dev, const void *data,
 	return 0;
 }
 
+static int cmd_change_conn_pkt_type(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_change_conn_pkt_type *cmd = data;
+	struct btdev_conn *conn;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	conn = queue_find(dev->conns, match_handle,
+				UINT_TO_PTR(cpu_to_le16(cmd->handle)));
+	if (!conn)
+		status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+
+	cmd_status(dev, status, BT_HCI_CMD_CHANGE_CONN_PKT_TYPE);
+
+	return 0;
+}
+
+static int cmd_change_conn_pkt_type_complete(struct btdev *dev,
+						const void *data, uint8_t len)
+{
+	const struct bt_hci_cmd_change_conn_pkt_type *cmd = data;
+	struct bt_hci_evt_conn_pkt_type_changed ev;
+	struct btdev_conn *conn;
+
+	conn = queue_find(dev->conns, match_handle,
+				UINT_TO_PTR(cpu_to_le16(cmd->handle)));
+	if (!conn)
+		return 0;
+
+	memset(&ev, 0, sizeof(ev));
+	ev.status = BT_HCI_ERR_SUCCESS;
+	ev.handle = cmd->handle;
+	ev.pkt_type = cmd->pkt_type;
+
+	send_event(dev, BT_HCI_EVT_CONN_PKT_TYPE_CHANGED, &ev, sizeof(ev));
+
+	return 0;
+}
+
 static int cmd_auth_requested(struct btdev *dev, const void *data, uint8_t len)
 {
 	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_AUTH_REQUESTED);
@@ -2789,6 +2828,9 @@ static int cmd_enable_dut_mode(struct btdev *dev, const void *data,
 	CMD(BT_HCI_CMD_PIN_CODE_REQUEST_NEG_REPLY, \
 					cmd_pin_code_neg_reply, \
 					cmd_pin_code_neg_reply_complete), \
+	CMD(BT_HCI_CMD_CHANGE_CONN_PKT_TYPE, \
+					cmd_change_conn_pkt_type, \
+					cmd_change_conn_pkt_type_complete), \
 	CMD(BT_HCI_CMD_AUTH_REQUESTED, cmd_auth_requested, \
 					cmd_auth_requested_complete), \
 	CMD(BT_HCI_CMD_SET_CONN_ENCRYPT, cmd_set_conn_encrypt, \
-- 
2.52.0

