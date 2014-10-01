Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1412154099-28014-18-git-send-email-jakub.tyszkowski@tieto.com>
References: <1412154099-28014-1-git-send-email-jakub.tyszkowski@tieto.com>
	<1412154099-28014-18-git-send-email-jakub.tyszkowski@tieto.com>
Date: Wed, 1 Oct 2014 15:37:09 +0300
Message-ID: <CABBYNZJ-AJ7XUQrC_xYSaic08d8EGs_KErJTLAgZAAOepdBFYQ@mail.gmail.com>
Subject: Re: [PATCHv3 17/17] android/tester: Replace pdu struct with iovec
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wed, Oct 1, 2014 at 12:01 PM, Jakub Tyszkowski
<jakub.tyszkowski@tieto.com> wrote:
> I/O vectors are now supported on bthost API.
> ---
>  android/tester-gatt.c    | 68 ++++++++++++++++++++++++------------------------
>  android/tester-hidhost.c | 10 +++----
>  android/tester-main.c    | 25 ++++++++++--------
>  android/tester-main.h    | 16 +++++-------
>  4 files changed, 58 insertions(+), 61 deletions(-)
>
> diff --git a/android/tester-gatt.c b/android/tester-gatt.c
> index 1460329..81ae257 100644
> --- a/android/tester-gatt.c
> +++ b/android/tester-gatt.c
> @@ -137,8 +137,8 @@ static struct gatt_search_service_data search_services_1 = {
>         .filter_uuid = NULL,
>  };
>
> -static const struct pdu exchange_mtu_req_pdu = raw_pdu(0x02, 0xa0, 0x02);
> -static const struct pdu exchange_mtu_resp_pdu = raw_pdu(0x03, 0xa0, 0x02);
> +static const struct iovec exchange_mtu_req_pdu = raw_pdu(0x02, 0xa0, 0x02);
> +static const struct iovec exchange_mtu_resp_pdu = raw_pdu(0x03, 0xa0, 0x02);
>
>  static struct bt_action_data bearer_type = {
>         .bearer_type = BDADDR_LE_PUBLIC,
> @@ -368,7 +368,7 @@ static struct set_write_params set_write_param_3 = {
>         .status = 0x01
>  };
>
> -static struct pdu search_service[] = {
> +static struct iovec search_service[] = {
>         raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
>         raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
>         raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
> @@ -376,7 +376,7 @@ static struct pdu search_service[] = {
>         null_pdu
>  };
>
> -static struct pdu search_service_2[] = {
> +static struct iovec search_service_2[] = {
>         raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
>         raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
>         raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
> @@ -386,13 +386,13 @@ static struct pdu search_service_2[] = {
>         null_pdu
>  };
>
> -static struct pdu search_service_3[] = {
> +static struct iovec search_service_3[] = {
>         raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
>         raw_pdu(0x01, 0x08, 0x01, 0x00, 0x0a),
>         null_pdu
>  };
>
> -static struct pdu get_characteristic_1[] = {
> +static struct iovec get_characteristic_1[] = {
>         raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
>         raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
>         raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
> @@ -404,7 +404,7 @@ static struct pdu get_characteristic_1[] = {
>         null_pdu
>  };
>
> -static struct pdu get_descriptor_1[] = {
> +static struct iovec get_descriptor_1[] = {
>         raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
>         raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
>         raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
> @@ -420,7 +420,7 @@ static struct pdu get_descriptor_1[] = {
>         null_pdu
>  };
>
> -static struct pdu get_descriptor_2[] = {
> +static struct iovec get_descriptor_2[] = {
>         raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
>         raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
>         raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
> @@ -436,7 +436,7 @@ static struct pdu get_descriptor_2[] = {
>         null_pdu
>  };
>
> -static struct pdu get_descriptor_3[] = {
> +static struct iovec get_descriptor_3[] = {
>         raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
>         raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
>         raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
> @@ -450,7 +450,7 @@ static struct pdu get_descriptor_3[] = {
>         null_pdu
>  };
>
> -static struct pdu get_included_1[] = {
> +static struct iovec get_included_1[] = {
>         raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
>         raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
>         raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
> @@ -462,7 +462,7 @@ static struct pdu get_included_1[] = {
>         null_pdu
>  };
>
> -static struct pdu get_included_2[] = {
> +static struct iovec get_included_2[] = {
>         raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
>         raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
>         raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
> @@ -477,7 +477,7 @@ static struct pdu get_included_2[] = {
>         null_pdu
>  };
>
> -static struct pdu get_included_3[] = {
> +static struct iovec get_included_3[] = {
>         raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
>         raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
>         raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
> @@ -487,7 +487,7 @@ static struct pdu get_included_3[] = {
>         null_pdu
>  };
>
> -static struct pdu read_characteristic_1[] = {
> +static struct iovec read_characteristic_1[] = {
>         raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
>         raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
>         raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
> @@ -501,7 +501,7 @@ static struct pdu read_characteristic_1[] = {
>         null_pdu
>  };
>
> -static struct pdu read_characteristic_2[] = {
> +static struct iovec read_characteristic_2[] = {
>         raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
>         raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
>         raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
> @@ -515,7 +515,7 @@ static struct pdu read_characteristic_2[] = {
>         null_pdu
>  };
>
> -static struct pdu read_descriptor_1[] = {
> +static struct iovec read_descriptor_1[] = {
>         raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
>         raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
>         raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
> @@ -533,7 +533,7 @@ static struct pdu read_descriptor_1[] = {
>         null_pdu
>  };
>
> -static struct pdu read_descriptor_2[] = {
> +static struct iovec read_descriptor_2[] = {
>         raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
>         raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
>         raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
> @@ -551,7 +551,7 @@ static struct pdu read_descriptor_2[] = {
>         null_pdu
>  };
>
> -static struct pdu write_characteristic_1[] = {
> +static struct iovec write_characteristic_1[] = {
>         raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
>         raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
>         raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
> @@ -564,7 +564,7 @@ static struct pdu write_characteristic_1[] = {
>         null_pdu
>  };
>
> -static struct pdu write_characteristic_2[] = {
> +static struct iovec write_characteristic_2[] = {
>         raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
>         raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
>         raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
> @@ -578,7 +578,7 @@ static struct pdu write_characteristic_2[] = {
>         null_pdu
>  };
>
> -static struct pdu write_characteristic_3[] = {
> +static struct iovec write_characteristic_3[] = {
>         raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
>         raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
>         raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
> @@ -847,16 +847,16 @@ static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
>         struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
>         struct emu_l2cap_cid_data *cid_data = user_data;
>         const uint8_t *pdu = data;
> -       struct pdu *gatt_pdu = queue_peek_head(t_data->pdus);
> +       struct iovec *gatt_pdu = queue_peek_head(t_data->pdus);
>
>         switch (pdu[0]) {
>         case L2CAP_ATT_EXCHANGE_MTU_REQ:
>                 tester_print("Exchange MTU request received.");
>
> -               if (!memcmp(exchange_mtu_req_pdu.data, pdu, len))
> -                       bthost_send_cid(bthost, cid_data->handle, cid_data->cid,
> -                                               exchange_mtu_resp_pdu.data,
> -                                               exchange_mtu_resp_pdu.size);
> +               if (!memcmp(exchange_mtu_req_pdu.iov_base, pdu, len))
> +                       bthost_send_cid_v(bthost, cid_data->handle,
> +                                               cid_data->cid,
> +                                               &exchange_mtu_resp_pdu, 1);
>
>                 break;
>         case L2CAP_ATT_EXCHANGE_MTU_RSP:
> @@ -864,29 +864,29 @@ static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
>
>                 break;
>         default:
> -               if (!gatt_pdu || !gatt_pdu->data) {
> +               if (!gatt_pdu || !gatt_pdu->iov_base) {
>                         tester_print("Unknown ATT packet.");
>                         break;
>                 }
>
> -               if (gatt_pdu->size != len) {
> +               if (gatt_pdu->iov_len != len) {
>                         tester_print("Size of incoming frame is not valid");
> -                       tester_print("Expected size = %d incoming size = %d",
> -                                                       gatt_pdu->size, len);
> +                       tester_print("Expected size = %zd incoming size = %d",
> +                                                       gatt_pdu->iov_len, len);
>                         break;
>                 }
>
> -               if (memcmp(gatt_pdu->data, data, len)) {
> +               if (memcmp(gatt_pdu->iov_base, data, len)) {
>                         tester_print("Incoming data mismatch");
>                         break;
>                 }
>                 queue_pop_head(t_data->pdus);
>                 gatt_pdu = queue_pop_head(t_data->pdus);
> -               if (!gatt_pdu || !gatt_pdu->data)
> +               if (!gatt_pdu || !gatt_pdu->iov_base)
>                         break;
>
> -               bthost_send_cid(bthost, cid_data->handle, cid_data->cid,
> -                                               gatt_pdu->data, gatt_pdu->size);
> +               bthost_send_cid_v(bthost, cid_data->handle, cid_data->cid,
> +                                                               gatt_pdu, 1);
>
>                 break;
>         }
> @@ -933,9 +933,9 @@ static void init_pdus(void)
>         struct test_data *data = tester_get_data();
>         struct step *current_data_step = queue_peek_head(data->steps);
>         struct step *step = g_new0(struct step, 1);
> -       struct pdu *pdu = current_data_step->set_data;
> +       struct iovec *pdu = current_data_step->set_data;
>
> -       while (pdu->data) {
> +       while (pdu->iov_base) {
>                 queue_push_tail(data->pdus, pdu);
>                 pdu++;
>         }
> diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
> index 4c8b4c6..a9d7bd9 100644
> --- a/android/tester-hidhost.c
> +++ b/android/tester-hidhost.c
> @@ -139,20 +139,18 @@ static void hid_prepare_reply_protocol_mode(struct emu_l2cap_cid_data *cid_data)
>  {
>         struct test_data *t_data = tester_get_data();
>         struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
> -       const struct pdu pdu = raw_pdu(0xa0, 0x00);
> +       const struct iovec pdu = raw_pdu(0xa0, 0x00);
>
> -       bthost_send_cid(bthost, cid_data->handle, cid_data->cid, pdu.data,
> -                                                               pdu.size);
> +       bthost_send_cid_v(bthost, cid_data->handle, cid_data->cid, &pdu, 1);
>  }
>
>  static void hid_prepare_reply_report(struct emu_l2cap_cid_data *cid_data)
>  {
>         struct test_data *t_data = tester_get_data();
>         struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
> -       const struct pdu pdu = raw_pdu(0xa2, 0x01, 0x00);
> +       const struct iovec pdu = raw_pdu(0xa2, 0x01, 0x00);
>
> -       bthost_send_cid(bthost, cid_data->handle, cid_data->cid, pdu.data,
> -                                                               pdu.size);
> +       bthost_send_cid_v(bthost, cid_data->handle, cid_data->cid, &pdu, 1);
>  }
>
>  static void hid_ctrl_cid_hook_cb(const void *data, uint16_t len,
> diff --git a/android/tester-main.c b/android/tester-main.c
> index c728f05..41abf6d 100644
> --- a/android/tester-main.c
> +++ b/android/tester-main.c
> @@ -2141,27 +2141,30 @@ static void emu_generic_cid_hook_cb(const void *data, uint16_t len,
>         struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
>         int i;
>
> -       for (i = 0; pdus[i].rsp.data; i++) {
> -               if (pdus[i].req.data) {
> -                       if (pdus[i].req.size != len)
> +       for (i = 0; pdus[i].rsp.iov_base; i++) {
> +               if (pdus[i].req.iov_base) {
> +                       if (pdus[i].req.iov_len != len)
>                                 continue;
>
> -                       if (memcmp(pdus[i].req.data, data, len))
> +                       if (memcmp(pdus[i].req.iov_base, data, len))
>                                 continue;
>                 }
>
> -               if (pdus[i].rsp.data) {
> +               if (pdus[i].rsp.iov_base) {
>                         /* overwrite transaction id if its sdp pdu */
>                         if (cid_data->is_sdp) {
> -                               pdus[i].rsp.data[1] = ((uint8_t *) data)[1];
> -                               pdus[i].rsp.data[2] = ((uint8_t *) data)[2];
> +                               ((uint8_t *) pdus[i].rsp.iov_base)[1] =
> +                                                       ((uint8_t *) data)[1];
> +                               ((uint8_t *) pdus[i].rsp.iov_base)[2] =
> +                                                       ((uint8_t *) data)[2];
>                         }
>
> -                       util_hexdump('>', pdus[i].rsp.data, pdus[i].rsp.size,
> -                                                       print_data, NULL);
> +                       util_hexdump('>', pdus[i].rsp.iov_base,
> +                                       pdus[i].rsp.iov_len, print_data, NULL);
> +
> +                       bthost_send_cid_v(bthost, cid_data->handle,
> +                                               cid_data->cid, &pdus[i].rsp, 1);
>
> -                       bthost_send_cid(bthost, cid_data->handle, cid_data->cid,
> -                                       pdus[i].rsp.data, pdus[i].rsp.size);
>                 }
>         }
>  }
> diff --git a/android/tester-main.h b/android/tester-main.h
> index 560277a..1b679d6 100644
> --- a/android/tester-main.h
> +++ b/android/tester-main.h
> @@ -33,6 +33,7 @@
>  #include <sys/wait.h>
>  #include <libgen.h>
>  #include <sys/signalfd.h>
> +#include <sys/uio.h>
>
>  #include "lib/bluetooth.h"
>  #include "lib/mgmt.h"
> @@ -56,25 +57,20 @@
>  #include <hardware/bt_gatt_client.h>
>  #include <hardware/bt_gatt_server.h>
>
> -struct pdu {
> -       uint8_t *data;
> -       uint16_t size;
> -};
> -
>  struct pdu_set {
> -       struct pdu req;
> -       struct pdu rsp;
> +       struct iovec req;
> +       struct iovec rsp;
>  };
>
>  #define raw_data(args...) ((unsigned char[]) { args })
>
>  #define raw_pdu(args...)                                       \
>         {                                                       \
> -               .data = raw_data(args),                         \
> -               .size = sizeof(raw_data(args)),                 \
> +               .iov_base = raw_data(args),                     \
> +               .iov_len = sizeof(raw_data(args)),              \
>         }
>
> -#define null_pdu { .data = NULL }
> +#define null_pdu { .iov_base = NULL }
>
>  #define TEST_CASE_BREDR(text, ...) { \
>                 HCIEMU_TYPE_BREDR, \
> --
> 1.9.1

I guess it would be beneficial to use bthost_send_cid_v since the
beginning here, perhaps you didn't want to rebase the changes or found
some problem while doing it. Normally what I would do is to rebase -i
--exec make, then mark the patch to edit and let make catch the
errors, it should really not take more than 30 min to rebase these.


-- 
Luiz Augusto von Dentz
