Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF70280631
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Aug 2024 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866925; cv=none; b=IYyuF7o2DiisaOo0+uSSnvE81IEK58j5ENmWk0izCbZdKKd2GYno8b1wLALJp5TD1q0KY5pyDhou2S9hEJC/Pl7Uf7hnESsYuwU0hsJTpZQQKjTSbRZMLwhSxoJKQ8/ve1Dkl6hRBasD3XAUh4bQHXjH+HA7KXXbAt6gQ7Ydb0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866925; c=relaxed/simple;
	bh=zK5PstR/J/SNhgoa834rHpP4N7yToufuA0WG/vN4QLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G4EHgvkmVVQ68RjtCXbS0DYNGxw41aW+BvIc0tyR0Yupl+78mj1+gMBTsgbafZvMDjAQ6YFpvDD0Cw+HBk5yksDVErFUlIKWCPDR76UT1DJe0y/mxGq8SAf3WTMfOjleS43A31F4yMwzV+e0DQtzNH5B2j3UcTgOUonacPUHDwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 57BD420007;
	Mon,  5 Aug 2024 14:08:42 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 3/8] health: mcap: Ensure sent doesn't overflow
Date: Mon,  5 Aug 2024 16:06:41 +0200
Message-ID: <20240805140840.1606239-4-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805140840.1606239-1-hadess@hadess.net>
References: <20240805140840.1606239-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: INTEGER_OVERFLOW (CWE-190): [#def13] [important]
bluez-5.77/profiles/health/mcap.c:390:2: tainted_data_argument: The check "sent < size" contains the tainted expression "sent" which causes "size" to be considered tainted.
bluez-5.77/profiles/health/mcap.c:391:3: overflow: The expression "size - sent" is deemed overflowed because at least one of its arguments has overflowed.
bluez-5.77/profiles/health/mcap.c:391:3: overflow_sink: "size - sent", which might have underflowed, is passed to "write(sock, buf_b + sent, size - sent)".
389|
390|	while (sent < size) {
391|->		int n = write(sock, buf_b + sent, size - sent);
392|		if (n < 0)
393|			return -1;
---
 profiles/health/mcap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/health/mcap.c b/profiles/health/mcap.c
index 2e4214a6984f..b3bf403e74d2 100644
--- a/profiles/health/mcap.c
+++ b/profiles/health/mcap.c
@@ -389,7 +389,7 @@ int mcap_send_data(int sock, const void *buf, uint32_t size)
 
 	while (sent < size) {
 		int n = write(sock, buf_b + sent, size - sent);
-		if (n < 0)
+		if (n < 0 || n > SSIZE_MAX - sent)
 			return -1;
 		sent += n;
 	}
-- 
2.45.2

