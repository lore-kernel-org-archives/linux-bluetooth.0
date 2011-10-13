Return-Path: <cyrus@holtmann.org>
From: "Lin, Mengdong" <mengdong.lin@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 13 Oct 2011 11:14:51 +0800
Subject: RE: Question about A2DP, Pulseaudio.
Message-ID: <749B9D3DBF0F054390025D9EAFF47F2212D292CE9E@shsmsx501.ccr.corp.intel.com>
References: <1318234286.16562.8.camel@chanten-desktop>
	<1318313229.11749.22.camel@snowflake>
	<749B9D3DBF0F054390025D9EAFF47F2212D28D505D@shsmsx501.ccr.corp.intel.com>
	<CABBYNZK2C9x3CeuiEiqwBGkpo-MZFDFstYRtMFnYtZAt9YZzFA@mail.gmail.com>
	<749B9D3DBF0F054390025D9EAFF47F2212D28D564A@shsmsx501.ccr.corp.intel.com>
 <CABBYNZLZGP0NZHbKUngERLasT1AAVdq2WUvdg7ASM0QotL2XeQ@mail.gmail.com>
In-Reply-To: <CABBYNZLZGP0NZHbKUngERLasT1AAVdq2WUvdg7ASM0QotL2XeQ@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> > -  For cell phone call, to let PA know a cell phone call begins so that it can set
> BT profile to "Off" and pause music, are you suggesting we write a PA module
> to detect cell modem call event?
> 
> Not exactly, we could probably have some mechanism to tag streams e.g.
> the dialer app tags its stream as 'voice' and the media player as
> 'music', this way PA don't need to depend on any telephony stack to do
> the profile switch.

I feel this method has a gap: 
Since the voice data from cell modem bypass PA in such a system, will the dialer app create the sink-input/source-output stream tagged as 'voice' or 'phone' for PA?
If the phone streams do not appear in PA, PA cannot know the time to switch profile by checking the stream's media role.

Please correct me if I misunderstand something.

Great thanks
Mengdong
