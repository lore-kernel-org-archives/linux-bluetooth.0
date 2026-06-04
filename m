Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06A93BED6E
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780566443; cv=none; b=JwlFhT5g1MOyAa3nTNi4inDkWhHBQJqJkKXPGOboomKXStoK+C4HEou0oNpceoviepFZxHf3z3XCR4Nnai96q7peu4NXj54xQEEPX3iZedFzRWQwnS96Ma/SCd8TeS5lSVNFYRuSsMsfioQPT/EQUEhVZgwSyMrvblgA+USoFBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780566443; c=relaxed/simple;
	bh=7iuumDYIkXGFLVLweSFsdJ7aSB1tZJSWgA12XU1vDLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IU4+ApodNrYc9Pk2Rw8adBLcj/58M1yedRyQniZdY+VZVz2O8Oewdn6wsUiciAGwKgEKfEHHBl5Uocvsl5taS4oCPwi4cHAVB/xNf4wH+Mo01C8NDdyOK0FrQlufMr3+UNw/U72nDwgUIHGSQItDZmekUQMKn7tgx+gv5UuvLF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 8E2C258461D
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 08:01:55 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EED0A3ECC2;
	Thu,  4 Jun 2026 08:01:47 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Funda Wang <fundawang@yeah.net>
Subject: [BlueZ] build: Support libical 4.0
Date: Thu,  4 Jun 2026 10:01:35 +0200
Message-ID: <20260604080139.1264222-1-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTFmTnanoySoYJ0TPmLWx9czyd/cvuCRSTfgPajW9dRRUB+WUl45DQOEoWbizmOwxsx/d37ZAu528sjqhKbCpd+HTBXsICTNzDlyCGSMC/xuN20K1Mftnc149xuOjLzHjnYtRjd2j71HTkT2vxDGuSkfuRf1i3MPYVL2uLm/kOXcS5CF+hqWVVlLNbdJJjD9KgjNp4cT9191bsxa7jkbpl5d723/GSl4ma+dos3fS5KluWYOnnYIe+GA6q64Z2iD8JM1kLDgf3RpzHbCrMwxa4OqmIdaeBk1zuH4XUs86sAN5j49eIaI55ffy+4V+zmTYK33g5wXCnjNlEbyojO6bwm6N9myY7axRN/wv0DbUGO9t5Z0ZXQURy4c5hRFnbHdRcxu5HLTvlCzvrZj7Gg5Kteux1agpvIgitKPqvcGMkm1yjCKvET7h2yCSYwP8bN5BLy2amxNNYB9HZ5QLTpLqnVsqpHJdEcEOHaIr3J2eb2rFMnPf5ldADniwvlkEb55g2kcYp37QWhn4BhlBT4idfcjzymdmM89+pLLmYw775gECstv5A0w5VY9DlZ3+YQHBEpRKDPjpGyXHkBBB+K4ryJGg440XyP6W6ZN9QXYYqeHm/Jb+c81xbuPA5wkKBH0VJskNnDZrA6w7VD3cdSLuqEe37fxPB5d/vODgIa0SlxAIw
X-GND-State: clean
X-GND-Score: -100

From: Funda Wang <fundawang@yeah.net>

libical 4.0 split off some vcal related functions to a separate shared
library, libicalvcal. As libicalvcal depends on libical itself, first
check for libicalvcal being available, and if it fails, check for
just libical.

Closes: https://github.com/bluez/bluez/issues/2090

Tested-by: Bastien Nocera <hadess@hadess.net>
---
 configure.ac | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 52de7d665184..1cdd551f61cb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -306,7 +306,9 @@ fi
 AC_ARG_ENABLE(obex, AS_HELP_STRING([--disable-obex],
 		[disable OBEX profile support]), [enable_obex=${enableval}])
 if (test "${enable_obex}" != "no"); then
-	PKG_CHECK_MODULES(ICAL, libical)
+	PKG_CHECK_MODULES(ICAL, [libicalvcal >= 4.0.0], [],
+                [PKG_CHECK_MODULES(ICAL, [libical])]
+        )
 fi
 AM_CONDITIONAL(OBEX, test "${enable_obex}" != "no")
 
-- 
2.54.0

