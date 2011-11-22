Return-Path: <cyrus@holtmann.org>
From: <Arkadiusz.Lichwa@tieto.com>
To: <padovan@profusion.mobi>
CC: <linux-bluetooth@vger.kernel.org>, <iliak@ti.com>,
	<ulrik.lauren@stericsson.com>, <peter@hurleysoftware.com>
Date: Tue, 22 Nov 2011 15:27:17 +0200
Subject: RE: [PATCH cover letter] Bluetooth: Revert: Fix L2CAP connection ...
Message-ID: <BF2CDDEFEC2D1E42A67A8AE0508897EC3E9238C49C@EXMB02.eu.tieto.com>
References: <1319621002-7122-1-git-send-email-arkadiusz.lichwa@tieto.com>
 <20111031190129.GA10164@joana>
 <BF2CDDEFEC2D1E42A67A8AE0508897EC3E92178FAA@EXMB02.eu.tieto.com>
 <20111104171821.GE6171@joana>
 <BF2CDDEFEC2D1E42A67A8AE0508897EC3E92179C49@EXMB02.eu.tieto.com>
 <20111107185401.GA3707@joana>
In-Reply-To: <20111107185401.GA3707@joana>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo

>-----Original Message-----
>From: Gustavo F. Padovan [mailto:pao@profusion.mobi] On Behalf Of Gustavo
>Padovan
>Sent: Monday, November 07, 2011 7:54 PM
>To: Lichwa Arkadiusz
>Cc: linux-bluetooth@vger.kernel.org; iliak@ti.com; ulrik.lauren@stericsson.com
>Subject: Re: [PATCH cover letter] Bluetooth: Revert: Fix L2CAP connection ...
>
>
>* Arkadiusz.Lichwa@tieto.com <Arkadiusz.Lichwa@tieto.com> [2011-11-07
>12:06:32 +0200]:
>
>>
>> >From: Gustavo F. Padovan [mailto:pao@profusion.mobi] On Behalf Of Gustavo
>> >Padovan
>> >Sent: Friday, November 04, 2011 6:18 PM
>> >To: Lichwa Arkadiusz
>> >Cc: linux-bluetooth@vger.kernel.org; iliak@ti.com; ulrik.lauren@stericsson.com
>> >Subject: Re: [PATCH cover letter] Bluetooth: Revert: Fix L2CAP connection ...
>> >
>> >Hi Arek,
>> >
>> >* Arkadiusz.Lichwa@tieto.com <Arkadiusz.Lichwa@tieto.com> [2011-11-02
>> >09:53:10 +0200]:
>> >
>> >>
>> >> Hi Gustavo
>> >>
>> >> >From: Gustavo F. Padovan [mailto:pao@profusion.mobi] On Behalf Of
>Gustavo
>> >> >Padovan
>> >> >Sent: Monday, October 31, 2011 8:01 PM
>> >> >To: Lichwa Arkadiusz
>> >> >Cc: linux-bluetooth@vger.kernel.org; iliak@ti.com;
>ulrik.lauren@stericsson.com
>> >> >Subject: Re: [PATCH cover letter] Bluetooth: Revert: Fix L2CAP connection ...
>> >> >
>> >> >Hi Arek,
>> >> >
>> >> >* Arek Lichwa <arkadiusz.lichwa@tieto.com> [2011-10-26 11:23:21 +0200]:
>> >> >
>> >> >> Hi
>> >> >>
>> >> >> We found during testing problem when setting rfcomm (SPP) channel
>between
>> >> >> two 2.1 devices.
>> >> >> The test case always failed mostly saying security block on l2cap level
>> >> >> but sometimes the fail root cause was 'Command not understood' on l2cap
>> >> >> as well.
>> >> >> Analyzing security block issue, I found that there's unencrypted link when
>> >> >> l2cap command 'connection request' is sent to remote.
>> >> >> The second issue with 'command not understood' has turn out to be related
>to
>> >> >> expiration of l2cap timer and its implications.
>> >> >>
>> >> >> Solution that I found to fix the problem seems to be related to old commit
>> >> >> 330605423ca6eafafb8dcc27502bce1c585d1b06 made by Ilia Kolomisnky.
>> >When
>> >> >there's
>> >> >> authentication ongoing, 'encryption pending' should be turn on, otherwise
>> >> >> there're situations when link stays unencrypted.
>> >> >> The issue with timer expiration is related to Andrzej Kaczmarek's patch
>> >> >> sent to community a couple days ago (~ 2011/10/20).
>> >> >> This patch actually recalculates (repairs) timer values on l2cap which were
>> >> >> wrongly converted before.
>> >> >> With this patch the expiration issue disappears during the test case
>> >> >> I've made, otherwise just reverting
>> >> >330605423ca6eafafb8dcc27502bce1c585d1b06
>> >> >> is not enough, since timer issue blocks very often passing the test case.
>> >> >
>> >> >Are you saying that Andrzej's patch together with revert of 330605423 fixes
>> >> >the problem? and are you sure that we are not creating any new regression?
>> >> >
>> >> >	Gustavo
>> >>
>> >> Yes, that's right, it fixes.
>> >> About potencial new regression, I don't think so since previous code before Ilia
>> >made change was stable and verified. Did you asked Ilia about regression report
>> >that time?
>> >
>> >So did you test this in many different cases? with and without SSP, in all
>> >security levels, with and without MITM protection and so on?
>>
>> Hi Gustavo,
>>
>> Should't such scenarios to be run/verified on bluez community's
>> common security regression test framework/set ?
>> Looks like now everyone (I hope) verify against his own and it's not trustable.
>>
>> To your questions, yes, I did, do you belive me ? :)
>
>Ok, I'm applying this one to the bluetooth tree (aka linux 3.2). Thanks.
>
>Also I verified the need of this patch while developing the security patches I
>just sent to the mailing list, it only works if I revert this patch.
>
>	Gustavo

Looks like the patch got to be reverted. 
More thorough / manual tests showed the problem on setting up subsequent
l2cap channels with legacy devices.
The root cause of generating the patch was security block on l2cap setup what 
I've been experiencing and it means no encryption was set on link when testing 
ssp (2.1) devices.

On my operational kernel 3.0 branch I've adopted Peter's Hurley patch which 
solves the issue. This patch wasn't applied to bluetooth-next branch 
but I think it should be in.
Correct me if I'm wrong.

Quoting part of Peter's request ...
From: Peter Hurley <peter@hurleysoftware.com>
Date: Mon, Aug 8, 2011 at 7:33 PM
Subject: [PATCH] Bluetooth: Fix l2cap conn failures for ssp devices
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
<...>

BR,
Arek
