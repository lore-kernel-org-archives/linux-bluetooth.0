Return-Path: <johan.hedberg@gmail.com>
Date: Sun, 11 Mar 2018 06:33:54 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_bcm: Use default baud rate if missing
 shutdown GPIO
Message-ID: <20180311133354.GA15813@x1c>
References: <20180307213903.47583-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180307213903.47583-1-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Mar 07, 2018, Marcel Holtmann wrote:
> In case the shutdown GPIO is not wired up, it is impossible to reset the
> Bluetooth controller to its original state. This include the initial
> default baud rate which leads to issues when reloading the module or
> when something unexpected happens. To avoid any kind of runtime
> deadlocks, stick with the initial default baud rate.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/hci_bcm.c | 5 +++++
>  1 file changed, 5 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
