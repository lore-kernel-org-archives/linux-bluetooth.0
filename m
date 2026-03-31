Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765E544B67E
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 21:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774993070; cv=none; b=oBLpxkHQovL7HpV5AP8YJb5vty7HzUm8N9bMAIj27kVc3fFdWPbFd5xrp6gUJ0+2iZhUgRS+IFbynQnk+g4ghMWPid809j7/2bGotdCYsM2lz5+NsGqbbec2MOpIynTMylKXjWUAaLiI4B1LaqMdHIIRuS2RSvlTj2h9s0mTisk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774993070; c=relaxed/simple;
	bh=YdujGk0t0JN5YMkUtnfll7BE16KnA3wEyI+3qfRmjQE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+6py1/6Gz52FLV8UWFYTu/MiDorJERvkPQAngNL9rj9PffAeGBIf+bCr/vBzPO/lI7oaM0cz1jIkU51ryhThTcB7+kYeC8VGpZG8kWO7gt8FC1qkVsycg7irGmxOx7RAhqldIGEj+khc6LJSBxqOtXdxoqLJyBrJTFygLPdDtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id A24EE3EC88
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 21:37:40 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/2] shared/util: Add MIN/MAX implementations
Date: Tue, 31 Mar 2026 23:36:36 +0200
Message-ID: <20260331213731.3895736-2-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331213731.3895736-1-hadess@hadess.net>
References: <20260331213731.3895736-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTFenMGUDv51xu6ewYXD7nvHPpBm9uS1zDGxGmHkEOomvN3TyrraH3NvRH2hcTR7XOKE0Xnp3txmsHjP/3Zo+c0CqLbAiWgpq3+TL/VrrbnsQfHmj5TMr61yHkskIYPmltcVfiGItDma0KmHSsXfBjI0Cn359uTdey9fyXqRfqTxcYJvdNAm4zrPgAGdRac1XNTDBssCwfAYhhTAVAJE2xtEn3pJZGxQJSa0hhjEJCnGaI69dtSLpMuMQch1zdI7vGOXhb3Ooi6qif0i3+m5qcj2mEg8JnQMniDqGbwCWNRSBAScmqmzJov84Y6yjs4cUnB/qmQ644HiO8PGtblbUB55er+XtR0aJHG7NVgk/nnBCBCPVigxHWhIfeV9Wf1lu8AQBW5WxAYXiifPmsZh+2OrWE+mMA7lL+Svd8rLNgYKUONbOI0JUGLNDThGcN50JKOzh5ycakYS4tAy1B7EF/ydk+Tr+1s1X8/sVBtkNvHfcfe0UbNuVvbVZbQm2LZfKbD7hjJ970+G2QjLcBjWDhM2E4JD4TMkLTX8Oe/AOJ9BcBVhv7vi58UQnYc500orDkT81kiGoOUTWAyorzl7D/fFPnlAmabPat1IrMWJ8vc9zriKq4jnfiGGQaJZyugpPBWPKSXmVcbQlpEZj2KO/4H969TuCfyl3YuCRoJz9AgKhg
X-GND-State: clean
X-GND-Score: 0

And remove it from src/sdpd-request.c to avoid a redefinition warning
at compile-time.
---
 src/sdpd-request.c | 2 --
 src/shared/util.h  | 6 ++++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/sdpd-request.c b/src/sdpd-request.c
index 1fc07e97bfe0..7c632c2aaf62 100644
--- a/src/sdpd-request.c
+++ b/src/sdpd-request.c
@@ -40,8 +40,6 @@ typedef struct {
 
 #define SDP_CONT_STATE_SIZE (sizeof(uint8_t) + sizeof(sdp_cont_state_t))
 
-#define MIN(x, y) ((x) < (y)) ? (x): (y)
-
 typedef struct sdp_cont_info sdp_cont_info_t;
 
 struct sdp_cont_info {
diff --git a/src/shared/util.h b/src/shared/util.h
index c480351d6e9f..67629dddfaa9 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -22,6 +22,12 @@
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
 #define BIT(n)  (1 << (n))
 
+#undef MIN
+#define MIN(a, b) ((a) < (b) ? (a) : (b))
+
+#undef MAX
+#define MAX(a, b) ((a) > (b) ? (a) : (b))
+
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define le16_to_cpu(val) (val)
 #define le32_to_cpu(val) (val)
-- 
2.53.0

