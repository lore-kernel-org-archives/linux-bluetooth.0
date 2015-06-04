Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH v1] core: Fix connection to already paired device.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1433353221-12338-1-git-send-email-jpawlowski@google.com>
Date: Thu, 4 Jun 2015 13:33:17 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <34869CD2-5D62-426D-91CF-9EB4B43FC14B@holtmann.org>
References: <1433353221-12338-1-git-send-email-jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> Currently, when BlueZ tries to connect to already paired device that
> just rotated its RPA MAC address, it would use old address and fail
> to connect. In order to fix that, "General Connection Establisment
> Procedure" must be used. It is already implemented in kernel.
> 
> This patch changes connection procedure behaviour for paired devices.
> Instead of directly calling "connect" with last known RPA, it'll add
> device to kernel whitelist and start scan. If advertisement is received,
> it'll be compared against whitelist and then trigger connection if it
> matches.
> 
> le_connect_timeout field was added to btd_device. If it's set, device
> was marked for autoconnect because someone tried to connect to it. When
> the connection is succesully estabilished, or after timeout this field
> is cleared, and device is removed from autoconnect whitelist. It's value
> is handle to timeout timer. If device is not found for 10 seconds, we
> cancel connection procedure.

I have to admit, this is a neat trick in fixing the issue without having to update the kernel. However the Add Device API is not meant for single shot connection attempts. You should really use L2CAP socket connect() call for that. And we really need to get that one fixed to handle devices for which we have their IRK, but the RPA might be expired.

Keep in mind that in theory the kernel can have the IRK for a device, but is actually not paired with that device. That is a valid mode of operation. If you now base everything around the fact the bluetoothd considers a device paired, this really only fixes part of the problem.

> ---
> src/device.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/src/device.c b/src/device.c
> index ce96ab5..3fe52e4 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -78,6 +78,7 @@
> 
> #define IO_CAPABILITY_NOINPUTNOOUTPUT	0x03
> 
> +#define LE_CONNECT_TIMEOUT 10
> #define DISCONNECT_TIMER	2
> #define DISCOVERY_TIMER		1
> 
> @@ -256,6 +257,8 @@ struct btd_device {
> 	gboolean	disable_auto_connect;
> 	gboolean	general_connect;
> 
> +	guint		le_connect_timeout;
> +
> 	bool		legacy;
> 	int8_t		rssi;
> 	int8_t		tx_power;
> @@ -2392,6 +2395,19 @@ void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type)
> {
> 	struct bearer_state *state = get_state(dev, bdaddr_type);
> 
> +	if (dev->le_connect_timeout) {
> +		g_source_remove(dev->le_connect_timeout);
> +		dev->le_connect_timeout = 0;
> +		device_set_auto_connect(dev, false);
> +
> +		if (dev->connect) {
> +			g_dbus_send_message(dbus_conn,
> +				dbus_message_new_method_return(dev->connect));
> +			dbus_message_unref(dev->connect);
> +			dev->connect = NULL;
> +		}
> +	}
> +
> 	device_update_last_seen(dev, bdaddr_type);
> 
> 	if (state->connected) {
> @@ -4459,6 +4475,37 @@ static void att_error_cb(const GError *gerr, gpointer user_data)
> 	}
> }
> 
> +static gboolean le_connect_timeout(gpointer user_data)
> +{
> +	struct btd_device *dev = user_data;
> +	char addr[18];
> +
> +	ba2str(&dev->bdaddr, addr);
> +	DBG("Connection attempt to: %s was aborted after timeout", addr);
> +
> +	if (!dev->le_connect_timeout)
> +		return FALSE;
> +
> +	dev->le_connect_timeout = 0;
> +	device_set_auto_connect(dev, false);
> +
> +	if (!dev->connect)
> +		return FALSE;
> +
> +	if (dbus_message_is_method_call(dev->connect, DEVICE_INTERFACE,
> +								"Connect")) {
> +		DBG("returning response to %s",
> +					dbus_message_get_sender(dev->connect));
> +
> +		g_dbus_send_message(dbus_conn,
> +				btd_error_failed(dev->connect, strerror(20)));
> +		dbus_message_unref(dev->connect);
> +		dev->connect = NULL;
> +	}
> +
> +	return FALSE;
> +}
> +
> int device_connect_le(struct btd_device *dev)
> {
> 	struct btd_adapter *adapter = dev->adapter;
> @@ -4469,13 +4516,22 @@ int device_connect_le(struct btd_device *dev)
> 	char addr[18];
> 
> 	/* There is one connection attempt going on */
> -	if (dev->att_io)
> +	if ((dev->le_state.paired && dev->auto_connect) || dev->att_io)
> 		return -EALREADY;
> 
> 	ba2str(&dev->bdaddr, addr);
> 
> 	DBG("Connection attempt to: %s", addr);
> 
> +	if (dev->le_state.paired) {
> +		device_set_auto_connect(dev, true);

Using this function to toggle auto-connect on/off on a frequent basis (meaning each connection attempt) worries me a bit. Fundamentally the function does not provide you any feedback on if the device is connected or if something else is in progress or even if the actual Add Device management command succeeded or not.

I think that in case it happens that you cause this to be called for a device that in the meantime connected, then you trigger the timeout and wrongly thing that you did not connect while in reality you already were connected. So at minimum that case needs to be now taken out of device_set_auto_connect function since it has a side effect now.

And in general this function is for profiles to just set the auto-connect flag and move on. Success or failure was not their concern. However if you use it for active connection establishment, then this is your concern. Maybe you need some extra refactoring to make this available for a) profiles just setting the flag and b) the core doing one-shot connection attempts.

Regards

Marcel

