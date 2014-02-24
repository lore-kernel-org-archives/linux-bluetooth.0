Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>, "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] android/pics: Add PICS and PIXIT for HSP
Date: Mon, 24 Feb 2014 21:31:19 +0100
Message-ID: <2241923.8SUrdZlcfd@athlon>
In-Reply-To: <781D8095-A034-40C5-904A-E56BB63870AC@holtmann.org>
References: <1393242895-19447-1-git-send-email-sebastian.chlad@tieto.com> <1813726.pFGF1AVLyQ@athlon> <781D8095-A034-40C5-904A-E56BB63870AC@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Monday 24 February 2014 11:34:26 Marcel Holtmann wrote:
> Hi Szymon,
> 
> >>> Added PICS and PIXIT target Android 4.4
> >>> ---
> >>> android/Makefile.am   |   2 +
> >>> android/pics-hsp.txt  | 103
> >>> ++++++++++++++++++++++++++++++++++++++++++++++++++ android/pixit-hsp.txt
> >>> 
> >>> |  30 +++++++++++++++
> >>> 
> >>> 3 files changed, 135 insertions(+)
> >>> create mode 100644 android/pics-hsp.txt
> >>> create mode 100644 android/pixit-hsp.txt
> >> 
> >> so we are doing Headset profile (HSP) and also Handsfree profile (HFP). I
> >> am fine with also doing HSP since it seems that is what Android uses on
> >> tablets.
> > 
> > Both HSP and HFP are handled by handsfree HAL sp we would probably need
> > some extra argument in IPC to allow disabling HFP if not required. And
> > some configuration (runtime/compile time?) flag for libhal.
> 
> I do not want a compile time option. Is that how Bluedroid handles it. For
> examples Nexus 4 vs Nexus 7.

Yes, Bluedroid is compile-time configured, device that wants to use
non-default options provides those in bdroid_buildcfg.h header eg.

this is defined for Nexus7 (flo), but not for Nexus4 (mako)
#define BTIF_HF_SERVICES (BTA_HSP_SERVICE_MASK)

> 
> The easiest would be to have some IPC option to set HSP and HFP. Meaning
> that we could have a property that the HAL sets and then just uses that to
> tell the daemon what to enabled.
> 
> I am thinking we might just need a flags parameter to the Register module
> command in the core service. Or alternatively, have a Set Option command.
> 
> Right now I would tend to do the Set Option command. So the HAL can
> configure certain options.

I agree, for now we can provide such option command, if it turns out that more 
profiles HALs need configuration we can move to flags in register commands.

-- 
Szymon K. Janc
szymon.janc@gmail.com
