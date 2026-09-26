Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E324A374E5A
	for <linux-bluetooth@vger.kernel.org>; Sat, 26 Sep 2026 17:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790443719; cv=none; b=OeOZpkovVDLVVmAMmB7hPum6d2aHS2VH9xAAhP0EifdzA9q7oqMxadQoY/4eJdawFqlChuvfuTuclHtSnlEOkgI6NmPpnWnmzVu9lavcHT4qY7XwFI8XL0IjnAl6+YiF4nwq/4hV9cT+nmQzjm+uQq2LfJrCLkWDvix9YUyUpho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790443719; c=relaxed/simple;
	bh=+HgRyJZqhYbFivkio75Od5NgednHCZsaD6zIdhfYl3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P67LZwkSenHZ/VzUDlqfG8gFLOCB0Nh0+zcs5tXqHE5gZ+j8ip8nv3a6dQQKpY3ch9moue7aEmeVvgYZxNzopAtrRe3RNzvlGVNnvJfAj9JybxWTcQgwA+aXOztmjkuyN1Oh0GMfTeU8iLnn+2cTgxBufE01Kvb1Rp/6O6qF2iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RR9Q61rH; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RR9Q61rH"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e4e75342aso141054eec.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Sep 2026 10:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790443717; x=1791048517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tkhLBNre7EA3iLFHkofLObtqttiY9XfSZc+5/v8P8mQ=;
        b=RR9Q61rHwUsGR8HRz9Lypfp3uEWu5x4pJI6aElo00I1TR9BnFU7+SPZZ5rQRiVnrVG
         BQ9AeRhkQy6HZ7tKJOts1R1AoYcPSU1Ds1SMstuilw3g67mb57R1WnG1BV1L0Y/mBlPd
         WkTusgvU5rA5Yi7qzU640BToxB/THBu7Epey/hHCpzUcPFiOunIcTuwrvc5zrzBTwMnt
         FQdvRZBfCbL8Vf8GBuKH3/FpH+sU8zuxmxjtTD85nkfEytvnrKsJKkszNnbAeLmX7u8H
         DpAE50C/2Lw9F+ceqB+yton9wbRedbUpLY/KXArkkWo1tRneZrHK0C5gTV8gNkXBbzOb
         EdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790443717; x=1791048517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tkhLBNre7EA3iLFHkofLObtqttiY9XfSZc+5/v8P8mQ=;
        b=gZX9OlxtuY4/9XOidNCTro++ZUlSdMzVhSyMvPJeCBuqvscuOb+qQXMUI983GDpRpY
         CANp0D5S0IxFNxP9nXk3f1/kYU7rhkBj4f4m0T1Uin0GT1k6AjR+hGvXlgL8yo7e9XVa
         6/3Rv8HaOtD/cG0XicZSI79psLJ9aaCA8ph6HcKGioBlJG9iQQ/rPu94ckpMYQnYtUWF
         NCzK90IWrUsg1YopZM4+iLSHDRd1rTg3Wt2pHDh3h15WGuo/SavwtdLMJ8xlJQDVbkDm
         +y/UrGkVkVa4jDKESDxZpNEqMPO+9Uj5oq3kb6aulobHjrrQoxlutepQVDEIDCHALIXR
         KnqA==
X-Gm-Message-State: AFuF++mKp2nDYatZMmLqOBeBFOV4YRFsvRE/FfpKIN27lI2VsOb7NAX3
	Hfl3qqYvWvBEHs26UNqOkRU/qPi3fS6y0LwPN0JEveATmbwaznXXr2/6
X-Gm-Gg: AYBFou1jFMkKUcoI+3KT4QJkV+t/Cy5qBk5a2H67KlPfKylgVUb8XyYM3kaZ60A1C5J
	c+8Ka/OQQ7o7DnOpmjdvZo8NXZ/Z6Bphp9kqEfGbWTU/iJISY+mq+kSnDVzvL1LFpTE44nqFWAP
	WbP08f4mgF5zayHFoglY+OA1cIG/wKKYGPIYH2lXvpkPmtArzRmlneGVEVQ9GEh64yQrF+olFp9
	WmMTMs+voaQ58MjiRrOlFsQ/Hz0C/DON2zFwH5+KXa9OBXSF7MjRU/jYmNzZ30DHzwfhS6MVDTY
	onoBvxsjKckif8kjQbqOZfWmQSOaxQiOoufOBSQaw8hWBWess8r5XH6vJ3LKZulSpS3zAZwaA+O
	PGoBiEsCeRQMBLe0aQq2GBRIUzHWZl+M/rQuCQBz+M6ZtVNZCT531ORGdyY69+SFng4BQI2Mgx1
	ruKbLJU7XUiLZs1aAddvOFsUJADd7lqAQUlkdSu2R0Kmy8B5kaVlxhcFeY7VEw/Kfhqq5e2JGGn
	KMHVZq+nRD7RCt8gpU/niOyWnLJOz5aBDedyjikq/S0gj+c4YXAPAjNXXIfU//G0fvqK03Rj85D
	XADC
X-Received: by 2002:a05:7022:1504:b0:143:858d:fb0e with SMTP id a92af1059eb24-146caf2aafcmr6359262c88.0.1790443716967;
        Sat, 26 Sep 2026 10:28:36 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145aa0cb7bcsm12652549c88.2.2026.09.26.10.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 10:28:36 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	=?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: Fix inquiry cache use-after-free
Date: Sun, 27 Sep 2026 01:28:31 +0800
Message-ID: <20260926172831.2415074-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sync command worker holds hdev->req_lock, but inquiry-cache updates
and flushes use hdev->lock. Both hci_acl_create_conn_sync() and
hci_stop_discovery_sync() look up entries and read their fields without
taking hdev->lock.

After either lookup returns, a concurrent HCIINQUIRY ioctl can acquire
hdev->lock and flush the cache, freeing the entry. The worker then reads
the freed entry while preparing a create-connection or remote-name-cancel
command. The list traversal also races with cache updates and removal.

KASAN reported these accesses:

  BUG: KASAN: slab-use-after-free in hci_acl_create_conn_sync+0x5f1/0x650
  Workqueue: hci0 hci_cmd_sync_work
  Call Trace:
   hci_acl_create_conn_sync+0x5f1/0x650
   hci_cmd_sync_work+0x13c/0x290

  Allocated by task 90:
   hci_inquiry_cache_update+0x3e6/0x7d0
   hci_inquiry_result_evt+0x3cb/0x560

  Freed by task 93:
   hci_inquiry_cache_flush+0x111/0x2b0
   hci_inquiry+0x2f2/0x780
   hci_sock_ioctl+0x269/0x5f0

  BUG: KASAN: slab-use-after-free in hci_stop_discovery_sync+0x3b1/0x3c0
  Workqueue: hci0 hci_cmd_sync_work
  Call Trace:
   hci_stop_discovery_sync+0x3b1/0x3c0
   hci_cmd_sync_work+0x173/0x300

  Allocated by task 86:
   hci_inquiry_cache_update+0x483/0x940
   hci_inquiry_result_evt+0x3cb/0x560

  Freed by task 91:
   hci_inquiry_cache_flush+0x13e/0x2f0
   hci_inquiry+0x2f2/0x780
   hci_sock_ioctl+0x269/0x5f0

Hold hdev->lock across each lookup and all reads from its result. Copy the
remote address before unlocking so discovery cancellation does not retain
a cache entry pointer. Release the lock before sending synchronous HCI
commands, since their completion handlers may need the same lock.

Fixes: cf75ad8b41d2 ("Bluetooth: hci_sync: Convert MGMT_SET_POWERED")
Fixes: 45340097ce6e ("Bluetooth: hci_conn: Only do ACL connections sequentially")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/bluetooth/hci_sync.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 74e2b04c84b2..0712ed09edd5 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5764,6 +5764,7 @@ int hci_stop_discovery_sync(struct hci_dev *hdev)
 {
 	struct discovery_state *d = &hdev->discovery;
 	struct inquiry_entry *e;
+	bdaddr_t addr;
 	int err;
 
 	bt_dev_dbg(hdev, "state %u", hdev->discovery.state);
@@ -5799,15 +5800,21 @@ int hci_stop_discovery_sync(struct hci_dev *hdev)
 		return 0;
 
 	if (d->state == DISCOVERY_RESOLVING || d->state == DISCOVERY_STOPPING) {
+		hci_dev_lock(hdev);
 		e = hci_inquiry_cache_lookup_resolve(hdev, BDADDR_ANY,
 						     NAME_PENDING);
-		if (!e)
+		if (!e) {
+			hci_dev_unlock(hdev);
 			return 0;
+		}
+
+		bacpy(&addr, &e->data.bdaddr);
+		hci_dev_unlock(hdev);
 
 		/* Ignore cancel errors since it should interfere with stopping
 		 * of the discovery.
 		 */
-		hci_remote_name_cancel_sync(hdev, &e->data.bdaddr);
+		hci_remote_name_cancel_sync(hdev, &addr);
 	}
 
 	return 0;
@@ -7236,6 +7243,7 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 	bacpy(&cp.bdaddr, &conn->dst);
 	cp.pscan_rep_mode = 0x02;
 
+	hci_dev_lock(hdev);
 	ie = hci_inquiry_cache_lookup(hdev, &conn->dst);
 	if (ie) {
 		if (inquiry_entry_age(ie) <= INQUIRY_ENTRY_AGE_MAX) {
@@ -7247,6 +7255,7 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 
 		memcpy(conn->dev_class, ie->data.dev_class, 3);
 	}
+	hci_dev_unlock(hdev);
 
 	cp.pkt_type = cpu_to_le16(conn->pkt_type);
 	if (lmp_rswitch_capable(hdev) && !(hdev->link_mode & HCI_LM_MASTER))
-- 
2.43.0

