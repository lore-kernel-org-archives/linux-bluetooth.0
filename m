Return-Path: <cyrus@holtmann.org>
Date: Mon, 8 Aug 2011 23:51:39 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: VISHWANATH KM <a21174@motorola.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC] New mgmt API for Features Exchange (was: Re: Security
 level for Primary Services discovery during pairing)
Message-ID: <20110808205139.GA6147@dell.Elisa>
References: <CAJdJm_OmwPrc_3nT3zOSa0PLQBfr8hzyXuWHj=JJXYdWagoG7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_OmwPrc_3nT3zOSa0PLQBfr8hzyXuWHj=JJXYdWagoG7w@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Aug 08, 2011, Anderson Lizardo wrote:
> On Mon, Aug 8, 2011 at 10:59 AM, VISHWANATH KM <a21174@motorola.com> wrote:
> >> I think you have two options:
> >>
> >> 1) Always use CreateDevice(). Then if you want to issue SMP pairing,
> >> you can change the BT_IO_SECLEVEL when connection with bt_io_connect()
> >> (I haven't tested this lately, but I remember it used to work).
> >>
> >> 2) Extend the kernel Management API to allow Features Exchange. See
> >> doc/mgmt-api.txt for the existing commands, to have an idea on how it
> >> works (I recommend first sending an API proposal here to the list).
> >
> > Option 2 sounds better, where we use CreatePairedDevice and after the LE ACL
> > is established we can do LE Read Remote features, (similar to what we do for
> > BR i.e we do HCI Read Remote features in conn complete ) and if Encryption
> > feature bit is set then we trigger SMP else we don't, pls let me know if any
> > comments, if this sounds ok then i will mail the changes to this maillist
> > for further review
> 
> Let's hear others opinions. Johan, Marcel, Gustavo?

To me it seems pretty clear from the core spec that this is purely about
Link Layer (i.e. controller side) behavior which doesn't tell you
anything about the host side capabilities. I also don't see any
corresponding write command which further confirms that this is not
something dependent on host-side features. I.e. I don't think you can
use this to conclude anything about SMP support on the remote side.

Johan
