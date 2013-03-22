Return-Path: <cyrus@holtmann.org>
Date: Fri, 22 Mar 2013 12:53:36 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [RFC v0 01/11] core: Add btd_service to represent device services
Message-ID: <20130322105336.GA10769@x220.ger.corp.intel.com>
References: <1363678855-12765-1-git-send-email-mikel.astiz.oss@gmail.com>
 <1363678855-12765-2-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1363678855-12765-2-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Mar 19, 2013, Mikel Astiz wrote:
> +static char *str_state[] = {
> +	"SERVICE_STATE_UNAVAILABLE",
> +	"SERVICE_STATE_DISCONNECTED",
> +	"SERVICE_STATE_CONNECTING",
> +	"SERVICE_STATE_CONNECTED",
> +	"SERVICE_STATE_DISCONNECTING",
> +};

I'd rather have a separate state2str function with a switch statement
than this array that relies on matching the order of states in the state
enum. Also, you seem to have forgotten the const specifier that should
be used for strings like this (I'm pointing it out since it also applies
to the return type of the state2str function).

> +struct btd_device *service_get_device(struct btd_service *service)
> +{
> +	return service->device;
> +}
> +
> +struct btd_profile *service_get_profile(struct btd_service *service)
> +{
> +	return service->profile;
> +}
> +
> +void service_set_user_data(struct btd_service *service, void *user_data)
> +{
> +	assert(service->state == SERVICE_STATE_UNAVAILABLE);
> +	service->user_data = user_data;
> +}
> +
> +void *service_get_user_data(struct btd_service *service)
> +{
> +	return service->user_data;
> +}
> +
> +int service_get_error(struct btd_service *service)
> +{
> +	return service->err;
> +}
> +
> +service_state_t service_get_state(struct btd_service *service)
> +{
> +	return service->state;
> +}

Why are these functions not prefixed with btd_?

> +void service_probed(struct btd_service *service)
> +{
> +	assert(service->state == SERVICE_STATE_UNAVAILABLE);
> +	service_set_state(service, SERVICE_STATE_DISCONNECTED);
> +}
> +
> +void service_connecting(struct btd_service *service)
> +{
> +	assert(service->state == SERVICE_STATE_DISCONNECTED);
> +	service->err = 0;
> +	service_set_state(service, SERVICE_STATE_CONNECTING);
> +}
> +
> +void service_connecting_complete(struct btd_service *service, int err)
> +{
> +	if (service->state != SERVICE_STATE_DISCONNECTED &&
> +				service->state != SERVICE_STATE_CONNECTING)
> +		return;
> +
> +	service->err = err;
> +
> +	if (err == 0)
> +		service_set_state(service, SERVICE_STATE_CONNECTED);
> +	else
> +		service_set_state(service, SERVICE_STATE_DISCONNECTED);
> +}
> +
> +void service_disconnecting(struct btd_service *service)
> +{
> +	assert(service->state == SERVICE_STATE_CONNECTING ||
> +				service->state == SERVICE_STATE_CONNECTED);
> +	service->err = 0;
> +	service_set_state(service, SERVICE_STATE_DISCONNECTING);
> +}
> +
> +void service_disconnecting_complete(struct btd_service *service, int err)
> +{
> +	if (service->state != SERVICE_STATE_CONNECTED &&
> +				service->state != SERVICE_STATE_DISCONNECTING)
> +		return;
> +
> +	service->err = err;
> +	service_set_state(service, SERVICE_STATE_DISCONNECTED);
> +}
> +
> +void service_unavailable(struct btd_service *service)
> +{
> +	service->profile = NULL;
> +	service->err = 0;
> +	service_set_state(service, SERVICE_STATE_UNAVAILABLE);
> +}

Why aren't these function names prefixed with btd_?

Johan
