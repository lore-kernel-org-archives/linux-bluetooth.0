Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.103
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795649296;
	b=l9kY3hxxvfRYmb/dSLCIEmgVHbBFyhzQEbzQi4jmlih3lGd2yWZ9IOx0c6GL7f7JulWo
	 qspxi7Hu9C8NwjRzTafu8uD4rreMXdNhD2oH5F/XJsCZYaGd/uCb7As1IEBXvjdMlnk0J
	 IN69h0KhAuiQDzq0BTLpW7tKB+EtBAp4PoK48F6QxM7/5lVN/js5w1IkgIbKV/gF/aCuT
	 EIQJYExHmpxgjBAeg/CtY0GqU3MBAuRlk4RfQkNXxXkVGTr/3//F+UJDMlIw766PdMgrU
	 z2yHESGcDH+Qsb1YDBU54Y6cXI8OZmo1ZmyFLWTdIllmCDa8pEznGlHMX3KrR9+QkJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795649296;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=iULYMwwT9Yz0ZAC4dZBowl5vTUSi9rHR+70m2dDHYGA=;
	b=RpUZJhIk49ZtCqj3xKEFumWjSqWSgNlR5k6YwLVhpyLo2lgHZ9kLqlSE3Ez177Th5+kH
	 HIkmemqW+ZklRZQdUk5s8D2zKkQYYbibQ4y8TnKvPM+oBD/hIWCmd59cIH/zC8lCxo1yo
	 qKYxsC3z3KWENpc770E9w8eYzkXWy7w5css5NwOK+RgP15pqib571t/iiWuZR/0050tNV
	 v8+mudKprIzbA+EJCOt7lAgbVd85JlUG00q2TCCSghat+Its1+xt0vKwOBTD6SgnE6e2p
	 KbO+Q1jt/CFZzcRuV3iQSsF/QLM2eMGxuDqDyq8Wvk2Tr3h2Imz2ugA/VTXiCcQxPyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=zdFsIZ2h;
	arc=none smtp.remote-ip=185.70.43.103
Received: from mail-43103.protonmail.ch (mail-43103.protonmail.ch [185.70.43.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7EE606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 23:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD7EE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=zdFsIZ2h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1795649292; x=1795908492;
	bh=iULYMwwT9Yz0ZAC4dZBowl5vTUSi9rHR+70m2dDHYGA=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=zdFsIZ2h97bQFvEA5XskE5X/oZwiSdLomrvYFQYRHvIMpH9JAM76PfZYoL/Y7FA7T
	 ijm4HeiNs6n38HjJPqS4CCHyJr2/CzRsQ+5GNRx+zhOTsJK1A2L5ZPGRjMhX29xA+T
	 +Zye8sBkYbutxJ79+SvU9ICwZ+Wp+7NH/Ic0Co2OPZ1QJyqA4JR9YR/CbujabRF+aN
	 pc7V+RgBQMkiDcoiwmh89Ijd6dbcwQRxBaU466NYRNlnKDqiwhcfcqkdCISF+gTbkM
	 frnOPccQ4iVr4olBXm6yHORcpC+xlDlVApqfn2tHDhkr7T6sOVkSTzWKg7ncA6VEAC
	 Lh9gxCtmVG69A==
Date: Wed, 25 Nov 2026 23:28:07 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Subject: [RFC PATCH BlueZ v6 3/4] asha: Notify observed connection intervals
Message-ID: <4670f4555d9e556c582ab7627b40aa10e00eb1c9.1795648818.git.cochcoder@proton.me>
In-Reply-To: <cover.1795648818.git.cochcoder@proton.me>
References: <20261029002158.1036153-1-cochcoder@proton.me> <20261106235122.719665-1-cochcoder@proton.me> <cover.1795489294.git.cochcoder@proton.me> <cover.1795535897.git.cochcoder@proton.me> <cover.1795648818.git.cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 0e6d0d835ac9fa5bffc2d62c9437837b0211b31d
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

Cache successful connection intervals per adapter and match each update
to the ATT connection handle. Announce the cached value before START and
notify attached devices when an initial or updated interval arrives. The
cached value is the last one observed; a requested update may still be
pending and is announced when it completes. Clear disconnected handles
so reused links cannot inherit stale values.

The observer only sees events after the adapter is probed, so a link
that was already connected when bluetoothd started has no cached
interval until its next update, and nothing is sent for it.

Assisted-by: OpenCode:gpt-6.1-sol
Assisted-by: Codex:gpt-6
---
 profiles/audio/asha.c | 231 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 231 insertions(+)

diff --git a/profiles/audio/asha.c b/profiles/audio/asha.c
index d86224764..e6a9ded62 100644
--- a/profiles/audio/asha.c
+++ b/profiles/audio/asha.c
@@ -39,6 +39,11 @@
 #include "src/profile.h"
 #include "src/service.h"
 #include "src/shared/util.h"
+#include "src/shared/queue.h"
+#include "src/shared/hci.h"
+#include "src/shared/att.h"
+#include "src/shared/gatt-client.h"
+#include "monitor/bt.h"
=20
 #include "profiles/audio/asha.h"
 #include "profiles/audio/media.h"
@@ -51,6 +56,18 @@
 /* The default of 672 does not work */
 #define ASHA_CONNECTION_MTU 512
=20
+/* HCI handles include zero; a zero cached interval means unknown. */
+#define ASHA_NUM_HANDLES 0x0f00
+
+struct asha_adapter {
+=09struct btd_adapter *adapter;
+=09struct bt_hci *hci;
+=09uint16_t intervals[ASHA_NUM_HANDLES];
+};
+
+static struct queue *asha_adapters;
+static struct queue *asha_streams;
+
 struct bt_asha_device {
 =09struct bt_asha *asha;
 =09struct btd_device *device;
@@ -62,6 +79,203 @@ struct bt_asha_device {
 =09unsigned int resume_id;
 };
=20
+static bool match_adapter(const void *data, const void *user_data)
+{
+=09const struct asha_adapter *data_adapter =3D data;
+
+=09return data_adapter->adapter =3D=3D user_data;
+}
+
+static bool asha_get_handle(struct bt_asha_device *asha_dev, uint16_t *han=
dle)
+{
+=09struct bt_att *att;
+=09struct l2cap_conninfo info;
+=09socklen_t len =3D sizeof(info);
+=09int fd;
+
+=09if (!asha_dev->asha->client)
+=09=09return false;
+
+=09att =3D bt_gatt_client_get_att(asha_dev->asha->client);
+=09fd =3D bt_att_get_fd(att);
+
+=09/* The ATT socket identifies this link even when CoC is not open. */
+=09if (fd < 0 || getsockopt(fd, SOL_L2CAP, L2CAP_CONNINFO,
+=09=09=09=09=09=09=09&info, &len) < 0) {
+=09=09DBG("Could not read ASHA connection handle");
+=09=09return false;
+=09}
+
+=09if (len !=3D sizeof(info) || info.hci_handle >=3D ASHA_NUM_HANDLES)
+=09=09return false;
+
+=09*handle =3D info.hci_handle;
+=09return true;
+}
+
+static void asha_notify_interval(struct bt_asha_device *asha_dev,
+=09=09=09=09=09uint16_t handle, uint16_t interval)
+{
+=09/* Only announce an interval observed on this connection. */
+=09if (!interval)
+=09=09return;
+
+=09DBG("ASHA connection h%u interval %u", handle, interval);
+
+=09if (!bt_asha_set_connection_interval(asha_dev->asha, interval))
+=09=09DBG("Could not send ASHA connection interval notification");
+}
+
+static void asha_send_interval(struct bt_asha_device *asha_dev)
+{
+=09struct asha_adapter *data;
+=09uint16_t handle;
+
+=09data =3D queue_find(asha_adapters, match_adapter,
+=09=09=09=09=09device_get_adapter(asha_dev->device));
+=09if (!data || !asha_get_handle(asha_dev, &handle))
+=09=09return;
+
+=09asha_notify_interval(asha_dev, handle, data->intervals[handle]);
+}
+
+struct interval_update {
+=09struct asha_adapter *adapter;
+=09uint16_t handle;
+};
+
+static void asha_update_stream(void *data, void *user_data)
+{
+=09struct bt_asha_device *asha_dev =3D data;
+=09struct interval_update *update =3D user_data;
+=09uint16_t handle;
+
+=09if (device_get_adapter(asha_dev->device) !=3D update->adapter->adapter =
||
+=09=09=09!asha_get_handle(asha_dev, &handle) ||
+=09=09=09handle !=3D update->handle)
+=09=09return;
+
+=09asha_notify_interval(asha_dev, handle,
+=09=09=09=09=09update->adapter->intervals[handle]);
+}
+
+static void asha_update_interval(struct asha_adapter *data, uint16_t handl=
e,
+=09=09=09=09=09=09=09uint16_t interval)
+{
+=09struct interval_update update =3D { .adapter =3D data, .handle =3D hand=
le };
+
+=09if (handle >=3D ASHA_NUM_HANDLES)
+=09=09return;
+
+=09data->intervals[handle] =3D interval;
+=09queue_foreach(asha_streams, asha_update_stream, &update);
+}
+
+static void asha_conn_update(const void *param, uint8_t size, void *user_d=
ata)
+{
+=09const struct bt_hci_evt_le_conn_update_complete *ev =3D param;
+
+=09if (size !=3D sizeof(*ev) || ev->status)
+=09=09return;
+
+=09asha_update_interval(user_data, get_le16(&ev->handle),
+=09=09=09=09=09=09get_le16(&ev->interval));
+}
+
+static void asha_conn_complete(const void *param, uint8_t size, void *user=
_data)
+{
+=09const struct bt_hci_evt_le_conn_complete *ev =3D param;
+
+=09if (size !=3D sizeof(*ev) || ev->status)
+=09=09return;
+
+=09asha_update_interval(user_data, get_le16(&ev->handle),
+=09=09=09=09=09=09get_le16(&ev->interval));
+}
+
+static void asha_enhanced_conn_complete(const void *param, uint8_t size,
+=09=09=09=09=09=09=09void *user_data)
+{
+=09const struct bt_hci_evt_le_enhanced_conn_complete *ev =3D param;
+
+=09if (size !=3D sizeof(*ev) || ev->status)
+=09=09return;
+
+=09asha_update_interval(user_data, get_le16(&ev->handle),
+=09=09=09=09=09=09get_le16(&ev->interval));
+}
+
+static void asha_disconn_complete(const void *param, uint8_t size,
+=09=09=09=09=09=09=09void *user_data)
+{
+=09const struct bt_hci_evt_disconnect_complete *ev =3D param;
+=09struct asha_adapter *data =3D user_data;
+=09uint16_t handle;
+
+=09if (size !=3D sizeof(*ev) || ev->status)
+=09=09return;
+
+=09handle =3D get_le16(&ev->handle);
+
+=09if (handle < ASHA_NUM_HANDLES)
+=09=09data->intervals[handle] =3D 0;
+}
+
+static int asha_adapter_probe(struct btd_profile *profile,
+=09=09=09=09=09=09struct btd_adapter *adapter)
+{
+=09struct asha_adapter *data;
+
+=09data =3D new0(struct asha_adapter, 1);
+=09data->adapter =3D adapter;
+=09data->hci =3D bt_hci_new_raw_device(btd_adapter_get_index(adapter));
+
+=09if (!data->hci)
+=09=09goto fail;
+
+=09if (!bt_hci_register_subevent(data->hci, BT_HCI_EVT_LE_CONN_COMPLETE,
+=09=09=09=09=09asha_conn_complete, data, NULL) ||
+=09=09!bt_hci_register_subevent(data->hci,
+=09=09=09=09=09BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE,
+=09=09=09=09asha_enhanced_conn_complete, data, NULL) ||
+=09=09!bt_hci_register_subevent(data->hci,
+=09=09=09=09=09BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE,
+=09=09=09=09=09asha_conn_update, data, NULL) ||
+=09=09!bt_hci_register(data->hci, BT_HCI_EVT_DISCONNECT_COMPLETE,
+=09=09=09=09=09asha_disconn_complete, data, NULL))
+=09=09goto fail;
+
+=09if (!asha_adapters)
+=09=09asha_adapters =3D queue_new();
+
+=09queue_push_tail(asha_adapters, data);
+=09return 0;
+
+fail:
+=09bt_hci_unref(data->hci);
+=09free(data);
+=09return -EIO;
+}
+
+static void asha_adapter_remove(struct btd_profile *profile,
+=09=09=09=09=09=09struct btd_adapter *adapter)
+{
+=09struct asha_adapter *data;
+
+=09data =3D queue_remove_if(asha_adapters, match_adapter, adapter);
+
+=09if (!data)
+=09=09return;
+
+=09bt_hci_unref(data->hci);
+=09free(data);
+
+=09if (queue_isempty(asha_adapters)) {
+=09=09queue_destroy(asha_adapters, NULL);
+=09=09asha_adapters =3D NULL;
+=09}
+}
+
 static char *make_endpoint_path(struct bt_asha_device *asha_dev)
 {
 =09char *path;
@@ -118,6 +332,8 @@ static void connect_cb(GIOChannel *io, GError *err, gpo=
inter user_data)
=20
 =09asha_dev->io =3D io;
=20
+=09asha_send_interval(asha_dev);
+
 =09bt_asha_start(asha_dev->asha, conn_data->cb,
 =09=09=09=09=09conn_data->cb_user_data);
 }
@@ -361,6 +577,11 @@ static int asha_source_device_probe(struct btd_service=
 *service)
 =09asha_dev->asha =3D bt_asha_new();
 =09asha_dev->io =3D NULL;
=20
+=09if (!asha_streams)
+=09=09asha_streams =3D queue_new();
+
+=09queue_push_tail(asha_streams, asha_dev);
+
 =09btd_service_set_user_data(service, asha_dev);
=20
 =09return 0;
@@ -382,6 +603,13 @@ static void asha_source_device_remove(struct btd_servi=
ce *service)
 =09=09return;
 =09}
=20
+=09queue_remove(asha_streams, asha_dev);
+
+=09if (queue_isempty(asha_streams)) {
+=09=09queue_destroy(asha_streams, NULL);
+=09=09asha_streams =3D NULL;
+=09}
+
 =09bt_asha_free(asha_dev->asha);
 =09g_free(asha_dev);
 }
@@ -514,6 +742,9 @@ static struct btd_profile asha_source_profile =3D {
 =09.remote_uuid=09=3D ASHA_PROFILE_UUID,
 =09.experimental=09=3D true,
=20
+=09.adapter_probe=09=3D asha_adapter_probe,
+=09.adapter_remove=09=3D asha_adapter_remove,
+
 =09.device_probe=09=3D asha_source_device_probe,
 =09.device_remove=09=3D asha_source_device_remove,
=20
--=20
2.56.1


