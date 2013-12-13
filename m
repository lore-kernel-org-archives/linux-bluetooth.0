Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1386921905-28047-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1386921905-28047-1-git-send-email-lukasz.rymanowski@tieto.com>
Date: Fri, 13 Dec 2013 11:03:58 +0200
Message-ID: <CABBYNZJ32i8RVKSHgiSEFmAGpupdwTQHnN68Opq2DZo3O8p20Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] android/tester: Add new id to hal_bluetooth_callbacks_id
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Fri, Dec 13, 2013 at 10:05 AM, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> Added adapter_prop_tod id to represents BT_PROPERTY_TYPE_OF_DEVICE
> property changed.
> ---
>  android/android-tester.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/android/android-tester.c b/android/android-tester.c
> index a50ed7b..16ddcc4 100644
> --- a/android/android-tester.c
> +++ b/android/android-tester.c
> @@ -55,6 +55,7 @@ enum hal_bluetooth_callbacks_id {
>         adapter_prop_uuids,
>         adapter_prop_cod,
>         adapter_prop_scan_mode,
> +       adapter_prop_tod,
>         adapter_prop_disc_timeout,
>         adapter_prop_service_record,
>         adapter_prop_bonded_devices
> @@ -484,7 +485,7 @@ static void adapter_properties_cb(bt_status_t status, int num_properties,
>                         remove_expected_hal_cb();
>                         break;
>                 case BT_PROPERTY_TYPE_OF_DEVICE:
> -                       if (hal_cb != adapter_prop_bdaddr) {
> +                       if (hal_cb != adapter_prop_tod) {
>                                 tester_test_failed();
>                                 return;
>                         }
> --
> 1.8.4

Too late, I already fixed it myself, but thanks anyway.


-- 
Luiz Augusto von Dentz
