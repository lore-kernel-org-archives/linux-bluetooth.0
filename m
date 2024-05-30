Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D7F17C214
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 May 2024 15:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081264; cv=none; b=P6M6Ogfc2+uz6CPjWKVF3UHxqxU6RfZzQ7fdbB6MwFxs0XU81FwKv2x2ru+IcaxdyPi1OQDw0SEmFu58CB/uGJ4pUuzUOoqgtsO+LffOkfANhiH0vQEBZBAmDBD3iPuz/NC7QS/JM7bpcxHq2jl4dSksQ7p8Lm44+ya2r9KqG7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081264; c=relaxed/simple;
	bh=nRdVYVVSmZ2ZAu8GRAxcCR1c4rYFBz0G2V4WoL8zsrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ep0Fag/wnuF9pisSD1WrVa06mTembMhUNUToywdXvYDV0hERSQ2Davrd7arm5ve39BZ7zjzMLRbFTk2mU8TJ0Ep3k+Xtn7j/xqqEtFzpMYUxkwegmZxBHMlRudcFu0UijWjN4xQtehBTRwmH34A4Z1QnltUbkL9xUZpmasiqEGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id A81A520011;
	Thu, 30 May 2024 15:00:59 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 7/9] obexd: Fix buffer overrun
Date: Thu, 30 May 2024 16:58:01 +0200
Message-ID: <20240530150057.444585-8-hadess@hadess.net>
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

Don't access path at byte 2 when it might only contain a single byte.

Error: OVERRUN (CWE-119): [#def27] [important]
bluez-5.76/obexd/client/session.c:1135:2: alias: Assigning: "first" = """". "first" now points to byte 0 of """" (which consists of 1 bytes).
bluez-5.76/obexd/client/session.c:1142:2: overrun-buffer-val: Overrunning buffer pointed to by "first" of 1 bytes by passing it to a function which accesses it at byte offset 2.
1140|		req->index++;
1141|
1142|->		p->req_id = g_obex_setpath(p->session->obex, first, setpath_cb, p, err);
1143|		if (*err != NULL)
1144|			return (*err)->code;
---
 gobex/gobex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index fdeb11c65130..40d6b8129b00 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -1611,7 +1611,7 @@ guint g_obex_setpath(GObex *obex, const char *path, GObexResponseFunc func,
 
 	memset(&data, 0, sizeof(data));
 
-	if (path != NULL && strncmp("..", path, 2) == 0) {
+	if (path != NULL && strlen(path) >= 2 && strncmp("..", path, 2) == 0) {
 		data.flags = 0x03;
 		folder = (path[2] == '/') ? &path[3] : NULL;
 	} else {
-- 
2.45.1

