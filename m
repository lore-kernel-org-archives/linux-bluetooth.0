Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793233312;
	b=Zb0IvkFZpJw+XTMj6I3JiN4lUGnq83OzZWmsg+S1iBHuDbGooTeWOHRs7d+YOihJtvGe
	 GEEu1lmI/L2HxEaypN8vMsU7VBVSNbk3ISI5IKmxe6CdqshSjnPsBLePE4+HDuYHrcnbG
	 KdDiGIbIjWeYf/Lqmxm67oCpiIi4yA7r77mC7TJr4XcYRu9Ac5+cRp+TbgHYB7JW4CuKZ
	 rxXFyRuELMV9/FnHz72jFW9XnksfJhd9TsbA6Up8osG29bsu0BEOfTZHHY/1dNjvHkJWi
	 7/VyEfPffIiMbaXgRLRmTnjEp+/SCrOAamVMvYBzLMDVic4E0ck/T/mTSVXf/LIbhUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793233312;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=acuJ22yD26Px8plncX5aOFAq9mGMul+PAbQEuPSoDNY=;
	b=TNaIxpO+IOFqY7+auLaBlOKqh1KFWcLZ+7QmvDg+TA7pENP82+P97dZUGxItoUQeJl4D
	 ozqn4CAybuczYc28iu5ht/SpbyYIb4Mi1RDehVx9o9KlRhGaNj2HMMiLSXS8RgBpvnhNG
	 MTy0k+kecnv7RV9ylUE36RgibnwI69zsHX5nLWmdgnJuJjAdVbXA9tbi23XWdo8QmoZ+M
	 1Y3J0cy3FjkZolkn/iGjtOe1RKR7lH+EjMgkrVMPNRZu30FPOQ4/Fwf7qdrNsgu8Ebr0n
	 l461RoTDCf4KI878OdetLMkQL4Wuv3o2oP8zxvjzJEf2OUE31GSTo2qDoxv1rAcjssA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=5ddc2jeeaffbfmdxf63zvq32cy.protonmail2 header.b=mkRdyw1k;
	arc=none smtp.remote-ip=185.70.43.22
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E644606A31A
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 00:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E644606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=5ddc2jeeaffbfmdxf63zvq32cy.protonmail2 header.b=mkRdyw1k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=5ddc2jeeaffbfmdxf63zvq32cy.protonmail2; t=1793233307;
	x=1793492507; bh=acuJ22yD26Px8plncX5aOFAq9mGMul+PAbQEuPSoDNY=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=mkRdyw1kZX1vGPHiO8Vhf8MNyCtS1iU4yacJVL2Dy48kELpz4aXovdkR+VbJYaoLt
	 iP5VkafEZfw26JXicFJC1T/hZTF9/w0TzTid8xmgF0ZTRg9sAxO+iPKFLM+o0TwV6c
	 F42DKJRdSCtFt169eQTK9SqKlalIpZLLNUOLxzfOZyzdhQVvZzsIHqZeSi7LjNxPzb
	 URkpCPunSJ4WQo8YjpMK878h8Em6paFoqwP8g9RU6OgWI5LKMIaHMrV6/WuUEc5O5M
	 UVuPTboX24i4hUb43DpN+V0F2+2KXvK9XUH8N/xR8iQ0/5caumk/kg8vQorzqvjQ2O
	 bWNN7dL6u64FA==
Date: Thu, 29 Oct 2026 00:21:43 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Subject: [PATCH RESEND v2] asha: allow LE 2M PHY on the audio channel
Message-ID: <20261029002132.1035888-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: b20add62cda877450b09d85c1261ff335f48cc29
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

Allow LE 2M on the CoC socket to increase available throughput for
capable peers. Retain LE 1M fallback and treat BT_PHY as best effort
for older kernels.

Test the PHY mask and continued startup when the preference is rejected.

Assisted-by: OpenCode:gpt-6.1-sol
---
Resending unchanged v2 after inactivity closure of the prior CI PR
(closure reported October 28). Original source and attribution retained.
Prior v2 CI passed as reported; not independently reverified.
No new hardware or remote CI result is claimed.

Changes since v1: fix sanitizer-retained daemon references with
fail-fast test stubs.
Refreshed to BlueZ 9dc7e40962f11d1d9a5568f8a7633a695288329c.
Strict non-LTO ASan/UBSan build and make check pass; ordinary LTO
build and make check pass. Strict LTO has an unchanged upstream
peripheral/btsensor warning failure, reproduced without this topic.
No new hardware trial or remote functional-lab result is claimed.

Submission review notes (not part of the commit message):
N8/UB500 completes 2M in the downstream stack. N7/1M-only hardware
is unavailable; fallback has focused unit coverage, not new hardware proof.

 .gitignore            |   1 +
 Makefile.am           |   9 ++
 profiles/audio/asha.c |  11 ++
 unit/test-asha-phy.c  | 241 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 262 insertions(+)
 create mode 100644 unit/test-asha-phy.c

diff --git a/.gitignore b/.gitignore
index 06b24735df..d214ba0591 100644
--- a/.gitignore
+++ b/.gitignore
@@ -112,6 +112,7 @@ unit/test-lib
 unit/test-mgmt
 unit/test-uhid
 unit/test-hfp
+unit/test-asha-phy
 unit/test-crypto
 unit/test-ecc
 unit/test-hog
diff --git a/Makefile.am b/Makefile.am
index f742458d11..2041ac87db 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -706,6 +706,15 @@ unit_test_avrcp_LDADD =3D lib/libbluetooth-internal.la=
 \
=20
 unit_tests +=3D unit/test-hfp
=20
+unit_tests +=3D unit/test-asha-phy
+
+unit_test_asha_phy_SOURCES =3D unit/test-asha-phy.c
+unit_test_asha_phy_CFLAGS =3D $(AM_CFLAGS) -DBLUETOOTH_PLUGIN_BUILTIN \
+=09-ffunction-sections -fdata-sections
+unit_test_asha_phy_LDADD =3D src/libshared-glib.la \
+=09lib/libbluetooth-internal.la $(GLIB_LIBS) $(DBUS_LIBS)
+unit_test_asha_phy_LDFLAGS =3D -Wl,--gc-sections
+
 unit_test_hfp_SOURCES =3D unit/test-hfp.c
 unit_test_hfp_LDADD =3D src/libshared-glib.la $(GLIB_LIBS)
=20
diff --git a/profiles/audio/asha.c b/profiles/audio/asha.c
index 8e625fdca3..d86224764d 100644
--- a/profiles/audio/asha.c
+++ b/profiles/audio/asha.c
@@ -88,6 +88,8 @@ static void connect_cb(GIOChannel *io, GError *err, gpoin=
ter user_data)
 =09struct connect_data *conn_data =3D user_data;
 =09struct bt_asha_device *asha_dev =3D conn_data->asha_dev;
 =09GError *gerr =3D NULL;
+=09uint32_t phys;
+=09int fd;
=20
 =09if (err) {
 =09=09error("%s", err->message);
@@ -105,6 +107,15 @@ static void connect_cb(GIOChannel *io, GError *err, gp=
ointer user_data)
 =09=09g_error_free(gerr);
 =09}
=20
+=09/*
+=09 * Allow LE 2M with LE 1M fallback. Older kernels may lack BT_PHY.
+=09 */
+=09phys =3D BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+=09=09=09BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX;
+=09fd =3D g_io_channel_unix_get_fd(io);
+=09if (setsockopt(fd, SOL_BLUETOOTH, BT_PHY, &phys, sizeof(phys)) < 0)
+=09=09DBG("Could not set LE 2M PHY preference: %s", strerror(errno));
+
 =09asha_dev->io =3D io;
=20
 =09bt_asha_start(asha_dev->asha, conn_data->cb,
diff --git a/unit/test-asha-phy.c b/unit/test-asha-phy.c
new file mode 100644
index 0000000000..c58101ebfd
--- /dev/null
+++ b/unit/test-asha-phy.c
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <assert.h>
+#include <stdarg.h>
+#include <sys/socket.h>
+
+int test_setsockopt(int fd, int level, int option, const void *value,
+=09=09=09=09=09=09=09socklen_t length);
+
+/* Source-level mocks remain effective with link-time optimization. */
+#define setsockopt test_setsockopt
+#define bt_io_get test_io_get
+#define bt_asha_start test_start
+#include "profiles/audio/asha.c"
+#undef setsockopt
+#undef bt_io_get
+#undef bt_asha_start
+#include "src/shared/tester.h"
+
+static unsigned int preferences, starts;
+static bool mtu_ok;
+static int preference_error, expected_fd;
+
+/* Sanitizers retain the plugin's globals, including unused daemon callbac=
ks. */
+int btd_profile_register(struct btd_profile *profile)
+{
+=09assert(false);
+}
+
+void btd_profile_unregister(struct btd_profile *profile)
+{
+=09assert(false);
+}
+
+const char *device_get_path(const struct btd_device *device)
+{
+=09assert(false);
+}
+
+const bdaddr_t *device_get_address(struct btd_device *device)
+{
+=09assert(false);
+}
+
+struct btd_adapter *device_get_adapter(struct btd_device *device)
+{
+=09assert(false);
+}
+
+const bdaddr_t *btd_adapter_get_address(struct btd_adapter *adapter)
+{
+=09assert(false);
+}
+
+void btd_device_set_conn_param(struct btd_device *device,
+=09=09=09=09uint16_t min_interval, uint16_t max_interval,
+=09=09=09=09=09uint16_t latency, uint16_t timeout)
+{
+=09assert(false);
+}
+
+struct gatt_db *btd_device_get_gatt_db(struct btd_device *device)
+{
+=09assert(false);
+}
+
+struct bt_gatt_client *btd_device_get_gatt_client(struct btd_device *devic=
e)
+{
+=09assert(false);
+}
+
+struct btd_device *btd_service_get_device(const struct btd_service *servic=
e)
+{
+=09assert(false);
+}
+
+void *btd_service_get_user_data(const struct btd_service *service)
+{
+=09assert(false);
+}
+
+void btd_service_set_user_data(struct btd_service *service, void *user_dat=
a)
+{
+=09assert(false);
+}
+
+void btd_service_connecting_complete(struct btd_service *service, int err)
+{
+=09assert(false);
+}
+
+void btd_service_disconnecting_complete(struct btd_service *service, int e=
rr)
+{
+=09assert(false);
+}
+
+DBusConnection *btd_get_dbus_connection(void)
+{
+=09assert(false);
+}
+
+gboolean g_dbus_register_interface(DBusConnection *connection,
+=09=09=09=09const char *path, const char *name,
+=09=09=09=09const GDBusMethodTable *methods,
+=09=09=09=09const GDBusSignalTable *signals,
+=09=09=09=09const GDBusPropertyTable *properties,
+=09=09=09=09void *user_data, GDBusDestroyFunction destroy)
+{
+=09assert(false);
+}
+
+gboolean g_dbus_unregister_interface(DBusConnection *connection,
+=09=09=09=09=09const char *path, const char *name)
+{
+=09assert(false);
+}
+
+const struct media_endpoint *media_endpoint_get_asha(void)
+{
+=09assert(false);
+}
+
+struct media_transport *media_transport_create(struct btd_device *device,
+=09=09=09=09const char *remote_endpoint,
+=09=09=09=09uint8_t *configuration, size_t size,
+=09=09=09=09void *data, void *stream)
+{
+=09assert(false);
+}
+
+void media_transport_destroy(struct media_transport *transport)
+{
+=09assert(false);
+}
+
+const char *media_transport_get_path(struct media_transport *transport)
+{
+=09assert(false);
+}
+
+GIOChannel *bt_io_connect(BtIOConnect connect, gpointer user_data,
+=09=09=09=09GDestroyNotify destroy, GError **gerr,
+=09=09=09=09=09=09=09BtIOOption opt1, ...)
+{
+=09assert(false);
+}
+
+void btd_error(uint16_t index, const char *format, ...)
+{
+}
+
+void btd_debug(uint16_t index, const char *format, ...)
+{
+}
+
+int test_setsockopt(int fd, int level, int option, const void *value,
+=09=09=09=09=09=09=09socklen_t length)
+{
+=09const uint32_t *phys =3D value;
+
+=09assert(fd =3D=3D expected_fd && level =3D=3D SOL_BLUETOOTH && option =
=3D=3D BT_PHY);
+=09assert(length =3D=3D sizeof(*phys));
+=09assert(*phys =3D=3D (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+=09=09=09=09=09BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX));
+=09assert(starts =3D=3D 0);
+=09preferences++;
+=09errno =3D preference_error;
+=09return preference_error ? -1 : 0;
+}
+
+gboolean test_io_get(GIOChannel *io, GError **error, BtIOOption first, ...=
)
+{
+=09va_list args;
+=09uint16_t *imtu, *omtu;
+
+=09if (!mtu_ok) {
+=09=09*error =3D g_error_new(G_IO_CHANNEL_ERROR,
+=09=09=09=09G_IO_CHANNEL_ERROR_FAILED, "MTU failure");
+=09=09return FALSE;
+=09}
+
+=09assert(first =3D=3D BT_IO_OPT_IMTU);
+=09va_start(args, first);
+=09imtu =3D va_arg(args, uint16_t *);
+=09assert(va_arg(args, int) =3D=3D BT_IO_OPT_OMTU);
+=09omtu =3D va_arg(args, uint16_t *);
+=09assert(va_arg(args, int) =3D=3D BT_IO_OPT_INVALID);
+=09va_end(args);
+=09*imtu =3D 512;
+=09*omtu =3D 163;
+=09return TRUE;
+}
+
+unsigned int test_start(struct bt_asha *asha, bt_asha_cb_t callback, void =
*data)
+{
+=09assert(preferences =3D=3D 1);
+=09starts++;
+=09return 0;
+}
+
+static void test_phy(const void *user_data)
+{
+=09const int errors[] =3D { 0, ENOPROTOOPT, EINVAL };
+=09unsigned int i;
+=09int fds[2];
+=09GIOChannel *io;
+=09GError *error;
+=09struct bt_asha asha =3D { 0 };
+=09struct bt_asha_device device =3D { .asha =3D &asha };
+=09struct connect_data data =3D { .asha_dev =3D &device };
+
+=09assert(!pipe(fds));
+=09io =3D g_io_channel_unix_new(fds[0]);
+=09expected_fd =3D fds[0];
+
+=09for (i =3D 0; i < ARRAY_SIZE(errors); i++) {
+=09=09preferences =3D starts =3D 0;
+=09=09preference_error =3D errors[i];
+=09=09mtu_ok =3D i !=3D 2;
+=09=09connect_cb(io, NULL, &data);
+=09=09assert(preferences =3D=3D 1 && starts =3D=3D 1 && device.io =3D=3D i=
o);
+=09=09assert(device.imtu =3D=3D 512 && device.omtu =3D=3D 163);
+=09}
+
+=09preferences =3D starts =3D 0;
+=09error =3D g_error_new(G_IO_CHANNEL_ERROR, G_IO_CHANNEL_ERROR_FAILED,
+=09=09=09=09=09=09=09"mock connection failure");
+=09connect_cb(io, error, &data);
+=09assert(preferences =3D=3D 0 && starts =3D=3D 0);
+=09g_error_free(error);
+=09g_io_channel_unref(io);
+=09close(fds[0]);
+=09close(fds[1]);
+=09tester_test_passed();
+}
+
+int main(int argc, char *argv[])
+{
+=09tester_init(&argc, &argv);
+=09tester_add("ASHA/PHY/preference", NULL, NULL, test_phy, NULL);
+=09return tester_run();
+}

base-commit: 9dc7e40962f11d1d9a5568f8a7633a695288329c
--=20
2.56.0


