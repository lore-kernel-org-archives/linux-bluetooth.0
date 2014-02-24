Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>, "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] android/pics: Add PICS and PIXIT for HSP
Date: Mon, 24 Feb 2014 20:17:47 +0100
Message-ID: <1813726.pFGF1AVLyQ@athlon>
In-Reply-To: <6632C143-D06A-48DC-A403-FDE4B40AB1B5@holtmann.org>
References: <1393242895-19447-1-git-send-email-sebastian.chlad@tieto.com> <6632C143-D06A-48DC-A403-FDE4B40AB1B5@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Monday 24 February 2014 09:57:14 Marcel Holtmann wrote:
> Hi Sebastian,
> 
> > Added PICS and PIXIT target Android 4.4
> > ---
> > android/Makefile.am   |   2 +
> > android/pics-hsp.txt  | 103
> > ++++++++++++++++++++++++++++++++++++++++++++++++++ android/pixit-hsp.txt
> > |  30 +++++++++++++++
> > 3 files changed, 135 insertions(+)
> > create mode 100644 android/pics-hsp.txt
> > create mode 100644 android/pixit-hsp.txt
> 
> so we are doing Headset profile (HSP) and also Handsfree profile (HFP). I am
> fine with also doing HSP since it seems that is what Android uses on
> tablets.

Both HSP and HFP are handled by handsfree HAL sp we would probably need some 
extra argument in IPC to allow disabling HFP if not required. And some 
configuration (runtime/compile time?) flag for libhal.


-- 
Szymon K. Janc
szymon.janc@gmail.com
