Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1423711064-7390-2-git-send-email-armansito@chromium.org>
References: <1423711064-7390-1-git-send-email-armansito@chromium.org>
	<1423711064-7390-2-git-send-email-armansito@chromium.org>
Date: Thu, 12 Feb 2015 15:40:38 +0200
Message-ID: <CABBYNZ+wMt00MErfHx=1sWAvMi8U4NkeNX6LLNSCSyYSGJkpRQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 01/14] shared/att: Add bt_att_get_fd
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Thu, Feb 12, 2015 at 5:17 AM, Arman Uguray <armansito@chromium.org> wrote:
> Added the bt_att_get_fd function which returns the underlying file
> descriptor of a bt_att.
> ---
>  src/shared/att.c          | 8 ++++++++
>  src/shared/att.h          | 2 ++
>  src/shared/gatt-client.c  | 3 ++-
>  src/shared/gatt-helpers.c | 3 ++-
>  4 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/src/shared/att.c b/src/shared/att.c
> index a98909e..8bf1bab 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -889,6 +889,14 @@ bool bt_att_set_close_on_unref(struct bt_att *att, bool do_close)
>         return io_set_close_on_destroy(att->io, do_close);
>  }
>
> +int bt_att_get_fd(struct bt_att *att)
> +{
> +       if (!att)
> +               return -1;
> +
> +       return att->fd;
> +}
> +
>  bool bt_att_set_debug(struct bt_att *att, bt_att_debug_func_t callback,
>                                 void *user_data, bt_att_destroy_func_t destroy)
>  {
> diff --git a/src/shared/att.h b/src/shared/att.h
> index cd00a1e..db423fe 100644
> --- a/src/shared/att.h
> +++ b/src/shared/att.h
> @@ -35,6 +35,8 @@ void bt_att_unref(struct bt_att *att);
>
>  bool bt_att_set_close_on_unref(struct bt_att *att, bool do_close);
>
> +int bt_att_get_fd(struct bt_att *att);
> +
>  typedef void (*bt_att_response_func_t)(uint8_t opcode, const void *pdu,
>                                         uint16_t length, void *user_data);
>  typedef void (*bt_att_notify_func_t)(uint8_t opcode, const void *pdu,
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index bfb9427..d5a277b 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -21,8 +21,9 @@
>   *
>   */
>
> -#include "src/shared/att.h"
>  #include "lib/uuid.h"
> +#include "lib/bluetooth.h"
> +#include "src/shared/att.h"
>  #include "src/shared/gatt-helpers.h"
>  #include "src/shared/util.h"
>  #include "src/shared/queue.h"
> diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
> index a33f960..b469116 100644
> --- a/src/shared/gatt-helpers.c
> +++ b/src/shared/gatt-helpers.c
> @@ -26,9 +26,10 @@
>  #include <config.h>
>  #endif
>
> +#include "lib/uuid.h"
> +#include "lib/bluetooth.h"
>  #include "src/shared/queue.h"
>  #include "src/shared/att.h"
> -#include "lib/uuid.h"
>  #include "src/shared/gatt-helpers.h"
>  #include "src/shared/util.h"

It seems there changes are not really necessary, are they? At least
for these changes you don't really need bluetooth.h.


-- 
Luiz Augusto von Dentz
