Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593CE34FF79
	for <linux-bluetooth@vger.kernel.org>; Sat, 22 Aug 2026 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787407958; cv=none; b=W3WipZHjMUXZY+RzwFRiU8Wnq+XJydhJxZBdb6xdvG7oF6TOreEkMef3nPzLgNPOuQmiu2DApdx+130ueWNN9VXWUfaWff/U6SNBayxCDRtCcBs2VLN3tpXQNLjfndXHhb8ZXNJ2URZxE03zCik0HLcUqKV53FQaaxeCuauGJOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787407958; c=relaxed/simple;
	bh=u2led2iM95H40jffR0sjXQKAm5+lVuIahsaSzLeQ8Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IklRpAJd5N4LDGK2YqRHFvnbLdrTi34n0Akcudj3b2Z5MD0Kp/x/xzgeoudQJ7+FPlnAPefAU9Yh2uMjjsOnu/wcBHKRu4KV+TMllyHdowtTd8WAoqi85jvPV2M9oePnM5plDqpdDoCnyIZF6rO2HjsG9UO4U0cINbWFoVQh6Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWTCC4fQ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWTCC4fQ"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a15d54ac95so3516476a12.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Aug 2026 07:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787407954; x=1788012754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AACxzMxh8D3+74R+fCgOyXG6KrSSQBlsUGYlirSS7iA=;
        b=EWTCC4fQMPSBJqRBqe65Xc1yo3aX/LU+O5aPqvfnA7uRCA6+uHISKIJOYWcvJn2jeB
         69T8SOtozWI4MCK7N2wv6NL/2JVZZOj8F+RydSmmFVweQhbW/hHzU6gh5iJsXpwha3S9
         w+WYOsjqOSYDYZM+VHoaPPIZdQL0hfUXsHSMAkHGyX0I1E3dGdKM0UKJHB7rU50K6nW+
         jdjd5xwHBW1GApDv47EwyC+CKfzi7g1Ip891vmTCA0NRHyk9BveQQxO3WL8WoVJSDAvJ
         eA4kn1kN4y8fBxPdU4o5/ZLoy2SVbuhtEifQMKVbmJ7HCT/QaPjwprKt1OGm06WVGdsD
         U/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787407954; x=1788012754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AACxzMxh8D3+74R+fCgOyXG6KrSSQBlsUGYlirSS7iA=;
        b=UpTLHwN0DKxcraMAZdx7HBJyEwE6O0lU2w0mfRTLclpy2pnULOkiIwOV3LLETCOwWj
         /bC/BHOQH1D788Kvfn9lexBmQsS+/BBwcLny07U7phm6dmmeiag73ba7fUkMmRQDMJnV
         gdJ2Y52JODrEIpIl8mhdlvCcMDwOPrnpSCjF8QX1udvjWKTEsi0bHykw0LxlD8o9LM98
         M4O0vfvMlTcnw1nsvxKhIyL3W0KDppNTcBLlgAtuMcY9NxwKORL1A5uQYe3D7Rj7Othc
         DeXQ/foRHoUzLIHBx4Ge4WfXi203/Juro9pmYpuvZAxjYQ8omOORSdff4qI12B3FrOrq
         wbrg==
X-Gm-Message-State: AFuF++mlN88SfoLsUctwj3UsBGhpzpMPDmm7wqYQL7F3T9w1ix08TJx9
	5TdlELgMm9YI/fahZRa+DZfrp+e3XvMm7M9WEBxlqM/3dhFEREHsbghioy1ZXTM9
X-Gm-Gg: AR+sD1149FoM4LPEf4efLp5BQGGBt88MFF1Lj9bsljZET0aww+8xOCupaKw4HUIVtDs
	rBhw+roEvIHkf+vFKnRVG1EHeXI2Wazz/ZNZ3f9d5Bp5h5CMYpqHP0QIc5iHWEcyP+wZbRSBNco
	EVSDvMZUP1RsIywyl67laOvFylCwqqpsJIY7oNnm0rzGqUWUbMvAIOq3dex4A6QABHj61C2jzm1
	vHS7lLAIyzKLsTMROqUHhvIFti68hhZZAp/oEGpvZkTfNKzIA9aQrcSMSVWRe7GDsFdzjs3Gdfw
	o3KNzSNg/kHmk3CscmTfsAyNeE7oE+ZVgTIt+ceLtlY28cfxkFI5Ng11xQuz463Sd/cpsYiWzPR
	8PIMdCcF/KwMJdmgup2AhqsCD2EPu1fNA6SJ6MuMUJFwort7qIjCB0FLO3M55s7gNLs3UGvXyHC
	eqCNwIGpuTKiPPlaSV2Mq2+1r+YTGJqwMeDub44j3dLX8T3hUDiEskwzTuVk62J+daBQSNR9wms
	cfV8LTsHHBeCeUwskQOUxqtLn6v5UUp1bPKc/qLgoCXJ/fc0BW4sjwM/eQNrVZwejpkUUWVWJIB
	2nTNqoY=
X-Received: by 2002:a17:907:3fa0:b0:c16:16b9:98fa with SMTP id a640c23a62f3a-c249257b3abmr609543266b.5.1787407954349;
        Sat, 22 Aug 2026 07:12:34 -0700 (PDT)
Received: from bobo (d163-170.icpnet.pl. [109.173.163.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496734bfcsm340625266b.43.2026.08.22.07.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 07:12:34 -0700 (PDT)
From: Kamil Serwus <kserwus@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Alexej Sidorenko <alexej@sidorenko.cz>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kamil Serwus <kserwus@gmail.com>
Subject: [RFC PATCH 1/2] Bluetooth: hci_sync: latch broken ext scan on Command Disallowed
Date: Sat, 22 Aug 2026 16:11:14 +0200
Message-ID: <20260822141115.58815-2-kserwus@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822141115.58815-1-kserwus@gmail.com>
References: <20260822141115.58815-1-kserwus@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HCI_QUIRK_BROKEN_EXT_SCAN exists for controllers that "erroneously claim
to support extended scanning". Today every user of it has to be
recognised up front - by chip id or USB id - which means a controller is
only handled once somebody has owned one, hit the bug and sent a patch.

Recognising them by behaviour instead is both simpler and complete: a
controller that advertises the extended scan commands in its supported
commands bitmap but answers Command Disallowed is exactly the class of
device the quirk describes, and it says so itself on the first attempt.

Latch the quirk there, so every later scan uses the legacy commands.
The cost for an affected controller is one rejected scan round per power
cycle instead of a permanent stream of failures; for everyone else
nothing changes.

Signed-off-by: Kamil Serwus <kserwus@gmail.com>
---
 include/net/bluetooth/hci.h |  4 ++--
 net/bluetooth/hci_sync.c    | 15 +++++++++++++--
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 50f0eef71..5cee010f2 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -276,8 +276,8 @@ enum {
 	 * disabled. This is required for some Broadcom controllers which
 	 * erroneously claim to support extended scanning.
 	 *
-	 * This quirk can be set before hci_register_dev is called or
-	 * during the hdev->setup vendor callback.
+	 * This quirk can be set before hci_register_dev is called, during the
+	 * hdev->setup vendor callback, or at runtime on Command Disallowed.
 	 */
 	HCI_QUIRK_BROKEN_EXT_SCAN,
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index c8d14128c..eb711f454 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2265,6 +2265,7 @@ static int hci_le_set_ext_scan_enable_sync(struct hci_dev *hdev, u8 val,
 					   u8 filter_dup)
 {
 	struct hci_cp_le_set_ext_scan_enable cp;
+	int err;
 
 	memset(&cp, 0, sizeof(cp));
 	cp.enable = val;
@@ -2274,8 +2275,18 @@ static int hci_le_set_ext_scan_enable_sync(struct hci_dev *hdev, u8 val,
 	else
 		cp.filter_dup = filter_dup;
 
-	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_SCAN_ENABLE,
-				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_SCAN_ENABLE,
+				    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+
+	/* The controller claims extended scan support but rejects it. Latch
+	 * the quirk so that every later scan uses the legacy commands.
+	 */
+	if (err == -EBUSY) {
+		bt_dev_warn(hdev, "extended scan rejected, using legacy scan");
+		hci_set_quirk(hdev, HCI_QUIRK_BROKEN_EXT_SCAN);
+	}
+
+	return err;
 }
 
 static int hci_le_set_scan_enable_sync(struct hci_dev *hdev, u8 val,
-- 
2.55.0

