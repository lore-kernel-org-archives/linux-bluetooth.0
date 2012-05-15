Return-Path: <cyrus@holtmann.org>
From: "Yao, Costa" <cqyao@qca.qualcomm.com>
To: "David.Woodhouse@intel.com" <David.Woodhouse@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "Al Cho (acho@suse.com)" <acho@suse.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>
Subject: [PATCH] ar3k: add patch and sysconfig for QCA9564(Aphrodite)
Date: Tue, 15 May 2012 06:44:12 +0000
Message-ID: <07BBB2AAB1A10A488A2AD166C7CB8B0DF7E1DB@nasanexd02b.na.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From e69f183ea4c12352970d41f7faec373277ac00f9 Mon Sep 17 00:00:00 2001
From: Costa Yao <cqyao@qca.qualcomm.com>
Date: Tue, 15 May 2012 12:32:40 +0800
Subject: [PATCH] [PATCH]ar3k: add patch and sysconfig for QCA9564(Aphrodite)

add patch and sysconfig for Qualcomm Atheros QCA9564

Signed-off-by: Costa Yao <cqyao@qca.qualcomm.com>
---
 WHENCE                       |    2 ++
 ar3k/AthrBT_0x31010000.dfu   |  Bin 0 -> 38916 bytes
 ar3k/ramps_0x31010000_40.dfu |  Bin 0 -> 1434 bytes
 3 files changed, 2 insertions(+), 0 deletions(-)
 create mode 100644 ar3k/AthrBT_0x31010000.dfu
 create mode 100644 ar3k/ramps_0x31010000_40.dfu

diff --git a/WHENCE b/WHENCE
index 10155e7..cc1a15f 100644
--- a/WHENCE
+++ b/WHENCE
@@ -1790,6 +1790,8 @@ File: ar3k/ramps_0x01020001_26.dfu
 File: ar3k/AthrBT_0x01020200.dfu
 File: ar3k/ramps_0x01020200_26.dfu
 File: ar3k/ramps_0x01020200_40.dfu
+File: ar3k/AthrBT_0x31010000.dfu
+File: ar3k/ramps_0x31010000_40.dfu
 
 Licence: Redistributable. See LICENCE.atheros_firmware for details
 
diff --git a/ar3k/AthrBT_0x31010000.dfu b/ar3k/AthrBT_0x31010000.dfu
new file mode 100644
index 0000000000000000000000000000000000000000..3bd76c02ecf2e433d640e1215e2253cebbed730d
GIT binary patch
literal 38916
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

literal 0
HcmV?d00001

diff --git a/ar3k/ramps_0x31010000_40.dfu b/ar3k/ramps_0x31010000_40.dfu
new file mode 100644
index 0000000000000000000000000000000000000000..1da3631ff2783264bce6d737f7c539373c75f9f8
GIT binary patch
literal 1434
zcmYk+U2GIp7zW_?%*?m5UAJ_B#n#%=5l{)VP$?nASa#8dK*I$wnAC=tCN_j%7pf9N
z8ibLo(kK@jY+_@2u@^*9i?kIh7lbaP2`f1vK!_pyXfH^L%Fo6SLZonfXVweOZl5{x
zeRF>1>^a5iw_#X56NJU0NB_NZKF(|3|1qF9(kqSXE=EV^V9a^)<Pcr~nl1QvA5d8|
zrD6^J@KXKn9t?U(4`B0)-G>ITxW%p-LOOl5v4HVPg-P^W8_yJRZPia1&HAdH7l6We
z25J)yIgWaH0}xe(KgJ)#6&3>t^@-hFN-E!f12u|0`*nfv6l#D)K|ShQDLBYl%`G1`
z_gnBfGikeTf8E?Ro6o_gKsL1BhU?>CXfAXhj1Ptmh34&`)5D=ns)Qq9bU1V*^myor
z(37DBJI^+gtjAHbt)!LI6u1y(FNbyjT^1a7^7I#|10<)mp{1qd_h9SR2sX0)*n_x>
zN-is|^xkXVgON*}qr35YUkA28A*tH<OyXu1snWDlKu$GsHT~cA+t+a=9YH_d%(TuL
zz}g5G3Eof<Io!DMRb(@!zNtXMZOx-K>E?YdoLl|Y#dw{YS;!8hos)6oa~hR%bQ#|{
zF0p!!CG9jRwT#wCC#{pOsV7(IBB^C|v2@Z#S;9!OY^N*bd%9ZwqOZvkX4A5rw#loE
zte2&9qr68q$q#h1{7pM#DWBOQTWFUwGSV$Qbejy*9;s)%SDIMgB^kO~j?z7Hhx*dQ
zY*sR~Us@SCC?C_D{747nE*+F*%nr#8nwK?<9G1QGh@7I!RT0CooV5|zNsr4hdP45e
zld_y`3bK<<$}w7$2`-!#!|Vk~al2fWee{Y<(CcF8l%#l&Zpywnz%7|z{k9ldk`#Bt
zec4AJ$^@MeLxY26Apv#1kVwLHI7<hA8vCSU)^bFL$>3WEp85HuqIKKhAVDN&p-nAh
zWxWa_V`Fns!s*kV^$SnwDNb`#c`(}24#ppSm%|H~GCHc~!_UIKCST4rdX}!hE#teu
zKaa}ZHvR$5^-<Z9@y~J}%#^)v{BIq!&y;=0oP|%B3!E|jw2k~sS^hH95uD>)pab8n
z4emmt@DDTuccDgCX~p6?b_-(Q+jnJ3*c!YLi_r<a0QsssR=|qJx;-yuJkRLaY-98s
zU7?Z~1Xs}*+vvI4dhWzC)s<6^%b$+N$;ZK8xv!_Sx*f|l4%^gf$8ykhmWK~fq|eR^
zN3GEcBFUK1)!O4o&uSOHjvVKF<}nlHwVqe?<oT+ndo_BYE^H{Ki|N98qtBeF#wuLA
z*v$WuRz)0(8n_|W#M1HkeLH$zU&pf7NhZ2y^`LXb%6Hbaf3WML-QI%p^(t}c(tiXQ
BZIl22

literal 0
HcmV?d00001

-- 
1.7.4.1
