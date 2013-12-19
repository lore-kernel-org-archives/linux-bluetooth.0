Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastianchlad@gmail.com>
Cc: johan.hedberg@intel.com, linux-bluetooth@vger.kernel.org,
	Sebastian Chlad <sebastianx.chlad@intel.com>
Subject: Re: [PATCH] android/pts: Add PICS, PIXITs and PTS for L2CAP
Date: Thu, 19 Dec 2013 10:42:36 +0100
Message-ID: <16520238.3ybnibyTNs@uw000953>
In-Reply-To: <1387444450-1511-1-git-send-email-sebastianx.chlad@intel.com>
References: <2115852EF878384FA984E6B76A9F379E164297@IRSMSX104.ger.corp.intel.com> <1387444450-1511-1-git-send-email-sebastianx.chlad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

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

Applying: android/pts: Add PICS, PIXITs and PTS for L2CAP
error: patch failed: android/Makefile.am:111
error: android/Makefile.am: patch does not apply
/home/janccszy/devel/bluez/.git/rebase-apply/patch:385: new blank line at EOF.

-- 
BR
Szymon Janc
