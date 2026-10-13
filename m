Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07574542ED2
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 22:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791930262; cv=none; b=cvJfSWHNpO4wqVcsh1Ef5ZNhRKP6emc0n3FN9fXmmtqT6uRfON4P5YRKXJf5HCJ9pGiru8/ta+spDJXIfsUh37CSR8j6xkPVi41eNdmhaFoBbZPUSWQjB9UE6c/T0Hozj67juiufExiolW57q9UffHo7PQCNEq1T0wCru4V2/Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791930262; c=relaxed/simple;
	bh=nEJ/mGPTrfuaoO+77BIybHMggcWNhCed5fQJEZDtXrk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ULhHW8IGXBSseS22f1ZB0BEOvE63QoX1z2qC0xXAbUTdYiz9t3+QQGdhYsiLQCH3OXzYXxXDT0ZwY9shJggVaLAkURjQJxYvIDG0HIwApHsOE30/BzczXadfv7oxlHR8zhO/N/nzYUC620ZGfVHOVc8AIN9owDMvqipeGUPBC9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=WEC+yywr; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="WEC+yywr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1791930254; x=1792189454;
	bh=5NsXj6J95nps+7D/CYSUe5C6HD693mF2vQgSxXICpwA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=WEC+yywr6SvnD4k+AvhktAvTpdAbvKMvLMwzOcoXaiY31X3AQlIPGIJFtUeb83Fxm
	 R0KKD2vu1zhNPl5370KXFCp/0G2N39okCVzuy5mfpQrwoMguAer/v3iRXJ53q7XeDQ
	 Kom3WcL4634cnlkVKhbzWuBmorlq0s6npEysRmGC9FyutxnVMcx3a5VJxWltKcG3OH
	 qx21gkjyZqY/EOzkDhKy9JLksk5o95T8dOKAskMeheaCc/3g1phekRLrmyI/cmyJv2
	 yawcwMmgx6YtZLYUfCysNq7MtyYOQL5aq+Am60xr6tKD7jdJOXdkdN3U8cjOuwHQSv
	 dpvL5axP03UoA==
Date: Tue, 13 Oct 2026 22:24:09 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH v2] asha: allow LE 2M PHY on the audio channel
Message-ID: <20261013222355.511390-1-cochcoder@proton.me>
In-Reply-To: <20261013034823.519119-1-cochcoder@proton.me>
References: <20261013034823.519119-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 580533e8038278b1530b69bbf0a6751b98cbfe8c
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Allow LE 2M on the CoC socket to increase available throughput for
capable peers. Retain LE 1M fallback and treat BT_PHY as best effort
for older kernels.

Test the PHY mask and continued startup when the preference is rejected.

Assisted-by: OpenCode:gpt-6.1-sol
---
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


