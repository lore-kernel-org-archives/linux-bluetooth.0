Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D12512DDBB
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Feb 2024 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708984836; cv=none; b=mxPPsIP9zcTIbSkDM+LAMiXFgxfdL64Secx6ztjIwAbe1dtgiTVx0nt8ByDNWAC5JW/4yzwyw4/UI0K1PTTaL4A4umOJ1fBNmTMpCpfaZ1dGtbhj7exHtexWyt6UeMIpuseDxkjlp5x9rVIOSB6PQ+bnrcHUIAR3tlPCByGLWQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708984836; c=relaxed/simple;
	bh=yAwVjnii4gOdKjVBPRKqszUhbHC1xKlL80xFSv2WaF0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=N/Z7kHKGIthAbqe0O2qGLcN2ki+uwatPnRQKBd/0nqsVndUHVWZOk6H3zPSzQrJbtgaLmXtkvjUS9AVUkf/KF1V2lIcmFIGy9V17Jv/OGRlhLjgDEVY0LUs8+0BFbAz7GA+Kc2fQm2VVA9hGaSuyF9wOyoScaYA8w9YSGnhCGTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gy9zCMtf; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gy9zCMtf"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4d158faf527so457296e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Feb 2024 14:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708984833; x=1709589633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ef5cxWS/DHX003FFu3ZV3XHChZLsTqEMaAm7lSIlAsk=;
        b=gy9zCMtfTvoKzYbW8aTTJYMFVR8zK477zWdopfnRCH/o7VsSNcuveA8lHMnvFmPn26
         JT16CzH/eovc3f0XEIwUuFMfQt3P+DTs6LpP3+2uy9oUWEHxZ31VpD8HFxz2OskQlraT
         IhR9eFTpXjd6sKxT+MAMpJJ5lbn7v5axI8Rjw+W62KSNPrnxedcTvnP1+Nq8mqmBgS2g
         4aXkvRRp4U8WJDr8oyTSsRYxLH8sRkmT0XbmlyVWJWBW61FqtCNSIhtgIAhPwrQtcR6C
         qJK8pyTLDHyy4fK6+A0Y6T5dCT8dW1ZC1BATqYtH5y984Q8ANScric10Z07GXN0uAzsM
         fOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708984833; x=1709589633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ef5cxWS/DHX003FFu3ZV3XHChZLsTqEMaAm7lSIlAsk=;
        b=DXLzawVQyPQTYG/zw8LTVVJAqG5SE0jVeqlmUwMw/rqIIkZhfenUR/66tBwBrkUbg+
         a5NwlLq8o2Wvqx0h4vsQc0lAz3K4J34TjEGsHX9XdTmAlyCFu684TRJ+mSJekMp/xSPu
         312A/C5Lr/Arq/9dcAbJuAzC82hIJoPsMwaUmNuVOHoN404XcjMj87XtCxAylsjQ/S9i
         l5pK05suR3uCp+uj+FoFn9xLCUWTwzlh6C3P56Y+ePymABl0pW7BvG92LaB7NOsy78z6
         Z/eAjg1mJfwrsv8rDZWf4+/+OR7lRPanOWG02lZHni3USINVcV92N4kzeKBccpK9e6Pk
         IL4A==
X-Gm-Message-State: AOJu0YzqrIXevJPh/DVZH0+mSukDn45zFhIVEMBj1wp03vN+WG8IVJy5
	gkJQ21i/pGNPQ8D2y/a8bKmvfQ3Rtg4/ailvHUYR0G9DFD/9HIGhLxA11ax+
X-Google-Smtp-Source: AGHT+IEQHh1jDmfdo6K/I+v5UyRos86Z+LjZU28SoRfLYGj9l2uFDFZY/sj909Ib22yBrkFgzYdQPQ==
X-Received: by 2002:a1f:c4c2:0:b0:4ca:b623:7786 with SMTP id u185-20020a1fc4c2000000b004cab6237786mr4721051vkf.2.1708984833415;
        Mon, 26 Feb 2024 14:00:33 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id n15-20020a1f720f000000b004c04a84d80csm815764vkc.56.2024.02.26.14.00.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 14:00:32 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 1/2] Bluetooth: hci_sync: Use address filtering when HCI_PA_SYNC is set
Date: Mon, 26 Feb 2024 17:00:30 -0500
Message-ID: <20240226220031.1686256-1-luiz.dentz@gmail.com>
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

