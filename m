Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Fri, 29 Jan 2016 16:19:02 -0800
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH 1/3] linux-firmware: Update firmware patch for Intel
 Bluetooth 7265 (C0/D0)
Message-ID: <20160129161902.7ebf5c7b@fedora-linux-22.shared>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates the firmware patch for Intel Bluetooth 7265 (C0/D0)
also known as Intel StP C0 and StP D0

C0 Patch Version: 57
D0 Patch Version: 35

Release Version: 18.15

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 WHENCE                                   |   4 ++--
 intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq | Bin 27505 -> 30851 bytes
 intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq | Bin 30212 -> 38291 bytes
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/WHENCE b/WHENCE
index c012ce6..ee8569d 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2669,9 +2669,9 @@ Version: WP_1345_01_patch_0.0.34.1
 File: intel/ibt-hw-37.8.bseq
 Version: 1339_02.00
 File: intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq
-Version: BT_StonePeak_C0_REL_55_0001
+Version: BT_StonePeak_C0_REL_57_0002
 File: intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq
-Version: BT_StonePeak_D0_REL_32_0002
+Version: BT_StonePeak_D0_REL_35_0002
 File: intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq
 Version: STP_D1_REL_13
 File: intel/ibt-11-5.ddc
diff --git a/intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq b/intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq
index 64d3015be6ab5de8b6112075722ab0293317c099..bee5b97aebfa4e82d612be33d87f02ad88ba4569 100644
GIT binary patch
delta 10411
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

delta 6873
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

diff --git a/intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq b/intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq
index fb0a94a1c5176d1609d479a50485154c50396669..4434913956ed058f765bd0a857ec926e32c8ba48 100644
GIT binary patch
delta 8327
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

delta 5354
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

-- 
2.4.3

