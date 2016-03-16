Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 15 Mar 2016 17:08:46 -0700
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH] linux-firmware: Update firmware patch for Intel Bluetooth
 7265 (D1)
Message-ID: <20160315170846.0cb5899b@fedora-linux-22.shared>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates the firmware patch for Intel Bluetooth 7265.
Also, this device is known as Intel StP D1.

StP D1 FW Patch Version: 16

Release Version: 18.16.01

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 WHENCE                                     |   2 +-
 intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq | Bin 30307 -> 43394 bytes
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/WHENCE b/WHENCE
index 25f91d9..cf4da40 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2695,7 +2695,7 @@ Version: BT_StonePeak_C0_REL_57_0002
 File: intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq
 Version: BT_StonePeak_D0_REL_35_0002
 File: intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq
-Version: STP_D1_REL_13
+Version: STP_D1_REL_16
 File: intel/ibt-11-5.ddc
 Version: LnP/SfP_REL0190
 File: intel/ibt-11-5.sfi
diff --git a/intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq b/intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq
index 11625aa5a0dad00be26fd74123a1389b77b59452..457f37a0c1074490ce4b8a24e38431bfa475352b 100644
GIT binary patch
delta 23209
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
KVtK{-$NnFqn+OR2

delta 9943
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

-- 
2.4.3

