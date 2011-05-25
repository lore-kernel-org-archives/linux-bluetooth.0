Return-Path: <cyrus@holtmann.org>
From: <ext-jablonski.radoslaw@nokia.com>
To: <johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Subject: Question about ABORT when canceling OPP file transfer
Date: Wed, 25 May 2011 07:39:39 +0000
Message-ID: <F41BD0C0A0991E449426F6CEE2BF5779014724@008-AM1MPN1-014.mgdnok.nokia.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

There is one PTS test for OPP which tests if we're disconnecting cleanly 
when cancelling outgoing file transfer (this test is not mandatory). 
Currently it fails, because we don't send ABORT before disconnect. 

I've noticed that code for handling it nicely already exist in 
gw_obex_xfer_do_abort(...) but is disabled by default (via 
USE_NICE_ABORT definition).

Is it safe to change that and  use "nice abort" by default? Were there problems 
with handling this ABORT command by some devices in described scenario?

BR,
Radek