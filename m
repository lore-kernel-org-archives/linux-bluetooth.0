Return-Path: <cyrus@holtmann.org>
Message-ID: <5425F927.8020408@intel.com>
Date: Fri, 26 Sep 2014 16:39:19 -0700
From: Tedd Ho-Jeong An <tedd.an@intel.com>
MIME-Version: 1.0
To: linux-firmware@kernel.org
CC: linux-bluetooth@vger.kernel.org, "An, Tedd" <tedd.an@intel.com>
Subject: linux-firmware: Add firmware patch for Intel Bluetooth 7265 ROM-spin(D0)
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds new firmware patch file for
- Intel Wireless 7265 Bluetooth ROM-spin SKU, also known as StP2 D0

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
  WHENCE                                   |   2 ++
  intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq | Bin 0 -> 8441 bytes
  2 files changed, 2 insertions(+)
  create mode 100644 intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq

diff --git a/WHENCE b/WHENCE
index 5424b0f..27d24d2 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2393,6 +2393,8 @@ File: intel/ibt-hw-37.8.bseq
  Version: 1339_02.00
  File: intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq
  Version: STP2_C0_1339_02_patch_31.1
+File: intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq
+Version: STP2_D0_1417_04_patch_04.1

  Licence: Redistributable. See LICENCE.ibt_firmware for details

diff --git a/intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq 
b/intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq
new file mode 100644
index 
0000000000000000000000000000000000000000..95a32a96d863a19726fa0d6faad5b0917cb6adcb
GIT binary patch
literal 8441
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
F_-~X>mv8_8

literal 0
HcmV?d00001

-- 
1.9.1

