Return-Path: <cyrus@holtmann.org>
Date: Fri, 10 Feb 2012 10:09:43 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv3 02/16] Bluetooth: Revert to mutexes from RCU list
Message-ID: <20120210080941.GA28197@aemeltch-MOBL1>
References: <1328797057-26331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1328797057-26331-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1328797634.28848.21.camel@aeonflux>
 <CAA37ikYriwfbS9SQKwqnPn+X6z6OoU1AGvqVnqa1vvsUWptmkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAA37ikYriwfbS9SQKwqnPn+X6z6OoU1AGvqVnqa1vvsUWptmkg@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

On Thu, Feb 09, 2012 at 03:54:44PM -0200, Ulisses Furquim wrote:
> Hi Andrei,
> 
> On Thu, Feb 9, 2012 at 12:27 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> > Hi Andrei,
> >
> >> Usage of RCU list looks not reasonalbe for a number of reasons:
> >> our code sleep and we have to use socket spinlocks, some parts
> >> of code are updaters thus we need to use mutexes anyway.
> >>
> >> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >> ---
> >>  net/bluetooth/l2cap_core.c |  108 ++++++++++++++++++++++----------------------
> >>  1 files changed, 54 insertions(+), 54 deletions(-)
> >
> > I am fine with this, but I wanna get an ack from Ulisses as well.
> 
> Please, refer to my previous review because it seems you haven't
> changed anything at all. For instance, l2cap_disconnect_rsp() is still

those changes are in other patch:
[RFCv3 09/16] Bluetooth: Use chan lock in L2CAP sig commands

I was thinking that this patch change RCU to mutex chan list locks
and the changes which change socket lock to chan lock are different.

> missing an unlock of chan_lock and I see no changes to l2cap_sock.c
> which are needed. Moreover, you need to use the unlocked versions of
> the chan lookup functions and check if we still need the locked ones.

I will check need for locking function but at least compiler did not warn
me about unused function.

Best regards 
Andrei Emeltchenko 
