Return-Path: <cyrus@holtmann.org>
Date: Sun, 29 May 2011 21:48:59 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Add support of secure pin code in mgmt code
Message-ID: <20110529184859.GB32088@dell.ger.corp.intel.com>
References: <1306401315-10948-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306401315-10948-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldek,

On Thu, May 26, 2011, Waldemar Rymarkiewicz wrote:
> -	err = btd_event_request_pin(&dev->bdaddr, dba);
> +	err = btd_event_request_pin(&dev->bdaddr, dba, 0);

Even though the mgmt protocol uses uint8_t from there upwards you should
use gboolean, i.e. use FALSE instead of 0 here.

>  static int pincode_request_new(struct agent_request *req, const char *device_path,
> -				dbus_bool_t numeric)
> +				uint8_t secure)

Since in the long run secure will map to a D-Bus message parameter, use
dbus_bool_t for it here (just like numeric).

>  
>  	if (agent->request)
>  		return -EBUSY;
>  
> +	secure = device_get_secure_pin(device);

The agent_request_pincode function should get the secure parameter
passed to it directly. It shouldn't need to poll device.c about it.

> diff --git a/src/device.c b/src/device.c
> index 4ffc124..f4fb5c7 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -133,6 +133,8 @@ struct btd_device {
>  	gboolean	paired;
>  	gboolean	blocked;
>  
> +	uint8_t		secure_pin;
> +
>  	gboolean	authorizing;
>  	gint		ref;
>  };

struct authentictation_req (device->authr) is the right place to store
this value since it's bound is to the lifetime of the authentication
request, whereas struct btd_device isn't. Also, as previously mentioned
the type should be gboolean and not uint8_t.

Johan
