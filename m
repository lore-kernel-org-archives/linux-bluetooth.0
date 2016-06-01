Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 1 Jun 2016 11:59:50 -0700
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: linux-firmware: Update firmware patch for Intel Bluetooth 7260
 (B3/B4)
Message-ID: <20160601115950.0a954160@fedora-linux-22.shared>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates the firmware patch for Intel bluetooth 7260
also known as Intel WP2 B3 and WP1 B4.

Patch Version: 86

Release Version: 19.01

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 WHENCE                                  |   4 ++--
 intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq  | Bin 25857 -> 25853 bytes
 intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq | Bin 25631 -> 25627 bytes
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/WHENCE b/WHENCE
index 9331897..b416c56 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2722,9 +2722,9 @@ Driver: btusb - Bluetooth USB driver
 File: intel/ibt-hw-37.7.bseq
 Version: 1316.02.00
 File: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
-BT_WilkinsPeak_B3_REL_85_0001
+Version: BT_WilkinsPeak_B3_REL_86_0001
 File: intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq
-BT_WilkinsPeak_B3_REL_85_0001
+Version: BT_WilkinsPeak_B3_REL_86_0001
 File: intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
 Version: BT_WilkinsPeak_B5_REL_37_0001
 File: intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq
diff --git a/intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq b/intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq
index b057cb0b926c2b1898f2f8ffeaa10f78cdc57053..46ef39b95c36f5b006545a695cce46f0f9a3cd98 100644
GIT binary patch
delta 4578
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

delta 4513
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
DD^}Dq

diff --git a/intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq b/intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
index 6627aecc54c6d341bd7fe5848f40a5ad112f5cae..9a930916a116d6a6d55978aeda76210b49bd3c80 100644
GIT binary patch
delta 4466
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

delta 4668
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
Rb22`;rJ1St;Fm3C=KmRn>Hh!#

-- 
2.4.11

