Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Feb 2011 14:51:12 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Suraj Sumangala <suraj@Atheros.com>
Cc: Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
Subject: Re: [RFC] Bluetooth: process received S-frames when socket is
 locked by user process
Message-ID: <20110202165112.GG2273@joana>
References: <1296479571-2971-1-git-send-email-suraj@atheros.com>
 <20110202162818.GD2273@joana>
 <4D49879F.8020000@Atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D49879F.8020000@Atheros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

* Suraj Sumangala <suraj@Atheros.com> [2011-02-02 22:04:39 +0530]:

> Hi Gustavo,
> 
> On 2/2/2011 9:58 PM, Gustavo F. Padovan wrote:
> > Hi Suraj,
> >
> > * Suraj Sumangala<suraj@atheros.com>  [2011-01-31 18:42:51 +0530]:
> >
> >> This patch lets L2CAP process received S-frames even when socket is
> >> continuously being locked by user process.
> >>
> >> This issue was seen when testing with l2test without using "-D" option.
> >>
> >> Since the user process does not expect any Rx packets,
> >> it hogs the socket with continuous call to "send()".
> >>
> >> When the TxWindow is full Tx stops untill the I-frames are acked by the receiver.
> >>
> >> But the Rx S-Frame acknowleding the Tx frames will stay in the backlog queue
> >> because the "sock_owned_by_user()" call in l2cap_data_channel()
> >> will always return true.
> >>
> >> The user process does not have an idea about this
> >> mechanism and keep pumping data and locking the socket and cause a deadlock.
> >
> > In which kernel are you seeing this error? I think it is already fixed.
> >
> > Regards,
> >
> 
> Can you direct me to the patch which fixed it?

This one: e454c844644683571617896ab2a4ce0109c1943e

The issue fixed by this patch is very similar to what you reported.

-- 
Gustavo F. Padovan
http://profusion.mobi
