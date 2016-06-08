Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 8 Jun 2016 12:53:19 -0700
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH 2/3] linux-firmware: Update firmware patch for Intel
 Bluetooth 7265 (C0/D0)
Message-ID: <20160608125319.737d188a@fedora-linux-22.shared>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates the firmware patch for Intel Bluetooth 7265 (C0/D0)
Also it is known as Intel StP C0 or StP D0

StP C0 Patch Version: 58
StP D0 Patch Version: 37

Release Version: 19.01

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 WHENCE                                   |   4 ++--
 intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq | Bin 30851 -> 31019 bytes
 intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq | Bin 38291 -> 38621 bytes
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/WHENCE b/WHENCE
index 896bac9..86d4513 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2732,9 +2732,9 @@ Version: BT_WilkinsPeak_B5_REL_38_0001
 File: intel/ibt-hw-37.8.bseq
 Version: 1339_02.00
 File: intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq
-Version: BT_StonePeak_C0_REL_57_0002
+Version: BT_StonePeak_C0_REL_58_0001
 File: intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq
-Version: BT_StonePeak_D0_REL_35_0002
+Version: BT_StonePeak_D0_REL_37_0002
 File: intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq
 Version: BT_StonePeak_D1_REL_20_0001
 File: intel/ibt-11-5.ddc
diff --git a/intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq b/intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq
index bee5b97aebfa4e82d612be33d87f02ad88ba4569..27a1c9cc12240abe951098ffe704ce3797e8f11e 100644
GIT binary patch
delta 5412
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
Gf%zA^wD7S2

delta 5229
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

diff --git a/intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq b/intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq
index 4434913956ed058f765bd0a857ec926e32c8ba48..cecb339d9d23d7f9650cfb8725a1cf8364477d62 100644
GIT binary patch
delta 6477
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
SVh)GJEzz?0i<?{GWd9E#9g~p&

delta 6115
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

-- 
2.4.11

