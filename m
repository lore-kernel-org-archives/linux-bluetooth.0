Return-Path: <cyrus@holtmann.org>
Message-ID: <53EB6393.8070107@linux.intel.com>
Date: Wed, 13 Aug 2014 16:09:39 +0300
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/health: Fix reconnect scenario
References: <1407777812-15652-1-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1407777812-15652-1-git-send-email-lukasz.rymanowski@tieto.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ping.

On 08/11/2014 08:23 PM, Lukasz Rymanowski wrote:
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
>   android/health.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/android/health.c b/android/health.c
> index 2d80365..f4edc3e 100644
> --- a/android/health.c
> +++ b/android/health.c
> @@ -1949,7 +1949,7 @@ static void bt_health_connect_channel(const void *buf, uint16_t len)
>   		}
>   	}
>   
> -	if (!dev->mcl) {
> +	if (!dev->mcl || (dev->mcl && !dev->mcl_conn)) {
>   		if (connect_mcl(channel) < 0) {
>   			error("health: error retrieving HDP SDP record");
>   			goto fail;

Ravi.
