Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794406743;
	b=L85STSEzPXcqKflBUYjbSQoZtIvwSXfeqmlShGiFzO1BrTArz8qMVAeCv0F9yV+MBCuj
	 Flbh81Wah3T+9EHYJiEgAPYqc54YWGjzvTjFkmYyJ/hbCJhL/sOCTR0XtwF6rUTLI8Vtv
	 gOCqTM+lg1H0NtLpLbroBLFplXVYMvVrv2Pjfs29VoRSJsdfw8JuMyK9Q83mxpq+RoCR2
	 Ldz/v8+7sk6dx+V065fVzzYsXgNWI8gp1pqNghFXS7C3O/2nUr1fo1nUqMzgWdynKyv9r
	 dK9So39/UsKE/1Brh62+LAE2nq1hUvssbLX1oxWRCfXnXRxKQN++AwXery9KNjPZrtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406743;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Y6gTVRH0QUUMYLX0+a94ClBwUuqd4zdDndEnTo5sJ98=;
	b=y1mUTMg0wGxZg7H2jCrhRtoioLHMXsYdI6M2IW6epKTZKUblFT3oratiNu1jw4t/n9qU
	 TkIo6JNJWLijk2F7ebm0UfMgkWx6vA3EYSpflnJvBhFH5/VN9lja/ZtFrjbmLfR23POyH
	 CPC1Iesi52wcGD/Trq0I+p3UUgjaR+f2ZUDHi24S9nlV8wy0Ade3heEJLjZbt6F1xH0b3
	 rD3bM1ubN//U2LdYEYMOTEjMxngMLSJtk0a6l0Se0nSQMellV0r/09KNE1pWuP3Wpbsed
	 yfYkQzjsoACIHAPlI40oXltcJX8kO89o8FJgwnLq2u/VQwWEZmAAU+L1kS8kby4wKSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Dw4Wqnlx;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B42F606A326
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 14:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B42F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Dw4Wqnlx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794406742; x=1825942742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IYc4SUax7PeiK1jS3zhAgDBQPsClpq9HBpsnSNchsfE=;
  b=Dw4WqnlxOvpGd9i3pbXcIokvBqcxSuHy9uiGds8mHpHVfUTa9P6qZ8qB
   fpBsgn9T3OnsnP/01lR/TEivxmy/c6UzB6iQ1wBQ1TuW8Oo4JaLPKIppf
   6J7IuW0/pNZA4p/93xNCYvXjLCKt2PdJjkbPsyKVQfPW/dfmg5+tXSDnb
   8f3xoY29p03t4ugQlnFilpTAMe1m50MEpkVYAMrNkCDT9RJqzr5T8CWzj
   TLdhVV8N5Feouk8rsOoGif3A9e7kzf9ehJtejO/VMdrhzu3BJrihkN7WZ
   bW1UOeHOBtr7xPSwezjg9zm1tgTednNA5xKGls4/l27Oy+SWPvCyqYIET
   Q==;
X-CSE-ConnectionGUID: ege0EL1ERf6OK1xhyHgfdg==
X-CSE-MsgGUID: SkMO5WC0ToeC1RJx7MkX6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3212657"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3212657"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 06:19:02 -0800
X-CSE-ConnectionGUID: dwyZF0wwR5qCuCoovNGIXw==
X-CSE-MsgGUID: qMqYv0PDShWZ7onx9jvAJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="9003089"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by fmviesa010.fm.intel.com with ESMTP; 11 Nov 2026 06:19:00 -0800
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	aluvala.sai.teja@intel.com,
	pmenzel@molgen.mpg.de,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Subject: [PATCH v2] Bluetooth: btintel_pcie: Fix SCP DBGC base address
Date: Wed, 11 Nov 2026 19:48:22 +0530
Message-ID: <20261111141822.2888893-1-chandrashekar.devegowda@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104064507.2600483-1-chandrashekar.devegowda@intel.com>
References: <20261104064507.2600483-1-chandrashekar.devegowda@intel.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BTINTEL_PCIE_DBGC_BASE_ADDR_SCP was entered as 0xf0d5d500 by mistake
when the define was added. The base of the SCP debug controller is
0xf0d5d400, as documented in the Intel SCP SAS document, so the value
is one register row too high. The status and wrap-around registers
derived from it at offsets 0x1C and 0x2C therefore point at the wrong
addresses, and the debug buffer status and wrap-around state read while
dumping SCP debug traces are incorrect.

Use 0xf0d5d400 so that the derived offsets land on the intended
registers.

Tested on an SCP platform by triggering a firmware exception and
collecting the resulting devcoredump. With the corrected base address,
the debug buffer status and wrap-around registers read back valid
values and the DRAM monitor buffers in the dump are decoded correctly;
with the old address they are read from the wrong registers.

Fixes: e43b33bf8d67 ("Bluetooth: btintel_pcie: Load IOSF debug regs by controller variant")
Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
---
Changes in v2:
- Rewrap commit message to 75 columns
- Explain that the original value was a typo made when the define
  was added, and cite the Intel SCP SAS document as the source of
  the correct base address
- Add a paragraph describing how the fix was tested

 drivers/bluetooth/btintel_pcie.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 4125601b78d7..181df5e14062 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -83,7 +83,7 @@
 #define BTINTEL_PCIE_DBGC_CUR_DBGBUFF_STATUS		(BTINTEL_PCIE_DBGC_BASE_ADDR + 0x1C)
 #define BTINTEL_PCIE_DBGC_DBGBUFF_WRAP_ARND		(BTINTEL_PCIE_DBGC_BASE_ADDR + 0x2C)
 
-#define BTINTEL_PCIE_DBGC_BASE_ADDR_SCP			(0xf0d5d500)
+#define BTINTEL_PCIE_DBGC_BASE_ADDR_SCP			(0xf0d5d400)
 #define BTINTEL_PCIE_DBGC_CUR_DBGBUFF_STATUS_SCP	(BTINTEL_PCIE_DBGC_BASE_ADDR_SCP + 0x1C)
 #define BTINTEL_PCIE_DBGC_DBGBUFF_WRAP_ARND_SCP		(BTINTEL_PCIE_DBGC_BASE_ADDR_SCP + 0x2C)
 #define BTINTEL_PCIE_DBGC_ALLOCATION_OFFSET		0x100
-- 
2.43.0

