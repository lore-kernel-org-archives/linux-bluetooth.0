Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1411713077-19757-2-git-send-email-jakub.tyszkowski@tieto.com>
References: <1411713077-19757-1-git-send-email-jakub.tyszkowski@tieto.com>
	<1411713077-19757-2-git-send-email-jakub.tyszkowski@tieto.com>
Date: Tue, 30 Sep 2014 13:08:28 +0300
Message-ID: <CABBYNZJwTo-hQ4LuaxbmQt8WGoPCrM-a_W1NQdf8AvJboNyu2w@mail.gmail.com>
Subject: Re: [PATCHv2 01/16] android/tester: Expose gatt-tester's pdu
 definition to other testers
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Fri, Sep 26, 2014 at 9:31 AM, Jakub Tyszkowski
<jakub.tyszkowski@tieto.com> wrote:
> This is not to reinvent this mechanism again for every tester that needs
> to send raw pdu data.
>
> 'end_pdu' was renamed to 'null_pdu' to better fit also as request pdu in
> 'pdu_set' structure while setting the response not null.
>
> This mechanism can be used later to send response regardles of data that
> came with request on this specific CID. This will siplify responding to
> sdp request without defining request pdus.
> ---
>  android/tester-a2dp.c  |  2 +-
>  android/tester-avrcp.c |  2 +-
>  android/tester-gatt.c  | 49 +++++++++++++++++--------------------------------
>  android/tester-main.h  | 15 +++++++++++++++
>  4 files changed, 34 insertions(+), 34 deletions(-)
>
> diff --git a/android/tester-a2dp.c b/android/tester-a2dp.c
> index 1b2a8ce..ab3936e 100644
> --- a/android/tester-a2dp.c
> +++ b/android/tester-a2dp.c
> @@ -50,7 +50,7 @@ static const uint8_t rsp_start[] = { 0x42, 0x07 };
>  static const uint8_t req_suspend[] = { 0x50, 0x09, 0x04 };
>  static const uint8_t rsp_suspend[] = { 0x52, 0x09 };
>
> -const struct pdu {
> +const struct pdu_set {
>         const uint8_t *req;
>         size_t req_len;
>         const uint8_t *rsp;
> diff --git a/android/tester-avrcp.c b/android/tester-avrcp.c
> index 07b95f5..b539e0e 100644
> --- a/android/tester-avrcp.c
> +++ b/android/tester-avrcp.c
> @@ -71,7 +71,7 @@ static const uint8_t rsp_start[] = { 0x42, 0x07 };
>  static const uint8_t req_suspend[] = { 0x50, 0x09, 0x04 };
>  static const uint8_t rsp_suspend[] = { 0x52, 0x09 };
>
> -static const struct pdu {
> +static const struct pdu_set {
>         const uint8_t *req;
>         size_t req_len;
>         const uint8_t *rsp;
> diff --git a/android/tester-gatt.c b/android/tester-gatt.c
> index 5d18bf0..ccc8e24 100644
> --- a/android/tester-gatt.c
> +++ b/android/tester-gatt.c
> @@ -34,23 +34,8 @@
>  #define CONN1_ID       1
>  #define CONN2_ID       2
>
> -#define data(args...) ((const unsigned char[]) { args })
> -
> -#define raw_pdu(args...)                                       \
> -       {                                                       \
> -               .data = data(args),                             \
> -               .size = sizeof(data(args)),                     \
> -       }
> -
> -#define end_pdu { .data = NULL }
> -
>  static struct queue *list; /* List of gatt test cases */
>
> -struct pdu {
> -       const uint8_t *data;
> -       uint16_t size;
> -};
> -
>  static bt_uuid_t client_app_uuid = {
>         .uu = { 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
>                                 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01 },
> @@ -397,7 +382,7 @@ static struct pdu search_service[] = {
>         raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
>         raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
>         raw_pdu(0x01, 0x10, 0x11, 0x00, 0x0a),
> -       end_pdu
> +       null_pdu
>  };
>
>  static struct pdu search_service_2[] = {
> @@ -407,13 +392,13 @@ static struct pdu search_service_2[] = {
>         raw_pdu(0x11, 0x06, 0x11, 0x00, 0x20, 0x00, 0x01, 0x18),
>         raw_pdu(0x10, 0x21, 0x00, 0xff, 0xff, 0x00, 0x28),
>         raw_pdu(0x01, 0x10, 0x21, 0x00, 0x0a),
> -       end_pdu
> +       null_pdu
>  };
>
>  static struct pdu search_service_3[] = {
>         raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
>         raw_pdu(0x01, 0x08, 0x01, 0x00, 0x0a),
> -       end_pdu
> +       null_pdu
>  };
>
>  static struct pdu get_characteristic_1[] = {
> @@ -425,7 +410,7 @@ static struct pdu get_characteristic_1[] = {
>         raw_pdu(0x09, 0x07, 0x02, 0x00, 0x04, 0x00, 0x00, 0x19, 0x00),
>         raw_pdu(0x08, 0x03, 0x00, 0x10, 0x00, 0x03, 0x28),
>         raw_pdu(0x01, 0x08, 0x03, 0x00, 0x0a),
> -       end_pdu
> +       null_pdu
>  };
>
>  static struct pdu get_descriptor_1[] = {
> @@ -441,7 +426,7 @@ static struct pdu get_descriptor_1[] = {
>         raw_pdu(0x05, 0x01, 0x04, 0x00, 0x00, 0x29),
>         raw_pdu(0x04, 0x05, 0x00, 0x10, 0x00),
>         raw_pdu(0x01, 0x04, 0x05, 0x00, 0x0a),
> -       end_pdu
> +       null_pdu
>  };
>
>  static struct pdu get_descriptor_2[] = {
> @@ -457,7 +442,7 @@ static struct pdu get_descriptor_2[] = {
>         raw_pdu(0x05, 0x01, 0x04, 0x00, 0x00, 0x29, 0x05, 0x00, 0x01, 0x29),
>         raw_pdu(0x04, 0x06, 0x00, 0x10, 0x00),
>         raw_pdu(0x01, 0x04, 0x06, 0x00, 0x0a),
> -       end_pdu
> +       null_pdu
>  };
>
>  static struct pdu get_descriptor_3[] = {
> @@ -471,7 +456,7 @@ static struct pdu get_descriptor_3[] = {
>         raw_pdu(0x01, 0x08, 0x03, 0x00, 0x0a),
>         raw_pdu(0x04, 0x01, 0x00, 0x10, 0x00),
>         raw_pdu(0x01, 0x04, 0x01, 0x00, 0x0a),
> -       end_pdu
> +       null_pdu
>  };
>
>  static struct pdu get_included_1[] = {
> @@ -483,7 +468,7 @@ static struct pdu get_included_1[] = {
>         raw_pdu(0x09, 0x08, 0x02, 0x00, 0x15, 0x00, 0x19, 0x00, 0xff, 0xfe),
>         raw_pdu(0x08, 0x03, 0x00, 0x10, 0x00, 0x02, 0x28),
>         raw_pdu(0x01, 0x08, 0x03, 0x00, 0x0a),
> -       end_pdu
> +       null_pdu
>  };
>
>  static struct pdu get_included_2[] = {
> @@ -498,7 +483,7 @@ static struct pdu get_included_2[] = {
>                                 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10),
>         raw_pdu(0x08, 0x03, 0x00, 0x10, 0x00, 0x02, 0x28),
>         raw_pdu(0x01, 0x08, 0x03, 0x00, 0x0a),
> -       end_pdu
> +       null_pdu
>  };
>
>  static struct pdu get_included_3[] = {
> @@ -508,7 +493,7 @@ static struct pdu get_included_3[] = {
>         raw_pdu(0x01, 0x11, 0x11, 0x00, 0x0a),
>         raw_pdu(0x08, 0x01, 0x00, 0x10, 0x00, 0x02, 0x28),
>         raw_pdu(0x01, 0x08, 0x01, 0x00, 0x0a),
> -       end_pdu
> +       null_pdu
>  };
>
>  static struct pdu read_characteristic_1[] = {
> @@ -522,7 +507,7 @@ static struct pdu read_characteristic_1[] = {
>         raw_pdu(0x01, 0x08, 0x03, 0x00, 0x0a),
>         raw_pdu(0x0a, 0x03, 0x00),
>         raw_pdu(0x0b, 0x01),
> -       end_pdu
> +       null_pdu
>  };
>
>  static struct pdu read_characteristic_2[] = {
> @@ -536,7 +521,7 @@ static struct pdu read_characteristic_2[] = {
>         raw_pdu(0x01, 0x08, 0x03, 0x00, 0x0a),
>         raw_pdu(0x0a, 0x03, 0x00),
>         raw_pdu(0x01, 0x0a, 0x03, 0x00, 0x08),
> -       end_pdu
> +       null_pdu
>  };
>
>  static struct pdu read_descriptor_1[] = {
> @@ -554,7 +539,7 @@ static struct pdu read_descriptor_1[] = {
>         raw_pdu(0x01, 0x04, 0x05, 0x00, 0x0a),
>         raw_pdu(0x0a, 0x04, 0x00),
>         raw_pdu(0x0b, 0x01),
> -       end_pdu
> +       null_pdu
>  };
>
>  static struct pdu read_descriptor_2[] = {
> @@ -572,7 +557,7 @@ static struct pdu read_descriptor_2[] = {
>         raw_pdu(0x01, 0x04, 0x05, 0x00, 0x0a),
>         raw_pdu(0x0a, 0x04, 0x00),
>         raw_pdu(0x01, 0x0a, 0x04, 0x00, 0x08),
> -       end_pdu
> +       null_pdu
>  };
>
>  static struct pdu write_characteristic_1[] = {
> @@ -585,7 +570,7 @@ static struct pdu write_characteristic_1[] = {
>         raw_pdu(0x08, 0x03, 0x00, 0x10, 0x00, 0x03, 0x28),
>         raw_pdu(0x01, 0x08, 0x03, 0x00, 0x0a),
>         raw_pdu(0x52, 0x03, 0x00, 0x00, 0x01, 0x02, 0x03),
> -       end_pdu
> +       null_pdu
>  };
>
>  static struct pdu write_characteristic_2[] = {
> @@ -599,7 +584,7 @@ static struct pdu write_characteristic_2[] = {
>         raw_pdu(0x01, 0x08, 0x03, 0x00, 0x0a),
>         raw_pdu(0x12, 0x03, 0x00, 0x00, 0x01, 0x02, 0x03),
>         raw_pdu(0x13),
> -       end_pdu
> +       null_pdu
>  };
>
>  static struct pdu write_characteristic_3[] = {
> @@ -613,7 +598,7 @@ static struct pdu write_characteristic_3[] = {
>         raw_pdu(0x01, 0x08, 0x03, 0x00, 0x0a),
>         raw_pdu(0x12, 0x03, 0x00, 0x00, 0x01, 0x02, 0x03),
>         raw_pdu(0x01, 0x12, 0x03, 0x00, 0x08),
> -       end_pdu
> +       null_pdu
>  };
>
>  static void gatt_client_register_action(void)
> diff --git a/android/tester-main.h b/android/tester-main.h
> index 6afc553..4cbc83f 100644
> --- a/android/tester-main.h
> +++ b/android/tester-main.h
> @@ -55,6 +55,21 @@
>  #include <hardware/bt_gatt_client.h>
>  #include <hardware/bt_gatt_server.h>
>
> +struct pdu {
> +       uint8_t *data;
> +       uint16_t size;

The size should probably be size_t, or even better use struct iovec
directly here since it is about the same.

> +};
> +
> +#define raw_data(args...) ((unsigned char[]) { args })
> +
> +#define raw_pdu(args...)                                       \
> +       {                                                       \
> +               .data = raw_data(args),                         \
> +               .size = sizeof(raw_data(args)),                 \
> +       }
> +
> +#define null_pdu { .data = NULL }
> +
>  #define TEST_CASE_BREDR(text, ...) { \
>                 HCIEMU_TYPE_BREDR, \
>                 text, \
> --
> 1.9.1



-- 
Luiz Augusto von Dentz
