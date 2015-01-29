Return-Path: <cyrus@holtmann.org>
Date: Thu, 29 Jan 2015 07:55:19 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Bluetooth: btusb: Handle out of order firmware loading
 complete event
Message-ID: <20150129055519.GB6847@t440s.P-661HNU-F1>
References: <1422438243-15352-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422438243-15352-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jan 28, 2015, Marcel Holtmann wrote:
> When loading the Intel firmware it can happen that the firmware loading
> complete vendor event arrives before the command complete event for the
> last firmware fragment.
> 
> < HCI Command: Vendor (0x3f|0x0009) plen 7
>         01 02 fc 03 00 00 00
> > HCI Event: Vendor (0xff) plen 5
>         06 00 00 00 00
> > HCI Event: Command Complete (0x0e) plen 4
>       Vendor (0x3f|0x0009) ncmd 31
>         Status: Success (0x00)
> 
> This is mainly caused by the fact that the vendor command and its
> command complete event are transported over the bulk endpoints. The
> firmware loading complete event however is send over the interrupt
> endpoint. So with just bad timing one event arrives before the other.
> 
> Currently the code does not account for it. There are precautions for
> receiving firmware loading complete event quickly, but not for receiving
> it before the command complete.
> 
> Introduce an extra flag that tracks when the firmware sending has
> completed from the driver point of view and track the completion of
> the firmware loading procedure with a different flag. That way the
> wakeup can be handled properly.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btusb.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

This made firmware loading again stable for me so I went ahead and
applied the patch to bluetooth-next. Thanks.

Johan
