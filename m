Return-Path: <cyrus@holtmann.org>
Date: Wed, 7 Oct 2015 10:00:21 -0700
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: <linux-firmware@kernel.org>
Cc: <linux-bluetooth@vger.kernel.org>, <kyle@infradead.org>,
	<tedd.an@intel.com>
Subject: linux-firmware: Add firmware patch for Intel Bluetooth 7265 (D1)
Message-ID: <20151007100021.5a061ec8@fedora-linux-22.shared>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds the firmware patch for Intel Bluetooth 7265 (D1)
also known as Intel StP D1.

D1 Patch Version: 9

Release Version: 153.1

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 WHENCE                                     |   2 ++
 intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq | Bin 0 -> 13239 bytes
 2 files changed, 2 insertions(+)
 create mode 100644 intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq

diff --git a/WHENCE b/WHENCE
index c310c8b..c6f74a8 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2547,6 +2547,8 @@ File: intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq
 Version: STP2_C0_1339_02_patch_54.1
 File: intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq
 Version: STP2_D0_1417_04_patch_28.1
+File: intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq
+Version: STP_D1_REL_9
 File: intel/ibt-11-5.ddc
 Version: LnP/SfP_REL0190
 File: intel/ibt-11-5.sfi
diff --git a/intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq b/intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq
new file mode 100644
index 0000000000000000000000000000000000000000..8c5ab79a9e1a560a231f26b1624b174df42cf366
GIT binary patch
literal 13239
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
E0>OP%qW}N^

literal 0
HcmV?d00001

-- 
2.4.3

