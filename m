Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Apr 2013 14:29:02 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alex Deymo <deymo@chromium.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	keybuk@chromium.org
Subject: Re: [PATCH v3 3/8] core: Add support for retrying a bonding
Message-ID: <20130424112902.GB15231@x220.ger.corp.intel.com>
References: <1366740247-368-1-git-send-email-deymo@chromium.org>
 <1366740247-368-4-git-send-email-deymo@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366740247-368-4-git-send-email-deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Tue, Apr 23, 2013, Alex Deymo wrote:
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -4253,7 +4253,7 @@ static void adapter_remove_connection(struct btd_adapter *adapter,
>  	if (device_is_authenticating(device))
>  		device_cancel_authentication(device, TRUE);
>  
> -	if (device_is_temporary(device)) {
> +	if (device_is_temporary(device) && !device_is_retrying(device)) {
>  		const char *path = device_get_path(device);
>  
>  		DBG("Removing temporary device %s", path);
> diff --git a/src/device.c b/src/device.c
> index 5686443..291ae5f 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -86,6 +86,9 @@ struct bonding_req {
>  	struct btd_device *device;
>  	struct agent *agent;
>  	struct pincb_iter *cb_iter;
> +	uint8_t capability;
> +	uint8_t status;
> +	guint retry_timer;
>  };
>  
>  typedef enum {
> @@ -1400,7 +1403,8 @@ static void device_svc_resolved(struct btd_device *dev, int err)
>  
>  static struct bonding_req *bonding_request_new(DBusMessage *msg,
>  						struct btd_device *device,
> -						struct agent *agent)
> +						struct agent *agent,
> +						uint8_t io_cap)
>  {
>  	struct bonding_req *bonding;
>  	char addr[18];
> @@ -1414,6 +1418,8 @@ static struct bonding_req *bonding_request_new(DBusMessage *msg,
>  
>  	bonding->cb_iter = pincb_iter_new(device->adapter);
>  
> +	bonding->capability = io_cap;

Do you really need to store this? Since you've got bonding->agent you
could just use agent_get_io_capability()?

> +gboolean device_is_retrying(struct btd_device *device)
> +{
> +	struct bonding_req *bonding = device->bonding;
> +
> +	return bonding && bonding->retry_timer != 0;

We try to keep the convention of using > 0 instead of != 0 for testing
for valid GSource ID values.

Johan
