Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3F336A35B
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436148; cv=none; b=Y9jjTJM2O1aKEwYSiCCRzkB9c8BHEVXJfYsXuikKUM5L+OtIf7VHisSeS7U47xQkBvVwc4eE1fSmkdlM1o6puYdkqsmd5py3mtFqrGr7wMJkP7KG5XRdTcifk2G5m1OG57rw3sFogcvYYM4TFnN59Ej5m93plMjy9xg6dM1mR0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436148; c=relaxed/simple;
	bh=ANEusjxaTpAHdCex1qp9gr3WysuiSpDcRDtk2AFacZE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=S2rkb5kbukRbegW2TNqQ3bpk6UJjRNXlRhJiWNlxLQoclZ+T2ujpOT+r2T5XKQGVsBrlRuN/3f6doFCSMRSZfjg/9tgHZbn1rLZsXAhjy/6T3tsOsdVCIHY1GieU1dPjX0+q2jcGTRew9dyV2QqqkoKJnzoVvd7mxf7qC22qLlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRKUTMzY; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRKUTMzY"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5bbd26a2729so3379037e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2026 07:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783436146; x=1784040946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IlIBBp2e7HpXIuZYwR6yIvshF+mx/HZJNiwBzCBI54w=;
        b=DRKUTMzYIOakuZc54taJF9Nw4Zq5iKVyZ5/CatO/iQO+4VG/XRCJHFEH8AXpj4JjXs
         29Vpj/f7HO16AxJ3ehFvC+dOAQOPUPpUMrwgdDEFw54Ui7tQt82cW3KlLB/R3i2+dmri
         IqBEvajtA6cJH1DRJ7jbcRzawI5ZQL2X+uydOfmDw88BGqHjroyY4F7MNhlzQwF5u5gY
         gwWXMGA7TJ0CcswEDwmV0uu39Bfe+JR1Umk+zbSgGZwmhmV8voRVcF55Tcod75j1lGEG
         Me5rr9uWtUgv5I3ZetpScnur+jXVo6tXF9mO1OJPvtV0OJw1d4lEhOuzpt2flk2haCu+
         1Ymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783436146; x=1784040946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IlIBBp2e7HpXIuZYwR6yIvshF+mx/HZJNiwBzCBI54w=;
        b=CxIn/oXvF4R++zbvs3nIhoq6qQDjCb2AWht1nFRX4wiwKfJiCY6n51x7ebngXakVI0
         9eCmweR9yYSEd1ymWhtk/8+jcqL5/PX771BOAezTGYc5Om/WB/fAwtWSOIQcdI7PbJBK
         yJRl91Iw8QMz1pi3M9LyZQsksQwELwBWv9Z4qg4v8ql0Ax2XzhTn+OJXtf/YLA/7QjnC
         JRaNZdcVR3uoV4D1C4q2TCg9t5vJhZ4N1d5/ERqPP7S2K7EkcfCbzYymoCQBiHEaKkNb
         0nA+E04TiNqfAQSm6L35d7ra1rQhkvV4W3MPDHTumKcgyR2uRNiTts0bc4vgsuCwvscE
         2H9g==
X-Gm-Message-State: AOJu0YysfgQGA7Q4NC1hQpoToeN69n4EeAKhm3ps+xK4avaTUlzq561Y
	gxhWolA9FulksC+FDmXdGfskgaH1IO5YNEFCK35tixQnC0UdwLHSUCg77KcZxJo1L+jGUQ==
X-Gm-Gg: AfdE7cmN2XYnHdRERd6M2bQtNh4Mp5ssbz1pwhegXpRiHYDXV+vDR7k7RQ12fywKWSn
	Ov6tY8tvYWX9NM0Xa0PNNsint/U4+guIWYrcyYuZHXH7X4BOwhDkHAI109+bwi5nn3OzUVzLdUD
	7JKsHYD3EvSi780mh92LQgyiH8UzFutj63f91jO0ydqzfYnpanOsuzYXP5QpB4m0TURwAPUpRox
	eZhrUUrP6L1TSDvdsPrFmVygMEENEBctItPZUWgX9zlVUFGBQKDi6/hj7q10G2PZuFmZPZ8da+S
	BBb6EZlL2XFY5/DsoTqZQsEcYd2mif6TCLYE0rvx0gGIkSZSqIAiiXWQMjqbwe/fa54j4oBaNdb
	KL6huDedeKavGZwLBMXdO7ATlxkYH56oTGZWZmnnj6q7mpgFxswJDm6zyaL4BeNTFKIK5mSNbf6
	A+00634WkPValtqkia6GqA0hUPTrSnYL9ExQgJWwpR/xJ9R/err2Rd/1j7hico4ttoSyc60M6zz
	xu42QY=
X-Received: by 2002:a05:6122:32c4:b0:59e:feb7:8a5b with SMTP id 71dfb90a1353d-5be8953a62fmr3219725e0c.0.1783436145577;
        Tue, 07 Jul 2026 07:55:45 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5be02c5d487sm7705481e0c.14.2026.07.07.07.55.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 07:55:45 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] l2test: Fix calling getsockopt(BT_PHY)
Date: Tue,  7 Jul 2026 10:55:36 -0400
Message-ID: <20260707145536.874859-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

getsockopt(BT_PHY) expectes a 32 bits argument not a
sizeof(struct sockaddr_l2).
---
 tools/l2test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/l2test.c b/tools/l2test.c
index aa05f5247c5e..08d2269936b9 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -358,7 +358,8 @@ static int print_info(int sk, struct l2cap_options *opts)
 	struct sockaddr_l2 addr;
 	socklen_t optlen;
 	struct l2cap_conninfo conn;
-	int prio, phy;
+	int prio;
+	uint32_t phy;
 	char ba[18];
 
 	/* Get connection information */
@@ -414,6 +415,8 @@ static int print_info(int sk, struct l2cap_options *opts)
 		conn.dev_class[0], prio, rcvbuf);
 
 
+	optlen = sizeof(phy);
+
 	if (!getsockopt(sk, SOL_BLUETOOTH, BT_PHY, &phy, &optlen)) {
 		syslog(LOG_INFO, "Supported PHY: 0x%08x", phy);
 		print_bitfield(2, phy, phy_table);
-- 
2.54.0

