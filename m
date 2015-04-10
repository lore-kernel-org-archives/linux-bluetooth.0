Return-Path: <cyrus@holtmann.org>
From: Kalle Valo <kvalo@qca.qualcomm.com>
To: <linux-firmware@kernel.org>
CC: <linux-bluetooth@vger.kernel.org>, <agoel@qca.qualcomm.com>
Subject: =?UTF-8?q?=5BPATCH=5D=20ath3k=3A=20update=20AR3012=202=2E2=2E1=20firmware=20with=20v=2E170?=
Date: Fri, 10 Apr 2015 20:34:54 +0300
Message-ID: <1428687294-10706-1-git-send-email-kvalo@qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is the latest firmware version for AR3012 2.2.1.
This also includes configuration file for coex support,
where all Bluetooth traffic is treated as high priority.

Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
---
 LICENSE.QualcommAtheros_ar3k                       |   47 ++++++++++++++++++++
 WHENCE                                             |   10 ++++-
 .../ramps_0x01020201_26_HighPriority.dfu           |  Bin 0 -> 336 bytes
 ar3k/AthrBT_0x01020201.dfu                         |  Bin 19164 -> 48188 bytes
 4 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 LICENSE.QualcommAtheros_ar3k
 create mode 100644 ar3k/1020201coex/ramps_0x01020201_26_HighPriority.dfu

diff --git a/LICENSE.QualcommAtheros_ar3k b/LICENSE.QualcommAtheros_ar3k
new file mode 100644
index 000000000000..7fae6323f5df
--- /dev/null
+++ b/LICENSE.QualcommAtheros_ar3k
@@ -0,0 +1,47 @@
+Copyright (c) 2015, Qualcomm Atheros, Inc.
+All rights reserved.
+
+Redistribution. Reproduction and redistribution in binary form, without
+modification, for use solely in conjunction with a Qualcomm Atheros, Inc.
+chipset, is permitted provided that the following conditions are met:
+
+  • Redistributions must reproduce the above copyright notice and the following
+    disclaimer in the documentation and/or other materials provided with the
+    distribution.
+
+  • Neither the name of Qualcomm Atheros, Inc. nor the names of its suppliers
+    may be used to endorse or promote products derived from this Software
+    without specific prior written permission.
+
+  • No reverse engineering, decompilation, or disassembly of this Software is
+    permitted.
+
+Limited patent license. Qualcomm Atheros, Inc. (“Licensor”) grants you
+(“Licensee”) a limited, worldwide, royalty-free, non-exclusive license under
+the Patents to make, have made, use, import, offer to sell and sell the
+Software. No hardware per se is licensed hereunder.
+The term “Patents” as used in this agreement means only those patents or patent
+applications owned solely and exclusively by Licensor as of the date of
+Licensor’s submission of the Software and any patents deriving priority (i.e.,
+having a first effective filing date) therefrom. The term “Software” as used in
+this agreement means the firmware image submitted by Licensor, under the terms
+of this license, to git://git.kernel.org/pub/scm/linux/kernel/git/firmware/
+linux-firmware.git.
+Notwithstanding anything to the contrary herein, Licensor does not grant and
+Licensee does not receive, by virtue of this agreement or the Licensor’s
+submission of any Software, any license or other rights under any patent or
+patent application owned by any affiliate of Licensor or any other entity
+(other than Licensor), whether expressly, impliedly, by virtue of estoppel or
+exhaustion, or otherwise.
+
+DISCLAIMER. THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING,
+BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
+FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
+THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
+INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
+BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
+OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
+TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
diff --git a/WHENCE b/WHENCE
index fc9512dce1fc..f3cd6e38a0f8 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2238,7 +2238,6 @@ File: ar3k/AthrBT_0x31010000.dfu
 File: ar3k/ramps_0x31010000_40.dfu
 File: ar3k/AthrBT_0x11020000.dfu
 File: ar3k/ramps_0x11020000_40.dfu
-File: ar3k/AthrBT_0x01020201.dfu
 File: ar3k/ramps_0x01020201_26.dfu
 File: ar3k/ramps_0x01020201_40.dfu
 File: ar3k/AthrBT_0x41020000.dfu
@@ -2248,6 +2247,15 @@ Licence: Redistributable. See LICENCE.atheros_firmware for details
 
 --------------------------------------------------------------------------
 
+Driver: DFU Driver for Atheros bluetooth chipset AR3012
+
+File: ar3k/AthrBT_0x01020201.dfu
+File: ar3k/1020201coex/ramps_0x01020201_26_HighPriority.dfu
+
+Licence: Redistributable. See LICENSE.QualcommAtheros_ar3k for details
+
+--------------------------------------------------------------------------
+
 Driver:Atheros AR300x UART HCI Bluetooth Chip driver
 
 File: ar3k/1020201/PS_ASIC.pst
diff --git a/ar3k/1020201coex/ramps_0x01020201_26_HighPriority.dfu b/ar3k/1020201coex/ramps_0x01020201_26_HighPriority.dfu
new file mode 100644
index 0000000000000000000000000000000000000000..2113377f1ad6e426d21ad73c46a1d6c2b821f36c
GIT binary patch
literal 336
zcmZwCu};G<5C-7imH{UU(58_<NC-m_ER{eR5kt1Z#t34`fYb^43T5OiGP2Sqpq)>M
z_6gX+z`(%3fP2_6BR71%Pxk3#9AAN5oeDIiLO64oi=NnYrxcHRu@KPF+wi*f4<yFp
z4&E`D82RGv?f`lc225)d;e*RV;K+J!?I%|&3K!Npv|n8I6;7=8!G3em*GR4R(*AH!
zE0;mHrq;-8P+>G!EixO_C<gH;v%$o5Y14U`TC{gxtyjn)b$nw?%*HUaNeHGbQZhl=
vOt)NyiEaA(J|Zlk(_Y4Im#It7=dWi>)9D5dFq;`jA)^HQJ1N9}h57s!*<NP7

literal 0
HcmV?d00001

diff --git a/ar3k/AthrBT_0x01020201.dfu b/ar3k/AthrBT_0x01020201.dfu
index c51bf1df29d780ce380de9ea64c1275812c58578..600dcdd49548a4790bfc59a50b753c1e4e5cc09c 100644
GIT binary patch
literal 48188
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

delta 10004
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

-- 
1.7.9.5

