Return-Path: <cyrus@holtmann.org>
Date: Thu, 7 Jun 2012 01:03:06 +0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Fix deadlock and crash when SMP pairing
 times out
Message-ID: <20120606170306.GA26644@x220.ccr.corp.intel.com>
References: <1338979451-15851-1-git-send-email-johan.hedberg@gmail.com>
 <1338979451-15851-2-git-send-email-johan.hedberg@gmail.com>
 <20120606164400.GA11387@samus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120606164400.GA11387@samus>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Wed, Jun 06, 2012, Vinicius Costa Gomes wrote:
> > The l2cap_conn_del function tries to cancel_sync the security timer, but
> > when it's called from the timeout function itself a deadlock occurs.
> > Subsequently the "hcon->l2cap_data = NULL" that's supposed to protect
> > multiple calls to l2cap_conn_del never gets cleared and when the
> > connection finally drops we double free's etc which will crash the
> > kernel.
> 
> I wonder if (inside l2cap_conn_del()) we move "hcon->l2cap_data = NULL"
> up in the function, probably next to the check for "!conn", would be a
> safer alternative.

That was one of the things I tried first as well (and it did remove the
crash) but it doesn't remove the deadlock. The l2cap_conn_del would
still deadlock in cancel_sync(sec_timer) when called from
security_timeout().

Moving the NULL assignment to the top would certainly help decrease the
chance of calling l2cap_conn_del twice but it wouldn't completely remove
this race condition as clearing the variable + testing its value isn't
a single atomic operation.

So I'd still consider this deadlock removal patch by itself as necessary
and valid but additionally the race of calling l2cap_conn_del twice
would need to be fixed with a separate patch, possibly involving some
new or existing lock.

Johan
