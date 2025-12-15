Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1442924BBEE
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 08:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765786905; cv=none; b=HxHVuTD4tJjkhvorjkSZy2xNol0/4YN+izAfj9GPXtuuC2+lHCQRCMmKh7eqgvlpxB+Y9uxXqV/I7X6lOdRyHGjBK5+ogado1hZrBFo8uYmpCdtZ/w3GdNePWBhSYlQXL67w5GRiAz2Q2/WuYENkVaAduINpwvs1sZDU4x2+p0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765786905; c=relaxed/simple;
	bh=cx8gLObsLSibZ9Bl7qFgxVmRpPOJKEsYpOGkITy2l3c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FD2dvNHv795NZqVVTjiux6JLun8H02WGSfAGsg6liX9737pMoJPi4NlC5DiUits44CIntqphm7atesOdt6+pa9VbthLEDLotSKi6Wwe/2ESfOMYJaxUgLLyGM6TmePO4UPkMLJKSSU2ugAheQqKfkCIuUIS2zcmFFEq/VOls+Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ia3eg8AH; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ia3eg8AH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=n+
	49jYxdp3do5cFHqmyyMWYr/vINrRYTlTzbbmkLIFM=; b=ia3eg8AHdlOcqFng/q
	tMEU8hWZ6uwwVqkLtfQ1GUlNOO56R7S8O4uo3r69yNxPXTyq3HnG2B+Jjz8e2AEU
	OhE/pDDFdvWOWlodeMPYOPpPM2ANo0BVWhxJtM0u/41xzx+3m3lF+U8AwB/urXEY
	oOXjEZu+uLeJVrRX3PtPvsXOo=
Received: from A207080518.realsil.com.cn (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wA3fjiExD9pTYA0Ag--.2835S2;
	Mon, 15 Dec 2025 16:19:18 +0800 (CST)
From: michael_kong <kx960506@163.com>
To: linux-bluetooth@vger.kernel.org
Cc: michael_kong <kx960506@163.com>
Subject: [PATCH BlueZ] client/palyer: Fix QoS 32_2_1 in lc3_ucast_presets
Date: Mon, 15 Dec 2025 16:19:12 +0800
Message-Id: <20251215081912.1245-1-kx960506@163.com>
X-Mailer: git-send-email 2.29.1.windows.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3fjiExD9pTYA0Ag--.2835S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFW3XF1xXry5KFy3ZF4rAFb_yoW3uFb_KF
	45KFWYqayktas5uanxtwnYqan3tr1j9r1xJr45Ar15ZF4jgr1vq398tr97Xr1Fg3Wjga1U
	AFs8u3s7Ca13CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUjbAw5UUUUU==
X-CM-SenderInfo: dn0zliqvqwqiywtou0bp/xtbCwwZ8N2k-xIZWqQAA3l

---
 client/player.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/player.c b/client/player.c
index b6b02a000..ea018fb9e 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1464,7 +1464,7 @@ static struct codec_preset lc3_ucast_presets[] = {
 	LC3_PRESET("24_1_1", LC3_CONFIG_24_1, LC3_QOS_24_1_1),
 	LC3_PRESET("24_2_1", LC3_CONFIG_24_2, LC3_QOS_24_2_1),
 	LC3_PRESET("32_1_1", LC3_CONFIG_32_1, LC3_QOS_32_1_1),
-	LC3_PRESET("32_2_1", LC3_CONFIG_32_2, LC3_QOS_32_1_1),
+	LC3_PRESET("32_2_1", LC3_CONFIG_32_2, LC3_QOS_32_2_1),
 	LC3_PRESET("44_1_1", LC3_CONFIG_44_1, LC3_QOS_44_1_1),
 	LC3_PRESET("44_2_1", LC3_CONFIG_44_2, LC3_QOS_44_2_1),
 	LC3_PRESET("48_1_1", LC3_CONFIG_48_1, LC3_QOS_48_1_1),
-- 
2.29.1.windows.1

