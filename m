Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928E0321D
	for <linux-bluetooth@vger.kernel.org>; Sun, 25 Aug 2024 20:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724619589; cv=none; b=P1R7bZd8fLP6dyb52+SSxBzSqbpMPplrGWe8ziBHIBu6zU2nVsq9bemNZj8ro6m0U4fj5lqhyTAXgVwMtCf4XwCr+sy5R2l2Kt7QqVyYN8xXmHJUvlIeaenDury9dFgbdETulN6oy7x6+RZiAuDxbbkB9OBGu5iASQ7Q8A4nHO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724619589; c=relaxed/simple;
	bh=yzRM8ubRIcfHEW/ijBjMyxMJQL0lF78Sxw4lfUrKPjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jU+XuWqD+exIhcpKuC0R0hZ4GlNX9rseAfbzoadHBvj/l9UIahaUhJUBgH5w1kHvui7wn5JL2EUn5Jkvi+490EgHvRTfSCy6np8seZkvTmGvspqV85XCTSltYMxlJp2aBMhAC1vxoUJkQiXiM8OCcIgSa+tTBZmhP3934TJxRXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ento0ZPW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ento0ZPW"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4281ca54fd3so32171465e9.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Aug 2024 13:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724619586; x=1725224386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8LAm/gcFco20+OvhIAZ3H5uHjdGcjGlEUIongsqcqi0=;
        b=ento0ZPWK0QfREfIaObbxxusTqirTA/19iWIqPPfS0Rvj0nbC7rOi7ILsthe8F706K
         JDBuTUJsGezQCmPScdo5W71HqxgxUNi9JGJF7WATqrwNpTdh0aWJgrPHZ8p7bVyWbhST
         GjRWeY8irb+4C0OKlZazzrhgEA2HCTw4InWBwQhOEbaJhFT3QJXUAl66QYGBMcITVybG
         fIIb1UUz2HKQKnvrRaXHzNOU6EgAehR6pkroUelCYE/3ousRYofFE5it4DzxL0a/I8bQ
         iUatq06dWSQXQXjz0/2gga6+X5BIju4r9VG5nhcnFrE46lbamlhgv0Z2eMkTbEaUWr88
         8VPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724619586; x=1725224386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8LAm/gcFco20+OvhIAZ3H5uHjdGcjGlEUIongsqcqi0=;
        b=uTff7zXFZAo39c+vDp3DUCBvcdaSEQYmlaBHb5W3meXp3g4jhiRjemU11dwLNVO8jb
         1TGMET80apIUPDoOKKpV7x2hQ/QDqaAkooxU7oyJoBQSVdFU+GpWUHqrUdSh1d/M64KW
         vCSa0RvE/3hzoZDWB3ltHKDekFgBdbd3T8EpOkBY/sm+lj5xb3RvamrgUyajEzEvPkKl
         voRb4I2HFidKS5lKGT0g6MSpJsh3vMPljYmiTvDiIiqHNeEMFU48HDfPr33GWQ68q8Tg
         lk9DOksj/kXI2MLUb+gDt3qH28f1uSmrgIUs7/jPUrF3NJQhkeZ7knUz4gzzzH1UjgoT
         3P5Q==
X-Gm-Message-State: AOJu0YzP2bPqHsQkrQeEZ6VhLj1mZlTAyJvxFBL3L797HVGiFsVPXevq
	Ob5bmXpLoZFEPAQ+Ezi69G54jDRda8qlwjUiy2J4Ij6FEOyo9VlKOr/hGQ==
X-Google-Smtp-Source: AGHT+IEpLe9ibfBFGo+4SRpxAYWw8wDQvHt9xhxqvt/eQqrn4prdl1Edi/waXQp5j+js9Dbrs9aEMg==
X-Received: by 2002:adf:f00a:0:b0:366:eeda:c32d with SMTP id ffacd0b85a97d-373118683fcmr4957351f8f.31.1724619585355;
        Sun, 25 Aug 2024 13:59:45 -0700 (PDT)
Received: from x1cx.uhrm.ch ([2a02:168:4f3f:7:4b00:1bb0:11f:418d])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42abed922b4sm169263975e9.11.2024.08.25.13.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 13:59:44 -0700 (PDT)
From: Markus Uhr <uhrmar@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Markus Uhr <uhrmar@gmail.com>
Subject: [PATCH v2] Add pattern matching for service UUIDs
Date: Sun, 25 Aug 2024 22:58:17 +0200
Message-ID: <20240825205817.70066-1-uhrmar@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit extends the pattern matching capabilities of advertisement
monitors with matching for service UUIDs. This functionality was lost
with bc2ab4b (see #652) and not added with b0656c2.
---
 src/shared/ad.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/src/shared/ad.c b/src/shared/ad.c
index d08ce7af9..53c4628b6 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -1362,6 +1362,46 @@ static bool match_manufacturer(const void *data, const void *user_data)
 	return false;
 }
 
+static bool match_uuid(const void *data, const void *user_data)
+{
+	const bt_uuid_t *uuid = data;
+	const struct pattern_match_info *info = user_data;
+	const struct bt_ad_pattern *pattern;
+
+	if (!uuid || !info)
+		return false;
+
+	if (info->matched_pattern)
+		return false;
+
+	pattern = info->current_pattern;
+
+	if (!pattern)
+		return false;
+
+	switch (pattern->type) {
+	case BT_AD_UUID16_ALL:
+	case BT_AD_UUID16_SOME:
+		if (pattern->offset != 0 || pattern->len != sizeof(uint16_t))
+			return false;
+		break;
+	case BT_AD_UUID32_ALL:
+	case BT_AD_UUID32_SOME:
+		if (pattern->offset != 0 || pattern->len != sizeof(uint32_t))
+			return false;
+		break;
+	case BT_AD_UUID128_ALL:
+	case BT_AD_UUID128_SOME:
+		if (pattern->offset != 0 || pattern->len != sizeof(uint128_t))
+			return false;
+		break;
+	default:
+		return false;
+	}
+
+	return !memcmp(&uuid->value, pattern->data, pattern->len);
+}
+
 static bool match_service(const void *data, const void *user_data)
 {
 	const struct bt_ad_service_data *service_data = data;
@@ -1451,6 +1491,14 @@ static void pattern_match(void *data, void *user_data)
 		matched = queue_find(ad->manufacturer_data, match_manufacturer,
 				user_data);
 		break;
+	case BT_AD_UUID16_ALL:
+	case BT_AD_UUID16_SOME:
+	case BT_AD_UUID32_ALL:
+	case BT_AD_UUID32_SOME:
+	case BT_AD_UUID128_ALL:
+	case BT_AD_UUID128_SOME:
+		matched = queue_find(ad->service_uuids, match_uuid, user_data);
+		break;
 	case BT_AD_SERVICE_DATA16:
 	case BT_AD_SERVICE_DATA32:
 	case BT_AD_SERVICE_DATA128:
-- 
2.46.0

