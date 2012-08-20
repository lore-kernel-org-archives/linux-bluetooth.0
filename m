Return-Path: <cyrus@holtmann.org>
Message-id: <50321EA8.5000504@samsung.com>
Date: Mon, 20 Aug 2012 20:25:28 +0900
From: Chan-yeol Park <chanyeol.park@samsung.com>
MIME-version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Write discoverable mode on storage after HCI response
References: <1344430990-4080-1-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1344430990-4080-1-git-send-email-chanyeol.park@samsung.com>
Content-type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello all,

I'm writing in order to discuss the point when bluez writes Discoverable 
Mode value.

Currently BlueZ writes it on the storage right after it sends HCI command.
Except DiscoverableTimeout is 0 case. it works fine.
hciconfig, bluez Adapter.GetProperties 's value are the same with the 
discoverable mode
on the storage.

But in case of DiscoverableTimeout is not 0 the value on the storage 
should be updated
  after BlueZ gets HCI Discoverable Mode change response. However the 
change is not
  applied on the storage , so it's skipped.
* Fortunately hciconfig, Adapter.GetProperties 's value are updated fine.

I think if we move the logic that writing the value on the storage FROM 
the point before
  bluez sends HCI commands TO the point after we get HCI response , this 
problem
would be resolved naturally.

If you need more explanation, please ask me.

Regards
chanyeol

On 08/08/2012 10:03 PM, chanyeol.park@samsung.com wrote:
> From: Chan-yeol Park <chanyeol.park@samsung.com>
>
> Right after HCI mode command is sent, Bluez writes mode value
> on the storage. but in case of DiscoverableTimeout, storage value
> is not updated like adapter->mode value. So this logic is moved.
> ---
>   src/adapter.c |   11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index acb845e..1b8e3b0 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -302,7 +302,6 @@ static int set_mode(struct btd_adapter *adapter, uint8_t new_mode,
>   
>   done:
>   	modestr = mode2str(new_mode);
> -	write_device_mode(&adapter->bdaddr, modestr);
>   
>   	DBG("%s", modestr);
>   
> @@ -2244,6 +2243,12 @@ static void set_mode_complete(struct btd_adapter *adapter)
>   		adapter->mode_sessions = NULL;
>   	}
>   
> +	modestr = mode2str(adapter->mode);
> +
> +	DBG("%s", modestr);
> +
> +	write_device_mode(&adapter->bdaddr, modestr);
> +
>   	if (adapter->pending_mode == NULL)
>   		return;
>   
> @@ -2268,10 +2273,6 @@ static void set_mode_complete(struct btd_adapter *adapter)
>   		g_dbus_send_message(connection, reply);
>   	}
>   
> -	modestr = mode2str(adapter->mode);
> -
> -	DBG("%s", modestr);
> -
>   	/* restore if the mode doesn't matches the pending */
>   	if (err != 0) {
>   		write_device_mode(&adapter->bdaddr, modestr);

