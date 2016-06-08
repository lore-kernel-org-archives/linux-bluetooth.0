Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 8 Jun 2016 12:53:15 -0700
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc: Tedd Ho-Jeong An <tedd.an@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH 1/3] linux-firmware: Update firmware patch for Intel
 Bluetooth 7265 (D1)
Message-ID: <20160608125315.49ea9f84@fedora-linux-22.shared>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates the firmware patch for Intel Bluetooth 7265 (D1)
Also, it is known as Intel StP D1

StP D1 FW Patch Version: 20

Release Version: 19.01

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 WHENCE                                     |   2 +-
 intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq | Bin 43496 -> 45680 bytes
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/WHENCE b/WHENCE
index 401809c..896bac9 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2736,7 +2736,7 @@ Version: BT_StonePeak_C0_REL_57_0002
 File: intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq
 Version: BT_StonePeak_D0_REL_35_0002
 File: intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq
-Version: STP_D1_REL_18
+Version: BT_StonePeak_D1_REL_20_0001
 File: intel/ibt-11-5.ddc
 Version: LnP/SfP_REL0257
 File: intel/ibt-11-5.sfi
diff --git a/intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq b/intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq
index 324b24b1d52e0f059f960004cd305073abc358ac..4edb93e5f904770390d45e9fbff7479df2d2297a 100644
GIT binary patch
delta 10417
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
LMyOF?)9U{L=K(I~

delta 9230
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

-- 
2.4.11

