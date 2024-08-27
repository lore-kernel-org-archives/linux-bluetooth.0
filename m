Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC031D2784
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 19:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724785622; cv=none; b=ixWPcBHt9CbAT4JRKT/Rnr9qwaoNhfztW9+Pc/AFi80sFIzSkVWuFrpHsXM1AcCxqCbER7MKtUqQnrMpPCLcKzhI12J+AGFq2L6+8W+60HaCvzVw1eQU0JiAbbvTqRmSGdWBGzzKTfGOJiRE+k93jQXRbs3JNcuR1ktnrtlCPIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724785622; c=relaxed/simple;
	bh=zU2tGzP4ELNdarrnj9fMOKIKXEDe8Z+yCXfmXiC3Yyw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lC7bZdPR+s6KSP8OmzJOPcz1SpsJDFA1NfsjT8eNQSKbOevMryGQBrULURjN3X28XLWegiKZmxJLbGesbG/3hjA98aV2FKc8lltQ7wCf7BxLcRO+Vgt7dkxQ/eQWhSSGK0IuxawJe5SKl4YXwNLkR9jT42mKRVX8vFHzh7aszNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6qm5xF5; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6qm5xF5"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-70e00cb1ee7so4177414a34.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 12:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724785619; x=1725390419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uejPwr/H34TViCpmiNFrCAPQXCy4CtXTFE5mrkckMbU=;
        b=k6qm5xF5fzpc3B2PHwzUu47i/ZE0p6jg79vbefVa4awqjTne026GZ5IQAZAir+txKX
         2PN5R0la7mid4c+6lOUnkiS9Zj0rdz3fgFAoUqzGsk4yyqUgWSvTv3oybzYTAMx2J29e
         tpIx7fPSS3m5x7hDDphGZE3Zo3YtVOXAA2sTDvXeVvKgLgfT8FEBGVvUg4hk2oZlXX64
         JQqdKw71pRP6z+GIswBN/SXeEHblndwxNhWtXTU7fUVKeHrZKcA3H3m/F0qay1vZjO/7
         gAzOuJ5HIVRnSjIrCoTOi/y9qAqvpQgH+Volok8TOEuWMVoEVz1+38FhIkqztyxY2AAR
         BICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724785619; x=1725390419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uejPwr/H34TViCpmiNFrCAPQXCy4CtXTFE5mrkckMbU=;
        b=v2HcwvwRnU+V9kCdpUsVL1b6dMxP8FBCJrzVaLb07FyJwhGwQJCWGIP60m4bhr2sCo
         YGS2EJ8oL3cVq78fn4Rq1EEJwmznIJM7ncNncfPVRrWu10DtAJ/xIzyLSoE8rMY1rjdY
         Q00LBPwwpzFakG52DLjkspu9HybnusLzXCrrsjtOqTALPc05Ieq4DUvum9h4lXwHHE90
         oBmGhrak7XmnddKSRFiW5MdAAnJgP9pXZ/irKGSG6Yi2GqZNQ9v/DnI7Fm03+2p0RZzl
         jgms9/bocOklJ3BrWKHnONh5B0tJH2MpH/BrFddPJu2v7bIoB0IRkyzb3Vn/6LyqV1es
         ijcQ==
X-Gm-Message-State: AOJu0YwUCvK12QdkdZ+ZbOnWA/zKH/p0FTJu9Wmn6EA6jSqk4lENMRvT
	+qoYvXaB8dWVE4ldXtWVCZDJxMbOORLOzVBJ4Qxgf7lpNtZC7gHQznz04w==
X-Google-Smtp-Source: AGHT+IFfOBtgSHT96njHyqQjKsQjRa1K+duAY1Fb5TiKqTQOd5Lg0Ss4XE8xL6e2iyg8kS3uOWj3BA==
X-Received: by 2002:a05:6358:724f:b0:1b5:a043:8f43 with SMTP id e5c5f4694b2df-1b5c1ea9182mr1611688755d.0.1724785619462;
        Tue, 27 Aug 2024 12:06:59 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-844ce4da5d6sm1395092241.4.2024.08.27.12.06.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 12:06:58 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 2/2] Bluetooth: MGMT: Attempt to fix up keys being loaded with invalid type
Date: Tue, 27 Aug 2024 15:06:55 -0400
Message-ID: <20240827190655.675179-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827190655.675179-1-luiz.dentz@gmail.com>
References: <20240827190655.675179-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Due to 59b047bc98084f8af2c41483e4d68a5adf2fa7f7 there could be keys stored
with the wrong address type so this attempt to detect it and fix them up,
in addition to that the commands are changed so that they are less
strict by just skipping keys considered invalid rather than failing to
load all keys.

Cc: stable@vger.kernel.org
Link: https://github.com/bluez/bluez/issues/875
Fixes: 59b047bc9808 ("Bluetooth: MGMT/SMP: Fix address type when using SMP over BREDR/LE")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 44 ++++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 240dd8cf7c7d..9b41b5f9c571 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2830,15 +2830,6 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 	bt_dev_dbg(hdev, "debug_keys %u key_count %u", cp->debug_keys,
 		   key_count);
 
-	for (i = 0; i < key_count; i++) {
-		struct mgmt_link_key_info *key = &cp->keys[i];
-
-		if (key->addr.type != BDADDR_BREDR || key->type > 0x08)
-			return mgmt_cmd_status(sk, hdev->id,
-					       MGMT_OP_LOAD_LINK_KEYS,
-					       MGMT_STATUS_INVALID_PARAMS);
-	}
-
 	hci_dev_lock(hdev);
 
 	hci_link_keys_clear(hdev);
@@ -2863,6 +2854,19 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 			continue;
 		}
 
+		/* Due to 59b047bc98084f8af2c41483e4d68a5adf2fa7f7 there could
+		 * be keys stored with the wrong address type so this check it
+		 * and fix them up.
+		 */
+		if (key->addr.type != BDADDR_BREDR)
+			key->addr.type = BDADDR_BREDR;
+
+		if (key->type > 0x08) {
+			bt_dev_warn(hdev, "Invalid link key type %u for %pMR",
+				    key->type, &key->addr.bdaddr);
+			continue;
+		}
+
 		/* Always ignore debug keys and require a new pairing if
 		 * the user wants to use them.
 		 */
@@ -7117,6 +7121,13 @@ static bool ltk_is_valid(struct mgmt_ltk_info *key)
 		return false;
 
 	switch (key->addr.type) {
+	case BDADDR_BREDR:
+		/* Due to 59b047bc98084f8af2c41483e4d68a5adf2fa7f7 there could
+		 * be keys stored with the wrong address type so this check it
+		 * and fix them up.
+		 */
+		key->addr.type = BDADDR_LE_PUBLIC;
+		return true;
 	case BDADDR_LE_PUBLIC:
 		return true;
 
@@ -7163,15 +7174,6 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 
 	bt_dev_dbg(hdev, "key_count %u", key_count);
 
-	for (i = 0; i < key_count; i++) {
-		struct mgmt_ltk_info *key = &cp->keys[i];
-
-		if (!ltk_is_valid(key))
-			return mgmt_cmd_status(sk, hdev->id,
-					       MGMT_OP_LOAD_LONG_TERM_KEYS,
-					       MGMT_STATUS_INVALID_PARAMS);
-	}
-
 	hci_dev_lock(hdev);
 
 	hci_smp_ltks_clear(hdev);
@@ -7188,6 +7190,12 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 			continue;
 		}
 
+		if (!ltk_is_valid(key)) {
+			bt_dev_warn(hdev, "Invalid LTK for %pMR",
+				    &key->addr.bdaddr);
+			continue;
+		}
+
 		switch (key->type) {
 		case MGMT_LTK_UNAUTHENTICATED:
 			authenticated = 0x00;
-- 
2.46.0

