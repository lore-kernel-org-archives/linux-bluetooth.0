Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E70C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Dec 2021 22:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237978AbhLUWeA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Dec 2021 17:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbhLUWd7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Dec 2021 17:33:59 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE1CC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Dec 2021 14:33:59 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id iy13so520041pjb.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Dec 2021 14:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6iNVXPe8Wr5X4KioCLQOVekdEYA1Qv5pozxb090b5Pc=;
        b=EOyANWbVxt1kC8EKI/n+SeAxMuJkWO2cUOdmLmGGAOjLkFyDuyOwgIsDcAj2utlImF
         WlckEM5jV/Q+vxAeFcKvyVRRgqXu14EOms76XSVEdHwj7XD9Yif5I3U2rdg/QIZidx9b
         O90fq4CZy/cQP1CxR0mOqJePAIEiUfILinG92Pb2MhoCbL3iYlz6YzdRmfqraizB1iyl
         AsLxZq4TUqs+ZQvp57k5q88+45R4EtEFzCUSQ4B8H0zKaf0iuAns8p2RzGkLqY3L1BBX
         wpK4/s/2KDKTws0cuRmJQgxiveXJazY+Otf0gbEXgMgbw/4w8bMfggboUmvbmBjOzDth
         sLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6iNVXPe8Wr5X4KioCLQOVekdEYA1Qv5pozxb090b5Pc=;
        b=XmI/QRyavDkycL5UQ5l9YiKw7IdsNYrkFKLBMcfHx2ZsILKlp+UdU98+Ib+rIrNAQu
         L3qeCIz4A2QBjUUBHPzCrKVPYNbeArRy2hU4Ght6xfVHxsd7QBoDZjhIbweMNEFOrPiy
         EqubJFkXTtGMLrERx4CCrikcLogpp2J9JyN+OYMM+g7vpAUm8f8c6GaB1Z7zxn/YOMQ9
         uaOd4v/vxo0LmH/7NwWGl6H/dtJkKC4de4GtytkVa8x1vCgdnRFGQ7L9QausrNOcB4dO
         Iu2VayyMt/MhN5uZthvNz90CMXgM4E7RWHsXNMORN3CUfYBzS9zqzZsx59rlIzSOTfg8
         4fkw==
X-Gm-Message-State: AOAM531SZ9aRgMEtX6vr44pqS0WIkFWIQr1UxE6tli2Wdp+V5vIui7IX
        vNrOTVtK8fhptQtDrkq+wZRCH+LAiiM=
X-Google-Smtp-Source: ABdhPJzrmkZURRWz3pbCJq0vJ3pCH/i42lmuAl/pynWan9Szgti3RUz98O8qlbgJoAS0+Hu4bQ2bqQ==
X-Received: by 2002:a17:90b:3e8b:: with SMTP id rj11mr570508pjb.237.1640126038719;
        Tue, 21 Dec 2021 14:33:58 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id np1sm3872209pjb.22.2021.12.21.14.33.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 14:33:58 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 1/4] Bluetooth: hci_sync: Wait for proper events when connecting LE
Date:   Tue, 21 Dec 2021 14:33:54 -0800
Message-Id: <20211221223357.742863-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When using HCI_OP_LE_CREATE_CONN wait for HCI_EV_LE_CONN_COMPLETE before
completing it and for HCI_OP_LE_EXT_CREATE_CONN wait for
HCI_EV_LE_ENHANCED_CONN_COMPLETE before resuming advertising.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
v2: Remove setting of direct_rpa as random address and add a patch checking
hdev->le_states if simultaneous roles are supported.
v3: Fix checkpatch warnings.
v4: Add patch fixing LE simultaneous roles supported vs enabled.

 net/bluetooth/hci_sync.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 917652b67194..28d62273d67c 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5157,8 +5157,10 @@ int hci_le_ext_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn,
 		plen += sizeof(*p);
 	}
 
-	return __hci_cmd_sync_status(hdev, HCI_OP_LE_EXT_CREATE_CONN,
-				     plen, data, HCI_CMD_TIMEOUT);
+	return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_EXT_CREATE_CONN,
+					plen, data,
+					HCI_EV_LE_ENHANCED_CONN_COMPLETE,
+					HCI_CMD_TIMEOUT, NULL);
 }
 
 int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
@@ -5244,8 +5246,9 @@ int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
 	cp.min_ce_len = cpu_to_le16(0x0000);
 	cp.max_ce_len = cpu_to_le16(0x0000);
 
-	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_CREATE_CONN,
-				    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	err = __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_CREATE_CONN,
+				       sizeof(cp), &cp, HCI_EV_LE_CONN_COMPLETE,
+				       HCI_CMD_TIMEOUT, NULL);
 
 done:
 	hci_resume_advertising_sync(hdev);
-- 
2.33.1

