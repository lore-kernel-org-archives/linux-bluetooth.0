Return-Path: <cyrus@holtmann.org>
Reply-To: <wyrles@ytram.com>
From: "Tom Allebrandi" <wyrles@ytram.com>
To: "'Luiz Augusto von Dentz'" <luiz.dentz@gmail.com>,
	<ext-jablonski.radoslaw@nokia.com>
Cc: <johan.hedberg@gmail.com>, <linux-bluetooth@vger.kernel.org>
References: <F41BD0C0A0991E449426F6CEE2BF5779014724@008-AM1MPN1-014.mgdnok.nokia.com> <BANLkTi=rPoWHxdSi8=Q2GtYwRzQkxo1mJQ@mail.gmail.com>
In-Reply-To: <BANLkTi=rPoWHxdSi8=Q2GtYwRzQkxo1mJQ@mail.gmail.com>
Subject: RE: Question about ABORT when canceling OPP file transfer
Date: Wed, 25 May 2011 09:43:43 -0700
Message-ID: <013e01cc1afa$f17d7920$d4786b60$@ytram.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All -

> On Wed, May 25, 2011 at 10:39 AM,  <ext-jablonski.radoslaw@nokia.com>
> wrote:
> > Hi Johan,
> >
> > There is one PTS test for OPP which tests if we're disconnecting
> > cleanly when cancelling outgoing file transfer (this test is not
mandatory).
> > Currently it fails, because we don't send ABORT before disconnect.
> 
> Just to confirm, this test is for client, right?
> 
> > I've noticed that code for handling it nicely already exist in
> > gw_obex_xfer_do_abort(...) but is disabled by default (via
> > USE_NICE_ABORT definition).
> >
> > Is it safe to change that and  use "nice abort" by default? Were there
> > problems with handling this ABORT command by some devices in described
> scenario?
> 
> Well if you want to have this test to pass obviously you need to send
abort
> properly, in the other hand I think we should make this a proper API on
> gwobex so the application using it can pass to gw_obex_xfer_do_abort how
> it wants to abort.
> 

I think he is referring to TC_CLIENT_OPH_BV_27_I -- "To verify that a client
can ABORT an OBEX push operation."

This is an optional (category X) test case that was added to exercise the
OBEX ABORT command. It is not required to pass this test case for
qualification.

It's a fairly new test case, it was just added in 4.1 or 4.2 of PTS.

Cheers!

--- tom
tom allebrandi
(Bluetooth SIG PTS Development Team: OPP, FTP, BIP, DUN, HCRP)
wyrles@ytram.com


