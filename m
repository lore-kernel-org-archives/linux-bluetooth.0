Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 10 Nov 2015 17:22:40 -0800
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: linux-firmware: Update firmware patch for Intel Bluetooth 7265
 (C0/D0)
Message-ID: <20151110172240.73eeef00@fedora-linux-22.shared>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates the firmware patch for Intel Bluetooth 7265 (C0/D0)
also known as Intel StP C0 and StP D0

C0 Patch Version: 55
D0 Patch Version: 32

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 WHENCE                                   |   4 ++--
 intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq | Bin 27481 -> 27505 bytes
 intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq | Bin 27244 -> 30212 bytes
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/WHENCE b/WHENCE
index d6c7117..cfbc269 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2589,9 +2589,9 @@ Version: WP_1345_01_patch_0.0.34.1
 File: intel/ibt-hw-37.8.bseq
 Version: 1339_02.00
 File: intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq
-Version: STP2_C0_1339_02_patch_54.1
+Version: BT_StonePeak_C0_REL_55_0001
 File: intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq
-Version: STP2_D0_1417_04_patch_28.1
+Version: BT_StonePeak_D0_REL_32_0002
 File: intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq
 Version: STP_D1_REL_9
 File: intel/ibt-11-5.ddc
diff --git a/intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq b/intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq
index 6201968596e332af1e645ba1e1ce6c957be6274e..64d3015be6ab5de8b6112075722ab0293317c099 100644
GIT binary patch
delta 4695
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
IHYH2{1ArLF6951J

delta 4592
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
K^sd>F!u$uDk*xIq

diff --git a/intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq b/intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq
index 032d82556fd85ccfa24698fbb987905daed317eb..fb0a94a1c5176d1609d479a50485154c50396669 100644
GIT binary patch
delta 9826
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

delta 6929
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
Gfc_r}#qJRR

-- 
2.4.3

