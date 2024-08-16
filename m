Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6561F143873;
	Fri, 16 Aug 2024 08:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723796869; cv=none; b=mx8XUZz05p2D66M2oVqsYQ5cOf4MI6Ps/9Lt5VWcDrXyfgAnXV6wQTmZ7G4G31QhTSIbmBc2vJ0r6OWoLvtf1jt1NgPnLyb9isQE5z5ViygAPWnPItkqPZvvm08NutB+JnaepOb/mv93cGa3jkCzmHCLWuNpC+zMJsSPu6gjGXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723796869; c=relaxed/simple;
	bh=/x7LFb4LrOciivV1kVUK7gY0Gm8F8suaP/n+NQUB8Xc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IcFs550Kk/550hdtgzTDH6rU/QWWjQpWwecZAGZcqAYeyu1D3O+80ssPyAwrjsVz6A428VM9yPnncsTKbk5ZuGT2PzOksRjAIXXG5sHi5TdYlVvziqXQfG8oaaJW8q9xX9qj62sNss/3wG2zcXY15mhfjlGnvBSsaUGYKEz93NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9EA9020179E;
	Fri, 16 Aug 2024 10:27:46 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 52FE9200DC0;
	Fri, 16 Aug 2024 10:27:46 +0200 (CEST)
Received: from pe-lt8779.in-pnq01.nxp.com (pe-lt8779.in-pnq01.nxp.com [10.17.104.141])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id ADE18181D0FD;
	Fri, 16 Aug 2024 16:27:44 +0800 (+08)
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	rohit.fule@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	ziniu.wang_1@nxp.com,
	haibo.chen@nxp.com,
	LnxRevLi@nxp.com
Subject: [PATCH v1 2/2] Bluetooth: btnxpuart: Add support for ISO packets
Date: Fri, 16 Aug 2024 13:55:24 +0530
Message-Id: <20240816082524.286245-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816082524.286245-1-neeraj.sanjaykale@nxp.com>
References: <20240816082524.286245-1-neeraj.sanjaykale@nxp.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

This enables btnxpuart driver to handle ISO packets.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index f75b24bd3045..0b52e5505687 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1396,6 +1396,7 @@ static const struct h4_recv_pkt nxp_recv_pkts[] = {
 	{ H4_RECV_ACL,          .recv = hci_recv_frame },
 	{ H4_RECV_SCO,          .recv = hci_recv_frame },
 	{ H4_RECV_EVENT,        .recv = hci_recv_frame },
+	{ H4_RECV_ISO,		.recv = hci_recv_frame },
 	{ NXP_RECV_CHIP_VER_V1, .recv = nxp_recv_chip_ver_v1 },
 	{ NXP_RECV_FW_REQ_V1,   .recv = nxp_recv_fw_req_v1 },
 	{ NXP_RECV_CHIP_VER_V3, .recv = nxp_recv_chip_ver_v3 },
-- 
2.34.1

