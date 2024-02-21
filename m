Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915C17C0B8
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Feb 2024 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526296; cv=none; b=diTrH0XpKQBqPib82UrxfxyB0oNQH0q/SjjXzRHS7C6mc5X94XFRD/0TCu5KzEeNQIwSIyxKy24LE5VMyH9ezCIKBKoPx6UH2oVx6gfvNm7Z1UUIZ0EraiAPPkmNnettT36Qi2PWqpAanP4tfA4i2XTCOGwJSILmX9GgTa7GCg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526296; c=relaxed/simple;
	bh=yAwVjnii4gOdKjVBPRKqszUhbHC1xKlL80xFSv2WaF0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QbFLfWeFmmvTBzv1B1QPrUt8aOJOm1S0mGpgITZ7qio2sNBmawo7x4oeBhgUEw7C3w+2Sd7ajr7XgW0YNkgrbY1dnAgjDXB4GnLKt+Co99d2qmOZAuKfYciicVqBTROWEKMY0e8kjdc6IS1TRBH6orLlf810Nr9Ae18Ie9YDo0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMAkORW3; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMAkORW3"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-21f0c82e97fso434690fac.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Feb 2024 06:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708526292; x=1709131092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ef5cxWS/DHX003FFu3ZV3XHChZLsTqEMaAm7lSIlAsk=;
        b=DMAkORW3Et+oHOnfIRa+XoeA0exEV4HevgJOopnQOYmA4mUdFTHPPO3/nKuJpsOkNR
         13xluK/yYwesWXiIYhsGZBD+euDpNokFvj5N7nIOTz4KK+H07/mFw4HIropjk7Xf2UNQ
         ABKTWww5KWdMe1r5GvdVYtGVi2qpNo4wc4YJFslDa3ku3iLhYOuYBS5oew07CxrG8Ol4
         hlk4Fi2tzDwp0UCY3vRbVZfqbuk/hUplIV6RVa5sPRWcXPxZ6V39y49Ocb0E0Jt3J7jY
         3Onc3LPAA1slERzfgFzPkOaszM4hkiBsvTEHfuVG6jFSAmutKC6SwJzqObsNKjyHsm+x
         32Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708526292; x=1709131092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ef5cxWS/DHX003FFu3ZV3XHChZLsTqEMaAm7lSIlAsk=;
        b=LkkO9wXaOwM351QZhDAFxjRd8v3mKD+dM+I6/vhYfdlGvOCjvT1kYHxAJDHkEVevbo
         60TI66BTi3gkIiLJmFlVcS7J9J3Sng7bcn8XD/tWatW3jHYyoxtJVenTdqOSt43fEkCj
         rDuTMVl1t071pPFiemUk6/9z7WRJYnKsoLIFsihL+n/uJlX1Nuhu78sNYObdVTeyyxQY
         +ZeEZSmJbTuqKY658Ko8TV9arPpXCAyvhYHd1PDKAHjfdDZJ4Y2q1de5WPCg1fB6wz1q
         pck5wHoO6HySXnP+06J2jTpOfTcwMYzrvlOSnBIPLeRWorR7oXanItUP4vUvviz2XZVj
         7RGw==
X-Gm-Message-State: AOJu0YxG1C6P1EB9Nor8lfqgPH5WVEoHYfZFm1lxKBjXnw8wAnNZMvU2
	d34B16JU7Gor171HSfu6aSRBMkKpbUX6WhglxKdm+8gijqsgQIknKHMwsyAr
X-Google-Smtp-Source: AGHT+IFnY7mLEqneOqeh15kRWAJjDIitE8DI0WHpcjOL4tqZjJe9gCmR5HzcgNR9uiQnK4E30/jHng==
X-Received: by 2002:a05:6870:8a0d:b0:21e:8cd7:50de with SMTP id p13-20020a0568708a0d00b0021e8cd750demr14672194oaq.28.1708526292389;
        Wed, 21 Feb 2024 06:38:12 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id db22-20020a056130239600b007d9150e1596sm1807716uab.33.2024.02.21.06.38.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 06:38:11 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 1/2] Bluetooth: hci_sync: Use address filtering when HCI_PA_SYNC is set
Date: Wed, 21 Feb 2024 09:38:09 -0500
Message-ID: <20240221143810.531710-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If HCI_PA_SYNC flag is set it means there is a Periodic Advertising
Synchronization pending, so this attempts to locate the address passed
to HCI_OP_LE_PA_CREATE_SYNC and program it in the accept list so only
reports with that address are processed.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 45 +++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 669099cf9b1a..ab609089ac4c 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2566,6 +2566,16 @@ static struct conn_params *conn_params_copy(struct list_head *list, size_t *n)
 	return p;
 }
 
+/* Clear LE Accept List */
+static int hci_le_clear_accept_list_sync(struct hci_dev *hdev)
+{
+	if (!(hdev->commands[26] & 0x80))
+		return 0;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_CLEAR_ACCEPT_LIST, 0, NULL,
+				     HCI_CMD_TIMEOUT);
+}
+
 /* Device must not be scanning when updating the accept list.
  *
  * Update is done using the following sequence:
@@ -2614,6 +2624,31 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 		goto done;
 	}
 
+	/* Force address filtering if PA Sync is in progress */
+	if (hci_dev_test_flag(hdev, HCI_PA_SYNC)) {
+		struct hci_cp_le_pa_create_sync *sent;
+
+		sent = hci_sent_cmd_data(hdev, HCI_OP_LE_PA_CREATE_SYNC);
+		if (sent) {
+			struct conn_params pa;
+
+			memset(&pa, 0, sizeof(pa));
+
+			bacpy(&pa.addr, &sent->addr);
+			pa.addr_type = sent->addr_type;
+
+			/* Clear first since there could be addresses left
+			 * behind.
+			 */
+			hci_le_clear_accept_list_sync(hdev);
+
+			num_entries = 1;
+			err = hci_le_add_accept_list_sync(hdev, &pa,
+							  &num_entries);
+			goto done;
+		}
+	}
+
 	/* Go through the current accept list programmed into the
 	 * controller one by one and check if that address is connected or is
 	 * still in the list of pending connections or list of devices to
@@ -4220,16 +4255,6 @@ static int hci_le_read_accept_list_size_sync(struct hci_dev *hdev)
 				     0, NULL, HCI_CMD_TIMEOUT);
 }
 
-/* Clear LE Accept List */
-static int hci_le_clear_accept_list_sync(struct hci_dev *hdev)
-{
-	if (!(hdev->commands[26] & 0x80))
-		return 0;
-
-	return __hci_cmd_sync_status(hdev, HCI_OP_LE_CLEAR_ACCEPT_LIST, 0, NULL,
-				     HCI_CMD_TIMEOUT);
-}
-
 /* Read LE Resolving List Size */
 static int hci_le_read_resolv_list_size_sync(struct hci_dev *hdev)
 {
-- 
2.43.0

