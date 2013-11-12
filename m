Return-Path: <cyrus@holtmann.org>
Date: Tue, 12 Nov 2013 15:24:25 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: Re: [PATCH v2 1/5] android: Add and remove sdp records and uuids
Message-ID: <20131112132425.GC22931@x220.p-661hnu-f1>
References: <1384257985-26319-1-git-send-email-szymon.janc@tieto.com>
 <1384257985-26319-2-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384257985-26319-2-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Nov 12, 2013, Szymon Janc wrote:
> +static void add_uuid(uint8_t svc_hint, uint128_t *uuid)
> +{
> +	struct mgmt_cp_add_uuid cp;
> +
> +	htob128(uuid, (uint128_t *) cp.uuid);
> +	cp.svc_hint = svc_hint;
> +
> +	mgmt_send(adapter->mgmt, MGMT_OP_ADD_UUID,
> +				adapter->index, sizeof(cp), &cp,
> +				add_uuid_complete, NULL, NULL);
> +}
> +
> +int bt_adapter_add_record(uint16_t uuid, sdp_record_t *rec, uint8_t svc_hint)

Is it really so that we can't infer the UUID by looking inside
sdp_record_t? (e.g. just use rec->svclass).

> +{
> +	uint128_t uint128;
> +
> +	if (g_slist_find(adapter->uuids, GUINT_TO_POINTER(uuid))) {
> +		DBG("UUID 0x%x already added", uuid);
> +		return -1;
> +	}

Shouldn't this be return -EALREADY?

> +	adapter->uuids = g_slist_prepend(adapter->uuids,
> +						GUINT_TO_POINTER(uuid));
> +
> +	uuid16_to_uint128(uuid, &uint128);
> +
> +	add_uuid(svc_hint, &uint128);

If we only support adding UUID-16, then how about just providing
uint16_t to add/remove_uuid and do the conversion inside these
functions?

> +void bt_adapter_remove_record(uint16_t uuid, int handle)

The type that sdp_record_t uses for the handle is uint32_t so the
parameter here should reflect that.

Johan
