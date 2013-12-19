Return-Path: <cyrus@holtmann.org>
From: "Chlad, SebastianX" <sebastianx.chlad@intel.com>
To: Szymon Janc <szymon.janc@tieto.com>,
	Sebastian Chlad <sebastianchlad@gmail.com>
CC: "Hedberg, Johan" <johan.hedberg@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH] android/pts: Add PICS, PIXITs and PTS for L2CAP
Date: Thu, 19 Dec 2013 09:45:31 +0000
Message-ID: <2115852EF878384FA984E6B76A9F379E164467@IRSMSX104.ger.corp.intel.com>
References: <2115852EF878384FA984E6B76A9F379E164297@IRSMSX104.ger.corp.intel.com>
 <1387444450-1511-1-git-send-email-sebastianx.chlad@intel.com>,<16520238.3ybnibyTNs@uw000953>
In-Reply-To: <16520238.3ybnibyTNs@uw000953>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


________________________________________
From: Szymon Janc [szymon.janc@tieto.com]
Sent: Thursday, December 19, 2013 11:42 AM
To: Sebastian Chlad
Cc: Hedberg, Johan; linux-bluetooth@vger.kernel.org; Chlad, SebastianX
Subject: Re: [PATCH] android/pts: Add PICS, PIXITs and PTS for L2CAP

Hi Sebastian,

> This allows better tracking of the current state of implementation
> ---
>  android/Makefile.am     |   4 +-
>  android/pics-l2cap.txt  | 157 ++++++++++++++++++++++++++++++++++++++++++++++++
>  android/pixit-l2cap.txt |  39 ++++++++++++
>  android/pts-l2cap.txt   | 149 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 348 insertions(+), 1 deletion(-)
>  create mode 100644 android/pics-l2cap.txt
>  create mode 100644 android/pixit-l2cap.txt
>  create mode 100644 android/pts-l2cap.txt
>

This one doesn't apply:

yes, indeed. I'll correct that. 

Seb

Applying: android/pts: Add PICS, PIXITs and PTS for L2CAP
error: patch failed: android/Makefile.am:111
error: android/Makefile.am: patch does not apply
/home/janccszy/devel/bluez/.git/rebase-apply/patch:385: new blank line at EOF.

--
BR
Szymon Janc
---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

