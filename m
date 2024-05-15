Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A880641C76;
	Wed, 15 May 2024 07:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715756941; cv=none; b=DebN2Ppyg1y8PCK3zP2WkIycp6d4jfF9m8q++1gmq1ee/dNnCJA+zSV+AK3UC6/UCegtgS3qgyycA7POyjrt0L8UWpINzOGRMMh4azPOo9cTtClc91Av26K7LS+QRLzvFcOmnkwnWX8mABsSSAaAQTUZo73xxRRpAOtGYHWU5hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715756941; c=relaxed/simple;
	bh=4zAOzBhsn58JdAcEAqx/g9gyIq1koku9aF+BceYr8xw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E470desSMCyM2mP9esap3qV4BFiJDSOIdJgT4K/29HzyyY35pprzBp0yr4ZFBXwS9ZaV1mbjxEazO9Eiyr0ch00T7G4T/lT3wn3aJo1KhU7x3YoghNW0RZK7lJchSM9tckxBggiax1kYh7wg1ckR/URqzAaVrn8U/UD85A7CFIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 34ED71A001F;
	Wed, 15 May 2024 09:08:52 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DA8021A000C;
	Wed, 15 May 2024 09:08:51 +0200 (CEST)
Received: from pe-lt8779.in-pnq01.nxp.com (pe-lt8779.in-pnq01.nxp.com [10.17.104.141])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id CC6B6180222A;
	Wed, 15 May 2024 15:08:49 +0800 (+08)
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
	LnxRevLi@nxp.com,
	guillaume.legoupil@nxp.com,
	salim.chebbo@nxp.com
Subject: [PATCH v1 0/3] Enable status prints for firmware download
Date: Wed, 15 May 2024 12:36:54 +0530
Message-Id: <20240515070657.85132-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

This patch series enables prints for firmware download functionality to
help any automation tests framework to verify this feature.

While testing some scenarios such as downloading corrupt FW file, if
the driver is removed before FW download completes, or FW download
timeout occurs, a kernel crash is observed due to Null Pointer
Dereference, which is fixed along with a print to indicate automation
framework that the FW Download was Aborted.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>

Neeraj Sanjay Kale (3):
  Bluetooth: btnxpuart: Fix Null pointer dereference in
    btnxpuart_flush()
  Bluetooth: btnxpuart: Enable status prints for firmware download
  Bluetooth: btnxpuart: Handle FW Download Abort scenario

 drivers/bluetooth/btnxpuart.c | 68 +++++++++++++++++++++++------------
 1 file changed, 46 insertions(+), 22 deletions(-)

-- 
2.34.1

