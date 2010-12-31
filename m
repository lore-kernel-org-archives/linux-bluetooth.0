Return-Path: <cyrus@holtmann.org>
Date: Fri, 31 Dec 2010 10:31:52 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Change security level on demand when reading
 characteristic value
Message-ID: <20101231083152.GA8328@jh-x301>
References: <1293744130-21124-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1293744130-21124-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Thu, Dec 30, 2010, Claudio Takahasi wrote:
> If a characteristic requires a higher security level, change it on
> demand and re-send the GATT Charateristic Value Read. Request will not
> be sent until the SMP negotiation finishes. This change doesn't affect
> GATT over BR/EDR, since encryption is mandatory for BR/EDR.
> ---
>  attrib/client.c  |   11 +++++++++++
>  attrib/gattrib.c |    8 ++++++++
>  attrib/gattrib.h |    2 ++
>  3 files changed, 21 insertions(+), 0 deletions(-)
> 
> diff --git a/attrib/client.c b/attrib/client.c
> index 10bbf7d..3297a0c 100644
> --- a/attrib/client.c
> +++ b/attrib/client.c
> @@ -744,6 +744,17 @@ static void update_char_value(guint8 status, const guint8 *pdu,
>  
>  	if (status == 0)
>  		characteristic_set_value(chr, pdu + 1, len - 1);
> +	else if (status == ATT_ECODE_INSUFF_ENC) {
> +		GIOChannel *io = g_attrib_get_channel(gatt->attrib);
> +
> +		if (bt_io_set(io, BT_IO_L2CAP, NULL,
> +				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_HIGH,
> +				BT_IO_OPT_INVALID)) {
> +			gatt_read_char(gatt->attrib, chr->handle,
> +					update_char_value, current);
> +			return;
> +		}
> +	}

The main problem with this is that it seems to be blocking. We can't
have that in a single threaded process like bluetoothd.

What I think the kernel should do when increasing the security level
with setsockopt is to mark the socket in a special state where neither
reads nor writes will succeed. Once the authentication is complete the
kernel would indicate POLLOUT on the socket, i.e. more or less the same
behavior as with non-blocking connects. If the authentication fails the
kernel would disconnect the socket.

We should also implement the same behavior for BR/EDR L2CAP sockets.
It'll particularly be useful for the HID implementation which right now
uses a raw HCI socket to request authentication and encryption when it
notices that the connected device is a keyboard (and not a mouse). The
whole thing could be abstracted by BtIO using something like
bt_io_set_security which would take a BtIOConnect callback pointer to
notify completion.

Johan
