Return-Path: <cyrus@holtmann.org>
Date: Fri, 3 May 2013 07:36:02 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] profile: Create a service for incomming connections
Message-ID: <20130503043602.GA3742@x220>
References: <1367533776-3987-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367533776-3987-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Thu, May 02, 2013, Vinicius Costa Gomes wrote:
> diff --git a/src/profile.c b/src/profile.c
> index 0500983..2c35dc7 100644
> --- a/src/profile.c
> +++ b/src/profile.c
> @@ -1045,6 +1045,7 @@ static struct ext_io *create_conn(struct ext_io *server, GIOChannel *io,
>  {
>  	struct btd_device *device;
>  	struct ext_io *conn;
> +	struct btd_profile *profile;
>  	GIOCondition cond;
>  
>  	conn = g_new0(struct ext_io, 1);
> @@ -1052,11 +1053,14 @@ static struct ext_io *create_conn(struct ext_io *server, GIOChannel *io,
>  	conn->proto = server->proto;
>  	conn->ext = server->ext;
>  	conn->adapter = btd_adapter_ref(server->adapter);
> +	profile = &server->ext->p;
>  
>  	device = adapter_find_device(server->adapter, dst);
>  
> -	if (device)
> +	if (device) {
>  		conn->device = btd_device_ref(device);
> +		conn->service = service_create(device, profile);
> +	}
>  
>  	cond = G_IO_HUP | G_IO_ERR | G_IO_NVAL;
>  	conn->io_id = g_io_add_watch(io, cond, ext_io_disconnected, conn);

How would the service show up in the list of services for the device
object in question? To me it seems like src/device.c is the only place
that should be calling service_create because of this. What does seem to
be missing in profile.c is a call to btd_device_add_uuid for unexpected
connections from a device which we did not yet know to support a certain
UUID. The btd_device_add_uuid function should cause a new service to be
created, but it may not yet be enough to get the service to be assigned
to conn in profile.c.

Johan
