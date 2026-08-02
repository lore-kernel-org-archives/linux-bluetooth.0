Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC761A6834
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Aug 2026 08:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785657715; cv=none; b=SiYr/+U8tMbR6toeQuQTCFngsdc6QmQgxXJaB2cQH0iUPfQE2o9V/asdUTjDPo1Hy5fgyUiaZXvIvATdyDpHfT5QyLdCNmHP2paKDVEHQVdSvEd2rauCehzRa4Wp0fL3B65af1M1mZO8Tvq6ZnMx7DGIp1C9GvjFP4/f2QqU8AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785657715; c=relaxed/simple;
	bh=F/8mTpDlfJ2APTAlFRDP8u5qtXZXpDscfJnsi4X65Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PJebhzQoo1DFw/r2sBlrdWJfZxECqyCZ65+Y91iRN7yLf5xax3XRgHl/1fZZ7R46cm6fjKqzbllyTqQ7bX6yUkYBjSPhxNNtnRqwafQl3JKoNCccLs8EeyHoA5gjoLdOp1TwcodoE1Vu6HipeorJZo07gfcl/+y3q9Hdewq8dUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGRq662+; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGRq662+"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4728c12ba97so1261019f8f.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 02 Aug 2026 01:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785657712; x=1786262512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KNMZKWUDhhWeZ+/JGFFL9uVVrDVLcPjOn/+YceLgCEE=;
        b=MGRq662+gQU0iU/K41FBA2kQ4rW0k+h+3dPDVaRknu/qu0DI+tMC1e5CWIgBtNMvYP
         gcGzO3i7nCJd5DNsfTLD4UozN8X/DlhgDzfUnx3OkUaK0+y6Lp600vOWWmcfuYJrAWs/
         zhGWiLmAFcZ0gQ3nwVkvUfD4l49NC40EN9ybpaLZ3Q7GkXnhgTXHvERETXgV8Su9JEBh
         05Wf2iWoWnz/vMmImPRiaUyZ1rNPh6zE4V1XkKxFAaT01tMK/TLgawzj/1XZgJ6SpQUM
         Om/H50fWG1zqCewxAdY2Y9lgwAl8EcrRE91CVhqpDs8Zk8HhIbeOI+/9eBiS+PvSWAYc
         sgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785657712; x=1786262512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KNMZKWUDhhWeZ+/JGFFL9uVVrDVLcPjOn/+YceLgCEE=;
        b=Rfk0mA6PKHksS+Q/nsMCaqe+doegIl2Rau5q6jHwZalxwzdYTzHmKLvZcTwHYdDNTO
         yINy2uxg1Uda3Lyyfd9EiEUWFy5jJXvut2cqxCh5eaeRx7YXD5OidXMzL6drUoZANOyU
         vNgVVTxwEjfkZrPkzoqMhOrkUg9wgKRijcI4bgAzLDRKnkqmXvnYF6RcFEZsxt7d3Jqg
         7adhp2eTQlRJjXJkRBzYhvrseRz3j5IK+J4SL6zWsP+53DUDg3zpERt6m9njSnJ3YdC8
         piIU1A5SJQFgZta9tyyhE008bi0WcS+nkqs7IFaJtZ+brM+Zb5I8FZYSJ3NC8qGSGZWf
         S5nw==
X-Gm-Message-State: AOJu0YwchqWZw6V6/cxnZ7G8XSju4KC27zBrtuCygwS4jnTUZnYIFmTe
	Zp2y7AIWbJ3/AjXIFP5Q0VBC/wynBjtd35ED6F5tBFOBKdjtkuVQ8zvgRcuKEqxNNr4=
X-Gm-Gg: AR+sD129kECYWoJq4F57ka+/zniOy4/W+9IRc386lQu7/E2G+lUVFkktCe0X92PL8Si
	rG20MQyujd9tSsbqPFY/TcNpEVHkI5IQb3nbtrDDFUTDVXojfQ3eWwS/+H6RIFDvztjjNxot1Iu
	X4eg1UtleJyNMz/z3ljJE+PLerKWksZ+JxLxDPibGPlKHwwr27oYMZdh0Vo+DcY0yCvjHExOjyb
	O2a2eBGBQVAMb3ZC37l/uteXTHXSDMAdoUz3t/7GfJ97gA0c3PmYTBpq5+i0EcRxKBbsqWoQvTL
	1bYFtgjYsp/rdrECWJrPdlZLQe12d3OKJcuJjI10GW392el89DMdwRprxhZYxQ9FjjMFPgspMu7
	sceMcyMvY+q5ls43aF5JQ6SHAAoSI5jaVE2yvdN5AyVOrdTTJnNACc5aNNF4IIIeO46r6vY6mE2
	sYIU0txAYbn4/k6T7ResJ1wpEIfASm2rWCCEri5Ij16bvP3lhKGJs4rvMAImbuGg==
X-Received: by 2002:a05:600c:4444:b0:493:f6f0:d66b with SMTP id 5b1f17b1804b1-4980c6458aamr100788215e9.1.1785657711628;
        Sun, 02 Aug 2026 01:01:51 -0700 (PDT)
Received: from Elman ([37.114.176.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49808199f2csm163630025e9.5.2026.08.02.01.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 01:01:51 -0700 (PDT)
From: Elman Shahbazov <shahbazovelman97@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: secalert@redhat.com,
	luiz.dentz@gmail.com,
	Elman Shahbazov <shahbazovelman97@gmail.com>
Subject: [PATCH] Fix Out-of-Bounds Read in AVRCP GetFolderItems parsing
Date: Sun,  2 Aug 2026 11:58:50 +0400
Message-ID: <20260802080137.17604-1-shahbazovelman97@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Elman Shahbazov <shahbazovelman97@gmail.com>
---
 profiles/audio/avrcp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 2194a9135..19ea13c16 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2625,8 +2625,12 @@ static struct media_item *parse_media_element(struct avrcp *session,
 	uid = get_be64(&operands[0]);
 
 	memset(name, 0, sizeof(name));
-	namesize = get_be16(&operands[11]);
+	namesize = MIN(get_be16(&operands[11]), len - 13);
 	namelen = MIN(namesize, sizeof(name) - 1);
+
+	if (len < 13 + namesize)
+		return NULL;
+
 	if (namelen > 0) {
 		memcpy(name, &operands[13], namelen);
 		strtoutf8(name, namelen);
@@ -2669,7 +2673,8 @@ static struct media_item *parse_media_folder(struct avrcp *session,
 	playable = operands[9];
 
 	memset(name, 0, sizeof(name));
-	namelen = MIN(get_be16(&operands[12]), sizeof(name) - 1);
+	namelen = MIN(get_be16(&operands[12]), len - 14);
+	namelen = MIN(namelen, sizeof(name) - 1);
 	if (namelen > 0)
 		memcpy(name, &operands[14], namelen);
 
-- 
2.53.0

