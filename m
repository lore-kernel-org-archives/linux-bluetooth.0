Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795538439;
	b=XuAu9otQAEa5oPqUe3/EfbKnZRXDKjj2EQCJixAymy91sY4Ez/k7kawYjgO4hbLxfkg7
	 0dcztLZnJ7lgcaVn7H7UGcRzA6HElEzfe4EDI+tPNUdVuy/Lx5uxRhEk1nAoWE9JWpbR+
	 OM1XjrmoOS98yCq4MIgPy9NojCbuTnmo8VlOYDw8iiYZk9DZ4XzKif2BGldpEPukCP8sa
	 k/7GJObKwGd5vZImGRto95JppK6zMJq4hcZMF1MbkmcijisyrrzgJVS+L2qvN2EuwXp/J
	 qGOVeMc7nm4fKJx/4qeVx185NspCMkVLnP8KpIwOP1aRuWKsUDaOgZ9yXylMJtpD2tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538439;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=cE/vCc6F8BDz4A8kAv+4hYD5j8tmRP8yBseceVd/HnM=;
	b=pK5jK4CMj6pbRrgtbOI/mAWCBmK0xlPWsvfZu6V98tueb8eqNDNDpYLo1goBKvVqEONT
	 VLfHOhAmu3TTEnkEN8wnhxckDNWTx4G52Z7lwBjWqQYKl3xOIun9/eGqNVDFCm2AdpbsS
	 v4/zGPd0DXTfNe/6BacBLWAF2Zo7GSn/hiaRIGhxlkgqA5zC/5MInyi8si0k8Tsd51yKo
	 BisCwh2CzPpTH6vO3YsUrZC1v532pX21S3VVAmK1g95XY2RBsbYAH0vIpbGGGMBYly5lr
	 Im0bLw+zPpqE6Q680FkEI4GBQsbcbOHq6zWLKlDFFldAMTQgK5afPUVihSKgSvmxfAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=ruNRkbXZ;
	arc=none smtp.remote-ip=109.224.244.17
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243D8606A32A
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 16:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 243D8606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=ruNRkbXZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1795538434; x=1795797634;
	bh=cE/vCc6F8BDz4A8kAv+4hYD5j8tmRP8yBseceVd/HnM=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ruNRkbXZABLaUAVPThxmkou0t1Mlt6ke1juH16Cn6Wj5+tF4dgHfbf6vChvIW7XmS
	 8WqQcY7jz1dL5oG61rZqz2z5cmY0WhrIoR76A8Ff4xY43u4yIidT90RzG9rfaMZIPt
	 9NzisznD3trbfcij68PmXdVn/zCqNJDkyZbnM+XRqo8kudpLIr+zOWxLwjZGuK49kU
	 BhtXRxUxbiboecb53UUSFXqPRj9rhsYUz5h6uUTe+b2s/WXUbe4HByqXJJLzL1MUiL
	 TpKUhBFcYrThtnxZb9ArJMMJZ6DSDwOnkm3v4J4FsLJ7R+WIoUJowvy/aolf1tysga
	 juTRbDT1rxPuQ==
Date: Tue, 24 Nov 2026 16:40:31 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Subject: [RFC PATCH BlueZ v5 4/4] unit: Test ASHA connection interval notifications
Message-ID: <47d4feee18480111ac99b9415ad3b95dbdd37cdb.1795535897.git.cochcoder@proton.me>
In-Reply-To: <cover.1795535897.git.cochcoder@proton.me>
References: <20261029002158.1036153-1-cochcoder@proton.me> <20261106235122.719665-1-cochcoder@proton.me> <cover.1795489294.git.cochcoder@proton.me> <cover.1795535897.git.cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 506fa8d38370abc5a1cbb3728966732f2b1efc1d
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

Cover STATUS encoding, independent writes, set lifetime and observed
connection intervals. Exercise attachment before either aid starts, both
property-read orders, stopped peers, reset/free and replacement. Keep
START other-connected state tied to the existing streaming set.

Assisted-by: OpenCode:gpt-6.1-sol
Assisted-by: Codex:gpt-6
---
 .gitignore                |   2 +
 Makefile.am               |  17 ++
 unit/test-asha-conn.c     | 578 ++++++++++++++++++++++++++++++++++++++
 unit/test-asha-conn.h     |  11 +
 unit/test-asha-interval.c | 355 +++++++++++++++++++++++
 5 files changed, 963 insertions(+)
 create mode 100644 unit/test-asha-conn.c
 create mode 100644 unit/test-asha-conn.h
 create mode 100644 unit/test-asha-interval.c

diff --git a/.gitignore b/.gitignore
index 06b2473..21b3bbe 100644
--- a/.gitignore
+++ b/.gitignore
@@ -99,6 +99,8 @@ unit/test-tester
 unit/test-mainloop
 unit/test-ringbuf
 unit/test-queue
+unit/test-asha-conn
+unit/test-asha-interval
 unit/test-util
 unit/test-eir
 unit/test-uuid
diff --git a/Makefile.am b/Makefile.am
index 37302ed..b92105f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -712,6 +712,23 @@ unit_tests +=3D unit/test-hfp
 unit_test_hfp_SOURCES =3D unit/test-hfp.c
 unit_test_hfp_LDADD =3D src/libshared-glib.la $(GLIB_LIBS)
=20
+unit_tests +=3D unit/test-asha-interval
+
+unit_test_asha_interval_SOURCES =3D unit/test-asha-interval.c
+unit_test_asha_interval_LDADD =3D src/libshared-glib.la \
+=09lib/libbluetooth-internal.la $(GLIB_LIBS)
+
+unit_tests +=3D unit/test-asha-conn
+
+unit_test_asha_conn_SOURCES =3D unit/test-asha-conn.c unit/test-asha-conn.=
h
+unit_test_asha_conn_CFLAGS =3D $(AM_CFLAGS) -DBLUETOOTH_PLUGIN_BUILTIN \
+=09-ffunction-sections -fdata-sections
+unit_test_asha_conn_LDADD =3D src/libshared-glib.la \
+=09lib/libbluetooth-internal.la $(GLIB_LIBS) $(DBUS_LIBS)
+unit_test_asha_conn_LDFLAGS =3D -Wl,--gc-sections \
+=09-Wl,--wrap=3Dsocket -Wl,--wrap=3Dbind -Wl,--wrap=3Dsetsockopt \
+=09-Wl,--wrap=3Dgetsockopt
+
 unit_tests +=3D unit/test-gdbus-client
=20
 unit_test_gdbus_client_SOURCES =3D unit/test-gdbus-client.c
diff --git a/unit/test-asha-conn.c b/unit/test-asha-conn.c
new file mode 100644
index 0000000..7db7d9a
--- /dev/null
+++ b/unit/test-asha-conn.c
@@ -0,0 +1,578 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <assert.h>
+#include <fcntl.h>
+#include <stdarg.h>
+#include "test-asha-conn.h"
+
+/* Internal calls can be resolved before GNU ld --wrap when LTO is enabled=
. */
+#define bt_gatt_client_get_att test_get_att
+#define bt_att_get_fd test_att_fd
+#define bt_asha_set_connection_interval test_set_interval
+#define bt_asha_start test_start
+#define bt_io_get test_io_get
+#include "profiles/audio/asha.c"
+#undef bt_gatt_client_get_att
+#undef bt_att_get_fd
+#undef bt_asha_set_connection_interval
+#undef bt_asha_start
+#undef bt_io_get
+#include "bluetooth/hci.h"
+#include "src/shared/tester.h"
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
+static int peer_fd[2];
+static int observer_fd[2];
+static int pending_peer;
+static unsigned int writes;
+static uint16_t last_interval;
+static struct bt_asha *last_asha;
+static bool socket_ready =3D true;
+static bool fail_socket;
+static int att_fd =3D 100;
+static unsigned int handle_reads;
+static socklen_t conninfo_length =3D sizeof(struct l2cap_conninfo);
+static uint16_t att_handle =3D 16;
+
+int __wrap_socket(int domain, int type, int protocol)
+{
+=09int fds[2];
+
+=09assert(domain =3D=3D PF_BLUETOOTH);
+=09assert(protocol =3D=3D BTPROTO_HCI);
+
+=09if (fail_socket)
+=09=09return -1;
+
+=09assert(!socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_NONBLOCK, 0, fds));
+=09pending_peer =3D fds[1];
+=09return fds[0];
+}
+
+int __wrap_bind(int fd, const struct sockaddr *addr, socklen_t length)
+{
+=09const struct sockaddr_hci *hci =3D (void *) addr;
+
+=09/* Ignore tester's optional logging channel. */
+=09if (hci->hci_dev =3D=3D HCI_DEV_NONE) {
+=09=09close(pending_peer);
+=09=09return -1;
+=09}
+
+=09assert(hci->hci_dev < 2);
+=09peer_fd[hci->hci_dev] =3D pending_peer;
+=09observer_fd[hci->hci_dev] =3D fd;
+=09return 0;
+}
+
+int __wrap_setsockopt(int fd, int level, int opt, const void *value,
+=09=09=09=09=09=09=09socklen_t length)
+{
+=09if (level =3D=3D SOL_HCI)
+=09=09return 0;
+
+=09return __real_setsockopt(fd, level, opt, value, length);
+}
+
+int __wrap_getsockopt(int fd, int level, int opt, void *value,
+=09=09=09=09=09=09=09socklen_t *length)
+{
+=09struct l2cap_conninfo *info =3D value;
+
+=09assert(level =3D=3D SOL_L2CAP && opt =3D=3D L2CAP_CONNINFO);
+=09handle_reads++;
+
+=09if (!socket_ready)
+=09=09return -1;
+
+=09assert(*length =3D=3D sizeof(*info));
+=09info->hci_handle =3D att_handle;
+=09*length =3D conninfo_length;
+=09return 0;
+}
+
+struct bt_att *test_get_att(struct bt_gatt_client *client)
+{
+=09return (void *) client;
+}
+
+int test_att_fd(struct bt_att *att)
+{
+=09return att_fd;
+}
+
+struct btd_adapter *device_get_adapter(struct btd_device *device)
+{
+=09return (void *) device;
+}
+
+uint16_t btd_adapter_get_index(struct btd_adapter *adapter)
+{
+=09return PTR_TO_UINT(adapter) - 1;
+}
+
+void btd_debug(uint16_t index, const char *format, ...)
+{
+}
+
+void btd_error(uint16_t index, const char *format, ...)
+{
+}
+
+bool test_set_interval(struct bt_asha *asha,
+=09=09=09=09=09=09=09uint16_t interval)
+{
+=09writes++;
+=09last_asha =3D asha;
+=09last_interval =3D interval;
+=09return true;
+}
+
+unsigned int test_start(struct bt_asha *asha, bt_asha_cb_t cb,
+=09=09=09=09=09=09=09void *user_data)
+{
+=09assert(writes =3D=3D 1 && last_asha =3D=3D asha && last_interval =3D=3D=
 24);
+=09asha->state =3D ASHA_STARTING;
+=09return 0;
+}
+
+gboolean test_io_get(GIOChannel *io, GError **err, BtIOOption opt1, ...)
+{
+=09return TRUE;
+}
+
+static void event(unsigned int adapter, uint8_t subevent, const void *valu=
e,
+=09=09=09=09=09=09=09uint8_t length)
+{
+=09uint8_t packet[260] =3D { BT_H4_EVT_PKT, BT_HCI_EVT_LE_META_EVENT,
+=09=09=09=09=09=09length + 1, subevent };
+
+=09memcpy(packet + 4, value, length);
+=09assert(write(peer_fd[adapter], packet, length + 4) =3D=3D length + 4);
+
+=09while (g_main_context_iteration(NULL, FALSE))
+=09=09;
+}
+
+static void test_connection(const void *user_data)
+{
+=09struct bt_asha asha =3D { .acp_handle =3D 0x79 };
+=09struct bt_asha other =3D { .acp_handle =3D 0x79 };
+=09struct bt_asha_device dev =3D { .asha =3D &asha, .device =3D (void *) 1=
 };
+=09struct bt_asha_device dev2 =3D { .asha =3D &other, .device =3D (void *)=
 2 };
+=09struct connect_data conn =3D { .asha_dev =3D &dev };
+=09GIOChannel *io;
+=09int io_fds[2];
+=09struct asha_adapter *adapter;
+=09unsigned int before;
+=09struct bt_hci_evt_le_conn_complete complete =3D {
+=09=09.handle =3D cpu_to_le16(16), .interval =3D cpu_to_le16(24),
+=09};
+=09struct bt_hci_evt_le_enhanced_conn_complete enhanced =3D {
+=09=09.handle =3D cpu_to_le16(16), .interval =3D cpu_to_le16(32),
+=09};
+=09struct bt_hci_evt_le_conn_update_complete update =3D {
+=09=09.handle =3D cpu_to_le16(16), .interval =3D cpu_to_le16(40),
+=09};
+=09struct bt_hci_evt_disconnect_complete disconnect =3D {
+=09=09.handle =3D cpu_to_le16(16),
+=09};
+=09uint8_t packet[7] =3D { BT_H4_EVT_PKT, BT_HCI_EVT_DISCONNECT_COMPLETE,
+=09=09=09=09=09=09=09sizeof(disconnect) };
+
+=09assert(!pipe(io_fds));
+=09io =3D g_io_channel_unix_new(io_fds[0]);
+=09assert(!asha_adapter_probe(NULL, (void *) 1));
+=09assert(!asha_adapter_probe(NULL, (void *) 2));
+=09asha_streams =3D queue_new();
+=09queue_push_tail(asha_streams, &dev);
+=09queue_push_tail(asha_streams, &dev2);
+=09writes =3D 0;
+=09asha_send_interval(&dev);
+=09assert(writes =3D=3D 0);
+
+=09/* Cache the initial event before GATT discovery/CoC. */
+=09event(0, BT_HCI_EVT_LE_CONN_COMPLETE, &complete, sizeof(complete));
+=09assert(writes =3D=3D 0);
+=09asha.client =3D (void *) 1;
+=09connect_cb(io, NULL, &conn);
+=09assert(writes =3D=3D 1 && last_interval =3D=3D 24);
+
+=09/* Identical handles on different controllers are separate links. */
+=09event(1, BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE, &enhanced,
+=09=09=09=09=09=09=09sizeof(enhanced));
+=09before =3D handle_reads;
+=09event(0, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &update, sizeof(update));
+=09assert(handle_reads =3D=3D before + 1);
+=09assert(writes =3D=3D 2 && last_asha =3D=3D &asha && last_interval =3D=
=3D 40);
+=09other.state =3D ASHA_STOPPED;
+=09other.client =3D (void *) 2;
+=09event(1, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &update, sizeof(update));
+=09assert(writes =3D=3D 3 && last_asha =3D=3D &other);
+
+=09/* Failed/malformed updates leave the last successful value intact. */
+=09update.status =3D 1;
+=09event(0, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &update, sizeof(update));
+=09update.status =3D 0;
+=09event(0, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &update,
+=09=09=09=09=09=09=09sizeof(update) - 1);
+=09update.handle =3D cpu_to_le16(ASHA_NUM_HANDLES);
+=09event(0, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &update, sizeof(update));
+=09assert(writes =3D=3D 3);
+=09asha_send_interval(&dev);
+=09assert(writes =3D=3D 4 && last_interval =3D=3D 40);
+
+=09/* Closed ATT sockets cannot be associated with a cached handle. */
+=09socket_ready =3D false;
+=09asha_send_interval(&dev);
+=09assert(writes =3D=3D 4);
+=09socket_ready =3D true;
+
+=09memcpy(packet + 3, &disconnect, sizeof(disconnect));
+=09assert(write(peer_fd[0], packet, sizeof(packet)) =3D=3D sizeof(packet))=
;
+
+=09while (g_main_context_iteration(NULL, FALSE))
+=09=09;
+
+=09asha_send_interval(&dev);
+=09assert(writes =3D=3D 4);
+=09asha_send_interval(&dev2);
+=09assert(writes =3D=3D 5 && last_interval =3D=3D 40);
+
+=09/* Reused handle gets the new connection's value, never the old one. */
+=09complete.interval =3D cpu_to_le16(16);
+=09asha.client =3D NULL;
+=09event(0, BT_HCI_EVT_LE_CONN_COMPLETE, &complete, sizeof(complete));
+=09asha.client =3D (void *) 1;
+=09asha_send_interval(&dev);
+=09assert(writes =3D=3D 6 && last_interval =3D=3D 16);
+
+=09adapter =3D queue_find(asha_adapters, match_adapter, (void *) 1);
+=09assert(adapter->intervals[16] =3D=3D 16);
+=09queue_remove(asha_streams, &dev);
+=09update.handle =3D cpu_to_le16(16);
+=09event(0, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &update, sizeof(update));
+=09assert(writes =3D=3D 6);
+=09asha_adapter_remove(NULL, (void *) 1);
+=09asha_adapter_remove(NULL, (void *) 2);
+=09assert(!asha_adapters);
+=09queue_destroy(asha_streams, NULL);
+=09asha_streams =3D NULL;
+=09close(peer_fd[0]);
+=09close(peer_fd[1]);
+=09g_io_channel_unref(io);
+=09close(io_fds[0]);
+=09close(io_fds[1]);
+=09dev.io =3D NULL;
+
+=09fail_socket =3D true;
+=09assert(asha_adapter_probe(NULL, (void *) 1) =3D=3D -EIO);
+=09assert(!asha_adapters);
+=09fail_socket =3D false;
+=09tester_test_passed();
+}
+
+static void test_handle_bounds(const void *user_data)
+{
+=09const uint16_t handles[] =3D { 0, ASHA_NUM_HANDLES - 1,
+=09=09=09=09=09ASHA_NUM_HANDLES, UINT16_MAX };
+=09struct bt_asha asha =3D { .client =3D (void *) 1, .acp_handle =3D 0x79 =
};
+=09struct bt_asha_device dev =3D { .asha =3D &asha, .device =3D (void *) 1=
 };
+=09struct bt_hci_evt_le_conn_complete complete =3D {
+=09=09.interval =3D cpu_to_le16(24),
+=09};
+=09struct bt_hci_evt_le_enhanced_conn_complete enhanced =3D {
+=09=09.interval =3D cpu_to_le16(32),
+=09};
+=09struct bt_hci_evt_disconnect_complete disconnect =3D { 0 };
+=09unsigned int i;
+
+=09assert(!asha_adapter_probe(NULL, (void *) 1));
+=09asha_streams =3D queue_new();
+=09queue_push_tail(asha_streams, &dev);
+
+=09for (i =3D 0; i < ARRAY_SIZE(handles); i++) {
+=09=09att_handle =3D handles[i];
+=09=09complete.handle =3D cpu_to_le16(att_handle);
+=09=09enhanced.handle =3D complete.handle;
+=09=09disconnect.handle =3D complete.handle;
+=09=09writes =3D 0;
+=09=09event(0, BT_HCI_EVT_LE_CONN_COMPLETE, &complete,
+=09=09=09=09=09=09=09sizeof(complete));
+=09=09event(0, BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE, &enhanced,
+=09=09=09=09=09=09=09sizeof(enhanced));
+
+=09=09if (att_handle >=3D ASHA_NUM_HANDLES) {
+=09=09=09asha_send_interval(&dev);
+=09=09=09assert(writes =3D=3D 0);
+=09=09=09continue;
+=09=09}
+
+=09=09assert(writes =3D=3D 2 && last_interval =3D=3D 32);
+=09=09complete.status =3D 1;
+=09=09enhanced.status =3D 1;
+=09=09event(0, BT_HCI_EVT_LE_CONN_COMPLETE, &complete,
+=09=09=09=09=09=09=09sizeof(complete));
+=09=09event(0, BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE, &enhanced,
+=09=09=09=09=09=09=09sizeof(enhanced));
+=09=09complete.status =3D 0;
+=09=09enhanced.status =3D 0;
+=09=09event(0, BT_HCI_EVT_LE_CONN_COMPLETE, &complete,
+=09=09=09=09=09=09=09sizeof(complete) - 1);
+=09=09event(0, BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE, &enhanced,
+=09=09=09=09=09=09=09sizeof(enhanced) - 1);
+=09=09asha_send_interval(&dev);
+=09=09assert(writes =3D=3D 3 && last_interval =3D=3D 32);
+=09=09disconnect.status =3D 1;
+=09=09asha_disconn_complete(&disconnect, sizeof(disconnect),
+=09=09=09queue_find(asha_adapters, match_adapter, (void *) 1));
+=09=09asha_send_interval(&dev);
+=09=09assert(writes =3D=3D 4 && last_interval =3D=3D 32);
+=09}
+
+=09att_handle =3D 16;
+=09queue_destroy(asha_streams, NULL);
+=09asha_streams =3D NULL;
+=09asha_adapter_remove(NULL, (void *) 1);
+=09close(peer_fd[0]);
+=09tester_test_passed();
+}
+
+static void test_late_connection(const void *user_data)
+{
+=09struct bt_asha asha =3D { .client =3D (void *) 1, .acp_handle =3D 0x79,
+=09=09=09=09=09=09=09.state =3D ASHA_STARTED };
+=09struct bt_asha_device dev =3D { .asha =3D &asha, .device =3D (void *) 1=
 };
+=09struct bt_hci_evt_le_conn_complete complete =3D {
+=09=09.handle =3D cpu_to_le16(16), .interval =3D cpu_to_le16(24),
+=09};
+=09struct bt_hci_evt_le_enhanced_conn_complete enhanced =3D {
+=09=09.handle =3D cpu_to_le16(16), .interval =3D cpu_to_le16(32),
+=09};
+
+=09writes =3D 0;
+=09assert(!asha_adapter_probe(NULL, (void *) 1));
+=09asha_streams =3D queue_new();
+=09queue_push_tail(asha_streams, &dev);
+=09asha_send_interval(&dev);
+=09assert(writes =3D=3D 0);
+
+=09/* The raw socket can dispatch the initial event after GATT/START. */
+=09event(0, BT_HCI_EVT_LE_CONN_COMPLETE, &complete, sizeof(complete));
+=09assert(writes =3D=3D 1 && last_interval =3D=3D 24);
+=09event(0, BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE, &enhanced,
+=09=09=09=09=09=09=09sizeof(enhanced));
+=09assert(writes =3D=3D 2 && last_interval =3D=3D 32);
+
+=09queue_destroy(asha_streams, NULL);
+=09asha_streams =3D NULL;
+=09asha_adapter_remove(NULL, (void *) 1);
+=09close(peer_fd[0]);
+=09tester_test_passed();
+}
+
+static void test_observer_lifecycle(const void *user_data)
+{
+=09struct bt_asha asha =3D { .acp_handle =3D 0x79 };
+=09struct bt_asha_device dev =3D { .asha =3D &asha, .device =3D (void *) 1=
 };
+=09struct bt_hci_evt_le_conn_complete complete =3D {
+=09=09.handle =3D cpu_to_le16(16), .interval =3D cpu_to_le16(24),
+=09};
+=09struct bt_hci_evt_le_conn_update_complete update =3D {
+=09=09.handle =3D cpu_to_le16(16), .interval =3D cpu_to_le16(32),
+=09};
+=09uint8_t pending[] =3D { BT_H4_EVT_PKT, BT_HCI_EVT_LE_META_EVENT,
+=09=09=09=09sizeof(update) + 1,
+=09=09=09=09BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE };
+=09uint8_t packet[sizeof(pending) + sizeof(update)];
+=09uint8_t byte;
+
+=09writes =3D 0;
+=09assert(!asha_adapter_probe(NULL, (void *) 1));
+=09asha_streams =3D queue_new();
+=09queue_push_tail(asha_streams, &dev);
+=09event(0, BT_HCI_EVT_LE_CONN_COMPLETE, &complete, sizeof(complete));
+=09asha.client =3D (void *) 1;
+=09asha_send_interval(&dev);
+=09assert(writes =3D=3D 1 && last_interval =3D=3D 24);
+
+=09/* Failed/truncated events cannot replace a successful interval. */
+=09complete.status =3D 1;
+=09complete.interval =3D cpu_to_le16(40);
+=09event(0, BT_HCI_EVT_LE_CONN_COMPLETE, &complete, sizeof(complete));
+=09complete.status =3D 0;
+=09event(0, BT_HCI_EVT_LE_CONN_COMPLETE, &complete, sizeof(complete) - 1);
+=09asha_send_interval(&dev);
+=09assert(writes =3D=3D 2 && last_interval =3D=3D 24);
+
+=09conninfo_length--;
+=09asha_send_interval(&dev);
+=09conninfo_length +=3D 2;
+=09asha_send_interval(&dev);
+=09conninfo_length--;
+=09att_fd =3D -1;
+=09asha_send_interval(&dev);
+=09att_fd =3D 100;
+=09assert(writes =3D=3D 2);
+
+=09/* The passive observer must never transmit controller commands. */
+=09assert(read(peer_fd[0], &byte, 1) =3D=3D -1);
+=09assert(errno =3D=3D EAGAIN);
+=09asha_adapter_remove(NULL, (void *) 1);
+=09assert(fcntl(observer_fd[0], F_GETFD) =3D=3D -1 && errno =3D=3D EBADF);
+=09close(peer_fd[0]);
+=09assert(!asha_adapter_probe(NULL, (void *) 1));
+
+=09/* After restart, existing links stay unknown until a new update. */
+=09asha_send_interval(&dev);
+=09assert(writes =3D=3D 2);
+=09event(0, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &update, sizeof(update));
+=09assert(writes =3D=3D 3 && last_interval =3D=3D 32);
+
+=09/* Drop queued callbacks when their adapter and device are removed. */
+=09memcpy(packet, pending, sizeof(pending));
+=09memcpy(packet + sizeof(pending), &update, sizeof(update));
+=09assert(write(peer_fd[0], packet, sizeof(packet)) =3D=3D sizeof(packet))=
;
+=09queue_remove(asha_streams, &dev);
+=09asha_adapter_remove(NULL, (void *) 1);
+
+=09while (g_main_context_iteration(NULL, FALSE))
+=09=09;
+
+=09assert(writes =3D=3D 3 && !asha_adapters);
+=09assert(fcntl(observer_fd[0], F_GETFD) =3D=3D -1 && errno =3D=3D EBADF);
+=09close(peer_fd[0]);
+=09queue_destroy(asha_streams, NULL);
+=09asha_streams =3D NULL;
+=09tester_test_passed();
+}
+
+int main(int argc, char *argv[])
+{
+=09tester_init(&argc, &argv);
+=09tester_add("ASHA/interval/HCI", NULL, NULL, test_connection, NULL);
+=09tester_add("ASHA/interval/handle-bounds", NULL, NULL,
+=09=09=09=09=09=09test_handle_bounds, NULL);
+=09tester_add("ASHA/interval/late-connection", NULL, NULL,
+=09=09=09=09=09=09test_late_connection, NULL);
+=09tester_add("ASHA/interval/observer-lifecycle", NULL, NULL,
+=09=09=09=09=09=09test_observer_lifecycle, NULL);
+=09return tester_run();
+}
diff --git a/unit/test-asha-conn.h b/unit/test-asha-conn.h
new file mode 100644
index 0000000..5e88aed
--- /dev/null
+++ b/unit/test-asha-conn.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include <sys/socket.h>
+
+int __wrap_socket(int domain, int type, int protocol);
+int __wrap_bind(int fd, const struct sockaddr *addr, socklen_t length);
+int __wrap_setsockopt(int fd, int level, int opt, const void *value,
+=09=09=09=09=09=09=09socklen_t length);
+int __wrap_getsockopt(int fd, int level, int opt, void *value,
+=09=09=09=09=09=09=09socklen_t *length);
+int __real_setsockopt(int fd, int level, int opt, const void *value,
+=09=09=09=09=09=09=09socklen_t length);
diff --git a/unit/test-asha-interval.c b/unit/test-asha-interval.c
new file mode 100644
index 0000000..1150b1e
--- /dev/null
+++ b/unit/test-asha-interval.c
@@ -0,0 +1,355 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+#include <assert.h>
+
+/* Redirect source-level calls so LTO cannot bypass the GATT mock. */
+#define bt_gatt_client_write_without_response test_gatt_write
+#include "src/shared/asha.c"
+#undef bt_gatt_client_write_without_response
+#include "src/shared/tester.h"
+
+static unsigned int writes;
+static struct bt_gatt_client *failed_client;
+static uint8_t expected_interval;
+
+static void detach(struct bt_asha *asha)
+{
+=09/* Fixtures mock client pointers instead of owning GATT clients. */
+=09asha->client =3D NULL;
+=09bt_asha_reset(asha);
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
+unsigned int test_gatt_write(
+=09struct bt_gatt_client *client, uint16_t handle, bool signed_write,
+=09=09=09=09const uint8_t *value, uint16_t length)
+{
+=09assert(client);
+=09assert(handle =3D=3D 0x79);
+=09assert(!signed_write);
+=09assert(length =3D=3D 3);
+=09assert(value[0] =3D=3D 0x03 && value[1] =3D=3D 0x02);
+=09assert(value[2] =3D=3D expected_interval);
+=09writes++;
+=09return client !=3D failed_client;
+}
+
+static void test_interval(const void *user_data)
+{
+=09struct bt_asha left =3D {
+=09=09.client =3D (void *) 1, .acp_handle =3D 0x79, .hisyncid =3D { 1 },
+=09=09.psm =3D 0x25,
+=09};
+=09struct bt_asha right =3D {
+=09=09.client =3D (void *) 2, .acp_handle =3D 0x79, .hisyncid =3D { 1 },
+=09=09.right_side =3D true,
+=09=09.psm =3D 0x25,
+=09};
+=09struct bt_asha unrelated =3D {
+=09=09.client =3D (void *) 3, .acp_handle =3D 0x79, .hisyncid =3D { 2 },
+=09=09.psm =3D 0x25,
+=09};
+
+=09asha_devices =3D queue_new();
+=09check_probe_done(&left);
+=09check_probe_done(&right);
+=09check_probe_done(&unrelated);
+=09update_asha_set(&left, true);
+=09update_asha_set(&right, true);
+=09update_asha_set(&unrelated, true);
+=09writes =3D 0;
+=09expected_interval =3D 16;
+
+=09/* Both attached sides, including a stopped peer, receive the update. *=
/
+=09assert(bt_asha_set_connection_interval(&left, expected_interval));
+=09assert(writes =3D=3D 2);
+=09assert(bt_asha_set_connection_interval(&right, expected_interval));
+=09assert(writes =3D=3D 4);
+=09assert(bt_asha_set_connection_interval(&unrelated, expected_interval));
+=09assert(writes =3D=3D 5);
+
+=09assert(!bt_asha_set_connection_interval(&left, 5));
+=09assert(!bt_asha_set_connection_interval(&left, 0));
+=09assert(!bt_asha_set_connection_interval(&left, 256));
+=09assert(!bt_asha_set_connection_interval(&left, UINT16_MAX));
+=09assert(!bt_asha_set_connection_interval(NULL, 16));
+=09assert(writes =3D=3D 5);
+
+=09expected_interval =3D 6;
+=09assert(bt_asha_set_connection_interval(&left, expected_interval));
+=09assert(writes =3D=3D 7);
+=09expected_interval =3D 255;
+=09assert(bt_asha_set_connection_interval(&right, expected_interval));
+=09assert(writes =3D=3D 9);
+
+=09/* Failure on either side does not suppress the other side's attempt. *=
/
+=09failed_client =3D left.client;
+=09assert(!bt_asha_set_connection_interval(&left, expected_interval));
+=09assert(writes =3D=3D 11);
+=09assert(!bt_asha_set_connection_interval(&right, expected_interval));
+=09assert(writes =3D=3D 13);
+=09failed_client =3D NULL;
+
+=09right.client =3D NULL;
+=09assert(bt_asha_set_connection_interval(&left, expected_interval));
+=09assert(writes =3D=3D 14);
+=09assert(!bt_asha_set_connection_interval(&right, expected_interval));
+=09assert(writes =3D=3D 14);
+=09right.client =3D (void *) 2;
+=09right.acp_handle =3D 0;
+=09assert(bt_asha_set_connection_interval(&left, expected_interval));
+=09assert(writes =3D=3D 15);
+=09assert(!bt_asha_set_connection_interval(&right, expected_interval));
+=09assert(writes =3D=3D 15);
+
+=09detach(&right);
+=09assert(bt_asha_set_connection_interval(&left, expected_interval));
+=09assert(writes =3D=3D 16);
+=09detach(&left);
+=09detach(&unrelated);
+=09assert(!asha_devices && !asha_attached);
+=09tester_test_passed();
+}
+
+/* How the object that leaves a pair is torn down, as the device code does=
. */
+#define TEST_RIGHT=090x01=09/* The leaving object is the right side */
+#define TEST_RESET=090x02=09/* Disconnect: reset, then reset again */
+#define TEST_FREE=090x04=09/* Device removal: free, after any reset */
+
+static void test_leave(const void *user_data)
+{
+=09unsigned int flags =3D PTR_TO_UINT(user_data);
+=09bool right =3D flags & TEST_RIGHT;
+=09struct bt_asha *leaving =3D bt_asha_new();
+=09struct bt_asha remaining =3D {
+=09=09.client =3D (void *) 1, .acp_handle =3D 0x79, .hisyncid =3D { 1 },
+=09=09.right_side =3D !right,
+=09=09.psm =3D 0x25,
+=09};
+=09struct bt_asha_set *set;
+
+=09leaving->hisyncid[0] =3D 1;
+=09leaving->right_side =3D right;
+=09leaving->psm =3D 0x25;
+=09asha_devices =3D queue_new();
+=09check_probe_done(leaving);
+=09check_probe_done(&remaining);
+=09update_asha_set(leaving, true);
+=09update_asha_set(&remaining, true);
+
+=09if (flags & TEST_RESET) {
+=09=09bt_asha_reset(leaving);
+=09=09bt_asha_reset(leaving);
+=09}
+
+=09if (flags & TEST_FREE) {
+=09=09bt_asha_free(leaving);
+=09=09leaving =3D NULL;
+=09}
+
+=09/* No slot may keep the object, so a freed one is never reached. */
+=09set =3D find_asha_set(&remaining);
+=09assert(set);
+=09assert(right ? !set->right : !set->left);
+=09assert(right ? set->left =3D=3D &remaining : set->right =3D=3D &remaini=
ng);
+
+=09writes =3D 0;
+=09expected_interval =3D 16;
+=09assert(bt_asha_set_connection_interval(&remaining, 16));
+=09assert(writes =3D=3D 1);
+
+=09/* Releasing an object that is no longer in a set stays harmless. */
+=09if (leaving)
+=09=09bt_asha_free(leaving);
+
+=09detach(&remaining);
+=09assert(!asha_devices && !asha_attached);
+=09tester_test_passed();
+}
+
+/* A newer object for the same side must survive the older one's release. =
*/
+static void test_replace(const void *user_data)
+{
+=09unsigned int flags =3D PTR_TO_UINT(user_data);
+=09bool right =3D flags & TEST_RIGHT;
+=09struct bt_asha *old =3D bt_asha_new();
+=09struct bt_asha *cur =3D bt_asha_new();
+=09struct bt_asha remaining =3D {
+=09=09.client =3D (void *) 1, .acp_handle =3D 0x79, .hisyncid =3D { 1 },
+=09=09.right_side =3D !right,
+=09=09.psm =3D 0x25,
+=09};
+=09struct bt_asha_set *set;
+
+=09old->hisyncid[0] =3D cur->hisyncid[0] =3D 1;
+=09old->right_side =3D cur->right_side =3D right;
+=09cur->client =3D (void *) 2;
+=09cur->acp_handle =3D 0x79;
+=09old->client =3D (void *) 3;
+=09old->acp_handle =3D 0x79;
+=09old->psm =3D cur->psm =3D 0x25;
+=09asha_devices =3D queue_new();
+=09check_probe_done(old);
+=09check_probe_done(&remaining);
+=09check_probe_done(cur);
+=09update_asha_set(old, true);
+=09update_asha_set(&remaining, true);
+=09update_asha_set(cur, true);
+=09writes =3D 0;
+=09expected_interval =3D 16;
+=09failed_client =3D old->client;
+=09assert(bt_asha_set_connection_interval(&remaining, expected_interval));
+=09assert(writes =3D=3D 2);
+=09failed_client =3D NULL;
+=09old->client =3D NULL;
+
+=09if (flags & TEST_RESET)
+=09=09bt_asha_reset(old);
+=09else
+=09=09bt_asha_free(old);
+
+=09set =3D find_asha_set(&remaining);
+=09assert(set);
+=09assert(right ? set->right =3D=3D cur : set->left =3D=3D cur);
+
+=09writes =3D 0;
+=09expected_interval =3D 16;
+=09assert(bt_asha_set_connection_interval(&remaining, 16));
+=09assert(writes =3D=3D 2);
+
+=09if (flags & TEST_RESET)
+=09=09bt_asha_free(old);
+
+=09cur->client =3D NULL;
+=09bt_asha_free(cur);
+=09detach(&remaining);
+=09assert(!asha_devices && !asha_attached);
+=09tester_test_passed();
+}
+
+static void attach_properties(struct bt_asha *asha, bool right, bool psm_f=
irst)
+{
+=09uint8_t rops[] =3D {
+=09=091, 2, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0,
+=09};
+=09uint8_t psm[] =3D { 0x25, 0 };
+
+=09rops[1] |=3D right;
+
+=09if (psm_first)
+=09=09read_psm(true, 0, psm, sizeof(psm), asha);
+
+=09read_rops(true, 0, rops, sizeof(rops), asha);
+
+=09if (!psm_first)
+=09=09read_psm(true, 0, psm, sizeof(psm), asha);
+}
+
+static void test_attach(const void *user_data)
+{
+=09unsigned int flags =3D PTR_TO_UINT(user_data);
+=09struct bt_asha left =3D { .client =3D (void *) 1, .acp_handle =3D 0x79 =
};
+=09struct bt_asha right =3D { .client =3D (void *) 2, .acp_handle =3D 0x79=
 };
+=09struct bt_asha *sender =3D flags & 1 ? &right : &left;
+
+=09asha_devices =3D queue_new();
+=09attach_properties(&left, false, flags & 2);
+=09attach_properties(&right, true, flags & 2);
+=09assert(queue_length(asha_attached) =3D=3D 2);
+=09check_probe_done(&right);
+=09assert(queue_length(asha_attached) =3D=3D 2);
+=09/* Attachment must not change the existing START other-connected bit. *=
/
+=09assert(!is_other_connected(&left) && !is_other_connected(&right));
+=09writes =3D 0;
+=09expected_interval =3D 16;
+=09assert(bt_asha_set_connection_interval(sender, expected_interval));
+=09assert(writes =3D=3D 2);
+=09assert(left.state =3D=3D ASHA_STOPPED && right.state =3D=3D ASHA_STOPPE=
D);
+=09detach(&left);
+=09detach(&right);
+=09assert(!asha_attached);
+=09queue_destroy(asha_devices, NULL);
+=09asha_devices =3D NULL;
+=09tester_test_passed();
+}
+
+static void test_incomplete_peer(const void *user_data)
+{
+=09struct bt_asha left =3D { .client =3D (void *) 1, .acp_handle =3D 0x79 =
};
+=09struct bt_asha right =3D {
+=09=09.client =3D (void *) 2, .acp_handle =3D 0x79, .right_side =3D true,
+=09=09.hisyncid =3D { 1 },
+=09};
+
+=09asha_devices =3D queue_new();
+=09attach_properties(&left, false, false);
+=09check_probe_done(&right);
+=09writes =3D 0;
+=09expected_interval =3D 16;
+=09assert(bt_asha_set_connection_interval(&left, expected_interval));
+=09assert(writes =3D=3D 1);
+=09right.psm =3D 0x25;
+=09memset(right.hisyncid, 0, sizeof(right.hisyncid));
+=09check_probe_done(&right);
+=09assert(bt_asha_set_connection_interval(&left, expected_interval));
+=09assert(writes =3D=3D 2);
+=09attach_properties(&right, true, false);
+=09assert(bt_asha_set_connection_interval(&left, expected_interval));
+=09assert(writes =3D=3D 4);
+=09detach(&left);
+=09detach(&right);
+=09assert(!asha_attached);
+=09queue_destroy(asha_devices, NULL);
+=09asha_devices =3D NULL;
+=09tester_test_passed();
+}
+
+int main(int argc, char *argv[])
+{
+=09tester_init(&argc, &argv);
+=09tester_add("ASHA/interval/pair", NULL, NULL, test_interval, NULL);
+=09tester_add("ASHA/attach/left/rops-first", UINT_TO_PTR(0), NULL,
+=09=09=09=09=09=09=09test_attach, NULL);
+=09tester_add("ASHA/attach/right/rops-first", UINT_TO_PTR(1), NULL,
+=09=09=09=09=09=09=09test_attach, NULL);
+=09tester_add("ASHA/attach/left/psm-first", UINT_TO_PTR(2), NULL,
+=09=09=09=09=09=09=09test_attach, NULL);
+=09tester_add("ASHA/attach/right/psm-first", UINT_TO_PTR(3), NULL,
+=09=09=09=09=09=09=09test_attach, NULL);
+=09tester_add("ASHA/attach/incomplete", NULL, NULL,
+=09=09=09=09=09=09test_incomplete_peer, NULL);
+
+=09tester_add("ASHA/leave/reset/left", UINT_TO_PTR(TEST_RESET), NULL,
+=09=09=09=09=09=09=09test_leave, NULL);
+=09tester_add("ASHA/leave/reset/right",
+=09=09=09UINT_TO_PTR(TEST_RESET | TEST_RIGHT), NULL,
+=09=09=09=09=09=09=09test_leave, NULL);
+=09tester_add("ASHA/leave/free/left", UINT_TO_PTR(TEST_FREE), NULL,
+=09=09=09=09=09=09=09test_leave, NULL);
+=09tester_add("ASHA/leave/free/right",
+=09=09=09UINT_TO_PTR(TEST_FREE | TEST_RIGHT), NULL,
+=09=09=09=09=09=09=09test_leave, NULL);
+=09tester_add("ASHA/leave/reset-free/left",
+=09=09=09UINT_TO_PTR(TEST_RESET | TEST_FREE), NULL,
+=09=09=09=09=09=09=09test_leave, NULL);
+=09tester_add("ASHA/leave/reset-free/right",
+=09=09UINT_TO_PTR(TEST_RESET | TEST_FREE | TEST_RIGHT), NULL,
+=09=09=09=09=09=09=09test_leave, NULL);
+
+=09tester_add("ASHA/replace/free/left", UINT_TO_PTR(0), NULL,
+=09=09=09=09=09=09=09test_replace, NULL);
+=09tester_add("ASHA/replace/free/right", UINT_TO_PTR(TEST_RIGHT), NULL,
+=09=09=09=09=09=09=09test_replace, NULL);
+=09tester_add("ASHA/replace/reset/left", UINT_TO_PTR(TEST_RESET), NULL,
+=09=09=09=09=09=09=09test_replace, NULL);
+=09tester_add("ASHA/replace/reset/right",
+=09=09=09UINT_TO_PTR(TEST_RESET | TEST_RIGHT), NULL,
+=09=09=09=09=09=09=09test_replace, NULL);
+=09return tester_run();
+}
--=20
2.56.1


