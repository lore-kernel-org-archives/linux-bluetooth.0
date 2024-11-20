Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3D917BB2E
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 13:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732107842; cv=none; b=DyizEIA29srDaIHdNuqNrHbV889GZUM/LSYolSWsvu9N0caJEriya6us620XOUHMhCeRa5HmHA3jej4PpubGLoDlUGlpVI/S6jvFCljvp8BjN9zepaaAkKBJdQT77TzXGWkEgOyfaIlZ50JcLNbudYBK4k75f7sdzAybq4q0cPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732107842; c=relaxed/simple;
	bh=mak+A+UCnbQSrBqnPtNGoSGFLcO10UatjdgO0YGOOYo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hD7giVCDQ0OdLZ+A5wywMXB3s5LOcxvKB6SeyAGNofeJY4hNIllWXBwOwhqlbTEq9ToKi5jF0DhY9MLTxmn/6aQT9885AIjnWk6eh6jXQvVAVl6a0mpcrHoKVSZ1wCKjxMMOgE94InCJ6uFneW6VbnJpK0/+VhNKOvQM3Rox01o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heitbaum.com; spf=pass smtp.mailfrom=heitbaum.com; dkim=pass (1024-bit key) header.d=heitbaum.com header.i=@heitbaum.com header.b=Xi3N8fMc; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=heitbaum.com header.i=@heitbaum.com header.b="Xi3N8fMc"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e467c3996so1641645b3a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 05:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1732107839; x=1732712639; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ss4rx2ga9Da9cMM+WmX/irbZfx5a7FwYVBVZk3F9viU=;
        b=Xi3N8fMchd4YoK7K0SVMWmjn5mjFOgsr59m+P3gyQ91K0to1SaI2JD03EZpBZY0y7z
         nUHgU5aG7L4h8APAR2Ai4UyfSSdk8xnst47w7KOEhSc7L3Hq4YJLSMItCFitPkjeGm+S
         gLciUXvh76YnN+P0acPx3Ck1samivRxpifpYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732107839; x=1732712639;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ss4rx2ga9Da9cMM+WmX/irbZfx5a7FwYVBVZk3F9viU=;
        b=lyuPisUA1sxdj4BlBUTXnzRWVfLUmvfWSQrbPJXY1qxQywtODQHzbC5VDpGy7YscdP
         1vzpCjNdNtTKrHYkr7KSSvUBmd161Se4PSXKxqT48yG6MmyOcjzTgVlCKo57KFEK9Hl7
         oYYdAmbtq0pDdSrhHLTwk6AecFpMK20KHcnNmd0AccgThOnETH177x7qbvhFnO26ovtm
         ms8+ZDUjQZfGFUOw3uatdxYiBloRJUUuhohgSl+3CAmxXVtvnzj4kLes9vZoiZmMTH2l
         oY6ZIg0AiMNtbxm1hWAD8qkhqn9d3hZiEGwt8FNb8rkd6eq/o6by2wUVjwuxQQS5sJlo
         cQeg==
X-Gm-Message-State: AOJu0YzNKDgFKOJBI7B1FPek6W0kE3nBQDx5aWk7CBamC2bC/DrZ8TF8
	qMOdzM4dHOFlEFn6rEHpIz5/zQHkdUcDdVNnYs8tMMHJ6fSQtyrqTjtOJiuYBOihvLFw+8OGLHM
	h
X-Google-Smtp-Source: AGHT+IF+ttl3LGKjZWjiSm9AEoP9p0vrOCpwJ/0fh7Lmwovrr3lagejFRBJPCTWmSI21ZVC7AFf3/w==
X-Received: by 2002:a17:90b:2d0b:b0:2ea:8c5c:ff63 with SMTP id 98e67ed59e1d1-2eaca7cecc2mr3084565a91.29.1732107839623;
        Wed, 20 Nov 2024 05:03:59 -0800 (PST)
Received: from c8d99ad60702 ([122.199.11.121])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead04d2b68sm1235902a91.39.2024.11.20.05.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 05:03:59 -0800 (PST)
Date: Wed, 20 Nov 2024 13:03:55 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: linux-bluetooth@vger.kernel.org
Cc: rudi@heitbaum.com
Subject: [PATCH 3/3] shared/gatt-helpers: fix -std=c23 build failure
Message-ID: <Zz3eO4higrwPKjG_@c8d99ad60702>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

gcc-15 switched to -std=c23 by default:

    https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=55e3bd376b2214e200fa76d12b67ff259b06c212

As a result `bluez` fails the build as:

    src/shared/gatt-helpers.c:1136:24: error: incompatible types when returning type '_Bool' but 'struct bt_gatt_request *' was expected
     1136 |                 return false;
          |                        ^~~~~
    src/shared/gatt-helpers.c:1250:24: error: incompatible types when returning type '_Bool' but 'struct bt_gatt_request *' was expected
     1250 |                 return false;
          |                        ^~~~~
    src/shared/gatt-helpers.c:1478:24: error: incompatible types when returning type '_Bool' but 'struct bt_gatt_request *' was expected
     1478 |                 return false;
          |                        ^~~~~

Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
---
 src/shared/gatt-helpers.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index 50fcb269b..f1fa6300a 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -1133,7 +1133,7 @@ struct bt_gatt_request *bt_gatt_discover_included_services(struct bt_att *att,
 	uint8_t pdu[6];
 
 	if (!att)
-		return false;
+		return NULL;
 
 	op = new0(struct bt_gatt_request, 1);
 	op->att = att;
@@ -1247,7 +1247,7 @@ struct bt_gatt_request *bt_gatt_discover_characteristics(struct bt_att *att,
 	uint8_t pdu[6];
 
 	if (!att)
-		return false;
+		return NULL;
 
 	op = new0(struct bt_gatt_request, 1);
 	op->att = att;
@@ -1475,7 +1475,7 @@ struct bt_gatt_request *bt_gatt_discover_descriptors(struct bt_att *att,
 	uint8_t pdu[4];
 
 	if (!att)
-		return false;
+		return NULL;
 
 	op = new0(struct bt_gatt_request, 1);
 	op->att = att;
-- 
2.43.0

