Return-Path: <cyrus@holtmann.org>
From: "Lin, Mengdong" <mengdong.lin@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 12 Oct 2011 13:20:57 +0800
Subject: RE: Question about A2DP, Pulseaudio.
Message-ID: <749B9D3DBF0F054390025D9EAFF47F2212D28D564A@shsmsx501.ccr.corp.intel.com>
References: <1318234286.16562.8.camel@chanten-desktop>
	<1318313229.11749.22.camel@snowflake>
	<749B9D3DBF0F054390025D9EAFF47F2212D28D505D@shsmsx501.ccr.corp.intel.com>
 <CABBYNZK2C9x3CeuiEiqwBGkpo-MZFDFstYRtMFnYtZAt9YZzFA@mail.gmail.com>
In-Reply-To: <CABBYNZK2C9x3CeuiEiqwBGkpo-MZFDFstYRtMFnYtZAt9YZzFA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Great thanks for your clarification, Luiz! I still have some questions.

> >> ... Apparently some system don't even bother
> >> exporting this audio path to the software stack because it is only
> >> active while on call, if this is your case then it means we cannot
> >> control the audio routing in software and we probably should do
> >> nothing (e.g. set sco_sink/sco_source to "none" and when HFP/HSP is
> >> active set card profile to 'Off'), but note that this type of
> >> configuration has many limitation for instance a system like that
> >> cannot do navigation or voice commands using SCO.
> >
> > Hi Luiz,
> >
> > Would you kindly share more information on a system that does not export
> SCO audio path to the software stack? Is it a typical design for handset?
> 
> Apparently it is common design in handset world, but probably not so
> common in smartphones where some other use cases need to be supported
> such as navigation, voice command and voip calls.

> 
> > If I have a BT headset that can support both A2DP and HSP profile, and I want
> to hear music in A2DP and make a phone call in HSP profile on such a system, is
> it possible?
> > If it's possible, how can pulseaudio set BT headset to A2DP profile for music
> and change to 'Off' profile on call? Can PA know when a call begins or ends on
> such a system, in order to change BT profile?
> 
> If you mean simultaneously A2DP stream and SCO then probably not, most
> headset simple cannot do audio mixing so it is either SCO _or_ A2DP,
> also there are recommendation to always switch the profiles but not to
> use them simultaneously e.g. suspend A2DP streaming while SCO is
> connected. As for PA knowing when to switch we probably need to work
> on that, other systems like MeeGo harmattan have external components
> to do that, but IMO it would have been much better to have such thing
> directly in PA as a module.
> 

I don't mean simultaneous A2DP stream and SCO, but hope PA can pause music on a cell or voip call and change BT profile from A2DP to HSP for the call.

But for a system that does not export SCO path to the software stack (and if PA is used as the audio server)
-  I think it cannot support VOIP call, because PA cannot exchange data between application and ALSA (via sco_sink/sco_source) or Bluez. Is this right?
  MeeGo harmattan is not such a system, I think, if it uses sco_sink/sco_source then it just exports SCO path through ALSA.

-  For cell phone call, to let PA know a cell phone call begins so that it can set BT profile to "Off" and pause music, are you suggesting we write a PA module to detect cell modem call event? 

You have mentioned this is a common design for non-smart phones. Is PA suitable to play the role of audio server in such a design?

Thanks
Mengdong
