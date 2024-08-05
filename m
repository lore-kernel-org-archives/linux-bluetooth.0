Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5361384B3
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Aug 2024 14:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866927; cv=none; b=UlgF5mgmpHYGOoCBJwog3QUUGbglOCIsOEe36XGdPLt15rScgjyDZ+Tz4uh6wNLDo4ZHMhxSd/mRMSGOce0H1EjJFo/shAia2yFuK2XC0/4USD4HXSPd0Rp/nKuxsVTGW7fj41MkWTr6pGe3bjespaWakaBR+sYYIjtFZg2lIkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866927; c=relaxed/simple;
	bh=FGFSVpnOlly3osBhem6Z4w168jLm3SJlQEX2KRzVZwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KeORl5j/COK0yxZLbWfLpFKq0D8NoIIWdFCdMMT0dxtmPn4CN3z8ir6u7yAO3fdfNXBov2ZDtQ6YXZ2I8rAUjfNsvRtkZUpBiJIbEf+ViGFLdL+IIHjlFKP0eSXyLfZFKrURmh3PA7MNPuOhvoGxq6U3rtfrnRAUw07A4g6esRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id CCB5D20010;
	Mon,  5 Aug 2024 14:08:43 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 8/8] monitor: Check for possible integer underflow
Date: Mon,  5 Aug 2024 16:06:46 +0200
Message-ID: <20240805140840.1606239-9-hadess@hadess.net>
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

Error: INTEGER_OVERFLOW (CWE-190): [#def4] [important]
bluez-5.77/monitor/control.c:1094:2: tainted_data_return: Called function "recv(data->fd, data->buf + data->offset, 1490UL - data->offset, MSG_DONTWAIT)", and a possible return value may be less than zero.
bluez-5.77/monitor/control.c:1094:2: assign: Assigning: "len" = "recv(data->fd, data->buf + data->offset, 1490UL - data->offset, MSG_DONTWAIT)".
bluez-5.77/monitor/control.c:1099:2: overflow: The expression "data->offset" is considered to have possibly overflowed.
bluez-5.77/monitor/control.c:1115:3: overflow: The expression "data->offset -= pktlen + 6" is deemed overflowed because at least one of its arguments has overflowed.
bluez-5.77/monitor/control.c:1118:4: overflow_sink: "data->offset", which might have underflowed, is passed to "memmove(data->buf, data->buf + 6 + pktlen, data->offset)". [Note: The source code implementation of the function has been overridden by a builtin model.]
1116|
1117|			if (data->offset > 0)
1118|->				memmove(data->buf, data->buf + MGMT_HDR_SIZE + pktlen,
1119|									data->offset);
1120|		}
---
 monitor/control.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/monitor/control.c b/monitor/control.c
index 009cf15209f0..62857b4b84de 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -18,6 +18,7 @@
 #include <stdbool.h>
 #include <stddef.h>
 #include <errno.h>
+#include <limits.h>
 #include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
@@ -1091,9 +1092,14 @@ static void client_callback(int fd, uint32_t events, void *user_data)
 		return;
 	}
 
+	if (sizeof(data->buf) <= data->offset)
+		return;
+
 	len = recv(data->fd, data->buf + data->offset,
 			sizeof(data->buf) - data->offset, MSG_DONTWAIT);
-	if (len < 0)
+	if (len < 0 ||
+	    len > UINT16_MAX ||
+	    UINT16_MAX - data->offset > len)
 		return;
 
 	data->offset += len;
-- 
2.45.2

