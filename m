Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED97231AA8F
	for <linux-bluetooth@vger.kernel.org>; Sun, 19 Apr 2026 07:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776583491; cv=none; b=gUe8aDVfVaJolloqR5GLw40gf9ppheSe+prcwd1Btmk26IgBHaXgjeTC8FIv12u94LurUj/etFWt/7hIbibgKRnHk1or6+d74BQ0tWScNZwNHc90js9w5rubtuOVtUlZ2r875E9WUQ1OxI3KFbSQv9M1s88UhHFV9LxyjIKMAeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776583491; c=relaxed/simple;
	bh=J14UXlGIcYcigiWAwLCstC3TmsB/OQZiIyPKbeH99yI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=idIvvTWNieXg1cjCu6OF4Bu0pp5KuAyq5DAhvFWK695pWNTHYAvL3cEJNs1QeLrHXRS9KkGrqz44VbbFIEmRXs/9sAxTN82cA0EYx4cauK9cBrCNIdaNwZdLtWdB56PRnLtX49ZTm9gDTxAd8XLiQ5E+Be9j7WIOCshP5ikowi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qmdva0p7; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qmdva0p7"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488d2079582so22729625e9.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Apr 2026 00:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776583488; x=1777188288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UqTpJplCXuGTQVzh35cdkgwJEWQnN+JdRURPZVphV0U=;
        b=qmdva0p7rsZqmmrDslSOt9wAPp1E/JJJK9MvDFMxtsbeCZpwAhNd316jw1iFF+Ozkk
         iJnsbpvvmQ/iV0b74EH4kAGFPfwaYbR4AHLnU306DLiHVX1m67XpwdAfYf5GOu6D+xiV
         wrN7xzctaA0x0cTspDRgBLWzuUkyK5JfqI4ks/xIHkYNNl7G8U3X1h5dsf59fVJuxgDp
         T5VEWZvrVoDl3R8fYm1Mz1NEcN7pryK/gDCbLfM5upvjOhDgslJRBySJ+7oZW/Xl01HC
         1zq1Wgbbk20Fj1HExwwbdvzNbQUISm+Glua2VxmPt1RhlITqB6iZZIKn975HfNUa4I5j
         qEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776583488; x=1777188288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqTpJplCXuGTQVzh35cdkgwJEWQnN+JdRURPZVphV0U=;
        b=kBgRD+tn82SZ2vsZ8ZTzLs8f6VvgVmwemYzKbD2JwChAxPS27zY8jMaYHpfc8DlJ4+
         lgteMgPauoRkX4DWj8+3Mymk2FcomTXtN/80y0CTdHvoZMNVaao9guNFAViph5+wmycA
         fqV0sBG8IEdgK5ux0/FAIYxZv21pvBFEgaBMXxAUIKL7N0WqNX9jAV7ulPDNmkrMevWt
         AMG4bPFoMKo1p9Offrzp0+TLsJCcYh8LHnUfcZMH1Ajp40Eg2FwGyKSX3wsfLYVvJtlX
         h6l0ZPDAwKAdvpwfEZ98Yz1iYb7o0e0FoZ5SryeLlyNisJcPXl2CvIzWZDmJ4GxrRxx3
         02TA==
X-Gm-Message-State: AOJu0YwPIEtin1J6xNGakWUAg6eKqELeIR5eG1F0J4Yd9WK34pfaYyWZ
	J4jnG9nX56K+nOkdEUQCIUkb6TMJrfv+XQV/lNTS/PzpWP/Yh4/O5QyGF720hKvd
X-Gm-Gg: AeBDiet6Izrfxb2o0GVRo2f7ab6YDJewm9utcSQ/0uZ7576+fIIvMeYaRyVzceoCNJi
	dSa8yqptLuYiZ9BvkhvsveAw5BwqHStSFY86s7rknZ6vAYbIZCX8aAfnRV9b+/wfbsm/XFz3C8n
	LcxWTjhxMcFJk3kM/i39VMtTNPQ+ttmLHDFsna26GsYp4mMgdKdycrKZhZ9zlw4B1EQWR8DeWYp
	DLvIEbsOntPrTxVvMjBXb+W0Hjt/lhXqQahSt58haXIjHfnfRTtroBeNzWF7xBIC+BuUQz2Zr/e
	6Ie7lweZ7bHAlZDADyUdjcbswYNFAw5LlmQR7e5cMmDlQV6+UGzWG6EwEjh4WSADnd1BXd8T0P2
	il7SgcvrceChvTB7Amq+Ih0gmFqlqkN48K8V2TBuqdi3KD5kCR+y8Dg1uSS+o4iLuthLcB/3rdE
	fCJn9mVoINnVi0/23Cl1aXshhcchwfrgdgpeHZas7KYnnw/YcLLfBo0QKdaCnbmjyUiICNS/BB0
	3bLiJBsS+geSO27jBsiUlMjzYVphrWAUQEutoTLhFd/SXEq
X-Received: by 2002:a05:600c:3515:b0:488:8b99:54a1 with SMTP id 5b1f17b1804b1-488fb78e7c5mr119713815e9.28.1776583487791;
        Sun, 19 Apr 2026 00:24:47 -0700 (PDT)
Received: from server ([5.14.142.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc16f8c3sm169076205e9.2.2026.04.19.00.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 00:24:46 -0700 (PDT)
From: StefanCondorache <condorachest@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	StefanCondorache <condorachest@gmail.com>
Subject: [PATCH] Bluetooth: Add HCI_QUIRK_NO_SCAN_WHILE_CONNECTED for combo chips
Date: Sun, 19 Apr 2026 10:24:33 +0300
Message-ID: <20260419072433.55976-1-condorachest@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Realtek combo chips share a single antenna between Wi-Fi and Bluetooth.
Background LE passive scanning while an active connection exists causes
antenna multiplexing conflicts via Packet Traffic Arbitration (PTA),
resulting in audio stuttering and Wi-Fi packet loss.

Add HCI_QUIRK_NO_SCAN_WHILE_CONNECTED to suppress passive scanning in
hci_update_passive_scan_sync() when active connections are present.
Set this quirk for all Realtek devices in btrtl_set_quirks().

Also add device ID 0x0bda:0xc829 to the btusb Realtek device table.

Signed-off-by: StefanCondorache <condorachest@gmail.com>
---
 drivers/bluetooth/btrtl.c   |  6 ++++++
 drivers/bluetooth/btusb.c   |  2 ++
 include/net/bluetooth/hci.h | 11 +++++++++++
 net/bluetooth/hci_sync.c    |  7 +++++++
 4 files changed, 26 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 62f9d4df3a4f..00dfba656970 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -1299,6 +1299,12 @@ EXPORT_SYMBOL_GPL(btrtl_download_firmware);
 
 void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 {
+	/* Realtek combo chips share the antenna between Wi-Fi and
+	 * Bluetooth. Suppress passive scanning while connected to
+	 * prevent coexistence issues.
+	 */
+	hci_set_quirk(hdev, HCI_QUIRK_NO_SCAN_WHILE_CONNECTED);
+
 	/* Enable controller to do both LE scan and BR/EDR inquiry
 	 * simultaneously.
 	 */
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5f57953393be..87972f5fc567 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -516,6 +516,8 @@ static const struct usb_device_id quirks_table[] = {
 	/* Realtek 8822CU Bluetooth devices */
 	{ USB_DEVICE(0x13d3, 0x3549), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0bda, 0xc829), .driver_info = BTUSB_REALTEK |
+							 BTUSB_WIDEBAND_SPEECH },
 
 	/* Realtek 8851BE Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0xb850), .driver_info = BTUSB_REALTEK },
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 572b1c620c5d..8466dc52aeca 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -378,6 +378,17 @@ enum {
 	 */
 	HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE,
 
+	/* When this quirk is set, the controller suppresses passive LE
+	 * background scanning while an active connection exists.
+	 * This is required for combo chips with shared Wi-Fi/Bluetooth
+	 * antennas to prevent coexistence issues causing audio drops
+	 * and Wi-Fi packet loss.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_NO_SCAN_WHILE_CONNECTED,
+
 	__HCI_NUM_QUIRKS,
 };
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index fd3aacdea512..5e30e725efa2 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3194,6 +3194,13 @@ int hci_update_passive_scan_sync(struct hci_dev *hdev)
 	if (hdev->discovery.state != DISCOVERY_STOPPED)
 		return 0;
 
+	/* If the controller requires no scanning while connected,
+	 * suppress passive scanning when an active connection exists.
+	 */
+	if (hci_test_quirk(hdev, HCI_QUIRK_NO_SCAN_WHILE_CONNECTED) &&
+	    !list_empty(&hdev->conn_hash.list))
+		return 0;
+
 	/* Reset RSSI and UUID filters when starting background scanning
 	 * since these filters are meant for service discovery only.
 	 *
-- 
2.53.0

