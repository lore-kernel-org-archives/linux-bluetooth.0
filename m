Received: from mail-106119.protonmail.ch (mail-106119.protonmail.ch [79.135.106.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD4C4718CF
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 03:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863052; cv=none; b=VYRoy1ZrLZairoHWldexQBgxPzovzk/QpUDnUsA+uRXZH+icxU0bhNb6VYI+t9GevdC+o1QJQC/tAuLzT69y9+GGGRO73nbS2VxrOA66YeGbHiZ8EpAWCiQHuBX9BEeoHwe4q0IlSscZ2qpkq6xyqegT8vYCxMpARdPacEoLViI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863052; c=relaxed/simple;
	bh=fREBOrSzaEYkZ0DMnh4y2g6Ix89+NWzLejauzh0XR10=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=AQbfREHs4rxIRi11JeREDq1tC7ls70Ew97llA6fYZZgDxHUWGX5zP0R54MwVmt1/Q/q4vpon2teTP0APjzC52NZpkI84hX2azvPyDhFYlcmToZsqqx7d4hhYpJp8cs8YAv98PPBqC/qgV8FLSMygoMHS6Gyoi9LY0gXvNk0hOkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=gM9Q043n; arc=none smtp.client-ip=79.135.106.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="gM9Q043n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1791863045; x=1792122245;
	bh=UI92Wblirhltddft1bFBKlMJ+BzxtwJr+EaHryIUPeQ=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=gM9Q043nCItHEcpdbau/vIstYu0kStYP3ShhyxFZqalPYVWC+9ondogEXQ28gkSMb
	 egIHrsdzPWRVaSMFjTfYhhAzrPQ91+lp+xOfoGO0lRWn8VK3zZr53a0WaCcfC12KZp
	 JgmcjgoM7IJZ5skWT4FUDyoun5AJX3uzbCxMH+xO5S+tzLjEPjZc5yDCtAGUid+/Rf
	 ZdxjD7u5F6qNM1FxIMlfcdaELDslZL6UIAdjChMgibG1pP1rfKogSVD6bUgC5WRAyZ
	 x4FxnahIHGXHg46TTIdViPzP2CSR391cWOyjU4JhC1OziroquofxgScUndzqJXV2s/
	 ByguAVT9JJpwQ==
Date: Tue, 13 Oct 2026 03:44:02 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] shared/asha: send STOP without waiting for a response
Message-ID: <20261013034345.513789-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: bd9d9a5b6960381021c707517e91834b23e7399c
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

STOP resets local state without consuming the ATT response. Use a Write
Command so an unresponsive renderer does not hold the request queue
until timeout.

Test command semantics, failure handling and peer STATUS notification.

Fixes: 9948168cca15 ("shared/asha: Don't wait for status notification on st=
op")
Assisted-by: OpenCode:gpt-6.1-sol
---
Submission review notes (not part of the commit message):
Local validation is for base 7428ca2df9356363079db0f48412c20cbdb9471f.
Compatibility with newer upstream tips has not been verified locally.
This topic uses the verified STOP introducing commit as its Fixes tag.
Existing N8 blocking-STOP failure evidence is retained; the new unit test
mocks setup and GATT writes, not hardware or daemon concurrency.

 .gitignore            |  1 +
 Makefile.am           |  6 +++
 src/shared/asha.c     |  5 ++-
 unit/test-asha-stop.c | 97 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 107 insertions(+), 2 deletions(-)
 create mode 100644 unit/test-asha-stop.c

diff --git a/.gitignore b/.gitignore
index 06b24735df..8a4195c05a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -112,6 +112,7 @@ unit/test-lib
 unit/test-mgmt
 unit/test-uhid
 unit/test-hfp
+unit/test-asha-stop
 unit/test-crypto
 unit/test-ecc
 unit/test-hog
diff --git a/Makefile.am b/Makefile.am
index f742458d11..6016913145 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -706,6 +706,12 @@ unit_test_avrcp_LDADD =3D lib/libbluetooth-internal.la=
 \
=20
 unit_tests +=3D unit/test-hfp
=20
+unit_tests +=3D unit/test-asha-stop
+
+unit_test_asha_stop_SOURCES =3D unit/test-asha-stop.c
+unit_test_asha_stop_LDADD =3D src/libshared-glib.la \
+=09lib/libbluetooth-internal.la $(GLIB_LIBS)
+
 unit_test_hfp_SOURCES =3D unit/test-hfp.c
 unit_test_hfp_LDADD =3D src/libshared-glib.la $(GLIB_LIBS)
=20
diff --git a/src/shared/asha.c b/src/shared/asha.c
index 79bb29bf9a..0e6261d37d 100644
--- a/src/shared/asha.c
+++ b/src/shared/asha.c
@@ -284,8 +284,9 @@ unsigned int bt_asha_stop(struct bt_asha *asha)
=20
 =09asha->state =3D ASHA_STOPPED;
=20
-=09ret =3D asha_send_acp(asha, acp_stop_cmd, sizeof(acp_stop_cmd), NULL,
-=09=09=09NULL);
+=09/* State is reset below without waiting for an ATT response. */
+=09ret =3D asha_send_acp_without_response(asha, acp_stop_cmd,
+=09=09=09sizeof(acp_stop_cmd));
 =09asha_set_send_status(asha, false);
=20
 =09/* We reset our state without waiting for a response */
diff --git a/unit/test-asha-stop.c b/unit/test-asha-stop.c
new file mode 100644
index 0000000000..5ef6d03623
--- /dev/null
+++ b/unit/test-asha-stop.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+#include <assert.h>
+
+/* Source-level mocks remain effective with link-time optimization. */
+#define bt_gatt_client_write_without_response test_write_command
+#define bt_gatt_client_write_value test_write_request
+#include "src/shared/asha.c"
+#undef bt_gatt_client_write_without_response
+#undef bt_gatt_client_write_value
+#include "src/shared/tester.h"
+
+static unsigned int commands, requests, peer_updates;
+static bool command_ok;
+
+void btd_error(uint16_t index, const char *format, ...)
+{
+}
+
+void btd_debug(uint16_t index, const char *format, ...)
+{
+}
+
+unsigned int test_write_command(struct bt_gatt_client *client, uint16_t ha=
ndle,
+=09=09=09=09=09bool signed_write,
+=09=09=09=09=09const uint8_t *value, uint16_t length)
+{
+=09assert(client && handle =3D=3D 0x79 && !signed_write);
+
+=09if (value[0] =3D=3D 0x02) {
+=09=09assert(length =3D=3D 1);
+=09=09commands++;
+=09=09return command_ok;
+=09}
+
+=09assert(length =3D=3D 2 && value[0] =3D=3D 0x03 && value[1] =3D=3D 0x00)=
;
+=09peer_updates++;
+=09return 1;
+}
+
+unsigned int test_write_request(struct bt_gatt_client *client, uint16_t ha=
ndle,
+=09=09=09=09const uint8_t *value, uint16_t length,
+=09=09=09=09bt_gatt_client_callback_t callback, void *data,
+=09=09=09=09bt_gatt_client_destroy_func_t destroy)
+{
+=09requests++;
+=09return 1;
+}
+
+static void state_callback(int status, void *data)
+{
+=09assert(false);
+}
+
+static void test_stop(const void *user_data)
+{
+=09unsigned int fail;
+
+=09for (fail =3D 0; fail < 2; fail++) {
+=09=09struct bt_asha left =3D {
+=09=09=09.client =3D (void *) 1, .acp_handle =3D 0x79,
+=09=09=09.hisyncid =3D { 1 }, .state =3D ASHA_STARTED,
+=09=09=09.state_cb =3D state_callback, .state_cb_data =3D (void *) 1,
+=09=09};
+=09=09struct bt_asha right =3D {
+=09=09=09.client =3D (void *) 2, .acp_handle =3D 0x79,
+=09=09=09.hisyncid =3D { 1 }, .right_side =3D true,
+=09=09=09.state =3D ASHA_STARTED,
+=09=09};
+
+=09=09asha_devices =3D queue_new();
+=09=09update_asha_set(&left, true);
+=09=09update_asha_set(&right, true);
+=09=09commands =3D requests =3D peer_updates =3D 0;
+=09=09command_ok =3D !fail;
+=09=09assert(bt_asha_stop(&left) =3D=3D (fail ? (unsigned int) -1 : 0));
+=09=09assert(commands =3D=3D 1 && requests =3D=3D 0 && peer_updates =3D=3D=
 1);
+=09=09assert(left.state =3D=3D ASHA_STOPPED);
+=09=09assert(right.state =3D=3D ASHA_STARTED);
+=09=09assert(!left.state_cb && !left.state_cb_data);
+
+=09=09/* Repeated stop must not send another control command. */
+=09=09assert(bt_asha_stop(&left) =3D=3D 0);
+=09=09assert(commands =3D=3D 1 && requests =3D=3D 0 && peer_updates =3D=3D=
 1);
+=09=09update_asha_set(&left, false);
+=09=09update_asha_set(&right, false);
+=09=09assert(!asha_devices);
+=09}
+
+=09tester_test_passed();
+}
+
+int main(int argc, char *argv[])
+{
+=09tester_init(&argc, &argv);
+=09tester_add("ASHA/stop/command", NULL, NULL, test_stop, NULL);
+=09return tester_run();
+}

base-commit: 7428ca2df9356363079db0f48412c20cbdb9471f

