Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 Nov 2011 16:54:01 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Arkadiusz.Lichwa@tieto.com
Cc: linux-bluetooth@vger.kernel.org, iliak@ti.com,
	ulrik.lauren@stericsson.com
Subject: Re: [PATCH cover letter] Bluetooth: Revert: Fix L2CAP connection ...
Message-ID: <20111107185401.GA3707@joana>
References: <1319621002-7122-1-git-send-email-arkadiusz.lichwa@tieto.com>
 <20111031190129.GA10164@joana>
 <BF2CDDEFEC2D1E42A67A8AE0508897EC3E92178FAA@EXMB02.eu.tieto.com>
 <20111104171821.GE6171@joana>
 <BF2CDDEFEC2D1E42A67A8AE0508897EC3E92179C49@EXMB02.eu.tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BF2CDDEFEC2D1E42A67A8AE0508897EC3E92179C49@EXMB02.eu.tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


* Arkadiusz.Lichwa@tieto.com <Arkadiusz.Lichwa@tieto.com> [2011-11-07 12:06:32 +0200]:

> 
> >From: Gustavo F. Padovan [mailto:pao@profusion.mobi] On Behalf Of Gustavo
> >Padovan
> >Sent: Friday, November 04, 2011 6:18 PM
> >To: Lichwa Arkadiusz
> >Cc: linux-bluetooth@vger.kernel.org; iliak@ti.com; ulrik.lauren@stericsson.com
> >Subject: Re: [PATCH cover letter] Bluetooth: Revert: Fix L2CAP connection ...
> >
> >Hi Arek,
> >
> >* Arkadiusz.Lichwa@tieto.com <Arkadiusz.Lichwa@tieto.com> [2011-11-02
> >09:53:10 +0200]:
> >
> >>
> >> Hi Gustavo
> >>
> >> >From: Gustavo F. Padovan [mailto:pao@profusion.mobi] On Behalf Of Gustavo
> >> >Padovan
> >> >Sent: Monday, October 31, 2011 8:01 PM
> >> >To: Lichwa Arkadiusz
> >> >Cc: linux-bluetooth@vger.kernel.org; iliak@ti.com; ulrik.lauren@stericsson.com
> >> >Subject: Re: [PATCH cover letter] Bluetooth: Revert: Fix L2CAP connection ...
> >> >
> >> >Hi Arek,
> >> >
> >> >* Arek Lichwa <arkadiusz.lichwa@tieto.com> [2011-10-26 11:23:21 +0200]:
> >> >
> >> >> Hi
> >> >>
> >> >> We found during testing problem when setting rfcomm (SPP) channel between
> >> >> two 2.1 devices.
> >> >> The test case always failed mostly saying security block on l2cap level
> >> >> but sometimes the fail root cause was 'Command not understood' on l2cap
> >> >> as well.
> >> >> Analyzing security block issue, I found that there's unencrypted link when
> >> >> l2cap command 'connection request' is sent to remote.
> >> >> The second issue with 'command not understood' has turn out to be related to
> >> >> expiration of l2cap timer and its implications.
> >> >>
> >> >> Solution that I found to fix the problem seems to be related to old commit
> >> >> 330605423ca6eafafb8dcc27502bce1c585d1b06 made by Ilia Kolomisnky.
> >When
> >> >there's
> >> >> authentication ongoing, 'encryption pending' should be turn on, otherwise
> >> >> there're situations when link stays unencrypted.
> >> >> The issue with timer expiration is related to Andrzej Kaczmarek's patch
> >> >> sent to community a couple days ago (~ 2011/10/20).
> >> >> This patch actually recalculates (repairs) timer values on l2cap which were
> >> >> wrongly converted before.
> >> >> With this patch the expiration issue disappears during the test case
> >> >> I've made, otherwise just reverting
> >> >330605423ca6eafafb8dcc27502bce1c585d1b06
> >> >> is not enough, since timer issue blocks very often passing the test case.
> >> >
> >> >Are you saying that Andrzej's patch together with revert of 330605423 fixes
> >> >the problem? and are you sure that we are not creating any new regression?
> >> >
> >> >	Gustavo
> >>
> >> Yes, that's right, it fixes.
> >> About potencial new regression, I don't think so since previous code before Ilia
> >made change was stable and verified. Did you asked Ilia about regression report
> >that time?
> >
> >So did you test this in many different cases? with and without SSP, in all
> >security levels, with and without MITM protection and so on?
> 
> Hi Gustavo,
> 
> Should't such scenarios to be run/verified on bluez community's 
> common security regression test framework/set ? 
> Looks like now everyone (I hope) verify against his own and it's not trustable.
> 
> To your questions, yes, I did, do you belive me ? :)

Ok, I'm applying this one to the bluetooth tree (aka linux 3.2). Thanks.

Also I verified the need of this patch while developing the security patches I
just sent to the mailing list, it only works if I revert this patch.

	Gustavo
