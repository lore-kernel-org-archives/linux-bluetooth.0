Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0E729E11D
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 13:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769174910; cv=none; b=cJSIyYQXOpLS7FUhuboOiNqN70yTxw7nS3+7aUqVO/vYGNSQ9oWIcng8pxUfaMm4wZ33Tfxig8uBQyptoGTbxt04HbQwMEYhWjCfjh8ctdxIVXg7iXdm0Y0qmvhY/wMkfeHI4EzhcnSDAbQ7AePR7O6VD7/6zh0RaCeG1rkM0GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769174910; c=relaxed/simple;
	bh=Ks8XVv2ATLteRm8DfTBueEjbrsRYx1hvbPRhJDg2zgI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OebMCgZYenfDiJGS3M+ZMzZac8tsD1FFWaCdf350DN9VfL5qkhVnnhOKComxJDM/HuDawK6zk1oQi4xcpnHIwUdcjBk4vnM0XVeNdDhHcWy0UPLkdZLNg/HKljzALoYiFzYRo/vLt2puFMOtKXEYHbzT8t5M+S3Y3yj/M6OEENY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 285214432F;
	Fri, 23 Jan 2026 13:28:19 +0000 (UTC)
Message-ID: <a5895368c0ed1f82a461c64aad5d0c2385cc92c5.camel@hadess.net>
Subject: Re: [PATCH BlueZ] Implement the Bluetooth Ranging Profile GATT
 server and client support as specified by the Bluetooth SIG:
From: Bastien Nocera <hadess@hadess.net>
To: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>, 
	linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com,
 quic_hbandi@quicinc.com, 	quic_anubhavg@quicinc.com
Date: Fri, 23 Jan 2026 14:28:18 +0100
In-Reply-To: <20260123112101.549446-1-prathibha.madugonde@oss.qualcomm.com>
References: <20260123112101.549446-1-prathibha.madugonde@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeludeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepieffgfehtedtgefgjeeggfffgeeuvdegveekveejfeekkedujeehteffueefffeunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepvdekhedvudeggeefvdfhpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepiedprhgtphhtthhopehprhgrthhhihgshhgrrdhmrgguuhhgohhnuggvsehoshhsrdhquhgrlhgtohhmmhdrtghomhdprhgtphhtthhop
 ehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhuihiiuggvnhhtiiesghhmrghilhdrtghomhdprhgtphhtthhopehquhhitggpmhhohhgrmhhulhhlsehquhhitghinhgtrdgtohhmpdhrtghpthhtohepqhhuihgtpghhsggrnhguihesqhhuihgtihhntgdrtghomhdprhgtphhtthhopehquhhitggprghnuhgshhgrvhhgsehquhhitghinhgtrdgtohhm
X-GND-State: clean
X-GND-Score: -100

Hey Prathibha,

You should send all your RAS patches in a single patchset, probably
with a cover-letter, so they get applied as one set in the bluez CI.
Otherwise the CI will treat it as separate and independent patches
which won't apply or compile correctly.

You should also trim your commit subjects, they should be a maximum of
72 characters long.

Cheers

On Fri, 2026-01-23 at 16:51 +0530, Prathibha Madugonde wrote:
> Add RAS service, characteristics, and descriptors to the local GATT
> DB
> Implement server-side callbacks for RAS Features, Procedure Data,
> Data Ready and Data Overwritten characteristics
> Add client-side session handling, notification registration and
> ready callbacks
> Wire RAS attachment/detachment to ATT/GATT client and server
> ---
> =C2=A0Makefile.am=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +-
> =C2=A0src/shared/rap.c | 874
> +++++++++++++++++++++++++++++++++++++++++++++++
> =C2=A0src/shared/rap.h |=C2=A0 48 +++
> =C2=A03 files changed, 925 insertions(+), 1 deletion(-)
> =C2=A0create mode 100644 src/shared/rap.c
> =C2=A0create mode 100644 src/shared/rap.h
>=20
> diff --git a/Makefile.am b/Makefile.am
> index 2217bcf15..cff5cc034 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -248,7 +248,9 @@ shared_sources =3D src/shared/io.h
> src/shared/timeout.h \
> =C2=A0			src/shared/bap-defs.h \
> =C2=A0			src/shared/asha.h src/shared/asha.c \
> =C2=A0			src/shared/battery.h src/shared/battery.c \
> -			src/shared/uinput.h src/shared/uinput.c
> +			src/shared/uinput.h src/shared/uinput.c \
> +			src/shared/rap.h src/shared/rap.c
> +
> =C2=A0
> =C2=A0if READLINE
> =C2=A0shared_sources +=3D src/shared/shell.c src/shared/shell.h
> diff --git a/src/shared/rap.c b/src/shared/rap.c
> new file mode 100644
> index 000000000..605963c92
> --- /dev/null
> +++ b/src/shared/rap.c
> @@ -0,0 +1,874 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * BlueZ - Bluetooth protocol stack for Linux
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its
> subsidiaries.
> + */
> +
> +#define _GNU_SOURCE
> +#include <inttypes.h>
> +#include <string.h>
> +#include <stdlib.h>
> +#include <stdbool.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <glib.h>
> +
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
> +
> +#include "src/shared/queue.h"
> +#include "src/shared/util.h"
> +#include "src/shared/timeout.h"
> +#include "src/shared/att.h"
> +#include "src/shared/gatt-db.h"
> +#include "src/shared/gatt-server.h"
> +#include "src/shared/gatt-client.h"
> +#include "src/shared/rap.h"
> +
> +#define DBG(_rap, fmt, arg...) \
> +	rap_debug(_rap, "%s:%s() " fmt, __FILE__, __func__, ## arg)
> +
> +#define RAS_UUID16			0x185B
> +
> +/* Total number of attribute handles reserved for the RAS service */
> +#define RAS_TOTAL_NUM_HANDLES		18
> +
> +/* Ranging Service context */
> +struct ras {
> +	struct bt_rap_db *rapdb;
> +
> +	/* Service and characteristic attributes */
> +	struct gatt_db_attribute *svc;
> +	struct gatt_db_attribute *feat_chrc;
> +	struct gatt_db_attribute *realtime_chrc;
> +	struct gatt_db_attribute *realtime_chrc_ccc;
> +	struct gatt_db_attribute *ondemand_chrc;
> +	struct gatt_db_attribute *cp_chrc;
> +	struct gatt_db_attribute *ready_chrc;
> +	struct gatt_db_attribute *overwritten_chrc;
> +};
> +
> +struct bt_rap_db {
> +	struct gatt_db *db;
> +	struct ras *ras;
> +};
> +
> +struct bt_rap {
> +	int ref_count;
> +	struct bt_rap_db *lrapdb;
> +	struct bt_rap_db *rrapdb;
> +	struct bt_gatt_client *client;
> +	struct bt_att *att;
> +
> +	unsigned int idle_id;
> +
> +	struct queue *notify;
> +	struct queue *pending;
> +	struct queue *ready_cbs;
> +
> +	bt_rap_debug_func_t debug_func;
> +	bt_rap_destroy_func_t debug_destroy;
> +	void *debug_data;
> +	void *user_data;
> +};
> +
> +static struct queue *rap_db;
> +static struct queue *bt_rap_cbs;
> +static struct queue *sessions;
> +
> +struct bt_rap_cb {
> +	unsigned int id;
> +	bt_rap_func_t attached;
> +	bt_rap_func_t detached;
> +	void *user_data;
> +};
> +
> +typedef void (*rap_func_t)(struct bt_rap *rap, bool success,
> +			=C2=A0=C2=A0 uint8_t att_ecode, const uint8_t *value,
> +			=C2=A0=C2=A0 uint16_t length, void *user_data);
> +
> +struct bt_rap_pending {
> +	unsigned int id;
> +	struct bt_rap *rap;
> +	rap_func_t func;
> +	void *userdata;
> +};
> +
> +struct bt_rap_ready {
> +	unsigned int id;
> +	bt_rap_ready_func_t func;
> +	bt_rap_destroy_func_t destroy;
> +	void *data;
> +};
> +
> +typedef void (*rap_notify_t)(struct bt_rap *rap, uint16_t
> value_handle,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 const uint8_t *value, uint16_t length,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 void *user_data);
> +
> +struct bt_rap_notify {
> +	unsigned int id;
> +	struct bt_rap *rap;
> +	rap_notify_t func;
> +	void *user_data;
> +};
> +
> +static bool real_time_enabled;
> +static bool on_demand_enabled;
> +struct gatt_db_attribute *global_real_time_char;
> +struct gatt_db_attribute *global_on_demand_char;
> +struct gatt_db_attribute *global_data_ready_char;
> +struct gatt_db_attribute *global_data_overwritten_char;
> +struct gatt_db_attribute *global_control_point_char;
> +
> +static struct bt_rap_db *rap_get_rapdb(struct bt_rap *rap)
> +{
> +	if (!rap)
> +		return NULL;
> +
> +	if (rap->lrapdb)
> +		return rap->lrapdb;
> +
> +	return NULL;
> +}
> +
> +struct ras *rap_get_ras(struct bt_rap *rap)
> +{
> +	if (!rap)
> +		return NULL;
> +
> +	if (rap->rrapdb->ras)
> +		return rap->rrapdb->ras;
> +
> +	rap->rrapdb->ras =3D new0(struct ras, 1);
> +	rap->rrapdb->ras->rapdb =3D rap->rrapdb;
> +
> +	return rap->rrapdb->ras;
> +}
> +
> +static void rap_detached(void *data, void *user_data)
> +{
> +	struct bt_rap_cb *cb =3D data;
> +	struct bt_rap *rap =3D user_data;
> +
> +	cb->detached(rap, cb->user_data);
> +}
> +
> +void bt_rap_detach(struct bt_rap *rap)
> +{
> +	if (!queue_remove(sessions, rap))
> +		return;
> +
> +	bt_gatt_client_idle_unregister(rap->client, rap->idle_id);
> +	bt_gatt_client_unref(rap->client);
> +	rap->client =3D NULL;
> +
> +	queue_foreach(bt_rap_cbs, rap_detached, rap);
> +}
> +
> +static void rap_db_free(void *data)
> +{
> +	struct bt_rap_db *rapdb =3D data;
> +
> +	if (!rapdb)
> +		return;
> +
> +	gatt_db_unref(rapdb->db);
> +
> +	free(rapdb->ras);
> +	free(rapdb);
> +}
> +
> +static void rap_ready_free(void *data)
> +{
> +	struct bt_rap_ready *ready =3D data;
> +
> +	if (ready->destroy)
> +		ready->destroy(ready->data);
> +
> +	free(ready);
> +}
> +
> +static void rap_free(void *data)
> +{
> +	struct bt_rap *rap =3D data;
> +
> +	bt_rap_detach(rap);
> +
> +	rap_db_free(rap->rrapdb);
> +
> +	queue_destroy(rap->notify, free);
> +	queue_destroy(rap->pending, NULL);
> +	queue_destroy(rap->ready_cbs, rap_ready_free);
> +
> +	free(rap);
> +}
> +
> +bool bt_rap_set_user_data(struct bt_rap *rap, void *user_data)
> +{
> +	if (!rap)
> +		return false;
> +
> +	rap->user_data =3D user_data;
> +
> +	return true;
> +}
> +
> +static bool rap_db_match(const void *data, const void *match_data)
> +{
> +	const struct bt_rap_db *rapdb =3D data;
> +	const struct gatt_db *db =3D match_data;
> +
> +	return rapdb->db =3D=3D db;
> +}
> +
> +struct bt_att *bt_rap_get_att(struct bt_rap *rap)
> +{
> +	if (!rap)
> +		return NULL;
> +
> +	if (rap->att)
> +		return rap->att;
> +
> +	return bt_gatt_client_get_att(rap->client);
> +}
> +
> +struct bt_rap *bt_rap_ref(struct bt_rap *rap)
> +{
> +	if (!rap)
> +		return NULL;
> +
> +	__sync_fetch_and_add(&rap->ref_count, 1);
> +
> +	return rap;
> +}
> +
> +void bt_rap_unref(struct bt_rap *rap)
> +{
> +	if (!rap)
> +		return;
> +
> +	if (__sync_sub_and_fetch(&rap->ref_count, 1))
> +		return;
> +
> +	rap_free(rap);
> +}
> +
> +static void rap_debug(struct bt_rap *rap, const char *format, ...)
> +{
> +	va_list ap;
> +
> +	if (!rap || !format || !rap->debug_func)
> +		return;
> +
> +	va_start(ap, format);
> +	util_debug_va(rap->debug_func, rap->debug_data, format, ap);
> +	va_end(ap);
> +}
> +
> +bool bt_rap_set_debug(struct bt_rap *rap, bt_rap_debug_func_t func,
> +			void *user_data, bt_rap_destroy_func_t
> destroy)
> +{
> +	if (!rap)
> +		return false;
> +
> +	if (rap->debug_destroy)
> +		rap->debug_destroy(rap->debug_data);
> +
> +	rap->debug_func =3D func;
> +	rap->debug_destroy =3D destroy;
> +	rap->debug_data =3D user_data;
> +
> +	return true;
> +}
> +
> +static void ras_features_read_cb(struct gatt_db_attribute *attrib,
> +				 unsigned int id, uint16_t offset,
> +				 uint8_t opcode, struct bt_att *att,
> +				 void *user_data)
> +{
> +	/*
> +	 * Feature mask: bits 0-2 set:
> +	 *=C2=A0 - Real-time ranging
> +	 *=C2=A0 - Retrieve stored results
> +	 *=C2=A0 - Abort operation
> +	 */
> +	uint8_t value[4] =3D { 0x01, 0x00, 0x00, 0x00 };
> +
> +	gatt_db_attribute_read_result(attrib, id, 0, value,
> sizeof(value));
> +}
> +
> +static void ras_realtime_read_cb(struct gatt_db_attribute *attrib,
> +				 unsigned int id, uint16_t offset,
> +				 uint8_t opcode, struct bt_att *att,
> +				 void *user_data)
> +{
> +	/* No static read data; real-time data is provided via
> notifications. */
> +	gatt_db_attribute_read_result(attrib, id, 0, NULL, 0);
> +}
> +
> +static void ras_ondemand_read_cb(struct gatt_db_attribute *attrib,
> +				 unsigned int id, uint16_t offset,
> +				 uint8_t opcode, struct bt_att *att,
> +				 void *user_data)
> +{
> +	/* No static read data =E2=80=93 on=E2=80=91demand data is pushed via
> +	 * notifications
> +	 */
> +	gatt_db_attribute_read_result(attrib, id, 0, NULL, 0);
> +}
> +
> +/*
> + * Control point handler.
> + * Parses the opcode and acts on queued data (implementation TBD).
> + */
> +static void ras_control_point_write_cb(struct gatt_db_attribute
> *attrib,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int id, uint16_t
> offset,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const uint8_t *value, size_t
> len,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t opcode, struct bt_att
> *att,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *user_data)
> +{
> +	/* Control point handler - implementation TBD */
> +}
> +
> +/* Data Ready =E2=80=93 returns the latest ranging counter. */
> +static void ras_data_ready_read_cb(struct gatt_db_attribute *attrib,
> +				=C2=A0=C2=A0 unsigned int id, uint16_t offset,
> +				=C2=A0=C2=A0 uint8_t opcode, struct bt_att
> *att,
> +				=C2=A0=C2=A0 void *user_data)
> +{
> +	uint16_t counter =3D 0;
> +	uint8_t value[2];
> +
> +	put_le16(counter, value);
> +	gatt_db_attribute_read_result(attrib, id, 0, value,
> sizeof(value));
> +}
> +
> +/* Data Overwritten =E2=80=93 indicates how many results were overwritte=
n.
> */
> +static void ras_data_overwritten_read_cb(struct gatt_db_attribute
> *attrib,
> +					 unsigned int id, uint16_t
> offset,
> +					 uint8_t opcode, struct
> bt_att *att,
> +					 void *user_data)
> +{
> +	uint8_t value[2] =3D { 0x00, 0x00 };
> +
> +	gatt_db_attribute_read_result(attrib, id, 0, value,
> sizeof(value));
> +}
> +
> +/* Service registration =E2=80=93 store attribute pointers */
> +static struct ras *register_ras_service(struct gatt_db *db)
> +{
> +	struct ras *ras;
> +	struct gatt_db_attribute *service;
> +	bt_uuid_t uuid;
> +
> +	if (!db)
> +		return NULL;
> +
> +	ras =3D new0(struct ras, 1);
> +	if (!ras)
> +		return NULL;
> +
> +	/* Primary RAS service */
> +	bt_uuid16_create(&uuid, RAS_UUID16);
> +	service =3D gatt_db_add_service(db, &uuid, true,
> RAS_TOTAL_NUM_HANDLES);
> +	if (!service) {
> +		free(ras);
> +		return NULL;
> +	}
> +
> +	ras->svc =3D service;
> +
> +	/* RAS Features */
> +	bt_uuid16_create(&uuid, RAS_FEATURES_UUID);
> +		ras->feat_chrc =3D
> +		gatt_db_service_add_characteristic(ras->svc, &uuid,
> +						=C2=A0 BT_ATT_PERM_READ |
> +						=C2=A0
> BT_ATT_PERM_READ_ENCRYPT,
> +						=C2=A0
> BT_GATT_CHRC_PROP_READ,
> +						=C2=A0
> ras_features_read_cb,
> +						=C2=A0 NULL, ras);
> +
> +	/* Real-time Ranging Data */
> +	bt_uuid16_create(&uuid, RAS_REALTIME_DATA_UUID);
> +	ras->realtime_chrc =3D
> +		gatt_db_service_add_characteristic(ras->svc, &uuid,
> +						=C2=A0 BT_ATT_PERM_READ |
> +						=C2=A0
> BT_ATT_PERM_READ_ENCRYPT,
> +						=C2=A0
> BT_GATT_CHRC_PROP_NOTIFY |
> +						=C2=A0
> BT_GATT_CHRC_PROP_INDICATE,
> +						=C2=A0 NULL, NULL, ras);
> +
> +	ras->realtime_chrc_ccc =3D
> +		gatt_db_service_add_ccc(ras->svc,
> +					BT_ATT_PERM_READ |
> +					BT_ATT_PERM_WRITE);
> +
> +	/* On-demand Ranging Data */
> +	bt_uuid16_create(&uuid, RAS_ONDEMAND_DATA_UUID);
> +	ras->ondemand_chrc =3D
> +		gatt_db_service_add_characteristic(ras->svc, &uuid,
> +						=C2=A0 BT_ATT_PERM_READ |
> +						=C2=A0
> BT_ATT_PERM_READ_ENCRYPT,
> +						=C2=A0
> BT_GATT_CHRC_PROP_NOTIFY |
> +						=C2=A0
> BT_GATT_CHRC_PROP_INDICATE,
> +						=C2=A0
> ras_ondemand_read_cb, NULL,
> +						=C2=A0 ras);
> +
> +	gatt_db_service_add_ccc(ras->svc,
> +				BT_ATT_PERM_READ |
> BT_ATT_PERM_WRITE);
> +
> +	/* RAS Control Point */
> +	bt_uuid16_create(&uuid, RAS_CONTROL_POINT_UUID);
> +	ras->cp_chrc =3D
> +		gatt_db_service_add_characteristic(ras->svc, &uuid,
> +						=C2=A0 BT_ATT_PERM_WRITE
> |
> +						=C2=A0
> BT_ATT_PERM_WRITE_ENCRYPT,
> +				BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP
> |
> +						=C2=A0
> BT_GATT_CHRC_PROP_INDICATE,
> +						=C2=A0 NULL,
> +						=C2=A0
> ras_control_point_write_cb,
> +						=C2=A0 ras);
> +
> +	gatt_db_service_add_ccc(ras->svc,
> +				BT_ATT_PERM_READ |
> BT_ATT_PERM_WRITE);
> +
> +	/* RAS Data Ready */
> +	bt_uuid16_create(&uuid, RAS_DATA_READY_UUID);
> +	ras->ready_chrc =3D
> +		gatt_db_service_add_characteristic(ras->svc, &uuid,
> +						=C2=A0 BT_ATT_PERM_READ |
> +						=C2=A0
> BT_ATT_PERM_READ_ENCRYPT,
> +						=C2=A0
> BT_GATT_CHRC_PROP_READ |
> +						=C2=A0
> BT_GATT_CHRC_PROP_NOTIFY |
> +						=C2=A0
> BT_GATT_CHRC_PROP_INDICATE,
> +						=C2=A0
> ras_data_ready_read_cb, NULL,
> +						=C2=A0 ras);
> +
> +	gatt_db_service_add_ccc(ras->svc,
> +				BT_ATT_PERM_READ |
> BT_ATT_PERM_WRITE);
> +
> +	/* RAS Data Overwritten */
> +	bt_uuid16_create(&uuid, RAS_DATA_OVERWRITTEN_UUID);
> +	ras->overwritten_chrc =3D
> +		gatt_db_service_add_characteristic(ras->svc, &uuid,
> +						=C2=A0 BT_ATT_PERM_READ |
> +						=C2=A0
> BT_ATT_PERM_READ_ENCRYPT,
> +						=C2=A0
> BT_GATT_CHRC_PROP_READ |
> +						=C2=A0
> BT_GATT_CHRC_PROP_NOTIFY |
> +						=C2=A0
> BT_GATT_CHRC_PROP_INDICATE,
> +						=C2=A0
> ras_data_overwritten_read_cb,
> +						=C2=A0 NULL, ras);
> +
> +	gatt_db_service_add_ccc(ras->svc,
> +				BT_ATT_PERM_READ |
> BT_ATT_PERM_WRITE);
> +
> +	/* Activate the service */
> +	gatt_db_service_set_active(ras->svc, true);
> +
> +	return ras;
> +}
> +
> +static struct bt_rap_db *rap_db_new(struct gatt_db *db)
> +{
> +	struct bt_rap_db *rapdb;
> +
> +	if (!db)
> +		return NULL;
> +
> +	rapdb =3D new0(struct bt_rap_db, 1);
> +	if (!rapdb)
> +		return NULL;
> +
> +	rapdb->db =3D gatt_db_ref(db);
> +
> +	if (!rap_db)
> +		rap_db =3D queue_new();
> +
> +	rapdb->ras =3D register_ras_service(db);
> +	if (rapdb->ras)
> +		rapdb->ras->rapdb =3D rapdb;
> +
> +	queue_push_tail(rap_db, rapdb);
> +
> +	return rapdb;
> +}
> +
> +static struct bt_rap_db *rap_get_db(struct gatt_db *db)
> +{
> +	struct bt_rap_db *rapdb;
> +
> +	rapdb =3D queue_find(rap_db, rap_db_match, db);
> +	if (rapdb)
> +		return rapdb;
> +
> +	return rap_db_new(db);
> +}
> +
> +void bt_rap_add_db(struct gatt_db *db)
> +{
> +	rap_db_new(db);
> +}
> +
> +unsigned int bt_rap_register(bt_rap_func_t attached, bt_rap_func_t
> detached,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 void *user_data)
> +{
> +	struct bt_rap_cb *cb;
> +	static unsigned int id;
> +
> +	if (!attached && !detached)
> +		return 0;
> +
> +	if (!bt_rap_cbs)
> +		bt_rap_cbs =3D queue_new();
> +
> +	cb =3D new0(struct bt_rap_cb, 1);
> +	cb->id =3D ++id ? id : ++id;
> +	cb->attached =3D attached;
> +	cb->detached =3D detached;
> +	cb->user_data =3D user_data;
> +
> +	queue_push_tail(bt_rap_cbs, cb);
> +
> +	return cb->id;
> +}
> +
> +static bool match_id(const void *data, const void *match_data)
> +{
> +	const struct bt_rap_cb *cb =3D data;
> +	unsigned int id =3D PTR_TO_UINT(match_data);
> +
> +	return cb->id =3D=3D id;
> +}
> +
> +bool bt_rap_unregister(unsigned int id)
> +{
> +	struct bt_rap_cb *cb;
> +
> +	cb =3D queue_remove_if(bt_rap_cbs, match_id, UINT_TO_PTR(id));
> +	if (!cb)
> +		return false;
> +
> +	free(cb);
> +
> +	return true;
> +}
> +
> +struct bt_rap *bt_rap_new(struct gatt_db *ldb, struct gatt_db *rdb)
> +{
> +	struct bt_rap *rap;
> +	struct bt_rap_db *rapdb;
> +
> +	if (!ldb)
> +		return NULL;
> +
> +	rapdb =3D rap_get_db(ldb);
> +	if (!rapdb)
> +		return NULL;
> +
> +	rap =3D new0(struct bt_rap, 1);
> +	rap->lrapdb =3D rapdb;
> +	rap->pending =3D queue_new();
> +	rap->ready_cbs =3D queue_new();
> +	rap->notify =3D queue_new();
> +
> +	if (!rdb)
> +		goto done;
> +
> +	rapdb =3D new0(struct bt_rap_db, 1);
> +	rapdb->db =3D gatt_db_ref(rdb);
> +
> +	rap->rrapdb =3D rapdb;
> +
> +done:
> +	bt_rap_ref(rap);
> +
> +	return rap;
> +}
> +
> +static void rap_pending_destroy(void *data)
> +{
> +	struct bt_rap_pending *pending =3D data;
> +	struct bt_rap *rap =3D pending->rap;
> +
> +	if (queue_remove_if(rap->pending, NULL, pending))
> +		free(pending);
> +}
> +
> +static void rap_pending_complete(bool success, uint8_t att_ecode,
> +				 const uint8_t *value, uint16_t
> length,
> +				 void *user_data)
> +{
> +	struct bt_rap_pending *pending =3D user_data;
> +
> +	if (pending->func)
> +		pending->func(pending->rap, success, att_ecode,
> value,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 length, pending->userdata);
> +}
> +
> +static void rap_register(uint16_t att_ecode, void *user_data)
> +{
> +	struct bt_rap_notify *notify =3D user_data;
> +
> +	if (att_ecode)
> +		DBG(notify->rap, "RAS register failed 0x%04x",
> att_ecode);
> +}
> +
> +static void rap_notify(uint16_t value_handle, const uint8_t *value,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t length, void *user_data)
> +{
> +	struct bt_rap_notify *notify =3D user_data;
> +
> +	if (notify->func)
> +		notify->func(notify->rap, value_handle, value,
> length,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 notify->user_data);
> +}
> +
> +static void rap_notify_destroy(void *data)
> +{
> +	struct bt_rap_notify *notify =3D data;
> +	struct bt_rap *rap =3D notify->rap;
> +
> +	if (queue_remove_if(rap->notify, NULL, notify))
> +		free(notify);
> +}
> +
> +static unsigned int bt_rap_register_notify(struct bt_rap *rap,
> +					=C2=A0=C2=A0 uint16_t value_handle,
> +					=C2=A0=C2=A0 rap_notify_t func,
> +					=C2=A0=C2=A0 void *user_data)
> +{
> +	struct bt_rap_notify *notify;
> +
> +	notify =3D new0(struct bt_rap_notify, 1);
> +	notify->rap =3D rap;
> +	notify->func =3D func;
> +	notify->user_data =3D user_data;
> +
> +	notify->id =3D bt_gatt_client_register_notify(rap->client,
> +						=C2=A0=C2=A0=C2=A0 value_handle,
> +						=C2=A0=C2=A0=C2=A0 rap_register,
> +						=C2=A0=C2=A0=C2=A0 rap_notify,
> +						=C2=A0=C2=A0=C2=A0 notify,
> +						=C2=A0=C2=A0=C2=A0
> rap_notify_destroy);
> +	if (!notify->id) {
> +		DBG(rap, "Unable to register for notifications");
> +		free(notify);
> +		return 0;
> +	}
> +
> +	queue_push_tail(rap->notify, notify);
> +
> +	return notify->id;
> +}
> +
> +static void foreach_rap_char(struct gatt_db_attribute *attr, void
> *user_data)
> +{
> +	struct bt_rap *rap =3D user_data;
> +	uint16_t value_handle;
> +	bt_uuid_t uuid;
> +	bt_uuid_t uuid_features;
> +	bt_uuid_t uuid_realtime;
> +	bt_uuid_t uuid_ondemand;
> +	bt_uuid_t uuid_cp;
> +	bt_uuid_t uuid_dataready;
> +	bt_uuid_t uuid_overwritten;
> +	struct ras *ras;
> +
> +	if (!gatt_db_attribute_get_char_data(attr, NULL,
> &value_handle,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 NULL, NULL, &uuid))
> +		return;
> +
> +	bt_uuid16_create(&uuid_features, RAS_FEATURES_UUID);
> +	bt_uuid16_create(&uuid_realtime, RAS_REALTIME_DATA_UUID);
> +	bt_uuid16_create(&uuid_ondemand, RAS_ONDEMAND_DATA_UUID);
> +	bt_uuid16_create(&uuid_cp, RAS_CONTROL_POINT_UUID);
> +	bt_uuid16_create(&uuid_dataready, RAS_DATA_READY_UUID);
> +	bt_uuid16_create(&uuid_overwritten,
> RAS_DATA_OVERWRITTEN_UUID);
> +
> +	if (!bt_uuid_cmp(&uuid, &uuid_features)) {
> +		DBG(rap, "Features characteristic found: handle
> 0x%04x",
> +		=C2=A0=C2=A0=C2=A0 value_handle);
> +
> +		ras =3D rap_get_ras(rap);
> +		if (!ras || ras->feat_chrc)
> +			return;
> +
> +		ras->feat_chrc =3D attr;
> +	}
> +
> +	if (!bt_uuid_cmp(&uuid, &uuid_realtime)) {
> +		DBG(rap, "Real Time Data characteristic found:
> handle 0x%04x",
> +		=C2=A0=C2=A0=C2=A0 value_handle);
> +
> +		ras =3D rap_get_ras(rap);
> +		if (!ras || ras->realtime_chrc)
> +			return;
> +
> +		ras->realtime_chrc =3D attr;
> +	}
> +
> +	if (!bt_uuid_cmp(&uuid, &uuid_ondemand)) {
> +		DBG(rap, "On-demand Data characteristic found:
> handle 0x%04x",
> +		=C2=A0=C2=A0=C2=A0 value_handle);
> +
> +		ras =3D rap_get_ras(rap);
> +		if (!ras || ras->ondemand_chrc)
> +			return;
> +
> +		ras->ondemand_chrc =3D attr;
> +	}
> +
> +	if (!bt_uuid_cmp(&uuid, &uuid_cp)) {
> +		DBG(rap, "Control Point characteristic found: handle
> 0x%04x",
> +		=C2=A0=C2=A0=C2=A0 value_handle);
> +
> +		ras =3D rap_get_ras(rap);
> +		if (!ras || ras->cp_chrc)
> +			return;
> +
> +		ras->cp_chrc =3D attr;
> +	}
> +
> +	if (!bt_uuid_cmp(&uuid, &uuid_dataready)) {
> +		DBG(rap, "Data Ready characteristic found: handle
> 0x%04x",
> +		=C2=A0=C2=A0=C2=A0 value_handle);
> +
> +		ras =3D rap_get_ras(rap);
> +		if (!ras || ras->ready_chrc)
> +			return;
> +
> +		ras->ready_chrc =3D attr;
> +	}
> +
> +	if (!bt_uuid_cmp(&uuid, &uuid_overwritten)) {
> +		DBG(rap, "Overwritten characteristic found: handle
> 0x%04x",
> +		=C2=A0=C2=A0=C2=A0 value_handle);
> +
> +		ras =3D rap_get_ras(rap);
> +		if (!ras || ras->overwritten_chrc)
> +			return;
> +
> +		ras->overwritten_chrc =3D attr;
> +	}
> +}
> +
> +static void foreach_rap_service(struct gatt_db_attribute *attr,
> +				void *user_data)
> +{
> +	struct bt_rap *rap =3D user_data;
> +	struct ras *ras =3D rap_get_ras(rap);
> +
> +	ras->svc =3D attr;
> +
> +	gatt_db_service_set_claimed(attr, true);
> +
> +	gatt_db_service_foreach_char(attr, foreach_rap_char, rap);
> +}
> +
> +unsigned int bt_rap_ready_register(struct bt_rap *rap,
> +				=C2=A0=C2=A0 bt_rap_ready_func_t func, void
> *user_data,
> +				=C2=A0=C2=A0 bt_rap_destroy_func_t destroy)
> +{
> +	struct bt_rap_ready *ready;
> +	static unsigned int id;
> +
> +	if (!rap)
> +		return 0;
> +
> +	DBG(rap, "bt_rap_ready_register");
> +
> +	ready =3D new0(struct bt_rap_ready, 1);
> +	ready->id =3D ++id ? id : ++id;
> +	ready->func =3D func;
> +	ready->destroy =3D destroy;
> +	ready->data =3D user_data;
> +
> +	queue_push_tail(rap->ready_cbs, ready);
> +
> +	return ready->id;
> +}
> +
> +static bool match_ready_id(const void *data, const void *match_data)
> +{
> +	const struct bt_rap_ready *ready =3D data;
> +	unsigned int id =3D PTR_TO_UINT(match_data);
> +
> +	return ready->id =3D=3D id;
> +}
> +
> +bool bt_rap_ready_unregister(struct bt_rap *rap, unsigned int id)
> +{
> +	struct bt_rap_ready *ready;
> +
> +	ready =3D queue_remove_if(rap->ready_cbs, match_ready_id,
> +				UINT_TO_PTR(id));
> +	if (!ready)
> +		return false;
> +
> +	rap_ready_free(ready);
> +
> +	return true;
> +}
> +
> +static struct bt_rap *bt_rap_ref_safe(struct bt_rap *rap)
> +{
> +	if (!rap || !rap->ref_count)
> +		return NULL;
> +
> +	return bt_rap_ref(rap);
> +}
> +
> +static void rap_notify_ready(struct bt_rap *rap)
> +{
> +	const struct queue_entry *entry;
> +
> +	if (!bt_rap_ref_safe(rap))
> +		return;
> +
> +	for (entry =3D queue_get_entries(rap->ready_cbs); entry;
> +	=C2=A0=C2=A0=C2=A0=C2=A0 entry =3D entry->next) {
> +		struct bt_rap_ready *ready =3D entry->data;
> +
> +		ready->func(rap, ready->data);
> +	}
> +
> +	bt_rap_unref(rap);
> +}
> +
> +static void rap_idle(void *data)
> +{
> +	struct bt_rap *rap =3D data;
> +
> +	rap->idle_id =3D 0;
> +	rap_notify_ready(rap);
> +}
> +
> +bool bt_rap_attach(struct bt_rap *rap, struct bt_gatt_client
> *client)
> +{
> +	bt_uuid_t uuid;
> +
> +	if (!sessions)
> +		sessions =3D queue_new();
> +
> +	queue_push_tail(sessions, rap);
> +
> +	if (!client)
> +		return true;
> +
> +	if (rap->client)
> +		return false;
> +
> +	rap->client =3D bt_gatt_client_clone(client);
> +	if (!rap->client)
> +		return false;
> +
> +	bt_gatt_client_idle_register(rap->client, rap_idle, rap,
> NULL);
> +
> +	bt_uuid16_create(&uuid, RAS_UUID16);
> +
> +	gatt_db_foreach_service(rap->lrapdb->db, &uuid,
> +				foreach_rap_service, rap);
> +
> +	return true;
> +}
> diff --git a/src/shared/rap.h b/src/shared/rap.h
> new file mode 100644
> index 000000000..488172ac6
> --- /dev/null
> +++ b/src/shared/rap.h
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * BlueZ - Bluetooth protocol stack for Linux
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its
> subsidiaries.
> + */
> +
> +#include <stdbool.h>
> +#include <inttypes.h>
> +
> +#include "src/shared/io.h"
> +#include "src/shared/gatt-client.h"
> +#include "src/shared/gatt-server.h"
> +
> +
> +struct bt_rap;
> +
> +typedef void (*bt_rap_debug_func_t)(const char *str, void
> *user_data);
> +typedef void (*bt_rap_ready_func_t)(struct bt_rap *rap, void
> *user_data);
> +typedef void (*bt_rap_destroy_func_t)(void *user_data);
> +typedef void (*bt_rap_func_t)(struct bt_rap *rap, void *user_data);
> +
> +struct bt_rap *bt_rap_ref(struct bt_rap *rap);
> +void bt_rap_unref(struct bt_rap *rap);
> +
> +void bt_rap_add_db(struct gatt_db *db);
> +
> +bool bt_rap_attach(struct bt_rap *rap, struct bt_gatt_client
> *client);
> +void bt_rap_detach(struct bt_rap *rap);
> +
> +struct bt_att *bt_rap_get_att(struct bt_rap *rap);
> +
> +bool bt_rap_set_user_data(struct bt_rap *rap, void *user_data);
> +
> +bool bt_rap_set_debug(struct bt_rap *rap, bt_rap_debug_func_t func,
> +			void *user_data, bt_rap_destroy_func_t
> destroy);
> +
> +/* session related functions */
> +unsigned int bt_rap_register(bt_rap_func_t attached, bt_rap_func_t
> detached,
> +					void *user_data);
> +unsigned int bt_rap_ready_register(struct bt_rap *rap,
> +				bt_rap_ready_func_t func, void
> *user_data,
> +				bt_rap_destroy_func_t destroy);
> +bool bt_rap_ready_unregister(struct bt_rap *rap, unsigned int id);
> +
> +bool bt_rap_unregister(unsigned int id);
> +
> +struct bt_rap *bt_rap_new(struct gatt_db *ldb, struct gatt_db *rdb);
