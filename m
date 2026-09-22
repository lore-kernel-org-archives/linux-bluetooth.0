Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DD13F9264
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 06:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059264; cv=none; b=D5nZTxgs8ZkLDGgve3Rcd7uE+GS++E+rEBdjRnxvEUNSJmIwNAO45y6DKd6NvEeBYgC2IuDlAwWA4/JliPCaF6bfdehR6ZXlhw+gr1z85yNnGd1FVyxlwOWsMLRqWlpjVMuXhpWhPe0Mx91dDbCJjbk1Em7W26CGJjGrU2XNm2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059264; c=relaxed/simple;
	bh=7IbROuMmJCUrhg0pxT4CLzIUf8k2lPvPwrHT1132aEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E3XxjcNlL3PX0yG6vd2OOOyenLsjwGjy07RyQjBrPOB8onp+22C2jvkcMVj0+kud5t13MVHTOrvMiPfCEHmO/vCp24PlZeF0Aw1ytij6ntmn7x8qClGIgsjmzOB8X1NWH4S3YA0//SBrLYOzyv67WkTzxUc9OWPwo/AOpjOskeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fh7PJPGI; arc=none smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fh7PJPGI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790059264; x=1821595264;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7IbROuMmJCUrhg0pxT4CLzIUf8k2lPvPwrHT1132aEw=;
  b=Fh7PJPGIe5Ke/V/5G13k7+zh/NoHVtg81RLHGsFMjyujPJ7+cfidzwml
   yFb3UQ0KUfm3OpVSKMqnA+VWstrqFgB2pIqNkxQLgTkfSnbzE/QOHM7Nv
   a+9YrYQZI8LJDQlPFp3GncC3GSFb8naJSFqTghO5s+PNzn0JtFQTE2tSA
   o0jjoNX/k28j3SFDgtz2eTIX3YEnGhHnrhm1y79KCrzZi1DJzOmarMrA6
   GBOjOvhpGWL36EUkJHqeCOYLk5s83Q15POPoQ3RX7Kwor00hduFQP+EOm
   OZUysyG5F18d2RyuIa2eZz6tLDpXrfCzrxsSYsP7kvJ7E16/5PBO0nMbB
   w==;
X-CSE-ConnectionGUID: jgWrhPAySPq+1V9t4QAXtA==
X-CSE-MsgGUID: bUzogAwCSLC7aHa/61BSZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="1139864"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="1139864"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 23:41:03 -0700
X-CSE-ConnectionGUID: vV2CycAVQpesxSRg4HpBOA==
X-CSE-MsgGUID: F443wRuRS7aJhKS3WFJvbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="3987079"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by fmviesa012.fm.intel.com with ESMTP; 21 Sep 2026 23:41:01 -0700
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Subject: [PATCH v1 0/3] Bluetooth: btintel: security fixes
Date: Tue, 22 Sep 2026 12:10:19 +0530
Message-ID: <cover.1790053452.git.chandrashekar.devegowda@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three small, independent fixes found by an internal audit of the Intel
Bluetooth drivers:

  1. btintel: bound the "Exception info" print, which reads past a
     controller-supplied buffer that is not NUL-terminated.
  2. btintel_pcie: widen plen to u32 so HDR_SIZE + dlen cannot wrap
     and defeat the RX length check.
  3. btintel_pcie: reject TX packets larger than the DMA buffer
     before they reach the memcpy() in the TX submit path.

All three pass checkpatch --strict.

Chandrashekar Devegowda (3):
  Bluetooth: btintel: fix buffer over-read in btintel_hw_error()
  Bluetooth: btintel_pcie: fix plen overflow in
    btintel_pcie_recv_frame()
  Bluetooth: btintel_pcie: reject oversized TX packets in send_frame()

 drivers/bluetooth/btintel.c      |  3 ++-
 drivers/bluetooth/btintel_pcie.c | 12 +++++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)


base-commit: 06d991977eeff5d51327e1e64889e70658e8f7ff
-- 
2.43.0

