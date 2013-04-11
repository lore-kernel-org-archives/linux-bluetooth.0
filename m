Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH 5/6] core: Add device_get_class to the public interface.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1365628753-16774-6-git-send-email-deymo@chromium.org>
Date: Wed, 10 Apr 2013 22:12:29 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <362A54BE-466C-4B1E-A968-6DD7F758CBA5@holtmann.org>
References: <1365628753-16774-1-git-send-email-deymo@chromium.org> <1365628753-16774-6-git-send-email-deymo@chromium.org>
To: Alex Deymo <deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

> Exports the device class to plugins.
> ---
> src/device.c | 5 +++++
> src/device.h | 1 +
> 2 files changed, 6 insertions(+)
> 
> diff --git a/src/device.c b/src/device.c
> index 032fc68..4ce7b8c 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -2127,6 +2127,11 @@ void device_set_class(struct btd_device *device, uint32_t class)
> 						DEVICE_INTERFACE, "Class");
> }
> 
> +uint32_t btd_device_get_class(struct btd_device *device)
> +{
> +	return device->class;
> +}
> +

why not export functions for getting the major and minor class. That seems to better then making a plugin decode that by themselves. Especially since we know they will get it work.

Regards

Marcel

