Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20150430214001.50CB1220C1B@puck.mtv.corp.google.com>
References: <20150430214001.50CB1220C1B@puck.mtv.corp.google.com>
Date: Thu, 30 Apr 2015 18:53:05 -0700
Message-ID: <CAHrH25R6EhPE=p2xtyE4rBoc4pYjo4MGaP_kXfDihAkt2ZZTLQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] hog: rework HoG report notifications enable
From: Arman Uguray <armansito@chromium.org>
To: Petri Gynther <pgynther@google.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Petri,

> On Thu, Apr 30, 2015 at 2:40 PM, Petri Gynther <pgynther@google.com> wrote:
> 1. Store HoG report CCC handle in the report data structure, so that
>    it can be used when needed.
> 2. Rename write_ccc() to enable_report_notifications().
> 3. In enable_report_notifications():
>    - first register the callback for HoG report notifications
>    - then enable the notifications on the HoG device
> 4. In report_ccc_written_cb():
>    - improve the emitted messages
> ---
>  profiles/input/hog.c | 39 +++++++++++++++++++++++++--------------
>  1 file changed, 25 insertions(+), 14 deletions(-)
>
> diff --git a/profiles/input/hog.c b/profiles/input/hog.c
> index 3d23d5b..5661e39 100644
> --- a/profiles/input/hog.c
> +++ b/profiles/input/hog.c
> @@ -98,6 +98,7 @@ struct hog_device {
>  struct report {
>         uint8_t                 id;
>         uint8_t                 type;
> +       uint16_t                ccc_handle;
>         guint                   notifyid;
>         struct gatt_char        *decl;
>         struct hog_device       *hogdev;
> @@ -150,30 +151,39 @@ static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
>                                         guint16 plen, gpointer user_data)
>  {
>         struct report *report = user_data;
> -       struct hog_device *hogdev = report->hogdev;
>
>         if (status != 0) {
> -               error("Write report characteristic descriptor failed: %s",
> -                                                       att_ecode2str(status));
> +               error("Report 0x%04x CCC write failed: %s",
> +                               report->decl->handle, att_ecode2str(status));
>                 return;
>         }
>
> +       DBG("Report 0x%04x CCC written: notifications enabled",
> +                                                       report->decl->handle);
> +}
> +
> +static void enable_report_notifications(struct report *report,
> +                                                       bool enable_on_device)
> +{
> +       struct hog_device *hogdev = report->hogdev;
> +       uint8_t value[2];
> +
> +       if (!report->ccc_handle)
> +               return;
> +
> +       /* Register callback for HoG report notifications */
>         report->notifyid = g_attrib_register(hogdev->attrib,
>                                         ATT_OP_HANDLE_NOTIFY,
>                                         report->decl->value_handle,
>                                         report_value_cb, report, NULL);
>
> -       DBG("Report characteristic descriptor written: notifications enabled");
> -}
> -
> -static void write_ccc(uint16_t handle, gpointer user_data)
> -{
> -       struct report *report = user_data;
> -       struct hog_device *hogdev = report->hogdev;
> -       uint8_t value[] = { 0x01, 0x00 };
> +       if (!enable_on_device)
> +               return;
>
> -       gatt_write_char(hogdev->attrib, handle, value, sizeof(value),
> -                                       report_ccc_written_cb, report);
> +       /* Enable HoG report notifications on the HoG device */
> +       put_le16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
> +       gatt_write_char(hogdev->attrib, report->ccc_handle, value,
> +                               sizeof(value), report_ccc_written_cb, report);
>  }
>
>  static void report_reference_cb(guint8 status, const guint8 *pdu,
> @@ -220,7 +230,8 @@ static void discover_descriptor_cb(uint8_t status, GSList *descs,
>                 switch (desc->uuid16) {
>                 case GATT_CLIENT_CHARAC_CFG_UUID:
>                         report = user_data;
> -                       write_ccc(desc->handle, report);
> +                       report->ccc_handle = desc->handle;
> +                       enable_report_notifications(report, true);
>                         break;
>                 case GATT_REPORT_REFERENCE:
>                         report = user_data;
> --
> 2.2.0.rc0.207.ga3a616c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

I've tested and applied all 3 patches in this set.

Thanks,
Arman
