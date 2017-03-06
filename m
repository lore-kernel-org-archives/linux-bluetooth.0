Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH 1/3] linux-firmware: Update firmware patch for Intel
 Bluetooth, 7265
Cc: jaya.p.g@linux.intel.com, linux-bluetooth@vger.kernel.org,
        tedd.an@intel.com, anand.kalyanakrishnan@intel.com
References: <58B956D3.4070003@linux.intel.com>
To: linux-firmware@kernel.org
From: "jaya.p.g" <jaya.p.g@linux.intel.com>
Message-ID: <58BD5CDD.5030003@linux.intel.com>
Date: Mon, 6 Mar 2017 18:28:05 +0530
MIME-Version: 1.0
In-Reply-To: <58B956D3.4070003@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Subject: [PATCH 1/3] linux-firmware: Update firmware patch for Intel Bluetooth, 7265
Date: Fri, 3 Mar 2017 17:13:15 +0530
From: jaya.p.g <jaya.p.g@linux.intel.com>
Organization: intel
To: tedd.an@intel.com
CC: anand.kalyanakrishnan@intel.com

From: Jaya P G <jaya.p.g@linux.intel.com>
Date: Tue, 28 Feb 2017 18:01:37 +0530
Subject: [PATCH 1/3] linux-firmware: Update firmware patch for Intel Bluetooth
 7265

This patch updates the firmware patch for Intel Bluetooth 7265 (D1)
also, it is known as Intel StP D1

StP D1 FW Patch Version: 28

Release Version: 19.50

Signed-off-by: Jaya P G <jaya.p.g@linux.intel.com>
---
 WHENCE                                     |   2 +-
 intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq | Bin 47932 -> 44846 bytes
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/WHENCE b/WHENCE
index be9a63a..64c3480 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2826,7 +2826,7 @@ Version: BT_StonePeak_C0_REL_59_0001
 File: intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq
 Version: BT_StonePeak_D0_REL_37_0002
 File: intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq
-Version: BT_StonePeak_D1_REL_25_0001
+Version: BT_StonePeak_D1_REL_28_0001
 File: intel/ibt-11-5.ddc
 Version: LnP/SfP_REL0351
 File: intel/ibt-11-5.sfi
diff --git a/intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq b/intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq
index 905e027e1d210aed9a2d353fd7470cd39fe92c98..92bbfd18ac8e4a40579697d6e41eb476288dfd69 100644
GIT binary patch
delta 11553
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
TX$j5Ff*)@BN~wL%V3qtogkJ_i

delta 14432
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

-- 
1.9.1


