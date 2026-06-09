Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C597B33ADB9
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015025; cv=none; b=Ym07TL1MnloMxUqSjn8IW7DXNJ+uCORicDD2RXHEwH/gUU5qz9Fx0KHsVLHRSyAGKjcIuoTdaIkcI7/lOZvLi7Q2wUQRzKYhx4ejh6gGlsgq2dn5q8TOfst2u+MlU2OvCBVXSR+UwOSjFXbSbUeHvl0JY+qVQdl0mgfWbz3EqiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015025; c=relaxed/simple;
	bh=f5k+UBbddWMtu4uYixxu0BXMZ3Qs0wI3HE8o0YFFDkU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EWb6dXMgQgGmHwrG1s5JplF9S6rE9Cvl/oJhS8nNzjA5icezAbs4wZtketCK0k92gdt6ibF20HoTWSN4vgYT5zhgCL0at+8TmoHBJkVhyV/Mh3+W3Y/ZcTM+x4aJZDHSUI3cjDmwnLq/OFbkr69hzlUkeFwkSYzn1jJI7X9Pcbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 37B7B5814DE
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 13:58:52 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9DA9E3EDCE
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 13:58:45 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 1/6] shared/util: Fix warnings when cleaning up NULL pointers
Date: Tue,  9 Jun 2026 15:50:53 +0200
Message-ID: <20260609135837.476561-2-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609135837.476561-1-hadess@hadess.net>
References: <20260609135837.476561-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTEVlSdXhFUvSV8QQx6yOrxge8LgLVsxPuUsLns/yksmkNx+qdDvLvza5bKGN8WNxSHwt+f8VbZ4lJPoURNdRMWp8SMuewEQUfgBMkY/jbgr+LyXuM7iW1giNJiHgNHw6TWCI3u/pWopj0uku4KXuEzF2U7Jkv7EHtBXrrJV7gBwCRlXQDiK2LO8ylQk6uzIFcjqpCrorpKwg3w0D6ojMjAneIde2+9Xgn2LOidAqfgBRNsXEa58H2+xUe5E0Ri8LlvlWBN+ajBkbQKIGVS8FIytq/3m1RxPUluCTzu51875p3iUUbERbtkhDOOaRjgxLdx7vcvY3Bj/fS1GlcpyS/+RiZefJYnSCAHMG3wiZjxPX//tFrFVkMmwgjhncYh8ECQ1lHXYVX0FVgeYPwxavWMXO1gNv0TI1Kb8K4OH3cUMihIS2+juUgvq+zFLakM9DxpUAqqJ042dB3XMPtmucO1IypaROWyy1FZVpFs+d+1tRs1EknPlilP43TJnpATZbtc49LoPRMFj7P9C5/SuvogYlXoYV77dPw1PUBSRtDxH67doh5Gxy40D4+VOsn3z+LMuplE5eoQ634JluhslsQRQZ9SRZREiliVbeaFOsiYsdk3wdSEq2a0tS+ysfGGxhAe4DDGCEO7wKROoSplv4Bq0haF71Gi7zbi/zHjqAPFDWw

Don't try to free NULL pointers in cleanup callbacks, some of the
functions we use to free pointers might not support being passed
non-NULL values.

Fixes: 2e0533f977cc ("shared/util: Add helper for "cleanup" variable attribute")
---
 src/shared/util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/util.h b/src/shared/util.h
index 562a5af31751..dd8e5288f55b 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -127,7 +127,7 @@ static inline void closefd(int *fdp)
 }
 
 #define CLEANUP_FREEFUNC(type, func) \
-	static inline void cleanup_##type (type **_ptr) { (func) (*_ptr); }
+	static inline void cleanup_##type (type **_ptr) { if (*_ptr != NULL) (func) (*_ptr); }
 
 #define _cleanup_(f) __attribute__((cleanup(f)))
 #define _cleanup_type_(type) __attribute__((cleanup(cleanup_##type)))
-- 
2.54.0

