Received: from mail-43100.protonmail.ch (mail-43100.protonmail.ch [185.70.43.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C9628B7C8
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 04:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792040159; cv=none; b=OEsJJBrGxieoL9lH5ik2S0p5IBhbYkoFhr3aRSe3MUoJmPiPMaNWVhwU+QimmOrVysFPgfl2XU77QtFm54RLfKTTevuZ779S5MgZMTS1cH8MgzqkOKg7MDuyGoxINZCWSIkudqSlPtLr7LIrTokIUwMIMJOjhYg0CTQqGah07AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792040159; c=relaxed/simple;
	bh=n9IJ8R+tp6M8H1KFG5jfTwT8EqTTQrJX99qx2W5leEA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Mzr8VnwMMOX1Do7SaRfDSTrA1OYR1Hmd7kOIUm0kq02J378Vje0czITuvxeZD9VavAtkuO0RrtWuzYd+3htGt0JT/j5mzFX738QrNZWOuwlubjU4EwApU+XIc8LUQGDuuT54TESHfE035lXhZBH0S1U4e9FE6301Vg9cN9g4NOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=PDEemaBI; arc=none smtp.client-ip=185.70.43.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="PDEemaBI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1792040150; x=1792299350;
	bh=BTy/QsRpWmI8/t2T5MZ23TWRdyLruqbvmsv8V2UWjGU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=PDEemaBI4JVfIFqjPxmys1oU/k6TZ2gopYaUC5ouY6mXumOT43C2PNB/ADCiQvNnu
	 wxs3j9GY5WulnxTuvWtpjuZrpr27RzBJKWrW2lb00euVuD0OPhSRJWxtSsyLkmX5T2
	 YiaO2+uzadcAlNz4GLDwQqC+CFl4+2kizxqpMFdMw2ndmBrgqkRaDLejmB5IVAq66/
	 uew8qbYoDQLHfw32+eQfcM2hKrlnS7ygCT0/ZCoOdjDAaY2jT8X14nnxrmqXRInaK1
	 5ACwwWVKTZpxaDuXd9raUQYkV5cxM7KToOwLAz6Hs+ORCebPLQ09taLH/WG8y3930R
	 quSB+xCT1SlQw==
Date: Thu, 15 Oct 2026 04:55:44 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [RFC PATCH 1/2] shared/asha: Cancel callbacks before resetting the device
Message-ID: <20261015045525.66971-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 632fd9b2292efa1ca489edf8c9f3dfd8cca4921c
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Track and cancel the pending ACP request before releasing stream state.
Detach state callbacks before invoking an owner that may remove the device.
Send STOP when canceling a START that is already queued.

Detach set membership before clearing its identity, retain replacement
members and clear notification registration on reset.

Fixes: 8e4bece63ce9 ("src/shared: Add initial implementation for an ASHA pr=
ofile")
Fixes: f44d3e08e9a1 ("shared/asha: Add support for other side update")
Assisted-by: OpenCode:gpt-6.1-sol
---
First of two new patches. Apply on BlueZ dd9d5ba1fa4f with the already-sent
STATUS v2 and STOP changes, in that order. These prerequisites are not rese=
nt:
https://lore.kernel.org/linux-bluetooth/20261013222556.513513-1-cochcoder@p=
roton.me/
https://lore.kernel.org/linux-bluetooth/20261013034345.513789-1-cochcoder@p=
roton.me/

This patch handles pending ACP request/callback ownership, cancellation and
set/notification reset. Patch 2 uses these lifecycle operations to gate ASH=
A
startup and stop acquired streams after incompatible completed intervals.

The prerequisite alone passes its ASHA sanitizer fixtures. The combined
standalone source passes 38/38 strict-maintainer ASan/UBSan and 38/38 ordin=
ary
LTO unit binaries. The full strict-maintainer plus LTO combination retains
documented baseline GATT/monitor errors; it is not claimed passing.

The Arch integration was built in a clean chroot and is reported working on
hardware. That trial also includes other existing runtime fixes; it is not
isolated attribution or coverage of every cancellation/teardown interleavin=
g.
No remote CI, severity assessment or proof of all surrounding lifetimes is =
claimed.

 src/shared/asha.c         |  63 +++++++++++-------
 src/shared/asha.h         |   1 +
 unit/test-asha-interval.c | 137 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 177 insertions(+), 24 deletions(-)

diff --git a/src/shared/asha.c b/src/shared/asha.c
index f73bbce1d5..e6862e8423 100644
--- a/src/shared/asha.c
+++ b/src/shared/asha.c
@@ -106,10 +106,10 @@ static void update_asha_set(struct bt_asha *asha, boo=
l connected)
 =09=09=09return;
 =09=09}
=20
-=09=09if (asha->right_side && set->right) {
+=09=09if (asha->right_side && set->right =3D=3D asha) {
 =09=09=09set->right =3D NULL;
 =09=09=09DBG("Right side unregistered for ASHA set");
-=09=09} else if (!asha->right_side && set->left) {
+=09=09} else if (!asha->right_side && set->left =3D=3D asha) {
 =09=09=09set->left =3D NULL;
 =09=09=09DBG("Left side unregistered for ASHA set");
 =09=09}
@@ -163,9 +163,13 @@ struct bt_asha *bt_asha_new(void)
=20
 void bt_asha_reset(struct bt_asha *asha)
 {
+=09bt_asha_state_reset(asha);
+=09update_asha_set(asha, false);
+
 =09if (asha->status_notify_id) {
 =09=09bt_gatt_client_unregister_notify(asha->client,
 =09=09=09=09=09=09asha->status_notify_id);
+=09=09asha->status_notify_id =3D 0;
 =09}
=20
 =09gatt_db_unref(asha->db);
@@ -174,19 +178,20 @@ void bt_asha_reset(struct bt_asha *asha)
 =09bt_gatt_client_unref(asha->client);
 =09asha->client =3D NULL;
=20
-=09bt_asha_state_reset(asha);
-
 =09asha->psm =3D 0;
 =09memset(asha->hisyncid, 0, sizeof(asha->hisyncid));
=20
 =09asha->attach_cb =3D NULL;
 =09asha->attach_cb_data =3D NULL;
-
-=09update_asha_set(asha, false);
 }
=20
 void bt_asha_state_reset(struct bt_asha *asha)
 {
+=09if (asha->acp_id) {
+=09=09bt_gatt_client_cancel(asha->client, asha->acp_id);
+=09=09asha->acp_id =3D 0;
+=09}
+
 =09asha->state =3D ASHA_STOPPED;
=20
 =09asha->state_cb =3D NULL;
@@ -195,33 +200,40 @@ void bt_asha_state_reset(struct bt_asha *asha)
=20
 void bt_asha_free(struct bt_asha *asha)
 {
-=09update_asha_set(asha, false);
-=09gatt_db_unref(asha->db);
-=09bt_gatt_client_unref(asha->client);
+=09bt_asha_reset(asha);
 =09free(asha);
 }
=20
 static void asha_acp_sent(bool success, uint8_t err, void *user_data)
 {
 =09struct bt_asha *asha =3D user_data;
+=09bt_asha_cb_t callback =3D asha->state_cb;
+=09void *data =3D asha->state_cb_data;
+
+=09asha->acp_id =3D 0;
=20
 =09if (success) {
 =09=09DBG("AudioControlPoint command successfully sent");
 =09} else {
 =09=09error("Failed to send AudioControlPoint command: %d", err);
=20
-=09=09if (asha->state_cb)
-=09=09=09asha->state_cb(-1, asha->state_cb_data);
-
 =09=09bt_asha_state_reset(asha);
+
+=09=09if (callback)
+=09=09=09callback(-1, data);
 =09}
 }
=20
 static int asha_send_acp(struct bt_asha *asha, uint8_t *cmd,
 =09=09unsigned int len, bt_asha_cb_t cb, void *user_data)
 {
-=09if (!bt_gatt_client_write_value(asha->client, asha->acp_handle, cmd,
-=09=09=09=09len, asha_acp_sent, asha, NULL)) {
+=09if (asha->acp_id)
+=09=09bt_gatt_client_cancel(asha->client, asha->acp_id);
+
+=09asha->acp_id =3D bt_gatt_client_write_value(asha->client,
+=09=09=09=09asha->acp_handle, cmd, len, asha_acp_sent,
+=09=09=09=09asha, NULL);
+=09if (!asha->acp_id) {
 =09=09error("Error writing ACP command");
 =09=09return -1;
 =09}
@@ -307,18 +319,17 @@ unsigned int bt_asha_stop(struct bt_asha *asha)
 =09};
 =09int ret;
=20
-=09if (asha->state !=3D ASHA_STARTED)
+=09if (asha->state =3D=3D ASHA_STOPPED)
 =09=09return 0;
=20
-=09asha->state =3D ASHA_STOPPED;
+=09/* Cancel a pending START before queuing STOP on the same ATT link. */
+=09bt_asha_state_reset(asha);
=20
 =09/* State is reset below without waiting for an ATT response. */
 =09ret =3D asha_send_acp_without_response(asha, acp_stop_cmd,
 =09=09=09sizeof(acp_stop_cmd));
 =09asha_set_send_status(asha, false);
=20
-=09/* We reset our state without waiting for a response */
-=09bt_asha_state_reset(asha);
 =09DBG("ASHA stop done");
=20
 =09return ret;
@@ -468,10 +479,17 @@ static void audio_status_notify(uint16_t value_handle=
, const uint8_t *value,
 =09=09=09=09=09uint16_t length, void *user_data)
 {
 =09struct bt_asha *asha =3D user_data;
-=09uint8_t status =3D *value;
+=09uint8_t status;
 =09/* Back these up to survive the reset paths */
 =09bt_asha_cb_t state_cb =3D asha->state_cb;
-=09bt_asha_cb_t state_cb_data =3D asha->state_cb_data;
+=09void *state_cb_data =3D asha->state_cb_data;
+
+=09if (length !=3D 1)
+=09=09return;
+
+=09status =3D value[0];
+=09asha->state_cb =3D NULL;
+=09asha->state_cb_data =3D NULL;
=20
 =09DBG("ASHA status %u", status);
=20
@@ -487,11 +505,8 @@ static void audio_status_notify(uint16_t value_handle,=
 const uint8_t *value,
 =09=09}
 =09}
=20
-=09if (state_cb) {
+=09if (state_cb)
 =09=09state_cb(status, state_cb_data);
-=09=09asha->state_cb =3D NULL;
-=09=09asha->state_cb_data =3D NULL;
-=09}
 }
=20
 static void handle_characteristic(struct gatt_db_attribute *attr,
diff --git a/src/shared/asha.h b/src/shared/asha.h
index e6b2e7a0d2..cbacb5ddff 100644
--- a/src/shared/asha.h
+++ b/src/shared/asha.h
@@ -31,6 +31,7 @@ struct bt_asha {
 =09uint16_t acp_handle;
 =09uint16_t volume_handle;
 =09unsigned int status_notify_id;
+=09unsigned int acp_id;
=20
 =09uint16_t psm;
 =09bool right_side;
diff --git a/unit/test-asha-interval.c b/unit/test-asha-interval.c
index 8cb77c07d3..5432cfb041 100644
--- a/unit/test-asha-interval.c
+++ b/unit/test-asha-interval.c
@@ -3,13 +3,136 @@
=20
 /* Redirect source-level calls so LTO cannot bypass the GATT mock. */
 #define bt_gatt_client_write_without_response test_gatt_write
+#define bt_gatt_client_write_value test_gatt_request
+#define bt_gatt_client_cancel test_gatt_cancel
+#define bt_gatt_client_unref test_client_unref
+#define bt_gatt_client_unregister_notify test_unregister_notify
 #include "src/shared/asha.c"
 #undef bt_gatt_client_write_without_response
+#undef bt_gatt_client_write_value
+#undef bt_gatt_client_cancel
+#undef bt_gatt_client_unref
+#undef bt_gatt_client_unregister_notify
 #include "src/shared/tester.h"
=20
 static unsigned int writes;
 static struct bt_gatt_client *failed_client;
 static uint8_t expected_interval;
+static unsigned int cancels;
+static unsigned int callbacks;
+static unsigned int unregisters;
+static unsigned int stops;
+
+void test_client_unref(struct bt_gatt_client *client)
+{
+}
+
+bool test_unregister_notify(struct bt_gatt_client *client, unsigned int id=
)
+{
+=09assert(client && id =3D=3D 7);
+=09unregisters++;
+=09return true;
+}
+
+unsigned int test_gatt_request(struct bt_gatt_client *client, uint16_t han=
dle,
+=09=09=09const uint8_t *value, uint16_t length,
+=09=09=09bt_gatt_client_callback_t callback, void *user_data,
+=09=09=09bt_gatt_client_destroy_func_t destroy)
+{
+=09assert(client && handle =3D=3D 0x79);
+=09assert(length =3D=3D 5 && value[0] =3D=3D 1);
+=09return 42;
+}
+
+bool test_gatt_cancel(struct bt_gatt_client *client, unsigned int id)
+{
+=09assert(client && id =3D=3D 42);
+=09cancels++;
+=09return true;
+}
+
+static void state_callback(int status, void *user_data)
+{
+=09struct bt_asha *asha =3D user_data;
+
+=09assert(asha->state =3D=3D ASHA_STOPPED);
+=09assert(!asha->state_cb && !asha->state_cb_data);
+=09callbacks++;
+}
+
+static void test_start_cancel(const void *user_data)
+{
+=09struct bt_asha asha =3D { .client =3D (void *) 1, .acp_handle =3D 0x79 =
};
+
+=09cancels =3D callbacks =3D 0;
+=09assert(!bt_asha_start(&asha, state_callback, &asha));
+=09bt_asha_state_reset(&asha);
+=09assert(cancels =3D=3D 1 && !callbacks);
+=09bt_asha_state_reset(&asha);
+=09assert(cancels =3D=3D 1);
+=09assert(!bt_asha_start(&asha, state_callback, &asha));
+=09asha_acp_sent(false, 1, &asha);
+=09assert(callbacks =3D=3D 1 && cancels =3D=3D 1);
+=09tester_test_passed();
+}
+
+static void test_start_stop(const void *user_data)
+{
+=09struct bt_asha asha =3D { .client =3D (void *) 1, .acp_handle =3D 0x79 =
};
+=09uint8_t status =3D 0;
+
+=09cancels =3D callbacks =3D stops =3D 0;
+=09assert(!bt_asha_start(&asha, state_callback, &asha));
+=09assert(!bt_asha_stop(&asha));
+=09assert(cancels =3D=3D 1 && stops =3D=3D 1 && !asha.state_cb);
+=09audio_status_notify(1, &status, 1, &asha);
+=09assert(asha.state =3D=3D ASHA_STOPPED && !callbacks);
+=09assert(!bt_asha_stop(&asha) && stops =3D=3D 1);
+=09tester_test_passed();
+}
+
+static void test_status_callback(const void *user_data)
+{
+=09struct bt_asha asha =3D { .client =3D (void *) 1, .acp_handle =3D 0x79 =
};
+=09uint8_t status =3D 1;
+
+=09callbacks =3D 0;
+=09assert(!bt_asha_start(&asha, state_callback, &asha));
+=09asha_acp_sent(true, 0, &asha);
+=09audio_status_notify(1, NULL, 0, &asha);
+=09assert(!callbacks && asha.state_cb =3D=3D state_callback);
+=09audio_status_notify(1, &status, 1, &asha);
+=09assert(callbacks =3D=3D 1);
+=09tester_test_passed();
+}
+
+static void test_pair_reset(const void *user_data)
+{
+=09struct bt_asha left =3D { .hisyncid =3D { 1 } };
+=09struct bt_asha right =3D { .hisyncid =3D { 1 }, .right_side =3D true };
+=09struct bt_asha replacement =3D { .hisyncid =3D { 1 } };
+=09struct bt_asha_set *set;
+
+=09asha_devices =3D queue_new();
+=09update_asha_set(&left, true);
+=09update_asha_set(&right, true);
+=09update_asha_set(&replacement, true);
+=09bt_asha_reset(&left);
+=09set =3D find_asha_set(&right);
+=09assert(set && set->left =3D=3D &replacement && set->right =3D=3D &right=
);
+=09bt_asha_reset(&replacement);
+=09assert(!set->left && set->right =3D=3D &right);
+=09bt_asha_reset(&right);
+=09assert(!asha_devices);
+
+=09right.client =3D (void *) 1;
+=09right.status_notify_id =3D 7;
+=09unregisters =3D 0;
+=09bt_asha_reset(&right);
+=09bt_asha_reset(&right);
+=09assert(unregisters =3D=3D 1 && !right.status_notify_id);
+=09tester_test_passed();
+}
=20
 void btd_error(uint16_t index, const char *format, ...)
 {
@@ -26,6 +149,13 @@ unsigned int test_gatt_write(
 =09assert(client);
 =09assert(handle =3D=3D 0x79);
 =09assert(!signed_write);
+
+=09if (length =3D=3D 1) {
+=09=09assert(value[0] =3D=3D 0x02);
+=09=09stops++;
+=09=09return true;
+=09}
+
 =09assert(length =3D=3D 3);
 =09assert(value[0] =3D=3D 0x03 && value[1] =3D=3D 0x02);
 =09assert(value[2] =3D=3D expected_interval);
@@ -100,5 +230,12 @@ int main(int argc, char *argv[])
 {
 =09tester_init(&argc, &argv);
 =09tester_add("ASHA/interval/pair", NULL, NULL, test_interval, NULL);
+=09tester_add("ASHA/start/cancel", NULL, NULL, test_start_cancel, NULL);
+=09tester_add("ASHA/start/stop-pending", NULL, NULL,
+=09=09=09=09=09=09=09test_start_stop, NULL);
+=09tester_add("ASHA/start/status-callback", NULL, NULL,
+=09=09=09=09=09=09test_status_callback, NULL);
+=09tester_add("ASHA/interval/pair-reset", NULL, NULL,
+=09=09=09=09=09=09=09test_pair_reset, NULL);
 =09return tester_run();
 }

base-commit: dd9d5ba1fa4f682b082b1275a8c38523d95a58fd
prerequisite-patch-id: ddf57fe789414af62220e755ca04c36ec8d46260
prerequisite-patch-id: 612e58f161bb31025d30aabe6a68809255e314ba

