Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2 01/12] android/hog: Add bt_hog_send
Date: Mon, 30 Jun 2014 18:56:42 +0200
Message-ID: <2047237.sJOmoChR6N@uw000953>
In-Reply-To: <1404137861-9313-1-git-send-email-luiz.dentz@gmail.com>
References: <1404137861-9313-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Monday 30 of June 2014 17:17:30 Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This function can be used to send data using Output Report if one is
> available.
> ---
> v2: Fix patch 02/12 to check if a hog instance exists.
> 
>  android/hog.c | 37 +++++++++++++++++++++++++++++++++++++
>  android/hog.h |  1 +
>  2 files changed, 38 insertions(+)
> 
> diff --git a/android/hog.c b/android/hog.c
> index 7e61790..5d33c63 100644
> --- a/android/hog.c
> +++ b/android/hog.c
> @@ -1009,3 +1009,40 @@ int bt_hog_set_control_point(struct bt_hog *hog, bool suspend)
>  
>  	return 0;
>  }
> +
> +int bt_hog_send(struct bt_hog *hog, void *data, size_t size)
> +{
> +	struct report *report;
> +	GSList *l;
> +
> +	if (!hog)
> +		return -EINVAL;
> +
> +	if (!hog->attrib)
> +		return -ENOTCONN;
> +
> +	l = g_slist_find_custom(hog->reports,
> +				GUINT_TO_POINTER(HOG_REPORT_TYPE_OUTPUT),
> +				report_type_cmp);
> +	if (!l)
> +		return -ENOTSUP;
> +
> +	report = l->data;
> +
> +	DBG("Sending data to handle 0x%X", report->decl->value_handle);
> +
> +	if (report->decl->properties & GATT_CHR_PROP_WRITE)
> +		gatt_write_char(hog->attrib, report->decl->value_handle,
> +				data, size, output_written_cb, hog);
> +	else if (report->decl->properties & GATT_CHR_PROP_WRITE_WITHOUT_RESP)
> +		gatt_write_cmd(hog->attrib, report->decl->value_handle,
> +						data, size, NULL, NULL);
> +
> +	for (l = hog->instances; l; l = l->next) {
> +		struct bt_hog *instance = l->data;
> +
> +		bt_hog_send(instance, data, size);
> +	}
> +
> +	return 0;
> +}
> diff --git a/android/hog.h b/android/hog.h
> index 7cf446b..4ebc83e 100644
> --- a/android/hog.h
> +++ b/android/hog.h
> @@ -33,3 +33,4 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt);
>  void bt_hog_detach(struct bt_hog *hog);
>  
>  int bt_hog_set_control_point(struct bt_hog *hog, bool suspend);
> +int bt_hog_send(struct bt_hog *hog, void *data, size_t size);
> 


I've applied patches 3-12 and updated PTS tests results. Thanks.

For first two I'm not sure yet, we would need similar code for input
and feature reports to pass PTS tests. I'll try using gattc interface
for those and see how it works out. Then we can decide.

-- 
Best regards, 
Szymon Janc
