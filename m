Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <749B9D3DBF0F054390025D9EAFF47F2212D28D505D@shsmsx501.ccr.corp.intel.com>
References: <1318234286.16562.8.camel@chanten-desktop>
	<1318313229.11749.22.camel@snowflake>
	<749B9D3DBF0F054390025D9EAFF47F2212D28D505D@shsmsx501.ccr.corp.intel.com>
Date: Tue, 11 Oct 2011 13:36:40 +0300
Message-ID: <CABBYNZK2C9x3CeuiEiqwBGkpo-MZFDFstYRtMFnYtZAt9YZzFA@mail.gmail.com>
Subject: Re: Question about A2DP, Pulseaudio.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Lin, Mengdong" <mengdong.lin@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Oct 11, 2011 at 9:19 AM, Lin, Mengdong <mengdong.lin@intel.com> wrote:
>> > 4. Is there anyone could explain sco_sink, sco_source? If there are ALSA
>> > code related to it, could you tell me the link that explain ?
>
>> … Apparently some system don't even bother
>> exporting this audio path to the software stack because it is only
>> active while on call, if this is your case then it means we cannot
>> control the audio routing in software and we probably should do
>> nothing (e.g. set sco_sink/sco_source to "none" and when HFP/HSP is
>> active set card profile to 'Off'), but note that this type of
>> configuration has many limitation for instance a system like that
>> cannot do navigation or voice commands using SCO.
>
> Hi Luiz,
>
> Would you kindly share more information on a system that does not export SCO audio path to the software stack? Is it a typical design for handset?

Apparently it is common design in handset world, but probably not so
common in smartphones where some other use cases need to be supported
such as navigation, voice command and voip calls.

> If I have a BT headset that can support both A2DP and HSP profile, and I want to hear music in A2DP and make a phone call in HSP profile on such a system, is it possible?
> If it’s possible, how can pulseaudio set BT headset to A2DP profile for music and change to ‘Off’ profile on call? Can PA know when a call begins or ends on such a system, in order to change BT profile?

If you mean simultaneously A2DP stream and SCO then probably not, most
headset simple cannot do audio mixing so it is either SCO _or_ A2DP,
also there are recommendation to always switch the profiles but not to
use them simultaneously e.g. suspend A2DP streaming while SCO is
connected. As for PA knowing when to switch we probably need to work
on that, other systems like MeeGo harmattan have external components
to do that, but IMO it would have been much better to have such thing
directly in PA as a module.

-- 
Luiz Augusto von Dentz
