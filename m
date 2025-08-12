Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141957E792;
	Tue, 12 Aug 2025 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755002806; cv=none; b=LcF8PCAUPjjyHqdYBaE12DL6qTKzl1yQj8oa/8MiNY8A9yKWlrGZn1bdlcVy2SVw3+Inqy1KQHyctHSHoXpiQz4rUfjme6EBZVJmmESJk+GzO4WrA9RGfQk6TAQyDFKYtX3RJRjTO7bmHFcRYprUs/7D9dRyvO5oxx4nXUHyekc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755002806; c=relaxed/simple;
	bh=lvRoGB489K2AfODPGly/9IpCKfkSjFTL8HjlrnWhjas=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RvZUO52mM8QIQgnFfFJdPXJRSUjWSE21CnMSl/54PHIZS44O9axgQ+S0MmagNUqYRJ/Fp4eOkRCUfNn80imHDaP1fgYcLgobdFRIPJj77+w8aDjsUEs2gOgO65IWZ1qZS4uvMpfFoJRbwsFboElmFjbQoQJVlMiiUc63HfsRWVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=c2HiOD4q; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="c2HiOD4q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1755002773;
	bh=/VFTw3DTFZynnDkAv1wj1bFyH7e2eQWzE2xYe6c/ZOg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=c2HiOD4qcHZqILOp6Z9p9IvUepvyTv1OyKvexTGPQJbYkdkNBCx3kroQTPKxQgiCc
	 +c93AAIuLZjm9ykjr05Nxcxkmoz98QP40JKTEQM+4d93/tTAOKsw+L0nY7YlxR8TCp
	 80zH+cCvgpvh+cnsTAL4DDeGqGkEQcSKhBlW4x6w=
X-QQ-mid: zesmtpsz7t1755002747t24630221
X-QQ-Originating-IP: Sql1TcudInrYL8zxoK7kUGvu7fQh3mvrnC7BwoV02vs=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 12 Aug 2025 20:45:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5415598875737750958
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: luiz.dentz@gmail.com
Cc: kiran.k@intel.com,
	vijay.satija@intel.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Guan <guanwentao@uniontech.com>,
	Jun Zhan <zhanjun@uniontech.com>
Subject: [PATCH] Bluetooth: btintel_pcie: Remove duplicate BTINTEL_PCIE_MAGIC_NUM definition
Date: Tue, 12 Aug 2025 20:43:08 +0800
Message-Id: <20250812124308.2504833-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: OYpbVsTx4C81wkYC60aT9wpHcTXPZOqcKEXCh1gXTDExeWiMgd432Y6r
	ugag9GwLn1qsKWRn7CnFyoMJZzEic4YdX/VOmpfYrcoaQksCAx+BGSMsTVhFGJEWNe5sdN7
	Znq6uYm/0vGTjSKC5f6nC+9Ein2lxI064dhfjG8gXXoRRVYXjPJ/kCHmbcJlXmQD/TfZw1l
	MhGFVphi6fODyEIYSASaUPMge0rcX5QBV9LxvTOyUXIpAoPMeZgPjxmbLDO+NDzxe03KAgl
	HdnLxaWuYj1vRvARHE8LFpzhJyx98GNRpXEGXeBB2h6U7/JnlN5rfvPiApNN1uh+f/bgDa2
	YOHJKET3X3Ji96qtvXlXNpfXKwb9aoQCE367ZhXJ2aM7cAfGUJ8FGHipKH2mbo+o02ZAdFu
	gkXXv0XHVCPmgl+0ltO7GFGkV6IuHrUyBQoXBJE63OY1zzlBteCMOpeFlhLWOrD6dnBQbVr
	RfFRMBqdOXItU8kZfaW+f0ndSwBjddyjzjYdS8uc0FCVaKvvTc60LKBoXXy04yh+1g+VN6B
	QUbHSSGh38/eKkAZeWLs7z7jbkCfxnxVS8HZsqa4QrL/DhYoXPqmDOHYvGpB+N53eVeHxZn
	xu3ROB6lPo9Y4MzL4vPSGqnDndHvDj/NrBDeDFPwwTF2ewUP0nDFpQ7rbiLNMVsErLIS26f
	BUtnJ37tmxH+BDiiVVRCShOqu0ehSeGCo9mFnS38EF8GBgEy35RI8Ybsuzeav4eAzKC734S
	RbVB4ABsYpQJHqPC6m9PhS+lhtKDb5aePksC37byeYCJphJL9ypqwBUwx+zcJYVWc54WII0
	7I911RfzC08z0aGwi5LD6ic0mos5AaTl45Cs/sqyNVV9AePedKfVbmcab5ujOO21YT75NQL
	lag1v/9YfrgM29oCGlUgBkz1sxhe3490nREOCs4AqvQ0l4AEiaumoO4tzKdcJHoBhGrHVrr
	4cjB4Oqm2Fy0zZ0pGGYXzGrbxMcyfN/4BBltYKO8dZc3i/eMO3G4io/pd3HdKo0cYj5Szo4
	59az6q4cj+Tlp8F/YMSdhP6N07HFWxXFyj6DrOkbFiMOyYx9CM
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Remove the duplicate definition of BTINTEL_PCIE_MAGIC_NUM macro.
The macro is defined twice with the same value (0xA5A5A5A5) which
is redundant and should be cleaned up.

Fixes: b9465e6670a2 ("Bluetooth: btintel_pcie: Read hardware exception data")
Signed-off-by: Jun Zhan <zhanjun@uniontech.com>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>

------
PS: I don`t know why not show a gcc redefined warning or error?
------
---
 drivers/bluetooth/btintel_pcie.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 6e7bbbd35279..758fbf3fb55a 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -65,8 +65,6 @@ struct btintel_pcie_dev_recovery {
 #define BTINTEL_PCIE_SCP_HWEXP_SIZE		4096
 #define BTINTEL_PCIE_SCP_HWEXP_DMP_ADDR		0xB030F800
 
-#define BTINTEL_PCIE_MAGIC_NUM	0xA5A5A5A5
-
 #define BTINTEL_PCIE_TRIGGER_REASON_USER_TRIGGER	0x17A2
 #define BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT		0x1E61
 
-- 
2.20.1

