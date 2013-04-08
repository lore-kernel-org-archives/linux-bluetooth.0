Return-Path: <cyrus@holtmann.org>
Message-ID: <1365439197.3683.52.camel@laptop>
Subject: Re: [pulseaudio-discuss] Bluetooth pulseaudio multiple device
 entries
From: Tanu Kaskinen <tanuk@iki.fi>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: Colin Beckingham <colbec@start.ca>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	General PulseAudio Discussion
	<pulseaudio-discuss@lists.freedesktop.org>
Date: Mon, 08 Apr 2013 19:39:57 +0300
In-Reply-To: <CANT-zCW3fMvHN_Ga0n6N8Kg7Qq2bQyxT_fidkCT201UeCXaD5g@mail.gmail.com>
References: <515EBB91.1020006@start.ca>
	 <CANT-zCVRwyR9de4gHp5+ur3_oDcMnL4RttQFayBmUKYUrgJODA@mail.gmail.com>
	 <515EC86C.1020809@start.ca>
	 <CANT-zCW7+n0Jh84T1RSUnP47bf_t5rMQXBByKtegV0E+eM-w9g@mail.gmail.com>
	 <515FE45C.10908@start.ca>
	 <CANT-zCW3fMvHN_Ga0n6N8Kg7Qq2bQyxT_fidkCT201UeCXaD5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> On Sat, Apr 6, 2013 at 11:01 AM, Colin Beckingham <colbec@start.ca> wrote:
> > My testing to this point has been that the device was connected
> > automatically having been pre-registered and paired.
> >
> > So I deleted the pre-registered entry and re-paired the device. The device
> > entry behaved correctly when first paired, however when I left the
> > registration in place, unconnected the device and then reconnected it, the
> > duplicates reappeared.
> >
> > In fact each time I selected an entry at random and clicked "test speakers"
> > it created a new entry. At one point I had 6 entries all working and all the
> > same device.
> >
> > It certainly looks like a UI issue. I will contact the PA folks.
> > Thanks for helping me remove the BT side from the query list.

You can check if the bug is in the UI or in PulseAudio by running "pactl
list cards short" and "pactl list sinks short". I that shows multiple
entries for the same device, it's not a UI bug.

Is the UI that you're using pavucontrol or something else?

-- 
Tanu

