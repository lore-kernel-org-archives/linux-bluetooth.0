Return-Path: <cyrus@holtmann.org>
Message-ID: <535F752F.1050507@tieto.com>
Date: Tue, 29 Apr 2014 11:47:27 +0200
From: Tyszkowski Jakub <jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	linux-bluetooth@vger.kernel.org
CC: szymon.janc@tieto.com
Subject: Re: [PATCH 01/36] android/gatt: Add comment about event type being
 sent
References: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com> <1398734107-4793-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398734107-4793-2-git-send-email-lukasz.rymanowski@tieto.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 04/29/2014 03:14 AM, Lukasz Rymanowski wrote:
> From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
>
> ---
>   android/gatt.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/android/gatt.c b/android/gatt.c
> index 0e81e7d..ed4ee75 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -599,6 +599,11 @@ failed:
>   static void send_client_disconnection_notify(struct app_connection *connection,
>   								int32_t status)
>   {
> +	/* disconnect and connect events are binary the same so its safe to pass
> +	 * hal_ev_gatt_client_disconnect struct even for connect event.
> +	 * Note that server do this the right way, having single event for
> +	 * connection state notification.
> +	 */
>   	struct hal_ev_gatt_client_disconnect ev;
>
>   	ev.client_if = connection->app->id;
>

This function was already changed to send only disconnect event and 
another function sends connect event. Please ignore this patch.

------------------
Jakub Tyszkowski
