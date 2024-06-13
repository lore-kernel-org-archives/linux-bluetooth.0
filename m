Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DB1145B26
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jun 2024 17:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718298198; cv=none; b=N13fL8/NYT1wV2wnjOUqvRIWYLJR68W7bDQFwca9lweuWR+PI8wDN2uzCauTlJxAa2MFFb2Zddreb+nzw7m2Q4BCHhW1pu0YxMBQ1eVu1zl38NFAt2H5MJzLYTp9p+061LNb4HRPdpYWN2IQVZM+9PQ0M9beF1UON7yAqa7xY8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718298198; c=relaxed/simple;
	bh=D2mZPYd6QGmiCunRi8u+dVq08lprYnpCkGEGI9yAIis=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YtZS9WWSV6+PNubH5FoKaqLQnrJHqV4WV1Gk1tOCUtDtTtONkrMVbuMhP3a35q5qAWaPbWy4yMTNFOGQPGyLfW+FkJJxni5FnBZEe/tbQCWGlOrvpC4euvfTcT9HyKZQhAfEiT/eIzDgcE5xf2qB7oU5gzzv2rWkXsty7dCEqZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViBR3sRg; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViBR3sRg"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-48c3402e658so474866137.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jun 2024 10:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718298195; x=1718902995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EGJ/3A8bOUmJ4auKYmUMV2ZxXAA6tDO2TrpE5KSs+fw=;
        b=ViBR3sRgNVL4tS00/dKlvv1PNqppd5GRx81L0Hl8Hv2r5HqNPVMbtlgjbUREZp/3Gz
         qQXVtOZ2QFs6ICOYDoEHhT7Qnfxo72R7CssNUlnom5Dm6KpR1m7n1dF8flmtH0YhZJ+u
         fqobbqmMo0r2OGX1JpFqGbpezzeiYZO+nbXl+TSf3J8Q3ON9JxDYpW6raCJ64Wd1aDMq
         BrkrNqwKVIpDBbHbo7K3EaioWKE2ozL/OLhhN5nEUOcNqI6n9ptdimem3kOMSyxNkQsk
         sU21ga13arEStbUEHaHyHHuSww9akQlATPmcwQ4KE+bBTjdMgmpxgpNxQPlvdMbrVl1X
         rIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718298195; x=1718902995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EGJ/3A8bOUmJ4auKYmUMV2ZxXAA6tDO2TrpE5KSs+fw=;
        b=cIN1hhNFFEv0GWcCrFSNwW3tnQatBsxZxNn0q1X8ZcKPe5jJg9xJWJ3JWeC+/GSSVW
         hK/CYBFhknETKfdIkjcHkaZyDifcyLMWRb8QwnbCh7LFAHSWk/u4hII6EDFdJ4I5lEZ5
         MIC/cfgy9p6+CKjs52VcVt7cuP5n1Sqv/8s1p1kOJOz52+sv5Z0O7ySR2tfOz5aeCMj0
         YilSo8n4bgifZiGyjfJUWA9ZKSh4voAH38+uQRo9KisfpKreefKd3u2Sa7KmxcBcHA53
         h1tnOYQM3Zuqkix9akqtW3kNJwyt3+RaxPE+BdGQDEdXJEMGUXSmSVzHu35Z26Fj7Fe7
         FglA==
X-Gm-Message-State: AOJu0YzB2nV+Iy2Kzgvz7DK7t9sC+82MGoTJ0Y1OKGgT4buLbqa948TA
	MPyqvf3RNZMsHabOOPxOEZG5RnDSQb5UB+SPmLLyVwaKsZzmBJyQCD8Iiw==
X-Google-Smtp-Source: AGHT+IFxeiz5kJAgBiH4a2rYes9WAMFmUQzjdUA4rI/xzQR9Ekka8SOlnIVe9l2MKj6jApeeUaaEew==
X-Received: by 2002:a67:e3b2:0:b0:48d:7126:e27e with SMTP id ada2fe7eead31-48dae3ee3e6mr182612137.33.1718298195259;
        Thu, 13 Jun 2024 10:03:15 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-48da43ff4f3sm302855137.18.2024.06.13.10.03.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 10:03:14 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] device: Fix marking device as temporary
Date: Thu, 13 Jun 2024 13:03:13 -0400
Message-ID: <20240613170313.1596181-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If bonding has failed but there are other bearers connected don't mark
the device as temporary.

Fixes: https://github.com/bluez/bluez/issues/856
---
 src/device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 5dc1cd0cdbf2..486ffdb4ea8d 100644
--- a/src/device.c
+++ b/src/device.c
@@ -6428,7 +6428,8 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 		/* Put the device back to the temporary state so that it will be
 		 * treated as a newly discovered device.
 		 */
-		if (!device_is_paired(device, bdaddr_type) &&
+		if (!btd_device_bearer_is_connected(device) &&
+				!device_is_paired(device, bdaddr_type) &&
 				!btd_device_is_trusted(device))
 			btd_device_set_temporary(device, true);
 
-- 
2.45.2

