Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <F41BD0C0A0991E449426F6CEE2BF5779014724@008-AM1MPN1-014.mgdnok.nokia.com>
References: <F41BD0C0A0991E449426F6CEE2BF5779014724@008-AM1MPN1-014.mgdnok.nokia.com>
Date: Wed, 25 May 2011 14:50:43 +0300
Message-ID: <BANLkTi=rPoWHxdSi8=Q2GtYwRzQkxo1mJQ@mail.gmail.com>
Subject: Re: Question about ABORT when canceling OPP file transfer
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: ext-jablonski.radoslaw@nokia.com
Cc: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Wed, May 25, 2011 at 10:39 AM,  <ext-jablonski.radoslaw@nokia.com> wrote:
> Hi Johan,
>
> There is one PTS test for OPP which tests if we're disconnecting cleanly
> when cancelling outgoing file transfer (this test is not mandatory).
> Currently it fails, because we don't send ABORT before disconnect.

Just to confirm, this test is for client, right?

> I've noticed that code for handling it nicely already exist in
> gw_obex_xfer_do_abort(...) but is disabled by default (via
> USE_NICE_ABORT definition).
>
> Is it safe to change that and  use "nice abort" by default? Were there problems
> with handling this ABORT command by some devices in described scenario?

Well if you want to have this test to pass obviously you need to send
abort properly, in the other hand I think we should make this a proper
API on gwobex so the application using it can pass to
gw_obex_xfer_do_abort how it wants to abort.

Regards,

-- 
Luiz Augusto von Dentz
Computer Engineer
