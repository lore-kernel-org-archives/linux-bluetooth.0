Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2C51AAE2C
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 18:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724868658; cv=none; b=IxODy1D1p3rC07f8YS5FMIGjr5fy6FM/2dtyqpm3y6aDfA//a8q9RYpNEd8VZdqXfsbSyguds1dVeOBtw/brldGjKnOU3Dx5mF4SAbBpkuWDPpcNyvp+T1hsgoVFhhfFC56A+EE3NPEVCyIvlbEkQ2K54ngs+wz7P/HRVnbWcPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724868658; c=relaxed/simple;
	bh=1gK0IdA27HujfdTxFGE8IlatyCq9h4hz19jHa/7SC2Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eOlrLBQpkGqnbdVor5SrBULsMEIUFyUTXY/v8Cm2CkVFCJanD3yhNQ2MxCYa0aTluWRJntW5Pcc9x3Bu5MstDXc7evJ4YZEM8qOoEtEPfGXpVaBLf9CcXj4FmJLTbhJxzFC8r4FaNWJlqNaM1hXqZtBd3RM2D5ajPGDI2kGLB6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RvD8AqBh; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvD8AqBh"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-498de7a11b9so2309929137.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 11:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724868655; x=1725473455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=miPIrcJtiQTyXHplzwiPVK6d4OA4XunJfp7gjICeoso=;
        b=RvD8AqBhy9h6SsJrJ8f0/GmLblUL2AMjfZBBM242aY9zQDlYz2cgj04PvlnZJfcubh
         5BM1u7lI6uaEKUkFV9uxZLcTYtKNQWWOKzQL50jL24AKUE1idjf/IqbHLPj2aoD6CRGC
         02BltYERCNCCyKw/p7BipoQj3Sxi/T9QDlSMEy2F+yO8z52WVi9MJp6j9AaHws2yLV0b
         Qrc5O+ONh2Kiw54tEofRaDjqblrFPAnfe5gD7gSFzvPTrvU3Bs7EF/p3azDio5N87suI
         ouX61Pq0w4BAbrzgi9xWrY57cl5Rg6/hY9+mmfRQ429r1KLoiRO4SFV4QY5usISCjcF+
         qxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724868655; x=1725473455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miPIrcJtiQTyXHplzwiPVK6d4OA4XunJfp7gjICeoso=;
        b=YIHnFe7ACihqIUyUrq9mY9r2ALyahcMQAPc4uW3M300/tV6ET2FxCZd/kSvNK5daiO
         eSTbqaIBO0V1ysYW+xGBlQQh02dXXfbLo2dRjoYymuqZL+wUalRKN4Eglv/kRGTXcIzz
         GuH6do0et5QVdFQZhqgfGg0kPWkr051Ecn564bOtx6mC2RXO75zLnMmgW7aVYdtrhVYG
         0a+Xh1ol3/VMUb+eZN/j7LoCa2xV26d2Dpie8tiZBupPzyPK5ZTUFEgfwAqUyxsgZrMD
         0Cxq0ZoWOlIco0qszRT/76D6JX5XNpjUAVyxYOWWXu0ahGlBGK0Ue87l0qc9nolmBT8n
         yh5A==
X-Gm-Message-State: AOJu0YxG29OP68n5azXgxNbGGnrXLXJ+3NIzdPnz9J1SZ5UWCDXApOl0
	b9i2Kih+YTh+EaePWm6XXPCqpQFyEBdjgNYtUVDv6iFbfgQC8cXVZ9Hb6g==
X-Google-Smtp-Source: AGHT+IHBrdoqx40STjbD8qHx49U7OHQr2XzC1y84RZtgWJy7d+XM1OH7FoJIa9kANNg/0ajVIYLW7Q==
X-Received: by 2002:a05:6102:4428:b0:49a:42f8:dd20 with SMTP id ada2fe7eead31-49a5ae70caamr725917137.14.1724868655330;
        Wed, 28 Aug 2024 11:10:55 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-498e48c9e0fsm1843280137.24.2024.08.28.11.10.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 11:10:53 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: MGMT: Ignore keys being loaded with invalid type
Date: Wed, 28 Aug 2024 14:10:51 -0400
Message-ID: <20240828181051.876598-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240828181051.876598-1-luiz.dentz@gmail.com>
References: <20240828181051.876598-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Due to 59b047bc98084f8af2c41483e4d68a5adf2fa7f7 there could be keys stored
with the wrong address type so this attempt to detect it and ignore them
instead of just failing to load all keys.

Cc: stable@vger.kernel.org
Link: https://github.com/bluez/bluez/issues/875
Fixes: 59b047bc9808 ("Bluetooth: MGMT/SMP: Fix address type when using SMP over BREDR/LE")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 240dd8cf7c7d..2c46316dfb2e 100644
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
 
+		if (key->addr.type != BDADDR_BREDR) {
+			bt_dev_warn(hdev,
+				    "Invalid link address type %u for %pMR",
+				    &key->addr.type);
+			continue;
+		}
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
@@ -7163,15 +7167,6 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 
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
@@ -7188,6 +7183,12 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
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

