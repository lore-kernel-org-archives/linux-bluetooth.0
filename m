Return-Path: <cyrus@holtmann.org>
Date: Sun, 3 Jul 2011 21:49:04 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] avrcp: mark signals as deprecated
Message-ID: <20110703184904.GA20422@dell.ger.corp.intel.com>
References: <1309646531-3681-1-git-send-email-padovan@profusion.mobi>
 <20110703114445.GD10186@dell.ger.corp.intel.com>
 <20110703183141.GB2706@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110703183141.GB2706@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Sun, Jul 03, 2011, Gustavo F. Padovan wrote:
> > On Sat, Jul 02, 2011, Gustavo F. Padovan wrote:
> > > From: "Gustavo F. Padovan" <padovan@profusion.mobi>
> > > 
> > > Connected and Disconnected are deprecated signals
> > > ---
> > >  doc/control-api.txt |    4 ++--
> > >  1 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > Why do you think these should be deprecated? Right now there are no
> > other signals available in the org.bluez.Control interface that'd give
> > the same information.
> 
> I'm just following the code:
> 
> static GDBusSignalTable control_signals[] = {
>         { "Connected",                  "",     G_DBUS_SIGNAL_FLAG_DEPRECATED},
>         { "Disconnected",               "",     G_DBUS_SIGNAL_FLAG_DEPRECATED},

That's probably a mistake from copy-pasting the same stuff to each audio
profile. We could of course consider adding a State property to match
the other profiles, and then these signals could really be marked as
deprecated.

Johan
