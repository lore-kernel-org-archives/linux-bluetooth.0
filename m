Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96271145FE0
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jul 2024 08:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720169987; cv=none; b=JeGl62AGe6/K3HDxeVt0n1BEi1Djc4aAAQY2RImHE6M/nTX4fowyj6CCltCmKVizA2RW2HI2IaZtM5O1GA5kmqnKOxTR/3/uBBCgUK8yrPYgMzQ1kZN9exxtIkzmqUj9IUhTVhNdA/pUBZy4/zuXTx6OuUGB95a4FhUzNNsuJjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720169987; c=relaxed/simple;
	bh=lvIg2+dDecXMydPp3QRxG42uiS2BVeRFzszFwjtEl44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qClbhdsgoIggcQ8gMKz59vf9TiC8xS4CIgPiOdOcLGfd+Drs1nwKfmwMoPkRlC6kxcFq8uDdUl7mYjd2HhfL6f2pcZQFrNKSngi8p8PXfyWzoIYHLh6RZnQZt/79Hxmin8XZzyLnSF+vlYjkSVOrEOvcaMVTDVAldGw/oDu95cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 06CF860005;
	Fri,  5 Jul 2024 08:59:36 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v2 04/11] btsnoop: Fix possible negative memcpy length
Date: Fri,  5 Jul 2024 10:57:32 +0200
Message-ID: <20240705085935.1255725-5-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705085935.1255725-1-hadess@hadess.net>
References: <20240705085935.1255725-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: INTEGER_OVERFLOW (CWE-190): [#def41] [important]
bluez-5.76/tools/btsnoop.c:438:2: tainted_data_return: Called function "read(fd, buf, toread)", and a possible return value may be less than zero.
bluez-5.76/tools/btsnoop.c:438:2: assign: Assigning: "len" = "read(fd, buf, toread)".
bluez-5.76/tools/btsnoop.c:473:4: overflow: The cast of "len - 9L", which is potentially negative, to an unsigned type could result in an overflow.
471|			/* next 4 bytes are data len and cid */
472|			current_cid = buf[8] << 8 | buf[7];
473|->			memcpy(pdu_buf, buf + 9, len - 9);
474|			pdu_len = len - 9;
475|		} else if (acl_flags & 0x01) {

Error: INTEGER_OVERFLOW (CWE-190): [#def42] [important]
bluez-5.76/tools/btsnoop.c:438:2: tainted_data_return: Called function "read(fd, buf, toread)", and a possible return value may be less than zero.
bluez-5.76/tools/btsnoop.c:438:2: assign: Assigning: "len" = "read(fd, buf, toread)".
bluez-5.76/tools/btsnoop.c:476:4: overflow: The cast of "len - 5L", which is potentially negative, to an unsigned type could result in an overflow.
474|			pdu_len = len - 9;
475|		} else if (acl_flags & 0x01) {
476|->			memcpy(pdu_buf + pdu_len, buf + 5, len - 5);
477|			pdu_len += len - 5;
478|		}
---
 tools/btsnoop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/btsnoop.c b/tools/btsnoop.c
index efaa45db41dd..0bd28b65b6e1 100644
--- a/tools/btsnoop.c
+++ b/tools/btsnoop.c
@@ -448,7 +448,7 @@ next_packet:
 		acl_flags = buf[2] >> 4;
 
 		/* use only packet with ACL start flag */
-		if (acl_flags & 0x02) {
+		if ((acl_flags & 0x02) && len > 9) {
 			if (current_cid == 0x0040 && pdu_len > 0) {
 				int i;
 				if (!pdu_first)
@@ -472,7 +472,7 @@ next_packet:
 			current_cid = buf[8] << 8 | buf[7];
 			memcpy(pdu_buf, buf + 9, len - 9);
 			pdu_len = len - 9;
-		} else if (acl_flags & 0x01) {
+		} else if ((acl_flags & 0x01) && len > 5) {
 			memcpy(pdu_buf + pdu_len, buf + 5, len - 5);
 			pdu_len += len - 5;
 		}
-- 
2.45.2

