Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] [Bluetooth 4.1][32bit-UUID Support] Added support for 32 bit uuid for the Attribute type in ATT and GATT 		 for GATT Client devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1396877011-30322-1-git-send-email-b.sudha@samsung.com>
Date: Tue, 8 Apr 2014 07:16:02 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <3A962E06-FA21-41BF-B7DC-E776EE0693D3@holtmann.org>
References: <1396877011-30322-1-git-send-email-b.sudha@samsung.com>
To: Sudha Bheemanna <b.sudha@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sudha,

> 1> As per 4.0 spec support for only 16 and 128 bit support was provided for attribute type in GATT.
> 2> As a part of core 4.1 spec, 32 bit uuid support is also added. The code changes for the same
>   in ATT and GATT is added as a part of this patch for GATT client role.
> ---
> attrib/att.c  |   12 ++++++++++++
> attrib/gatt.c |   11 +++++++++++
> 2 files changed, 23 insertions(+)
> 
> diff --git a/attrib/att.c b/attrib/att.c
> index 8e9c06d..2225255 100644
> --- a/attrib/att.c
> +++ b/attrib/att.c
> @@ -42,6 +42,8 @@ static inline void put_uuid_le(const bt_uuid_t *src, void *dst)
> {
> 	if (src->type == BT_UUID16)
> 		put_le16(src->value.u16, dst);
> +	else if (src->type == BT_UUID32)
> +		put_le32(src->value.u32, dst);

I have no idea when this would ever happen. The wire protocol of ATT does not support 32-bit UUIDs and they all need to be converted into 128-bit UUIDs.

> 	else
> 		/* Convert from 128-bit BE to LE */
> 		bswap_128(&src->value.u128, dst);
> @@ -134,6 +136,8 @@ static void get_uuid(uint8_t type, const void *val, bt_uuid_t *uuid)
> {
> 	if (type == BT_UUID16)
> 		bt_uuid16_create(uuid, get_le16(val));
> +	else if (type == BT_UUID32)
> +		bt_uuid32_create(uuid, get_le32(val));

Same here. There will be no 32-bit UUID coming from the wire.

> 	else {
> 		uint128_t u128;
> 
> @@ -153,6 +157,8 @@ uint16_t enc_read_by_grp_req(uint16_t start, uint16_t end, bt_uuid_t *uuid,
> 
> 	if (uuid->type == BT_UUID16)
> 		uuid_len = 2;
> +	else if (uuid->type == BT_UUID32)
> +		uuid_len = 4;

This is not valid. It needs to be convert to a 128-bit UUID.

> 	else if (uuid->type == BT_UUID128)
> 		uuid_len = 16;
> 	else
> @@ -187,6 +193,8 @@ uint16_t dec_read_by_grp_req(const uint8_t *pdu, size_t len, uint16_t *start,
> 
> 	if (len == (min_len + 2))
> 		type = BT_UUID16;
> +	else if (len == (min_len + 4))
> +		type = BT_UUID32;

Same here, no 32-bit UUID on the wire, they will all be 128-bit.

> 	else if (len == (min_len + 16))
> 		type = BT_UUID128;
> 	else
> @@ -398,6 +406,8 @@ uint16_t enc_read_by_type_req(uint16_t start, uint16_t end, bt_uuid_t *uuid,
> 
> 	if (uuid->type == BT_UUID16)
> 		uuid_len = 2;
> +	else if (uuid->type == BT_UUID32)
> +		uuid_len = 4;
> 	else if (uuid->type == BT_UUID128)
> 		uuid_len = 16;
> 	else
> @@ -429,6 +439,8 @@ uint16_t dec_read_by_type_req(const uint8_t *pdu, size_t len, uint16_t *start,
> 
> 	if (len == (min_len + 2))
> 		type = BT_UUID16;
> +	if (len == (min_len + 4))
> +		type = BT_UUID32;

These two as well, I do not see a reference in the spec. that you can encode or decode 32-bit sized UUID in the wire protocol.

> 	else if (len == (min_len + 16))
> 		type = BT_UUID128;
> 	else
> diff --git a/attrib/gatt.c b/attrib/gatt.c
> index 49cd1a3..bb2330a 100644
> --- a/attrib/gatt.c
> +++ b/attrib/gatt.c
> @@ -143,6 +143,8 @@ static void put_uuid_le(const bt_uuid_t *uuid, void *dst)
> {
> 	if (uuid->type == BT_UUID16)
> 		put_le16(uuid->value.u16, dst);
> +	else if (uuid->type == BT_UUID32)
> +		put_le32(uuid->value.u32, dst);
> 	else
> 		/* Convert from 128-bit BE to LE */
> 		bswap_128(&uuid->value.u128, dst);
> @@ -155,6 +157,11 @@ static void get_uuid128(uint8_t type, const void *val, bt_uuid_t *uuid)
> 
> 		bt_uuid16_create(&uuid16, get_le16(val));
> 		bt_uuid_to_uuid128(&uuid16, uuid);
> +	} else if (type == BT_UUID32) {
> +		bt_uuid_t uuid32;
> +
> +		bt_uuid32_create(&uuid32, get_le32(val));
> +		bt_uuid_to_uuid128(&uuid32, uuid);
> 	} else {
> 		uint128_t u128;
> 
> @@ -256,6 +263,8 @@ static void primary_all_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
> 
> 	if (list->len == 6)
> 		type = BT_UUID16;
> +	else if (list->len == 8)
> +		type = BT_UUID32;
> 	else if (list->len == 20)
> 		type = BT_UUID128;
> 	else {
> @@ -519,6 +528,8 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
> 
> 	if (list->len == 7)
> 		type = BT_UUID16;
> +	else if (list->len == 9)
> +		type = BT_UUID32;
> 	else
> 		type = BT_UUID128;

I just do not see how this patch is correct at all. I am reading the Bluetooth 4.1 spec and the 32-bit UUID is not part of the wire protocol. It is an internal representation that always needs to be converted into a 128-bit before it goes over the wire. Which makes sense since otherwise GATT from Bluetooth 4.1 would not be backwards compatible with Bluetooth 4.0 specification.

Regards

Marcel

