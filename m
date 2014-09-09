Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1409922002-30751-1-git-send-email-marcin.kraglak@tieto.com>
References: <1409922002-30751-1-git-send-email-marcin.kraglak@tieto.com>
Date: Tue, 9 Sep 2014 13:03:25 +0300
Message-ID: <CABBYNZLGUqXOO9xyTMc=kzo2oiWPk_1GaC8B-dg6JFrh_6cMdA@mail.gmail.com>
Subject: Re: [PATCHv3 1/2] android/tester: Simplify setup procedure
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Fri, Sep 5, 2014 at 4:00 PM, Marcin Kraglak <marcin.kraglak@tieto.com> wrote:
> Every profile test case must initialize bluetooth profile and start
> bluetoothd, and it is now done in setup_generic(). Additionally
> each profile can define its own init routine, which will be
> called after initializing stack.
> ---
>  android/tester-main.c | 220 ++++++++++++--------------------------------------
>  android/tester-main.h |   1 +
>  2 files changed, 53 insertions(+), 168 deletions(-)
>
> diff --git a/android/tester-main.c b/android/tester-main.c
> index 297aadb..7e8621a 100644
> --- a/android/tester-main.c
> +++ b/android/tester-main.c
> @@ -1336,7 +1336,7 @@ static bool setup_base(struct test_data *data)
>         return true;
>  }
>
> -static void setup(const void *test_data)
> +static void setup_generic(const void *test_data)
>  {
>         struct test_data *data = tester_get_data();
>         bt_status_t status;
> @@ -1353,210 +1353,117 @@ static void setup(const void *test_data)
>                 return;
>         }
>
> -       tester_setup_complete();
> +       if (!data->init_routine || data->init_routine() == BT_STATUS_SUCCESS)
> +               tester_setup_complete();
> +       else
> +               tester_setup_failed();
>  }
>
> -static void setup_socket(const void *test_data)
> +static int init_socket(void)
>  {
>         struct test_data *data = tester_get_data();
> -       bt_status_t status;
>         const void *sock;
>
> -       if (!setup_base(data)) {
> -               tester_setup_failed();
> -               return;
> -       }
> -
> -       status = data->if_bluetooth->init(&bt_callbacks);
> -       if (status != BT_STATUS_SUCCESS) {
> -               data->if_bluetooth = NULL;
> -               tester_setup_failed();
> -               return;
> -       }
> -
>         sock = data->if_bluetooth->get_profile_interface(BT_PROFILE_SOCKETS_ID);
> -       if (!sock) {
> -               tester_setup_failed();
> -               return;
> -       }
> +       if (!sock)
> +               return BT_STATUS_FAIL;
>
>         data->if_sock = sock;
>
> -       tester_setup_complete();
> +       return BT_STATUS_SUCCESS;
>  }
>
> -static void setup_hidhost(const void *test_data)
> +static int init_hidhost(void)
>  {
>         struct test_data *data = tester_get_data();
>         bt_status_t status;
>         const void *hid;
>
> -       if (!setup_base(data)) {
> -               tester_setup_failed();
> -               return;
> -       }
> -
> -       status = data->if_bluetooth->init(&bt_callbacks);
> -       if (status != BT_STATUS_SUCCESS) {
> -               data->if_bluetooth = NULL;
> -               tester_setup_failed();
> -               return;
> -       }
> -
>         hid = data->if_bluetooth->get_profile_interface(BT_PROFILE_HIDHOST_ID);
> -       if (!hid) {
> -               tester_setup_failed();
> -               return;
> -       }
> +       if (!hid)
> +               return BT_STATUS_FAIL;
>
>         data->if_hid = hid;
>
>         status = data->if_hid->init(&bthh_callbacks);
> -       if (status != BT_STATUS_SUCCESS) {
> +       if (status != BT_STATUS_SUCCESS)
>                 data->if_hid = NULL;
> -               tester_setup_failed();
> -               return;
> -       }
>
> -       tester_setup_complete();
> +       return status;
>  }
>
> -static void setup_pan(const void *test_data)
> +static int init_pan(void)
>  {
>         struct test_data *data = tester_get_data();
>         bt_status_t status;
>         const void *pan;
>
> -       if (!setup_base(data)) {
> -               tester_setup_failed();
> -               return;
> -       }
> -
> -       status = data->if_bluetooth->init(&bt_callbacks);
> -       if (status != BT_STATUS_SUCCESS) {
> -               data->if_bluetooth = NULL;
> -               tester_setup_failed();
> -               return;
> -       }
> -
>         pan = data->if_bluetooth->get_profile_interface(BT_PROFILE_PAN_ID);
> -       if (!pan) {
> -               tester_setup_failed();
> -               return;
> -       }
> +       if (!pan)
> +               return BT_STATUS_FAIL;
>
>         data->if_pan = pan;
>
>         status = data->if_pan->init(&btpan_callbacks);
> -       if (status != BT_STATUS_SUCCESS) {
> +       if (status != BT_STATUS_SUCCESS)
>                 data->if_pan = NULL;
> -               tester_setup_failed();
> -               return;
> -       }
>
> -       tester_setup_complete();
> +       return status;
>  }
>
> -static void setup_hdp(const void *test_data)
> +static int init_hdp(void)
>  {
>         struct test_data *data = tester_get_data();
>         bt_status_t status;
>         const void *hdp;
>
> -       if (!setup_base(data)) {
> -               tester_setup_failed();
> -               return;
> -       }
> -
> -       status = data->if_bluetooth->init(&bt_callbacks);
> -       if (status != BT_STATUS_SUCCESS) {
> -               data->if_bluetooth = NULL;
> -               tester_setup_failed();
> -               return;
> -       }
> -
>         hdp = data->if_bluetooth->get_profile_interface(BT_PROFILE_HEALTH_ID);
> -       if (!hdp) {
> -               tester_setup_failed();
> -               return;
> -       }
> +       if (!hdp)
> +               return BT_STATUS_FAIL;
>
>         data->if_hdp = hdp;
>
>         status = data->if_hdp->init(&bthl_callbacks);
> -       if (status != BT_STATUS_SUCCESS) {
> +       if (status != BT_STATUS_SUCCESS)
>                 data->if_hdp = NULL;
> -               tester_setup_failed();
> -               return;
> -       }
>
> -       tester_setup_complete();
> +       return status;
>  }
>
> -static void setup_a2dp(const void *test_data)
> +static int init_a2dp(void)
>  {
>         struct test_data *data = tester_get_data();
>         const bt_interface_t *if_bt;
>         bt_status_t status;
>         const void *a2dp;
>
> -       if (!setup_base(data)) {
> -               tester_setup_failed();
> -               return;
> -       }
> -
>         if_bt = data->if_bluetooth;
>
> -       status = if_bt->init(&bt_callbacks);
> -       if (status != BT_STATUS_SUCCESS) {
> -               data->if_bluetooth = NULL;
> -               tester_setup_failed();
> -               return;
> -       }
> -
>         a2dp = if_bt->get_profile_interface(BT_PROFILE_ADVANCED_AUDIO_ID);
> -       if (!a2dp) {
> -               tester_setup_failed();
> -               return;
> -       }
> +       if (!a2dp)
> +               return BT_STATUS_FAIL;
>
>         data->if_a2dp = a2dp;
>
>         status = data->if_a2dp->init(&bta2dp_callbacks);
> -       if (status != BT_STATUS_SUCCESS) {
> +       if (status != BT_STATUS_SUCCESS)
>                 data->if_a2dp = NULL;
> -               tester_setup_failed();
> -               return;
> -       }
>
> -       tester_setup_complete();
> +       return status;
>  }
>
> -static void setup_avrcp(const void *test_data)
> +static int init_avrcp(void)
>  {
>         struct test_data *data = tester_get_data();
>         const bt_interface_t *if_bt;
>         bt_status_t status;
>         const void *a2dp, *avrcp;
>
> -       if (!setup_base(data)) {
> -               tester_setup_failed();
> -               return;
> -       }
> -
>         if_bt = data->if_bluetooth;
>
> -       status = if_bt->init(&bt_callbacks);
> -       if (status != BT_STATUS_SUCCESS) {
> -               data->if_bluetooth = NULL;
> -               tester_setup_failed();
> -               return;
> -       }
> -
>         a2dp = if_bt->get_profile_interface(BT_PROFILE_ADVANCED_AUDIO_ID);
>         if (!a2dp) {
> -               tester_setup_failed();
> -               return;
> +               return BT_STATUS_FAIL;
>         }
>
>         data->if_a2dp = a2dp;
> @@ -1564,63 +1471,39 @@ static void setup_avrcp(const void *test_data)
>         status = data->if_a2dp->init(&bta2dp_callbacks);
>         if (status != BT_STATUS_SUCCESS) {
>                 data->if_a2dp = NULL;
> -               tester_setup_failed();
> -               return;
> +               return status;
>         }
>
>         avrcp = if_bt->get_profile_interface(BT_PROFILE_AV_RC_ID);
> -       if (!a2dp) {
> -               tester_setup_failed();
> -               return;
> -       }
> +       if (!a2dp)
> +               return BT_STATUS_FAIL;
>
>         data->if_avrcp = avrcp;
>
>         status = data->if_avrcp->init(&btavrcp_callbacks);
> -       if (status != BT_STATUS_SUCCESS) {
> +       if (status != BT_STATUS_SUCCESS)
>                 data->if_avrcp = NULL;
> -               tester_setup_failed();
> -               return;
> -       }
>
> -       tester_setup_complete();
> +       return status;
>  }
>
> -static void setup_gatt(const void *test_data)
> +static int init_gatt(void)
>  {
>         struct test_data *data = tester_get_data();
>         bt_status_t status;
>         const void *gatt;
>
> -       if (!setup_base(data)) {
> -               tester_setup_failed();
> -               return;
> -       }
> -
> -       status = data->if_bluetooth->init(&bt_callbacks);
> -       if (status != BT_STATUS_SUCCESS) {
> -               data->if_bluetooth = NULL;
> -               tester_setup_failed();
> -               return;
> -       }
> -
>         gatt = data->if_bluetooth->get_profile_interface(BT_PROFILE_GATT_ID);
> -       if (!gatt) {
> -               tester_setup_failed();
> -               return;
> -       }
> +       if (!gatt)
> +               return BT_STATUS_FAIL;
>
>         data->if_gatt = gatt;
>
>         status = data->if_gatt->init(&btgatt_callbacks);
> -       if (status != BT_STATUS_SUCCESS) {
> +       if (status != BT_STATUS_SUCCESS)
>                 data->if_gatt = NULL;
>
> -               tester_setup_failed();
> -               return;
> -       }
> -
> -       tester_setup_complete();
> +       return status;
>  }
>
>  static void teardown(const void *test_data)
> @@ -2174,7 +2057,7 @@ static void generic_test_function(const void *test_data)
>         first_step->action();
>  }
>
> -#define test(data, test_setup, test, test_teardown) \
> +#define test(data, init, test, test_teardown) \
>         do { \
>                 struct test_data *user; \
>                 user = g_malloc0(sizeof(struct test_data)); \
> @@ -2182,8 +2065,9 @@ static void generic_test_function(const void *test_data)
>                         break; \
>                 user->hciemu_type = data->emu_type; \
>                 user->test_data = data; \
> +               user->init_routine = init; \
>                 tester_add_full(data->title, data, test_pre_setup, \
> -                                       test_setup, test, test_teardown, \
> +                                       setup_generic, test, test_teardown, \
>                                         test_post_teardown, 3, user, g_free); \
>         } while (0)
>
> @@ -2203,56 +2087,56 @@ static void add_bluetooth_tests(void *data, void *user_data)
>  {
>         struct test_case *tc = data;
>
> -       test(tc, setup, generic_test_function, teardown);
> +       test(tc, NULL, generic_test_function, teardown);
>  }
>
>  static void add_socket_tests(void *data, void *user_data)
>  {
>         struct test_case *tc = data;
>
> -       test(tc, setup_socket, generic_test_function, teardown);
> +       test(tc, init_socket, generic_test_function, teardown);
>  }
>
>  static void add_hidhost_tests(void *data, void *user_data)
>  {
>         struct test_case *tc = data;
>
> -       test(tc, setup_hidhost, generic_test_function, teardown);
> +       test(tc, init_hidhost, generic_test_function, teardown);
>  }
>
>  static void add_pan_tests(void *data, void *user_data)
>  {
>         struct test_case *tc = data;
>
> -       test(tc, setup_pan, generic_test_function, teardown);
> +       test(tc, init_pan, generic_test_function, teardown);
>  }
>
>  static void add_hdp_tests(void *data, void *user_data)
>  {
>         struct test_case *tc = data;
>
> -       test(tc, setup_hdp, generic_test_function, teardown);
> +       test(tc, init_hdp, generic_test_function, teardown);
>  }
>
>  static void add_a2dp_tests(void *data, void *user_data)
>  {
>         struct test_case *tc = data;
>
> -       test(tc, setup_a2dp, generic_test_function, teardown);
> +       test(tc, init_a2dp, generic_test_function, teardown);
>  }
>
>  static void add_avrcp_tests(void *data, void *user_data)
>  {
>         struct test_case *tc = data;
>
> -       test(tc, setup_avrcp, generic_test_function, teardown);
> +       test(tc, init_avrcp, generic_test_function, teardown);
>  }
>
>  static void add_gatt_tests(void *data, void *user_data)
>  {
>         struct test_case *tc = data;
>
> -       test(tc, setup_gatt, generic_test_function, teardown);
> +       test(tc, init_gatt, generic_test_function, teardown);
>  }
>
>  int main(int argc, char *argv[])
> diff --git a/android/tester-main.h b/android/tester-main.h
> index 6cad803..8247c5a 100644
> --- a/android/tester-main.h
> +++ b/android/tester-main.h
> @@ -314,6 +314,7 @@ struct test_data {
>         struct hw_device_t *device;
>         struct hciemu *hciemu;
>         enum hciemu_type hciemu_type;
> +       int (*init_routine)(void);
>
>         const bt_interface_t *if_bluetooth;
>         const btsock_interface_t *if_sock;
> --
> 1.9.3

I still think the initialization is not a valid end to end test it is
a unit test since it does not communicate, therefore it does not
belong here.

-- 
Luiz Augusto von Dentz
