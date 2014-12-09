Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1418083529-4418-2-git-send-email-jamuraa@chromium.org>
References: <1418083529-4418-1-git-send-email-jamuraa@chromium.org>
	<1418083529-4418-2-git-send-email-jamuraa@chromium.org>
Date: Tue, 9 Dec 2014 14:00:03 +0200
Message-ID: <CABBYNZK5zJzWkGrdguYaF+Hm15XXz67sh6KWKS+vO5sgnFq61g@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/5] lib/uuid: Simplify BT base UUIDs when possible
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michael Janssen <jamuraa@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Tue, Dec 9, 2014 at 2:05 AM, Michael Janssen <jamuraa@chromium.org> wrote:
> When converting a UUID from string to bt_uuid_t, prefer using
> the 16-bit version when possible, which should generate shorter
> sequences by increasing the number of 16-bit types.
> ---
>  lib/uuid.c       |  4 ++++
>  unit/test-uuid.c | 22 +++++++++++++++++++---
>  2 files changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/lib/uuid.c b/lib/uuid.c
> index 5c3f986..d110b5e 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -238,6 +238,10 @@ static int bt_string_to_uuid128(bt_uuid_t *uuid, const char *string)
>                                 &data3, &data4, &data5) != 6)
>                 return -EINVAL;
>
> +       if (data0 <= 0xFFFF && data1 == 0x0000 && data2 == 0x1000 &&
> +           data3 == 0x8000 && data4 == 0x0805f9bL && data5 == 0x34fb)
> +               return bt_uuid16_create(uuid, data0 & 0xFFFF);
> +
>         data0 = htonl(data0);
>         data1 = htons(data1);
>         data2 = htons(data2);
> diff --git a/unit/test-uuid.c b/unit/test-uuid.c
> index 6c7e9d0..8647af9 100644
> --- a/unit/test-uuid.c
> +++ b/unit/test-uuid.c
> @@ -46,9 +46,9 @@ static unsigned char uuid_base_binary[] = {
>                         0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb };
>
>  static struct uuid_test_data uuid_base = {
> -       .str = "00000000-0000-1000-8000-00805f9b34fb",
> -       .binary = uuid_base_binary,
> -       .type = BT_UUID128,
> +       .str = "0000",
> +       .val16 = 0x0000,
> +       .type = BT_UUID16,
>         .str128 = "00000000-0000-1000-8000-00805f9b34fb",
>         .binary128 = uuid_base_binary,
>  };
> @@ -93,6 +93,18 @@ static struct uuid_test_data uuid_32_2 = {
>         .binary128 = uuid_32_binary,
>  };
>
> +static unsigned char uuid_128_binary[] = {
> +                       0xF0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00,
> +                       0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb };
> +
> +static struct uuid_test_data uuid_128 = {
> +       .str = "F0000000-0000-1000-8000-00805f9b34fb",
> +       .binary = uuid_128_binary,
> +       .type = BT_UUID128,
> +       .str128 = "F0000000-0000-1000-8000-00805f9b34fb",
> +       .binary128 = uuid_128_binary,
> +};
> +
>  static void test_uuid(gconstpointer data)
>  {
>         const struct uuid_test_data *test_data = data;
> @@ -216,6 +228,10 @@ int main(int argc, char *argv[])
>         g_test_add_data_func("/uuid/thritytwo2/str", &uuid_32_2, test_str);
>         g_test_add_data_func("/uuid/thirtytwo2/cmp", &uuid_32_2, test_cmp);
>
> +       g_test_add_data_func("/uuid/onetwentyeight", &uuid_128, test_uuid);
> +       g_test_add_data_func("/uuid/onetwentyeight/str", &uuid_128, test_str);
> +       g_test_add_data_func("/uuid/onetwentyeight/cmp", &uuid_128, test_cmp);
> +
>         for (i = 0; malformed[i]; i++) {
>                 char *testpath;
>
> --
> 2.2.0.rc0.207.ga3a616c

I have skip this one since it perhaps better to call it
bt_string_to_uuid if in fact this could end up as uuid16, but then
apparently it does not pass the unit tests:


bt_gatt_server:Read By Grp Type - start: 0x0001 end: 0xffff
GATT: > 11 14 10 f0 15 f0 fb 34 9b 5f 80 00 00 80 00 10  .......4._......
GATT:   00 00 00 18 00 00                                ......
**
ERROR:unit/test-gatt.c:268:test_handler: assertion failed (len ==
pdu->size): (22 == 14)
(MSG: ERROR:unit/test-gatt.c:268:test_handler: assertion failed (len
== pdu->size): (22 == 14))



-- 
Luiz Augusto von Dentz
