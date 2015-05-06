Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1430863554-30611-1-git-send-email-armansito@chromium.org>
References: <1430863554-30611-1-git-send-email-armansito@chromium.org>
Date: Wed, 6 May 2015 13:50:03 -0700
Message-ID: <CAHrH25SPqUBGQbLXjB7-+wd37=mo4Zhh_Jthx2YfL_HvLf-NJQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] core/gatt: Add btd_gatt_client_foreach_service
From: Arman Uguray <armansito@chromium.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Cc: =?UTF-8?Q?Giovanni_Ortu=C3=B1o?= <ortuno@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> On Tue, May 5, 2015 at 3:05 PM, Arman Uguray <armansito@chromium.org> wrote:
> This patch introduces btd_gatt_client_foreach_service which allows
> users to iterate through the object paths of currently exported
> GattService1 objects.
> ---
>  src/gatt-client.c | 28 ++++++++++++++++++++++++++++
>  src/gatt-client.h |  6 ++++++
>  2 files changed, 34 insertions(+)
>
> diff --git a/src/gatt-client.c b/src/gatt-client.c
> index 2e26ed7..3614553 100644
> --- a/src/gatt-client.c
> +++ b/src/gatt-client.c
> @@ -1961,3 +1961,31 @@ void btd_gatt_client_disconnected(struct btd_gatt_client *client)
>         bt_gatt_client_unref(client->gatt);
>         client->gatt = NULL;
>  }
> +
> +struct foreach_service_data {
> +       btd_gatt_client_service_path_t func;
> +       void *user_data;
> +};
> +
> +static void client_service_foreach(void *data, void *user_data)
> +{
> +       struct service *service = data;
> +       struct foreach_service_data *foreach_data = user_data;
> +
> +       foreach_data->func(service->path, foreach_data->user_data);
> +}
> +
> +void btd_gatt_client_foreach_service(struct btd_gatt_client *client,
> +                                       btd_gatt_client_service_path_t func,
> +                                       void *user_data)
> +{
> +       struct foreach_service_data data;
> +
> +       if (!client)
> +               return;
> +
> +       data.func = func;
> +       data.user_data = user_data;
> +
> +       queue_foreach(client->services, client_service_foreach, &data);
> +}
> diff --git a/src/gatt-client.h b/src/gatt-client.h
> index f6da3b0..a18db17 100644
> --- a/src/gatt-client.h
> +++ b/src/gatt-client.h
> @@ -28,3 +28,9 @@ void btd_gatt_client_service_added(struct btd_gatt_client *client,
>  void btd_gatt_client_service_removed(struct btd_gatt_client *client,
>                                         struct gatt_db_attribute *attrib);
>  void btd_gatt_client_disconnected(struct btd_gatt_client *client);
> +
> +typedef void (*btd_gatt_client_service_path_t)(const char *service_path,
> +                                                       void *user_data);
> +void btd_gatt_client_foreach_service(struct btd_gatt_client *client,
> +                                       btd_gatt_client_service_path_t func,
> +                                       void *user_data);
> --
> 2.2.0.rc0.207.ga3a616c
>

Both patches in this set have been pushed.

Thanks,
Arman
