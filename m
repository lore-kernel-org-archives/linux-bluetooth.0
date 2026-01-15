Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B6A30C62B
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 20:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768510465; cv=none; b=nDYfbE3vd5trxbi6ZMnXlLkKZhjt7C7yHxdThcJqywx6P6uK0F8I93XUrTNqBJJC+0c1GNEnTLIlsr3h+dT/pp1m/R+i5mTDV79bMJs6QmE47pWCVA7eVl9K5CEwp7mBbXKXX35+KW9qYmfmNFk/v/YGyrxj2vuEEd6nRuiFRao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768510465; c=relaxed/simple;
	bh=zk342nU0Srqwai0A4BL9Mu9iumNQx2oCOYA66Py0Wxw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WdEPwYWwLN/s0BiTQjlpR/VTxN/wbzcYI4H10pcC22QcOuChwTayoK5o2SbcEHBF/acezbu8QlsZG4S7gM05q7Pg0RmsHXBrPQRVkGbr4HZmq/3gflH62vSp4P9O4w/gK/omfhKB5oGYnTszbiFP7UL5qnWebTkjJdqVCZjKq4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBcxhBCn; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBcxhBCn"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5636784883bso1140199e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 12:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768510463; x=1769115263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u4HHP6HjEr3Gekv5bQetD7gP4Pde3d88NSmEPM4ATGU=;
        b=IBcxhBCnfZQNxXGIijt5I5aeO50QBq6R8zhD8lkpIJnec7d9aiWkMtocauy1qBWlpy
         xPmoU70J23PJampjlSzZmvuN0Yy6Twv46i4kbx7oidqsAidg4kG8JZF34i/U1drPttfW
         8feSeFJNUTbF+3MdGwCJpi097YbOJu6I4v/88YSZmlhgU5iGYhjvowDC5CjHwz39ioml
         pVDsqWczkyvKn39AfoblhiTYNc0joP4xiq31moSVN1ujMur2cFs5JRpzr3nDIfWIUsYG
         YbdkQrHyUSzohqymFT0EtgG1/vrCzthFDcKI6R8BlVYYetHEqFPhLY25x9MCPZYpDKKX
         el5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768510463; x=1769115263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u4HHP6HjEr3Gekv5bQetD7gP4Pde3d88NSmEPM4ATGU=;
        b=tzhj2481TEJiU0TvansxWFMV0nEKd3GQgBhVum1OPfDkr5zYqGJqM5p+zDx1txiyxM
         Z+h65Sct5Lo7ICmVDK130AtDPeiGSR6VNYu/FlcGJ3U1xk87ugXH0xSQeCwRSkPd68bc
         9hMhejCXznBYRyu2xFE9Qzf1FYkTnGWXfNaCYniV8fMh7rgfebC/7JCxZaP87k92iYfF
         9Kqk8FWH4CE9fo/57xsZtomVsdwj/2h37xCJVmCmryjpr0JdJs7cyY3BQq2y4z5p7/0O
         +4bgXKAXQBLabmS53HhjKwAu80tm5LVhaR7LLhnm1zIrD3Z4g+hPv3Fl4/ECvXt/4b1D
         g92w==
X-Gm-Message-State: AOJu0YyZjr+44MSK+aRIvqFqYqC4Fy3wKg7G1SYgaMAn55LJuTXPOkZJ
	brBtfQwxpiDtYnEy1f/Mjm2cxm4HUbRVO5uhnbktoPpf9ChxPYXguQ670z8bMYwz
X-Gm-Gg: AY/fxX4L8VQA/zVfj2tEtsvA85T+iuqlj/i9s2jMaeXooTdMoKs86rnlbATDzLQqxVh
	acwOo8LHdv/hidGlxVIyKXxbzy1PeTnsCM3jML+STzhj+ax9+ihTVpfBed9MSEvFsJfJAdQiw/x
	l9zrmLrQSFN4rAQL7VgLKaC3slxfm7sb9BKDZH/SdbWhN8SqIdjjwj/qi7Q+JXZ8/uGio+59sfV
	Z8txsSXnCZgaOCFMzLV3VMK6yZTi9zHdkHz5wbOW1BrCjEXZBlpXSoMO3Gi0k89tX4E2SKZWG1c
	8PY2Sq8nRC+mmqb/RID9RJxX9ryRidj1iosLlEANiISAaaFuPKjqz2vmWe+TcfO4ntv9FM2qcot
	UW/l4+jMBmO9FTC6lvxJ0tKM942rRkNsQWX/RPWAXFOlsMN9zN2TfDSSOHpDqLak8h2xXj6uubP
	ehv0+wDOV/jd1V6h4S1pYlfNgBahAKqMXjKG/u0UwDhOn7HMfpKGg3TJ40SjRrfLRXcClZMgI95
	k0ibZB6h/vTWrHM
X-Received: by 2002:a05:6122:459e:b0:563:687f:360c with SMTP id 71dfb90a1353d-563b719252bmr187011e0c.0.1768510462732;
        Thu, 15 Jan 2026 12:54:22 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-563b6ffda3csm167159e0c.7.2026.01.15.12.54.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 12:54:22 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 5/6] advertising: Fix not verifying if RSI set is valid
Date: Thu, 15 Jan 2026 15:54:06 -0500
Message-ID: <20260115205408.1554101-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115205408.1554101-1-luiz.dentz@gmail.com>
References: <20260115205408.1554101-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The hash portion of the RSI can be verified if it was set properly.
---
 src/advertising.c | 69 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 61 insertions(+), 8 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index 5dc33c004f93..0543870eea02 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -506,11 +506,52 @@ static bool parse_service_data_sr(DBusMessageIter *iter,
 	return parse_service_data(iter, client->scan);
 }
 
+static bool validate_rsi(const uint8_t *data, uint8_t len)
+{
+	struct bt_crypto *crypto;
+	uint8_t zero[16] = {};
+	uint8_t hash[3];
+	bool ret;
+
+	if (!data || len != 6)
+		return false;
+
+	/* Check if a valid SIRK has been set */
+	if (!memcmp(btd_opts.csis.sirk, zero, sizeof(zero)))
+		return false;
+
+	crypto = bt_crypto_new();
+	if (!crypto)
+		return false;
+
+	/* Generate a hash using SIRK and prand as input */
+	ret = bt_crypto_sih(crypto, btd_opts.csis.sirk, data + 3, hash);
+	if (!ret)
+		goto done;
+
+	/* Check if hash matches  */
+	ret = !(memcmp(hash, data, 3));
+	if (!ret) {
+		error("RSI set invalid: hash mismatch");
+		printf("Random: %02x%02x%02x\n", data[3], data[4], data[5]);
+		printf("Hash:   %02x%02x%02x\n", data[0], data[1], data[2]);
+		printf("Match:   %02x%02x%02x\n", hash[0], hash[1], hash[2]);
+		goto done;
+	}
+
+	DBG("RSI validated");
+
+done:
+	bt_crypto_unref(crypto);
+	return ret;
+}
+
 static bool set_rsi(struct btd_adv_client *client)
 {
 	struct bt_crypto *crypto;
 	uint8_t zero[16] = {};
 	struct bt_ad_data rsi = { .type = BT_AD_CSIP_RSI };
+	struct bt_ad_data *ad;
 	uint8_t data[6];
 	bool ret;
 
@@ -518,23 +559,28 @@ static bool set_rsi(struct btd_adv_client *client)
 	if (!memcmp(btd_opts.csis.sirk, zero, sizeof(zero)))
 		return false;
 
-	/* Check if RSI needs to be set or data already contains RSI data */
-	if (!client || bt_ad_has_data(client->data, &rsi))
+	if (!client)
 		return true;
 
+	/* Check if RSI needs to be set or data already contains RSI data */
+	ad = bt_ad_has_data(client->data, &rsi);
+	if (ad) {
+		ret = validate_rsi(ad->data, ad->len);
+		return ret;
+	}
+
 	crypto = bt_crypto_new();
 	if (!crypto)
 		return false;
 
 	ret = bt_crypto_rsi(crypto, btd_opts.csis.sirk, data);
-	if (!ret)
-		goto done;
 
-	ret = bt_ad_add_data(client->data, BT_AD_CSIP_RSI, data, sizeof(data));
-
-done:
 	bt_crypto_unref(crypto);
-	return ret;
+
+	if (!ret)
+		return ret;
+
+	return bt_ad_add_data(client->data, BT_AD_CSIP_RSI, data, sizeof(data));
 }
 
 static struct adv_include {
@@ -753,6 +799,13 @@ static bool parse_data(DBusMessageIter *iter, struct bt_ad *ad)
 
 		DBG("Adding Data for type 0x%02x len %u", type, len);
 
+		switch (type) {
+		case BT_AD_CSIP_RSI:
+			if (!validate_rsi(data, len))
+				goto fail;
+			break;
+		}
+
 		if (!bt_ad_add_data(ad, type, data, len))
 			goto fail;
 
-- 
2.52.0

