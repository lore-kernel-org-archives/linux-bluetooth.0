Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Jul 2014 17:09:10 -0700
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: linux-firmware@kernel.org
Cc: tedd.an@intel.com, ben@decadent.org.uk,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] linux-firmware: Update firmware patch for Intel BT 7265
Message-ID: <20140718170910.13cc22ee@han1-desk-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates firmware patch file for Intel BT 7265

- fixed no audio with HFP issue

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 WHENCE                                   |   2 +-
 intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq | Bin 10612 -> 18017 bytes
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/WHENCE b/WHENCE
index 514f471..294b75d 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2304,7 +2304,7 @@ Version: WP_1345_01_patch_0.0.13.1
 File: intel/ibt-hw-37.8.bseq
 Version: 1339_02.00
 File: intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq
-Version: STP2_C0_1339_02_patch_13.1 (0x0D)
+Version: STP2_C0_1339_02_patch_27.1
 
 Licence: Redistributable. See LICENCE.ibt_firmware for details
 
diff --git a/intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq b/intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq
index 3177c2984b91dec69f61124cafada1e4fb29d491..1241f5334a04bad765b28a20bc94d42bdd8ff36c 100644
GIT binary patch
literal 18017
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

delta 5027
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
GqW=dw$b2FI

-- 
1.9.1

