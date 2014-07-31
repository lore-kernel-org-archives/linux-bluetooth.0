Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1406632365-21136-1-git-send-email-luiz.dentz@gmail.com>
References: <1406632365-21136-1-git-send-email-luiz.dentz@gmail.com>
Date: Thu, 31 Jul 2014 11:18:30 +0300
Message-ID: <CABBYNZKPWa0OEdSvq9y_HDW4dzPWTDmq_F1ViM2QyrDR5b1aqw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] android/hog: Cache report value
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jul 29, 2014 at 2:12 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Report value will be used for implementing support for UHID_FEATURE
> event.
> ---
>  android/hog.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/android/hog.c b/android/hog.c
> index ef5690c..85a6982 100644
> --- a/android/hog.c
> +++ b/android/hog.c
> @@ -105,6 +105,8 @@ struct report {
>         uint16_t                ccc_handle;
>         guint                   notifyid;
>         struct gatt_char        *decl;
> +       uint16_t                len;
> +       uint8_t                 *value;
>  };
>
>  static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
> @@ -290,8 +292,18 @@ static void discover_report(GAttrib *attrib, uint16_t start, uint16_t end,
>  static void report_read_cb(guint8 status, const guint8 *pdu, guint16 len,
>                                                         gpointer user_data)
>  {
> -       if (status != 0)
> +       struct report *report = user_data;
> +
> +       if (status != 0) {
>                 error("Error reading Report value: %s", att_ecode2str(status));
> +               return;
> +       }
> +
> +       if (report->value)
> +               g_free(report->value);
> +
> +       report->value = g_memdup(pdu, len);
> +       report->len = len;
>  }
>
>  static struct report *report_new(struct bt_hog *hog, struct gatt_char *chr)
> @@ -690,6 +702,7 @@ static void report_free(void *data)
>  {
>         struct report *report = data;
>
> +       g_free(report->value);
>         g_free(report->decl);
>         g_free(report);
>  }
> --
> 1.9.3

Applied.


-- 
Luiz Augusto von Dentz
