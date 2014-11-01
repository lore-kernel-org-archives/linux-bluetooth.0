Return-Path: <cyrus@holtmann.org>
Date: Sat, 1 Nov 2014 10:00:38 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alfonso Acosta <fons@spotify.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] core: Add btd_adapter_recreate_bonding()
Message-ID: <20141101080038.GA11840@t440s.P-661HNU-F1>
References: <1413817285-23388-1-git-send-email-fons@spotify.com>
 <1413817285-23388-2-git-send-email-fons@spotify.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1413817285-23388-2-git-send-email-fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alfonso,

On Mon, Oct 20, 2014, Alfonso Acosta wrote:
> This patch adds btd_adapter_recreate_bonding() which rebonds a device,
> i.e. it performs an unbonding operation inmediately followed by a
> bonding operation.
> 
> Although there is no internal use for btd_adapter_recreate_bonding()
> yet, it is useful for plugins dealing with devices which require
> renegotiaing their keys. For instance, when dealing with devices
> without persistent storage which lose their keys on reset.
> 
> Certain caveats have been taken into account when rebonding with a LE
> device:
> 
>  * If the device to rebond is already connected, the rebonding is done
>    without disconnecting to avoid the extra latency of reestablishing
>    the connection.
> 
>  * If no connection exists, we connect before unbonding anyways to
>    avoid losing the device's autoconnection and connection parameters,
>    which are removed by the kernel when unpairing if no connection
>    exists.
> 
>  * Not closing the connection requires defering attribute discovery
>    until the rebonding is done. Otherwise, the security level could be
>    elavated with the old LTK, which may be invalid since we are
>    rebonding. When rebonding, attribute discovery is suspended and the
>    ATT socket is saved to allow resuming it once bonding is finished.
> ---
>  src/adapter.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  src/adapter.h |  7 ++++++-
>  src/device.c  | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  src/device.h  |  4 ++++
>  4 files changed, 119 insertions(+), 7 deletions(-)

First of all, sorry for the delay with reviewing this patch.

>  int btd_adapter_remove_bonding(struct btd_adapter *adapter,
> -				const bdaddr_t *bdaddr, uint8_t bdaddr_type)
> +				const bdaddr_t *bdaddr, uint8_t bdaddr_type,
> +				uint8_t disconnect)

I think I mentioned this earlier, but I don't really like exposing mgmt
protocol details in a public adapter.h API. In this case I'm referring
to using a uint8_t parameter instead of a bool or an enum (which is then
internally converted to the mgmt protocol).

Even if this is converted to a bool (which I think is the simplest
change) it makes for hard to understand calls of this function where
it's not immediately clear to the reader what the parameter does
(without looking at the implementation of the function). If you go with
that you should at least ensure that the calling code has a comment
explaining what the last parameter does.

> +int btd_adapter_recreate_bonding(struct btd_adapter *adapter,
> +					const bdaddr_t *bdaddr,
> +					uint8_t bdaddr_type,
> +					uint8_t io_cap)
> +{
> +	struct btd_device *device;
> +	int err;
> +
> +	device = btd_adapter_get_device(adapter, bdaddr, bdaddr_type);
> +
> +	if (!device || !device_is_bonded(device, bdaddr_type))
> +		return -EINVAL;
> +
> +	device_set_rebonding(device, bdaddr_type, true);
> +
> +	/* Make sure the device is connected before unbonding to avoid
> +	 * losing the device's autoconnection and connection
> +	 * parameters, which are removed by the kernel when unpairing
> +	 * if no connection exists. We would had anyways implicitly
> +	 * connected when bonding later on, so we might as well just
> +	 * do it explicitly now.
> +	 */
> +	if (bdaddr_type != BDADDR_BREDR && !btd_device_is_connected(device)) {
> +		err = device_connect_le(device);
                      ^^^^^^^^^^^^^^^^^^^^^^^^^^
> +		if (err < 0)
> +			goto failed;
> +	}
> +	/* Unbond without disconnecting to avoid the connection
> +	 * re-establishment latency
> +	 */
> +	err = btd_adapter_remove_bonding(adapter, bdaddr, bdaddr_type, 0);

device_connect_le() is an asynchronous function so I don't quite
understand how this is supposed to work. Don't you have to wait for the
connection to be established?

> +	if (dev->le_state.rebonding) {
> +		DBG("postponing due to rebonding");
> +		/* Keep the att socket, and defer attaching the attributes
> +		 * until rebonding is done.
> +		 */
> +		if (!dev->att_rebond_io)
> +			dev->att_rebond_io = g_io_channel_ref(io);
> +		return false;
> +	}

This all-or-nothing design may need to be rethought. There should be no
reason why services not requiring special security (such as GAP)
shouldn't be available immediately when the LE link becomes available.
Only services requiring MEDIUM or higher security level (e.g. HID)
should need to wait to get their notification once the new pairing is
complete.

Johan
