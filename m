Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0B13382F4
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786699686; cv=none; b=mJuMsaWdN2uyn5Ex2/8yRz/fT9BRUlDLxLEN+mwZ9yuIRaGEMXHHh+MlX9C26sRwGWSxbvN5NPQ8Z6ws2t+ilPncn53jwjJPopDl9NExHe+CF5KRdImWqCOcxf7YwJWL7Uv73jgh2SQYrOQ9+Pm78TrZkJul+QmL8Wd7Igz8E5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786699686; c=relaxed/simple;
	bh=xdl0sG0nlVZ7mx5ZlFdOcIIdsnqyF34MOxUN/pQpWIY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KvuKmVaOUoCwxxHfMgaMJn7Q5RfOT27x6OWidjAHz8QagDT00GmXOUfhS5FCtjAoOYLC4GHe2Y6SPXzx7hKtBCkUKiHGMcbp7Mb9kpHxgG8gxJylX7eYXcSIUWAuCqOLWikKRR1loDBLY7IGFd/H39dSn3dMxy+gz4GLGcNFQkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id D393C1F4F6
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 09:27:55 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ] attrib: Fix smatch "non-ANSI function declaration" warning
Date: Fri, 14 Aug 2026 11:27:41 +0200
Message-ID: <20260814092747.3064311-1-hadess@hadess.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: dmFkZTF2Y8mjbHLm1GjfWk0QmrA8bHRpLctYaUiT+d+5Tk2p3+CnRoKQwMXUajThVb2VWJxuJd55DpQq5BUM7zUPdEILq1vNrl31YegO2U6cydJlL7HyfWBywaBPlpfYqLN0j7uytiUF8S2hTZalROR8CVhTDWZgjpHrfrnsNk91SrjA2+SlVowNNIyW1CcoTs1lsrzhvv/JTwCOx1O/baTib753upsB+Jvn1lvYJWwxHEmM3fnzD6K8UhmvTlFC3PbzRhoyI/FwfRiUv400LVDfdOQUbY92ZNYrb56SnvSu4NwXmz1AGzYm+lMTHybUO927W/Tuv5ljd5wmB6rrgjpv0FbEcsAZtm1LzpQNjMGe+KiH9BwkJxi3f6YIWr94a/oq5FspRQ9mmqHdyCtDfotd6XwQqNMl1iSm8E3Ej/FtIz+3O94KddpWBmRqssxRtriqyfg5/yGJRBg1eZ2Gc+My9eDRxbh/Wpr83QJ/o4EN+DBfbFyQOj5Z7a0LufYlI3Sj4o8nbar3QgCiAuCKzvtpFtEbZRbEqXenPJM8lVO+kQBlwyJZYzKtciEzshxOuHsvWcXJKN02e3Ww/yYR9fYe1zlR43r0mmYgZKTsVj8CldRqluuKih9qkQqgUPs0rlL5jtt3+/cDrUtR9mbfXR0ifx8c2dFAiMLsqdr7P7PCAAmpEA
X-GND-State: clean

attrib/interactive.c:175:27: warning: non-ANSI function declaration of function 'disconnect_io'
---
 attrib/interactive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index 07d6cafc57ba..0291fa876533 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -172,7 +172,7 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 	rl_printf("Connection successful\n");
 }
 
-static void disconnect_io()
+static void disconnect_io(void)
 {
 	if (conn_state == STATE_DISCONNECTED)
 		return;
-- 
2.55.0

