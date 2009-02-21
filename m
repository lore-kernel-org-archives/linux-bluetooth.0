Return-Path: <cyrus@holtmann.org>
Date: Sat, 21 Feb 2009 23:59:45 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jelle de Jong <jelledejong@powercraft.nl>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: current git segfaults, gdb backtraces included, pl;ease help
Message-ID: <20090221215945.GA10295@jh-x301>
References: <499FDB3E.3040202@powercraft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <499FDB3E.3040202@powercraft.nl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sat, Feb 21, 2009, Jelle de Jong wrote:
> When running the bluetoothd daemon it segfaults when a devices tries
> to connect, please see the debug attachments, what is going wrong
> here? and how can I provide more useful debug info. I compiled with
> debug flags please see the attachment for how I compiled and made the
> Debian packages for testing.

The recent BtIO rework has changed quite alot of bluez code during this
week so the code base is inevitably less stable than it used to be. We
will try to iron out any outstanding issues during the next few days.

Could you describe in more detail the steps you've taken to make
bluetoothd segfault? I have not been able to reproduce this with my own
tests (mainly testing HFP, A2DP and Serial functionalities).

Your backtraces also didn't seem to contain much useful info. What I
usually do is after a git clone/pull I compile with
./bootstrap-configure && make
and then I can use the src/.libs/bluetoothd binary for debuging (e.g.
with valgrind or gdb). The --enable-maintainer-mode switch that
bootstrap-configure uses makes the produced bluetoothd binary load the
modules from the source tree instead of their usual location
(/usr/lib/bluetooth) which helps make sure you're only running code from
the latest git.

Johan
