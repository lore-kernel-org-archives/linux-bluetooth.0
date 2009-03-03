Return-Path: <cyrus@holtmann.org>
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] btusb: new device id needing BTUSB_WRONG_SCO_MTU quirk
References: <87hc2c3x5g.fsf@nemi.mork.no>
	<1236008354.742.1.camel@localhost.localdomain>
Date: Tue, 03 Mar 2009 16:23:56 +0100
In-Reply-To: <1236008354.742.1.camel@localhost.localdomain> (Marcel Holtmann's
	message of "Mon, 02 Mar 2009 16:39:14 +0100")
Message-ID: <87wsb67hpv.fsf@nemi.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org> writes:

> it does not make any sense. 

I see.  And my testing todays confirms that.  Sorry for the first
misplaced shot, and thanks for reviewing.

> Can you just try to run the latest
> bluetooth-testing.git tree kernel and see if that might have fixed this
> issue.

I tried it, and the problem was gone.

Only thing is:  I cannot reproduce the problem at all anymore.  Weird.
Yesterday it was easily reproducible using the procedure mentioned.  

Which means that there must be a mitigating factor I haven't found.
Could the presence of other BT devices make a difference?  The initial
testing was done at work where there are a large number of active BT
devices nearby, while today's testing has been done at home where there
aren't so many.  That's the only difference I can come up with.

Well, I'm satisfied as long as the problem is gone.  Will do more proper
testing and report back if it reappears.

Thanks


Bjørn
