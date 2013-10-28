Return-Path: <cyrus@holtmann.org>
Date: Mon, 28 Oct 2013 15:23:54 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/5] android: Add and remove uuids in mgmt interface
Message-ID: <20131028132354.GA13148@x220.p-661hnu-f1>
References: <1382963409-1012-1-git-send-email-marcin.kraglak@tieto.com>
 <1382963409-1012-5-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382963409-1012-5-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Mon, Oct 28, 2013, Marcin Kraglak wrote:
> +static int uuid_cmp(const void *a, const void *b)
> +{
> +	const sdp_record_t *rec = a;
> +	const uuid_t *uuid = b;
> +
> +	return sdp_uuid_cmp(&rec->svclass, uuid);
> +}
> +
> +static void uuid_to_uuid128(uuid_t *uuid128, const uuid_t *uuid)
> +{
> +	if (uuid->type == SDP_UUID16)
> +		sdp_uuid16_to_uuid128(uuid128, uuid);
> +	else if (uuid->type == SDP_UUID32)
> +		sdp_uuid32_to_uuid128(uuid128, uuid);
> +	else
> +		memcpy(uuid128, uuid, sizeof(*uuid));
> +}
> +
> +static uint8_t get_uuid_mask(const uuid_t *uuid)
> +{
> +	if (uuid->type != SDP_UUID16)
> +		return 0;
> +
> +	switch (uuid->value.uuid16) {
> +	case DIALUP_NET_SVCLASS_ID:
> +	case CIP_SVCLASS_ID:
> +		return 0x42;    /* Telephony & Networking */
> +	case IRMC_SYNC_SVCLASS_ID:
> +	case OBEX_OBJPUSH_SVCLASS_ID:
> +	case OBEX_FILETRANS_SVCLASS_ID:
> +	case IRMC_SYNC_CMD_SVCLASS_ID:
> +	case PBAP_PSE_SVCLASS_ID:
> +		return 0x10;    /* Object Transfer */
> +	case HEADSET_SVCLASS_ID:
> +	case HANDSFREE_SVCLASS_ID:
> +		return 0x20;    /* Audio */
> +	case CORDLESS_TELEPHONY_SVCLASS_ID:
> +	case INTERCOM_SVCLASS_ID:
> +	case FAX_SVCLASS_ID:
> +	case SAP_SVCLASS_ID:
> +	/*
> +	* Setting the telephony bit for the handsfree audio gateway
> +	* role is not required by the HFP specification, but the
> +	* Nokia 616 carkit is just plain broken! It will refuse
> +	* pairing without this bit set.
> +	*/
> +	case HANDSFREE_AGW_SVCLASS_ID:
> +		return 0x40;    /* Telephony */
> +	case AUDIO_SOURCE_SVCLASS_ID:
> +	case VIDEO_SOURCE_SVCLASS_ID:
> +		return 0x08;    /* Capturing */
> +	case AUDIO_SINK_SVCLASS_ID:
> +	case VIDEO_SINK_SVCLASS_ID:
> +		return 0x04;    /* Rendering */
> +	case PANU_SVCLASS_ID:
> +	case NAP_SVCLASS_ID:
> +	case GN_SVCLASS_ID:
> +		return 0x02;    /* Networking */
> +	default:
> +		return 0;
> +	}
> +}

I don't think it makes sense to duplicate this code in bluez.git,
especially not the last function. Instead, I think it should be
refactored to the appropriate common place (lib/sdp.c maybe? Or maybe
not if we don't want to pollute the already deprecated libbluetooth - in
which case I'd expect a proposal where to put this).

> +static int add_uuid(uuid_t *uuid, uint8_t svc_hint)
> +{
> +	struct mgmt_cp_add_uuid cp;
> +	uuid_t uuid128;
> +	uint128_t uint128;
> +
> +	uuid_to_uuid128(&uuid128, uuid);
> +
> +	ntoh128((uint128_t *) uuid128.value.uuid128.data, &uint128);
> +	htob128(&uint128, (uint128_t *) cp.uuid);
> +	cp.svc_hint = svc_hint;
> +
> +	if (mgmt_send(adapter->mgmt, MGMT_OP_ADD_UUID,
> +			0, sizeof(cp), &cp,
> +			add_uuid_complete, adapter, NULL) > 0)
> +		return 0;

Since you're skipping the "is_supported_uuid" check that we're doing in
the normal bluetoothd I suppose we at least have a proper check for a
minimum mgmt version when initializing the android bluetoothd? Otherwise
your patch is broken.

Johan
