Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [RFC][PATCH BlueZ] Bluetooth: L2CAP: Add BT_LE_CONN_PARAM socket
 option
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170203213604.2697-1-eu@felipetonello.com>
Date: Fri, 10 Feb 2017 12:30:34 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <6400F4C7-3488-4B59-9434-D6CC48D963E3@holtmann.org>
References: <20170203213604.2697-1-eu@felipetonello.com>
To: "Felipe F. Tonello" <eu@felipetonello.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Felipe,

> There is a need for certain LE profiles (MIDI for example)to change the
> current connection's parameters. In order to do that, this patch
> introduces a new BT_LE_CONN_PARAM socket option for SOL_BLUETOOTH
> protocol which allow user-space l2cap sockets to update the current
> connection.
> 
> This option will also send a MGMT_EV_NEW_CONN_PARAM event with the
> store_hint set so the user-space application can store the connection
> parameters for persistence reasons.
> 
> Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
> ---
> include/net/bluetooth/bluetooth.h |  8 ++++
> net/bluetooth/l2cap_sock.c        | 98 +++++++++++++++++++++++++++++++++++++++
> 2 files changed, 106 insertions(+)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index 01487192f628..ce5b3abd3b27 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -122,6 +122,14 @@ struct bt_voice {
> #define BT_SNDMTU		12
> #define BT_RCVMTU		13
> 
> +#define BT_LE_CONN_PARAM	14
> +struct bt_le_conn_param {
> +	__u16 min_interval;
> +	__u16 max_interval;
> +	__u16 latency;
> +	__u16 supervision_timeout;
> +};
> +

I am not 100% convinced that we want this level of detail exposed to user space. I was more thinking of having two or three sets of connection parameters and then a simple enum via socket option to choose from.

We have the default value that we use for everything right now. And then we can have a high latency and low latency setting to change that. The supervision timeout is a different story since that would also apply to BR/EDR and we could allow for individual setting of that.

The reason we store the exact connection parameters via mgmt is so that next time around, the slave does not have to request new ones. We already use the correct ones from the get go. One thing we are missing is to actually pick them up from advertising report. Since they can also be reported that way.

Also with a socket option we have to be careful that multiple sockets might want to program different values. We do support connection oriented channels with LE. Otherwise this would have to artificially restricted to GATT CID for now. And even there is still the case between connect() and accept(). Also that accept() is use with the background connection. I mean on an outgoing connection, I want to be able to influence the settings before calling connect() so they are used directly in the LE_Create_Connection command. Especially if I already know what I am creating the connection for.

Regards

Marcel

