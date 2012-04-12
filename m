Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Apr 2012 12:51:11 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jefferson Delfes <jefferson.delfes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] GATT: Add support for find included services
Message-ID: <20120412095111.GA8925@x220.ger.corp.intel.com>
References: <1333572353-10332-1-git-send-email-jefferson.delfes@openbossa.org>
 <1333572353-10332-2-git-send-email-jefferson.delfes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333572353-10332-2-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jefferson,

On Wed, Apr 04, 2012, Jefferson Delfes wrote:
> Some services like HID over LE can reference another service using
> included services.
> 
> See Vol 3, Part G, section 2.6.3 of Core specification for more
> details.
> ---
>  attrib/gatt.c |  173 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  attrib/gatt.h |    9 +++
>  2 files changed, 182 insertions(+)
> 
> diff --git a/attrib/gatt.c b/attrib/gatt.c
> index 1c3ff78..3802200 100644
> --- a/attrib/gatt.c
> +++ b/attrib/gatt.c
> @@ -47,6 +47,22 @@ struct discover_primary {
>  	void *user_data;
>  };
>  
> +struct find_included {
> +	GAttrib *attrib;
> +	uint16_t end;
> +	GSList *includes;
> +	gatt_cb_t cb;
> +	uint16_t n_uuid_missing;
> +	gboolean final;
> +	unsigned int err;
> +	void *user_data;
> +};

Could you try to make this struct a bit more readable, e.g. use tabs to
align the variable names and group related things together (like cb and
user_data). I think uuids_missing or missing_uuids would be better than
n_uuid_missing.

> +static size_t encode_find_included(uint16_t start, uint16_t end,
> +					uint8_t *pdu, size_t len)
> +{
> +	bt_uuid_t uuid;
> +	
> +	bt_uuid16_create(&uuid, GATT_INCLUDE_UUID);

The empty line above is not actually empty but adds an unnecessary tab.
Please fix.

> +static void included_cb(uint8_t status, const uint8_t *pdu, uint16_t len,
> +							gpointer user_data)
> +{
> +	struct find_included *fi = user_data;
> +	struct att_data_list *list;
> +	unsigned int i;
> +	uint16_t last_handle = fi->end;
> +
> +	if (status) {
> +		if (status != ATT_ECODE_ATTR_NOT_FOUND)
> +			fi->err = status;
> +		fi->final = TRUE;
> +		goto done;
> +	}
> +
> +	list = dec_read_by_type_resp(pdu, len);
> +	if (list == NULL) {
> +		fi->err = ATT_ECODE_IO;
> +		fi->final = TRUE;
> +		goto done;
> +	}
> +
> +	for (i = 0; i < list->num; i++) {
> +		const uint8_t *data = list->data[i];
> +		struct gatt_included *include;
> +		
> +		/* Skipping invalid data */

The above empty line is not actually empty but adds two unnecessary
tabs. Please fix.

> +		if (list->len != 6 && list->len != 8)
> +			continue;

The value of list->len doesn't change anywhere inside this for loop so
it doesn't make sense to keep checking for it at every iteration.
Instead it seems like the right place to check for it is before entering
the for loop.

> +
> +		include = g_new0(struct gatt_included, 1);
> +		include->handle = att_get_u16(&data[0]);
> +		include->range.start = att_get_u16(&data[2]);
> +		include->range.end = att_get_u16(&data[4]);
> +		fi->includes = g_slist_append(fi->includes, include);
> +
> +		if (list->len == 8) {
> +			bt_uuid_t uuid128;
> +			bt_uuid_t uuid16 = att_get_uuid16(&data[6]);
> +			bt_uuid_to_uuid128(&uuid16, &uuid128);
> +			bt_uuid_to_string(&uuid128, include->uuid,
> +						sizeof(include->uuid));
> +		} else {
> +			uint8_t *buf;
> +			int buflen;
> +			uint16_t plen;
> +			struct find_include_data *fid =
> +					g_new0(struct find_include_data, 1);
> +			fid->find_incl = fi;
> +			fid->gatt_incl = include;
> +
> +			/* 128-bit UUID, we need to "resolve" it */
> +			buf = g_attrib_get_buffer(fi->attrib, &buflen);
> +			plen = enc_read_req(include->range.start, buf, buflen);
> +			fi->n_uuid_missing++;
> +			g_attrib_send(fi->attrib, 0, buf[0], buf,
> +						plen, find_included_helper,
> +						fid, NULL);
> +		}
> +
> +		last_handle = include->handle;
> +	}
> +
> +	att_data_list_free(list);
> +
> +	if (last_handle != fi->end) {
> +		int buflen = 0;
> +		uint8_t *buf = g_attrib_get_buffer(fi->attrib, &buflen);
> +		size_t oplen = encode_find_included(last_handle + 1,
> +							fi->end, buf, buflen);
> +
> +		g_attrib_send(fi->attrib, 0, buf[0], buf, oplen,
> +					included_cb, fi, NULL);
> +	} else
> +		fi->final = TRUE;
> +
> +done:
> +	if (fi->final && fi->n_uuid_missing == 0) {
> +		fi->cb(fi->includes, fi->err, fi->user_data);
> +		find_included_free(fi);
> +	}
> +}

This whole function is too long. See if you can refactor it somehow.

> +unsigned int gatt_find_included(GAttrib *attrib, uint16_t start, uint16_t end,
> +				gatt_cb_t func, gpointer user_data)
> +{
> +	struct find_included *fi;
> +	int buflen;
> +	uint8_t *buf = g_attrib_get_buffer(attrib, &buflen);
> +	size_t plen;
> +
> +	plen = encode_find_included(start, end, buf, buflen);
> +	if (plen == 0)
> +		return 0;
> +
> +	fi = g_new0(struct find_included, 1);
> +	fi->attrib = g_attrib_ref(attrib);
> +	fi->end = end;
> +	fi->cb = func;
> +	fi->user_data = user_data;
> +
> +	return g_attrib_send(attrib, 0, buf[0], buf, plen, included_cb,
> +					fi, NULL);

Looks like the above line is not appropriately indented. Please indent
as much as possible while staying under 80 chars.

Johan
