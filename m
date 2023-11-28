Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fPOTojv9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363C2E6
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Nov 2023 20:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701145028; x=1732681028;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XBiUC1bIe26Kzoox/bRe7wGoYs2HeWvKcMT0pr1DcMk=;
  b=fPOTojv9w+g+WjtXfk1tvOgGs70vd+PyhyYOdOmVZUseb2wCEjLLJtzG
   GRCj1JHTXAPjpsUD0zOD2cTYIumXgl7cvVuObofUfM7jF/+IKkUOSvoHy
   EvmEHMeIaHq8LfJ0hs4CBMMnmkdGnSgOeKaj8r7YX9mZTMOQl7vDOr7a9
   fthlfeCUKvWGIJ+gGn2gHiI2Wg9TKvU8R//dQcqbZ5ANC2jh/3b9ZtfS4
   8+m/FRTMWZbmbytNwkx8syNze7pq/esJL2eKtODIYyXmq1GKyeHYlYyTK
   tVskR2HSdtr+qTDylM9Nbg+feENuZtZatPnmQ1WR2ZjTu3706hFNugGUY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="6045005"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="6045005"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 20:17:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="761827490"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="761827490"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga007.jf.intel.com with ESMTP; 27 Nov 2023 20:17:05 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH] monitor/intel: Add decoding of firmware SHA1 in read version event
Date: Tue, 28 Nov 2023 09:59:22 +0530
Message-Id: <20231128042922.2514576-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

< HCI Command: Intel Read Version (0x3f|0x0005) plen 1
        Requested Type:
          All Supported Types(0xff)
> HCI Event: Command Complete (0x0e) plen 107
      Intel Read Version (0x3f|0x0005) ncmd 1
        Status: Success (0x00)
        CNVi TOP(16): 0x00400410
        CNVr TOP(17): 0x00400410
        CNVi BT(18): 0x00173700
        CNVr BT(19): 0x00123720
        CNVr OTP(21): 0x0413
        Device Rev ID(22): 0x0000
        USB VID(23): 0x8087
        USB PID(24): 0x0032
        Image Type(28): Firmware(0x03)
        Time Stamp(29): 23-42
        Build Type(30): 0x01
        Build Num(31): 0x00011d97
        FW Build Product(32): 0x06
        FW Build HW(33): 0x06
        FW Build Step(34): 0xa0
        BT Spec(35): 0x00
        Manufacturer(36): Intel Corp. (2)
        HCI Revision(37): 0x3597
        LMP SubVersion(38): 0x3597
        OTP Lock(42): Disabled(0)
        API Lock(43): Disabled(0)
        Firmware SHA1(50): 0x2e575f2a
        Unknown Type(51):
        00
        Unknown Type(52):
        Unknown Type(53):
        00 00 00 00
---
 monitor/intel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/monitor/intel.c b/monitor/intel.c
index 0191987d45fb..4aea4d5fbb99 100644
--- a/monitor/intel.c
+++ b/monitor/intel.c
@@ -291,6 +291,7 @@ static const struct intel_version_tlv_desc {
 	{ 47, "SBE Type", print_version_tlv_u8 },
 	{ 48, "OTP BDADDR", print_version_tlv_otp_bdaddr },
 	{ 49, "Unlocked State", print_version_tlv_enabled },
+	{ 50, "Firmware SHA1", print_version_tlv_u32 },
 	{ 0, NULL, NULL },
 };
 
-- 
2.34.1

