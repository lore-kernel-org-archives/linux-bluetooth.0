Received: from mail-43101.protonmail.ch (mail-43101.protonmail.ch [185.70.43.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619F13859EB
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 03:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863201; cv=none; b=S4VGlX9CECsEIDJKXirVFsm64f+DXLM6KVMWOoC0etIHBxAmUSyaBnGQzuOLs565iPDPw0X5hwZ5IlCddZzrI2AWrgrhho16BuNvrGOzH8M6SiP98SBuCqpqpv5FomtP3Vfz0idbfQrWQbEX2c5qClg98E3CHM8opYL932W8Ge4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863201; c=relaxed/simple;
	bh=xXumaqmmQ+qE+TFYIW4XqhJCAroYwXcsx1te2TF1rWw=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=KX3cAP8ix+ALNUEt7z+CYWKkBScaHk9n49wMmg35dyahvzKWtap9LdT7oI+sxwYVHXbo5ABvCxFfOVwVNKnsysWJ7Hn5kNcIo7ItcIIMKSVPpd2Zjvy/z3p3iTWsreqao7mNBG4bhUfH6ITGt65d0HVzI9hoTNjIfMu+Fw1WiX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=H1xNbpbK; arc=none smtp.client-ip=185.70.43.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="H1xNbpbK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1791863191; x=1792122391;
	bh=qRbW5CHUq9oM/5O/FSSAfxDDwbsoqHQNU37sJj1BpJo=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=H1xNbpbKzGRtNLhGhi7zztLRjU5Cd9cIJije6dENNpZ6HcJ2sp61lx4+BizDHfuOf
	 HoGCJHkJQJb7bwol6N3PCyyrVEGCvw17vLrUD/2qTd1pPC3B4PilCq6YlIgX5feUSH
	 kWYCKCbEdW+uPXSX6Ew4E//rCC3TxbWcq1Zh9aTT8q/0t1G1e3sikITrkzUgV81+EM
	 ayO/YqCEpCe0YB/mCTYIOlzaP+52pJFc8BqFOACQeyuZUDQ7MHXuU9aCKniNJ6D9e6
	 sISGRAQM6aFA3HXN/w3z/gQJ+Q5E8iMF9iwQbZKpD+7Eg/pp1zQkW3r10tdp1CqSoA
	 4GXs/WMBOvc4Q==
Date: Tue, 13 Oct 2026 03:46:27 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] shared/asha: prime volume before starting audio
Message-ID: <20261013034613.516771-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 85cafe014ffe03783caa69d0394a6369c7185305
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Some tested renderers remain silent unless the Volume characteristic is
written before START. Prime it with the selected volume and keep the
write best effort.

Test volume-before-START ordering and best-effort failure handling.

Assisted-by: OpenCode:gpt-6.1-sol
---
Submission review notes (not part of the commit message):
Local validation is for base 7428ca2df9356363079db0f48412c20cbdb9471f.
Compatibility with newer upstream tips has not been verified locally.
N8 startup evidence is from the combined downstream stack, not a
volume-only hardware ablation. Native ordering/failure unit tests are
included; other renderer coverage and human contribution review remain.

 .gitignore             |  1 +
 Makefile.am            |  6 +++
 src/shared/asha.c      |  4 ++
 unit/test-asha-start.c | 99 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 110 insertions(+)
 create mode 100644 unit/test-asha-start.c

diff --git a/.gitignore b/.gitignore
index 06b24735df..adff1ea84a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -112,6 +112,7 @@ unit/test-lib
 unit/test-mgmt
 unit/test-uhid
 unit/test-hfp
+unit/test-asha-start
 unit/test-crypto
 unit/test-ecc
 unit/test-hog
diff --git a/Makefile.am b/Makefile.am
index f742458d11..a56d66873b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -706,6 +706,12 @@ unit_test_avrcp_LDADD =3D lib/libbluetooth-internal.la=
 \
=20
 unit_tests +=3D unit/test-hfp
=20
+unit_tests +=3D unit/test-asha-start
+
+unit_test_asha_start_SOURCES =3D unit/test-asha-start.c
+unit_test_asha_start_LDADD =3D src/libshared-glib.la \
+=09lib/libbluetooth-internal.la $(GLIB_LIBS)
+
 unit_test_hfp_SOURCES =3D unit/test-hfp.c
 unit_test_hfp_LDADD =3D src/libshared-glib.la $(GLIB_LIBS)
=20
diff --git a/src/shared/asha.c b/src/shared/asha.c
index 79bb29bf9a..b5e8d67567 100644
--- a/src/shared/asha.c
+++ b/src/shared/asha.c
@@ -262,6 +262,10 @@ unsigned int bt_asha_start(struct bt_asha *asha, bt_as=
ha_cb_t cb,
 =09=09return 0;
 =09}
=20
+=09/* Some renderers require a Volume write before START. */
+=09if (!bt_asha_set_volume(asha, asha->volume))
+=09=09DBG("ASHA volume priming failed, continuing with START");
+
 =09ret =3D asha_send_acp(asha, acp_start_cmd, sizeof(acp_start_cmd), cb,
 =09=09=09user_data);
 =09if (ret < 0)
diff --git a/unit/test-asha-start.c b/unit/test-asha-start.c
new file mode 100644
index 0000000000..49df54c1f3
--- /dev/null
+++ b/unit/test-asha-start.c
@@ -0,0 +1,99 @@
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
+static unsigned int commands, requests;
+static bool volume_ok, start_ok;
+static int8_t selected_volume;
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
+=09assert(client && handle =3D=3D 0x82 && !signed_write);
+=09assert(length =3D=3D 1 && (int8_t) value[0] =3D=3D selected_volume);
+=09assert(requests =3D=3D 0);
+=09commands++;
+=09return volume_ok;
+}
+
+unsigned int test_write_request(struct bt_gatt_client *client, uint16_t ha=
ndle,
+=09=09=09=09const uint8_t *value, uint16_t length,
+=09=09=09=09bt_gatt_client_callback_t callback, void *data,
+=09=09=09=09bt_gatt_client_destroy_func_t destroy)
+{
+=09assert(client && handle =3D=3D 0x79);
+=09assert(commands =3D=3D 1 && requests =3D=3D 0);
+=09assert(length =3D=3D 5 && value[0] =3D=3D 0x01 && value[1] =3D=3D 0x01)=
;
+=09assert((int8_t) value[3] =3D=3D selected_volume);
+=09assert(callback && data && !destroy);
+=09requests++;
+=09return start_ok;
+}
+
+static void test_start(const void *user_data)
+{
+=09const int8_t volumes[] =3D { -128, -127, -64, 0 };
+=09unsigned int i, fail;
+
+=09for (i =3D 0; i < ARRAY_SIZE(volumes); i++) {
+=09=09for (fail =3D 0; fail < 2; fail++) {
+=09=09=09struct bt_asha asha =3D {
+=09=09=09=09.client =3D (void *) 1, .acp_handle =3D 0x79,
+=09=09=09=09.volume_handle =3D 0x82, .volume =3D volumes[i],
+=09=09=09};
+
+=09=09=09selected_volume =3D volumes[i];
+=09=09=09commands =3D requests =3D 0;
+=09=09=09volume_ok =3D !fail;
+=09=09=09start_ok =3D true;
+=09=09=09assert(bt_asha_start(&asha, NULL, NULL) =3D=3D 0);
+=09=09=09assert(commands =3D=3D 1 && requests =3D=3D 1);
+=09=09=09assert(asha.state =3D=3D ASHA_STARTING);
+=09=09=09assert(asha.volume =3D=3D selected_volume);
+
+=09=09=09/* A repeated start must not write the volume again. */
+=09=09=09bt_asha_start(&asha, NULL, NULL);
+=09=09=09assert(commands =3D=3D 1 && requests =3D=3D 1);
+=09=09}
+=09}
+
+=09{
+=09=09struct bt_asha asha =3D {
+=09=09=09.client =3D (void *) 1, .acp_handle =3D 0x79,
+=09=09=09.volume_handle =3D 0x82, .volume =3D -64,
+=09=09};
+
+=09=09commands =3D requests =3D 0;
+=09=09selected_volume =3D asha.volume;
+=09=09volume_ok =3D true;
+=09=09start_ok =3D false;
+=09=09assert(bt_asha_start(&asha, NULL, NULL) =3D=3D (unsigned int) -1);
+=09=09assert(asha.state =3D=3D ASHA_STOPPED);
+=09=09assert(commands =3D=3D 1 && requests =3D=3D 1);
+=09}
+
+=09tester_test_passed();
+}
+
+int main(int argc, char *argv[])
+{
+=09tester_init(&argc, &argv);
+=09tester_add("ASHA/start/volume", NULL, NULL, test_start, NULL);
+=09return tester_run();
+}

base-commit: 7428ca2df9356363079db0f48412c20cbdb9471f

