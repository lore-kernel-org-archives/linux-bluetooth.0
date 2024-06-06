Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623DD10E9
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jun 2024 16:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717691348; cv=none; b=s6bCZI7wnpTqrUhSntgXqEtMxCZtxYmGRdJLITyQUnKJY1B5+2WyeO11UJ2F/nKbvX4QRfASZkXwNt4QObZHJju5VZmg4/lx7Kc9eKoJ0sLpczUOBkmAvjfNKaLI9AsdxKhphvBZujlkfP0qD0OXjNIMMkzzpO0y32SZ2ACnFcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717691348; c=relaxed/simple;
	bh=rSlArMrLfKQHTJRyHkwEgeykINTVTWlWE5nyU8Yg7BI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=N7JJtpyXJe1EfMWFlQ3kDwqZll0xmKxPPAitlPGQXno5bhsyBbI4JGQJ/FuJlHLgaBVvtWElJ9xP+ownbF1mh/ZVTjrIOCZXsndLlsqnQto1+DGrjvMObHV0YfRJbz1vkE8wuMYzSee1EpTqTjxnGeC+lCyNA2UkjD+fgn/IAF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5QgfRuC; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5QgfRuC"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-48bdbaab67aso370369137.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Jun 2024 09:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717691345; x=1718296145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pcye0rJiyy34ptRIzGkdbWCJ6FryA9ij26/cfVA8Jh4=;
        b=d5QgfRuCrj7WX1ixxJB1KwMUxczIdtbW1Kb8SwoF/WVFOBMIFnOVL8lqgcZYZPsui+
         flAWKPOf+xYwIA9Q+sYv7MeELe3zD/TpToxGNeMBNtQn2rZSNgLSn2g6sE9tYISdUMNJ
         BsnGYlaFzjsGGD5igY+IR0zf3PR2krcdwx6S32xQKBG/yo2E6q7RfqmF+stArZ6ek61l
         r5w70wFIPK+eFC0CyjJ1IycLEkERUSCj00QGvMa4cV13t2EtDcbfgOoTGnCyof8LxuTR
         r/qO1DoEgmLORplMDhetkkcvxRLV63aXG0TNAUFYYD72dIV2r0rqVrL2Xg384kv1sKoP
         4O5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717691345; x=1718296145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pcye0rJiyy34ptRIzGkdbWCJ6FryA9ij26/cfVA8Jh4=;
        b=PUHL630g9GyUCf97Fo2mVwIUumFkztgRO2Ie20HxWU+j4kfyj78+uII0Xqf43smseM
         uvNT081WPqNmz6hGw7VpYWv8kBlqo8vXjU8HNjU4Cobu5FxufC67MV+3LqFFNWUyS4d3
         QAiDsrebIVrM/MppGkIx7O+0Dlx6LCquwOHLZoLCImdz0I2FM24B1O6DRw/a7f8nDh40
         UBmXmsogv4209BXLiOfghw4lQlY2AtwFunnptww5zxA2zw3aYkkjryI71TVY44RcVasY
         4jNm6Pk7MqDYoW8ktE6E0baxh41w1HdCCbPe4LKo+WYvSWro+xfl26pWm5uT+Z0JDq4B
         21KA==
X-Gm-Message-State: AOJu0YxwzVkd67mUVj66cpvxyHcTkqSmd5PGjK/P4uTvQUsg0vb7SiiH
	FBM8eyMjnKMoZYDbzjp4c8FnOMf2kwuGRmC6Y82zWUcni89/BBa8GtVOag==
X-Google-Smtp-Source: AGHT+IEaLQyK1IWOKGVFhmkXn+5S+tfb2TKabEsEVZ8g73+744PaRMnVF+NWMWdfjLU3UFn5kQR+CQ==
X-Received: by 2002:a67:e2d5:0:b0:48b:bcbc:fc3b with SMTP id ada2fe7eead31-48c04a86669mr4902282137.35.1717691345422;
        Thu, 06 Jun 2024 09:29:05 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-48c19f09735sm315126137.12.2024.06.06.09.29.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 09:29:04 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] isotest: Fix ISO send data rate
Date: Thu,  6 Jun 2024 12:29:03 -0400
Message-ID: <20240606162903.620906-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

We are sending data to controller at wrong average rate not equal to
1 packet / SDU interval, if Transport_Latency is not an integer multiple
of SDU_Interval.  The calculation currently may also give zero, so no
data gets sent.
---
 tools/isotest.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/isotest.c b/tools/isotest.c
index 68154b19caa4..c1bb6abd29aa 100644
--- a/tools/isotest.c
+++ b/tools/isotest.c
@@ -46,6 +46,7 @@
 #define NSEC_USEC(_t) (_t / 1000L)
 #define SEC_USEC(_t)  (_t  * 1000000L)
 #define TS_USEC(_ts)  (SEC_USEC((_ts)->tv_sec) + NSEC_USEC((_ts)->tv_nsec))
+#define ROUND_CLOSEST(_x, _y) (((_x) + (_y / 2)) / (_y))
 
 #define DEFAULT_BIG_ID 0x01
 #define DEFAULT_BIS_ID 0x01
@@ -834,7 +835,9 @@ static void do_send(int sk, int fd, char *peer, bool repeat)
 	}
 
 	/* num of packets = latency (ms) / interval (us) */
-	num = (out->latency * 1000 / out->interval);
+	num = ROUND_CLOSEST(out->latency * 1000, out->interval);
+	if (!num)
+		num = 1;
 
 	syslog(LOG_INFO, "Number of packets: %d", num);
 
@@ -843,8 +846,7 @@ static void do_send(int sk, int fd, char *peer, bool repeat)
 		 * latency:
 		 * jitter buffer = 2 * (SDU * subevents)
 		 */
-		sndbuf = 2 * ((out->latency * 1000 / out->interval) *
-							out->sdu);
+		sndbuf = 2 * (num * out->sdu);
 
 	len = sizeof(sndbuf);
 	if (setsockopt(sk, SOL_SOCKET, SO_SNDBUF, &sndbuf, len) < 0) {
-- 
2.45.1

