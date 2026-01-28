Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446942F1FC4
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614779; cv=none; b=p+rdlfaprDrIt1mvXyU1lPddrA41Xae6k48+nq8eNajGt8XPbKOOu9UlP3o3E3rU10WvIu0zol1WEJx58ZBiTAD3LkOWn/G1Abjtr/PoHMabe1jWhTov8/8G+YSHC/99INJSiwX3XjfJilz+MEflNG8gPzTMxafP6ZwZPcGwcR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614779; c=relaxed/simple;
	bh=OK878HwyHyeNJ//5yYtzBX7OAUx1+qHz+Jg1DFLeuA0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bNYY532dn+ZW8EDwarfJxoJzAZkojfw4R9Y5QvLAEavAQwFK9LUaT/c3SCguQIv6m934oe3N5zvPtwpAdDHwqaL5pPRTNyyxjMmNzKiLkqLO8biqu6tytlZkwoO1iSwfqSS/6JSMg7pyy1xrA66g5IjYvJ+kPymURGPm2HpO37M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GO2+nD2R; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GO2+nD2R"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a79998d35aso45368795ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 07:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769614777; x=1770219577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xnGHCaeps39JHQBRGZuvc5hl+ZGTz8Lty0ikWALTJvI=;
        b=GO2+nD2RRXnF2ZqwFMnVAJeePlHfCs+KLqr+rEs540GdqN9cCp1bbNtusvc/aUIcTG
         lzQwkyeWdm/zGh2iImOlarLHfCsSYt2c6tSR3aZueIa8nZ6hT6bI56GUyjtYQb119BdG
         jmf8PEd6a3gFfd/wKJFdJY6SDkYcovZFChGJ2lXKW6oY2LmEu1qbQW4mqImCbUAQnkEV
         mPYv0roGjSTq4lpM9tlUOibcD7EPtHjuoJAuxtUQoQtFrctEsVjgj2c84eyuF4lqTXHc
         /94xf2mCu1TM7al7eyBDIaD4qkdrZfnc9lhFTTPvSavDUi3pzIZupqUswazUhQ8FqL1G
         GKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769614777; x=1770219577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnGHCaeps39JHQBRGZuvc5hl+ZGTz8Lty0ikWALTJvI=;
        b=duolyOPMvQ+gkMCdKgYcv6d/LUn+0FTiHVjiom1V7xBv8oZ0JlB4RkBdK1B68zrQlQ
         D6jDchTbTs49z/T7vve6m1E9QnXrGy+kDOIswfXZ8feYcSz4hePUFkex9xcyTv2q5Qyv
         eB/kAIHubdqpLGsv2JkKNXHy3H6PS+jGRdJmikn+5IeR2eGqjCaloRfuXG4zFxhvTPgi
         CHYFoE+/R1NIDpzyiejoMt1HZkAu+P0eb3mD1RxRBRQYwAs810/jYhWOuf4f9Q4SyZXU
         gKyXNGIQCioALTLD8aFDqvZv29XDfR8CboA5+v+zPgZjToNM8CgpamSn2QO92TMD8cIl
         XTAQ==
X-Gm-Message-State: AOJu0YxhEwNljoVOYsI7etUeMN0jBD0aAfiG6+nkmSAfoy4ZKI5v54MH
	T0VN4b9FbpB6nQHH01MRga+0ErqQ0J3rijYzJYwA9on6XjpJJNrdRtRdcpkfOQ==
X-Gm-Gg: AZuq6aK0hCNkTohUA3L5zFUn2Y+FKtRdAssKsMiSkUR1YcnE0SjcNmHTmmSqZx/NDsS
	zNgOSz5DZkISYLII7IRFCGO05Vo0jkXPQWB4AAC5yth1IkJ10efF0Snl2DaoHYdWxMPx52eQUpe
	+XFwKZtiz55CPR2g37nRnALM2S2xMBOgzhvMwYrhomJq+8ZpLRAP3GC1FRvl52YvUqIevs/LGRt
	/MCKB4ylyivEe7ozspkxVKD9LiZ3VtL/ULhjicniwHarIInuwrfTPhb2F5l+Kg7s1pYKFRETkzo
	jeVld/Lhins8rrtKc56ZHKWP7/7wIfsZeuG0dIM5YqmbdkGENh6kdQ/4hitpjWBHk9bT4lpAWPJ
	OYHbYTWcfuqa5MOkO1/mHkjDfYozaTj4rVrto1N0tc7shBz1NnUBpvLQ1zEORAQyl7u7HuwdI5c
	43KRBkttJV67U1uqexQ2UXRDbnpm77X6jNi+InbEz4saJnMpaofyAJsLai88bn4g==
X-Received: by 2002:a17:902:f785:b0:2a8:7814:47c9 with SMTP id d9443c01a7336-2a8781448d0mr53924985ad.36.1769614777328;
        Wed, 28 Jan 2026 07:39:37 -0800 (PST)
Received: from lena-HP-Laptop-15-fd0xxx.. (p7603059-ipoefx.ipoe.ocn.ne.jp. [153.231.55.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4c3deasm26670335ad.57.2026.01.28.07.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 07:39:36 -0800 (PST)
From: Magdalena Trivina Sihotang <trivin2024@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Magdalena Trivina <trivin2024@gmail.com>
Subject: [PATCH] tools/sdptool: report error when local SDP server is not found
Date: Thu, 29 Jan 2026 00:39:05 +0900
Message-Id: <20260128153905.163137-1-trivin2024@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Magdalena Trivina <trivin2024@gmail.com>

Currently, the sdptool add, setattr and setseq commands do not
report any error when the local SDP server is unavailable.

Add an explicit error message so users can distinguish between
successful execution and failure due to a missing local server.

Signed-off-by: Magdalena Trivina Sihotang <trivin2024@gmail.com>
---
 tools/sdptool.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/sdptool.c b/tools/sdptool.c
index 4e95a18d0..4f4dd41ac 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -871,8 +871,10 @@ static int cmd_setattr(int argc, char **argv)
 
 	/* Do it */
 	sess = sdp_connect(BDADDR_ANY, BDADDR_LOCAL, 0);
-	if (!sess)
+	if (!sess) {
+		printf("No local SDP server!\n");
 		return -1;
+	}
 
 	status = set_attrib(sess, handle, attrib, argv[2]);
 	sdp_close(sess);
@@ -1033,8 +1035,10 @@ static int cmd_setseq(int argc, char **argv)
 
 	/* Do it */
 	sess = sdp_connect(BDADDR_ANY, BDADDR_LOCAL, 0);
-	if (!sess)
+	if (!sess) {
+		printf("No local SDP server!\n");
 		return -1;
+	}
 
 	status = set_attribseq(sess, handle, attrib, argc, argv);
 	sdp_close(sess);
@@ -3692,8 +3696,10 @@ static int add_service(bdaddr_t *bdaddr, svc_info_t *si)
 		return -1;
 
 	sess = sdp_connect(&interface, BDADDR_LOCAL, SDP_RETRY_IF_BUSY);
-	if (!sess)
+	if (!sess) {
+		printf("No local SDP server!\n");
 		return -1;
+	}
 
 	for (i = 0; service[i].name; i++)
 		if (!strcasecmp(service[i].name, si->name)) {
-- 
2.34.1

