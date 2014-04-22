Return-Path: <cyrus@holtmann.org>
Message-ID: <5356313A.5040704@tieto.com>
Date: Tue, 22 Apr 2014 11:07:06 +0200
From: Tyszkowski Jakub <jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] android/gatt: Refactor client connection handling
References: <1397830148-6301-1-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1397830148-6301-1-git-send-email-jakub.tyszkowski@tieto.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Two issues which are now fixed:

On 04/18/2014 04:09 PM, Jakub Tyszkowski wrote:
> @@ -861,45 +861,37 @@ static gboolean disconnected_cb(GIOChannel *io, GIOCondition cond,
>   	int sock, err = 0;
>   	socklen_t len;
>
> -	queue_remove(conn_list, dev);
> -
>   	sock = g_io_channel_unix_get_fd(io);
>   	len = sizeof(err);
>   	if (!getsockopt(sock, SOL_SOCKET, SO_ERROR, &err, &len))
>   		DBG("%s (%d)", strerror(err), err);
>
> +	device_disconnect_clients(dev);
>   	connection_cleanup(dev);
Connection cleanup unrefs attrib, triggering notification cleanup, which 
still needs client's connection map to remove itself from notification 
queue, thus the proper order is:
    	connection_cleanup(dev);
   +	device_disconnect_clients(dev);

> @@ -1099,96 +1061,204 @@ static struct gatt_device *create_device(bdaddr_t *addr)
>
>   	bacpy(&dev->bdaddr, addr);
>
> -	dev->clients = queue_new();
>   	dev->services = queue_new();
> -
> -	if (!dev->clients || !dev->services) {
> +	if (!dev->services) {
>   		error("gatt: Failed to allocate memory for client");
> +
>   		destroy_device(dev);
>   		return NULL;
>   	}
>
> +	if (!queue_push_head(gatt_devices, dev)) {
> +		error("gatt: Cannot push device to queue");
> +
> +		return NULL;
> +	}
> +
>   	return dev;
>   }
>
> -static void handle_client_connect(const void *buf, uint16_t len)
> +static struct connection_record *create_conn_record(struct gatt_device *device,
> +						struct gatt_client *client)
>   {
> -	const struct hal_cmd_gatt_client_connect *cmd = buf;
> -	struct gatt_device *dev = NULL;
> -	void *l;
> -	bdaddr_t addr;
> +	struct connection_record *new_conn;
> +	struct connection_record *last;
> +
> +	/* Check if already connected */
> +	new_conn = new0(struct connection_record, 1);
> +	if (!new_conn)
> +		return NULL;
> +
> +	new_conn->client = client;
> +	new_conn->device = device;
> +
> +	/* Make connection id unique to connection record
> +	 * (client, device) pair.
> +	 */
> +	last = queue_peek_head(client_connections);
> +	if (last)
> +		new_conn->id = last->id + 1;
> +	else
> +		new_conn->id = 1;
> +
> +	if (!queue_push_head(client_connections, new_conn)) {
> +		error("gatt: Cannot push client on the client queue!?");
> +
> +		free(new_conn);
> +		return NULL;
> +	}
> +
> +	new_conn->device->client_count++;
> +
> +	return new_conn;
> +}
> +
> +static void trigger_disconnection(struct connection_record *conn)
> +{
> +	if (conn->device->state == DEVICE_STATE_DISCONNECTED)
> +		return;
> +
> +	if (queue_remove(client_connections, conn)) {
> +		send_client_disconnect_notify(conn, GATT_SUCCESS);
> +		conn->device->client_count--;
> +	}
> +
> +	if (conn->device->client_count <= 0) {
> +		connection_cleanup(conn->device);
> +		device_set_state(conn->device, DEVICE_STATE_DISCONNECTED);
> +	}
> +
> +	free(conn);
> +}
> +
> +static void client_disconnect_devices(struct gatt_client *client)
> +{
> +	struct connection_record *conn;
> +
> +	/* find every connection for client record and trigger disconnect */
> +	while ((conn = queue_find(client_connections,
It should obviously be:
while ((conn = queue_remove_if(client_connections,
