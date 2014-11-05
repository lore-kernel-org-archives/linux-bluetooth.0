Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] android/gatt: Add support for new API
Date: Wed, 05 Nov 2014 21:51:39 +0100
Message-ID: <2576310.nRxAd5vMes@leonov>
In-Reply-To: <1415181217-16510-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415181217-16510-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wednesday 05 of November 2014 11:53:35 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> In new Android API client_if parameter is removed.
> ---
>  android/gatt.c     | 14 ++++++++------
>  android/hal-gatt.c | 14 +++++++++++++-
>  2 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index b3dd6d3..5a531d9 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -1730,15 +1730,17 @@ static void handle_client_scan(const void *buf,
> uint16_t len) {
>  	const struct hal_cmd_gatt_client_scan *cmd = buf;
>  	uint8_t status;
> -	void *registered;
> 
>  	DBG("new state %d", cmd->start);
> 
> -	registered = find_app_by_id(cmd->client_if);
> -	if (!registered) {
> -		error("gatt: Client not registered");
> -		status = HAL_STATUS_FAILED;
> -		goto reply;
> +	if (cmd->client_if != 0) {
> +		void *registered = find_app_by_id(cmd->client_if);
> +
> +		if (!registered) {
> +			error("gatt: Client not registered");
> +			status = HAL_STATUS_FAILED;
> +			goto reply;
> +		}
>  	}
> 
>  	/* Turn off scan */
> diff --git a/android/hal-gatt.c b/android/hal-gatt.c
> index c563fe9..080852a 100644
> --- a/android/hal-gatt.c
> +++ b/android/hal-gatt.c
> @@ -595,7 +595,7 @@ static bt_status_t unregister_client(int client_if)
>  					sizeof(cmd), &cmd, NULL, NULL, NULL);
>  }
> 
> -static bt_status_t scan(int client_if, bool start)
> +static bt_status_t scan_real(int client_if, bool start)
>  {
>  	struct hal_cmd_gatt_client_scan cmd;
> 
> @@ -609,6 +609,18 @@ static bt_status_t scan(int client_if, bool start)
>  					sizeof(cmd), &cmd, NULL, NULL, NULL);
>  }
> 
> +#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
> +static bt_status_t scan(bool start)
> +{
> +	return scan_real(0, start);
> +}
> +#else
> +static bt_status_t scan(int client_if, bool start)
> +{
> +	return scan_real(client_if, start);
> +}
> +#endif
> +
>  static bt_status_t connect(int client_if, const bt_bdaddr_t *bd_addr,
>  								bool is_direct)
>  {

All patches applied, thanks.

-- 
BR
Szymon Janc
