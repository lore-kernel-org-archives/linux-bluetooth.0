Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1422596768-17058-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1422596768-17058-1-git-send-email-lukasz.rymanowski@tieto.com>
Date: Mon, 2 Feb 2015 12:40:48 +0100
Message-ID: <CAMudyAt92tkc8004ubknBY5tHvhP=34SyLAceFj6k0u+Cws5Kg@mail.gmail.com>
Subject: Re: [PATCH 1/2] android/gatt: Fix Find By Type request
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 30 January 2015 at 06:46, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> With this patch GATT will correctly response with attribute not found if
> there is no attributes matching.
>
> Issue found and fix tested on UPF50
> ---
>  android/gatt.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/android/gatt.c b/android/gatt.c
> index 466c1ea..3b0b81d 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -6258,6 +6258,7 @@ struct find_by_type_request_data {
>         uint8_t *search_value;
>         size_t search_vlen;
>         uint8_t error;
> +       bool found;
>  };
>
>  static void find_by_type_request_cb(struct gatt_db_attribute *attrib,
> @@ -6289,6 +6290,9 @@ static void find_by_type_request_cb(struct gatt_db_attribute *attrib,
>                                                         find_data->search_vlen);
>
>         queue_push_tail(find_data->device->pending_requests, request_data);
> +
> +       if (!find_data->found)
> +               find_data->found = true;
>  }
>
>  static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
> @@ -6315,11 +6319,12 @@ static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
>         data.search_vlen = search_vlen;
>         data.search_value = search_value;
>         data.device = device;
> +       data.found = false;
>
>         gatt_db_find_by_type(gatt_db, start, end, &uuid,
>                                                 find_by_type_request_cb, &data);
>
> -       if (data.error == ATT_ECODE_ATTR_NOT_FOUND) {
> +       if (!data.found) {
>                 size_t mtu;
>                 uint8_t *rsp = g_attrib_get_buffer(device->attrib, &mtu);

Ehen think longer about it, maybe we should move the fix somehow to
gatt-db. E.x. find_by_type_request_cb would be called with *attrib ==
NULL when there is any matching attribute.

Any comments?

\Łukasz

>
> --
> 1.8.4
>
