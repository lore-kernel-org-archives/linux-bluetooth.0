Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B1928F5
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 03:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765422175; cv=none; b=IjjXhjVs2oOm5iHp9u9QZbptFqHdKfFeWjZD8Ivt/nG2n0k/vxmydt9M3NgHhSxs/9I9VhreLFtOkJ9BS0Hxa0omXe5wXUOrMjH+CG2DpklCzhLwgR98KWmsq1P3scC5qG+iXLn5PhKLsZPmCWlkQm1I8tbg8A9FR4p1+k3JLSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765422175; c=relaxed/simple;
	bh=ar94NrkHbayYlPl3Zu+++q+03+DLGYFU+8YpKf4eZAo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WmCWJhy1DGmRZHlqKKaMMLur79308q7SjoDaLoh+tCR3kBTg/gXgUUaEHG08rGkvCaZlLI9JKYu7MoYr+MJQc1eympq0TnMYK/D8pzcfMVrW4F5yV1wfBiV0kSEql9+IQgRouHk5DEy05xFGMXXbgzTO67e2SfpqMhAkI2osauE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eTSAe6gc; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eTSAe6gc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=jw
	mazSDuRMZVJs9u1GjkJTc0cNUrlboPC90nn8ONbBk=; b=eTSAe6gcHAZ6tbbB0T
	3qbJ3CBClOkHIsEOxlwFL4W5tUHO527DORxiWoQemwAryFpPJ21RZZEK54dAB7+T
	+aKS+BsBHZCX5LkjFjs+megGUx5g65hyD0mA0x/VIlnjsTNWX6X/i2Ln7C8rXwHp
	e310ew2RVAfnDu/eTlGoFybo8=
Received: from A207080518.realsil.com.cn (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDHi61XNDppY+8CBA--.5077S2;
	Thu, 11 Dec 2025 11:02:49 +0800 (CST)
From: michael_kong <kx960506@163.com>
To: linux-bluetooth@vger.kernel.org
Cc: michael_kong <kx960506@163.com>
Subject: [PATCH] shared/lc3: Fix frame len in set 44_1 The frame len in set 44_1 shoule be 97.
Date: Thu, 11 Dec 2025 11:02:43 +0800
Message-Id: <20251211030243.1175-1-kx960506@163.com>
X-Mailer: git-send-email 2.29.1.windows.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHi61XNDppY+8CBA--.5077S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTR_-BMDUUUU
X-CM-SenderInfo: dn0zliqvqwqiywtou0bp/xtbC6xkMxmk6NFmtLQAA3G

---
 src/shared/lc3.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/lc3.h b/src/shared/lc3.h
index a6f65eede..cb78b668d 100644
--- a/src/shared/lc3.h
+++ b/src/shared/lc3.h
@@ -206,7 +206,7 @@
 #define LC3_CONFIG_32_2_AC(_ac) \
 	LC3_CONFIG_32_AC(LC3_CONFIG_DURATION_10, LC3_CONFIG_FRAME_LEN_32_2, _ac)
 
-#define LC3_CONFIG_FRAME_LEN_44_1 98u
+#define LC3_CONFIG_FRAME_LEN_44_1 97u
 
 #define LC3_CONFIG_44_1 \
 	LC3_CONFIG_44(LC3_CONFIG_DURATION_7_5, LC3_CONFIG_FRAME_LEN_44_1)
-- 
2.29.1.windows.1

