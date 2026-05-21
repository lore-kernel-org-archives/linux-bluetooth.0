Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33271358381
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 03:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779334111; cv=none; b=l3EY/gsZv+c2GJ8NPRp03y/fWeGYpHdQu2YfMPa5STleuyTFEd0qS/K5Qu3QlNLT1qpuF0Ob7sCfPLmw0K5rBGnTsVcSEbCvR5J0lMIX/kkGoIBypozF7vW8w6OMbHhNvmvImeelFV+Qw8ZCdtOf2Te1kUGLfDwUhaiAbVHePLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779334111; c=relaxed/simple;
	bh=k2VtKvu5ZJbj0TPg8qgnhQHgW+9+78GpY0lZD69k2Mc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eKccNgKta0MN4ojyEsN1KBbKCQKSdd+IkZ3ErV/Gv0EtaB7CKf88e5ha+N9yvZ59/LphrzHQTMT3HMzKE+JKzdEFZP2mOxdnNnnRMAvvSTkpCV/05gvs5RmapOGpS7L4U2JoOnIvBZc46/UWNqzCQLLrDmFS4Lkl5s6nEGVPB8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=C8NdXwxb; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="C8NdXwxb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=WU
	ujVupB3Bwc43yuwQjAV2rzKmVw07zLFLexWmFudsc=; b=C8NdXwxbkZu3K4FDch
	mruFj0+cP1/uT/5WMQmGjExmYS06XYJuLm/Ap2y99NcQtGSzqGotMzMWrX0AfVla
	zVpRbOerOVitquVxmlegiL7Q9QWnWIxiZO2TvzdUHTXjkXz3D0IVRRlfuwSfnWJ2
	bhOyNP0Ckx8TMSqtcxfFUzLcE=
Received: from A207080518.realsil.com.cn (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wB3VeHTew5qUYFtCg--.57035S2;
	Thu, 21 May 2026 11:28:21 +0800 (CST)
From: michael_kong <kx960506@163.com>
To: linux-bluetooth@vger.kernel.org
Cc: michael_kong <kx960506@163.com>
Subject: [PATCH BlueZ 1/2] shared/bap: Fix unused value in qos
Date: Thu, 21 May 2026 11:28:14 +0800
Message-Id: <20260521032815.1845-1-kx960506@163.com>
X-Mailer: git-send-email 2.29.1.windows.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3VeHTew5qUYFtCg--.57035S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw1DAFyDGF1xWw1kuF4fAFb_yoWfXrgEq3
	s7Jrs7GFWYyay0gF47CFn0yay2vwsYgw18urWvg392kayUXFWDAF48Xrn2yr4UWr13uFsx
	G3Wkur42yFy2gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRiDGY3UUUUU==
X-CM-SenderInfo: dn0zliqvqwqiywtou0bp/xtbCxBUy7GoOe9VCFgAA3R

In bt_bap_parse_base, PresentationDelay is parsed but not written to QoS.
---
 src/shared/bap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 78ba22259..bd523e5e6 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -7655,16 +7655,15 @@ bool bt_bap_parse_base(uint8_t sid, struct iovec *iov,
 			bt_bap_bis_func_t handler,
 			void *user_data)
 {
-	uint32_t delay;
 	uint8_t sgrps;
 	bool ret = true;
 
 	util_debug(func, NULL, "BASE len: %zd", iov->iov_len);
 
-	if (!util_iov_pull_le24(iov, &delay))
+	if (!util_iov_pull_le24(iov, &qos->bcast.delay))
 		return false;
 
-	util_debug(func, NULL, "PresentationDelay: %d", delay);
+	util_debug(func, NULL, "PresentationDelay: %d", qos->bcast.delay);
 
 	if (!util_iov_pull_u8(iov, &sgrps))
 		return false;
-- 
2.29.1.windows.1

