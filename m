Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH 2/6] plugins: Extend the pin code callback with the call number
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1365628753-16774-3-git-send-email-deymo@chromium.org>
Date: Wed, 10 Apr 2013 22:06:59 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <D1661A8A-7A16-4B53-98B3-03D256B76766@holtmann.org>
References: <1365628753-16774-1-git-send-email-deymo@chromium.org> <1365628753-16774-3-git-send-email-deymo@chromium.org>
To: Alex Deymo <deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

> The plugin's pin code callback doesn't know about the pairing process. It
> just provides a pin code based on the information provided to this function.
> Although limited state could be added through other new callbacks, this fix
> achieves this by providing more information to the callback itself. The
> new argument "count" states the pin callback attempt of the particular
> plugin for the current pairing of the device. This allows a plugin to try
> different pincodes for the same device in the same pairing process.
> 
> To signal that the plugin doesn't provide any pin code for the provided device
> the current implementation returns 0 (an empty pin code). Analogously, with
> this fix, a plugin should return 0 when it doesn't have any other pin code to
> provide for the given device.
> ---
> plugins/wiimote.c | 7 ++++++-
> src/adapter.c     | 2 +-
> src/adapter.h     | 3 ++-
> 3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/plugins/wiimote.c b/plugins/wiimote.c
> index 90d6d7b..c8d024f 100644
> --- a/plugins/wiimote.c
> +++ b/plugins/wiimote.c
> @@ -70,12 +70,17 @@ static const char *wii_names[] = {
> };
> 
> static ssize_t wii_pincb(struct btd_adapter *adapter, struct btd_device *device,
> -						char *pinbuf, gboolean *display)
> +				char *pinbuf, gboolean *display, int count)
> {
> 	uint16_t vendor, product;
> 	char addr[18], name[25];
> 	unsigned int i;
> 
> +	/* Only try the pin code once per device. If it's not correct then it's
> +	 * an unknown device. */
> +	if (count > 0)
> +		return 0;
> +
> 	ba2str(device_get_address(device), addr);
> 
> 	vendor = btd_device_get_vendor(device);
> diff --git a/src/adapter.c b/src/adapter.c
> index 957f829..f2193cf 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -4802,7 +4802,7 @@ static ssize_t pincb_iter_next(struct pincb_iter *iter,
> 
> 	while (iter->it != NULL) {
> 		cb = iter->it->data;
> -		ret = cb(adapter, device, pin_buf, display);
> +		ret = cb(adapter, device, pin_buf, display, iter->count);
> 		iter->count++;
> 		if (ret > 0)
> 			return ret;
> diff --git a/src/adapter.h b/src/adapter.h
> index d158334..692963f 100644
> --- a/src/adapter.h
> +++ b/src/adapter.h
> @@ -132,7 +132,8 @@ int btd_cancel_authorization(guint id);
> int btd_adapter_restore_powered(struct btd_adapter *adapter);
> 
> typedef ssize_t (*btd_adapter_pin_cb_t) (struct btd_adapter *adapter,
> -			struct btd_device *dev, char *out, gboolean *display);
> +			struct btd_device *dev, char *out, gboolean *display,
> +								int count);

so I do not think that "count" is a really good name here. Wouldn't it be better to call it "attempt" or something like that?

And I prefer to make these things unsigned if we are not planning to have -1 handed to it.

Regards

Marcel

