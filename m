Return-Path: <cyrus@holtmann.org>
Date: Tue, 9 Oct 2012 14:22:26 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC BlueZ 3/5] hog: Use the per handle GATT event notifier
Message-ID: <20121009172226.GB2148@samus>
References: <1349742372-18420-1-git-send-email-vinicius.gomes@openbossa.org>
 <1349742372-18420-4-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349742372-18420-4-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 21:26 Mon 08 Oct, Vinicius Costa Gomes wrote:
> ---
>  profiles/input/hog_device.c | 66 ++++++++++++++++++++++++---------------------
>  1 file changed, 36 insertions(+), 30 deletions(-)
> 
> diff --git a/profiles/input/hog_device.c b/profiles/input/hog_device.c
> index 52ebd95..34f4a41 100644
> --- a/profiles/input/hog_device.c
> +++ b/profiles/input/hog_device.c
> @@ -154,22 +134,31 @@ static void report_value_cb(const uint8_t *pdu, uint16_t len,
>  static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
>  					guint16 plen, gpointer user_data)
>  {
> +	struct report *report = user_data;
> +	struct hog_device *hogdev = report->hogdev;
> +
>  	if (status != 0) {
>  		error("Write report characteristic descriptor failed: %s",
>  							att_ecode2str(status));
>  		return;
>  	}
>  
> +	report->notifyid = g_attrib_register(hogdev->attrib,
> +					ATT_OP_HANDLE_NOTIFY,
> +					report->decl->value_handle,
> +					report_value_cb, report, NULL);
> +
>  	DBG("Report characteristic descriptor written: notifications enabled");
>  }
>  
>  static void write_ccc(uint16_t handle, gpointer user_data)
>  {
> -	struct hog_device *hogdev = user_data;
> +	struct report *report = user_data;
> +	struct hog_device *hogdev = report->hogdev;
>  	uint8_t value[] = { 0x01, 0x00 };
>  
>  	gatt_write_char(hogdev->attrib, handle, value, sizeof(value),
> -					report_ccc_written_cb, hogdev);
> +					report_ccc_written_cb, report);
>  }

There's a bug in this patch. So please consider it just as a proof of
concept.


Cheers,
-- 
Vinicius
