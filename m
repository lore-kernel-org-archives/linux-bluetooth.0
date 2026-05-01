Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142CB3BAD8D
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 May 2026 14:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777646344; cv=none; b=DWVx/98+L9TtdZqKQQSk4NsUO5DTdwkjSJObLKSeV0UBlK2cG7v5W/oAVwzO1U1tXZVe/ZGrfAi7Z8xy7ijlzzlt5/QBpU9eqgTCBWpURNtBL0CJ1GCbgvYcMZmfJWmZwNIsuslMl/3xrvJ1qVPSrpdu1o2aiSSCF2DQjqc1t+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777646344; c=relaxed/simple;
	bh=D2Gp3Yqs1ck+PJdNwn7aZzQJLW8epMVRtfky+CCgdrc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XoWWDQetYGK07WntxMJj7xuafd2X6J7WAZ2jEKUsKA3OMDbZehYCo43hWIEL+eYKZ4jm31PsPuhmct3R+n8SEM5R92WSAKohYPaoegr3oXBn9cFlJkrXAnnI4CUBSqQ85QlpxscFdmc9e6Rif34XQPAqqn0lGorVBdCYTl42oCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o25TpO9h; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o25TpO9h"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-56a8e0ea02aso1805596e0c.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 May 2026 07:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777646340; x=1778251140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B90siZ5dqpzJN+32PN+mfbmhHNMVrLuF+e5HNWBGIsQ=;
        b=o25TpO9hqgmPWPKWya4d5D3xjCHUZzl4vALvC4Pjm8nTesykrOKKBkWMHFFc578rN7
         JArIh1bYfu7GWMPhbhFxAOPct4CD127tQKGb3kx9sAkro09jn6EvHc5EWzASINjcTG8c
         ne3w2SwsaZxFpPTxeqjrlbBmn0/5zpABHeYmPOw0NIw2I7xPSJyQtr9PO1sl+UMeGatd
         h2fYkk7nXWr+bFfj1d2LgfgTqc8sJJrnceqsic+fIJavEnWCHsHXwAIisfYF6yRzmx3P
         tQqHxcU5oBjkveStreUZ+lTDTdXNs+co8KeUsmGOGD/SEBnwJKb4IAx1NPj8nbKI9nzH
         9/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777646340; x=1778251140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B90siZ5dqpzJN+32PN+mfbmhHNMVrLuF+e5HNWBGIsQ=;
        b=sX9LJW7xmFqVkyZ7bdPDm91hpdxm1HCdZBo85D4sHN5i9LEWfMOlgO5E548KfrbzXb
         3stNvgZr2PLkX1AAy0Qu5dfrFVIMGpI8/t8BaxGK27EX3ugfFpSxtfcr4dSdtvxSyxpL
         NajCAzAO1Xx+iQ7FgtaFk1uKIF9USEQA9b1xF1pXh+SsPB/uiaSaEH+8OL9jYy0E5hgP
         zhaVTfXzJU1QmTzzZDz4UClq5B3hXXz9WjQgbgi6gmsBWa0AotqF8T54ySYv6cIzlwZO
         kLeSI7uviHK+CAuAWtqpjRh/WHotgvIMQofC9+haVIzpzu/wmqRI7RXEvXivFNbiOGlq
         mYjg==
X-Gm-Message-State: AOJu0YxDRYd39Vc9mTCaRccCqa7lCQk60JW2JP6MUTtc1h+RNAh6W/Jb
	jFF/RKOE7T23pGskY2mcthoxBanpbdaIDp9PGeBfM5otO4v7rNqhlk+SEFDynUde
X-Gm-Gg: AeBDieu9WYtXrnVfHhKa3BOXVB//RnDTP3cfizeRc7TvbyfAdLA7w3YBTeFB8sEHqOS
	Knnx96m7amAVwvcISc5W2p8wLpZueZwQOzSGcOAvXZAHDCBksqe59b4cYO12xWkQfLIlSdLjwgX
	5yOfqXkufVdjsILMbYSjwb3Q0HV/Rljop0V2vOVY3q1OlM94Zajt2w9eqTwUm6zKV0koAelIG+M
	oMpbkGVurbw4eYq5RzNOYa17qvzT3rFNwPW1ltm91Ap1Y9PCJokwvSqnGSri/d/zcQXuWiUSRrl
	sDQ5vfVCCGi0G1jVme+sIbT4nCzgmAje6v9+NLkQg4x2l9eau62jgcLNIT8A4D7VuWtimcJ9Jwa
	bsI8YdFfURAfDPgiYk3swg6d1FCak67KzwTBEBz3hReHQdyglgw3zE1zzV+9XpwOM8g1P9c6joE
	CPIHCF+eNfGpCvAhYo0II1fO0hKs0rJs9sL0ctZN3xVger/tC+ByyyLMjM7ThcFT6HW2xKSv9pB
	rCXWq4FT2f0Yk//B6BS1Wa8gh+R
X-Received: by 2002:a05:6122:909:b0:56b:7ec9:f54 with SMTP id 71dfb90a1353d-573c96a855amr4154660e0c.9.1777646340565;
        Fri, 01 May 2026 07:39:00 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-574a6dc7dd4sm1531895e0c.14.2026.05.01.07.39.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 07:39:00 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 4/4] hci-tester: Use bt_hci_register_subevent for LE Meta events
Date: Fri,  1 May 2026 10:38:47 -0400
Message-ID: <20260501143847.724150-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260501143847.724150-1-luiz.dentz@gmail.com>
References: <20260501143847.724150-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Convert all bt_hci_register(BT_HCI_EVT_LE_META_EVENT) calls to use
bt_hci_register_subevent with the specific subevent code. Update
callbacks to work with data that no longer contains the subevent byte
prefix, since bt_hci_register_subevent strips it before dispatch.

Assisted-by: Claude:claude-opus-4.6
---
 tools/hci-tester.c | 59 +++++++++++++---------------------------------
 1 file changed, 17 insertions(+), 42 deletions(-)

diff --git a/tools/hci-tester.c b/tools/hci-tester.c
index 79193220feec..b8446ee83ccf 100644
--- a/tools/hci-tester.c
+++ b/tools/hci-tester.c
@@ -407,17 +407,9 @@ static void test_le_rand(const void *test_data)
 static void test_le_read_local_pk_complete(const void *data, uint8_t size,
 								void *user_data)
 {
-	const uint8_t *event = data;
-	const struct bt_hci_evt_le_read_local_pk256_complete *evt;
+	const struct bt_hci_evt_le_read_local_pk256_complete *evt = data;
 	struct le_keys *keys = user_data;
 
-	if (*event != BT_HCI_EVT_LE_READ_LOCAL_PK256_COMPLETE) {
-		tester_warn("Failed Read Local PK256 command");
-		tester_test_failed();
-		return;
-	}
-
-	evt = (void *)(event + 1);
 	if (evt->status) {
 		tester_warn("HCI Read Local PK complete failed (0x%02x)",
 								evt->status);
@@ -450,7 +442,8 @@ static void test_le_read_local_pk(const void *test_data)
 	struct bt_hci_cmd_set_event_mask sem;
 	struct bt_hci_cmd_le_set_event_mask lsem;
 
-	bt_hci_register(user->hci_ut, BT_HCI_EVT_LE_META_EVENT,
+	bt_hci_register_subevent(user->hci_ut,
+				BT_HCI_EVT_LE_READ_LOCAL_PK256_COMPLETE,
 				test_le_read_local_pk_complete,
 				(void *)test_data, NULL);
 
@@ -480,17 +473,9 @@ static void test_le_read_local_pk(const void *test_data)
 static void setup_le_read_local_pk_complete(const void *data, uint8_t size,
 								void *user_data)
 {
-	const uint8_t *event = data;
-	const struct bt_hci_evt_le_read_local_pk256_complete *evt;
+	const struct bt_hci_evt_le_read_local_pk256_complete *evt = data;
 	struct le_keys *keys = user_data;
 
-	if (*event != BT_HCI_EVT_LE_READ_LOCAL_PK256_COMPLETE) {
-		tester_warn("Failed Read Local PK256 command");
-		tester_setup_failed();
-		return;
-	}
-
-	evt = (void *)(event + 1);
 	if (evt->status) {
 		tester_warn("HCI Read Local PK complete failed (0x%02x)",
 								evt->status);
@@ -523,7 +508,8 @@ static void setup_le_generate_dhkey(const void *test_data)
 	struct bt_hci_cmd_set_event_mask sem;
 	struct bt_hci_cmd_le_set_event_mask lsem;
 
-	bt_hci_register(user->hci_ut, BT_HCI_EVT_LE_META_EVENT,
+	bt_hci_register_subevent(user->hci_ut,
+				BT_HCI_EVT_LE_READ_LOCAL_PK256_COMPLETE,
 				setup_le_read_local_pk_complete,
 				(void *)test_data, NULL);
 
@@ -554,18 +540,10 @@ static void setup_le_generate_dhkey(const void *test_data)
 static void test_le_generate_dhkey_complete(const void *data, uint8_t size,
 								void *user_data)
 {
-	const uint8_t *event = data;
-	const struct bt_hci_evt_le_generate_dhkey_complete *evt;
+	const struct bt_hci_evt_le_generate_dhkey_complete *evt = data;
 	struct le_keys *keys = user_data;
 	uint8_t dhkey[32];
 
-	if (*event != BT_HCI_EVT_LE_GENERATE_DHKEY_COMPLETE) {
-		tester_warn("Failed DHKey generation command");
-		tester_test_failed();
-		return;
-	}
-
-	evt = (void *)(event + 1);
 	if (evt->status) {
 		tester_warn("HCI Generate DHKey complete failed (0x%02x)",
 								evt->status);
@@ -613,10 +591,11 @@ static void test_le_generate_dhkey(const void *test_data)
 
 	ecc_make_key(cmd.remote_pk256, keys->remote_sk);
 
-	/* Unregister handler for META event */
-	bt_hci_unregister(user->hci_ut, 1);
+	/* Unregister handler for PK256 subevent */
+	bt_hci_unregister_subevent(user->hci_ut, 1);
 
-	bt_hci_register(user->hci_ut, BT_HCI_EVT_LE_META_EVENT,
+	bt_hci_register_subevent(user->hci_ut,
+				BT_HCI_EVT_LE_GENERATE_DHKEY_COMPLETE,
 				test_le_generate_dhkey_complete, keys,
 				NULL);
 
@@ -830,15 +809,10 @@ static void teardown_connection(const void *test_data)
 static void test_adv_report(const void *data, uint8_t size, void *user_data)
 {
 	struct user_data *user = tester_get_data();
-	uint8_t subevent = *((uint8_t *) data);
-	const struct bt_hci_evt_le_adv_report *lar = data + 1;
+	const struct bt_hci_evt_le_adv_report *lar = data;
 
-	switch (subevent) {
-	case BT_HCI_EVT_LE_ADV_REPORT:
-		if (!memcmp(lar->addr, user->bdaddr_ut, 6))
-			tester_setup_complete();
-		break;
-	}
+	if (!memcmp(lar->addr, user->bdaddr_ut, 6))
+		tester_setup_complete();
 }
 
 static void setup_advertising_initiated(const void *test_data)
@@ -850,8 +824,9 @@ static void setup_advertising_initiated(const void *test_data)
 	struct bt_hci_cmd_le_set_adv_parameters lsap;
 	struct bt_hci_cmd_le_set_adv_enable lsae;
 
-	bt_hci_register(user->hci_lt, BT_HCI_EVT_LE_META_EVENT,
-					test_adv_report, NULL, NULL);
+	bt_hci_register_subevent(user->hci_lt,
+				BT_HCI_EVT_LE_ADV_REPORT,
+				test_adv_report, NULL, NULL);
 
 	memset(sem.mask, 0, 8);
 	sem.mask[1] |= 0x20;	/* Command Complete */
-- 
2.53.0

