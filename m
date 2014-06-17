Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH v4 1/4] src/shared/att: Introduce struct bt_att.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1402958640-1132-2-git-send-email-armansito@chromium.org>
Date: Tue, 17 Jun 2014 11:21:06 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <840D03B0-40A9-4596-B7AB-9DCB417BE956@holtmann.org>
References: <1402958640-1132-1-git-send-email-armansito@chromium.org> <1402958640-1132-2-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> This patch introduces struct bt_att, which handles the transport and
> encoding/decoding for the ATT protocol. The structure of the code
> follows that of src/shared/mgmt and lib/mgmt.h, where individual
> parameter structures are defined for all ATT protocol requests, responses,
> commands, indications, and notifications. The serialization and
> endianness conversion for all parameters are handled by bt_att.
> 
> struct bt_att is based around struct io and operates on a raw file
> descriptor.
> ---
> Makefile.am            |   3 +-
> src/shared/att-types.h | 222 +++++++++++++++++++++++++++++++++++++++++++++++++
> src/shared/att.c       | 182 ++++++++++++++++++++++++++++++++++++++++
> src/shared/att.h       |  73 ++++++++++++++++
> 4 files changed, 479 insertions(+), 1 deletion(-)
> create mode 100644 src/shared/att-types.h
> create mode 100644 src/shared/att.c
> create mode 100644 src/shared/att.h
> 
> diff --git a/Makefile.am b/Makefile.am
> index dc88816..d10b573 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -156,7 +156,8 @@ src_bluetoothd_SOURCES = $(builtin_sources) \
> 			src/shared/timeout.h src/shared/timeout-glib.c \
> 			src/shared/queue.h src/shared/queue.c \
> 			src/shared/util.h src/shared/util.c \
> -			src/shared/mgmt.h src/shared/mgmt.c
> +			src/shared/mgmt.h src/shared/mgmt.c \
> +			src/shared/att-types.h src/shared/att.h src/shared/att.c
> src_bluetoothd_LDADD = lib/libbluetooth-internal.la gdbus/libgdbus-internal.la \
> 			@GLIB_LIBS@ @DBUS_LIBS@ -ldl -lrt
> src_bluetoothd_LDFLAGS = $(AM_LDFLAGS) -Wl,--export-dynamic \
> diff --git a/src/shared/att-types.h b/src/shared/att-types.h
> new file mode 100644
> index 0000000..636a5e3
> --- /dev/null
> +++ b/src/shared/att-types.h
> @@ -0,0 +1,222 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2014  Google Inc.
> + *
> + *
> + *  This library is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU Lesser General Public
> + *  License as published by the Free Software Foundation; either
> + *  version 2.1 of the License, or (at your option) any later version.
> + *
> + *  This library is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  Lesser General Public License for more details.
> + *
> + *  You should have received a copy of the GNU Lesser General Public
> + *  License along with this library; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + */
> +
> +#include <stdint.h>
> +
> +/* Error response */
> +#define BT_ATT_OP_ERROR_RSP	      		0x01
> +struct bt_att_error_rsp_param {
> +	uint8_t request_opcode;
> +	uint16_t handle;
> +	uint8_t	error_code;
> +};
> +
> +/* Exchange MTU */
> +#define BT_ATT_OP_MTU_REQ			0x02
> +struct bt_att_mtu_req_param {
> +	uint16_t client_rx_mtu;
> +};
> +
> +#define BT_ATT_OP_MTU_RSP			0x03
> +struct bt_att_mtu_rsp_param {
> +	uint16_t server_rx_mtu;
> +};
> +
> +/* Find Information */
> +#define BT_ATT_OP_FIND_INFO_REQ			0x04
> +struct bt_att_find_info_req_param {
> +	uint16_t start_handle;
> +	uint16_t end_handle;
> +};
> +
> +#define BT_ATT_OP_FIND_INFO_RSP			0x05
> +struct bt_att_find_info_rsp_param {
> +	uint8_t format;
> +	const uint8_t *info_data;
> +	uint16_t length;
> +};
> +
> +/* Find By Type Value */
> +#define BT_ATT_OP_FIND_BY_TYPE_VAL_REQ		0x06
> +struct bt_att_find_by_type_value_req_param {
> +	uint16_t start_handle;
> +	uint16_t end_handle;
> +	uint16_t type;  /* 2 octet UUID */
> +	const uint8_t *value;
> +	uint16_t length;  /* MAX length: (ATT_MTU - 7) */
> +};
> +
> +#define BT_ATT_OP_FIND_BY_TYPE_VAL_RSP		0x07
> +struct bt_att_find_by_type_value_rsp_param {
> +	const uint8_t *handles_info_list;
> +	uint16_t length;
> +};
> +
> +/* Read By Type */
> +#define BT_ATT_OP_READ_BY_TYPE_REQ		0x08
> +struct bt_att_read_by_type_req_param {
> +	uint16_t start_handle;
> +	uint16_t end_handle;
> +	bt_uuid_t type;  /* 2 or 16 octet UUID */
> +};
> +
> +#define BT_ATT_OP_READ_BY_TYPE_RSP		0x09
> +struct bt_att_read_by_type_rsp_param {
> +	uint8_t length;
> +	const uint8_t *attr_data_list;
> +	uint16_t list_length;  /* Length of "attr_data_list" */
> +};
> +
> +/* Read */
> +#define BT_ATT_OP_READ_REQ			0x0a
> +struct bt_att_read_req_param {
> +	uint16_t handle;
> +};
> +
> +#define BT_ATT_OP_READ_RSP			0x0b
> +struct bt_att_read_rsp_param {
> +	const uint8_t *value;
> +	uint16_t length;
> +};
> +
> +/* Read Blob */
> +#define BT_ATT_OP_READ_BLOB_REQ			0x0c
> +struct bt_att_read_blob_req_param {
> +	uint16_t handle;
> +	uint16_t offset;
> +};
> +
> +#define BT_ATT_OP_READ_BLOB_RSP			0x0d
> +struct bt_att_read_blob_rsp_param {
> +	const uint8_t *part_value;
> +	uint16_t length;
> +};
> +
> +/* Read Multiple */
> +#define BT_ATT_OP_READ_MULT_REQ			0x0e
> +struct bt_att_read_multiple_req_param {
> +	const uint16_t *handles;
> +	uint16_t num_handles;
> +};
> +
> +#define BT_ATT_OP_READ_MULT_RSP			0x0f
> +struct bt_att_read_multiple_rsp_param {
> +	const uint8_t *values;
> +	uint16_t length;
> +};
> +
> +/* Read By Group Type */
> +#define BT_ATT_OP_READ_BY_GRP_TYPE_REQ		0x10
> +struct bt_att_read_by_group_type_req_param {
> +	uint16_t start_handle;
> +	uint16_t end_handle;
> +	bt_uuid_t type;
> +};
> +
> +#define BT_ATT_OP_READ_BY_GRP_TYPE_RSP		0x11
> +struct bt_att_read_by_group_type_rsp_param {
> +	uint8_t length;
> +	const uint8_t *attr_data_list;
> +	uint16_t list_length;  /* Length of "attr_data_list" */
> +};
> +
> +/* Write Request */
> +#define BT_ATT_OP_WRITE_REQ			0x12
> +/*
> + * bt_att_write_param is used for write request and signed and unsigned write
> + * command.
> + */
> +struct bt_att_write_param {
> +	uint16_t handle;
> +	const uint8_t *value;
> +	uint16_t length;
> +};
> +
> +#define BT_ATT_OP_WRITE_RSP			0x13  /* No parameters */
> +
> +/* Write Command */
> +#define BT_ATT_OP_WRITE_CMD			0x52
> +
> +/* Signed Write Command */
> +#define BT_ATT_OP_SIGNED_WRITE_CMD		0xD2
> +
> +/* Prepare Write */
> +#define BT_ATT_OP_PREP_WRITE_REQ		0x16
> +struct bt_att_prepare_write_req_param {
> +	uint16_t handle;
> +	uint16_t offset;
> +	const uint8_t *part_value;
> +	uint16_t length;
> +};
> +
> +#define BT_ATT_OP_PREP_WRITE_RSP		0x17
> +struct bt_att_prepare_write_rsp_param {
> +	uint16_t handle;
> +	uint16_t offset;
> +	const uint8_t *part_value;
> +	uint16_t length;
> +};
> +
> +/* Execute Write */
> +#define BT_ATT_OP_EXEC_WRITE_REQ		0x18
> +typedef enum {
> +	BT_ATT_EXEC_WRITE_FLAG_CANCEL	= 0x00,
> +	BT_ATT_EXEC_WRITE_FLAG_WRITE	= 0x01,
> +} bt_att_exec_write_flag_t;
> +
> +struct bt_att_exec_write_req_param {
> +	bt_att_exec_write_flag_t flags;
> +};
> +
> +#define BT_ATT_OP_EXEC_WRITE_RSP		0x19
> +
> +/* Handle Value Notification/Indication */
> +#define BT_ATT_OP_HANDLE_VAL_NOT		0x1B
> +#define BT_ATT_OP_HANDLE_VAL_IND		0x1D
> +struct bt_att_notify_param {
> +	uint16_t handle;
> +	const uint8_t *value;
> +	uint16_t length;
> +};
> +
> +/* Handle Value Confirmation */
> +#define BT_ATT_OP_HANDLE_VAL_CONF		0x1E
> +
> +/* Error codes for Error response PDU */
> +#define BT_ATT_ERROR_INVALID_HANDLE			0x01
> +#define BT_ATT_ERROR_READ_NOT_PERMITTED			0x02
> +#define BT_ATT_ERROR_WRITE_NOT_PERMITTED		0x03
> +#define BT_ATT_ERROR_INVALID_PDU			0x04
> +#define BT_ATT_ERROR_AUTHENTICATION			0x05
> +#define BT_ATT_ERROR_REQUEST_NOT_SUPPORTED		0x06
> +#define BT_ATT_ERROR_INVALID_OFFSET			0x07
> +#define BT_ATT_ERROR_AUTHORIZATION			0x08
> +#define BT_ATT_ERROR_PREPARE_QUEUE_FULL			0x09
> +#define BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND		0x0A
> +#define BT_ATT_ERROR_ATTRIBUTE_NOT_LONG			0x0B
> +#define BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION_KEY_SIZE	0x0C
> +#define BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN	0x0D
> +#define BT_ATT_ERROR_UNLIKELY				0x0E
> +#define BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION		0x0F
> +#define BT_ATT_ERROR_UNSUPPORTED_GROUP_TYPE		0x10
> +#define BT_ATT_ERROR_INSUFFICIENT_RESOURCES		0x11
> diff --git a/src/shared/att.c b/src/shared/att.c
> new file mode 100644
> index 0000000..fc75eb8
> --- /dev/null
> +++ b/src/shared/att.c
> @@ -0,0 +1,182 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2014  Google Inc.
> + *
> + *
> + *  This library is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU Lesser General Public
> + *  License as published by the Free Software Foundation; either
> + *  version 2.1 of the License, or (at your option) any later version.
> + *
> + *  This library is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  Lesser General Public License for more details.
> + *
> + *  You should have received a copy of the GNU Lesser General Public
> + *  License along with this library; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <unistd.h>
> +
> +#include "src/shared/io.h"
> +#include "src/shared/queue.h"
> +#include "lib/uuid.h"
> +#include "src/shared/att.h"
> +
> +#define ATT_DEFAULT_LE_MTU		23
> +#define ATT_MIN_PDU_LEN			1  /* At least 1 byte for the opcode. */
> +
> +struct att_send_op;
> +
> +struct bt_att {
> +	int ref_count;
> +	int fd;
> +	bool close_on_unref;
> +	struct io *io;
> +	bool destroyed;
> +
> +	struct queue *req_queue;	/* Queued ATT protocol requests */
> +	struct att_send_op *pending_req;
> +	struct queue *ind_queue;	/* Queued ATT protocol indications */
> +	struct att_send_op *pending_ind;
> +	struct queue *write_queue;	/* Queue of PDUs ready to send */
> +	bool writer_active;
> +
> +	/* TODO Add notify queue */
> +
> +	uint8_t *buf;
> +	uint16_t mtu;
> +
> +	uint8_t csrk[16];
> +	uint32_t local_sign_cnt;
> +	uint32_t remote_sign_cnt;
> +	bool signing_data_set;
> +
> +	unsigned int next_send_id;	/* IDs for "send" ops */
> +	unsigned int next_reg_id;	/* IDs for registered callbacks */
> +
> +	bt_att_timeout_func_t timeout_callback;
> +	bt_att_destroy_func_t timeout_destroy;
> +	void *timeout_data;
> +
> +	bt_att_debug_func_t debug_callback;
> +	bt_att_destroy_func_t debug_destroy;
> +	void *debug_data;
> +};
> +
> +struct att_send_op {
> +	unsigned int id;
> +	uint16_t opcode;
> +	void *pdu;
> +	uint16_t len;
> +	bt_att_request_func_t callback;
> +	bt_att_destroy_func_t destroy;
> +	void *user_data;
> +};
> +
> +struct bt_att *bt_att_new(int fd)
> +{
> +	/* TODO */
> +	return NULL;
> +}
> +
> +struct bt_att *bt_att_ref(struct bt_att *att)
> +{
> +	/* TODO */
> +	return NULL;
> +}
> +
> +void bt_att_unref(struct bt_att *att)
> +{
> +	/* TODO */
> +}
> +
> +bool bt_att_set_close_on_unref(struct bt_att *att, bool do_close)
> +{
> +	/* TODO */
> +	return false;
> +}
> +
> +bool bt_att_set_debug(struct bt_att *att, bt_att_debug_func_t callback,
> +				void *user_data, bt_att_destroy_func_t destroy)
> +{
> +	/* TODO */
> +	return false;
> +}
> +
> +uint16_t bt_att_get_mtu(struct bt_att *att)
> +{
> +	/* TODO */
> +	return 0;
> +}
> +
> +bool bt_att_set_mtu(struct bt_att *att, uint16_t mtu)
> +{
> +	/* TODO */
> +	return false;
> +}
> +
> +void bt_att_set_signing_data(struct bt_att *att, uint8_t csrk[16],
> +						uint32_t local_sign_cnt,
> +						uint32_t remote_sign_cnt)
> +{
> +	/* TODO */
> +}
> +
> +bool bt_att_set_timeout_cb(struct bt_att *att, bt_att_timeout_func_t callback,
> +						void *user_data,
> +						bt_att_destroy_func_t destroy)
> +{
> +	/* TODO */
> +	return false;
> +}
> +
> +unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
> +				const void *param, uint16_t length,
> +				bt_att_request_func_t callback, void *user_data,
> +				bt_att_destroy_func_t destroy)
> +{
> +	/* TODO */
> +	return 0;
> +}
> +
> +bool bt_att_cancel(struct bt_att *att, unsigned int id)
> +{
> +	/* TODO */
> +	return false;
> +}
> +
> +bool bt_att_cancel_all(struct bt_att *att)
> +{
> +	/* TODO */
> +	return false;
> +}
> +
> +unsigned int bt_att_register(struct bt_att *att, uint8_t opcode,
> +				bt_att_request_func_t callback,
> +				void *user_data, bt_att_destroy_func_t destroy)
> +{
> +	/* TODO */
> +	return 0;
> +}
> +
> +bool bt_att_unregister(struct bt_att *att, unsigned int id)
> +{
> +	/* TODO */
> +	return false;
> +}
> +
> +bool bt_att_unregister_all(struct bt_att *att)
> +{
> +	/* TODO */
> +	return false;
> +}
> diff --git a/src/shared/att.h b/src/shared/att.h
> new file mode 100644
> index 0000000..4cbe7c2
> --- /dev/null
> +++ b/src/shared/att.h
> @@ -0,0 +1,73 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2014  Google Inc.
> + *
> + *
> + *  This library is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU Lesser General Public
> + *  License as published by the Free Software Foundation; either
> + *  version 2.1 of the License, or (at your option) any later version.
> + *
> + *  This library is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  Lesser General Public License for more details.
> + *
> + *  You should have received a copy of the GNU Lesser General Public
> + *  License along with this library; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + */
> +
> +#include <stdbool.h>
> +#include <stdint.h>
> +
> +#include "src/shared/att-types.h"
> +
> +struct bt_att;
> +
> +struct bt_att *bt_att_new(int fd);
> +
> +struct bt_att *bt_att_ref(struct bt_att *att);
> +void bt_att_unref(struct bt_att *att);
> +
> +bool bt_att_set_close_on_unref(struct bt_att *att, bool do_close);
> +
> +typedef void (*bt_att_request_func_t)(uint8_t opcode, const void *param,
> +					uint16_t length, void *user_data);
> +typedef void (*bt_att_destroy_func_t)(void *user_data);
> +typedef void (*bt_att_debug_func_t)(const char *str, void *user_data);
> +typedef void (*bt_att_notify_func_t)(uint8_t opcode,
> +					const struct bt_att_notify_param *param,
> +					void *user_data);
> +typedef void (*bt_att_timeout_func_t)(unsigned int id, uint8_t opcode,
> +							void *user_data);
> +
> +bool bt_att_set_debug(struct bt_att *att, bt_att_debug_func_t callback,
> +				void *user_data, bt_att_destroy_func_t destroy);
> +
> +uint16_t bt_att_get_mtu(struct bt_att *att);
> +bool bt_att_set_mtu(struct bt_att *att, uint16_t mtu);
> +
> +void bt_att_set_signing_data(struct bt_att *att, uint8_t csrk[16],
> +						uint32_t local_sign_cnt,
> +						uint32_t remote_sign_cnt);

leave the CSRK part out for now. This is still not correct. Lets do that later since I really don't want this to hold up us merging this patchset. I think it is ready to get merged and all other fixes or extensions, can be made once this is upstream.

Just an update on the CSRK part. You will have actually two CSRK. One for signing and one for verification. You might have both, one of them, or none of them. This all depends on what the remote agrees to distribute over SMP.

So I think this needs to be bt_att_set_signing_key and bt_att_set_resolving_key. But again here, lets deal with this after this gets merged. Just something to keep in mind.

Regards

Marcel

