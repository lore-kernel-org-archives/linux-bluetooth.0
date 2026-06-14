Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804AF204C3B
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 10:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781432987; cv=none; b=MH8vP9sbpiZ3NAcbR903W8DLK+A/aSu5jObGzmmKiJsGtaE3LbcqLl0t/vb43WMX1zkGKqtTBAVlGanpe+m0/jgxX4gmu0a2PMsnQGctqp+gG/ljklh263fV8E8gk83T8zCWAzlOaAbQ15+A9/ZX7tFTSXBJLGx9IqY9WztqxpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781432987; c=relaxed/simple;
	bh=aHHLytpjQL/OwTf5J4CxumqJPtDSgcVIQKgTuwJhkPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IjP81QptGiBBnmXb1eu4Mr5ERdlO9I7GRdWGDn1+FD5NCAutoFVrmVWGMqUi7ho+aT5GTWIBaodbwdUlxR3wF5TxhvwHphm7nnf4vAGM4c/R65oLpPlXVTYPa9QGzf18Dfdnzz2SPRqLJE+lG3fpXTC8IppDazJzJfg55mAIG/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=DCt07XIB; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="DCt07XIB"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso22539855e9.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 03:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1781432984; x=1782037784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FH64zEBiRFRJyEQQungjcvf9z0BH/82R0qqOtYHGJTw=;
        b=DCt07XIBQDIx0GozqNXKLHnyTgyuS1aTuf76mAj4ij5+84chAIz3Dne6FCUsGy5Edu
         tHKRZpVfmAe0vUi++x15BE/bsfYoApNyrIi/e6gLsPb6RyQ6y01J5+qExM05EXfjcFE6
         t5/r2dEkK5oCaSe8TzpHMZIDGMuSdjnFH3dp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781432984; x=1782037784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FH64zEBiRFRJyEQQungjcvf9z0BH/82R0qqOtYHGJTw=;
        b=VS4JzmQdDqjiX4dTzGIUlsCzhAFkYQjTz6P/U3HJq5w2pph8+x73ghwbCgc8a3Kser
         mYhesWFKHM8dfft+aIYkniuZc9uQJotAKgslPpVO6/tfEMqPzX5XdQglWCfF7I2JbHcW
         I6wSHBy4dhaDoiiHQ5I+ktS2agJm8pxjh9q+Ybef9+r9rwEwMPUmv2P0T2Q7F33zvLj1
         3IByeBZ4ITxFzq4TCQqbmi0aiysJlqrQO67Lq73Qn4i/7W2KAH+0NQY4KikiEa+Ouimx
         ivIOvVBmun8MVBwZnkwPXM2fj2zI3uh26i6fUqy1TamIPCZg/wv0lSLaTR5zY6tDZlKT
         86aQ==
X-Gm-Message-State: AOJu0YzEJp1XTwHy2S4P1SuuEgH6DNEGJ99268oR+eeW87mkYQCasXdA
	cKDnHzEki71LHex0eXBcPvggqZkM4XX7E2G/WUpBwfwp0VWWkUXx/nD4WbsEWHukBBeEOAVariD
	XarPa
X-Gm-Gg: Acq92OFwJ56HNsP68ag0TH9u26Om0ZLVbAIQiLk7ZoUYUN3rbaEhPGhE+CL/pi/bN2S
	WnsUON2+DgOM5DYvESEUSJuYxROkfPfTSp7RPUglbufxG6rqv860ZsrvdTlxmvYju3cfh66kk5e
	mfVV2G23u+xus1auJvEgU7LAnJOfUDlwHI85nSRVh2XSR3n6NgsdNkiK/apTGdXoZXqa8llEUMF
	PT7/UJoUd61BXjat85f/cnT2k/PxvT1S+OGl05i+Fdz4iRTQVdLipygsS90WD1EKqSlR1fRuQfN
	zRtW66SDmJDiLqyiFwF6u3/QHBmbe4AJeAKssiGrcPqfVv71kubF0M7z2JcWUztSHb0HgM2+sG6
	6//jND9ZDACnuzNPavgdbwsu/1AaOWPnW+KscNBlrU4YfCiwrWUDhgX/Wjgm18aH9KBxmcy4Xib
	F9cOOpVOvIUOlw1Rs5kp5zUJJ9acoqMaBd7cNEPdSkVxq7ui5Hcbiy/mU=
X-Received: by 2002:a05:600c:17d5:b0:490:b4e5:ce7e with SMTP id 5b1f17b1804b1-49220104e46mr47922975e9.25.1781432983782;
        Sun, 14 Jun 2026 03:29:43 -0700 (PDT)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:eb61:bfa9:279d:6464])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492203d05d1sm203418025e9.12.2026.06.14.03.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 03:29:43 -0700 (PDT)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 2/2] gatt-database: Prefer notifications over indications
Date: Sun, 14 Jun 2026 12:29:31 +0200
Message-ID: <20260614102931.1133819-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CABBYNZL-A=NpnfiO9GO66TNX5QaEuvpSZ9fuBk0Jo+aNtr7huA@mail.gmail.com>
References: <CABBYNZL-A=NpnfiO9GO66TNX5QaEuvpSZ9fuBk0Jo+aNtr7huA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When both notifications and indications are enabled (CCC value=0x0003)
we will send notifications by default.
---
 src/gatt-database.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 680a52952..dfa83b31a 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1446,7 +1446,7 @@ static void send_notification_to_device(void *data, void *user_data)
 	 * TODO: If the device is not connected but bonded, send the
 	 * notification/indication when it becomes connected.
 	 */
-	if (!(ccc->value & 0x0002)) {
+	if (ccc->value & 0x0001) {
 		DBG("GATT server sending notification");
 		bt_gatt_server_send_notification(server,
 					notify->handle, notify->value,
-- 
2.43.0

