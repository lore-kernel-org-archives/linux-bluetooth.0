Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 May 2011 13:17:56 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: ext-jablonski.radoslaw@nokia.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Question about ABORT when canceling OPP file transfer
Message-ID: <20110525201756.GA18489@dell.amr.corp.intel.com>
References: <F41BD0C0A0991E449426F6CEE2BF5779014724@008-AM1MPN1-014.mgdnok.nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F41BD0C0A0991E449426F6CEE2BF5779014724@008-AM1MPN1-014.mgdnok.nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Wed, May 25, 2011, ext-jablonski.radoslaw@nokia.com wrote:
> There is one PTS test for OPP which tests if we're disconnecting
> cleanly when cancelling outgoing file transfer (this test is not
> mandatory).  Currently it fails, because we don't send ABORT before
> disconnect. 
> 
> I've noticed that code for handling it nicely already exist in
> gw_obex_xfer_do_abort(...) but is disabled by default (via
> USE_NICE_ABORT definition).
> 
> Is it safe to change that and  use "nice abort" by default? Were there
> problems with handling this ABORT command by some devices in described
> scenario?

I think this is just a packaging bug. There's no reason to disable the
"nice abort" feature. Actually, I think it'd be fine not to have this
configurable for gwobex but always enable it (it's a legacy from really
old OpenOBEX versions that didn't yet support sending the Abort
command).

Johan
