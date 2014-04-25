Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1397610266-20894-2-git-send-email-armansito@chromium.org>
References: <1397610266-20894-1-git-send-email-armansito@chromium.org>
	<1397610266-20894-2-git-send-email-armansito@chromium.org>
Date: Fri, 25 Apr 2014 10:42:29 -0300
Message-ID: <CAKT1EBdNeCSjc+XfQ-oA8EtYK9=yK2yBiKn=vcQuZY=gjBOHzw@mail.gmail.com>
Subject: Re: [RFC 1/2] src/shared/att: Introduce struct bt_att.
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Arman Uguray <armansito@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

Below are some comments in addition to your findings ...

Remember that incoming and outgoing queues are independent, and there
isn't "flow control" for notification, it can be sent at any time.

On Tue, Apr 15, 2014 at 10:04 PM, Arman Uguray <armansito@chromium.org> wrote:
> This patch introduces struct bt_att, which handles the transport and
> encoding/decoding for the ATT protocol. The structure of the code
> follows that of src/shared/mgmt and lib/mgmt.h, where individual
> parameter structures are defined for all ATT protocol requests, responses,
> commands, indications, and notifications. The serialization and
> endianness conversion for all parameters are handled by bt_att.
>
> struct bt_att is based around struct io and operates on a raw file
> descriptor. The initial patch implements the Exchange MTU request &
> response and the Error Response. Currently, only requests that are
> initiated locally are supported.
> ---
>  Makefile.am      |   3 +-
>  src/shared/att.c | 554 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/shared/att.h |  97 ++++++++++
>  3 files changed, 653 insertions(+), 1 deletion(-)
>  create mode 100644 src/shared/att.c
>  create mode 100644 src/shared/att.h
>
> diff --git a/Makefile.am b/Makefile.am
> index f96c700..0c3424f 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -155,7 +155,8 @@ src_bluetoothd_SOURCES = $(builtin_sources) \
>                         src/shared/timeout.h src/shared/timeout-glib.c \
>                         src/shared/queue.h src/shared/queue.c \
>                         src/shared/util.h src/shared/util.c \
> -                       src/shared/mgmt.h src/shared/mgmt.c
> +                       src/shared/mgmt.h src/shared/mgmt.c \
> +                       src/shared/att.h src/shared/att.c
>  src_bluetoothd_LDADD = lib/libbluetooth-internal.la gdbus/libgdbus-internal.la \
>                         @GLIB_LIBS@ @DBUS_LIBS@ -ldl -lrt
>  src_bluetoothd_LDFLAGS = $(AM_LDFLAGS) -Wl,--export-dynamic \
> diff --git a/src/shared/att.c b/src/shared/att.c
> new file mode 100644
> index 0000000..04b68a9
> --- /dev/null
> +++ b/src/shared/att.c
> @@ -0,0 +1,554 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2012-2014  Intel Corporation. All rights reserved.
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
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <errno.h>
> +
> +#include "src/shared/io.h"
> +#include "src/shared/queue.h"
> +#include "src/shared/util.h"
> +#include "src/shared/att.h"
> +
> +#define ATT_MAX_VALUE_LEN              512
> +#define ATT_DEFAULT_LE_MTU             23
> +
> +struct bt_att {
> +       int ref_count;
> +       int fd;
> +       bool close_on_unref;
> +       struct io *io;
> +       bool writer_active;
> +       struct queue *request_queue;
> +       struct queue *pending_list;
> +       unsigned int next_request_id;
> +       bool destroyed;
> +       void *buf;
> +       uint16_t len;
> +       bt_att_debug_func_t debug_callback;
> +       bt_att_destroy_func_t debug_destroy;
> +       void *debug_data;
> +};
> +
> +struct bt_att_request {
> +       unsigned int id;
> +       uint16_t opcode;
> +       void *pdu;
> +       uint16_t len;
> +       bt_att_request_func_t callback;
> +       bt_att_destroy_func_t destroy;
> +       void *user_data;

PDU could be declared as "uint8_t pdu[]" at the end the struct, but if
you are trying to keep it aligned with mgmt.c it should be better to
keep it as pointer.

> +};
> +
> +static void destroy_request(void *data)
> +{
> +       struct bt_att_request *request = data;
> +
> +       if (request->destroy)
> +               request->destroy(request->user_data);
> +
> +       free(request->pdu);
> +       free(request);
> +}
> +
> +static bool match_request_id(const void *a, const void *b)
> +{
> +       const struct bt_att_request *request = a;
> +       unsigned int id = PTR_TO_UINT(b);
> +
> +       return request->id == id;
> +}
> +
> +static bool match_request_opcode(const void *a, const void *b)
> +{
> +       const struct bt_att_request *request = a;
> +       const uint8_t *opcode = b;
> +
> +       return request->opcode == *opcode;
> +}
> +
> +static void write_watch_destroy(void *user_data)
> +{
> +       struct bt_att *att = user_data;
> +
> +       att->writer_active = false;
> +}
> +
> +static bool can_write_data(struct io *io, void *user_data)
> +{
> +       struct bt_att *att = user_data;
> +       struct bt_att_request *request;
> +       ssize_t bytes_written;
> +
> +       if (!queue_isempty(att->pending_list))
> +               return false;
> +
> +       request = queue_pop_head(att->request_queue);
> +       if (!request)
> +               return false;
> +
> +       bytes_written = write(att->fd, request->pdu, request->len);
> +       if (bytes_written < 0) {
> +               util_debug(att->debug_callback, att->debug_data,
> +                                       "write failed: %s", strerror(errno));
> +               if (request->callback)
> +                       request->callback(ATT_ERROR_IO, NULL, 0,
> +                                                       request->user_data);

I think ATT_ERROR_IO is BlueZ specific (internal). Please make sure if
this error is being handled properly by the caller, maybe it should
not be used at all.

> +
> +               destroy_request(request);
> +               return true;
> +       }
> +
> +       util_debug(att->debug_callback, att->debug_data,
> +                                       "ATT command 0x%02x", request->opcode);
> +
> +       util_hexdump('<', request->pdu, bytes_written,
> +                                       att->debug_callback, att->debug_data);
> +
> +       queue_push_tail(att->pending_list, request);
> +
> +       return false;
> +}
> +
> +static void wakeup_writer(struct bt_att *att)
> +{
> +       if (!queue_isempty(att->pending_list))
> +               return;
> +
> +       if (att->writer_active)
> +               return;
> +
> +       io_set_write_handler(att->io, can_write_data, att, write_watch_destroy);
> +}
> +
> +static void request_complete(struct bt_att *att, uint8_t req_opcode,
> +                                       uint8_t rsp_opcode, const void *param,
> +                                       uint16_t length)
> +{
> +       struct bt_att_request *request;
> +
> +       request = queue_remove_if(att->pending_list,
> +                                       match_request_opcode, &req_opcode);
> +
> +       if (request) {
> +               if (request->callback)
> +                       request->callback(rsp_opcode, param, length,
> +                                                       request->user_data);
> +
> +               destroy_request(request);
> +       }
> +
> +       if (att->destroyed)
> +               return;
> +
> +       wakeup_writer(att);
> +}
> +
> +static bool handle_error_rsp(struct bt_att *att, uint8_t opcode,
> +                                       const uint8_t *pdu, uint16_t pdu_length)
> +{
> +       struct bt_att_error_rsp_param param;
> +
> +       if (pdu_length != 5)
> +               return false;
> +
> +       memset(&param, 0, sizeof(param));
> +
> +       param.request_opcode = pdu[1];
> +       param.handle = get_le16(pdu + 2);
> +       param.error_code = pdu[4];
> +
> +       request_complete(att, param.request_opcode, opcode,
> +                                                       &param, sizeof(param));
> +
> +       return true;
> +}
> +
> +static bool handle_exchange_mtu_rsp(struct bt_att *att, uint8_t opcode,
> +                                       const uint8_t *pdu, uint16_t pdu_length)
> +{
> +       struct bt_att_exchange_mtu_rsp_param param;
> +
> +       if (pdu_length != 3)
> +               return false;

I noticed that length is always "1" + param. Where "1" refers to ATT opcode.

> +
> +       param.server_rx_mtu = get_le16(pdu + 1);
> +
> +       request_complete(att, ATT_OP_EXCHANGE_MTU_REQ, opcode,
> +                                                       &param, sizeof(param));
> +
> +       return true;
> +}
> +
> +static bool handle_response(struct bt_att *att, uint8_t opcode,
> +                                       const uint8_t *pdu, uint16_t pdu_length)
> +{

Is it necessary to inform the opcode? Maybe you could use pdu[0].

> +       if (opcode == ATT_OP_ERROR_RESP)
> +               return handle_error_rsp(att, opcode, pdu, pdu_length);
> +
> +       if (opcode == ATT_OP_EXCHANGE_MTU_RESP)
> +               return handle_exchange_mtu_rsp(att, opcode, pdu, pdu_length);
> +
> +       return false;
> +}
> +
> +static void read_watch_destroy(void *user_data)
> +{
> +       struct bt_att *att = user_data;
> +
> +       if (att->destroyed) {
> +               queue_destroy(att->pending_list, NULL);
> +               free(att);
> +       }
> +}
> +
> +static bool can_read_data(struct io *io, void *user_data)
> +{
> +       struct bt_att *att = user_data;
> +       uint8_t *pdu;
> +       ssize_t bytes_read;
> +       uint16_t opcode;
> +
> +       bytes_read = read(att->fd, att->buf, att->len);
> +       if (bytes_read < 0)
> +               return false;
> +
> +       util_hexdump('>', att->buf, bytes_read,
> +                                       att->debug_callback, att->debug_data);
> +
> +       if (bytes_read < 1)
> +               return true;

Why "1"? What is the smallest ATT PDU? Notification?

> +
> +       pdu = att->buf;
> +       opcode = pdu[0];
> +
> +       /* The opcode is either a response to a pending request, a new request
> +        * from a client, or a notification/indication. Handle them separately
> +        * here.
> +        */
> +       /* TODO: Handle other types of data here. */
> +       handle_response(att, opcode, pdu, bytes_read);
> +
> +       if (att->destroyed)
> +               return false;
> +
> +       return true;
> +}
> +
> +struct bt_att *bt_att_new(int fd)
> +{
> +       struct bt_att *att;
> +
> +       if (fd < 0)
> +               return NULL;
> +
> +       att = new0(struct bt_att, 1);

Missing memory allocation fail checking.

> +       att->fd = fd;
> +       att->close_on_unref = false;
> +
> +       att->len = ATT_DEFAULT_LE_MTU;
> +       att->buf = malloc(att->len);
> +       if (!att->buf) {
> +               free(att);
> +               return NULL;
> +       }
> +
> +       att->io = io_new(fd);
> +       if (!att->io) {
> +               free(att->buf);
> +               free(att);
> +               return NULL;
> +       }
> +
> +       att->request_queue = queue_new();
> +       if (!att->request_queue) {
> +               io_destroy(att->io);
> +               free(att->buf);
> +               free(att);
> +               return NULL;
> +       }
> +
> +       att->pending_list = queue_new();
> +       if (!att->pending_list) {
> +               queue_destroy(att->request_queue, NULL);
> +               free(att->buf);
> +               free(att);
> +               return NULL;
> +       }
> +
> +       if (!io_set_read_handler(att->io, can_read_data,
> +                                               att, read_watch_destroy)) {
> +               queue_destroy(att->pending_list, NULL);
> +               queue_destroy(att->request_queue, NULL);
> +               free(att->buf);
> +               free(att);
> +               return NULL;
> +       }
> +
> +       att->writer_active = false;

A label for cleanup will be more convenient.

> +
> +       return bt_att_ref(att);
> +}
> +
> +struct bt_att *bt_att_ref(struct bt_att *att)
> +{
> +       if (!att)
> +               return NULL;
> +
> +       __sync_fetch_and_add(&att->ref_count, 1);
> +
> +       return att;
> +}
> +
> +void bt_att_unref(struct bt_att *att)
> +{
> +       if (!att)
> +               return;
> +
> +       if (__sync_sub_and_fetch(&att->ref_count, 1))
> +               return;
> +
> +       bt_att_cancel_all(att);
> +
> +       queue_destroy(att->request_queue, NULL);
> +
> +       io_set_write_handler(att->io, NULL, NULL, NULL);
> +       io_set_read_handler(att->io, NULL, NULL, NULL);
> +
> +       io_destroy(att->io);
> +       att->io = NULL;
> +
> +       if (att->close_on_unref)
> +               close(att->fd);
> +
> +       if (att->debug_destroy)
> +               att->debug_destroy(att->debug_data);
> +
> +       free(att->buf);
> +       att->buf = NULL;
> +
> +       att->destroyed = true;
> +}
> +
> +bool bt_att_set_debug(struct bt_att *att, bt_att_debug_func_t callback,
> +                               void *user_data, bt_att_destroy_func_t destroy)
> +{
> +       if (!att)
> +               return false;
> +
> +       if (att->debug_destroy)
> +               att->debug_destroy(att->debug_data);
> +
> +       att->debug_callback = callback;
> +       att->debug_destroy = destroy;
> +       att->debug_data = user_data;
> +
> +       return true;
> +}
> +
> +bool bt_att_set_close_on_unref(struct bt_att *att, bool do_close)
> +{
> +       if (!att)
> +               return false;
> +
> +       att->close_on_unref = do_close;
> +
> +       return true;
> +}
> +
> +uint16_t bt_att_get_mtu(struct bt_att *att)
> +{
> +       if (!att)
> +               return 0;
> +
> +       return att->len;
> +}
> +
> +bool bt_att_set_mtu(struct bt_att *att, uint16_t mtu)
> +{
> +       if (!att)
> +               return false;
> +
> +       if (mtu <= ATT_DEFAULT_LE_MTU)
> +               return false;
> +
> +       att->len = mtu;
> +
> +       return true;
> +}
> +
> +static bool encode_mtu_req(const void *param, uint16_t length, void *buf,
> +                                       uint16_t mtu, uint16_t *pdu_length)
> +{
> +       const struct bt_att_exchange_mtu_req_param *cp = param;
> +       const uint16_t len = 3;
> +
> +       if (!param || !buf)
> +               return false;
> +
> +       if (length != sizeof(struct bt_att_exchange_mtu_req_param))
> +               return false;
> +
> +       if (len > mtu)
> +               return false;

If your plan is to use encode_pdu() as a switch for all possible
requests, maybe it will be better to move the common parameters
validation to it.

> +
> +       put_le16(cp->client_rx_mtu, buf);
> +       *pdu_length = len;
> +
> +       return true;
> +}
> +
> +static bool encode_pdu(uint8_t opcode, const void *param, uint16_t length,
> +                               uint16_t mtu, void *pdu, uint16_t *pdu_length)
> +{
> +       uint8_t *bytes = pdu;
> +       bytes[0] = opcode;
> +
> +       /* The length of the PDU depends on the specific ATT method. Special
> +        * case the operations with variable-length PDU's here.
> +        */
> +       if (length == 0) {
> +               *pdu_length = 1;
> +               return true;
> +       }
> +
> +       if (opcode == ATT_OP_EXCHANGE_MTU_REQ) {
> +               return encode_mtu_req(param, length, bytes + 1,
> +                                                       mtu, pdu_length);
> +       }
> +
> +       return false;
> +}
> +
> +static struct bt_att_request *create_request(uint8_t opcode, const void *param,
> +                               uint16_t length, void *buf, uint16_t mtu,
> +                               bt_att_request_func_t callback, void *user_data,
> +                               bt_att_destroy_func_t destroy)
> +{
> +       struct bt_att_request *request;
> +
> +       if (!opcode)
> +               return NULL;
> +
> +       if (length > 0 && !param)
> +               return NULL;
> +
> +       request = new0(struct bt_att_request, 1);
> +       if (!request)
> +               return NULL;
> +
> +       if (!encode_pdu(opcode, param, length, mtu, buf, &request->len)) {
> +               free(request);
> +               return NULL;
> +       }
> +
> +       /* request->len is at least 1 due to the opcode */
> +       request->pdu = malloc(request->len);
> +       if (!request->pdu) {
> +               free(request);
> +               return NULL;
> +       }
> +
> +       if (request->len > 0)
> +               memcpy(request->pdu, buf, request->len);
> +
> +       request->opcode = opcode;
> +       request->callback = callback;
> +       request->destroy = destroy;
> +       request->user_data = user_data;
> +
> +       return request;
> +}
> +
> +unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
> +                               const void *param, uint16_t length,
> +                               bt_att_request_func_t callback, void *user_data,
> +                               bt_att_destroy_func_t destroy)
> +{
> +       struct bt_att_request *request;
> +
> +       if (!att)
> +               return 0;
> +
> +       request = create_request(opcode, param, length, att->buf, att->len,
> +                                               callback, user_data, destroy);
> +
> +       if (!request)
> +               return 0;
> +
> +       if (att->next_request_id < 1)
> +               att->next_request_id = 1;
> +
> +       request->id = att->next_request_id++;
> +
> +       if (!queue_push_tail(att->request_queue, request)) {
> +               free(request->pdu);
> +               free(request);
> +               return 0;
> +       }
> +
> +       wakeup_writer(att);
> +
> +       return request->id;
> +}
> +
> +bool bt_att_cancel(struct bt_att *att, unsigned int id)
> +{

Does it make sense to cancel only one ATT request?
In general if some error happens you need to cancel all requests and
close the socket.

> +       struct bt_att_request *request;
> +
> +       if (!request || !id)
> +               return false;
> +
> +       request = queue_remove_if(att->request_queue, match_request_id,
> +                                                       UINT_TO_PTR(id));
> +       if (request)
> +               goto done;
> +
> +       request = queue_remove_if(att->pending_list, match_request_id,
> +                                                       UINT_TO_PTR(id));
> +       if (request)
> +               goto done;
> +
> +done:
> +       destroy_request(request);
> +
> +       wakeup_writer(att);
> +
> +       return true;
> +}
> +
> +bool bt_att_cancel_all(struct bt_att *att)
> +{
> +       if (!att)
> +               return false;
> +
> +       queue_remove_all(att->pending_list, NULL, NULL, destroy_request);
> +       queue_remove_all(att->request_queue, NULL, NULL, destroy_request);
> +
> +       return true;
> +}
> diff --git a/src/shared/att.h b/src/shared/att.h
> new file mode 100644
> index 0000000..570fbd2
> --- /dev/null
> +++ b/src/shared/att.h
> @@ -0,0 +1,97 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2012-2014  Intel Corporation. All rights reserved.
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
> +/* Error response */
> +#define ATT_OP_ERROR_RESP              0x01
> +struct bt_att_error_rsp_param {
> +       uint8_t request_opcode;
> +       uint16_t handle;
> +       uint8_t error_code;
> +};
> +
> +/* Exchange MTU */
> +#define ATT_OP_EXCHANGE_MTU_REQ                0x02
> +struct bt_att_exchange_mtu_req_param {
> +       uint16_t client_rx_mtu;
> +};
> +
> +#define ATT_OP_EXCHANGE_MTU_RESP       0x03
> +struct bt_att_exchange_mtu_rsp_param {
> +       uint16_t server_rx_mtu;
> +};
> +
> +/* Error codes for Error response PDU */
> +#define ATT_ERROR_INVALID_HANDLE                       0x01
> +#define ATT_ERROR_READ_NOT_PERMITTED                   0x02
> +#define ATT_ERROR_WRITE_NOT_PERMITTED                  0x03
> +#define ATT_ERROR_INVALID_PDU                          0x04
> +#define ATT_ERROR_AUTHENTICATION                       0x05
> +#define ATT_ERROR_REQUEST_NOT_SUPPORTED                        0x06
> +#define ATT_ERROR_INVALID_OFFSET                       0x07
> +#define ATT_ERROR_AUTHORIZATION                                0x08
> +#define ATT_ERROR_PREPARE_QUEUE_FULL                   0x09
> +#define ATT_ERROR_ATTRIBUTE_NOT_FOUND                  0x0A
> +#define ATT_ERROR_ATTRIBUTE_NOT_LONG                   0x0B
> +#define ATT_ERROR_INSUFFICIENT_ENCRYPTION_KEY_SIZE     0x0C
> +#define ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN          0x0D
> +#define ATT_ERROR_UNLIKELY                             0x0E
> +#define ATT_ERROR_INSUFFICIENT_ENCRYPTION              0x0F
> +#define ATT_ERROR_UNSUPPORTED_GROUP_TYPE               0x10
> +#define ATT_ERROR_INSUFFICIENT_RESOURCES               0x11

I recommend do leave them out until you really need these application
defined errors. Maybe you can propose a solution which doesn't require
this workaround.
> +/* Application defined errors */
> +#define ATT_ERROR_IO                                   0x80
> +#define ATT_ERROR_TIMEOUT                              0x81
> +#define ATT_ERROR_ABORTED                              0x82
> +
> +typedef void (*bt_att_destroy_func_t)(void *user_data);
> +
> +struct bt_att;
> +
> +struct bt_att *bt_att_new(int fd);
> +
> +struct bt_att *bt_att_ref(struct bt_att *att);
> +void bt_att_unref(struct bt_att *att);
> +
> +typedef void (*bt_att_debug_func_t)(const char *str, void *user_data);
> +
> +bool bt_att_set_debug(struct bt_att *att, bt_att_debug_func_t callback,
> +                               void *user_data, bt_att_destroy_func_t destroy);
> +
> +bool bt_att_set_close_on_unref(struct bt_att *att, bool do_close);
> +
> +uint16_t bt_att_get_mtu(struct bt_att *att);
> +bool bt_att_set_mtu(struct bt_att *att, uint16_t mtu);
> +
> +typedef void (*bt_att_request_func_t)(uint8_t opcode, const void *param,
> +                                       uint16_t length, void *user_data);
> +
> +unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
> +                               const void *param, uint16_t length,
> +                               bt_att_request_func_t callback, void *user_data,
> +                               bt_att_destroy_func_t destroy);
> +
> +bool bt_att_cancel(struct bt_att *att, unsigned int id);
> +bool bt_att_cancel_all(struct bt_att *att);
> --
> 1.9.1.423.g4596e3a
>

Regards,
Claudio
