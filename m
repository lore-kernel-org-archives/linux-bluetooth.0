Return-Path: <cyrus@holtmann.org>
Date: Mon, 29 Oct 2012 13:21:19 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Patkos Csaba <patkoscsaba@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Crashing bluetoothd when keyboard enters sleep mode / stand-by
Message-ID: <20121029112119.GA11037@x220>
References: <op.wmwjsbelgqbfom@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <op.wmwjsbelgqbfom@localhost>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sun, Oct 28, 2012, Patkos Csaba wrote:
> When my keyboard enters stand-by and disconnects from the computer I
> see high cpu usage by bluetoothd. Sometimes, not always, if I don't
> wake up the keyboard, bluetoothd will crash

Could you please try to get a proper backtrace of what's happening.
I.e. run bluetoothd with valgrind or gdb, e.g.:

sudo killall bluetoothd
sudo valgrind /usr/sbin/bluetoothd -nd

If this doesn't give useful info because of missing debug symbols either
try to install them (no idea how to do that with your distro though) or
compile and run 4.101 from the source tree (no need to install the
custom compilation on your system).

The HCI-level log would also be helpful in addition to the bluetoothd
debug logs, so please run "hcidump -X" in a separate terminal while
reproducing the issue. Thanks.

Johan
