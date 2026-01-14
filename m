Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8314B3A7E1A
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jan 2026 21:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768427416; cv=none; b=cnAEEpPXf8l4xJKnkqX/2xXP8W+xRb+ghwXVJleoL17xPzEAkR/ZYgk0IBxtzVRUA5QX6LX8m4wi1Ce/O5hqCioVt1D1w3JvVRRclXAK7PFZYvDufoO9t1w5epXHkZvT3n+DkPjWjsFRkfH9vzv7pQLIoRK38BIuvsvSHTcDY+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768427416; c=relaxed/simple;
	bh=zk342nU0Srqwai0A4BL9Mu9iumNQx2oCOYA66Py0Wxw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SbHI5W/LI4TYuAeiPaJUqlPl/k9AhX/AWBdFCAo0EBgJn0LCf0W8AORXkHXs3a56I5YOf+a+cC5Ks+ypAigHinQ0XECpx6XVYyk4+yp4IWZN+uTJHi5YFBNJrjSflm4poMCjhyJ3MY+41bWiH6NKTXgFbc7b9EJmInUuz/Ki7F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCfYOorM; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCfYOorM"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5ec8781f5c9so137885137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jan 2026 13:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768427392; x=1769032192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u4HHP6HjEr3Gekv5bQetD7gP4Pde3d88NSmEPM4ATGU=;
        b=lCfYOorMgTtIlQALHSabMA0lYgT7g9MN9avg81lv4P+dyDk10/JVjoyTmYMrKGDRml
         p6TZmBu+ZXEYdTNic6WrLTLCKYzBH5Skk5SedWMzjBn+FfoolKLgp2Nrt2RFU75Lf54+
         2jTtZhtPO+v6tzGJGOJZ/1zJIlPGDFbWfUAoBfXk0TMWLkWuAnWuohEBbfPFUwLYWJG2
         O++WLjKHTA59fc49VNT0wDjUzhgysnWwc8YrClodon8iV+0gpacZNga5HxaLqq3FovgT
         1jC4psBVrXCgmWPGJBIHgocwS2IDhUJ1stab04mEdHHt9a20rtv0ATLjg71pfkWAACN4
         ZNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768427392; x=1769032192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u4HHP6HjEr3Gekv5bQetD7gP4Pde3d88NSmEPM4ATGU=;
        b=Io9n53M5V1mLtZCz4ZiFtRCSoP0cY5obT3/QND+RgiY/dn6VOvCzBZqS8MsbDkCw8+
         lZE71mB6PlAtd64VR/pEaBbiQg5MZ/RZq9YpF0BSJdyf/NS+qYGndayf3J2j+bhmOka4
         zVUnzWbX5/seMb1ZQi90+JxeCrWkxeJqoyq5b5Oq9Aw7hKzP6ds8D4OHdSuU9y4t9c+v
         dH/BFbu5lEZVB3Gm/miRecG8iVomGQylKqfZDQxa2BeSVhjjUxPcphUB4sOCe05zwDnt
         prtI7oibBohpkKgwWDChxfhsNVqTUxxeS4PDDWJLYet164CTF1zl44EAbynPnmxQqMJk
         FHdA==
X-Gm-Message-State: AOJu0YxPuZFq/QUxNpDJxrUpvOVcihHEKUWYf0EKs1Q6SZidtGZRoP1i
	rTAaXJhI/nnijpaQaVjLWG3JTMxX8QjqrZpye6Di597muts9AoAFZjYr04xuuQ==
X-Gm-Gg: AY/fxX5+9xkCROL0oZ6OUNkac++ONOA9b+GjnqFGciaXQiXZPByEKQjmjcvuIL3Dsd9
	wDd9m3YB9OAbp+neXvcfz6Z8NVGeZPHi1jKUzyhUvqT+zwSWgEi9mdUZ7NAsEQhlojHmvYfQOqi
	aYFw+oA4hdqfVXkb5Q8E9gw47+OMN1KiEUwhHetDGFat8jrUqnMV//Uivps8pCF5Rf5AcuwOvDa
	Z73wEoQXW2O4y+buIL00CTwMgM4I+zzD0DIyv17YPrSWX+NTTReL05QDPCU1hc6WhukAG9nAQmU
	2flGKTAXkZJ7o4LyzSJxsBHqoGyLBtpqd8efmYsq7aikNBk/v0wDmqpyml+2JeOFrWde4A8wzj3
	FINhoEaJY6vKqcAHzY56+qmYkjHnRc79yqQBqDSVDWeA8Y2GLXL5kKUvJV5xO43xZrlm/FBD4CZ
	INQFi8WsuvN4xyUmJaqX8yqCexnXp5aHoQPYn1/bJD5T+AybZD/V8sny7jKgXleolsWnzJ7tlVM
	IzK/w==
X-Received: by 2002:a05:6102:50a0:b0:5ee:a590:6b11 with SMTP id ada2fe7eead31-5f183bdcd49mr1571440137.36.1768427392341;
        Wed, 14 Jan 2026 13:49:52 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ec772af325sm24985649137.10.2026.01.14.13.49.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 13:49:51 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 5/6] advertising: Fix not verifying if RSI set is valid
Date: Wed, 14 Jan 2026 16:49:36 -0500
Message-ID: <20260114214938.1417430-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114214938.1417430-1-luiz.dentz@gmail.com>
References: <20260114214938.1417430-1-luiz.dentz@gmail.com>
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

