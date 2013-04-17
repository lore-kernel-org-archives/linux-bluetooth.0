Return-Path: <cyrus@holtmann.org>
Date: Wed, 17 Apr 2013 12:44:57 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [RFC v2 01/11] core: Add btd_service to represent device services
Message-ID: <20130417094457.GA8155@x220>
References: <1365162348-25541-1-git-send-email-mikel.astiz.oss@gmail.com>
 <1365162348-25541-2-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365162348-25541-2-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

I did a quick read through of the patches and in general they seem quite
good. A couple of issues though:

> +struct btd_service *service_create(struct btd_device *device,
> +						struct btd_profile *profile)
> +{
> +	struct btd_service *service;
> +
> +	service = g_try_new0(struct btd_service, 1);
> +	if (!service) {
> +		error("service_create: failed to alloc memory");
> +		return NULL;
> +	}
> +
> +	service->ref = 1;
> +	service->device = btd_device_ref(device);

I don't think we want to have this pointer impacting reference count of
the device. The device "owns" the service and maintains a list of them
so when device.c calls service_create it shouldn't cause a new
reference for the device. We follow the same principle with adapters and
devices too: when an adapter creates a new device object the device
objects adapter pointer doesn't use ref().

One thing that you may need to pay attention to though is if for
whatever reason (buggy plugins) all service references aren't released
when a device gets removed, the device pointer should at least get set
to NULL (or maybe just have a big assert if this should only happen in
the case of a bug).

> +struct btd_service *service_create(struct btd_device *device,
> +						struct btd_profile *profile);
> +
> +struct btd_service *btd_service_ref(struct btd_service *service);
> +void btd_service_unref(struct btd_service *service);
> +
> +struct btd_device *btd_service_get_device(const struct btd_service *service);
> +struct btd_profile *btd_service_get_profile(const struct btd_service *service);
> +btd_service_state_t btd_service_get_state(const struct btd_service *service);
> +
> +void btd_service_set_user_data(struct btd_service *service, void *user_data);
> +void *btd_service_get_user_data(const struct btd_service *service);
> +int btd_service_get_error(const struct btd_service *service);
> +
> +void btd_service_probed(struct btd_service *service);
> +void btd_service_connecting(struct btd_service *service);
> +void btd_service_connecting_complete(struct btd_service *service, int err);
> +void btd_service_disconnecting(struct btd_service *service);
> +void btd_service_disconnecting_complete(struct btd_service *service, int err);
> +void btd_service_unavailable(struct btd_service *service);

Since you're adding all these APIs without any actual users in this
patch I'd appreciate a short description of the expected uses of them.
You could e.g. put it to the cover letter or even the commit message.

Johan
