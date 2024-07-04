Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46F11AB91B
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jul 2024 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720088784; cv=none; b=AKL/H6uZ7OvWHeV2kf32QVvI6/tXCsJhYmWfU/a14KMmxCz3FZkqQEV6mtopMmFEJpW8XlHBDA+T6lBsRRfG2i+coA3hwkvw2kqrf2CcOYIbZPfepRUXy2ulB92oOvNykrqPiQKRDHZOSo2WVzL07OZZiZoxiD1ZEN4gHZdLoCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720088784; c=relaxed/simple;
	bh=lvIg2+dDecXMydPp3QRxG42uiS2BVeRFzszFwjtEl44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apcnjZYG8h1El4pUO+27Yy86/FbaigJ6XLfvY69c3+F6QyUSdXjXt1G0cpKG6mGm7fUvif8R+xkRGpIXAvGHIjCa7IH54R8+5B4p5g9XHESZIYRIUQKJuVgQiTE9U0YBfGKoipIacmHMzj1pTdNmM/iuo3BOzamBap+bTLCx/v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1486124000E;
	Thu,  4 Jul 2024 10:26:19 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 05/12] btsnoop: Fix possible negative memcpy length
Date: Thu,  4 Jul 2024 12:24:36 +0200
Message-ID: <20240704102617.1132337-6-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704102617.1132337-1-hadess@hadess.net>
References: <20240704102617.1132337-1-hadess@hadess.net>
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

