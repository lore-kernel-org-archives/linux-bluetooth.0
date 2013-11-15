Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Nov 2013 13:46:04 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, szymon.janc@tieto.com
Subject: Re: [PATCH v4 2/4] android: Cache device name on device list.
Message-ID: <20131115114604.GB9847@x220.p-661hnu-f1>
References: <1384453825-19241-1-git-send-email-lukasz.rymanowski@tieto.com>
 <1384453825-19241-3-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384453825-19241-3-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Thu, Nov 14, 2013, Lukasz Rymanowski wrote:
> +static void cache_device_name(const bdaddr_t *addr, char *name)

Maybe const char *name here?

> +	struct device *dev = NULL;
> +	GSList *l;
> +
> +	l = g_slist_find_custom(devices, addr, bdaddr_cmp);
> +	if (l)
> +		dev = l->data;
> +
> +	if (!dev) {
> +		dev = g_new0(struct device, 1);
> +		bacpy(&dev->bdaddr, addr);
> +		dev->bond_state = HAL_BOND_STATE_NONE;
> +		dev->name = g_malloc0(strlen(name) + 1);
> +		memcpy(dev->name, name, strlen(name));

Why this complicated malloc + memcpy when further below you do a much
simpler g_strdup?

In fact I'd just skip the name part here completely, remove the return
statement and let the code continue to the single place where you free
and set the name. Both g_strcmp0 and g_free should do the right thing if
the name is NULL.

> +	if (!g_strcmp0(dev->name, name))
> +			return;

Minor coding style issue here with indentation.

> +static char* get_device_name(const bdaddr_t *addr)
> +{

Coding style above with spacing, and this should be static const char *

> +	GSList *l;
> +	struct device *dev;
> +
> +	l = g_slist_find_custom(devices, addr, bdaddr_cmp);
> +	if (l) {
> +		dev = l->data;

You can move the variable declaration here to the more reduced scope.

> +static void send_remote_device_name_prop(const bdaddr_t *bdaddr)
>  {
>  	struct hal_ev_remote_device_props *ev;
> -	uint8_t buf[BASELEN_REMOTE_DEV_PROP + strlen(name)];
> +	uint8_t *buf;
> +	char dst[18];
> +	char *name;

const char *name;

> +
> +	ba2str(bdaddr, dst);
> +
> +	/* Use cached name or bdaddr string */
> +	name = get_device_name(bdaddr);
> +	if (!name)
> +		name = dst;
> +
> +	buf = g_malloc0(BASELEN_REMOTE_DEV_PROP + strlen(name));
>  
>  	ev =  (void *) buf;

The value of having a separate buf variable is completely lost here now
that you start doing dynamic allocation. What I'd do is remove buf, add
a new size_t ev_len, evaluate ev_len and then do ev = g_malloc0(ev_len);

>  	memset(buf, 0, sizeof(buf));

This one is both unnecessary and broken. Firstly you already zeroed out
the buffer with g_malloc and secondly sizeof(buf) doesn't do what you'd
want it to do (now that this is pointer instead of an array).

Johan
