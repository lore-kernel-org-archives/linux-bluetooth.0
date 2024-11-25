Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BAD1C1F12
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Nov 2024 20:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732567339; cv=none; b=hoFs9W5IRjQYStDj/FS1ePqGHVUrBUTK7r3XTVIvJopCiFaI4q43N/gsjmWFvmxZ76R7SXjPseOs6UjJ2JKqWRZa4rh8cSietqhh0xTQqlHQuLBoiCXBwBfq5igEoBx0k3S9ftAuOWD6skb0bwUlnDqQgaEV4q3FE89A9JoPGMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732567339; c=relaxed/simple;
	bh=zajCWDymF2CQVGsHAlaWcUNJiLHBwpFRQfYizjAO4bk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=juMVLYqgChsGQo4JJQ466oCYCrfryukLm+JoHSZDVcSqdkOo4WBA2M/2JZz25tJLzT17bGJ6yOVzap3MSzmCsADk5XqOuQYQd8W0ycsO6W3dWGtpJG27xrDaSCIrZO6lLVQD6+Qc+DuOE4TkQaxhPi80Gl9AHg/iFTILtLhhVfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRMiGm9N; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRMiGm9N"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-51533f41d84so420036e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Nov 2024 12:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732567336; x=1733172136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LD8kiPdUDvDi7TDCPzoHKEOZz9o/dvQO3E3SPtcR0TI=;
        b=BRMiGm9NEqhBRxIaR0iU/fatu2hxYg1h0i968VUumXjfqCp9+q01d7ojpTj533Tl1S
         jdZOeGzaVGv7I+0bnEdBQL5Gq808NdFKq7fHR6QgH1ITg47FAJWTL6+Spsq5+n6m3KUi
         3aY3mSeqozG17IEy4Ah4XwTHYYFT9VY948RGzgxnwMpj8SdQnQhZfRV++MzIbbh8Sf70
         lAEP6dZhoWTRM2groNZwyNAW8OIITFPsa5eyKOwNvwJ8diCWW4xKEsim4q9yj7lo77b2
         zh6SZwuhEq9CXjF9/e98HUS0bn46AZgcSnUSXOEbWtuQpoNcJD8Q9dQZSyA/ZVe/n214
         drDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732567336; x=1733172136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LD8kiPdUDvDi7TDCPzoHKEOZz9o/dvQO3E3SPtcR0TI=;
        b=t/5AVyns9xcY4ZpUUBCrzuBkjRbDFN52QCr4Y8+we/ztDmF/HagQEj8qWz095z/g5c
         koTJU0sM0ttgL11GyeJS140OC9EoLletZ25bi/0JplDi94Q2+d//IIrbCRv9/Pgx9drS
         AmNvHcIHvlTPtQM2no13SZDhAiBF0EUptejBrKkeLzA44Fr+2aauO+m3VT1h84/Uwr6t
         tQZ/G1W3RsVL1l3FXqWcXjw3vbqpQsMlX82+k7PcYtILmtkQe5R0PLIkt+9kVZcNnrjb
         Eh21cha8m0kvCctt4Q9HQ21LH0g2OUOn8lYMHxeZEoYvXPeABNRzkniRMXw6ds+sJRHJ
         3mxQ==
X-Gm-Message-State: AOJu0Yw41g82G+7laLEIdDoklFeWqNdlrm2OL5E0jwnuHvPp1B2ZlFpM
	APusJP1eE6W5rLNhUgms9/t3vBtwY0loadkb/YwGteC3SywbXMpsevw+Yg==
X-Gm-Gg: ASbGncuIE0X7+Kdr6tF5k4efwoe9MvbLYee2Rtl6wCCgRzQhU3p8KaXvazScDbmALnh
	Y+r9XxKhQOET/iWpxriq1We72LhNZaSIoG1bgjkCugbeUQSW4PW8Thi6baJVM2hG91ALK14JVY4
	fHx3fAvn0s8mDnBBwdIBVAGR16Y1NGRUL4lUP0H6ujG5wu4X7+kS88DC9CvOOuHnJ9aSiAy+m/u
	qRplTEWKGi3uX84ftR+IBZ/qFqCM02Lg5BqC3kH7mEZt778WFyAts0O34lydObuXNfwm8ttUmxI
	PKmj6y+VXGAel/SIKVTNaw==
X-Google-Smtp-Source: AGHT+IEE0PKIoKfdtXnFXDmL20YBxtjkfnZRa4T4X3UERqrwkdnr7N/lWNa1NwGqeWD0F7JjFyqqHQ==
X-Received: by 2002:a05:6122:4d0a:b0:50d:918d:4da1 with SMTP id 71dfb90a1353d-515004987c0mr13482995e0c.3.1732567335724;
        Mon, 25 Nov 2024 12:42:15 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5154456a62dsm49166e0c.44.2024.11.25.12.42.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 12:42:14 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 1/3] Bluetooth: hci_sync: Fix not setting Random Address when required
Date: Mon, 25 Nov 2024 15:42:09 -0500
Message-ID: <20241125204211.716883-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes errors such as the following when Own address type is set to
Random Address but it has not been programmed yet due to either be
advertising or connecting:

< HCI Command: LE Set Exte.. (0x08|0x0041) plen 13
        Own address type: Random (0x03)
        Filter policy: Ignore not in accept list (0x01)
        PHYs: 0x05
        Entry 0: LE 1M
          Type: Passive (0x00)
          Interval: 60.000 msec (0x0060)
          Window: 30.000 msec (0x0030)
        Entry 1: LE Coded
          Type: Passive (0x00)
          Interval: 180.000 msec (0x0120)
          Window: 90.000 msec (0x0090)
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Extended Scan Parameters (0x08|0x0041) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Exten.. (0x08|0x0042) plen 6
        Extended scan: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 1
        Status: Invalid HCI Command Parameters (0x12)

Fixes: c45074d68a9b ("Bluetooth: Fix not generating RPA when required")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index c86f4e42e69c..7b2b04d6b856 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1031,9 +1031,9 @@ static bool adv_use_rpa(struct hci_dev *hdev, uint32_t flags)
 
 static int hci_set_random_addr_sync(struct hci_dev *hdev, bdaddr_t *rpa)
 {
-	/* If we're advertising or initiating an LE connection we can't
-	 * go ahead and change the random address at this time. This is
-	 * because the eventual initiator address used for the
+	/* If a random_addr has been set we're advertising or initiating an LE
+	 * connection we can't go ahead and change the random address at this
+	 * time. This is because the eventual initiator address used for the
 	 * subsequently created connection will be undefined (some
 	 * controllers use the new address and others the one we had
 	 * when the operation started).
@@ -1041,8 +1041,9 @@ static int hci_set_random_addr_sync(struct hci_dev *hdev, bdaddr_t *rpa)
 	 * In this kind of scenario skip the update and let the random
 	 * address be updated at the next cycle.
 	 */
-	if (hci_dev_test_flag(hdev, HCI_LE_ADV) ||
-	    hci_lookup_le_connect(hdev)) {
+	if (bacmp(&hdev->random_addr, BDADDR_ANY) &&
+	    (hci_dev_test_flag(hdev, HCI_LE_ADV) ||
+	    hci_lookup_le_connect(hdev))) {
 		bt_dev_dbg(hdev, "Deferring random address update");
 		hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
 		return 0;
-- 
2.47.0

