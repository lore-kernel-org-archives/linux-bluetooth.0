Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1409840644-32200-1-git-send-email-luiz.dentz@gmail.com>
References: <1409840644-32200-1-git-send-email-luiz.dentz@gmail.com>
Date: Fri, 5 Sep 2014 15:45:44 +0300
Message-ID: <CABBYNZKgjVHnFgRs6B1dXfY3RqL_XdoKJSFMnvmF7QRhMUe+WQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] android/tester: Add AVRCP init - Success test case
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Sep 4, 2014 at 5:24 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> ---
>  android/Makefile.am    |  1 +
>  android/tester-avrcp.c | 50 +++++++++++++++++++++++++++++++++++
>  android/tester-main.c  | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  android/tester-main.h  |  4 +++
>  4 files changed, 127 insertions(+)
>  create mode 100644 android/tester-avrcp.c
>
> diff --git a/android/Makefile.am b/android/Makefile.am
> index e93a08b..49fbddc 100644
> --- a/android/Makefile.am
> +++ b/android/Makefile.am
> @@ -171,6 +171,7 @@ android_android_tester_SOURCES = emulator/btdev.h emulator/btdev.c \
>                                 android/tester-pan.c \
>                                 android/tester-hdp.c \
>                                 android/tester-a2dp.c \
> +                               android/tester-avrcp.c \
>                                 android/tester-gatt.c \
>                                 android/tester-main.h android/tester-main.c
>
> diff --git a/android/tester-avrcp.c b/android/tester-avrcp.c
> new file mode 100644
> index 0000000..60a57b4
> --- /dev/null
> +++ b/android/tester-avrcp.c
> @@ -0,0 +1,50 @@
> +/*
> + * Copyright (C) 2014 Intel Corporation
> + *
> + * Licensed under the Apache License, Version 2.0 (the "License");
> + * you may not use this file except in compliance with the License.
> + * You may obtain a copy of the License at
> + *
> + *      http://www.apache.org/licenses/LICENSE-2.0
> + *
> + * Unless required by applicable law or agreed to in writing, software
> + * distributed under the License is distributed on an "AS IS" BASIS,
> + * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
> + * See the License for the specific language governing permissions and
> + * limitations under the License.
> + *
> + */
> +
> +#include <stdbool.h>
> +
> +#include "emulator/bthost.h"
> +#include "src/shared/util.h"
> +
> +#include "tester-main.h"
> +#include "android/utils.h"
> +
> +static struct queue *list;
> +
> +static struct test_case test_cases[] = {
> +       TEST_CASE_BREDRLE("AVRCP Init",
> +               ACTION_SUCCESS(dummy_action, NULL),
> +       ),
> +};
> +
> +struct queue *get_avrcp_tests(void)
> +{
> +       uint16_t i = 0;
> +
> +       list = queue_new();
> +
> +       for (; i < sizeof(test_cases) / sizeof(test_cases[0]); ++i)
> +               if (!queue_push_tail(list, &test_cases[i]))
> +                       return NULL;
> +
> +       return list;
> +}
> +
> +void remove_avrcp_tests(void)
> +{
> +       queue_destroy(list, NULL);
> +}
> diff --git a/android/tester-main.c b/android/tester-main.c
> index f5f46fb..37f3442 100644
> --- a/android/tester-main.c
> +++ b/android/tester-main.c
> @@ -1212,6 +1212,10 @@ static btav_callbacks_t bta2dp_callbacks = {
>         .audio_state_cb = a2dp_audio_state_cb,
>  };
>
> +static btrc_callbacks_t btavrcp_callbacks = {
> +       .size = sizeof(btavrcp_callbacks),
> +};
> +
>  static const btgatt_client_callbacks_t btgatt_client_callbacks = {
>         .register_client_cb = gattc_register_client_cb,
>         .scan_result_cb = gattc_scan_result_cb,
> @@ -1528,6 +1532,60 @@ static void setup_a2dp(const void *test_data)
>         tester_setup_complete();
>  }
>
> +static void setup_avrcp(const void *test_data)
> +{
> +       struct test_data *data = tester_get_data();
> +       const bt_interface_t *if_bt;
> +       bt_status_t status;
> +       const void *a2dp, *avrcp;
> +
> +       if (!setup_base(data)) {
> +               tester_setup_failed();
> +               return;
> +       }
> +
> +       if_bt = data->if_bluetooth;
> +
> +       status = if_bt->init(&bt_callbacks);
> +       if (status != BT_STATUS_SUCCESS) {
> +               data->if_bluetooth = NULL;
> +               tester_setup_failed();
> +               return;
> +       }
> +
> +       a2dp = if_bt->get_profile_interface(BT_PROFILE_ADVANCED_AUDIO_ID);
> +       if (!a2dp) {
> +               tester_setup_failed();
> +               return;
> +       }
> +
> +       data->if_a2dp = a2dp;
> +
> +       status = data->if_a2dp->init(&bta2dp_callbacks);
> +       if (status != BT_STATUS_SUCCESS) {
> +               data->if_a2dp = NULL;
> +               tester_setup_failed();
> +               return;
> +       }
> +
> +       avrcp = if_bt->get_profile_interface(BT_PROFILE_AV_RC_ID);
> +       if (!a2dp) {
> +               tester_setup_failed();
> +               return;
> +       }
> +
> +       data->if_avrcp = avrcp;
> +
> +       status = data->if_avrcp->init(&btavrcp_callbacks);
> +       if (status != BT_STATUS_SUCCESS) {
> +               data->if_avrcp = NULL;
> +               tester_setup_failed();
> +               return;
> +       }
> +
> +       tester_setup_complete();
> +}
> +
>  static void setup_gatt(const void *test_data)
>  {
>         struct test_data *data = tester_get_data();
> @@ -1605,6 +1663,11 @@ static void teardown(const void *test_data)
>                 data->if_a2dp = NULL;
>         }
>
> +       if (data->if_avrcp) {
> +               data->if_avrcp->cleanup();
> +               data->if_avrcp = NULL;
> +       }
> +
>         if (data->if_bluetooth) {
>                 data->if_bluetooth->cleanup();
>                 data->if_bluetooth = NULL;
> @@ -2125,6 +2188,7 @@ static void tester_testcases_cleanup(void)
>         remove_hidhost_tests();
>         remove_gatt_tests();
>         remove_a2dp_tests();
> +       remove_avrcp_tests();
>         remove_hdp_tests();
>         remove_pan_tests();
>  }
> @@ -2171,6 +2235,13 @@ static void add_a2dp_tests(void *data, void *user_data)
>         test(tc, setup_a2dp, generic_test_function, teardown);
>  }
>
> +static void add_avrcp_tests(void *data, void *user_data)
> +{
> +       struct test_case *tc = data;
> +
> +       test(tc, setup_avrcp, generic_test_function, teardown);
> +}
> +
>  static void add_gatt_tests(void *data, void *user_data)
>  {
>         struct test_case *tc = data;
> @@ -2190,6 +2261,7 @@ int main(int argc, char *argv[])
>         queue_foreach(get_pan_tests(), add_pan_tests, NULL);
>         queue_foreach(get_hdp_tests(), add_hdp_tests, NULL);
>         queue_foreach(get_a2dp_tests(), add_a2dp_tests, NULL);
> +       queue_foreach(get_avrcp_tests(), add_avrcp_tests, NULL);
>         queue_foreach(get_gatt_tests(), add_gatt_tests, NULL);
>
>         if (tester_run())
> diff --git a/android/tester-main.h b/android/tester-main.h
> index 46aacce..6cad803 100644
> --- a/android/tester-main.h
> +++ b/android/tester-main.h
> @@ -50,6 +50,7 @@
>  #include <hardware/bt_pan.h>
>  #include <hardware/bt_hl.h>
>  #include <hardware/bt_av.h>
> +#include <hardware/bt_rc.h>
>  #include <hardware/bt_gatt.h>
>  #include <hardware/bt_gatt_client.h>
>  #include <hardware/bt_gatt_server.h>
> @@ -321,6 +322,7 @@ struct test_data {
>         const bthl_interface_t *if_hdp;
>         const btav_interface_t *if_a2dp;
>         struct audio_stream_out *if_stream;
> +       const btrc_interface_t *if_avrcp;
>         const btgatt_interface_t *if_gatt;
>
>         const void *test_data;
> @@ -443,6 +445,8 @@ struct queue *get_hdp_tests(void);
>  void remove_hdp_tests(void);
>  struct queue *get_a2dp_tests(void);
>  void remove_a2dp_tests(void);
> +struct queue *get_avrcp_tests(void);
> +void remove_avrcp_tests(void);
>  struct queue *get_gatt_tests(void);
>  void remove_gatt_tests(void);
>
> --
> 1.9.3

Pushed.


-- 
Luiz Augusto von Dentz
