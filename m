Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 Sep 2015 11:51:40 -0700
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Kyle McMartin <kyle@infradead.org>,
	"An, Tedd" <tedd.an@intel.com>
Subject: [PATCH 2/3] linux-firmware: Update firmware patch for Intel
 Bluetooth 7260 (B5/B6)
Message-ID: <20150921115140.3bd5f683@tedd-fedora-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates the firmware patch for Intel Bluetooth 7260 (B5/B6)
also known as Intel WP2 B5 and WP1 B6

Patch Version: 34

Release Version: 153

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 WHENCE                                   |   4 ++--
 intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq  | Bin 17508 -> 21161 bytes
 intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq | Bin 17310 -> 20997 bytes
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/WHENCE b/WHENCE
index 885a759..847b1a3 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2538,9 +2538,9 @@ Version: WP_1303_02_patch_0.0.83.1
 File: intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq
 Version: WP_1303_02_patch_0.0.83.1
 File: intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
-Version: WP_1345_01_patch_0.0.26.1
+Version: WP_1345_01_patch_0.0.34.1
 File: intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq
-Version: WP_1345_01_patch_0.0.26.1
+Version: WP_1345_01_patch_0.0.34.1
 File: intel/ibt-hw-37.8.bseq
 Version: 1339_02.00
 File: intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq
diff --git a/intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq b/intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq
index 5b855e57a5e5b39c12866d60502221fbad4dc653..10feb8aeba152bb314c70101d533ca0992806dd9 100644
GIT binary patch
delta 7950
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
Moas-tIa%EQ0j4?is{jB1

delta 4312
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

diff --git a/intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq b/intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
index fe52824a5d0ff9a20482bdbe839a9d4bac91d9fb..2ecca8c5694b1d8b2d77dd1fbe4d2cb0116aa3f2 100644
GIT binary patch
delta 8130
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

delta 4432
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

-- 
2.1.0

