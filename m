Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1392805549-28152-11-git-send-email-jakub.tyszkowski@tieto.com>
References: <1392805549-28152-1-git-send-email-jakub.tyszkowski@tieto.com>
	<1392805549-28152-11-git-send-email-jakub.tyszkowski@tieto.com>
Date: Wed, 19 Feb 2014 07:50:53 -0400
Message-ID: <CAJdJm_M4KmZu-mTTNQhGwC=wL4FC3LRO3g7iBKV34N1hik0CSg@mail.gmail.com>
Subject: Re: [RFC 10/11] android/tester: Execute hh report cbacks in main loop
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wed, Feb 19, 2014 at 6:25 AM, Jakub Tyszkowski
<jakub.tyszkowski@tieto.com> wrote:
> Execute HIDHost generic get_report_cb in tester's main loop.
> ---
>  android/android-tester.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/android/android-tester.c b/android/android-tester.c
> index 1e1d9aa..2bf897d 100644
> --- a/android/android-tester.c
> +++ b/android/android-tester.c
> @@ -129,6 +129,7 @@ struct generic_cb_data {
>
>         bthh_hid_info_t hid_info;
>         bthh_protocol_mode_t mode;
> +       uint8_t report;
>  };
>
>  static char exec_dir[PATH_MAX + 1];
> @@ -3311,17 +3312,33 @@ static void hidhost_protocol_mode_cb(bt_bdaddr_t *bd_addr,
>         g_idle_add(hidhost_protocol_mode, cb_data);
>  }
>
> -static void hidhost_get_report_cb(bt_bdaddr_t *bd_addr, bthh_status_t status,
> -                                               uint8_t *report, int size)
> +static gboolean hidhost_get_report(gpointer user_data)
>  {
>         struct test_data *data = tester_get_data();
>         const struct hidhost_generic_data *test = data->test_data;
> +       struct generic_cb_data *cb_data = user_data;
>
>         data->cb_count++;
>
>         if (test && test->expected_hal_cb.get_report_cb)
> -               test->expected_hal_cb.get_report_cb(bd_addr, status, report,
> -                                                                       size);
> +               test->expected_hal_cb.get_report_cb(&cb_data->bdaddr,
> +                       cb_data->status, &cb_data->report, cb_data->num);
> +
> +       g_free(cb_data);
> +       return FALSE;
> +}
> +
> +static void hidhost_get_report_cb(bt_bdaddr_t *bd_addr, bthh_status_t status,
> +                                               uint8_t *report, int size)
> +{
> +       struct generic_cb_data *cb_data = g_new0(struct generic_cb_data, 1);
> +
> +       cb_data->bdaddr = *bd_addr;
> +       cb_data->status = status;
> +       cb_data->report = *report;
> +       cb_data->num = size;

Shouldn't cb_data->report be an array allocated with g_memdup()?

> +
> +       g_idle_add(hidhost_get_report, cb_data);
>  }

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil
