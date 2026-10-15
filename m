Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A587E370AE6
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 04:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792040194; cv=none; b=UNwWe9NHffOb+10xENqL54v75XnyOpEuWXNDRFkqMV5RfRE46ea3Ik5q9FHhmmgQya1IDgukTASqoZzYWRAi/TmLHuRLgpNFzKo/gAli+lfV4ZjNTRH4xNuRi6+ljup0qUySG4z+zg5xyk/yhQoFWlnsnmX9r+pyuz2ZmK8FtEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792040194; c=relaxed/simple;
	bh=smN2cDR3FejVVAwQCYm8F8tgdpGnC0vu69EdRMjsegU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EjIPPIsJRp0KVBFgle9GwAfYQ6ceELnRJxetbHqNe0+rU/qoPJt1SJrBX5iFftRGVaFVhdT/n5PBmuKmmRWyzwvcY3wEqUTtnT1n784pFHMdIbDomZlFioAOSFOtA329Tn9H4xhpeTdDAD70DzfQXGOl2qrrpNytpmyszTwON8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=v9I4FaIX; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="v9I4FaIX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=2ia27oyizjandc4hthhvgskmty.protonmail2; t=1792040179;
	x=1792299379; bh=B+tBffwDkuCdDBU6qQDWEaTqiWRraWkC0oYx4AUr95k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=v9I4FaIX4dWvzK9AcJscPDf6ZdDRWRfQkisuUfKbC796QbeqXCamUdRXz0rcDfc0A
	 Ps8Jo6ZfV+aybNYoo2I6/pqJYwi7I32CE1K0Wi+NvqkEgtF32QVOnjZIbeSOm2jk4u
	 A3akEN0kktnmN+FApUyh97X0axcvTZhR4x1zAyyI3yuctUJrFWqxNs7FmoWiIWtD/n
	 WG03dl7ilHW8M2YrlHjKnYBbAEuefmcfr/ohIoZM7GFTsdb9lPhfLoADvLZAG+K2Fq
	 ZPNPAr4e1hhy3Sh74fedEvtrpQ310U/rbHnSuFzPcXlzeCAxmGUgiJ2tgRu4HzhEuS
	 azSVcDSKLdgwQ==
Date: Thu, 15 Oct 2026 04:56:14 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [RFC PATCH 2/2] asha: Gate streaming on the observed connection interval
Message-ID: <20261015045525.66971-2-cochcoder@proton.me>
In-Reply-To: <20261015045525.66971-1-cochcoder@proton.me>
References: <20261015045525.66971-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 6dac98114b185b0739c76e31795e253fa9e67515
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Wait for a completed 20 ms interval and queued STATUS before sending
G.722 START. Bound acquisition through AudioStatusPoint and cancel
pending CoC, timer and ACP work before releasing its owner.

Report later completed intervals and close an acquired stream if its
interval becomes incompatible. Defer transport teardown outside HCI
iteration and unregister its callback when the transport is destroyed.

Fixes: c26389c466a0 ("profiles/audio: Add an ASHA plugin")
Assisted-by: OpenCode:gpt-6.1-sol
---
Second of two new patches; requires patch 1 and the already-sent STATUS v2
and STOP prerequisites. It does not replace or resend either prerequisite.

Observe a completed 20 ms interval and queue STATUS before START. Bound set=
up
through AudioStatusPoint and cancel pending acquisition on stop/reset/remov=
al.
On an incompatible completed interval after acquisition, report STATUS and =
defer
STOP, CoC closure and transport-owner removal outside the HCI stream iterat=
ion.
A failed update proposal does not invalidate a last observed working interv=
al.

Coverage includes 21 startup, seven pending-CoC and 12 acquired-stream scen=
arios.
Combined standalone source: 38/38 strict ASan/UBSan and 38/38 ordinary LTO =
unit
binaries. Actual BtIO watch fixture: 500 cycles; extracted transport closur=
e
functions: 1,000 mocked-owner cycles. No Valgrind or remote-CI pass is clai=
med.

The combined Arch port passes 44/44 package tests and is reported working o=
n
hardware; specific N7, paired-device and incompatible-update hardware cover=
age
was not supplied. Standalone source is submitted here, not package integrat=
ion.

Unknown/missed initial intervals are not reconstructed from requested value=
s:
setup waits for an observation and may time out, including after daemon res=
tart.
Incompatible acquired timing closes the audio stream; seamless renegotiatio=
n
or uninterrupted playback is not guaranteed. No forced ACL disconnect or ne=
w
kernel ABI is added. A valid disjoint peer request can remain legal in Linu=
x.

Companion Linux soft-preference RFC v2 and independent BlueZ interval tests=
:
https://lore.kernel.org/linux-bluetooth/20261015043336.47734-1-cochcoder@pr=
oton.me/
https://lore.kernel.org/linux-bluetooth/20261015044221.55631-1-cochcoder@pr=
oton.me/
Archive rendering of these links has not been independently verified.

 profiles/audio/asha.c      | 333 +++++++++++++++++---
 profiles/audio/asha.h      |   2 +
 profiles/audio/transport.c |  20 +-
 unit/test-asha-conn.c      | 603 +++++++++++++++++++++++++++++++++++--
 4 files changed, 904 insertions(+), 54 deletions(-)

diff --git a/profiles/audio/asha.c b/profiles/audio/asha.c
index 6596ff3633..310022ff4c 100644
--- a/profiles/audio/asha.c
+++ b/profiles/audio/asha.c
@@ -55,6 +55,8 @@
 #define ASHA_MIN_MTU 163
 /* The default of 672 does not work */
 #define ASHA_CONNECTION_MTU 512
+#define ASHA_STREAM_INTERVAL 0x0010
+#define ASHA_START_TIMEOUT 10
=20
 /* HCI connection handles occupy 0x0000 through 0x0eff. Zero is unknown. *=
/
 #define ASHA_NUM_HANDLES 0x0f00
@@ -68,15 +70,34 @@ struct asha_adapter {
 static struct queue *asha_adapters;
 static struct queue *asha_streams;
=20
+struct asha_start_wait {
+=09bt_asha_cb_t callback;
+=09void *user_data;
+=09unsigned int source_id;
+=09int error;
+=09bool connected;
+=09bool sent;
+};
+
+struct connect_data {
+=09struct bt_asha_device *asha_dev;
+};
+
 struct bt_asha_device {
 =09struct bt_asha *asha;
 =09struct btd_device *device;
 =09struct media_transport *transport;
=20
 =09GIOChannel *io;
+=09struct connect_data *connect_data;
 =09uint16_t imtu, omtu;
=20
 =09unsigned int resume_id;
+=09struct asha_start_wait *start_wait;
+=09unsigned int close_id;
+=09int close_error;
+=09bt_asha_cb_t closed_cb;
+=09void *closed_data;
 };
=20
 static bool match_adapter(const void *data, const void *user_data)
@@ -113,20 +134,25 @@ static bool asha_get_handle(struct bt_asha_device *as=
ha_dev, uint16_t *handle)
 =09return true;
 }
=20
-static void asha_notify_interval(struct bt_asha_device *asha_dev,
+static bool asha_notify_interval(struct bt_asha_device *asha_dev,
 =09=09=09=09=09uint16_t handle, uint16_t interval)
 {
 =09/* Only announce an interval observed on this connection. */
 =09if (!interval)
-=09=09return;
+=09=09return false;
=20
 =09DBG("ASHA connection h%u interval %u", handle, interval);
=20
-=09if (!bt_asha_set_connection_interval(asha_dev->asha, interval))
+=09if (!bt_asha_set_connection_interval(asha_dev->asha, interval)) {
 =09=09DBG("Could not send ASHA connection interval notification");
+=09=09return false;
+=09}
+
+=09return true;
 }
=20
-static void asha_send_interval(struct bt_asha_device *asha_dev)
+static bool asha_send_interval(struct bt_asha_device *asha_dev,
+=09=09=09=09=09=09uint16_t *interval)
 {
 =09struct asha_adapter *data;
 =09uint16_t handle;
@@ -134,39 +160,234 @@ static void asha_send_interval(struct bt_asha_device=
 *asha_dev)
 =09data =3D queue_find(asha_adapters, match_adapter,
 =09=09=09=09=09device_get_adapter(asha_dev->device));
 =09if (!data || !asha_get_handle(asha_dev, &handle))
+=09=09return false;
+
+=09if (interval)
+=09=09*interval =3D data->intervals[handle];
+
+=09return asha_notify_interval(asha_dev, handle, data->intervals[handle]);
+}
+
+static void asha_start_wait_cancel(struct bt_asha_device *asha_dev)
+{
+=09struct asha_start_wait *wait =3D asha_dev->start_wait;
+
+=09if (!wait)
+=09=09return;
+
+=09asha_dev->start_wait =3D NULL;
+
+=09if (wait->source_id)
+=09=09g_source_remove(wait->source_id);
+
+=09g_free(wait);
+}
+
+static void asha_cancel_connect(struct bt_asha_device *asha_dev)
+{
+=09if (!asha_dev->connect_data)
+=09=09return;
+
+=09asha_dev->connect_data->asha_dev =3D NULL;
+=09asha_dev->connect_data =3D NULL;
+}
+
+static gboolean asha_start_wait_error(gpointer user_data)
+{
+=09struct bt_asha_device *asha_dev =3D user_data;
+=09struct asha_start_wait *wait =3D asha_dev->start_wait;
+=09bt_asha_cb_t callback =3D wait->callback;
+=09void *data =3D wait->user_data;
+=09int err =3D wait->error;
+
+=09wait->source_id =3D 0;
+=09bt_asha_device_stop(asha_dev);
+
+=09/* The owner callback may remove the device. */
+=09if (callback)
+=09=09callback(err, data);
+
+=09return G_SOURCE_REMOVE;
+}
+
+static gboolean asha_start_wait_timeout(gpointer user_data)
+{
+=09struct bt_asha_device *asha_dev =3D user_data;
+
+=09asha_dev->start_wait->error =3D -ETIMEDOUT;
+=09return asha_start_wait_error(asha_dev);
+}
+
+static void asha_start_wait_fail(struct bt_asha_device *asha_dev, int err)
+{
+=09struct asha_start_wait *wait =3D asha_dev->start_wait;
+
+=09if (!wait || wait->error)
+=09=09return;
+
+=09if (wait->source_id)
+=09=09g_source_remove(wait->source_id);
+
+=09wait->error =3D err;
+=09/* Do not call the owner from inside the HCI stream iteration. */
+=09wait->source_id =3D g_idle_add(asha_start_wait_error, asha_dev);
+}
+
+static void asha_start_complete(int status, void *user_data)
+{
+=09struct bt_asha_device *asha_dev =3D user_data;
+=09struct asha_start_wait *wait =3D asha_dev->start_wait;
+=09bt_asha_cb_t callback;
+=09void *data;
+
+=09if (!wait || wait->error)
 =09=09return;
=20
-=09asha_notify_interval(asha_dev, handle, data->intervals[handle]);
+=09if (status) {
+=09=09asha_start_wait_fail(asha_dev, -EIO);
+=09=09return;
+=09}
+
+=09callback =3D wait->callback;
+=09data =3D wait->user_data;
+=09asha_start_wait_cancel(asha_dev);
+
+=09if (callback)
+=09=09callback(0, data);
+}
+
+static void asha_start_wait_try(struct bt_asha_device *asha_dev)
+{
+=09struct asha_start_wait *wait =3D asha_dev->start_wait;
+=09uint16_t interval =3D 0;
+=09bool notified;
+
+=09if (!wait || wait->error || !wait->connected || wait->sent)
+=09=09return;
+
+=09notified =3D asha_send_interval(asha_dev, &interval);
+=09if (!interval)
+=09=09return;
+
+=09if (!notified) {
+=09=09asha_start_wait_fail(asha_dev, -EIO);
+=09=09return;
+=09}
+
+=09if (interval !=3D ASHA_STREAM_INTERVAL)
+=09=09return;
+
+=09wait->sent =3D true;
+
+=09if (bt_asha_start(asha_dev->asha, asha_start_complete, asha_dev))
+=09=09asha_start_wait_fail(asha_dev, -EIO);
+}
+
+static void asha_start_wait_begin(struct bt_asha_device *asha_dev,
+=09=09=09=09=09bt_asha_cb_t callback, void *user_data)
+{
+=09struct asha_start_wait *wait;
+
+=09wait =3D g_new0(struct asha_start_wait, 1);
+=09wait->callback =3D callback;
+=09wait->user_data =3D user_data;
+=09asha_dev->start_wait =3D wait;
+=09wait->source_id =3D g_timeout_add_seconds(ASHA_START_TIMEOUT,
+=09=09=09=09=09asha_start_wait_timeout, asha_dev);
+}
+
+static void asha_stream_close_cancel(struct bt_asha_device *asha_dev)
+{
+=09if (!asha_dev->close_id)
+=09=09return;
+
+=09g_source_remove(asha_dev->close_id);
+=09asha_dev->close_id =3D 0;
+}
+
+static gboolean asha_stream_closed(gpointer user_data)
+{
+=09struct bt_asha_device *asha_dev =3D user_data;
+=09bt_asha_cb_t callback =3D asha_dev->closed_cb;
+=09void *data =3D asha_dev->closed_data;
+=09int err =3D asha_dev->close_error;
+
+=09asha_dev->close_id =3D 0;
+=09bt_asha_device_stop(asha_dev);
+
+=09if (callback)
+=09=09callback(err, data);
+
+=09return G_SOURCE_REMOVE;
+}
+
+static void asha_stream_fail(struct bt_asha_device *asha_dev, int err)
+{
+=09if (asha_dev->close_id || asha_dev->asha->state !=3D ASHA_STARTED)
+=09=09return;
+
+=09asha_dev->close_error =3D err;
+=09/* Transport teardown must not run inside the HCI stream iteration. */
+=09asha_dev->close_id =3D g_idle_add(asha_stream_closed, asha_dev);
 }
=20
 struct interval_update {
 =09struct asha_adapter *adapter;
 =09uint16_t handle;
+=09int error;
 };
=20
 static void asha_update_stream(void *data, void *user_data)
 {
 =09struct bt_asha_device *asha_dev =3D data;
 =09struct interval_update *update =3D user_data;
-=09uint16_t handle;
+=09uint16_t handle, interval;
+=09bool notified;
=20
 =09if (device_get_adapter(asha_dev->device) !=3D update->adapter->adapter =
||
 =09=09=09!asha_get_handle(asha_dev, &handle) ||
 =09=09=09handle !=3D update->handle)
 =09=09return;
=20
-=09asha_notify_interval(asha_dev, handle,
-=09=09=09=09=09update->adapter->intervals[handle]);
+=09if (update->error) {
+=09=09asha_start_wait_fail(asha_dev, update->error);
+
+=09=09if (update->error =3D=3D -ENOTCONN)
+=09=09=09asha_stream_fail(asha_dev, update->error);
+
+=09=09return;
+=09}
+
+=09interval =3D update->adapter->intervals[handle];
+
+=09/* An update can race the START response or AudioStatus notification. *=
/
+=09if (asha_dev->start_wait && asha_dev->start_wait->sent &&
+=09=09=09=09=09interval !=3D ASHA_STREAM_INTERVAL) {
+=09=09asha_start_wait_fail(asha_dev, -ERANGE);
+=09=09return;
+=09}
+
+=09if (asha_dev->start_wait) {
+=09=09asha_start_wait_try(asha_dev);
+=09=09return;
+=09}
+
+=09notified =3D asha_notify_interval(asha_dev, handle, interval);
+
+=09if (interval !=3D ASHA_STREAM_INTERVAL)
+=09=09asha_stream_fail(asha_dev, -ERANGE);
+=09else if (!notified)
+=09=09asha_stream_fail(asha_dev, -EIO);
 }
=20
 static void asha_conn_update(const void *param, uint8_t size, void *user_d=
ata)
 {
 =09const struct bt_hci_evt_le_conn_update_complete *ev =3D param;
 =09struct asha_adapter *data =3D user_data;
-=09struct interval_update update;
+=09struct interval_update update =3D { 0 };
 =09uint16_t handle;
=20
-=09if (size !=3D sizeof(*ev) || ev->status)
+=09if (size !=3D sizeof(*ev))
 =09=09return;
=20
 =09handle =3D get_le16(&ev->handle);
@@ -174,7 +395,10 @@ static void asha_conn_update(const void *param, uint8_=
t size, void *user_data)
 =09if (handle >=3D ASHA_NUM_HANDLES)
 =09=09return;
=20
-=09data->intervals[handle] =3D get_le16(&ev->interval);
+=09if (!ev->status)
+=09=09data->intervals[handle] =3D get_le16(&ev->interval);
+=09else
+=09=09update.error =3D -EIO;
 =09update.adapter =3D data;
 =09update.handle =3D handle;
 =09queue_foreach(asha_streams, asha_update_stream, &update);
@@ -216,6 +440,7 @@ static void asha_disconn_complete(const void *param, ui=
nt8_t size,
 {
 =09const struct bt_hci_evt_disconnect_complete *ev =3D param;
 =09struct asha_adapter *data =3D user_data;
+=09struct interval_update update =3D { .adapter =3D data, .error =3D -ENOT=
CONN };
 =09uint16_t handle;
=20
 =09if (size !=3D sizeof(*ev) || ev->status)
@@ -223,8 +448,12 @@ static void asha_disconn_complete(const void *param, u=
int8_t size,
=20
 =09handle =3D get_le16(&ev->handle);
=20
-=09if (handle < ASHA_NUM_HANDLES)
-=09=09data->intervals[handle] =3D 0;
+=09if (handle >=3D ASHA_NUM_HANDLES)
+=09=09return;
+
+=09data->intervals[handle] =3D 0;
+=09update.handle =3D handle;
+=09queue_foreach(asha_streams, asha_update_stream, &update);
 }
=20
 static int asha_adapter_probe(struct btd_profile *profile,
@@ -263,6 +492,17 @@ fail:
 =09return -EIO;
 }
=20
+static void asha_adapter_cancel_stream(void *data, void *user_data)
+{
+=09struct bt_asha_device *asha_dev =3D data;
+
+=09if (device_get_adapter(asha_dev->device) !=3D user_data)
+=09=09return;
+
+=09asha_start_wait_fail(asha_dev, -ENODEV);
+=09asha_stream_fail(asha_dev, -ENODEV);
+}
+
 static void asha_adapter_remove(struct btd_profile *profile,
 =09=09=09=09=09=09struct btd_adapter *adapter)
 {
@@ -273,6 +513,7 @@ static void asha_adapter_remove(struct btd_profile *pro=
file,
 =09if (!data)
 =09=09return;
=20
+=09queue_foreach(asha_streams, asha_adapter_cancel_stream, adapter);
 =09bt_hci_unref(data->hci);
 =09free(data);
=20
@@ -297,20 +538,20 @@ static char *make_endpoint_path(struct bt_asha_device=
 *asha_dev)
 =09return path;
 }
=20
-struct connect_data {
-=09struct bt_asha_device *asha_dev;
-=09bt_asha_cb_t cb;
-=09void *cb_user_data;
-};
-
 static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 {
 =09struct connect_data *conn_data =3D user_data;
 =09struct bt_asha_device *asha_dev =3D conn_data->asha_dev;
 =09GError *gerr =3D NULL;
=20
+=09if (!asha_dev)
+=09=09return;
+
+=09asha_dev->connect_data =3D NULL;
+
 =09if (err) {
 =09=09error("%s", err->message);
+=09=09asha_start_wait_fail(asha_dev, -EIO);
 =09=09return;
 =09}
=20
@@ -325,12 +566,8 @@ static void connect_cb(GIOChannel *io, GError *err, gp=
ointer user_data)
 =09=09g_error_free(gerr);
 =09}
=20
-=09asha_dev->io =3D io;
-
-=09asha_send_interval(asha_dev);
-
-=09bt_asha_start(asha_dev->asha, conn_data->cb,
-=09=09=09=09=09conn_data->cb_user_data);
+=09asha_dev->start_wait->connected =3D true;
+=09asha_start_wait_try(asha_dev);
 }
=20
 static int asha_connect_socket(struct bt_asha_device *asha_dev,
@@ -340,21 +577,22 @@ static int asha_connect_socket(struct bt_asha_device =
*asha_dev,
 =09const bdaddr_t *src_addr;
 =09struct connect_data *conn_data;
=20
-=09if (asha_dev->asha->state !=3D ASHA_STOPPED) {
+=09if (asha_dev->io || asha_dev->start_wait ||
+=09=09=09=09=09asha_dev->asha->state !=3D ASHA_STOPPED) {
 =09=09error("ASHA device connect failed. Bad state %d",
 =09=09=09=09=09=09=09asha_dev->asha->state);
-=09=09return 0;
+=09=09return -EBUSY;
 =09}
=20
 =09conn_data =3D g_new0(struct connect_data, 1);
 =09conn_data->asha_dev =3D asha_dev;
-=09conn_data->cb =3D cb;
-=09conn_data->cb_user_data =3D user_data;
+=09asha_dev->connect_data =3D conn_data;
+=09asha_start_wait_begin(asha_dev, cb, user_data);
=20
 =09src_addr =3D btd_adapter_get_address(
 =09=09=09device_get_adapter(asha_dev->device));
=20
-=09if (!bt_io_connect(connect_cb, conn_data,
+=09asha_dev->io =3D bt_io_connect(connect_cb, conn_data,
 =09=09=09=09g_free, &gerr,
 =09=09=09=09BT_IO_OPT_MODE, BT_IO_MODE_LE_FLOWCTL,
 =09=09=09=09BT_IO_OPT_SOURCE_TYPE, BDADDR_LE_PUBLIC,
@@ -365,9 +603,13 @@ static int asha_connect_socket(struct bt_asha_device *=
asha_dev,
 =09=09=09=09BT_IO_OPT_PSM, asha_dev->asha->psm,
 =09=09=09=09BT_IO_OPT_OMTU, ASHA_MIN_MTU,
 =09=09=09=09BT_IO_OPT_IMTU, ASHA_CONNECTION_MTU,
-=09=09=09=09BT_IO_OPT_INVALID)) {
+=09=09=09=09BT_IO_OPT_INVALID);
+=09if (!asha_dev->io) {
 =09=09error("Could not open L2CAP CoC socket: %s", gerr->message);
 =09=09g_error_free(gerr);
+=09=09asha_dev->connect_data =3D NULL;
+=09=09g_free(conn_data);
+=09=09asha_start_wait_cancel(asha_dev);
 =09=09goto error;
 =09}
=20
@@ -393,13 +635,20 @@ unsigned int bt_asha_device_start(struct bt_asha_devi=
ce *asha_dev,
=20
 =09if (ret < 0)
 =09=09return 0;
-=09else
-=09=09return (++asha_dev->resume_id);
+
+=09if (!++asha_dev->resume_id)
+=09=09++asha_dev->resume_id;
+
+=09return asha_dev->resume_id;
 }
=20
 unsigned int bt_asha_device_stop(struct bt_asha_device *asha_dev)
 {
+=09asha_stream_close_cancel(asha_dev);
+=09asha_start_wait_cancel(asha_dev);
+=09asha_cancel_connect(asha_dev);
 =09bt_asha_stop(asha_dev->asha);
+=09bt_asha_state_reset(asha_dev->asha);
=20
 =09if (asha_dev->io) {
 =09=09g_io_channel_shutdown(asha_dev->io, TRUE, NULL);
@@ -412,6 +661,10 @@ unsigned int bt_asha_device_stop(struct bt_asha_device=
 *asha_dev)
=20
 void bt_asha_device_state_reset(struct bt_asha_device *asha_dev)
 {
+=09asha_stream_close_cancel(asha_dev);
+=09asha_start_wait_cancel(asha_dev);
+=09asha_cancel_connect(asha_dev);
+
 =09if (asha_dev->io) {
 =09=09g_io_channel_shutdown(asha_dev->io, TRUE, NULL);
 =09=09g_io_channel_unref(asha_dev->io);
@@ -419,8 +672,6 @@ void bt_asha_device_state_reset(struct bt_asha_device *=
asha_dev)
 =09};
=20
 =09bt_asha_state_reset(asha_dev->asha);
-
-=09asha_dev->resume_id =3D 0;
 }
=20
 unsigned int bt_asha_device_device_get_resume_id(
@@ -432,9 +683,19 @@ unsigned int bt_asha_device_device_get_resume_id(
 enum bt_asha_state_t bt_asha_device_get_state(
 =09=09=09=09=09struct bt_asha_device *asha_dev)
 {
+=09if (asha_dev->start_wait)
+=09=09return ASHA_STARTING;
+
 =09return asha_dev->asha->state;
 }
=20
+void bt_asha_device_set_stream_closed_cb(struct bt_asha_device *asha_dev,
+=09=09=09=09=09bt_asha_cb_t callback, void *user_data)
+{
+=09asha_dev->closed_cb =3D callback;
+=09asha_dev->closed_data =3D user_data;
+}
+
 uint16_t bt_asha_device_get_render_delay(struct bt_asha_device *asha_dev)
 {
 =09return asha_dev->asha->render_delay;
@@ -598,6 +859,7 @@ static void asha_source_device_remove(struct btd_servic=
e *service)
 =09=09return;
 =09}
=20
+=09bt_asha_device_state_reset(asha_dev);
 =09queue_remove(asha_streams, asha_dev);
=20
 =09if (queue_isempty(asha_streams)) {
@@ -723,6 +985,7 @@ static int asha_source_disconnect(struct btd_service *s=
ervice)
 =09}
=20
 =09asha_source_endpoint_unregister(asha_dev);
+=09bt_asha_device_state_reset(asha_dev);
 =09bt_asha_reset(asha_dev->asha);
=20
 =09btd_service_disconnecting_complete(service, 0);
diff --git a/profiles/audio/asha.h b/profiles/audio/asha.h
index 9ffd9d307d..6c3550dc81 100644
--- a/profiles/audio/asha.h
+++ b/profiles/audio/asha.h
@@ -20,6 +20,8 @@ struct bt_asha_device;
 unsigned int bt_asha_device_start(struct bt_asha_device *asha_dev,
 =09=09=09=09=09bt_asha_cb_t cb, void *user_data);
 unsigned int bt_asha_device_stop(struct bt_asha_device *asha_dev);
+void bt_asha_device_set_stream_closed_cb(struct bt_asha_device *asha_dev,
+=09=09=09=09=09bt_asha_cb_t callback, void *user_data);
=20
 void bt_asha_device_state_reset(struct bt_asha_device *asha_dev);
 unsigned int bt_asha_device_device_get_resume_id(
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index e001f73151..794303464a 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -2658,11 +2658,29 @@ static int transport_asha_set_volume(struct media_t=
ransport *transport,
 =09return bt_asha_device_set_volume(asha_dev, scaled_volume) ? 0 : -EIO;
 }
=20
+static void asha_transport_closed(int status, void *user_data)
+{
+=09struct media_transport *transport =3D user_data;
+
+=09if (transport->owner)
+=09=09media_transport_remove_owner(transport);
+=09else
+=09=09transport_set_state(transport, TRANSPORT_STATE_IDLE);
+}
+
 static void *transport_asha_init(struct media_transport *transport, void *=
data)
 {
+=09bt_asha_device_set_stream_closed_cb(data, asha_transport_closed,
+=09=09=09=09=09=09=09=09transport);
+
 =09/* We just store the struct asha_device on the transport */
 =09return data;
 }
+
+static void transport_asha_destroy(void *data)
+{
+=09bt_asha_device_set_stream_closed_cb(data, NULL, NULL);
+}
 #endif /* HAVE_ASHA */
=20
 #ifdef HAVE_HFP
@@ -2857,7 +2875,7 @@ static void transport_hfp_cancel(struct media_transpo=
rt *transport, guint id)
 =09=09=09transport_asha_resume, transport_asha_suspend, \
 =09=09=09transport_asha_cancel, NULL, NULL, \
 =09=09=09transport_asha_get_volume, transport_asha_set_volume, \
-=09=09=09NULL, NULL, NULL, NULL)
+=09=09=09NULL, NULL, transport_asha_destroy, NULL)
=20
 #define HFP_OPS(_uuid) \
 =09TRANSPORT_OPS(_uuid, transport_hfp_properties, NULL, NULL, \
diff --git a/unit/test-asha-conn.c b/unit/test-asha-conn.c
index 4b0354c67e..e7e669867d 100644
--- a/unit/test-asha-conn.c
+++ b/unit/test-asha-conn.c
@@ -9,12 +9,14 @@
 #define bt_att_get_fd test_att_fd
 #define bt_asha_set_connection_interval test_set_interval
 #define bt_asha_start test_start
+#define bt_asha_stop test_stop
 #define bt_io_get test_io_get
 #include "profiles/audio/asha.c"
 #undef bt_gatt_client_get_att
 #undef bt_att_get_fd
 #undef bt_asha_set_connection_interval
 #undef bt_asha_start
+#undef bt_asha_stop
 #undef bt_io_get
 #include "bluetooth/hci.h"
 #include "src/shared/tester.h"
@@ -37,19 +39,23 @@ const char *device_get_path(const struct btd_device *de=
vice)
=20
 const bdaddr_t *device_get_address(struct btd_device *device)
 {
-=09assert(false);
+=09static const bdaddr_t address;
+
+=09return &address;
 }
=20
 const bdaddr_t *btd_adapter_get_address(struct btd_adapter *adapter)
 {
-=09assert(false);
+=09static const bdaddr_t address;
+
+=09return &address;
 }
=20
 void btd_device_set_conn_param(struct btd_device *device,
 =09=09=09=09uint16_t min_interval, uint16_t max_interval,
 =09=09=09=09=09uint16_t latency, uint16_t timeout)
 {
-=09assert(false);
+=09assert(min_interval =3D=3D 16 && max_interval =3D=3D 16);
 }
=20
 struct gatt_db *btd_device_get_gatt_db(struct btd_device *device)
@@ -131,17 +137,45 @@ const char *media_transport_get_path(struct media_tra=
nsport *transport)
 =09assert(false);
 }
=20
+static BtIOConnect pending_connect;
+static GDestroyNotify pending_destroy;
+static void *pending_data;
+static GIOChannel *pending_io;
+static int connect_peer;
+static bool connect_error;
+
 GIOChannel *bt_io_connect(BtIOConnect connect, gpointer user_data,
 =09=09=09=09GDestroyNotify destroy, GError **gerr,
 =09=09=09=09=09=09=09BtIOOption opt1, ...)
 {
-=09assert(false);
+=09int fds[2];
+
+=09if (connect_error) {
+=09=09g_set_error_literal(gerr, g_quark_from_static_string("test"),
+=09=09=09=09=09=09=09EIO, "connect failed");
+=09=09return NULL;
+=09}
+
+=09assert(!pending_io);
+=09assert(!socketpair(AF_UNIX, SOCK_STREAM, 0, fds));
+=09pending_io =3D g_io_channel_unix_new(fds[0]);
+=09g_io_channel_set_close_on_unref(pending_io, TRUE);
+=09pending_connect =3D connect;
+=09pending_data =3D user_data;
+=09pending_destroy =3D destroy;
+=09connect_peer =3D fds[1];
+=09return g_io_channel_ref(pending_io);
 }
=20
 static int peer_fd[2];
 static int observer_fd[2];
 static int pending_peer;
 static unsigned int writes;
+static unsigned int starts;
+static bool start_error;
+static bool interval_error;
+static bt_asha_cb_t start_callback;
+static void *start_data;
 static uint16_t last_interval;
 static struct bt_asha *last_asha;
 static bool socket_ready =3D true;
@@ -241,14 +275,27 @@ bool test_set_interval(struct bt_asha *asha,
 =09writes++;
 =09last_asha =3D asha;
 =09last_interval =3D interval;
-=09return true;
+=09return !interval_error;
 }
=20
 unsigned int test_start(struct bt_asha *asha, bt_asha_cb_t cb,
 =09=09=09=09=09=09=09void *user_data)
 {
-=09assert(writes =3D=3D 1 && last_asha =3D=3D asha && last_interval =3D=3D=
 24);
+=09assert(writes && last_asha =3D=3D asha && last_interval =3D=3D 16);
+=09starts++;
+
+=09if (start_error)
+=09=09return -1;
+
 =09asha->state =3D ASHA_STARTING;
+=09start_callback =3D cb;
+=09start_data =3D user_data;
+=09return 0;
+}
+
+unsigned int test_stop(struct bt_asha *asha)
+{
+=09bt_asha_state_reset(asha);
 =09return 0;
 }
=20
@@ -304,14 +351,18 @@ static void test_connection(const void *user_data)
 =09queue_push_tail(asha_streams, &dev);
 =09queue_push_tail(asha_streams, &dev2);
 =09writes =3D 0;
-=09asha_send_interval(&dev);
+=09asha_send_interval(&dev, NULL);
 =09assert(writes =3D=3D 0);
=20
 =09/* Cache the initial event before GATT discovery/CoC. */
 =09event(0, BT_HCI_EVT_LE_CONN_COMPLETE, &complete, sizeof(complete));
 =09assert(writes =3D=3D 0);
+=09asha_start_wait_begin(&dev, NULL, NULL);
+=09dev.io =3D io;
 =09connect_cb(io, NULL, &conn);
 =09assert(writes =3D=3D 1 && last_interval =3D=3D 24);
+=09assert(dev.start_wait && starts =3D=3D 0);
+=09asha_start_wait_cancel(&dev);
=20
 =09/* Identical handles on different controllers are separate links. */
 =09event(1, BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE, &enhanced,
@@ -333,12 +384,12 @@ static void test_connection(const void *user_data)
 =09update.handle =3D cpu_to_le16(ASHA_NUM_HANDLES);
 =09event(0, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &update, sizeof(update));
 =09assert(writes =3D=3D 3);
-=09asha_send_interval(&dev);
+=09asha_send_interval(&dev, NULL);
 =09assert(writes =3D=3D 4 && last_interval =3D=3D 40);
=20
 =09/* Closed ATT sockets cannot be associated with a cached handle. */
 =09socket_ready =3D false;
-=09asha_send_interval(&dev);
+=09asha_send_interval(&dev, NULL);
 =09assert(writes =3D=3D 4);
 =09socket_ready =3D true;
=20
@@ -348,15 +399,15 @@ static void test_connection(const void *user_data)
 =09while (g_main_context_iteration(NULL, FALSE))
 =09=09;
=20
-=09asha_send_interval(&dev);
+=09asha_send_interval(&dev, NULL);
 =09assert(writes =3D=3D 4);
-=09asha_send_interval(&dev2);
+=09asha_send_interval(&dev2, NULL);
 =09assert(writes =3D=3D 5 && last_interval =3D=3D 40);
=20
 =09/* Reused handle gets the new connection's value, never the old one. */
 =09complete.interval =3D cpu_to_le16(16);
 =09event(0, BT_HCI_EVT_LE_CONN_COMPLETE, &complete, sizeof(complete));
-=09asha_send_interval(&dev);
+=09asha_send_interval(&dev, NULL);
 =09assert(writes =3D=3D 6 && last_interval =3D=3D 16);
=20
 =09adapter =3D queue_find(asha_adapters, match_adapter, (void *) 1);
@@ -405,7 +456,7 @@ static void test_observer_lifecycle(const void *user_da=
ta)
 =09asha_streams =3D queue_new();
 =09queue_push_tail(asha_streams, &dev);
 =09event(0, BT_HCI_EVT_LE_CONN_COMPLETE, &complete, sizeof(complete));
-=09asha_send_interval(&dev);
+=09asha_send_interval(&dev, NULL);
 =09assert(writes =3D=3D 1 && last_interval =3D=3D 24);
=20
 =09/* Failed/truncated events cannot replace a successful interval. */
@@ -414,16 +465,16 @@ static void test_observer_lifecycle(const void *user_=
data)
 =09event(0, BT_HCI_EVT_LE_CONN_COMPLETE, &complete, sizeof(complete));
 =09complete.status =3D 0;
 =09event(0, BT_HCI_EVT_LE_CONN_COMPLETE, &complete, sizeof(complete) - 1);
-=09asha_send_interval(&dev);
+=09asha_send_interval(&dev, NULL);
 =09assert(writes =3D=3D 2 && last_interval =3D=3D 24);
=20
 =09conninfo_length--;
-=09asha_send_interval(&dev);
+=09asha_send_interval(&dev, NULL);
 =09conninfo_length +=3D 2;
-=09asha_send_interval(&dev);
+=09asha_send_interval(&dev, NULL);
 =09conninfo_length--;
 =09att_fd =3D -1;
-=09asha_send_interval(&dev);
+=09asha_send_interval(&dev, NULL);
 =09att_fd =3D 100;
 =09assert(writes =3D=3D 2);
=20
@@ -436,7 +487,7 @@ static void test_observer_lifecycle(const void *user_da=
ta)
 =09assert(!asha_adapter_probe(NULL, (void *) 1));
=20
 =09/* After restart, existing links stay unknown until a new update. */
-=09asha_send_interval(&dev);
+=09asha_send_interval(&dev, NULL);
 =09assert(writes =3D=3D 2);
 =09event(0, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &update, sizeof(update));
 =09assert(writes =3D=3D 3 && last_interval =3D=3D 32);
@@ -459,11 +510,527 @@ static void test_observer_lifecycle(const void *user=
_data)
 =09tester_test_passed();
 }
=20
+struct gate_result {
+=09struct bt_asha_device *device;
+=09unsigned int calls;
+=09int error;
+=09bool remove;
+};
+
+static void gate_callback(int status, void *user_data)
+{
+=09struct gate_result *result =3D user_data;
+
+=09assert(!result->device->start_wait);
+
+=09if (status) {
+=09=09assert(!result->device->io);
+=09=09assert(bt_asha_device_get_state(result->device) =3D=3D
+=09=09=09=09=09=09=09ASHA_STOPPED);
+=09} else {
+=09=09assert(result->device->io);
+=09=09assert(bt_asha_device_get_state(result->device) =3D=3D
+=09=09=09=09=09=09=09ASHA_STARTED);
+=09}
+=09result->calls++;
+=09result->error =3D status;
+
+=09if (result->remove) {
+=09=09queue_remove(asha_streams, result->device);
+=09=09bt_asha_device_state_reset(result->device);
+=09=09g_free(result->device);
+=09=09result->device =3D NULL;
+=09}
+}
+
+static void finish_connect(bool failed)
+{
+=09GError *err =3D NULL;
+
+=09if (failed)
+=09=09g_set_error_literal(&err, g_quark_from_static_string("test"),
+=09=09=09=09=09=09=09EIO, "connect failed");
+
+=09pending_connect(pending_io, err, pending_data);
+=09pending_destroy(pending_data);
+=09g_io_channel_unref(pending_io);
+=09pending_io =3D NULL;
+=09g_clear_error(&err);
+=09close(connect_peer);
+}
+
+static void test_pending_connect(const void *user_data)
+{
+=09unsigned int scenario;
+
+=09for (scenario =3D 0; scenario < 7; scenario++) {
+=09=09struct bt_asha asha =3D { .client =3D (void *) 1 };
+=09=09struct bt_asha_device *dev =3D g_new0(struct bt_asha_device, 1);
+=09=09struct gate_result result =3D { .device =3D dev };
+=09=09GSource *timer;
+=09=09unsigned int id;
+=09=09int fds[2];
+
+=09=09dev->asha =3D &asha;
+=09=09dev->device =3D (void *) 1;
+=09=09starts =3D writes =3D 0;
+=09=09connect_error =3D scenario =3D=3D 2;
+=09=09id =3D bt_asha_device_start(dev, gate_callback, &result);
+
+=09=09if (connect_error) {
+=09=09=09assert(!id && !dev->io && !dev->start_wait);
+=09=09=09connect_error =3D false;
+=09=09=09g_free(dev);
+=09=09=09continue;
+=09=09}
+
+=09=09assert(id && bt_asha_device_get_state(dev) =3D=3D ASHA_STARTING);
+=09=09assert(!bt_asha_device_start(dev, gate_callback, &result));
+
+=09=09switch (scenario) {
+=09=09case 0:
+=09=09=09bt_asha_device_stop(dev);
+=09=09=09assert(bt_asha_device_get_state(dev) =3D=3D ASHA_STOPPED);
+=09=09=09g_free(dev);
+=09=09=09result.device =3D NULL;
+=09=09=09/* Dispatch the old watch after fd reuse. */
+=09=09=09assert(!socketpair(AF_UNIX, SOCK_STREAM, 0, fds));
+=09=09=09finish_connect(false);
+=09=09=09close(fds[0]);
+=09=09=09close(fds[1]);
+=09=09=09break;
+=09=09case 1:
+=09=09=09finish_connect(true);
+=09=09=09while (g_main_context_iteration(NULL, FALSE))
+=09=09=09=09;
+=09=09=09assert(result.calls =3D=3D 1 && result.error =3D=3D -EIO);
+=09=09=09break;
+=09=09case 2:
+=09=09=09assert(false);
+=09=09=09break;
+=09=09case 3:
+=09=09=09timer =3D g_main_context_find_source_by_id(NULL,
+=09=09=09=09=09=09dev->start_wait->source_id);
+=09=09=09g_source_set_ready_time(timer, 0);
+=09=09=09while (g_main_context_iteration(NULL, FALSE))
+=09=09=09=09;
+=09=09=09finish_connect(false);
+=09=09=09assert(result.calls =3D=3D 1 && result.error =3D=3D -ETIMEDOUT);
+=09=09=09break;
+=09=09case 4:
+=09=09=09bt_asha_device_state_reset(dev);
+=09=09=09finish_connect(false);
+=09=09=09assert(bt_asha_device_start(dev, gate_callback, &result)
+=09=09=09=09=09=09=09=09=09!=3D id);
+=09=09=09bt_asha_device_stop(dev);
+=09=09=09finish_connect(false);
+=09=09=09break;
+=09=09case 5:
+=09=09=09assert(!asha_adapter_probe(NULL, (void *) 1));
+=09=09=09asha_streams =3D queue_new();
+=09=09=09queue_push_tail(asha_streams, dev);
+=09=09=09asha_adapter_remove(NULL, (void *) 1);
+=09=09=09while (g_main_context_iteration(NULL, FALSE))
+=09=09=09=09;
+=09=09=09finish_connect(false);
+=09=09=09assert(result.calls =3D=3D 1 && result.error =3D=3D -ENODEV);
+=09=09=09queue_destroy(asha_streams, NULL);
+=09=09=09asha_streams =3D NULL;
+=09=09=09close(peer_fd[0]);
+=09=09=09break;
+=09=09case 6:
+=09=09=09bt_asha_device_state_reset(dev);
+=09=09=09finish_connect(false);
+=09=09=09break;
+=09=09}
+
+=09=09assert(!starts);
+
+=09=09if (result.device) {
+=09=09=09bt_asha_device_state_reset(dev);
+=09=09=09g_free(dev);
+=09=09}
+=09}
+
+=09tester_test_passed();
+}
+
+static void test_start_gate(const void *user_data)
+{
+=09unsigned int scenario;
+
+=09for (scenario =3D 0; scenario < 21; scenario++) {
+=09=09struct bt_asha asha =3D { .client =3D (void *) 1 };
+=09=09struct bt_asha_device *dev =3D g_new0(struct bt_asha_device, 1);
+=09=09struct gate_result result =3D { .device =3D dev };
+=09=09struct connect_data conn =3D { .asha_dev =3D dev };
+=09=09struct bt_hci_evt_le_conn_complete complete =3D {
+=09=09=09.handle =3D cpu_to_le16(16),
+=09=09=09.interval =3D cpu_to_le16(24),
+=09=09};
+=09=09struct bt_hci_evt_le_conn_update_complete update =3D {
+=09=09=09.handle =3D cpu_to_le16(16), .interval =3D cpu_to_le16(16),
+=09=09};
+=09=09struct bt_hci_evt_disconnect_complete disconnect =3D {
+=09=09=09.handle =3D cpu_to_le16(16),
+=09=09};
+=09=09struct asha_adapter *adapter;
+=09=09int fds[2];
+=09=09unsigned int source;
+=09=09GSource *timer;
+
+=09=09dev->asha =3D &asha;
+=09=09dev->device =3D (void *) 1;
+=09=09starts =3D writes =3D 0;
+=09=09start_error =3D false;
+=09=09interval_error =3D scenario =3D=3D 14;
+=09=09assert(!pipe(fds));
+=09=09assert(!asha_adapter_probe(NULL, (void *) 1));
+=09=09adapter =3D queue_find(asha_adapters, match_adapter, (void *) 1);
+=09=09asha_streams =3D queue_new();
+=09=09queue_push_tail(asha_streams, dev);
+
+=09=09if (scenario =3D=3D 0 || scenario =3D=3D 14 || scenario >=3D 15)
+=09=09=09complete.interval =3D cpu_to_le16(16);
+
+=09=09/* Scenario 2 starts with no observed connection interval. */
+=09=09if (scenario !=3D 2)
+=09=09=09event(0, BT_HCI_EVT_LE_CONN_COMPLETE, &complete,
+=09=09=09=09=09=09=09sizeof(complete));
+
+=09=09asha_start_wait_begin(dev, gate_callback, &result);
+=09=09dev->io =3D g_io_channel_unix_new(fds[0]);
+=09=09g_io_channel_set_close_on_unref(dev->io, TRUE);
+=09=09connect_cb(dev->io, NULL, &conn);
+
+=09=09if (scenario =3D=3D 0 || scenario >=3D 15) {
+=09=09=09assert(starts =3D=3D 1 && dev->start_wait->sent);
+=09=09} else {
+=09=09=09assert(starts =3D=3D 0 && dev->start_wait);
+=09=09=09assert(bt_asha_device_get_state(dev) =3D=3D ASHA_STARTING);
+=09=09}
+
+=09=09switch (scenario) {
+=09=09case 0:
+=09=09=09asha.state =3D ASHA_STARTED;
+=09=09=09start_callback(0, start_data);
+=09=09=09assert(!dev->start_wait && result.calls =3D=3D 1);
+=09=09=09break;
+=09=09case 1:
+=09=09case 2:
+=09=09=09event(0, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &update,
+=09=09=09=09=09=09=09=09sizeof(update));
+=09=09=09assert(starts =3D=3D 1 && dev->start_wait->sent);
+=09=09=09break;
+=09=09case 3:
+=09=09=09update.status =3D 1;
+=09=09=09event(0, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &update,
+=09=09=09=09=09=09=09=09sizeof(update));
+=09=09=09assert(result.calls =3D=3D 1 && result.error =3D=3D -EIO);
+=09=09=09break;
+=09=09case 4:
+=09=09=09source =3D dev->start_wait->source_id;
+=09=09=09timer =3D g_main_context_find_source_by_id(NULL, source);
+=09=09=09assert(timer);
+=09=09=09g_source_set_ready_time(timer, 0);
+=09=09=09while (g_main_context_iteration(NULL, FALSE))
+=09=09=09=09;
+=09=09=09assert(!g_main_context_find_source_by_id(NULL, source));
+=09=09=09assert(result.calls =3D=3D 1 && result.error =3D=3D -ETIMEDOUT);
+=09=09=09break;
+=09=09case 5:
+=09=09=09source =3D dev->start_wait->source_id;
+=09=09=09bt_asha_device_stop(dev);
+=09=09=09assert(!g_main_context_find_source_by_id(NULL, source));
+=09=09=09event(0, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &update,
+=09=09=09=09=09=09=09=09sizeof(update));
+=09=09=09assert(starts =3D=3D 0 && result.calls =3D=3D 0);
+=09=09=09break;
+=09=09case 6:
+=09=09=09bt_asha_device_state_reset(dev);
+=09=09=09break;
+=09=09case 7:
+=09=09=09asha_adapter_remove(NULL, (void *) 1);
+=09=09=09while (g_main_context_iteration(NULL, FALSE))
+=09=09=09=09;
+=09=09=09assert(result.calls =3D=3D 1 && result.error =3D=3D -ENODEV);
+=09=09=09break;
+=09=09case 8:
+=09=09=09asha_disconn_complete(&disconnect, sizeof(disconnect),
+=09=09=09=09=09=09=09=09adapter);
+=09=09=09while (g_main_context_iteration(NULL, FALSE))
+=09=09=09=09;
+=09=09=09assert(result.calls =3D=3D 1 && result.error =3D=3D -ENOTCONN);
+=09=09=09break;
+=09=09case 9:
+=09=09=09start_error =3D true;
+=09=09=09event(0, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &update,
+=09=09=09=09=09=09=09=09sizeof(update));
+=09=09=09assert(starts =3D=3D 1 && result.calls =3D=3D 1);
+=09=09=09assert(result.error =3D=3D -EIO);
+=09=09=09break;
+=09=09case 10:
+=09=09=09result.remove =3D true;
+=09=09=09update.status =3D 1;
+=09=09=09event(0, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &update,
+=09=09=09=09=09=09=09=09sizeof(update));
+=09=09=09assert(!result.device && result.calls =3D=3D 1);
+=09=09=09break;
+=09=09case 11:
+=09=09=09update.status =3D 1;
+=09=09=09asha_conn_update(&update, sizeof(update), adapter);
+=09=09=09assert(dev->start_wait->error =3D=3D -EIO);
+=09=09=09bt_asha_device_stop(dev);
+=09=09=09while (g_main_context_iteration(NULL, FALSE))
+=09=09=09=09;
+=09=09=09assert(!result.calls && !starts);
+=09=09=09break;
+=09=09case 12:
+=09=09=09update.handle =3D cpu_to_le16(17);
+=09=09=09event(0, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &update,
+=09=09=09=09=09=09=09=09sizeof(update));
+=09=09=09update.handle =3D cpu_to_le16(16);
+=09=09=09event(0, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &update,
+=09=09=09=09=09=09=09sizeof(update) - 1);
+=09=09=09assert(starts =3D=3D 0 && dev->start_wait);
+=09=09=09event(0, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &update,
+=09=09=09=09=09=09=09=09sizeof(update));
+=09=09=09assert(starts =3D=3D 1 && dev->start_wait->sent);
+=09=09=09break;
+=09=09case 13:
+=09=09=09interval_error =3D true;
+=09=09=09event(0, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &update,
+=09=09=09=09=09=09=09=09sizeof(update));
+=09=09=09assert(starts =3D=3D 0 && result.calls =3D=3D 1);
+=09=09=09assert(result.error =3D=3D -EIO && !dev->start_wait);
+=09=09=09interval_error =3D false;
+=09=09=09break;
+=09=09case 14:
+=09=09=09while (g_main_context_iteration(NULL, FALSE))
+=09=09=09=09;
+=09=09=09assert(!starts && result.calls =3D=3D 1);
+=09=09=09assert(result.error =3D=3D -EIO && !dev->start_wait);
+=09=09=09interval_error =3D false;
+=09=09=09break;
+=09=09case 15:
+=09=09=09/* AudioStatusPoint never arrives after START. */
+=09=09=09source =3D dev->start_wait->source_id;
+=09=09=09timer =3D g_main_context_find_source_by_id(NULL, source);
+=09=09=09g_source_set_ready_time(timer, 0);
+=09=09=09while (g_main_context_iteration(NULL, FALSE))
+=09=09=09=09;
+=09=09=09assert(result.calls =3D=3D 1 && result.error =3D=3D -ETIMEDOUT);
+=09=09=09break;
+=09=09case 16:
+=09=09=09/* An update races the START acknowledgment. */
+=09=09=09update.interval =3D cpu_to_le16(24);
+=09=09=09event(0, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &update,
+=09=09=09=09=09=09=09=09sizeof(update));
+=09=09=09assert(result.calls =3D=3D 1 && result.error =3D=3D -ERANGE);
+=09=09=09break;
+=09=09case 17:
+=09=09=09start_callback(-1, start_data);
+=09=09=09while (g_main_context_iteration(NULL, FALSE))
+=09=09=09=09;
+=09=09=09assert(result.calls =3D=3D 1 && result.error =3D=3D -EIO);
+=09=09=09break;
+=09=09case 18:
+=09=09=09bt_asha_device_stop(dev);
+=09=09=09assert(asha.state =3D=3D ASHA_STOPPED && !dev->start_wait);
+=09=09=09break;
+=09=09case 19:
+=09=09=09result.remove =3D true;
+=09=09=09asha.state =3D ASHA_STARTED;
+=09=09=09start_callback(0, start_data);
+=09=09=09assert(!result.device && result.calls =3D=3D 1);
+=09=09=09break;
+=09=09case 20:
+=09=09=09/* Duplicate completion must not issue another START. */
+=09=09=09event(0, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &update,
+=09=09=09=09=09=09=09=09sizeof(update));
+=09=09=09assert(starts =3D=3D 1 && !result.calls);
+=09=09=09break;
+=09=09}
+
+=09=09if (result.device) {
+=09=09=09bt_asha_device_state_reset(dev);
+=09=09=09queue_remove(asha_streams, dev);
+=09=09=09g_free(dev);
+=09=09}
+
+=09=09if (scenario !=3D 7)
+=09=09=09asha_adapter_remove(NULL, (void *) 1);
+
+=09=09queue_destroy(asha_streams, NULL);
+=09=09asha_streams =3D NULL;
+=09=09close(peer_fd[0]);
+=09=09close(fds[1]);
+=09}
+
+=09tester_test_passed();
+}
+
+static void test_acquired_interval(const void *user_data)
+{
+=09unsigned int scenario;
+
+=09for (scenario =3D 0; scenario < 12; scenario++) {
+=09=09struct bt_asha asha =3D {
+=09=09=09.client =3D (void *) 1, .state =3D ASHA_STARTED,
+=09=09};
+=09=09struct bt_asha_device *dev =3D g_new0(struct bt_asha_device, 1);
+=09=09struct gate_result result =3D { .device =3D dev };
+=09=09struct bt_hci_evt_le_conn_complete complete =3D {
+=09=09=09.handle =3D cpu_to_le16(16), .interval =3D cpu_to_le16(16),
+=09=09};
+=09=09struct bt_hci_evt_le_conn_update_complete update =3D {
+=09=09=09.handle =3D cpu_to_le16(16), .interval =3D cpu_to_le16(24),
+=09=09};
+=09=09struct bt_hci_evt_disconnect_complete disconnect =3D {
+=09=09=09.handle =3D cpu_to_le16(16),
+=09=09};
+=09=09struct asha_adapter *adapter;
+=09=09unsigned int source;
+=09=09int fds[2];
+
+=09=09dev->asha =3D &asha;
+=09=09dev->device =3D (void *) 1;
+=09=09assert(!pipe(fds));
+=09=09dev->io =3D g_io_channel_unix_new(fds[0]);
+=09=09g_io_channel_set_close_on_unref(dev->io, TRUE);
+=09=09bt_asha_device_set_stream_closed_cb(dev, gate_callback,
+=09=09=09=09=09=09=09=09&result);
+=09=09assert(!asha_adapter_probe(NULL, (void *) 1));
+=09=09adapter =3D queue_find(asha_adapters, match_adapter, (void *) 1);
+=09=09asha_streams =3D queue_new();
+=09=09queue_push_tail(asha_streams, dev);
+=09=09writes =3D starts =3D 0;
+=09=09event(0, BT_HCI_EVT_LE_CONN_COMPLETE, &complete,
+=09=09=09=09=09=09=09 sizeof(complete));
+
+=09=09switch (scenario) {
+=09=09case 0:
+=09=09=09event(0, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &update,
+=09=09=09=09=09=09=09=09sizeof(update));
+=09=09=09assert(result.calls =3D=3D 1 && result.error =3D=3D -ERANGE);
+=09=09=09break;
+=09=09case 1:
+=09=09=09/* A rejected update leaves the 20 ms link intact. */
+=09=09=09update.status =3D 1;
+=09=09=09event(0, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &update,
+=09=09=09=09=09=09=09=09sizeof(update));
+=09=09=09assert(!result.calls && dev->io && !writes);
+=09=09=09assert(asha.state =3D=3D ASHA_STARTED);
+=09=09=09break;
+=09=09case 2:
+=09=09=09update.interval =3D cpu_to_le16(16);
+=09=09=09event(0, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &update,
+=09=09=09=09=09=09=09=09sizeof(update));
+=09=09=09assert(!result.calls && dev->io && writes =3D=3D 1);
+=09=09=09break;
+=09=09case 3:
+=09=09=09asha_conn_update(&update, sizeof(update), adapter);
+=09=09=09assert(dev->close_id && !result.calls);
+=09=09=09bt_asha_device_stop(dev);
+=09=09=09while (g_main_context_iteration(NULL, FALSE))
+=09=09=09=09;
+=09=09=09assert(!result.calls && !dev->close_id && !dev->io);
+=09=09=09break;
+=09=09case 4:
+=09=09=09asha_conn_update(&update, sizeof(update), adapter);
+=09=09=09bt_asha_device_set_stream_closed_cb(dev, NULL, NULL);
+=09=09=09while (g_main_context_iteration(NULL, FALSE))
+=09=09=09=09;
+=09=09=09assert(!result.calls && !dev->io);
+=09=09=09break;
+=09=09case 5:
+=09=09=09result.remove =3D true;
+=09=09=09event(0, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &update,
+=09=09=09=09=09=09=09=09sizeof(update));
+=09=09=09assert(result.calls =3D=3D 1 && !result.device);
+=09=09=09break;
+=09=09case 6:
+=09=09=09asha_adapter_remove(NULL, (void *) 1);
+=09=09=09while (g_main_context_iteration(NULL, FALSE))
+=09=09=09=09;
+=09=09=09assert(result.calls =3D=3D 1 && result.error =3D=3D -ENODEV);
+=09=09=09break;
+=09=09case 7:
+=09=09=09asha_disconn_complete(&disconnect, sizeof(disconnect),
+=09=09=09=09=09=09=09=09adapter);
+=09=09=09while (g_main_context_iteration(NULL, FALSE))
+=09=09=09=09;
+=09=09=09assert(result.calls =3D=3D 1 && result.error =3D=3D -ENOTCONN);
+=09=09=09break;
+=09=09case 8:
+=09=09=09interval_error =3D true;
+=09=09=09update.interval =3D cpu_to_le16(16);
+=09=09=09event(0, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &update,
+=09=09=09=09=09=09=09=09sizeof(update));
+=09=09=09assert(result.calls =3D=3D 1 && result.error =3D=3D -EIO);
+=09=09=09interval_error =3D false;
+=09=09=09break;
+=09=09case 9:
+=09=09=09asha_conn_update(&update, sizeof(update), adapter);
+=09=09=09source =3D dev->close_id;
+=09=09=09asha_conn_update(&update, sizeof(update), adapter);
+=09=09=09assert(source && dev->close_id =3D=3D source);
+=09=09=09while (g_main_context_iteration(NULL, FALSE))
+=09=09=09=09;
+=09=09=09assert(result.calls =3D=3D 1 && !dev->close_id);
+=09=09=09break;
+=09=09case 10:
+=09=09=09update.handle =3D cpu_to_le16(17);
+=09=09=09event(0, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &update,
+=09=09=09=09=09=09=09=09sizeof(update));
+=09=09=09assert(!result.calls && dev->io && !writes);
+=09=09=09break;
+=09=09case 11:
+=09=09=09asha_conn_update(&update, sizeof(update), adapter);
+=09=09=09source =3D dev->close_id;
+=09=09=09bt_asha_device_state_reset(dev);
+=09=09=09assert(!g_main_context_find_source_by_id(NULL, source));
+=09=09=09queue_remove(asha_streams, dev);
+=09=09=09g_free(dev);
+=09=09=09result.device =3D NULL;
+=09=09=09while (g_main_context_iteration(NULL, FALSE))
+=09=09=09=09;
+=09=09=09assert(!result.calls);
+=09=09=09break;
+=09=09}
+
+=09=09assert(!starts);
+
+=09=09if (result.device) {
+=09=09=09bt_asha_device_state_reset(dev);
+=09=09=09queue_remove(asha_streams, dev);
+=09=09=09g_free(dev);
+=09=09}
+
+=09=09queue_destroy(asha_streams, NULL);
+=09=09asha_streams =3D NULL;
+
+=09=09if (scenario !=3D 6)
+=09=09=09asha_adapter_remove(NULL, (void *) 1);
+
+=09=09close(peer_fd[0]);
+=09=09close(fds[1]);
+=09}
+
+=09tester_test_passed();
+}
+
 int main(int argc, char *argv[])
 {
 =09tester_init(&argc, &argv);
 =09tester_add("ASHA/interval/HCI", NULL, NULL, test_connection, NULL);
 =09tester_add("ASHA/interval/observer-lifecycle", NULL, NULL,
 =09=09=09=09=09=09test_observer_lifecycle, NULL);
+=09tester_add("ASHA/interval/start-gate", NULL, NULL,
+=09=09=09=09=09=09=09test_start_gate, NULL);
+=09tester_add("ASHA/interval/pending-connect", NULL, NULL,
+=09=09=09=09=09=09test_pending_connect, NULL);
+=09tester_add("ASHA/interval/acquired-interval", NULL, NULL,
+=09=09=09=09=09=09test_acquired_interval, NULL);
 =09return tester_run();
 }

