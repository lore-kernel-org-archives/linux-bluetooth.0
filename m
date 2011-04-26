Return-Path: <cyrus@holtmann.org>
From: Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
To: "dwmw2@infradead.org" <dwmw2@infradead.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Shanmugamkamatchi Balashanmugam
	<Shanmugamkamatchi.Balashanmugam@Atheros.com>
Date: Wed, 27 Apr 2011 02:24:21 +0530
Subject: RE: [PATCH] linux-firmware: Add patch and sysconfig files
Message-ID: <44EE5C37ADC36343B0625A05DD408C48517D2D6D61@CHEXMB-01.global.atheros.com>
References: <1301649288-3315-1-git-send-email-jkumar@atheros.com>
  <44EE5C37ADC36343B0625A05DD408C4850EF09CA00@CHEXMB-01.global.atheros.com>
In-Reply-To: <44EE5C37ADC36343B0625A05DD408C4850EF09CA00@CHEXMB-01.global.atheros.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

>-----Original Message-----
>From: Jothikumar Mothilal 
>Sent: Thursday, April 07, 2011 3:29 PM
>To: Jothikumar Mothilal; dwmw2@infradead.org
>Cc: linux-bluetooth@vger.kernel.org; Shanmugamkamatchi Balashanmugam
>Subject: RE: [PATCH] linux-firmware: Add patch and sysconfig files
>
>Hi David,
>
-----Original Message-----
>From: Jothikumar Mothilal 
>Sent: Monday, April 04, 2011 12:29 PM
>To: Jothikumar Mothilal; dwmw2@infradead.org
>Cc: linux-bluetooth@vger.kernel.org; Shanmugamkamatchi Balashanmugam
>Subject: RE: [PATCH] linux-firmware: Add patch and sysconfig files

>Hi David,

-----Original Message-----
From: Jothikumar Mothilal 
Sent: Friday, April 01, 2011 2:45 PM
To: dwmw2@infradead.org
Cc: linux-bluetooth@vger.kernel.org; Shanmugamkamatchi Balashanmugam; Jothikumar Mothilal
>Subject: [PATCH] linux-firmware: Add patch and sysconfig files

>Added files for AR3012 version 2.2

>Signed-off-by: Jothikumar Mothilal <jkumar@atheros.com>
>---
> WHENCE                       |    2 ++
> ar3k/AthrBT_0x01020200.dfu   |  Bin 0 -> 40596 bytes
> ar3k/ramps_0x01020200_26.dfu |  Bin 0 -> 1262 bytes
> 3 files changed, 2 insertions(+), 0 deletions(-)
> create mode 100644 ar3k/AthrBT_0x01020200.dfu
 >create mode 100644 ar3k/ramps_0x01020200_26.dfu

>diff --git a/WHENCE b/WHENCE
>index 6632b85..f6a0ec1 100644
>--- a/WHENCE
>+++ b/WHENCE
>@@ -1555,6 +1555,8 @@ Driver: DFU Driver for Atheros bluetooth chipset AR3012
 
> File: ar3k/AthrBT_0x01020001.dfu
> File: ar3k/ramps_0x01020001_26.dfu
>+File: ar3k/AthrBT_0x01020200.dfu
>+File: ar3k/ramps_0x01020200_26.dfu
 
 >Licence: Redistributable. See LICENCE.atheros_firmware for details
 
>diff --git a/ar3k/AthrBT_0x01020200.dfu b/ar3k/AthrBT_0x01020200.dfu
>new file mode 100644

> literal 0
>HcmV?d00001

> -- 
> 1.6.3.3

>Can you please push this firmware patch upstream if you have no comments.

Did you get a chance to push this firmware patch upstream?
Please let me know if you have any issue.

Thanks,
Jothi
