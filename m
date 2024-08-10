Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199E5200A3;
	Sat, 10 Aug 2024 14:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723299263; cv=none; b=QFAAw9Tkda8/qTTw/wRKk5vaaNrt2I+caMYF9QEJs0SKZMCDw76N2y0VihJ3jp6fEN9mSemts0I8iBdfH7tKPo+mwMW1+z4gIEUkD+Cj7pkftfcZz2qjUgUWr8nNuvmrz/ES54j2fwsLLd4i2x8hOlv+vpD8U9t54TZqx/X6LP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723299263; c=relaxed/simple;
	bh=xB94tenxHo5MzGvjAnLNtLzWSr66es7r61w9U+9iJsw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T/j/6cLHBgmMpqYVb6BeunBYY+JhWCR4+9pj5d7sEm20kotBfCKFO44bdDiLtsVbiQTxaHqWu5vAZmqJwW1uZ9iXn7YWECKlJKonMzQ0hipvtYXOhT4X4+NQoA0g2DMQ8c9AYis2046UFz4C4Se5w2KPom7bHkrVeNg16sjcGn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkaHQc6H; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkaHQc6H"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2cd16900ec5so547437a91.3;
        Sat, 10 Aug 2024 07:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723299261; x=1723904061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pr7g5yqDwE9a5NUp1QK9GoWcWHPRwH1JMXCEiNFE2LY=;
        b=SkaHQc6Hh2emmmtla1uANIxtXGAMz6apd2JGF5yaWqa7n0ugDPUseRbmI81c7LUgx7
         vsaJAqbfGzqQU1Zpaijn/g5bClxcmKD7t2gnRFXYkHyzZ0rfA+TbmRHTad0gEtLMZjHM
         ACe3LFFoFhBakQ0IzxAJ8uoKba4xLjJYBzSkd1uFGjetAfWSbrF6UpI89N3efzmBRber
         dPGjTWqFbqoWWoi6PEmQ1RgdQSg1BuHDOqzwU/OJsUU9qcT+5LiMxtOkcmaS7VJ2ukSp
         Kn/ZEF1gFpZk5gUbC93dNq4XNbs1nTiLxBIa9lBvpHmMShkITIcSdT55185GC6Sj5Y8k
         gTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723299261; x=1723904061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pr7g5yqDwE9a5NUp1QK9GoWcWHPRwH1JMXCEiNFE2LY=;
        b=pWldTMJEFhzTWAwDe1j1GnLZ6PAmplGkb6wSh3hlnynDTSjefEXplTUmBWBVV4JT+U
         czhmYIXOptvMxJo1923hUgB8yKuyI3vydxDaHn5wT6oB6qfl2AU9e6rpB8ay8b3qdApu
         AgP3PKNNHPdodQSiqP2ARb9BdgFdDALiI2/mv8USJRYNxHTsRmEbvc1pu+FZBFkiKg3H
         GkzzjW6qnlGWAkKjZxba4saPgQNRWMXJ4GzygqUC98OCWYaAc6BOfhpRrQdCrC5lmkLb
         BONSs4RsEcvlsMw0zSTPQFCoE2Kk9AXgLi0zP+DzEdoiNYVHrsQHNgNeohWXsu3qUK1C
         xPWA==
X-Forwarded-Encrypted: i=1; AJvYcCUj/oaF8FP1gCGl3SUtfiEL91nHtmQKvn9rr7B1XYHf0KLqmV+WE7WW+EW53bEXdRVXjJbEysDkv1kGMoy5rrHN3O0goph6Tle2tKKP/hmMvZpfk33ZMmP3scnOFDP+RA7CJfz2nMx8wRW0iSaK
X-Gm-Message-State: AOJu0YzxdbHzkHqA3YolZqHRTIEfMmiqXZQxWJdEMTzKNChWm9TRXtG/
	zeHazlJL3wlzEQyT7soNKmWltAro5/17MSgt3SW5XTi5y9msT13Mm8zqCw==
X-Google-Smtp-Source: AGHT+IGzF6kHyk8ZqN1YDAIiNUUZOagU67Y002andqYX2Zzc6ihm5ZT62xdxgXXD7TW0GikTdpK4Fg==
X-Received: by 2002:a17:902:c407:b0:1fd:a428:a021 with SMTP id d9443c01a7336-200ae5eeb66mr34305495ad.11.1723299261199;
        Sat, 10 Aug 2024 07:14:21 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bbb6323bsm12106995ad.307.2024.08.10.07.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 07:14:20 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: jserv@ccns.ncku.edu.tw,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] Bluetooth: hci_conn: Remove redundant memset after kzalloc
Date: Sat, 10 Aug 2024 22:14:15 +0800
Message-Id: <20240810141415.124113-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since kzalloc already zeroes the allocated memory, the subsequent
memset call is unnecessary. This patch removes the redundant memset to
clean up the code and enhance efficiency.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Note: Build test only.

 net/bluetooth/hci_conn.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 8e48ccd2af30..8f0c9322eadb 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -778,7 +778,6 @@ static int hci_le_big_terminate(struct hci_dev *hdev, u8 big, struct hci_conn *c
 	if (!d)
 		return -ENOMEM;
 
-	memset(d, 0, sizeof(*d));
 	d->big = big;
 	d->sync_handle = conn->sync_handle;
 
-- 
2.34.1

