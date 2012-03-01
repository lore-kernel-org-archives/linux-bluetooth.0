Return-Path: <cyrus@holtmann.org>
From: "Kumar, Sunil A" <sunil.a.kumar@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Nair, Rashmi G" <rashmi.g.nair@intel.com>,
	"Khanzode, Prashant" <prashant.khanzode@intel.com>,
	"Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Subject: RE: Response to AVRCP Passthrough Commands.
Date: Thu, 1 Mar 2012 09:53:37 +0000
Message-ID: <8948CE8A2D1716449B389D5F68D4A30E020969@FMSMSX108.amr.corp.intel.com>
References: <8948CE8A2D1716449B389D5F68D4A30E02048F@FMSMSX108.amr.corp.intel.com>
	<20120228130505.GA4170@vader>
	<CABBYNZL32nUYXTXTM1gCmRhGms5qGpW2uibyT5j5gDBow8Akiw@mail.gmail.com>
	<8948CE8A2D1716449B389D5F68D4A30E02072B@FMSMSX108.amr.corp.intel.com>
 <CABBYNZJvgqDhknP-4OWDYP3MZD5nrn3oPq9cO313cJfY7BEV2Q@mail.gmail.com>
In-Reply-To: <CABBYNZJvgqDhknP-4OWDYP3MZD5nrn3oPq9cO313cJfY7BEV2Q@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Thanks for the details. It clarifies the questions. And agree with you that there is no use to make any change here when we are already moving to AVRCP1.3/1.4.

Hi Lucas,

I was not able to test your patch on latest Bluez version as Android version we are using still makes use of Bluez4.47. But, I made similar changes over 4.47 and I didn't see any error from PTS. So, your patch shall be good to go.
Thanks.

Best Regards
Sunil Kumar
-----Original Message-----
From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com] 
Sent: Wednesday, February 29, 2012 6:53 PM
To: Kumar, Sunil A
Cc: Lucas De Marchi; linux-bluetooth@vger.kernel.org; Nair, Rashmi G; Khanzode, Prashant; Von Dentz, Luiz
Subject: Re: Response to AVRCP Passthrough Commands.

Hi Sunil,

On Wed, Feb 29, 2012 at 2:20 PM, Kumar, Sunil A <sunil.a.kumar@intel.com> wrote:
> Hi Luiz/Lucas,
>
> Thanks for your inputs.
>
> I agree that situation can be workaround to a great extent using metadata in devices supporting the same. Though, the error codes hold importance in some cases:
>
> - Purely from specification perspective, we are not doing right thing 
> here. But, we can ignore this until we have strong reasons for not 
> doing so :-)

AV/C spec targets completely different system than AVRCP, that why ipod like devices uses MTP.

> - Consider a Carkit which supports Media Player with TOUCH BUTTONS and still operating with AVRCP 1.0. User presses the Play button to start the music playback but TG could not really start it because of an internal error. In this case, if TG responds with ACCEPTED then I expect Carkit to change Play button to Pause button even though playback has not started (many of the Carkits really will not look at A2DP state to change the play button to pause button) whereas if TG responds with REJECTED then Play button will still stay as Play which is right as well so that user can try again.

The carkit implementations really got this wrong, first there are several recommendation not do toggling for PLAY/PAUSE, the second and to me more important is that TG should not be treated as single purpose player application so using the PLAY to try to start a specific application just doesn't work, it is the same as hitting play button on keyboard even Windows doesn't react to that because it doesn't know what application to open or what to play.

AVRCP 1.4 attempt to fix this with media browsing, although Im not sure why this is not done using OBEX as it fits much better when possible dealing with files and browsing directories, so you can actually select what you want to play.

> - Assumption in Bluez that application supports all commands supported by Bluez is not right as some of these commands are optional and hence, application can choose to not support. And hence, it might be better option to leave the final decision on user (application in this case) but of course, we have complexities in place mentioned by Luiz.

We are assuming that if we are able to translate the command into Linux input system it will be considered accepted, it is the remote stack that is trying to be smart and triggering special handling depending on the response. It also doesn't work given the application the possibility to tell what commands it supports, because this is done in runtime depending on what application is in focus, it can even be a browser accessing youtube.

> Again, as Luiz said effort is really high to change the design. So, not sure if gains are really proportional and hence, please see if we really need to do something here.

I really think this doesn't worth the effort, BlueZ already supports
1.3 and there is plans to support 1.4, Android and others will follow and carkits will have to catch up as well, so trying to do something about this for AVRCP 1.0 sounds pretty useless to me.

--
Luiz Augusto von Dentz
