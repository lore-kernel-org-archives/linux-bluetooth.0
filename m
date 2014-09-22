Return-Path: <cyrus@holtmann.org>
From: "Gu, Chao Jie" <chao.jie.gu@intel.com>
To: Szymon Janc <szymon.janc@tieto.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"marcel@holtmann.org" <marcel@holtmann.org>, "armansito@chromium.org"
	<armansito@chromium.org>
Subject: RE: [PATCH] Add signed write command
Date: Mon, 22 Sep 2014 08:25:50 +0000
Message-ID: <3D02B219753AD44CBDDDE484323B17741130A080@SHSMSX104.ccr.corp.intel.com>
References: <1410958395-7174-1-git-send-email-chao.jie.gu@intel.com>
 <12273172.GZIjs3WGW2@leonov>
In-Reply-To: <12273172.GZIjs3WGW2@leonov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> > Add bt_att_set_csrk for btgatt-client tool. However this patch hook
> > into shared/mgmt, so btgatt-client now should be running by the root us=
er.
>=20
> I guess this could be made optional.

You said this could be made optional , what's you point ? I am not very cle=
ar about
That.
=20
> > ---
> >  src/shared/att-types.h   |    3 ++
> >  src/shared/att.c         |   49 ++++++++++++++++--
> >  src/shared/att.h         |    2 +
> >  src/shared/gatt-client.c |   11 ++--
> >  tools/btgatt-client.c    |  129
> > ++++++++++++++++++++++++++++++++++++++++++++++ 5 files changed, 186
> > insertions(+), 8 deletions(-)
> >
> > diff --git a/src/shared/att-types.h b/src/shared/att-types.h index
> > b85c969..da8b6ae 100644
> > --- a/src/shared/att-types.h
> > +++ b/src/shared/att-types.h
> > @@ -25,6 +25,9 @@
> >
> >  #define BT_ATT_DEFAULT_LE_MTU 23
> >
> > +/* Length of signature in write signed packet */
> > +#define BT_ATT_SIGNATURE_LEN		12
> > +
> >  /* ATT protocol opcodes */
> >  #define BT_ATT_OP_ERROR_RSP	      		0x01
> >  #define BT_ATT_OP_MTU_REQ			0x02
> > diff --git a/src/shared/att.c b/src/shared/att.c index
> > a5cab45..aadef9e 100644
> > --- a/src/shared/att.c
> > +++ b/src/shared/att.c
> > @@ -36,6 +36,7 @@
> >  #include "lib/uuid.h"
> >  #include "src/shared/att.h"
> >  #include "src/shared/att-types.h"
> > +#include "src/shared/crypto.h"
> >
> >  #define ATT_MIN_PDU_LEN			1  /* At least 1 byte for the opcode. */
> >  #define ATT_OP_CMD_MASK			0x40
> > @@ -77,6 +78,11 @@ struct bt_att {
> >  	bt_att_debug_func_t debug_callback;
> >  	bt_att_destroy_func_t debug_destroy;
> >  	void *debug_data;
> > +
> > +	struct bt_crypto *crypto;
> > +
> > +	uint8_t local_csrk[16];
> > +	uint32_t local_sign_cnt;
> >  };
> >
> >  enum att_op_type {
> > @@ -176,6 +182,8 @@ struct att_send_op {
> >  	bt_att_response_func_t callback;
> >  	bt_att_destroy_func_t destroy;
> >  	void *user_data;
> > +
> > +	struct bt_att *att;
> >  };
> >
> >  static void destroy_att_send_op(void *data) @@ -277,6 +285,10 @@
> > static bool encode_pdu(struct att_send_op *op, const void *pdu,
> > uint16_t length, uint16_t mtu)  {
> >  	uint16_t pdu_len =3D 1;
> > +	struct bt_att *att =3D op->att;
> > +
> > +	if (op->opcode & ATT_OP_SIGNED_MASK)
> > +		pdu_len +=3D BT_ATT_SIGNATURE_LEN;
> >
> >  	if (length && pdu)
> >  		pdu_len +=3D length;
> > @@ -293,17 +305,32 @@ static bool encode_pdu(struct att_send_op *op,
> > const void *pdu, if (pdu_len > 1)
> >  		memcpy(op->pdu + 1, pdu, length);
> >
> > +	if (op->opcode & ATT_OP_SIGNED_MASK) {
>=20
> This should be used only if CSRK was provided. So we should have local_cs=
rk_valid or
> similar flag (similar to what we currently have in android code). Check s=
hould be
> either here or we could also bail out sooner in
> bt_gatt_client_write_without_response().

I think if we add loca_csrk_valid flag, it would be better to put in here. =
Since csrk
Information in the bt_att structure, it should be hidden the details from u=
pper layer.

>=20
> > +		if (bt_crypto_sign_att(att->crypto,
> > +					att->local_csrk,
> > +					op->pdu,
> > +					1 + length,
> > +					att->local_sign_cnt,
> > +					&((uint8_t *) op->pdu)[1 + length]))
> > +			att->local_sign_cnt++;
> > +		else
> > +			return false;
> > +	}
> > +
> >  	return true;
> >  }
> >
> > -static struct att_send_op *create_att_send_op(uint8_t opcode, const vo=
id
> > *pdu, -						uint16_t length, uint16_t mtu,
> > +static struct att_send_op *create_att_send_op(uint8_t opcode,
> > +						const void *pdu,
> > +						uint16_t length,
> > +						struct bt_att *att,
> >  						bt_att_response_func_t callback,
> >  						void *user_data,
> >  						bt_att_destroy_func_t destroy)
> >  {
> >  	struct att_send_op *op;
> >  	enum att_op_type op_type;
> > +	uint16_t mtu =3D att->mtu;
> >
> >  	if (length && !pdu)
> >  		return NULL;
> > @@ -334,6 +361,7 @@ static struct att_send_op
> > *create_att_send_op(uint8_t opcode, const void *pdu, op->callback =3D c=
allback;
> >  	op->destroy =3D destroy;
> >  	op->user_data =3D user_data;
> > +	op->att =3D att;
> >
> >  	if (!encode_pdu(op, pdu, length, mtu)) {
> >  		free(op);
> > @@ -707,6 +735,10 @@ struct bt_att *bt_att_new(int fd)
> >  	if (!att->io)
> >  		goto fail;
> >
> > +	att->crypto =3D bt_crypto_new();
> > +	if (!att->crypto)
> > +		goto fail;
> > +
> >  	att->req_queue =3D queue_new();
> >  	if (!att->req_queue)
> >  		goto fail;
> > @@ -741,6 +773,7 @@ fail:
> >  	queue_destroy(att->write_queue, NULL);
> >  	queue_destroy(att->notify_list, NULL);
> >  	queue_destroy(att->disconn_list, NULL);
> > +	bt_crypto_unref(att->crypto);
> >  	io_destroy(att->io);
> >  	free(att->buf);
> >  	free(att);
> > @@ -931,7 +964,7 @@ unsigned int bt_att_send(struct bt_att *att,
> > uint8_t opcode, if (!att || !att->io)
> >  		return 0;
> >
> > -	op =3D create_att_send_op(opcode, pdu, length, att->mtu, callback,
> > +	op =3D create_att_send_op(opcode, pdu, length, att, callback,
> >  							user_data, destroy);
> >  	if (!op)
> >  		return 0;
> > @@ -1116,3 +1149,13 @@ bool bt_att_unregister_all(struct bt_att *att)
> >
> >  	return true;
> >  }
> > +
> > +void bt_att_set_csrk(struct bt_att *att,
> > +			const uint8_t *val,
> > +			uint32_t local_sign_cnt)
>=20
> This should allow to set local and/or remote csrk. Either we have two fun=
ctions or
> flag identifying which key is provided.

This is good idea. But this patch for client side, there is no need to use =
remote_csrk,
So would it be better to add remote csrk part when we need this?=20

> Also there should be a way to notify user of bt_att about incremented val=
ues of
> counters.

This suggestion is also the same with previous one. I have thought about ad=
d
function like bt_att_get_csrk for user. However , for btgatt-client tool, t=
here is no
need to use it right now, so I didn't add it.

> > +{
> > +	memcpy(att->local_csrk, val, 16);
> > +	att->local_sign_cnt =3D local_sign_cnt; }
> > +
> > +
> > diff --git a/src/shared/att.h b/src/shared/att.h index
> > 1063021..b76e5f5 100644
> > --- a/src/shared/att.h
> > +++ b/src/shared/att.h
> > @@ -76,3 +76,5 @@ unsigned int bt_att_register_disconnect(struct
> > bt_att *att, bool bt_att_unregister_disconnect(struct bt_att *att,
> > unsigned int id);
> >
> >  bool bt_att_unregister_all(struct bt_att *att);
> > +
> > +void bt_att_set_csrk(struct bt_att *att, const uint8_t *val, uint32_t
> > local_sign_cnt); diff --git a/src/shared/gatt-client.c
> > b/src/shared/gatt-client.c index 1a157ec..b1619c6 100644
> > --- a/src/shared/gatt-client.c
> > +++ b/src/shared/gatt-client.c
> > @@ -973,19 +973,20 @@ bool bt_gatt_client_read_long_value(struct
> > bt_gatt_client *client, bool
> > bt_gatt_client_write_without_response(struct
> > bt_gatt_client *client, uint16_t value_handle,
> >  					bool signed_write,
> > -					uint8_t *value, uint16_t length) {
> > +					uint8_t *value, uint16_t length) {
> >  	uint8_t pdu[2 + length];
> >
> >  	if (!client)
> >  		return 0;
> >
> > -	/* TODO: Support this once bt_att_send supports signed writes. */
> > -	if (signed_write)
> > -		return 0;
> > -
> >  	put_le16(value_handle, pdu);
> >  	memcpy(pdu + 2, value, length);
> >
> > +	if (signed_write)
> > +		return bt_att_send(client->att, BT_ATT_OP_SIGNED_WRITE_CMD,
> > +					pdu, sizeof(pdu), NULL, NULL, NULL);
> > +
> >  	return bt_att_send(client->att, BT_ATT_OP_WRITE_CMD, pdu, sizeof(pdu)=
,
> >  							NULL, NULL, NULL);
> >  }
> > diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
> > index d1395b2..fdf8485 100644
> > --- a/tools/btgatt-client.c
> > +++ b/tools/btgatt-client.c
>=20
> It would be nice if you do not mix src/shared/ and tools/ changes in sing=
le
> patch (makes history and review easier).

Great. I will follow your advice.
>=20
> > @@ -38,11 +38,14 @@
> >  #include <bluetooth/hci_lib.h>
> >  #include <bluetooth/l2cap.h>
> >  #include "lib/uuid.h"
> > +#include "lib/bluetooth.h"
> > +#include "lib/mgmt.h"
> >
> >  #include "monitor/mainloop.h"
> >  #include "src/shared/util.h"
> >  #include "src/shared/att.h"
> >  #include "src/shared/gatt-client.h"
> > +#include "src/shared/mgmt.h"
> >
> >  #define ATT_CID 4
> >
> > @@ -59,6 +62,8 @@
> >  #define COLOR_BOLDWHITE	"\x1B[1;37m"
> >
> >  static bool verbose =3D false;
> > +static struct mgmt *mgmt_if =3D NULL;
> > +static uint16_t adapter_index =3D MGMT_INDEX_NONE;
> >
> >  struct client {
> >  	int fd;
> > @@ -92,6 +97,115 @@ static void gatt_debug_cb(const char *str, void
> > *user_data) PRLOG(COLOR_GREEN "%s%s\n" COLOR_OFF, prefix, str);
> >  }
> >
> > +static void new_csrk_callback(uint16_t index, uint16_t length,
> > +					const void *param, void *user_data)
> > +{
> > +	const struct mgmt_ev_new_csrk *ev =3D param;
> > +	struct bt_att *att =3D user_data;
> > +
> > +	if (length < sizeof(*ev)) {
> > +		fprintf(stderr, "Too small csrk event (%u bytes)\n", length);
> > +		return;
> > +	}
> > +
> > +	switch (ev->key.master) {
> > +	case 0x00:
> > +		bt_att_set_csrk(att, ev->key.val, 0);
> > +		break;
> > +	case 0x01:
> > +		break;
> > +	default:
> > +		fprintf(stderr,
> > +			"Unknown CSRK key type 02%02x\n", ev->key.master);
> > +		return;
> > +	}
> > +}
> > +
> > +static void mgmt_index_added_event(uint16_t index, uint16_t length,
> > +					const void *param, void *user_data)
> > +{
> > +	struct bt_att *att =3D user_data;
> > +
> > +	printf("index %u\n", index);
> > +
> > +	if (adapter_index !=3D MGMT_INDEX_NONE) {
> > +		fprintf(stderr, "skip event for index %u\n", index);
> > +		return;
> > +	}
> > +	adapter_index =3D index;
> > +
> > +	mgmt_register(mgmt_if, MGMT_EV_NEW_CSRK, adapter_index,
> > +						new_csrk_callback, att, NULL);
> > +}
> > +
> > +static void mgmt_index_removed_event(uint16_t index, uint16_t length,
> > +					const void *param, void *user_data)
> > +{
> > +	if (index !=3D adapter_index)
> > +		return;
> > +
> > +	perror("Adapter was removed. Exiting.\n");
>=20
> Using perror() is not correct here (and in other places as well). It will
> print error message with description of (most likely bogus) errno value. =
It
> should be used only for printing error message after failed syscall (or i=
f
> function uses errno for error reporting).
>=20
Mistake . I will modify it.

> > +	raise(SIGTERM);
> > +}
> > +
> > +static void read_version_complete(uint8_t status, uint16_t length,
> > +					const void *param, void *user_data)
> > +{
> > +	const struct mgmt_rp_read_version *rp =3D param;
> > +	uint8_t mgmt_version, mgmt_revision;
> > +	struct bt_att *att =3D user_data;
> > +
> > +	if (status) {
> > +		fprintf(stderr,
> > +			"Failed to read version information: %s (0x%02x)\n",
> > +						mgmt_errstr(status), status);
> > +		return;
> > +	}
> > +
> > +	if (length < sizeof(*rp)) {
> > +		perror("Wrong size response\n");
>=20
> Ditto.
>=20
> > +		return;
> > +	}
> > +
> > +	mgmt_version =3D rp->version;
> > +	mgmt_revision =3D btohs(rp->revision);
> > +
> > +	printf("Bluetooth management interface %u.%u initialized\n",
> > +						mgmt_version, mgmt_revision);
> > +
> > +	if (MGMT_VERSION(mgmt_version, mgmt_revision) < MGMT_VERSION(1, 3)) {
> > +		perror("Version 1.3 later of management interface required\n");
> > +		return;
>=20
> Why 1.3?

I follow the bluetoothd daemon implementation, Maybe it lower than 1.3,
Would some mgmt API would not compatible with kernel?  It' s for safe purpo=
se here.
> > +	}
> > +
> > +	mgmt_register(mgmt_if, MGMT_EV_INDEX_ADDED, MGMT_INDEX_NONE,
> > +					mgmt_index_added_event, att, NULL);
> > +	mgmt_register(mgmt_if, MGMT_EV_INDEX_REMOVED,
> MGMT_INDEX_NONE,
> > +					mgmt_index_removed_event, NULL, NULL);
> > +}
> > +
> > +static bool mgmt_create(struct bt_att *att)
> > +{
> > +	mgmt_if =3D mgmt_new_default();
> > +	if (!mgmt_if) {
> > +		perror("Failed to access management interface\n");
> > +		return false;
> > +	}
> > +
> > +	if (mgmt_send(mgmt_if, MGMT_OP_READ_VERSION, MGMT_INDEX_NONE, 0,
> NULL,
> > +				read_version_complete, att, NULL) =3D=3D 0) {
> > +		perror("Error sending READ_VERSION mgmt command\n");
> > +
> > +		mgmt_unref(mgmt_if);
> > +		mgmt_if =3D NULL;
> > +
> > +		return false;
> > +	}
> > +
> > +	return true;
> > +}
> > +
> >  static void ready_cb(bool success, uint8_t att_ecode, void *user_data)=
;
> >
> >  static struct client *client_create(int fd, uint16_t mtu)
> > @@ -136,6 +250,13 @@ static struct client *client_create(int fd, uint16=
_t
> > mtu) return NULL;
> >  	}
> >
> > +	if (!mgmt_create(att)) {
> > +		fprintf(stderr, "Failed to create management interface\n");
> > +		bt_att_unref(att);
> > +		free(cli);
> > +		return NULL;
> > +	}
> > +
> >  	if (verbose) {
> >  		bt_att_set_debug(att, att_debug_cb, "att: ", NULL);
> >  		bt_gatt_client_set_debug(cli->gatt, gatt_debug_cb, "gatt: ",
> > @@ -155,6 +276,12 @@ static void client_destroy(struct client *cli)
> >  	bt_gatt_client_unref(cli->gatt);
> >  }
> >
> > +static void mgmt_destroy(struct mgmt *mgmt_if)
> > +{
> > +	mgmt_unref(mgmt_if);
> > +	mgmt_if =3D NULL;
>=20
> You are shadowing mgmt_if here so it will not NULL static (it doesn't rea=
lly
> introduce a bug since tool is exiting at that time but makes code harder =
to
> follow). I'd just opencode this.

You mean remove mgmt_destroy function and just directly use mgmt_unref , ri=
ght?
But I still cannot catch your meaning about this making code harder to foll=
ow


Best Regards
Chaojie Gu
