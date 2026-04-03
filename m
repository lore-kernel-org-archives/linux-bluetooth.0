Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697F9329C57
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775206599; cv=none; b=DeAJ3QAAvJjn4xPHNoatzfuTN2jYmanJG5/DTykxdooEFR2umtfvPBtEXsMLEb63gSyP5lba8stpbapflFuKI5aM5bNH2pRn874LghsZNzmU9dmub4qTcBT2gm0hChBdD2kpkSpxJRRksw+QLwZGBE6aNF+gM8mvZFROgMPPz1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775206599; c=relaxed/simple;
	bh=+N5KZaJxqmt0MCelTJwzlMXRZJltpO/IR6keB2uVoys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jmvy+HLDY/S7QhS3JSGiEHAiUQq233f8zBHwBGOxbdFKEjYGnaHZD1kdg2l2+oBgSnhUheLZrn1woGGF76T77Bm+UVMBetFRZJmvKnrjJuEvG2HoXBQVQgGfii0JzLp4VsMONnVztpjtMW4m3zbGmcQV9mCtjN+Pk7vEYNY8fWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b=QpevXC+Q; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b="QpevXC+Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1775206594; x=1775811394; i=martinbts@gmx.net;
	bh=focvSS0+DEpJo5zXv6DUeL5MQUKzKnkTezf8QdSUXVE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QpevXC+Q7KaLxvKabK2MB9FRrPBniU5FPjaAB350D+B8TFvQvr4CmEEk5mLND1J4
	 iuaM5AjrbJiN9tTwLM/799uN1AEppC1EgH0M+IxoEiZDj4rHSyHaJPdcUhHustXAs
	 YpvtLbFjIh0l9AG8drxveLRhSTcdmQq1CrfP9Mn6vrpgqLilflEZ1S0PJ6E+fSnuG
	 WRlDXnSljMT9Y8QAwYhmUylLok4SAHNbh0NH1nbtaYn/lMKkVA5oYcgCPCLlwyXi4
	 oDCr//unfxlc+h7uW1e8QzrC+/wu/z+iSOevwznQbtHa0yPIEuIfEyKQvFXRc8mFm
	 smwq27E7idOKRhO3Aw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5mKJ-1vRxNZ1hQB-0135zr; Fri, 03
 Apr 2026 10:56:34 +0200
From: Martin BTS <martinbts@gmx.net>
To: linux-bluetooth@vger.kernel.org
Cc: hadess@hadess.net,
	luiz.dentz@gmail.com,
	vi@endrift.com,
	Martin BTS <martinbts@gmx.net>
Subject: [PATCH BlueZ v3 2/6] shared/gatt: Add timeout for secondary service discovery
Date: Fri,  3 Apr 2026 10:55:49 +0200
Message-ID: <20260403085555.23871-3-martinbts@gmx.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260403085555.23871-1-martinbts@gmx.net>
References: <20260403085555.23871-1-martinbts@gmx.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PPeMc1K1i6GP+ke7IrfbKTujkYY1dHK1/5GexxSUimgSr02/zfV
 ysWpTw4jguh8JA2mWPZhgYjr5v028f++bLEgTAGW6c99tgrqAcG6GqKwU1S/TBGnhasuegD
 nMYibzHdARpfMyIhXjsEYe6sFRogeoauiWLedpkB5IImaCKAWJyntIlKfodBMqZYU5VKBrH
 E2ChgJLfQrE9Q+iwNjUdA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NnvJiYT2ZKY=;aLPOGCOXSxlF3gTcQKt09jNDulA
 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
 yR8xywT5ydb

Some BLE devices do not respond to secondary service discovery
requests, causing the 30-second ATT timeout to fire and terminate the
connection. Add a 2-second timeout at the GATT client level that
cancels the pending ATT request and proceeds as if no secondary
services were found. This prevents the ATT timeout from killing the
connection while still giving well-behaved devices enough time to
respond.
=2D--
 src/shared/gatt-client.c | 62 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index e1685809f..3e1c3e525 100644
=2D-- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -20,6 +20,7 @@
 #include "src/shared/queue.h"
 #include "src/shared/gatt-db.h"
 #include "src/shared/gatt-client.h"
+#include "src/shared/timeout.h"
=20
 #include <assert.h>
 #include <limits.h>
@@ -33,6 +34,8 @@
 #define MIN(a, b) ((a) < (b) ? (a) : (b))
 #endif
=20
+#define SECONDARY_DISC_TIMEOUT	2000	/* 2 seconds in ms */
+
 #define UUID_BYTES (BT_GATT_UUID_SIZE * sizeof(uint8_t))
=20
 #define GATT_SVC_UUID	0x1801
@@ -114,6 +117,7 @@ struct bt_gatt_client {
 	unsigned int next_request_id;
=20
 	struct bt_gatt_request *discovery_req;
+	unsigned int sec_disc_timeout_id;
 	unsigned int mtu_req_id;
=20
 	/* Pending retry operation for DB out of sync handling */
@@ -1231,6 +1235,42 @@ static bool discovery_parse_services(struct discove=
ry_op *op, bool primary,
 	return true;
 }
=20
+struct sec_disc_timeout_data {
+	struct bt_gatt_client *client;
+	struct discovery_op *op;
+};
+
+static bool sec_disc_timeout_cb(void *user_data)
+{
+	struct sec_disc_timeout_data *data =3D user_data;
+	struct bt_gatt_client *client =3D data->client;
+	struct discovery_op *op =3D data->op;
+
+	DBG(client, "Secondary service discovery timed out, proceeding");
+
+	client->sec_disc_timeout_id =3D 0;
+
+	/* Cancel the pending ATT request before it hits the 30s ATT timeout */
+	if (client->discovery_req) {
+		bt_gatt_request_cancel(client->discovery_req);
+		bt_gatt_request_unref(client->discovery_req);
+		client->discovery_req =3D NULL;
+	}
+
+	/* Treat as success =E2=80=94 no secondary services found */
+	discovery_op_complete(op, true, 0);
+
+	return false;
+}
+
+static void sec_disc_timeout_destroy(void *user_data)
+{
+	struct sec_disc_timeout_data *data =3D user_data;
+
+	discovery_op_unref(data->op);
+	free(data);
+}
+
 static void discover_secondary_cb(bool success, uint8_t att_ecode,
 						struct bt_gatt_result *result,
 						void *user_data)
@@ -1242,6 +1282,11 @@ static void discover_secondary_cb(bool success, uin=
t8_t att_ecode,
=20
 	discovery_req_clear(client);
=20
+	if (client->sec_disc_timeout_id) {
+		timeout_remove(client->sec_disc_timeout_id);
+		client->sec_disc_timeout_id =3D 0;
+	}
+
 	if (!success) {
 		switch (att_ecode) {
 		case BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND:
@@ -1354,8 +1399,18 @@ secondary:
 						discover_secondary_cb,
 						discovery_op_ref(op),
 						discovery_op_unref);
-	if (client->discovery_req)
+	if (client->discovery_req) {
+		struct sec_disc_timeout_data *td;
+
+		td =3D new0(struct sec_disc_timeout_data, 1);
+		td->client =3D client;
+		td->op =3D discovery_op_ref(op);
+		client->sec_disc_timeout_id =3D timeout_add(
+						SECONDARY_DISC_TIMEOUT,
+						sec_disc_timeout_cb, td,
+						sec_disc_timeout_destroy);
 		return;
+	}
=20
 	DBG(client, "Failed to start secondary service discovery");
=20
@@ -2822,6 +2877,11 @@ bool bt_gatt_client_cancel_all(struct bt_gatt_clien=
t *client)
=20
 	queue_remove_all(client->pending_requests, NULL, NULL, cancel_pending);
=20
+	if (client->sec_disc_timeout_id) {
+		timeout_remove(client->sec_disc_timeout_id);
+		client->sec_disc_timeout_id =3D 0;
+	}
+
 	if (client->discovery_req) {
 		bt_gatt_request_cancel(client->discovery_req);
 		bt_gatt_request_unref(client->discovery_req);
=2D-=20
2.47.3

