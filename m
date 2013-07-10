Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1373380758-16489-3-git-send-email-luiz.dentz@gmail.com>
References: <1373380758-16489-1-git-send-email-luiz.dentz@gmail.com>
	<1373380758-16489-3-git-send-email-luiz.dentz@gmail.com>
Date: Wed, 10 Jul 2013 13:00:24 +0300
Message-ID: <CABBYNZLywe4UyQgiab81bdZPBVAvLdo+cFjrKFCGYAEw4Zf8NQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3 v2] core/service: Rename service_shutdown to service_remove
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jul 9, 2013 at 5:38 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This rename service_shutdown to service_remove to make it more similar to
> other internal APIs such as device_remove which only do object
> cleanup/free and do not have any disconnect logic.
> ---
>  src/device.c  | 3 +--
>  src/service.c | 3 ++-
>  src/service.h | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/src/device.c b/src/device.c
> index edd377c..afb0cfc 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -967,9 +967,8 @@ static void remove_service(gpointer data)
>         struct btd_service *service = data;
>         struct btd_device *device = btd_service_get_device(service);
>
> -       service_shutdown(service);
>         device->pending = g_slist_remove(device->pending, service);
> -       btd_service_unref(service);
> +       service_remove(service);
>  }
>
>  static gboolean do_disconnect(gpointer user_data)
> diff --git a/src/service.c b/src/service.c
> index 83e1c1a..52a8291 100644
> --- a/src/service.c
> +++ b/src/service.c
> @@ -168,12 +168,13 @@ int service_probe(struct btd_service *service)
>         return err;
>  }
>
> -void service_shutdown(struct btd_service *service)
> +void service_remove(struct btd_service *service)
>  {
>         change_state(service, BTD_SERVICE_STATE_UNAVAILABLE, 0);
>         service->profile->device_remove(service);
>         service->device = NULL;
>         service->profile = NULL;
> +       btd_service_unref(service);
>  }
>
>  int btd_service_connect(struct btd_service *service)
> diff --git a/src/service.h b/src/service.h
> index 6ee8f17..5230115 100644
> --- a/src/service.h
> +++ b/src/service.h
> @@ -46,7 +46,7 @@ struct btd_service *service_create(struct btd_device *device,
>                                                 struct btd_profile *profile);
>
>  int service_probe(struct btd_service *service);
> -void service_shutdown(struct btd_service *service);
> +void service_remove(struct btd_service *service);
>
>  /* Connection control API */
>  int btd_service_connect(struct btd_service *service);
> --
> 1.8.1.4

These 3 patches are now pushed.


--
Luiz Augusto von Dentz
