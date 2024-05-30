Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3534B16F0DA
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 May 2024 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081262; cv=none; b=e+jGp9CYP5vQacmP44ObncQIfRSqbbAglf1EltcHdJ7SiF6JB6XcooyXKBj4LBohDOzExtmdVyeunCAN373LH85mwYQ+fj37agYON6JxJsMG5p5NieRAC0cxdU7t5lK3MfAPRuTbOH2eM/9xytKwAemnvnzCGSy6JnmoBAeQwng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081262; c=relaxed/simple;
	bh=gfZu0KVCoQ5wGva5wZeqr64mlcdoNf+tqpQU6FXiceA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCMtPKDcpfFdpJU1/59feWaAQzOVrTERcpnI76XrcLU/0eGXDGdu29ISgz4dSqzgPAlyQmPSa7OLYSOF3v/oIcLAZbRwNvJLo6t3emyi1FFazWKOOF4Kmr03696sRkVXWrEDFSMubBjRpa5RuYxrX706j27c7Hty1jM2Hhv7eLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0CF722000B;
	Thu, 30 May 2024 15:00:57 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 1/9] rctest: Fix possible overrun
Date: Thu, 30 May 2024 16:57:55 +0200
Message-ID: <20240530150057.444585-2-hadess@hadess.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240530150057.444585-1-hadess@hadess.net>
References: <20240530150057.444585-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: OVERRUN (CWE-119): [#def57] [important]
bluez-5.76/tools/rctest.c:556:3: return_constant: Function call "read(fd, buf, data_size)" may return -1. [Note: The source code implementation of the function has been overridden by a builtin model.]
bluez-5.76/tools/rctest.c:556:3: assignment: Assigning: "len" = "read(fd, buf, data_size)". The value of "len" is now -1.
bluez-5.76/tools/rctest.c:557:3: overrun-buffer-arg: Calling "send" with "buf" and "len" is suspicious because of the very large index, 18446744073709551615. The index may be due to a negative parameter being interpreted as unsigned.
555|		}
556|		len = read(fd, buf, data_size);
557|->		send(sk, buf, len, 0);
558|		close(fd);
559|		return;
---
 tools/rctest.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/rctest.c b/tools/rctest.c
index d31180880ef4..ff91eb2f159d 100644
--- a/tools/rctest.c
+++ b/tools/rctest.c
@@ -554,7 +554,8 @@ static void do_send(int sk)
 			exit(1);
 		}
 		len = read(fd, buf, data_size);
-		send(sk, buf, len, 0);
+		if (len > 0)
+			send(sk, buf, len, 0);
 		close(fd);
 		return;
 	} else {
-- 
2.45.1

