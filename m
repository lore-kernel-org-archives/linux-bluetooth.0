Return-Path: <cyrus@holtmann.org>
Date: Mon, 9 May 2011 19:52:47 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: Arun Kumar SINGH <arunkr.singh@stericsson.com>,
	Anurag Gupta <anurag1303@gmail.com>, pkrystad@codeaurora.org,
	linux-bluetooth@vger.kernel.org
Subject: Re: BT 3.0 HS Support in BlueZ
Message-ID: <20110509225246.GB2203@joana>
References: <BANLkTimKJNo9WgwkfC2Hci-dW6kjF3VWGw@mail.gmail.com>
 <20110419180425.GA2476@joana>
 <AFCDDB4A3EA003429EEF1E7B211FDBBA3395937A4C@EXDCVYMBSTM005.EQ1STM.local>
 <20110505201531.GE2098@joana>
 <alpine.DEB.2.00.1105051548540.4213@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.00.1105051548540.4213@localhost6.localdomain6>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2011-05-05 16:27:17 -0700]:

> 
> On Thu, 5 May 2011, Gustavo F. Padovan wrote:
> 
> > Hi Arun,
> >
> > * Arun Kumar SINGH <arunkr.singh@stericsson.com> [2011-05-05 09:26:58 +0200]:
> >
> >> Hi Gustavo,
> >>
> >>>> Does anybody know if
> >>> bluetooth 3.0 HS spec is
> >>> supported in BlueZ?
> >>>> Is AMP supported in BlueZ?
> >>>
> >>> There is two different
> >>> implementations, one by
> >>> Atheros and another by QuIC.
> >>> Both never reach upstream,
> >>> if you look to the list logs
> >>> you will find them.
> >>
> >>
> >> Any hopes of getting this unified version upstream anytime in near future? I guess this has been on the cards for some time now given that merge process started last august.
> >
> > I'm interested in have this on the stack but it doesn't depend on me.
> > Patches for this are not arriving to the mailing list. Actually we had no real
> > feedback for AMP since the meeting in Boston.
> 
> Gustavo, Arun:
> 
> We do still plan to upstream our Bluetooth 3.0 + HS implementation.  I 
> will start work on upstreaming later this month, but I need to merge 
> in all of the recent L2CAP refactoring changes.
> 
> Also note that Qualcomm and Atheros have announced a merger.
> 
> You can find the kernel AMP implementation in the codeaurora.org 
> Android git trees:
> 
> git://codeaurora.org/kernel/msm.git
> https://www.codeaurora.org/gitweb/quic/la/?p=kernel/msm.git;a=summary
> 
> The android-msm-2.6.35 and msm-2.6.38 branches contain the AMP code.
> 
> 
> Please let me know if you have any other questions about AMP.

Isn't Extended Flow Specification a required feature for AMP? I haven't seen
it in your implementation.

-- 
Gustavo F. Padovan
http://profusion.mobi
