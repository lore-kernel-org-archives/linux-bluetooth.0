Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795472617;
	b=SmJjzvFKQ/dbKYJjC9LeW+6zJz3kM3AmkJyHfetIYB5tDXEWv2cUQM/57N95hkAHeFGU
	 NPuW1cX1rQMtXTb/JDebpoqEdqQ2f7fPPCZuJmH/zFafA4YkgDBgvD9Enr1ZApB679gVw
	 e8S0nUZnwbdhDEZ5tiD4wfbBv3bhJSO0D3/v3TOliOjd+hY4BoJYhrl4UR0bLm4UUo8V/
	 m3lpLAj4tpHPHT9ps28mPar2su1zCRxgEoa46qzfj6RZ8TAKMbghdT+lyNIOa4vULox+G
	 i2Yt0eJg01SYTtPK/XZwOqoqPebMtgIFLC0F1d58p5eD4LwvrtPWamZoSIZi3Dt5oyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472617;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=u082h5nsg1QYpIeH5d7X+8TgQiC6KbFuw9Ai+aJAWkA=;
	b=SbN5RUqdc49XqnSkBZGCkIh115QdBKp+l0qcDVZovNr/jOqJRsQvo405zFOdBKsx4c6i
	 tE+Ct8X5b4aWdMEBYw/lMmweUxHoMjprEzEFQNq/cSZnoHdPaNGsGrdNdyWdyse07Efp7
	 VtfRQPgK74HwfMhzEB+Nsi0tE9vnpnjz7+t2+BIKKqoOkjslPSejq6+k9qoNg+BKSCo/q
	 /DzQ/wHv26ARbPt3uX5X+rsNg35LpwKREPGBBWhZJd265A3xf7wHgHz103gR//JUo0PFC
	 BT00gBQmtw+q5gN9WtRWR7hojREkDGh54q+MJS5u+uA58X6/pcNHGqb8T4d1hyjcAuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NhtfVHmj;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E2F606A321
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 22:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65E2F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NhtfVHmj
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4bb67b3a18aso3492495e9.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 14:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795472616; x=1796077416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u082h5nsg1QYpIeH5d7X+8TgQiC6KbFuw9Ai+aJAWkA=;
        b=NhtfVHmjy2K+xcUjRB7ynxn1UgGhIkiA3xdCWlzeofoa0PnOtL/2MXQHJ9nG52DJni
         FjqlyfVDaZoS+pgY1wwVq+uYzKZRzqMukpXdfNhRcbhmwNJekLs/vnUreupSeNcwjlFB
         fmBgYVfV731i0jw2ncXBITOnCPKCPk/QjL5mVWkak5UKg91pOskRRUi4D1ASXQsD/4pt
         yHxh7rvDI1X2pcWWqvEX40+bGcruzrSRRBFDDm8OZvIrPYsQTAdn3/5JN8gcdjwyNP6h
         AFj5p9ZgbEM4Xrv+ze10dpOBIkrNt6oXOAX0n0S1Q7fyEVBy2u0ckjfL1djiCy7wE/1J
         zXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795472616; x=1796077416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u082h5nsg1QYpIeH5d7X+8TgQiC6KbFuw9Ai+aJAWkA=;
        b=gu1QyB6mKBfkYb+AYF4wQPq87w0qbIacML+ZjLg9dz0EmnrSIWl73L2nzIrPXvcXo5
         T+jccWJlu9HMt/ntdpNiF//DYNlSXFZ/1RL8HsnndIvxqSlswDFTAtN4drnZe1IS6xYE
         JoL3rbKX1oJVQ/D8zCU5pqgjLHzVP4PEOloe9tvmPP2ER+dcaEjsrzNrnxB6GNq9aIOk
         kN30T2qW15bef9VYbAfUI6zp2oukk42rPIT0hUkMlak7eB+ZLxMpL8RLLnF8QIPuPTgt
         d/5a9gTA3MbjnXLa6CdK5c8BGbOwRMMKcmPYgcuP8kkOfmuvx3ZP+RFVRI2fUmpTCafX
         llIw==
X-Gm-Message-State: APuU4Z+3xZbdab1AFnxkg9pew2r9uwUB53ysM5+77D4jadd7A+mxeTJb
	iYHC3+nrACTfGzj/ZyHtf5Bp+jaereiagPclj3ibjuGB9jUIQN+TqzV4sE1NGQ==
X-Gm-Gg: AZFdTZco1bY8dO78oYbiFYvgg2hgjKEqJXTptmLinmQkt/gEyNFKo2BRPRefXVM+ucj
	k/nMCFSb8DTb5VPPKqsP/zVM2g1ZA+YcvtOxR1icur8PoCxT2hem6sD+nsLhbKgFpWpYhc0mZlL
	rN6nnqgHPBYfBi14MNXfMbuyFmgAzAj+31AZHLsePbokF1AOCYonlrynF0y0bw7CLRCYz8nf7VF
	RjIO8iN/Url9amipUPVUDuoi5h7paT3RX0mwGxaXSCQteSf65oO8a0hRA/pVFM9BdLlrP5R8tyc
	xk8/aLjVIKMcOd1/xyoKqcI9M1YhxkWI0EMTeG7uflWtaH5MFlGmfriPtRVMZYLEubf2djWa0Nn
	k0mQOhlJuow+XoxY29z5P7h9SEMYndQad4Y3viSnkm/LY7ekebetn0KR00Si1FJoQcWB+czIAah
	4fnscemMt2lftDU1tOR8qT20xQ0iZAO+FKAboJN510bK8G4AswylJCAO/EhSN+MNEpanwiEIl1t
	R+Vu7LWWSrWcxHD4zEVQWNCgIH38lvwlw9cK8R7utvF3YE4gU8hjycNeUoXnmTKc+YnsORYrL7C
	1tqBfB/mOrGB8qpTQlKjyNXbViPpUsAQAZy6+op4+szdX5J/
X-Received: by 2002:a5d:5f93:0:b0:48e:6675:3a77 with SMTP id ffacd0b85a97d-4abb400ac51mr23708879f8f.3.1795472615850;
        Mon, 23 Nov 2026 14:23:35 -0800 (PST)
Received: from schinder.fritz.box ([2001:9e8:b398:6b00:c303:57b6:d70:952e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4abbd84e661sm23019015f8f.18.2026.11.23.14.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:23:35 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ v2 6/6] monitor: Fix decoding of Public Broadcast Announcements
Date: Mon, 23 Nov 2026 23:23:15 +0100
Message-ID: <20261123222315.223450-7-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123222315.223450-1-rolandschober1968@gmail.com>
References: <20261123222315.223450-1-rolandschober1968@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

print_pbp_announcement() takes the result of util_iov_pull_u8() the
wrong way round: a well formed announcement is reported as "invalid
features", and an empty one is decoded from uninitialised variables,
which can hand a NULL pointer to bt_bap_debug_metadata().

Check the metadata length against the remaining data as well.

Fixes: 3171f7fd3685 ("monitor: Add decoding support for Public Broadcast Announcements")
Assisted-by: Claude:claude-fable-5-2
---
 monitor/packet.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 042a2ecb6..7fdab7cc5 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -4101,7 +4101,7 @@ static void print_pbp_announcement(const uint8_t *data, uint8_t data_len)
 	iov.iov_base = (void *) data;
 	iov.iov_len = data_len;
 
-	if (util_iov_pull_u8(&iov, &feat)) {
+	if (!util_iov_pull_u8(&iov, &feat)) {
 		print_text(COLOR_ERROR, "  invalid features");
 		return;
 	}
@@ -4113,7 +4113,7 @@ static void print_pbp_announcement(const uint8_t *data, uint8_t data_len)
 		print_text(COLOR_UNKNOWN_SERVICE_CLASS,
 					"  Unknown feature (0x%2.2x)", mask);
 
-	if (util_iov_pull_u8(&iov, &len)) {
+	if (!util_iov_pull_u8(&iov, &len)) {
 		print_text(COLOR_ERROR, "  invalid metadata length");
 		return;
 	}
@@ -4122,6 +4122,11 @@ static void print_pbp_announcement(const uint8_t *data, uint8_t data_len)
 		return;
 
 	meta.iov_base = util_iov_pull_mem(&iov, len);
+	if (!meta.iov_base) {
+		print_text(COLOR_ERROR, "  invalid metadata");
+		return;
+	}
+
 	meta.iov_len = len;
 
 	bt_bap_debug_metadata(meta.iov_base, meta.iov_len, print_ltv,
-- 
2.47.3

