Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194310;
	b=rbnD6Jjoq4j9vSIBOSSj80hC5Gx/hF+SUgaHc7L8ZoadK0IzDkGFHmMLagJBt6ahNE8P
	 bkkJjk3GjAsfT66BYWfoJej7R9NqWuu1MLTnswVsG66XZxGdMiQZ2rSWg+kZ+l0M1hl5V
	 qFCFN1SKvssSvtSkrq/yuxRHcI6ygUoNAH2fXukMXJJPMEvVR30jFFLTBSuSixKtzSNW8
	 X5oGYp2xlVwkXS3keh/hPDE3rs2yOfwKs2YmSaj41VUW+Qhw2Z6IdS5YkAiyAZQgcP9tI
	 eMto7NTUDPogXLcLXGhk7CoM6XyX93I4cpOrLaIP9LknTHfsPXBpiDcxIJ5qgqNKX8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194310;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/LnT7F0RF8XXmh6ACg4TMxOnyLJZrZgmCApLht3Q5d8=;
	b=bBx8PXVRPZcdh6cWJLOXdXlxY1amemImWm0vkODmfySNkjiI7XasBV5H3pyM66lTG798
	 RAkxuccuJ7/cvHH48kTbI4KXZ9yFHSsa71mTc7wGMWDJDoNeZx13c+jkzzdUv+J3gs0Md
	 r7VlY+/f5pVWFbSBbvR/Kfug+/UAURrdReIXZkXwQ3rxviLV/9zILid91DrDmO4bb0wkv
	 cX2JY9c3nQ+LZ5ZoTS9fY1FPO1EozUdEiFJbrOG5AzhFPs7xvv/5uav0vatF1azKC0Zcr
	 4RY3gkYXK+5fVXP4r46RveQ+qAygwlV6BvycGwG+uDDWiyrV2QvtJCKssMynEkLfiSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=lidtW4dQ;
	arc=none smtp.remote-ip=79.135.106.119
Received: from mail-106119.protonmail.ch (mail-106119.protonmail.ch [79.135.106.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6867C606A31D
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 13:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6867C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=lidtW4dQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1793194307; x=1793453507;
	bh=/LnT7F0RF8XXmh6ACg4TMxOnyLJZrZgmCApLht3Q5d8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=lidtW4dQ3liIBZmCemjVL4eIfqTONOaJhs17u3rZes1G1ogubRJoOpOxfntnrcrEJ
	 dKlYj3jtzSGvidMCmAkrdzKZfAJfzox1OeTUDEs6KPcMa5LKinD2H+4ZpIGosWSnSF
	 OCkYB1aCUyqWWQPVf1WBUiWTcYL7oRgwftp2D1vAc9De4GOqUB1cAtb80CNlkNamw5
	 pXeYaY7TglhOq50LMYaIfFhCK+K1/zqwGK+Mm0Fq5fxwIVjaFGlazYS0LsX8gTY9g5
	 b14RJDIZPl5b/n/tnxbWZ/3vtRe81hrgUVd4kxvaqspFeh3r9jBfnQi8PDsq7dP02d
	 L/YwVLTXZOtPA==
Date: Wed, 28 Oct 2026 13:31:42 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH RESEND] shared/asha: prime volume before starting audio
Message-ID: <20261028133131.262033-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 2777878a8ae051bd451f75c63f6a302c491e88ab
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Some tested renderers remain silent unless the Volume characteristic is
written before START. Prime it with the selected volume and keep the
write best effort.

Test volume-before-START ordering and best-effort failure handling.

Assisted-by: OpenCode:gpt-6.1-sol
---
Resending unchanged after automated CI PR2665 expiry; no source changes.
Previous submission: https://lore.kernel.org/linux-bluetooth/20261013034613=
.516771-1-cochcoder@proton.me/
Earlier remote functional, lowercase checkpatch, Codacy Security Scan and
outer-CI failures remain unresolved. Historical local passes do not
establish remote success; no new hardware or functional test is claimed.

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

