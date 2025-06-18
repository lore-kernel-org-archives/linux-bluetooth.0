Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94FD2DF3F2
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750260568; cv=none; b=fMKKbWE4L1a2pYLzP5BWTczJZh7SDj0gSjckZUFAnNPB7k7Bk7TEJqNkXLpKOEtLb2Z6tx9Acdq8TYLkem8BACPXqOhjaCH4pYYM0Hm511py3zo9UUIhEUzKQkhJujUDJM+JSBRF2n4RmMm0FV80N32MjSgr6XlNgzhpNJHyaV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750260568; c=relaxed/simple;
	bh=aRP7YNiAdZEVblyh9bLebwafkiOFAxszmsYr4VoPlqY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E/96Z81g2EsqPtWrm1T6Co3CfB70BSfVPyUIITiT2vuj725UGka4dnMa0dK/8IembgJ4PoBuvh4GH1mYei38f5HUUr/70tlk81L589FPnoRIQwqn3gcetd0PrsczTuOi2NmVGEGZAENsWAJSa3F+hwyjieSfxS2qos9cI+e+db8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZzeO3DNo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZzeO3DNo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750260563;
	bh=aRP7YNiAdZEVblyh9bLebwafkiOFAxszmsYr4VoPlqY=;
	h=From:To:Subject:Date:From;
	b=ZzeO3DNoq7PK6ADCIVQZ7A7/DQxIk6wCLScykmLLWw/fFDcKHI1HFaZHgCsOA/utc
	 euEhra3tS4AGjqzeGTM09vKAcLyIGoiaS9GSE2pyBZjx7wXMbIkh1cjrTuX/uy/zJR
	 olnIGqjSu7Kk19nc1Czoken0lmPphB1YeSA/Ucr6RU+ylUZdLxDiDtKvSB8LeDM+v3
	 1vPE4LjDPOu1LpYLlQ+HgTcb2A0q+1ULLbDfN/nriXdIaCeOjB9FAzFR7FfDMiout2
	 QitISeKqtIps/H2dRpgMuKRa5JFLNE4RlyWttqQ85auepQFoUyxyLPtNjnFcY0GnWN
	 I8j7mOCdTA/vw==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-Af44-1001-b057-D04c-Ab87-D2BE.rev.sfr.net [IPv6:2a02:8428:af44:1001:b057:d04c:ab87:d2be])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C6F4917E0649
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 17:29:23 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] device: Fix memory leak
Date: Wed, 18 Jun 2025 17:29:18 +0200
Message-ID: <20250618152918.220245-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This frees the LastUsedBearer string to avoid memory leak:

Direct leak of 12 byte(s) in 2 object(s) allocated from:
    #0 0x7ccf538fd9c7 in malloc ../../../../src/libsanitizer/asan/
						asan_malloc_linux.cpp:69
    #1 0x7ccf53665b09 in g_malloc (/lib/x86_64-linux-gnu/
						libglib-2.0.so.0+0x62b09)
    #2 0x7ccf53659b90  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x56b90)
    #3 0x7ccf53659cd4 in g_key_file_get_string (/lib/x86_64-linux-gnu/
						libglib-2.0.so.0+0x56cd4)
    #4 0x5c8c691f2811 in load_info src/device.c:4225
---
 src/device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 902c4aa44..e4d5d79ee 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4224,10 +4224,12 @@ static void load_info(struct btd_device *device, const char *local,
 		/* Load last used bearer */
 		str = g_key_file_get_string(key_file, "General",
 						"LastUsedBearer", NULL);
-		if (str)
+		if (str) {
 			device_update_last_used(device, !strcmp(str, "le") ?
 						device->bdaddr_type :
 						BDADDR_BREDR);
+			g_free(str);
+		}
 	}
 
 next:
-- 
2.43.0

