Return-Path: <cyrus@holtmann.org>
Date: Wed, 22 Feb 2012 10:00:21 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Bluetooth: Add set_err to state_change callback
Message-ID: <20120222080014.GB24328@aemeltch-MOBL1>
References: <1329834858-22816-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CAA37ikZvUdCgPqjDS=DjCzOn0Bz6MGpiiMmg_YuFBNLoQLvCeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAA37ikZvUdCgPqjDS=DjCzOn0Bz6MGpiiMmg_YuFBNLoQLvCeA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

On Tue, Feb 21, 2012 at 03:42:33PM -0200, Ulisses Furquim wrote:
> Hi Andrei,
> 
> On Tue, Feb 21, 2012 at 12:34 PM, Andrei Emeltchenko
> <Andrei.Emeltchenko.news@gmail.com> wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >
> > There are several places in the code where l2cap_state_change and
> > l2cap_chan_set_err used together. With combining them we remove
> > socket lock in l2cap_send_disconn_req and simplify code in couple
> > of other places with a price of adding extra parameter err to
> > state_change.
> >
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > ---
> >  include/net/bluetooth/l2cap.h |    3 +-
> >  net/bluetooth/l2cap_core.c    |   58 ++++++++++++++++++----------------------
> >  net/bluetooth/l2cap_sock.c    |    9 +++++-
> >  3 files changed, 36 insertions(+), 34 deletions(-)
> 
> While I see the benefit of removing function calls and also some code
> I'm not sure about this change now. We need to think of moving sock
> handling to l2cap_sock.c and for that we may have to work more on
> l2cap_ops indeed. However, we need to change ERTM state machine
> handling first, I'd say.

Yes, the main idea is to remove those socket operations to l2cap_ops so
that other socket-less protocols would override it.

Best regards 
Andrei Emeltchenko 

