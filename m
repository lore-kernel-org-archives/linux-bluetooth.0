Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 Sep 2015 11:51:37 -0700
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"An, Tedd" <tedd.an@intel.com>, Kyle McMartin <kyle@infradead.org>
Subject: [PATCH 1/3] linux-firmware: Update firmware patch for Intel
 Bluetooth 7260 (B3/B4)
Message-ID: <20150921115137.5e1fc2a9@tedd-fedora-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates the firmware patch for Intel Bluetooth 7260 (B3/B4)
also known as Intel WP2 B3 and WP1 B4

Patch Version: 83

Release Version: 153

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 WHENCE                                  |   4 ++--
 intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq  | Bin 25575 -> 25343 bytes
 intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq | Bin 25366 -> 25117 bytes
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/WHENCE b/WHENCE
index c1d5982..885a759 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2534,9 +2534,9 @@ Driver: btusb - Bluetooth USB driver
 File: intel/ibt-hw-37.7.bseq
 Version: 1316.02.00
 File: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
-Version: WP_1303_02_patch_0.0.79.1
+Version: WP_1303_02_patch_0.0.83.1
 File: intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq
-Version: WP_1303_02_patch_0.0.79.1
+Version: WP_1303_02_patch_0.0.83.1
 File: intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
 Version: WP_1345_01_patch_0.0.26.1
 File: intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq
diff --git a/intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq b/intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq
index 484b723b6ce86445acde2d7072b037eefd7b100d..0e761127e4a78fff67480e4dff14650b7d4769e7 100644
GIT binary patch
delta 8854
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
BRD%Ej

delta 8970
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
EKMqYY&Hw-a

diff --git a/intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq b/intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
index b18fdfdfa8fb9b4a054de03a25e8aa8d1fe42488..e3bc1cb5f4119110659bd7eef2722c1d3034d1a4 100644
GIT binary patch
delta 8572
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%0As6U~>T&Xo$$=j<FzTPFuA%;F
zOX{t1|GFvsKN;xR6nImdaKflkgURUU4w~^u;*eLdk6$X7)hcx`j@L22>wk~ZNO$6q
zO`&QkUGPZKLo&bB;pY?xHIDpJoxv6l78D*A9s@JY!s5`D^VX)EwDk#!%_W<8S9J~N
zkAHs?{rw~Pxhq28wl>Y&DVi$gUO;1Trzbx1upr+Qd47U&j}}i^6y6De6q)gIq=yaH
z>q^q`$OFLwbvny$#jmU=Ej~2Y`$+e2<9fyChc$vsz3PWW^<Xbu^{7=*6;(#}Jv!7G
zsTbP~MQCS-=b$zYw-8;D_J1VjNAD`O#&c3?6sO`R{?ev@@(UY=gp;M%bHgQmY>d89
zMOrOG@H{BdVTtIQp53N@&cR$v4Ccn1)n-M{AksaNNcExXm>9iIRisO-Dc^bi^_T=*
z+UNM8#*ZI66f)&2Dn#Xt_d;T#J6aC~U-3etggi|VVbuKTR11)DejzuVcx3GFkN?as
zXp9evh3=k(_*0K@Csrr(vE4IPMZ`E1E8wXXI~nCV;TpB%ilgah#H=g#4F3t;@cZi(
zS@!nRq?kKxW;p2^SIegz{fDnx2KwWprSe#`SB7Kpp~nOjN%2FSkGdbj`_sp&<Vc0n
z!blV5chEKS3#s*SlYG=VJv>_acnAIY@d0$Es_;npf)4th1p`L3Gr}X&7IsiYO{MkO
z0S6dPEJj0E4&jHL30stb^esg-)irFex|aUBrkuKJCeY+sd8xPSmPpY?b+v;Nw!E6G
jz{Q$_H>%>tZv5~qP@%SrlG<o`vUV^t>kl_-EzJJ|2(9cZ

delta 8830
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
R%juu%3z%7N{IlN9{2xeR_DcW&

-- 
2.1.0

