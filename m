Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 Aug 2014 17:57:25 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/health: Fix reconnect scenario
Message-ID: <20140813145725.GA11644@t440s.P-661HNU-F1>
References: <1407777812-15652-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407777812-15652-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Mon, Aug 11, 2014, Lukasz Rymanowski wrote:
> When trying to reconnect to HDP device, BfA tries to connect MDL even
> MCL is not connected.
> 
> D/BlueZ   ( 2218): external/bluetooth/bluez/android/hal-health.c:connect_channel()
> I/bluetoothd( 2220): bluetoothd[2221]: external/bluetooth/bluez/android/health.c:bt_health_connect_channel()
> I/bluetoothd( 2220): bluetoothd[2221]: external/bluetooth/bluez/android/health.c:create_channel() mdep 1
> D/BlueZ   ( 2218): external/bluetooth/bluez/android/hal-bluetooth.c:handle_acl_state_changed() state 0
> I/bluetoothd( 2220): bluetoothd[2221]: external/bluetooth/bluez/android/mcap-lib.c:mcap_create_mdl()
> I/bluetoothd( 2220): bluetoothd[2221]: health: error creating mdl MCL is not connected
> 
> This patch makes sure that MCL is connected before trying to connect
> MDL.
> ---
>  android/health.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/health.c b/android/health.c
> index 2d80365..f4edc3e 100644
> --- a/android/health.c
> +++ b/android/health.c
> @@ -1949,7 +1949,7 @@ static void bt_health_connect_channel(const void *buf, uint16_t len)
>  		}
>  	}
>  
> -	if (!dev->mcl) {
> +	if (!dev->mcl || (dev->mcl && !dev->mcl_conn)) {

The patch looks good but the second check for dev->mcl is a bit
redundant as this part is only evaluated if the first part (!dev->mcl)
was false. So the more concise form would be:

	if (!dev->mcl || !dev->mcl_conn)

However, could you explain to me why these separate variables are needed
to begin with? Why isn't dev->mcl cleared in the mcl_disconnected()
function that sets dev->mcl_conn to false but doesn't do anything to the
dev->mcl pointer?

Johan
