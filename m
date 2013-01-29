Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Jan 2013 16:01:24 -0600
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] core: Fix g_source_remove() with zero ID while
 removing device
Message-ID: <20130129220124.GB11112@x220>
References: <1359485546-28790-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1359485546-28790-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Tue, Jan 29, 2013, Anderson Lizardo wrote:
> store_device_info_cb() is also used as callback for g_idle_add() and
> therefore sets device->store_id to zero. During device removal it may be
> called manually, which must be done only after the existing
> device->store_id is removed from mainloop.
> 
> Fix this GLib error (and a bunch of invalid read/writes when
> store_device_info_cb() was called after device removal due to this bug):
> 
> bluetoothd[1192]: src/device.c:device_remove() Removing device
> /org/bluez/hci0/dev_12_34_12_34_12_34
> 
> (bluetoothd:1192): GLib-CRITICAL **: g_source_remove: assertion `tag >
> 0' failed
> bluetoothd[1192]: src/device.c:btd_device_unref() Freeing device
> /org/bluez/hci0/dev_12_34_12_34_12_34
> bluetoothd[1192]: src/device.c:device_free() 0x463a2a0
> ---
>  src/device.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied. Thanks.

Johan
