Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <749B9D3DBF0F054390025D9EAFF47F2212D28D564A@shsmsx501.ccr.corp.intel.com>
References: <1318234286.16562.8.camel@chanten-desktop>
	<1318313229.11749.22.camel@snowflake>
	<749B9D3DBF0F054390025D9EAFF47F2212D28D505D@shsmsx501.ccr.corp.intel.com>
	<CABBYNZK2C9x3CeuiEiqwBGkpo-MZFDFstYRtMFnYtZAt9YZzFA@mail.gmail.com>
	<749B9D3DBF0F054390025D9EAFF47F2212D28D564A@shsmsx501.ccr.corp.intel.com>
Date: Wed, 12 Oct 2011 10:31:50 +0300
Message-ID: <CABBYNZLZGP0NZHbKUngERLasT1AAVdq2WUvdg7ASM0QotL2XeQ@mail.gmail.com>
Subject: Re: Question about A2DP, Pulseaudio.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Lin, Mengdong" <mengdong.lin@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Oct 12, 2011 at 8:20 AM, Lin, Mengdong <mengdong.lin@intel.com> wrote:
> I don't mean simultaneous A2DP stream and SCO, but hope PA can pause music on a cell or voip call and change BT profile from A2DP to HSP for the call.

It sure can, but right now there is no policy for doing that in PA,
now that 1.0 was release we should probably try to make it happen.

> But for a system that does not export SCO path to the software stack (and if PA is used as the audio server)
> -  I think it cannot support VOIP call, because PA cannot exchange data between application and ALSA (via sco_sink/sco_source) or Bluez. Is this right?

Yep, VoIP is not support in such systems, so I hope people doing the
hardware/firmware realize that this is quite a huge limitation.

>  MeeGo harmattan is not such a system, I think, if it uses sco_sink/sco_source then it just exports SCO path through ALSA.
>
> -  For cell phone call, to let PA know a cell phone call begins so that it can set BT profile to "Off" and pause music, are you suggesting we write a PA module to detect cell modem call event?

Not exactly, we could probably have some mechanism to tag streams e.g.
the dialer app tags its stream as 'voice' and the media player as
'music', this way PA don't need to depend on any telephony stack to do
the profile switch.

> You have mentioned this is a common design for non-smart phones. Is PA suitable to play the role of audio server in such a design?

It is, we just need a way to configure PA to handle it e.g. by having
'none' as sco_sink/sco_source we should set the profile to 'off'.

-- 
Luiz Augusto von Dentz
