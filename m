Received: from mx4.sberdevices.ru (mx4.sberdevices.ru [176.109.96.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8162299A94
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.109.96.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762518494; cv=none; b=kk6q025YAr6wsCANj72976zm/EwhaALLNFVdbVzKpGCqy4vQrBhJDBvGeRNYtxOYzus2JisXw7+yxV7ApsKvh3a18RKSjw2Yj3WACS78tlDWk9AuhqatiDPuei8Oo5ZBWEEL8FLt0vyzr7iXgYONAIxqW6OF6jKIv65x2oQQltQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762518494; c=relaxed/simple;
	bh=hxHKV/SqHgzbPEIWVb9UPDqMzQvyrKoka0N+sHC/m/I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OlV/bqyq5j8zPheG7LMw8g9SPguIbJ7ngxdtre/EOK5IJl6FedXV3ZzdcQhn7bo53axLpzW7RxXG5H4mg5uL4l3ig0rjaZF63HRyCTWoBoAkGTtYT0mrxbIWzycAW3MqfriBnSfArVBsOqnHgpP7Jc57g3UAWOVnXdjd/j1sH0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=JdCk86sF; arc=none smtp.client-ip=176.109.96.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="JdCk86sF"
Received: from p-antispam-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx4.sberdevices.ru (Postfix) with ESMTP id A6C9240059
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 15:28:06 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx4.sberdevices.ru A6C9240059
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1762518486;
	bh=4Di2YYASedd4ORpnRJ+tS2cIV040+0GjsXjHcz36dxg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=JdCk86sFthZli7lJozYpU6blkPbzytjS6YH+9cI8z03s7CKMql4mJPpIjNHsa4BQi
	 gEk0xbTLpRlX6Gl2KlPYrR3/NiWGp0LqytufqJw/akqE8PEH2X2DQgiAiJzX4AJ6iD
	 4ha+iyAHSoUuarhDU+ix/JB78d/LiF0qVLc3CLK6Oz/9auS8lziCPYJdirhpdHRbh9
	 3+AJihnUnsUFsUrt3ciiXG6Ht9ypx+Pj+RnJhtc6hfcfgtmk8cv+ev5lTxJ3JWMxfg
	 7oPVeXb5tETLeooyIMpHinNdpVZCyIQgs5PkAMUKtsQunWuUTWcXRZXkUOxmH3Y09Q
	 pHSM81/ebev4Q==
Received: from smtp.sberdevices.ru (p-exch-cas-s-m1.sberdevices.ru [172.16.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "sberdevices.ru", Issuer "R13" (verified OK))
	by mx4.sberdevices.ru (Postfix) with ESMTPS
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 15:28:06 +0300 (MSK)
From: Pavel Bozhko <pvbozhko@salutedevices.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Pavel Bozhko <pvbozhko@salutedevices.com>
Subject: [PATCH BlueZ] The GATT.Client option is in the wrong section.
Date: Fri, 7 Nov 2025 15:27:34 +0300
Message-ID: <20251107122734.228-1-pvbozhko@salutedevices.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-exch-cas-a-m2.sberdevices.ru (172.24.201.210) To
 p-exch-cas-s-m1.sberdevices.ru (172.16.210.2)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: pvbozhko@salutedevices.com
X-KSMG-AntiSpam-Info: LuaCore: 75 0.3.75 aab2175a55dcbd410b25b8694e49bbee3c09cdde, {Tracking_uf_ne_domains}, {Tracking_black_eng_exceptions}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 197878 [Nov 07 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/11/07 09:54:00 #27891999
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5

GATT.Client is currently in the CSIS section, but should
be in the GATT section. The bug is that
setting the Client option to false has no effect.
---
 src/main.conf | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/main.conf b/src/main.conf
index 4c53376dc..fa94cf97d 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -262,6 +262,11 @@
 # Default: always
 #Cache = always
 
+# This enables the GATT client functionally, so it can be disabled in system
+# which can only operate as a peripheral.
+# Defaults to 'true'.
+#Client = true
+
 # Minimum required Encryption Key Size for accessing secured characteristics.
 # Possible values: 0 and 7-16. 0 means don't care.
 # Defaults to 0
@@ -308,11 +313,6 @@
 # Defaults to 0
 #Rank = 0
 
-# This enables the GATT client functionally, so it can be disabled in system
-# which can only operate as a peripheral.
-# Defaults to 'true'.
-#Client = true
-
 [AVDTP]
 # AVDTP L2CAP Signalling Channel Mode.
 # Possible values:
-- 
2.43.0

