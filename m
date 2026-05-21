Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB2B1A6806
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 06:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779343777; cv=none; b=ZEmYYjq60HD22xOgGGWxbk/QjG6GP8lcSZU7Kx9AoB/CixFTRQ8wSuVUjeevg1yYgjtn8MVu9NsLhzHKK6WGMz/VZYQekOIofdh7UfdbUHqD1NuCRuknm0aaRuCK+lUcxcJWUzTwTOFuWZ+c+bfIlMJVvey2G+FNUzD3Zwm/5Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779343777; c=relaxed/simple;
	bh=wBTrPpz9TJa+8HtBIApobZHQ5SJC1J/dqr5xchxsV8U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nXs/89nSB1JTSXcdG0n2Z5jR9UtOB3sTgcN8q+AJG82iRg6WR1Tx7C///n5506h8Vo730UlcLV81VPgJavsmDFBMCLJrUPNGWnJQtmK6auZTMQTdUBBg4EZWhQ3f/zBO26wrCNfw88DUVLWG08vTc5k0FAO9Vwaukvi5I/AY6+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ikLfHMg4; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ikLfHMg4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Tz
	TByhR4OMC0xR1LpSVP4d+6nOsnEMdbAahU+UUPBgc=; b=ikLfHMg4ZhH8r0AcRu
	SLuGR3EiNCEtT5kKIGTNwHAIqALXB32nhlsGhR9yakoRPbqEEtB9oD0IVgf0PWid
	zfE88DzN8raAI8jyYi4Qo/3fQC7I9Rgbn2/7fKCGMY8qEVYeQdCTw0UZ4dPKM6qi
	5PiVzR4brKwNLYsz7sJ8/vXPU=
Received: from A207080518.realsil.com.cn (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAnc5qSoQ5qqoR8Cg--.59506S2;
	Thu, 21 May 2026 14:09:24 +0800 (CST)
From: michael_kong <kx960506@163.com>
To: linux-bluetooth@vger.kernel.org
Cc: michael_kong <kx960506@163.com>
Subject: [PATCH BlueZ] doc: Fix Data Path direction in btmin-le-audio.rst
Date: Thu, 21 May 2026 14:09:19 +0800
Message-Id: <20260521060919.2124-1-kx960506@163.com>
X-Mailer: git-send-email 2.29.1.windows.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnc5qSoQ5qqoR8Cg--.59506S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr47tF43CF4fKw4xJrW8JFb_yoWDGwb_Ww
	1rJFyxArWqk3sxK3ZrXrW7CFn5u3ZrCw1Yg3WavFnYkFn3Awn0yanFqrn2qF92vF9xXFs8
	ZryjvFWDAw42yjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRE7KIPUUUUU==
X-CM-SenderInfo: dn0zliqvqwqiywtou0bp/xtbCwxSrZmoOoZQ+UwAA3m

The Data Path direction 0x01 should be Output (Controller to Host).
---
 doc/btmon-le-audio.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/btmon-le-audio.rst b/doc/btmon-le-audio.rst
index 50ee11879..47213c92e 100644
--- a/doc/btmon-le-audio.rst
+++ b/doc/btmon-le-audio.rst
@@ -454,12 +454,12 @@ On success, the controller assigns BIS connection handles (0x0010,
 
     < HCI Command: LE Setup ISO Data Path (0x08|0x006e) plen 13  #140 [hci0] 0.500003
           Connection Handle: 0x0010
-          Data Path Direction: Output (Host to Controller) (0x01)
+          Data Path Direction: Output (Controller to Host) (0x01)
           Data Path ID: HCI (0x00)
 
     < HCI Command: LE Setup ISO Data Path (0x08|0x006e) plen 13  #145 [hci0] 0.550003
           Connection Handle: 0x0011
-          Data Path Direction: Output (Host to Controller) (0x01)
+          Data Path Direction: Output (Controller to Host) (0x01)
           Data Path ID: HCI (0x00)
 
 **Step 8 -- ISO Data flows** on BIS handles::
-- 
2.29.1.windows.1

