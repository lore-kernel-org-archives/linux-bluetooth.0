Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD17C433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Feb 2021 10:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F1F360295
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Feb 2021 10:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhBVKb0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Feb 2021 05:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbhBVKbS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Feb 2021 05:31:18 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E3DC061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Feb 2021 02:30:38 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id u4so10949100lja.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Feb 2021 02:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qnXfQkuQax+urG+3M24GD/QjcSdsFnSg39G2UiF/0Iw=;
        b=KM/waiK8demfUVKz6gGShBWv7QGoA2wko2yk5i1GIC7sSDfcMTJ+3ekBXYMlAdSelb
         2Kxh7814+9TOGQYwwTQePdePauaku570Tg6kUftTWBfBuhj8xnbJL18ufutuODwPvfML
         R43h9pspABsn5HwNGbQuMb33+PuBp9m1hPHS6IFiHJzvqyQdlh+Yg00CbMO7kSgVazLR
         xnCs1wY0swwiT03CUT6bLQUAruU9ZIbg+aNpyPf6xFea27K9Wh9c0IX2+K4QGy/nef/P
         14EO35+Ga/UEcvkOUKUd0kuMvLOOagFuAwDvelVK7zf+tUMlGQRh0hYKC67hCJUfV5uy
         xVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qnXfQkuQax+urG+3M24GD/QjcSdsFnSg39G2UiF/0Iw=;
        b=Bd7JuqFScT0ccmZeojt41cr+r5EesMMcv10SaQ5xY7GV8nsg686UvOf/8/YiB+IRgd
         EyBjUNNYHfpZiH5mW4KvkZapQX1QVGwrn6to1Rr+1cB1SLTgW6VVqRelPWM//SD6D3g2
         Fb0aJRVqiPNJca9vQEM7S3VNX8dDz2IiAq5O5ZJIwDkQ150v1JktqnyW/6AqXl3lFurz
         3FCuWTHSXt1YxDkMCI8doFmltN/eBvlU4BhWwsr9UmuWClq0xrkY00okxgnYDqzHojZt
         E+Rz+gK6iNzP3D4cnZyMELoNLKQ+DZa09rxz68n9QSRIhZ98wKRbawydHyI+It43Mz7l
         JYqA==
X-Gm-Message-State: AOAM531hjT1AOSGNrs0/Xsxop+6VVbx5oFvvKj9yd8L0x9L+rRJKcBUa
        NR1zIu65cdbwHvAhtVqk3cur0g/p8ilqOg==
X-Google-Smtp-Source: ABdhPJwNEArXT05JiL4dKs8DFP3DwkDBSF2YnQPt6cARclTw5JF8FpwhxIO2uIEd0OAloDpMVxKhjg==
X-Received: by 2002:a05:651c:38f:: with SMTP id e15mr13838299ljp.420.1613989836679;
        Mon, 22 Feb 2021 02:30:36 -0800 (PST)
Received: from magda-ThinkPad-L14.cc.local ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id g26sm870153lja.10.2021.02.22.02.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 02:30:36 -0800 (PST)
From:   Magdalena Kasenberg <magdalena.kasenberg@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Magdalena Kasenberg <magdalena.kasenberg@codecoup.pl>,
        Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] Bluetooth: Fix for L2CAP/LE/CFC/BV-15-C
Date:   Mon, 22 Feb 2021 11:30:21 +0100
Message-Id: <20210222103021.20923-1-magdalena.kasenberg@codecoup.pl>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This is required for the qualification test L2CAP/LE/CFC/BV-15-C

Implementation does not allow to set different key size for SMP and
L2CAP, which is needed for a current specification of the test. This fix
workarounds it with the debugfs variable le_l2cap_min_key_size.

Logs from the test when the IUT uses a min and max l2cap encryption key size 16.
$ echo 16 > /sys/kernel/debug/bluetooth/hci0/le_l2cap_min_key_size
The lower tester uses a key size 7.

> ACL Data RX: Handle 99 flags 0x02 dlen 11                #34 [hci0] 25.007392
      SMP: Pairing Request (0x01) len 6
        IO capability: DisplayYesNo (0x01)
        OOB data: Authentication data not present (0x00)
        Authentication requirement: Bonding, No MITM, SC, No Keypresses (0x09)
        Max encryption key size: 7
        Initiator key distribution: <none> (0x00)
        Responder key distribution: <none> (0x00)
< ACL Data TX: Handle 99 flags 0x00 dlen 11                #35 [hci0] 25.007591
      SMP: Pairing Response (0x02) len 6
        IO capability: KeyboardDisplay (0x04)
        OOB data: Authentication data not present (0x00)
        Authentication requirement: Bonding, No MITM, SC, No Keypresses (0x09)
        Max encryption key size: 16
        Initiator key distribution: <none> (0x00)
        Responder key distribution: <none> (0x00)
@ MGMT Event: New Long Term Key (0x000a) plen 37      {0x0001} [hci0] 28.788872
        Store hint: Yes (0x01)
        LE Address: C0:DE:C0:FF:FF:01 (OUI C0-DE-C0)
        Key type: Unauthenticated key from P-256 (0x02)
        Master: 0x00
        Encryption size: 7
        Diversifier: 0000
        Randomizer: 0000000000000000
        Key: 529e11e8c7b9f5000000000000000000

<snip>

After pairing with key size 7, L2CAP connection is requested which
requires key size 16.

> ACL Data RX: Handle 99 flags 0x02 dlen 18                #56 [hci0] 34.998084
      LE L2CAP: LE Connection Request (0x14) ident 3 len 10
        PSM: 244 (0x00f4)
        Source CID: 64
        MTU: 256
        MPS: 284
        Credits: 1
< ACL Data TX: Handle 99 flags 0x00 dlen 18                #57 [hci0] 34.998325
      LE L2CAP: LE Connection Response (0x15) ident 3 len 10
        Destination CID: 0
        MTU: 0
        MPS: 0
        Credits: 0
        Result: Connection refused - insufficient encryption key size (0x0007)

Signed-off-by: Magdalena Kasenberg <magdalena.kasenberg@codecoup.pl>
Reviewed-by: Szymon Janc <szymon.janc@codecoup.pl>
Cc: Szymon Janc <szymon.janc@codecoup.pl>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         |  1 +
 net/bluetooth/hci_debugfs.c      | 30 ++++++++++++++++++++++++++++++
 net/bluetooth/l2cap_core.c       | 25 +++++++++++++++++++++++++
 4 files changed, 57 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ebdd4afe30d2..0bf0543efec5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -379,6 +379,7 @@ struct hci_dev {
 	__u16		auth_payload_timeout;
 	__u8		min_enc_key_size;
 	__u8		max_enc_key_size;
+	__u8		le_l2cap_min_key_size;
 	__u8		pairing_opts;
 	__u8		ssp_debug_mode;
 	__u8		hw_error_code;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b0d9c36acc03..9ef4b39b380c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3788,6 +3788,7 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->conn_info_max_age = DEFAULT_CONN_INFO_MAX_AGE;
 	hdev->auth_payload_timeout = DEFAULT_AUTH_PAYLOAD_TIMEOUT;
 	hdev->min_enc_key_size = HCI_MIN_ENC_KEY_SIZE;
+	hdev->le_l2cap_min_key_size = HCI_MIN_ENC_KEY_SIZE;
 
 	/* default 1.28 sec page scan */
 	hdev->def_page_scan_type = PAGE_SCAN_TYPE_STANDARD;
diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 1a0ab58bfad0..dec8b96b8427 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -1096,6 +1096,34 @@ static int max_key_size_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(max_key_size_fops, max_key_size_get,
 			  max_key_size_set, "%llu\n");
 
+static int le_l2cap_min_key_size_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+
+	if (val > SMP_MAX_ENC_KEY_SIZE || val < SMP_MIN_ENC_KEY_SIZE)
+		return -EINVAL;
+
+	hci_dev_lock(hdev);
+	hdev->le_l2cap_min_key_size = val;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int le_l2cap_min_key_size_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->le_l2cap_min_key_size;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(le_l2cap_min_key_size_fops, le_l2cap_min_key_size_get,
+			 le_l2cap_min_key_size_set, "%llu\n");
+
 static int auth_payload_timeout_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
@@ -1226,6 +1254,8 @@ void hci_debugfs_create_le(struct hci_dev *hdev)
 			    &min_key_size_fops);
 	debugfs_create_file("max_key_size", 0644, hdev->debugfs, hdev,
 			    &max_key_size_fops);
+	debugfs_create_file("le_l2cap_min_key_size", 0644, hdev->debugfs, hdev,
+			    &le_l2cap_min_key_size_fops);
 	debugfs_create_file("auth_payload_timeout", 0644, hdev->debugfs, hdev,
 			    &auth_payload_timeout_fops);
 	debugfs_create_file("force_no_mitm", 0644, hdev->debugfs, hdev,
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 72c2f5226d67..d9a3a1c1f366 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5742,6 +5742,20 @@ static inline int l2cap_bredr_sig_cmd(struct l2cap_conn *conn,
 	return err;
 }
 
+static bool le_l2cap_key_size_sufficient(struct hci_conn *hcon, u8 sec_level)
+{
+	struct smp_ltk *ltk;
+
+	if (sec_level == BT_SECURITY_LOW)
+		return true;
+
+	ltk = hci_find_ltk(hcon->hdev, &hcon->dst, hcon->dst_type, hcon->role);
+	if (ltk && ltk->enc_size >= hcon->hdev->le_l2cap_min_key_size)
+		return true;
+
+	return false;
+}
+
 static int l2cap_le_connect_req(struct l2cap_conn *conn,
 				struct l2cap_cmd_hdr *cmd, u16 cmd_len,
 				u8 *data)
@@ -5788,6 +5802,12 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 		goto response_unlock;
 	}
 
+	if (!le_l2cap_key_size_sufficient(conn->hcon, pchan->sec_level)) {
+		result = L2CAP_CR_LE_BAD_KEY_SIZE;
+		chan = NULL;
+		goto response_unlock;
+	}
+
 	/* Check for valid dynamic CID range */
 	if (scid < L2CAP_CID_DYN_START || scid > L2CAP_CID_LE_DYN_END) {
 		result = L2CAP_CR_LE_INVALID_SCID;
@@ -5969,6 +5989,11 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 		goto unlock;
 	}
 
+	if (!le_l2cap_key_size_sufficient(conn->hcon, pchan->sec_level)) {
+		result = L2CAP_CR_LE_BAD_KEY_SIZE;
+		goto unlock;
+	}
+
 	result = L2CAP_CR_LE_SUCCESS;
 	cmd_len -= sizeof(*req);
 	num_scid = cmd_len / sizeof(u16);
-- 
2.25.1

