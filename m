Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1423016185-321-1-git-send-email-jpawlowski@google.com>
References: <1423016185-321-1-git-send-email-jpawlowski@google.com>
Date: Wed, 4 Feb 2015 18:01:45 +0200
Message-ID: <CABBYNZL4kQAwvByB4Edv_KkKOvbdeLbTp4UXz3=iQjWfMC7wbg@mail.gmail.com>
Subject: Re: [PATCH] shared/gatt-client: fix overflow bug in find_service_for_handle
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wed, Feb 4, 2015 at 4:16 AM, Jakub Pawlowski <jpawlowski@google.com> wrote:
> find_service_for_handle was manually computing end handle. It was
> causing overflow for last service in range, that always ends at 0xFFFF.
> That caused service for handle not being found.
>
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
>  src/shared/gatt-db.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index 780d640..f72d58e 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -1170,10 +1170,9 @@ static bool find_service_for_handle(const void *data, const void *user_data)
>         uint16_t handle = PTR_TO_UINT(user_data);
>         uint16_t start, end;
>
> -       start = service->attributes[0]->handle;
> -       end = start + service->num_handles;
> +       gatt_db_service_get_handles(service, &start, &end);
>
> -       return (start <= handle) && (handle < end);
> +       return (start <= handle) && (handle <= end);
>  }
>
>  struct gatt_db_attribute *gatt_db_get_attribute(struct gatt_db *db,
> --
> 2.2.0.rc0.207.ga3a616c

Applied, thanks.


-- 
Luiz Augusto von Dentz
