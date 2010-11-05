Return-Path: <cyrus@holtmann.org>
Date: Fri, 5 Nov 2010 12:05:48 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, suraj@atheros.com,
	joakim.xj.ceder@stericsson.com
Subject: Re: [PATCH 3/4] Sim Access Profile Server
Message-ID: <20101105100548.GB32149@jh-x301>
References: <1288791271-13857-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1288791271-13857-4-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1288791271-13857-4-git-send-email-waldemar.rymarkiewicz@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldek,

On Wed, Nov 03, 2010, Waldemar Rymarkiewicz wrote:
> +	uint8_t atr[] = {0x3b, 0x9a, 0x96, 0x00, 0x92, 0x01, 0x98, 0x93, 0x17,

Space after {

> +			 0x00, 0x02, 0x28, 0x03, 0x00};

Mixed spaces and tabs for indentation. Just use tabs. Space before }

> +void sap_transfer_card_reader_status_req(void * sap_device)

No space between * and sap_device

> +void sap_set_transport_protocol_req(void * sap_device,sap_parameter * param)

White space again. It should be "void *sap_device, sap_parameter *param)"

> + *  Copyright (C) 2010 Claudio Takahasi<claudio.takahasi@openbossa.org>

Same copyright issue as previously discussed.

> +/* Connection Status - SAP v1.1 section 5.2.2 */
> +typedef enum {
> +	SAP_STATUS_OK 				= 0x00,

There's an extra space after OK. Just use tabs.

> +/* Result codes - SAP v1.1 section 5.2.4 */
> +typedef enum {
> +	SAP_RESULT_OK 			= 0x00,

Same here.

> +/* Status Change - SAP v1.1 section 5.2.8 */
> +typedef enum {
> +	SAP_STATUS_CHANGE_UNKNOWN_ERROR	= 0x00,
> +	SAP_STATUS_CHANGE_CARD_RESET	= 0x01,
> +	SAP_STATUS_CHANGE_CARD_NOT_ACCESSIBLE = 0x02,
> +	SAP_STATUS_CHANGE_CARD_REMOVED	= 0x03,
> +	SAP_STATUS_CHANGE_CARD_INSERTED	= 0x04,
> +	SAP_STATUS_CHANGE_CARD_RECOVERED = 0x05
> +} sap_status_change_t;

Why don't you use similar alignmenth here as for the other enums?

> +/* Message format - SAP v1.1 section 5.1 */
> +typedef struct {

Please don't use typedefs with structs. 

> +} __attribute__ ((packed)) sap_message;
> +
> +
> +typedef enum {

Remove one of the consequtive empty lines.

> +} icc_reader_status_t;
> +
> +
> +#define SAP_BUF_SIZE		512

Same here.

> +/*SAP responses to SAP requests. Implemented by server.c */
> +int sap_connect_rsp(void *sap_device, sap_status_t status, uint16_t maxmsgsize);
> +int sap_disconnect_rsp(void *sap_device);
> +int sap_transfer_apdu_rsp(void *sap_device, sap_result_t result, uint8_t *sap_apdu_resp, uint16_t length);
> +int sap_transfer_atr_rsp(void *sap_device, sap_result_t result, uint8_t *sap_atr, uint16_t length);
> +int sap_power_sim_off_rsp(void *sap_device, sap_result_t result);
> +int sap_power_sim_on_rsp(void *sap_device, sap_result_t result);
> +int sap_reset_sim_rsp(void *sap_device, sap_result_t result);
> +int sap_transfer_card_reader_status_rsp(void *sap_device, sap_result_t result, icc_reader_status_t status);
> +int sap_error_rsp(void *sap_device);
> +int sap_transport_protocol_rsp(void *sap_device, sap_result_t result);

Several of the above lines go beyond 79 columns. Please split them.

> +++ b/sap/server.c
> @@ -2,7 +2,9 @@
>   *  BlueZ - Bluetooth protocol stack for Linux
>   *
>   *  Copyright (C) 2010 ST-Ericsson SA
> + *  Copyright (C) 2010 Claudio Takahasi<claudio.takahasi@openbossa.org>

Same copyright issue as before.

> +static void connect_req(void *data, sap_parameter *param);
> +static int disconnect_req(void *data, sap_disconnection_type_t disc_type);
> +static void transfer_apdu_req(void *data, sap_parameter *param);
> +static void transfer_atr_req(void *data);
> +static void power_sim_off_req(void *data);
> +static void power_sim_on_req(void *data);
> +static void reset_sim_req(void *data);
> +static void transfer_card_reader_status_req(void *data);
> +static void set_transport_protocol_req(void *data, sap_parameter *param);
> +static int disconnect_ind(void *sap_device, sap_disconnection_type_t type);

Are all these forward-declarations really needed? If you can avoid them
by sorting the functions within the c file differently, please do so.

> +static gsize add_result_parameter(sap_result_t result, sap_parameter *param);

Use size_t instead of gsize.

> +}
> +
> +
> +static inline int is_power_sim_off_req_allowed(uint8_t processing_req)

Remove one of the consecutive empty lines. Remove the "inline" unless
you really profiled this and discovered that this has a measurable
impact and that the compiler fails to optimize this without the
"inline".

> +	switch(processing_req) {

Space before )

> +static inline int is_reset_sim_req_allowed(uint8_t processing_req)
> +{
> +	switch(processing_req) {

Same here.

> +static int check_msg(sap_message *msg)
> +{
> +	if(!msg)

And here.

> +}
> +
> +
> +static void start_guard_timer(struct sap_server *server, guint interval)

Remove one of the empty lines.

> +{
> +	if(!server)

Space before (

> +	switch(server->state) {

Same here.

> +	if(!server || !buf)

And here.

> +	if(written != (gsize)size) {

And here.

> +		error("send_message:write error. written %d size %d", written, size);
> +	}
> +	DBG("send_message: written=%x",(unsigned int)written);

Empty line after }

> +	if(!server || !param)

Space before (

> +	val = (uint16_t *) &param->val;
> +	maxmsgsize = ntohs(*val);

Is this unaligned access safe?

> +	if (maxmsgsize <= SAP_BUF_SIZE){
> +		server->processing_req = SAP_CONNECT_REQ;
> +		sap_connect_req(server, maxmsgsize);
> +	}else{

Space before and after else

> +	if(!server)

Space before (

> +	switch(disc_type) {

Same here.

> +static void transfer_apdu_req(void * data, sap_parameter * param)

No spaces after *

> +	if(!server || !param)

Space before (

> +}
> +
> +
> +static void transfer_atr_req(void * data)

Remove one of the empty lines. No space before data.

> +	if(!server)

Space before (

> +}
> +
> +
> +static void power_sim_off_req(void *data)

Remove one of the empty lines.

> +	if(!server)

Space before (

> +static void power_sim_on_req(void *data)
> +{
> +	struct sap_server *server = data;
> +
> +	if(!server)

Space before (

> +static void reset_sim_req(void *data)
> +{
> +	struct sap_server *server = data;
> +
> +	if(!server)

Same here.

> +static void transfer_card_reader_status_req(void * data)

No space before data.

> +{
> +	struct sap_server *server = data;
> +
> +	if(!server)

Space before (

> +static void set_transport_protocol_req(void *data, sap_parameter *param)
> +{
> +	struct sap_server *server = data;
> +
> +	if(!server || !param)

Same here.

> +	gchar buf[SAP_BUF_SIZE];

Use char instead of gchar.

> +	gsize size = sizeof(sap_message);

Use size_t instead of gsize.

> +	if(!server)

Space before (

> +int sap_connect_rsp(void *sap_device, sap_status_t status, uint16_t maxmsgsize)
> +{
> +	struct sap_server *server = sap_device;
> +	gchar buf[SAP_BUF_SIZE];
> +	sap_message *msg = (sap_message *) buf;
> +	sap_parameter *param = (sap_parameter *) msg->param;
> +	gsize size = sizeof(sap_message);

size_t

> +	if(!server)

Space before (

> +	if (server->state != SAP_STATE_CONNECT_IN_PROGRESS) {
> +		return -EPERM;
> +	}

{} not needed for one-line scopes.

> +int sap_disconnect_rsp(void *sap_device)
> +{
> +	struct sap_server *server = sap_device;
> +	sap_message msg = {0};

Space before and after 0

> +	if(!server)

Space before (

> +	gchar buf[SAP_BUF_SIZE] = {0};

Use char instead of gchar. Is the initialization upon declaration really
necessary?

> +	gsize size = sizeof(sap_message);

sizt_t

> +	if(!server)

Space before (

> +int sap_transfer_atr_rsp(void *sap_device, sap_result_t result, uint8_t *atr,
> +								uint16_t length)
> +{
> +	struct sap_server *server = sap_device;
> +	gchar buf[SAP_BUF_SIZE]= {0};
> +	sap_message *msg = (sap_message *) buf;
> +	sap_parameter *param = (sap_parameter *) msg->param;
> +	gsize size = sizeof(sap_message);
> +
> +	if(!server)
> +		return -1;

Same comments as for the previous function.

> +int sap_power_sim_off_rsp(void *sap_device, sap_result_t result)
> +{
> +	struct sap_server *server = sap_device;
> +	gchar buf[SAP_BUF_SIZE] = {0};
> +	sap_message *msg = (sap_message *) buf;
> +	gsize size = sizeof(sap_message);
> +
> +	if(!server)
> +		return -1;

Same here.

> +int sap_power_sim_on_rsp(void *sap_device, sap_result_t result)
> +{
> +	struct sap_server *server = sap_device;
> +	gchar buf[SAP_BUF_SIZE] = {0};
> +	sap_message *msg = (sap_message *) buf;
> +	gsize size = sizeof(sap_message);
> +
> +	if(!server)
> +		return -1;

And here.

> +int sap_reset_sim_rsp(void *sap_device, sap_result_t result)
> +{
> +	struct sap_server *server = sap_device;
> +	gchar buf[SAP_BUF_SIZE] = {0};
> +	sap_message *msg = (sap_message *) buf;
> +	gsize size = sizeof(sap_message);
> +
> +	if(!server)
> +		return -1;

And here.

> +int sap_transfer_card_reader_status_rsp(void *sap_device, sap_result_t result,
> +						icc_reader_status_t status)
> +{
> +	struct sap_server *server = sap_device;
> +	gchar buf[SAP_BUF_SIZE] = {0};
> +	sap_message *msg = (sap_message *) buf;
> +	sap_parameter *param = (sap_parameter *) msg->param;
> +	gsize size = sizeof(sap_message);
> +
> +	if(!server)
> +		return -1;

And here.

> +int sap_transport_protocol_rsp(void *sap_device, sap_result_t result)
> +{
> +	struct sap_server *server = sap_device;
> +	gchar buf[SAP_BUF_SIZE] = {0};
> +	sap_message *msg = (sap_message *) buf;
> +	gsize size = sizeof(sap_message);
> +
> +	if(!server)
> +		return -1;

And here.

> +int sap_error_rsp(void *sap_device)
> +{
> +	sap_message msg;
> +
> +	memset(&msg, 0, sizeof(msg));
> +	msg.id = SAP_ERROR_RESP;
> +
> +	return send_message(sap_device, (gchar *) &msg, sizeof(msg));

char instead of gchar. Worth considering if the second parameter to
send_message should be void * to avoid these type casts.

> +int sap_status_ind(void *sap_device, sap_status_change_t status_change)
> +{
> +	struct sap_server *server = sap_device;
> +	gchar buf[SAP_BUF_SIZE] = {0};
> +	sap_message *msg = (sap_message *) buf;
> +	sap_parameter *param = (sap_parameter *) msg->param;
> +	gsize size = sizeof(sap_message);
> +
> +	if(!server)
> +		return -1;

Same comments as for the few other functions above.

> +		/*Don't propagate status indication if client is not connected */

Space before D

> +static int handle_cmd(void *data, gchar *buf, gsize size)

char instead of gchar, size_t instead of gsize

> +	sap_message *msg = (sap_message *) buf;

Maybe the function should take void * so you don't need the explicit
type cast?

> +	switch(msg->id) {

Space befor e(

> +		case SAP_CONNECT_REQ:

Incorrect indentation. This should have the same as the initial switch
line. Same goes for all other case statements.

> +static gboolean sap_io_cb(GIOChannel *chan, GIOCondition cond, void *data)
> +{
> +	gchar buf[SAP_BUF_SIZE];
> +	gsize bytes_read = 0;

char and size_t

> +	if (handle_cmd(data, buf, bytes_read) < 0) {
> +		error("Invalid SAP message.");
> +	}

No {} for one-line scopes.

> +	if(!server)

Space before (

> +	g_io_add_watch_full(chan, G_PRIORITY_DEFAULT,
> +			G_IO_IN | G_IO_ERR | G_IO_HUP| G_IO_NVAL,
> +			(GIOFunc) sap_io_cb, server, sap_io_destroy);

Instead of type casting to GIOFunc just fix sap_io_cp to have the right
type and then do necessary assignments to correct variable types inside
that function.

> +	if(!server || !server->io)

Space before (

> +	if (!bt_io_accept(server->io, sap_connect_cb, server, NULL, &gerr)) {
> +		error("bt_io_accept: %s", gerr->message);
> +		g_error_free(gerr);
> +		goto drop;
> +	}
> +	return;

Empty line before return

> +	if(!chan || !server)

Space before (

> +	DBG("SAP incoming connection (sock %d) authorization.", g_io_channel_unix_get_fd(chan));

Too long line.

> +}
> +
> +
> +

Three empty lines? :)

> +static inline DBusMessage *message_failed(DBusMessage *msg,

Remove the inline unless you've really done the profiling and concluded
that it's necessary.

> +	sdp_record_t *record = NULL;
> +	GIOChannel *io = NULL;

Unnecessary initialization since the variables gets unconditionally
initialized before usage in the function. Pay attention to this kind of
stuff everywhere in your code and fix other places too in case I missed
them.

> +	io = bt_io_listen(BT_IO_RFCOMM, NULL, connect_confirm_cb, server, NULL, &gerr,

Looks like that one goes over 79 columns.

> +static DBusMessage *disable(DBusConnection *conn,
> +				DBusMessage *msg, void *data)

Looks like at least the DBusMessage parameter would still fit on the
previous line.

> +	DBusMessage *reply = NULL;

Unnecessary initialization upon declaration.

> +	if(!server)

Space before (

> +static DBusMessage *disconnect(DBusConnection *conn, DBusMessage *msg, void *data)

Looks like that goes over 79 columns.

> +	server = g_new0(struct sap_server, 1);
> +
> +	if (!server) {

g_new0 is guaranteed to succeed or call abort(). It will never return
NULL. If you really want to have the possibility for checking for
allocation errors use the g_try_new variants.

Johan
