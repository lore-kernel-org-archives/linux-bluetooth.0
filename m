Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B83A1DC185
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Mar 2025 15:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742484861; cv=none; b=kXxYxjyCYpT7WHXtv2Ds5Gjz9EFOL1MfRhpqWHtgeaW1XLioVTsf3eDgPyctI2ALsXzE6iOa5Mypjs3OLuc8zqX9vZENSIwKMOdL+axO+thxO9pROkdnixOXtZb9pr8yIXu4XblK1vNp6CYn76clDXII4Mle4lirkU1uc9nvo7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742484861; c=relaxed/simple;
	bh=A74eMZJRJ6gERM/X4hoPCchXy0M0NEMYK8/YzuRCSWY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gL++coJNpk4bj07+hrDjXnuNQXxYD4gZF16YpxLrMEz8O0hzRjNXzVHt8Yc0YOyuVHjU4ik/dtuWwKlBl+y1U+8vqUltIqq/AkeH5mfoa1M9uMfDf0UxW5wXnZyROW0IZiKxivE8UeqVrFFLZNuGoWcI85H0vqsNsuWW2saejiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lt4tyD0K; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lt4tyD0K"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-523edc385caso386289e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Mar 2025 08:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742484858; x=1743089658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6FdTCwqMzkmFdWitB2V5bgPRQJHyyKDjK4an6/4ZyU=;
        b=Lt4tyD0K7BRR4gXVOFzovmJ4FWhWUn3UatPrH5NB6VYSz9pJTAvh06P/cSgwt31H8k
         NZEd/7OMdlVwQJQd0TXkHXqXJFbODDlZPDn/6ufmdMRfjSYV9t7vaXqRjfRa9cyEzKza
         N6qntCrRyePxcidR6xx3f/u90yRSdU5rsSe+Cv7QYUS6wPGJOHANddiaW0QOSJmYywyq
         gc9ToXAeD8FGqXbtiScXTpgNx44U6ncetAVxHCyjmI26MOvZl25o42YUNgkfoQpgb4Rs
         gJeI3phjZZvYz5GLoL0gIyoTmNEtvELJUgr6t/8PnmCLLKC7Yb3hdNGOKloKlEGIQ0ow
         19LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742484858; x=1743089658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6FdTCwqMzkmFdWitB2V5bgPRQJHyyKDjK4an6/4ZyU=;
        b=ub3ysXLenpzXyFayNTrRnIyf06+bJA6CfJ5imi4wiPKW/9XF9kTz7VXTGCleQgGX2w
         2vznFsHLrWPBXc2MitwMX6sKiM7eQej1H8xNpoOLwF2rqSPaycWtl9wJ1ld+7T50JEMm
         +KLwE4DfT0Np9ylpDmJQQwD8j7rzlP0myn71ugKrCy2wXTyvVDzL1GSSxR093oCmMz9z
         Wn2wg7ixJTUeK/GgPv2H+IBwr0UE5fLeNfGdrEwJTriem7b3ghwlQddTXYy7x4h2cs+x
         YRomcqkC5omnEikDT8De1u29+KupY3klIjBev1BcNGCKqV9uuMfVFLpP5LOmbrb2DofN
         1KjQ==
X-Gm-Message-State: AOJu0Yw1ow7UchxQrAaVUxECoYaY+uumqs2oOVSZUOU3CLJSsWCn6NPf
	nMeHC1uoD3L4di/3UDnSS/37LkKtjUfKnrLNfGqgtgXMqW+xJUfAijc5eohN+W0=
X-Gm-Gg: ASbGncuYKqNkWqq6Q+9vK3Wa8mTTkTLISPMw55Pfs9joRxw/lA/zeZqu+1GnSU/5iV1
	JCkYuQgjBVdsJdrfP5HDz6HG18LyvaQJdXh6C16sfOU67TTeaI7zFcSE3VRP+6S5YePZ90i9XZ2
	4KaKdihWmC/+cwx4I9J8WvvtLC5dMOK248AhFTHcBwm8Bz4u4k5vK9DBG1Ere0jHRALlXFXw6Nk
	tSW4jAIYdEV53UgRKqcXGqgCKvCEL0S2vM0/zddluAidVoFU+2lhYV7UCUg95K1kCu7o4sURC/x
	oISSvvm/+9m59L2GSZYTn3PLPU+K66rqOLSP0NK75w4Xoi8lf078qzY+1B8cqFk1RlvCv556VxK
	ihALkfoAs9I7KPA==
X-Google-Smtp-Source: AGHT+IE4WJ4Eak03dhOwufAfE2KQ3wgLoZ7KOVn1+KFJ2QqRMdeikJXpKidnGHdeGi0jPTGk5dkEbA==
X-Received: by 2002:a05:6122:4312:b0:520:6773:e5c5 with SMTP id 71dfb90a1353d-5258926463bmr6576743e0c.7.1742484858169;
        Thu, 20 Mar 2025 08:34:18 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-525a7359ccdsm20198e0c.4.2025.03.20.08.34.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 08:34:16 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_event: Fix handling of HCI_EV_LE_DIRECT_ADV_REPORT
Date: Thu, 20 Mar 2025 11:34:14 -0400
Message-ID: <20250320153415.1391223-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Some controllers seems to generate HCI_EV_LE_DIRECT_ADV_REPORT even when
scan_filter is not set to 0x02 or 0x03, which indicates that local
privacy is enabled, causing them to be ignored thus breaking
auto-connect logic:

< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
        Type: Passive (0x00)
        Interval: 60.000 msec (0x0060)
        Window: 30.000 msec (0x0030)
        Own address type: Public (0x00)
        Filter policy: Ignore not in accept list (0x01)
...
> HCI Event: LE Meta Event (0x3e) plen 18
      LE Direct Advertising Report (0x0b)
        Num reports: 1
        Event type: Connectable directed - ADV_DIRECT_IND (0x01)
        Address type: Random (0x01)
        Address: XX:XX:XX:XX:XX:XX (Static)
        Direct address type: Random (0x01)
        Direct address: XX:XX:XX:XX:XX:XX (Non-Resolvable)
        RSSI: -54 dBm (0xca)

So this attempts to mitigate the above problem by skipping checking of
direct_addr if local privacy is not enabled.

Link: https://github.com/bluez/bluez/issues/1138
Fixes: e209e5ccc5ac ("Bluetooth: MGMT: Mark LL Privacy as stable")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0df4a0e082c8..01d8c11c2c7e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6056,8 +6056,17 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	 * a LE Direct Advertising Report event. In that case it is
 	 * important to see if the address is matching the local
 	 * controller address.
+	 *
+	 * If local privacy is not enable the controller shall not be
+	 * generating such event since according to its documentation it is only
+	 * valid for filter_policy 0x02 and 0x03, but the fact that it did
+	 * generate LE Direct Advertising Report means it is probably broken and
+	 * won't generate any other event which can potentially break
+	 * auto-connect logic so in case local privacy is not enable this
+	 * ignores the direct_addr so it works as a regular report.
 	 */
-	if (!hci_dev_test_flag(hdev, HCI_MESH) && direct_addr) {
+	if (!hci_dev_test_flag(hdev, HCI_MESH) && direct_addr &&
+	    hci_dev_test_flag(hdev, HCI_PRIVACY)) {
 		direct_addr_type = ev_bdaddr_type(hdev, direct_addr_type,
 						  &bdaddr_resolved);
 
@@ -6067,12 +6076,6 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 		if (!hci_bdaddr_is_rpa(direct_addr, direct_addr_type))
 			return;
 
-		/* If the controller is not using resolvable random
-		 * addresses, then this report can be ignored.
-		 */
-		if (!hci_dev_test_flag(hdev, HCI_PRIVACY))
-			return;
-
 		/* If the local IRK of the controller does not match
 		 * with the resolvable random address provided, then
 		 * this report can be ignored.
-- 
2.48.1

