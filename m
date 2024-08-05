Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FCB78685
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Aug 2024 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866926; cv=none; b=oItD1Z9W0XeoKD5h5WLMC4YrZJ4VAwmQQqEcK+v714/rttyVi7fm4rNAhro1bTEHrKGiW5CJhsNp2TM+i5JHHOHGP2+gaqO5h0Bw/VD5gcocd5cBCn7WDQNT+O3GBptA8K5jmveydRO3jHSmHgnUBHVc+gGc2xMAJIu4Jy8lmug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866926; c=relaxed/simple;
	bh=5zaz91anUO0jZjOxKnw2kj87TKZb2NE7EdsGGeFrdfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzgtnSSR3AbRSp8GOLK0L4DsPrEt8T4m+WuwoKF/w+SryHS4mH2EdmLZvpchHZweiMLYXZNn4Y3b7GzKHuASuVKIbo3AQwhpQXhg/Vsguf/wwIYbPMnA5RiYuCE1Yff7BTSsVlG19mMTIws7d7WWP9jhdGuPg7GdoTYa/qLyzyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id B106220004;
	Mon,  5 Aug 2024 14:08:41 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 1/8] sdp: Ensure size doesn't overflow
Date: Mon,  5 Aug 2024 16:06:39 +0200
Message-ID: <20240805140840.1606239-2-hadess@hadess.net>
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

Error: INTEGER_OVERFLOW (CWE-190): [#def1] [important]
bluez-5.77/lib/sdp.c:1685:2: tainted_data_argument: The check "sent < size" contains the tainted expression "sent" which causes "size" to be considered tainted.
bluez-5.77/lib/sdp.c:1686:3: overflow: The expression "size - sent" is deemed overflowed because at least one of its arguments has overflowed.
bluez-5.77/lib/sdp.c:1686:3: overflow_sink: "size - sent", which might have underflowed, is passed to "send(session->sock, buf + sent, size - sent, 0)".
1684|
1685|		while (sent < size) {
1686|->			int n = send(session->sock, buf + sent, size - sent, 0);
1687|			if (n < 0)
1688|				return -1;
---
 lib/sdp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 411a95b8a7d3..8a15ad803db1 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -1678,13 +1678,13 @@ sdp_data_t *sdp_data_get(const sdp_record_t *rec, uint16_t attrId)
 	return NULL;
 }
 
-static int sdp_send_req(sdp_session_t *session, uint8_t *buf, uint32_t size)
+static int sdp_send_req(sdp_session_t *session, uint8_t *buf, size_t size)
 {
-	uint32_t sent = 0;
+	size_t sent = 0;
 
 	while (sent < size) {
 		int n = send(session->sock, buf + sent, size - sent, 0);
-		if (n < 0)
+		if (n < 0 || sent > SIZE_MAX - n)
 			return -1;
 		sent += n;
 	}
-- 
2.45.2

