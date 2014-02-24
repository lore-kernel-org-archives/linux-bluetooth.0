Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH] android/pics: Add PICS and PIXIT for HSP
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1813726.pFGF1AVLyQ@athlon>
Date: Mon, 24 Feb 2014 11:34:26 -0800
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>,
	"bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <781D8095-A034-40C5-904A-E56BB63870AC@holtmann.org>
References: <1393242895-19447-1-git-send-email-sebastian.chlad@tieto.com> <6632C143-D06A-48DC-A403-FDE4B40AB1B5@holtmann.org> <1813726.pFGF1AVLyQ@athlon>
To: Szymon Janc <szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

>>> Added PICS and PIXIT target Android 4.4
>>> ---
>>> android/Makefile.am   |   2 +
>>> android/pics-hsp.txt  | 103
>>> ++++++++++++++++++++++++++++++++++++++++++++++++++ android/pixit-hsp.txt
>>> |  30 +++++++++++++++
>>> 3 files changed, 135 insertions(+)
>>> create mode 100644 android/pics-hsp.txt
>>> create mode 100644 android/pixit-hsp.txt
>> 
>> so we are doing Headset profile (HSP) and also Handsfree profile (HFP). I am
>> fine with also doing HSP since it seems that is what Android uses on
>> tablets.
> 
> Both HSP and HFP are handled by handsfree HAL sp we would probably need some 
> extra argument in IPC to allow disabling HFP if not required. And some 
> configuration (runtime/compile time?) flag for libhal.

I do not want a compile time option. Is that how Bluedroid handles it. For examples Nexus 4 vs Nexus 7.

The easiest would be to have some IPC option to set HSP and HFP. Meaning that we could have a property that the HAL sets and then just uses that to tell the daemon what to enabled.

I am thinking we might just need a flags parameter to the Register module command in the core service. Or alternatively, have a Set Option command.

Right now I would tend to do the Set Option command. So the HAL can configure certain options.

Regards

Marcel

