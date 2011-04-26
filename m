Return-Path: <cyrus@holtmann.org>
From: Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
To: "dwmw2@infradead.org" <dwmw2@infradead.org>
CC: Shanmugamkamatchi Balashanmugam
	<Shanmugamkamatchi.Balashanmugam@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 27 Apr 2011 02:30:32 +0530
Subject: RE: [PATCH] linux-firmware: Add sysconfig file
Message-ID: <44EE5C37ADC36343B0625A05DD408C48517D2D6D63@CHEXMB-01.global.atheros.com>
References: <1302507848-3197-1-git-send-email-jkumar@atheros.com>
In-Reply-To: <1302507848-3197-1-git-send-email-jkumar@atheros.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

-----Original Message-----
>From: Jothikumar Mothilal 
>Sent: Monday, April 11, 2011 1:14 PM
>To: dwmw2@infradead.org
>Cc: Jothikumar Mothilal; Shanmugamkamatchi Balashanmugam
>Subject: [PATCH] linux-firmware: Add sysconfig file
>
>Added sysconfig file for new clock frequency.

>Signed-off-by: Jothikumar Mothilal <jkumar@atheros.com>
>---
 >WHENCE                       |    1 +
> ar3k/ramps_0x01020200_40.dfu |  Bin 0 -> 1204 bytes
> 2 files changed, 1 insertions(+), 0 deletions(-)  create mode 100644 ar3k/ramps_0x01020200_40.dfu
>
>diff --git a/WHENCE b/WHENCE
>index f6a0ec1..9c682bf 100644
>--- a/WHENCE
>+++ b/WHENCE
>@@ -1557,6 +1557,7 @@ File: ar3k/AthrBT_0x01020001.dfu
> File: ar3k/ramps_0x01020001_26.dfu
> File: ar3k/AthrBT_0x01020200.dfu
> File: ar3k/ramps_0x01020200_26.dfu
>+File: ar3k/ramps_0x01020200_40.dfu
> 
> Licence: Redistributable. See LICENCE.atheros_firmware for details
> 
>diff --git a/ar3k/ramps_0x01020200_40.dfu b/ar3k/ramps_0x01020200_40.dfu new file mode 100644 index >0000000000000000000000000000000000000000..02166c073dff1feebb4307294db7a95d837eb107
>GIT binary patch
>literal 1204
>zcmXxiTTC2P7zgnG%+AN0p-Wj{El5D8mZE8wOVk+CK$pfQwxlt{U_|6$lM-4hE5!If
>zOqFdyA|ek2No))c`(TKd)<Q!F52P#&4`@!Bf<BPantiC&OKCTz4~=$u{BPHu&Hm1r
>z@7%tbbI|-23`^R<qhizZ|7>3gv!41t28_v=6SMAMZmt~j>fyupu?z5Rggr!oamB%H
>zDK!LGBdTH0KRBxV_~`LMd`flh?VUWU)?SM>POG-IYq5-4D6z1r`nML6YijGIpORW7
>z*oN1ENyqX0qev+)JMi|eh4mxenNV{s>ZMYzpvvQ3shYg-y?nNB0tp+AySnljY5<wA
>zPNJ_bYxP6xFphEb@$ImS5}+BIgLm6cV|Jr^ZV118*o7Wgh+2oaO62AU;<;N+1`}2c
>z*Rk1Fga#{zQM{gP-8qFrMO+B}^cp5`<Hi?7oyg93h`6n3v_{=@%0iV}`Nn#<#!c?w
>za?;LJ92uiZexzY3uH`P$PNP!INR@Qc8u^m?a*ftWHG7|vZW@z)j5NzB`l5VGUzR^<
>zi|k`>o1CJD<p3i`WIsJ7@6rzWj&{mlv`hALOpo-?gv1!>m413s&e49UWqeQ?*#1D0
>zbV$zAM(b~!mTk6D(!dcTlBA>3%E-8UL?`5XIwg1LS!rbNw7f^ta*&a)<YW4^T%zZs
>ziO$LZotF!AQSQ<uY2x^d4A51%K-XlMA5Dv4?^TIgz|S&FH)WY#7eliW=W*YZ;d0=2
>zS!VmT7@CuK2)HN1^u8?92V!Xc^4f^Nx{`@R;qo!<;13g8a?BxKR3>0!(PE8@7b}p%
z%8G9<@oq0NkvYqU(YAK5@b5Ph*o~~wN<W3v2;43Cyv*pGTH&@y^HwwkD@6{HLC*Nx>
>zq$Ai}?_eOfXYi_n13~J9gHMC|COhMxJV<|{&=ou|nHhz?AmMu05ipT@54Az!*%E{
>z2mY-Hyr7_hf1->t3L0IiEf&`ay@2BU3nr2|^yOcH#psBB=1jUYjpt#j;$Gh`Hok9k
>z8Rr;Xu04xi#h8%M721AsaYq#6s4UF}g<n??4f6lay=Cdiy26SD?Ow+Y8He+#wPQcd
>z?{Q{ES7{3((PE=3wa=Y)X%|1t&NH7VdyIa9D%Q2E^Q8(cEfsiYoagbI(R*~}=+z@e
>iU%p(4daSSeur1pQqwZ-Qvz0%l{2S+I^5IcyW8*)wU^<Tg
>
>literal 0
>HcmV?d00001
>
>--
>1.6.3.3
>
This is my next firmware patch to add upstream. Let me know if you have any issue.

Thanks,
Jothi
