Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1397027234-12003-3-git-send-email-marcin.kraglak@tieto.com>
References: <1397027234-12003-1-git-send-email-marcin.kraglak@tieto.com>
	<1397027234-12003-3-git-send-email-marcin.kraglak@tieto.com>
Date: Mon, 14 Apr 2014 11:11:42 -0300
Message-ID: <CAKT1EBdb3O03mN4RUw9hyYQJxb4si9LvqAcGLEcwQ=vC9DusvA@mail.gmail.com>
Subject: Re: [RFC 02/16] gatt: Add services list to gatt_db struct
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Wed, Apr 9, 2014 at 4:07 AM, Marcin Kraglak <marcin.kraglak@tieto.com> wrote:
> Gatt database will store all services in queue services. Each service
> contains attributes, number of handles included and flag if it is
> active service.
> ---
>  src/shared/gatt-db.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index e56b381..47915c7 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -21,11 +21,24 @@
>   *
>   */
>
> +#include <stdbool.h>
> +
>  #include "src/shared/util.h"
> +#include "src/shared/queue.h"
>  #include "src/shared/gatt-db.h"
>
>  struct gatt_db {
>         uint16_t next_handle;
> +       struct queue *services;
> +};
> +
> +struct gatt_db_attribute {
> +};
> +
> +struct gatt_db_service {
> +       bool active;
> +       uint16_t num_handles;
> +       struct gatt_db_attribute **attributes;

If the plan is to support handle allocation, maybe it'd better to have
continuous memory allocation instead of attributes pointers.

Claudio.

<snip>
