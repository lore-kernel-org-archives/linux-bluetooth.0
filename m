Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E18437C0F0
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 20:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773779229; cv=none; b=Up9u49g9eBHlpWZ3+KLacxJGT5jJHBT9XKoBPa7ENTiH297M4glGJuQONj50NsN437YwsR4fmMcNTwzyIVFQ25OTYMy5dqsmk79Ye9nDZpRZ0OTiHBSqnfe3Pt36XAVCUdSAYzVQaGyhhikn6GecP557MF+WhnIxczFNU3XCKQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773779229; c=relaxed/simple;
	bh=+1Jqn2DgNwpYV8NicwAmicOAOjZkJlIkbG+Tlu/S7dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MknMsXNYUUKy4TdtL2+QJECBZ8ECTdwVr5Hl1zdhj31QZuY7cxr34ylM9l7zqYqOMbbJizde873zraMQ/ia0JwKUTJiy4kXyfB3dnDBKQN7onLpgKH3icEfB9gZyR8Xu/e22CWjusfASohHuKPIzYkf9O5asktdXZdqfM1N/Q10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b=mISgg08I; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b="mISgg08I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1773779225; x=1774384025; i=martinbts@gmx.net;
	bh=5Ar5VowuxiKr/LUTSxFWweDLiV0kcwLYj/oNb4up/Ds=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mISgg08IIQ9sZGyiOAPjedkweuWkQl6yNFQmEWs6WgKxToKy8BQ3z7NpR8XfUCHu
	 3SRa8IZX1pF9R0GsSExDtRseXzEib4eiZaTQdzFYNFKAeU3yBQNDBHg8kclxj0cVM
	 hnK9FWScG5YP75KkRiluCYlcBAc7C0bYJmKBBuaJtNJLms0puXzVf34QGEkQ6cWas
	 zAfWwDEQ4pXFIZhOkFFaTBVD9gkubWTuXFdjuPe72ZbL5BBduZCBop0TFtncQOndg
	 tphokYw4Ehj5VOHmtdhNPkHFJsdZitKdOo6Wwbh0CpEdtGmUyqughSO8VEf3aAkDk
	 rh+88KhkMuMb7NyiRg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBUm7-1vsvyA1eyF-008kHP; Tue, 17
 Mar 2026 21:27:05 +0100
From: Martin BTS <martinbts@gmx.net>
To: linux-bluetooth@vger.kernel.org
Cc: hadess@hadess.net,
	luiz.dentz@gmail.com,
	vi@endrift.com,
	Martin BTS <martinbts@gmx.net>,
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: [PATCH BlueZ v3 2/6] shared/gatt: Add timeout for secondary service discovery
Date: Tue, 17 Mar 2026 21:26:28 +0100
Message-ID: <20260317202637.158997-3-martinbts@gmx.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317202637.158997-1-martinbts@gmx.net>
References: <20260317202637.158997-1-martinbts@gmx.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mpYEBnRIlPrqnqZQj+d3VS8ZFHq7Woe4KnhxQhJ58ik/Tc9dzzC
 WvG80ZKGZkErcTHo8K55Ec/tX710SmM/mGhWakv+n4cZG8EITsnESN68lFIUjwZLtEcS6rJ
 Ldb2g9ppM/72ZaXpCVNuKLtMAyYA8q1ESbzitcG5nIZc0fXpp7ks+bBdMJNWFFWvJi9YUL3
 eUK9NtVFhyVJwFFWazPaA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nrtZJMindHA=;NIWWfCa4Y9ypmIzSs1r2mOxNVED
 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

Some BLE devices do not respond to secondary service discovery
requests, causing the 30-second ATT timeout to fire and terminate the
connection. Add a 2-second timeout at the GATT client level that
cancels the pending ATT request and proceeds as if no secondary
services were found. This prevents the ATT timeout from killing the
connection while still giving well-behaved devices enough time to
respond.

Co-Authored-By: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
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

