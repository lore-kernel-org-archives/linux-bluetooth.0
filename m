Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B46E47F5D
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Mar 2024 14:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711118330; cv=none; b=KqjaLzU5V7z+6nz7ijkNYGmtCD7m/+3MUTHQ6wGlPoEL48RV97miv4ISxJ2WdN6VYZHRquAgKOfSQ0Ldw8y9y5Y/NPb4syA/UDVFmEgoGxYdYYOytbEjFWsVG99mGbOdE7CVTrqUVPcQRflRlIjI+462ABJcHmMvNL95xK61jg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711118330; c=relaxed/simple;
	bh=src+WaGSgLX7scvyppQr1O8bWgruike09lAr2xHi9r0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LY3l4I98wkMsXMyL8qhFNiuLN7mtgNTBh9iEysO2IlWeerXu6om8UFheaX6adRF69qlr7MdX2lGVXMVZ6JedYG98EFv6MwaLYz/YhzZouTd199tkMYSlob2Hqv7AQSIEOnZY50GkNd9MxUzUa+LUFKFKqC75j8gb/TRZTtUEaH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=XMvuyVuH; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="XMvuyVuH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=X1loo
	rMf+QvlOFhsm1qxJ7wrN3yiqLfmZe22Cq60aZc=; b=XMvuyVuHMeulso/qfR3or
	FZTUlSP2E6wjk6SXhvpF/NmGZvkKnmAP6v5kq7kXB+WadKLnXUr6y17+WbNgPcJD
	v5D/Xxv7wDaCFYiEfsrUoPSAacc7fJMTVoNuTDEbJllHKUuHqDiDKvP8+TjllUBL
	0sBB6ygccvRayIS04kzSvg=
Received: from localhost.localdomain (unknown [58.22.7.114])
	by gzga-smtp-mta-g0-2 (Coremail) with SMTP id _____wD3n5_pl_1lmkIWAQ--.55737S2;
	Fri, 22 Mar 2024 22:38:35 +0800 (CST)
From: Xiao Yao <xiaokeqinhealth@126.com>
To: linux-bluetooth@vger.kernel.org,
	luiz.dentz@gmail.com
Cc: Xiao Yao <xiaoyao@rock-chips.com>
Subject: [PATCH BlueZ] avctp: Remove redundant UUID checks and additions
Date: Fri, 22 Mar 2024 22:38:30 +0800
Message-Id: <20240322143830.1476938-1-xiaokeqinhealth@126.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n5_pl_1lmkIWAQ--.55737S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFW7Xw4rGr4kury3AF4Dtwb_yoW3WFc_Z3
	s5ZryUWa18t34vvF43Xw4UXr9aqr4Sq395uas3trn7KF4UXrWYgw17ZFWYvrn3u3Z3Cry3
	ZFy8ZF45KrnxWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRReOJ7UUUUU==
X-CM-SenderInfo: 50ld0yhhtl0xhhdo3xa6rslhhfrp/1tbiEBap1WVLafNveQABsZ

From: Xiao Yao <xiaoyao@rock-chips.com>

---
 profiles/audio/avctp.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 8ad146df1..6199ee951 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -1597,12 +1597,6 @@ static void avctp_confirm_cb(GIOChannel *chan, gpointer data)
 	if (session == NULL)
 		return;
 
-	if (btd_device_get_service(device, AVRCP_REMOTE_UUID) == NULL)
-		btd_device_add_uuid(device, AVRCP_REMOTE_UUID);
-
-	if (btd_device_get_service(device, AVRCP_TARGET_UUID) == NULL)
-		btd_device_add_uuid(device, AVRCP_TARGET_UUID);
-
 	switch (psm) {
 	case AVCTP_CONTROL_PSM:
 		avctp_control_confirm(session, chan, device);
-- 
2.34.1

