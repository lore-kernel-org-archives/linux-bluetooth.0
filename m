Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6D91974EA;
	Fri, 16 Aug 2024 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806933; cv=none; b=AVcyVeqg/tP/bNQ/zXlAxU1eb9xIEjxKnffl+TaYVlgQSlYPwShvJPfjBxExMEWAb4Qrpq46DgEhFOjtZNM5hg5QGcMqfc9tUmPWvksa6/cmc+aD6HA31+W4l2I4dvuHmGWScBsEYQgBbB+5wKMwhgn0is+WA2Y9n/nxC1mkgik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806933; c=relaxed/simple;
	bh=CmWm5Wz5/zD6YgQrWDv+Px8V/U0u8vGYCng4QqoEvhI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VI2t49VPr02lvSfKYz8/EYbQG7qeL9Awqxgq2mLqJnvVwotrzQpye9k2IM6eNFL+6lX9P1mFySObpXOk7/H4KYkP3KNGEC0PkgaaKPB2ZUTKOG7R4YiiicgiCcIZLEzHeqs9aOeFn/OEr3QE6or42sIOvY4pN3Kjj/kB7gg0Wko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 535591A0DB0;
	Fri, 16 Aug 2024 13:15:30 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0A6621A0734;
	Fri, 16 Aug 2024 13:15:30 +0200 (CEST)
Received: from pe-lt8779.in-pnq01.nxp.com (pe-lt8779.in-pnq01.nxp.com [10.17.104.141])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 6C4AA181D0FD;
	Fri, 16 Aug 2024 19:15:28 +0800 (+08)
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
Subject: [PATCH v2 2/2] Bluetooth: btnxpuart: Add support for ISO packets
Date: Fri, 16 Aug 2024 16:43:09 +0530
Message-Id: <20240816111309.287515-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816111309.287515-1-neeraj.sanjaykale@nxp.com>
References: <20240816111309.287515-1-neeraj.sanjaykale@nxp.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

This enables btnxpuart driver to handle ISO RX packet when DUT is
configured as audio sink.

Tested IW612 on iMX8MMini platform and BlueZ-5.77 as follows:
1) Configured DUT with bap_bcast_sink role in pipewire configuration file.
2) Started pipewire and DUT is able to sync with Broadcast source through
pipewire.
3) ISO data RX is seen in btmon.
4) Audio/Music is heard on audio jack.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Tested-by: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
---
v2: Add test steps to commit message. (Paul Menzel)
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

