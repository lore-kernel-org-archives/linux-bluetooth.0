Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: Gustavo Padovan <padovan@profusion.mobi>
Subject: Re: [REGRESSION] resume takes 10s longer due to e1b6eb3 (Bluetooth: Increase HCI reset timeout ...)
Date: Fri, 23 Dec 2011 21:43:20 +0100
Cc: =?utf-8?q?Tom=C3=A1=C5=A1_Janou=C5=A1ek?= <tomi@nomi.cz>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Linux PM mailing list <linux-pm@vger.kernel.org>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
References: <20111118184017.GA5052@nomi.cz> <20111121211506.GA16081@nomi.cz> <20111223165429.GA5287@joana>
In-Reply-To: <20111223165429.GA5287@joana>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201112232143.20937.szymon@janc.net.pl>
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday 23 December 2011 17:54:29 Gustavo Padovan wrote:

Hi,

> > On Mon, Nov 21, 2011 at 05:25:06PM +0200, Johan Hedberg wrote:
> > > It might be worth to try out the two patches I just sent to
> > > linux-bluetooth for HCI command failure tracking. They make sure that
> > > failures are properly caught which should help avoid triggering the
> > > timeout in certain scenarios (and yours might be one of them).
> > 
> > No, these don't help. :-(
> 
> Is this still happening? If yes I'm going to revert this patch.

I kindly ask to not revert this patch yet as this will bring back issue on my 
CSR dongle.

If this regression still happening I can try investigate it next week (as long 
as Tomáš is willing to provide more detailed logs and do some tests if 
needed).


-- 
Szymon K. Janc
szymon@janc.net.pl // GG: 1383435
