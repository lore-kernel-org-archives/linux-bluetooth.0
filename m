Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D521C26C3B7
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Sep 2025 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758299419; cv=none; b=SZBnzoZp8f+SKxtPtAUsfeQZ64qfq84lWL8dCGZ58dII8hhtLanw7kV2J1qsbCqMMEXZiYA0VEiJbEI1XKe/lCEvWUFf5zD/gF9uudD2Bk5toiJClCRlMfaT9tR7iRwP39IYMmJIEXnarainIsFeeSHkjYBrWrSZJL5UBkaN7hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758299419; c=relaxed/simple;
	bh=BKdVFxL3ljsv3ncmAiuv93ZBC9fxbJ/0JmqtcAunVmI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=oJENMXxeOXAM+LAn34WTPBARwATjv68BL5MXgsmMIye+/ZrcMpHiUmMvhDUOUvieO7XFL1fDEa4ZOri/rrjI5m/C7DYC5bvHI0vB/4du7yO/6bvsSh0SJDlFOPapdMLXAhXJdrvY4ehCLiFw3LVrLn5FbB+iUZ54j3p0qLCfdb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqhBEwcE; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqhBEwcE"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-54a786ed57cso1642823e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Sep 2025 09:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758299416; x=1758904216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=th8P/mEYlAqVGaj/WtFrW2G2HmFKVGvHZmsKttAeAH8=;
        b=HqhBEwcEMGbWLbM2J4k4GO732MtsCL64HNOzjuLs9/xncdEKdLdafV3fLvCFPl5AuN
         arml+nYKXusrW8kJ00/o9p70mzRpslAzu2Q9chDBhaWPCxUBd7B3OeqYEOgZa6Mjl3z+
         vhuknywnmzp+HaM+2cbXXic//S+V0DUf4XBbxkM6KYMXxzzl1Ig/+XnE6HhidqkbrL9y
         GrqMvs3UiMtEXIVOTEpkGf+U4cieA7ElB86kZRJ59FxfPyDQzLTs02sBDb5veCLnWus7
         M6UDWa9evBWDPA7Yo+YQ+RVPZOF4UmyCFEUmVLfeOtSbHfY/VaOoGXXrPDpb+EN1AplM
         2l9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758299416; x=1758904216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=th8P/mEYlAqVGaj/WtFrW2G2HmFKVGvHZmsKttAeAH8=;
        b=XpyrQ9Rsb/Xz/Jev+/yjqGNyIpmn7JQxEs1qaKLtjiMLiFGM61YxLU//P2nmG7paey
         v770i5UpbYiXh9huef8Pb3y7imvhTO0RFdNutBMRSezQsUWTyN7MnzQgNjk2QPngu0OF
         WCdWJlAlwXwuLdnTqSV+g7FntXoQARC5+vWkXW0lsT0BSrf8eiWwzraw/5kRzrbqr8oE
         JhLM2l1bHnLs9e0ZHXZOORJ+Q8hiJmLADR0/Vr6LDIKXprMGq7rykeMFz5ZG4OCIhazw
         IL2+qRJ7G3A/3WBPv6R38EKGzM/OysFQx8xBMzz2BvxKnF24aX2lwmLbh9ibxXHcvrM5
         cLEw==
X-Gm-Message-State: AOJu0YwlD6cwJGQ/c/fFwxVuVjnYx5g+QnkHIQGm8rUAqJgwYuP6UY9c
	dAnj4TzLLJONUMeJJ9zmGYPeXVXFE3w4DHqvadKYpQzY7xbnSpxlqGbL5OMYmxbsWkc=
X-Gm-Gg: ASbGncsgGTN8snHPoxOpZcqA8OoabS+lGgNoQhuPDbebyBkLkgNZS9h0q3FfsjpQ5lK
	/8b3et7KANqwdG+uiSgePtIZXmQClfTI2xrZlcevrhBFDOcpL7wgYQAa01/Na8Ws3iCgJvVSpmO
	3qQh4Q5ePXJrncqFOaRaIrloDKhzT44aVfSVC5GHI2MnNInVaMeJYyG8YC6Hk/bLvRyDJee8IyO
	Y8i59QqRRKAfZK5u690o6UBXtjenKr2qqlkX0zsyIgEnX0uyvIYUhlKe3tdIB6U3NIO/DwNWDAB
	z2M4KBi1dJbpkbZndbnNgPuvOKNQtE5q0dgDhCjcETJp+zp9wInBL8WDqBUyWB+yjkQI66gslA0
	SXqS07nHJXrldeFKE6VoxBNZQ35H12sP60ZeKXIrpXMrkGpEuAVf2ZzBjMbqtaSEaJA==
X-Google-Smtp-Source: AGHT+IGxJ54ukl6WvvXmjkGXYWJ3BLdnlmIUSXu4rxafVC681WKzcA62wKeI67phmPo7baF739sKIw==
X-Received: by 2002:a05:6122:3c4c:b0:541:bf69:17ac with SMTP id 71dfb90a1353d-54a83b355b2mr1624641e0c.16.1758299415938;
        Fri, 19 Sep 2025 09:30:15 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54a729b9222sm1214470e0c.22.2025.09.19.09.30.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 09:30:14 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_sync: Fix using random address for BIG/PA advertisements
Date: Fri, 19 Sep 2025 12:30:05 -0400
Message-ID: <20250919163005.2278059-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When creating an advertisement for BIG the address shall not be
non-resolvable since in case of acting as BASS/Broadcast Assistant the
address must be the same as the connection in order to use the PAST
method and even when PAST/BASS are not in the picture a PA can still be
synchronized thus the same argument as to connectable advertisements
still stand.

Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connections")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 6a0f731615f2..7f4310dc804c 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1325,7 +1325,7 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 {
 	struct hci_cp_le_set_ext_adv_params cp;
 	struct hci_rp_le_set_ext_adv_params rp;
-	bool connectable;
+	bool connectable, require_privacy;
 	u32 flags;
 	bdaddr_t random_addr;
 	u8 own_addr_type;
@@ -1363,10 +1363,12 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 		return -EPERM;
 
 	/* Set require_privacy to true only when non-connectable
-	 * advertising is used. In that case it is fine to use a
-	 * non-resolvable private address.
+	 * advertising is used and it is not periodic.
+	 * In that case it is fine to use a non-resolvable private address.
 	 */
-	err = hci_get_random_address(hdev, !connectable,
+	require_privacy = !connectable && !(adv && adv->periodic);
+
+	err = hci_get_random_address(hdev, require_privacy,
 				     adv_use_rpa(hdev, flags), adv,
 				     &own_addr_type, &random_addr);
 	if (err < 0)
-- 
2.51.0

