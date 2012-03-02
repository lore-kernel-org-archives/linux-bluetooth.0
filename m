Return-Path: <cyrus@holtmann.org>
Date: Fri, 2 Mar 2012 14:32:15 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: santosh prasad nayak <santoshprasadnayak@gmail.com>
Cc: marcel@holtmann.org, padovan@profusion.mobi, davem@davemloft.net,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: Resend: [PATCH] Bluetooth: Fix Endian Bug.
Message-ID: <20120302123210.GA4741@aemeltch-MOBL1>
References: <1330599561-20392-1-git-send-email-santoshprasadnayak@gmail.com>
 <20120301123540.GE25627@aemeltch-MOBL1>
 <CAOD=uF4LSS8nuKMNHGEH2JsVZHU0rntSxZjvNaa4oZrey1macw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAOD=uF4LSS8nuKMNHGEH2JsVZHU0rntSxZjvNaa4oZrey1macw@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santosh,

On Thu, Mar 01, 2012 at 07:34:58PM +0530, santosh prasad nayak wrote:
> Andrei,
> 
> I could not get you.
> 
> Do you want me to resend the patch with subject,
>   "[PATCH] Bluetooth: Fix network to host endian conversion for L2CAP
> chan id."  ?

No, the main concern was your commit message which is changelog and should
come after "---" as it is shown in the example below.

> > On Thu, Mar 01, 2012 at 04:29:21PM +0530, santosh nayak wrote:
> >> From: Santosh Nayak <santoshprasadnayak@gmail.com>
> >>
> >> Fix for endian bug.
> >>
> >> Fix for null dereferenced removed as it is already
> >> submitted by Andrei.
> >>
> >> Signed-off-by: Santosh Nayak <santoshprasadnayak@gmail.com>
> >> ---
> >>  net/bluetooth/l2cap_sock.c |    5 +++--
> >>  1 files changed, 3 insertions(+), 2 deletions(-)
> >
> > We prefer following commit log (this is the example)
> >
> > <------8<----------------------------------------------------------
> > |  From: Santosh Nayak <santoshprasadnayak@gmail.com>
> > |
> > |  Fix network to host endian conversion for L2CAP chan id.
> > |
> > |  Signed-off-by: Santosh Nayak <santoshprasadnayak@gmail.com>
> > |
> > |  ---
> > |          * v2 Fix for null dereferenced removed as it is already
> > |          submitted by Andrei.
> > |
> > |    net/bluetooth/l2cap_sock.c |    5 +++--
> > |    1 files changed, 3 insertions(+), 2 deletions(-)
> > |
> > <------8<----------------------------------------------------------

Best regards 
Andrei Emeltchenko 
