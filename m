Return-Path: <johan.hedberg@gmail.com>
Date: Mon, 15 Aug 2016 11:09:18 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH, RFC] Bluetooth: btusb, hci_intel: Fix
 wait_on_bit_timeout() return value checks
Message-ID: <20160815080918.GA23198@t440s.lan>
References: <fae0be30-bd77-e5ce-37c6-58591916d28c@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fae0be30-bd77-e5ce-37c6-58591916d28c@sandisk.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bart,

On Thu, Aug 11, 2016, Bart Van Assche wrote:
> wait_on_bit_timeout() returns one of the following three values:
> * 0 to indicate success.
> * -EINTR to indicate that a signal has been received;
> * -EAGAIN to indicate timeout;
> Make the wait_on_bit_timeout() callers check for these values.
> This patch has not yet been tested.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Gustavo Padovan <gustavo@padovan.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> ---
>  drivers/bluetooth/btusb.c     | 5 ++---
>  drivers/bluetooth/hci_intel.c | 6 +++---
>  2 files changed, 5 insertions(+), 6 deletions(-)

The patch has now been applied to bluetooth-next. Thanks.

Johan
