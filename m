Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E9E364B5
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jan 2024 10:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705831469; cv=pass; b=d5J+Zuzi2NozIETAZHdH9rMtNeT8dvJROVlPiKKTXFSauxwsucPaZfMCXP/oCJSJ5dNOPIWRM5BjicJtveE86F7Xe2VY8gI2d+kFxscSAwix1k5tlHj1WM64DVtKRx8ZA5pyeb5iwORdypGhu37uSXzx2MG/f8h3Tl9h3ykTg1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705831469; c=relaxed/simple;
	bh=hEDMmARFMwo8nd4gZMvYeFJzn7xmZ3PgRXRkOeLMksk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z5+NMCKIlo8a+4tR78LCT50XGgNRjKjiFdowvV13K/36KLwiUxuqQueFDcBXXjrKO1aWuikCUO7QYGaGPfc18xVUZnhs5D1XXRJUbGDhcNzTByxviw2ZBP/BssTx8hyNrtoKJCwn9gxCZSCOy888NhsOWNgwrzZBqehoxfhrZ5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lab.zgora.pl; spf=pass smtp.mailfrom=lab.zgora.pl; dkim=pass (2048-bit key) header.d=lab.zgora.pl header.i=mk@lab.zgora.pl header.b=XR1BpVzI; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lab.zgora.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lab.zgora.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lab.zgora.pl header.i=mk@lab.zgora.pl header.b="XR1BpVzI"
ARC-Seal: i=1; a=rsa-sha256; t=1705831464; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=h875/isVzX3TwegLCvzy2MoKAKxkIscjLtvEdBqW19cyRIyc9PDN1NbbAxYWm4m/jYzpFKHKtrAXeSSFstD2o1CTNilkMGkr5x36f3vKokZ1lqPkvAYmbH/7msqivABb7sLfJ6iKF6Hd99MmhCY2eAa6opJEcpxlubbrp5CiNcI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1705831464; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/hrJzDrd9QMRCUeKIcsVEMQ97JS2VY0Ht8lJtSJdjlo=; 
	b=HKqQ1V7VG0n/FoQPEgO5mvFmOt1NeZDzQ8Le+I/4wjbBTtF4vDHyKPYLrEp6u82V+OwEkZy1qS46wsnhdabHXaQlWJVCRTulEPyPl04joP9rX0lBRbeVAbtWDCGrljZEcGMqInzQYSDNQXIcU/whK2czsaebIeaUtUpx4ssICAw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=lab.zgora.pl;
	spf=pass  smtp.mailfrom=mk@lab.zgora.pl;
	dmarc=pass header.from=<mk@lab.zgora.pl>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1705831464;
	s=mail; d=lab.zgora.pl; i=mk@lab.zgora.pl;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=/hrJzDrd9QMRCUeKIcsVEMQ97JS2VY0Ht8lJtSJdjlo=;
	b=XR1BpVzI+R2HergKuy3+iNdpi11fDMwTLe2373Hwfj5PTXU+gOih3l4aQWK/n+qQ
	uZ0u+xSvZ/GzNM0NqFqaf2GgaeDCMvzyznEtspgc8ZVCb27RK91jts/TaBmXQC8eUnF
	w+io5IwbnonKSFDzwoTI+nupiC5WcdYTJJtv/hJVgXjsb+Yrq4S6c1Rbh+gRRMgclSF
	ABBMCRA6RyF39hBAaf/TjSNp1UtHLNZ9CRyMJSYvOouhNRWC++5S6cxsbdASfIF8gZ2
	zFuse/83rsk8LsGqNk+0tAGvX+h8rdIp+TM3ILbwrqw6dOiXmqcmwpo0FKDDcfydZoM
	P3ZU4dFoqg==
Received: from box.. (77-254-108-42.dynamic.inetia.pl [77.254.108.42]) by mx.zohomail.com
	with SMTPS id 1705831463019240.5137268587515; Sun, 21 Jan 2024 02:04:23 -0800 (PST)
From: =?UTF-8?q?Mariusz=20Koz=C5=82owski?= <mk@lab.zgora.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Mariusz=20Koz=C5=82owski?= <mk@lab.zgora.pl>
Subject: [PATCH BlueZ] btmon-logger: Fix stack corruption
Date: Sun, 21 Jan 2024 11:03:28 +0100
Message-Id: <20240121100328.1200839-1-mk@lab.zgora.pl>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Version 3 capability masks are 64 bits in size.
---
 tools/btmon-logger.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/btmon-logger.c b/tools/btmon-logger.c
index a770ad575..1f6db3751 100644
--- a/tools/btmon-logger.c
+++ b/tools/btmon-logger.c
@@ -161,14 +161,14 @@ extern int capset(struct __user_cap_header_struct *header,
 static void drop_capabilities(void)
 {
 	struct __user_cap_header_struct header;
-	struct __user_cap_data_struct cap;
+	struct __user_cap_data_struct cap[_LINUX_CAPABILITY_U32S_3];
 	unsigned int mask;
 	int err;
 
 	header.version = _LINUX_CAPABILITY_VERSION_3;
 	header.pid = 0;
 
-	err = capget(&header, &cap);
+	err = capget(&header, cap);
 	if (err) {
 		perror("Unable to get current capabilities");
 		return;
@@ -177,11 +177,11 @@ static void drop_capabilities(void)
 	/* not needed anymore since monitor socket is already open */
 	mask = ~CAP_TO_MASK(CAP_NET_RAW);
 
-	cap.effective &= mask;
-	cap.permitted &= mask;
-	cap.inheritable &= mask;
+	cap[0].effective &= mask;
+	cap[0].permitted &= mask;
+	cap[0].inheritable &= mask;
 
-	err = capset(&header, &cap);
+	err = capset(&header, cap);
 	if (err)
 		perror("Failed to set capabilities");
 }
-- 
2.34.1

