Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 Jan 2013 10:32:07 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] input: Fix closing sockets when ioctl_connadd()
 fails
Message-ID: <20130103083207.GA11193@x220>
References: <1357178905-22533-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1357178905-22533-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Wed, Jan 02, 2013, Anderson Lizardo wrote:
> Instead of calling close() directly, properly shutdown the channel and
> set GIOChannel pointers to NULL.
> 
> Also remove dead code and do a small refactoring around the code.
> 
> Fixes this error detected when HIDP support is disabled on kernel and we
> attempt to connect to a BT keyboard:
> 
> bluetoothd[5168]: profiles/input/device.c:encrypt_notify()
> bluetoothd[5168]: ioctl_connadd(): Protocol not supported(93)
> bluetoothd[5168]: profiles/input/device.c:ctrl_watch_cb() Device
> CA:FE:CA:FE:CA:FE disconnected
> 
> (bluetoothd:5168): GLib-WARNING **: Invalid file descriptor.
> 
> bluetoothd[5168]: profiles/input/device.c:intr_watch_cb() Device
> CA:FE:CA:FE:CA:FE disconnected
> 
> (bluetoothd:5168): GLib-WARNING **: Invalid file descriptor.
> ---
> 
> Let me know if you want me to split the refactoring part in a separate patch.
> 
>  profiles/input/device.c |   62 ++++++++++++++++++++++-------------------------
>  1 file changed, 29 insertions(+), 33 deletions(-)

Looks good, but please split this into two patches.

Johan
