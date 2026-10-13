Received: from mail-43100.protonmail.ch (mail-43100.protonmail.ch [185.70.43.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046EF479890
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 03:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863659; cv=none; b=bBnoTWMpbGl6Xb3e6c8hjCweD67tbsF/a9mnV7Y5eWgCE1vYRmrrShlqedy1LI6uNUlmqtTAZ1BoIH1/RJP+M4A+PpGPWiSPENCrYvEPw/wvdQsDbMoxhOTnsrTsO6AZ9schhrnk8ovEbanrX/qQX6RY53Kcj6ELBSO8mPWugL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863659; c=relaxed/simple;
	bh=Xm40UdpQfI3ttF5VB1MZWy4rDLlE+RESTGnOQrktv+8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=t+jA4/QKqidw79geXJqVd6eCfpbfSrcwl80qz4/Jhaa7yUv3ExlfU5a2uMf9X1+Wkd1wCd4WjC/NMS+x2HOINmYgdJ17IO9kMAm4DYDMmV+UvM3Um3kJrXdPSNEub6znX2xFsUO258HdXIZ5DNRDyP/Tg3Tbhk+HOjnKLs0X+Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=nCUnptYe; arc=none smtp.client-ip=185.70.43.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="nCUnptYe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1791863646; x=1792122846;
	bh=VwkFNoObCdY2kNu7AdvVS8kUROwJQgRz9kWhxT3n//I=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=nCUnptYeOkSbKH8jNDueVEop6Gd5hRfa6k0zescXKpPf4a9huR67B1OoTV0UKxxHl
	 2Ukw6klCvf8D4pW0E4NMtNd3cXBP4KXEY0NvG5+5oDwASdP9vablphqmePku/Sh9qy
	 XHxHAanPktTNrInM7AI9zoU+Th2QGXXm/+uhxFDybn5A9i0TRcrnsFHkToO+vYBtJ5
	 ffttjdRMyZjagyGFk5WstdKQ5eMfwpnsk3qKLOhfYZJKL/Tlh3uoyJ1szFdXxtaWK7
	 sDWC+1Tmx1QkHbzjY/n713ih6sjqfs5sE0DkUhwL1JCt9sG/yCWoln7fuc6gC9HWNv
	 +Deq/v1kDvDcA==
Date: Tue, 13 Oct 2026 03:54:04 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [RFC PATCH] asha: Defer BR/EDR inquiry while streaming
Message-ID: <20261013035348.525335-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 93b59048d989af9ccff3afa6476c0eb7df62e8e8
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Defer BR/EDR discovery while ASHA streams are active on the adapter.
Keep client filters intact and leave LE discovery available.

Reject a new BR/EDR-only discovery request with Busy rather than
leaving its reply pending. Re-evaluate the scan type after START
completes, and leave suspended discovery suspended.

Assisted-by: OpenCode:gpt-6.1-sol
---
Submission review notes (not part of the commit message):
Local validation is for base 7428ca2df9356363079db0f48412c20cbdb9471f.
Compatibility with newer upstream tips has not been verified locally.
October 12 N8/UB500 capture 182750 has successful LE discovery during
streaming, 5342 audio SDUs, no in-stream Inquiry, and BR/EDR Inquiry after
STOP. This tests the combined package. Native MGMT acknowledgments,
cancellation, failure unwind and concurrent-client arbitration remain
review gates. A separate baseline SPA plugin crash occurs at daemon swap;
the capture does not establish the source-level cause of that crash.

 profiles/audio/asha.c |  30 ++++++++++-
 src/adapter.c         | 119 ++++++++++++++++++++++++++++++++++++++++--
 src/adapter.h         |   5 ++
 3 files changed, 147 insertions(+), 7 deletions(-)

diff --git a/profiles/audio/asha.c b/profiles/audio/asha.c
index 8e625fdca3..602da68da4 100644
--- a/profiles/audio/asha.c
+++ b/profiles/audio/asha.c
@@ -60,8 +60,26 @@ struct bt_asha_device {
 =09uint16_t imtu, omtu;
=20
 =09unsigned int resume_id;
+=09bool streaming_counted;
 };
=20
+/*
+ * Count each device once so inquiry stays deferred until all streams stop=
.
+ */
+static void asha_set_streaming(struct bt_asha_device *asha_dev, bool strea=
ming)
+{
+=09if (streaming =3D=3D asha_dev->streaming_counted)
+=09=09return;
+
+=09if (streaming)
+=09=09btd_adapter_le_audio_ref(device_get_adapter(asha_dev->device));
+=09else
+=09=09btd_adapter_le_audio_unref(
+=09=09=09=09=09device_get_adapter(asha_dev->device));
+
+=09asha_dev->streaming_counted =3D streaming;
+}
+
 static char *make_endpoint_path(struct bt_asha_device *asha_dev)
 {
 =09char *path;
@@ -91,6 +109,7 @@ static void connect_cb(GIOChannel *io, GError *err, gpoi=
nter user_data)
=20
 =09if (err) {
 =09=09error("%s", err->message);
+=09=09asha_set_streaming(asha_dev, false);
 =09=09return;
 =09}
=20
@@ -171,12 +190,15 @@ unsigned int bt_asha_device_start(struct bt_asha_devi=
ce *asha_dev,
=20
 =09if (ret < 0)
 =09=09return 0;
-=09else
-=09=09return (++asha_dev->resume_id);
+
+=09asha_set_streaming(asha_dev, true);
+=09return (++asha_dev->resume_id);
 }
=20
 unsigned int bt_asha_device_stop(struct bt_asha_device *asha_dev)
 {
+=09asha_set_streaming(asha_dev, false);
+
 =09bt_asha_stop(asha_dev->asha);
=20
 =09if (asha_dev->io) {
@@ -190,6 +212,8 @@ unsigned int bt_asha_device_stop(struct bt_asha_device =
*asha_dev)
=20
 void bt_asha_device_state_reset(struct bt_asha_device *asha_dev)
 {
+=09asha_set_streaming(asha_dev, false);
+
 =09if (asha_dev->io) {
 =09=09g_io_channel_shutdown(asha_dev->io, TRUE, NULL);
 =09=09g_io_channel_unref(asha_dev->io);
@@ -371,6 +395,8 @@ static void asha_source_device_remove(struct btd_servic=
e *service)
 =09=09return;
 =09}
=20
+=09asha_set_streaming(asha_dev, false);
+
 =09bt_asha_free(asha_dev->asha);
 =09g_free(asha_dev);
 }
diff --git a/src/adapter.c b/src/adapter.c
index d3aa03fb70..28c58106dd 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -302,6 +302,7 @@ struct btd_adapter {
 =09=09=09=09=09 * without delay */
 =09uint8_t discovery_type;=09=09/* current active discovery type */
 =09uint8_t discovery_enable;=09/* discovery enabled/disabled */
+=09unsigned int le_audio_active;=09/* Active ASHA streams */
 =09bool discovery_suspended;=09/* discovery has been suspended */
 =09bool discovery_discoverable;=09/* discoverable while discovering */
 =09GSList *discovery_list;=09=09/* list of discovery clients */
@@ -1833,6 +1834,8 @@ static void discovery_remove(struct discovery_client =
*client)
 }
=20
 static void trigger_start_discovery(struct btd_adapter *adapter, guint del=
ay);
+static int update_discovery_filter(struct btd_adapter *adapter);
+static uint8_t discovery_scan_type(struct btd_adapter *adapter, uint8_t ty=
pe);
=20
 static struct discovery_client *discovery_complete(struct btd_adapter *ada=
pter,
 =09=09=09=09=09=09uint8_t status)
@@ -1867,6 +1870,7 @@ static void start_discovery_complete(uint8_t status, =
uint16_t length,
 =09struct btd_adapter *adapter =3D user_data;
 =09struct discovery_client *client;
 =09const struct mgmt_cp_start_discovery *rp =3D param;
+=09uint8_t type;
=20
 =09DBG("status 0x%02x", status);
=20
@@ -1911,6 +1915,16 @@ static void start_discovery_complete(uint8_t status,=
 uint16_t length,
=20
 =09=09discovery_complete(adapter, status);
=20
+=09=09/* Audio or filters may change while START is pending. */
+=09=09type =3D adapter->current_discovery_filter ?
+=09=09=09=09adapter->current_discovery_filter->type :
+=09=09=09=09get_scan_type(adapter);
+=09=09type =3D discovery_scan_type(adapter, type);
+
+=09=09if (!adapter->discovery_suspended &&
+=09=09=09=09=09=09adapter->discovery_type !=3D type)
+=09=09=09trigger_start_discovery(adapter, 0);
+
 =09=09if (adapter->discovering)
 =09=09=09return;
=20
@@ -1934,23 +1948,60 @@ static void start_discovery_complete(uint8_t status=
, uint16_t length,
 =09trigger_start_discovery(adapter, IDLE_DISCOV_TIMEOUT * 2);
 }
=20
+/*
+ * Defer BR/EDR discovery during ASHA streaming, leaving LE discovery avai=
lable.
+ * A zero result means the client requested only BR/EDR discovery.
+ */
+static uint8_t discovery_scan_type(struct btd_adapter *adapter, uint8_t ty=
pe)
+{
+=09if ((type & SCAN_TYPE_BREDR) && btd_adapter_le_audio_active(adapter)) {
+=09=09DBG("LE audio active: deferring BR/EDR inquiry");
+=09=09type &=3D ~SCAN_TYPE_BREDR;
+=09}
+
+=09return type;
+}
+
+static void defer_discovery(struct btd_adapter *adapter)
+{
+=09struct discovery_client *client;
+
+=09/* Do not leave a new BR/EDR-only StartDiscovery call unanswered. */
+=09client =3D discovery_complete(adapter, MGMT_STATUS_BUSY);
+=09if (client) {
+=09=09discovery_remove(client);
+
+=09=09if (adapter->discovery_list)
+=09=09=09update_discovery_filter(adapter);
+
+=09=09return;
+=09}
+
+=09/* Keep accepted sessions until audio releases the adapter. */
+=09trigger_start_discovery(adapter, IDLE_DISCOV_TIMEOUT);
+}
+
 static bool start_discovery_timeout(gpointer user_data)
 {
 =09struct btd_adapter *adapter =3D user_data;
 =09struct mgmt_cp_start_service_discovery *sd_cp;
+=09size_t sd_len;
 =09uint8_t new_type;
=20
 =09DBG("");
=20
 =09adapter->discovery_idle_timeout =3D 0;
=20
+=09if (!adapter->discovery_list || adapter->discovery_suspended)
+=09=09return FALSE;
+
 =09/* If we're doing filtered discovery, it must be quickly restarted */
 =09adapter->no_scan_restart_delay =3D !!adapter->current_discovery_filter;
=20
 =09DBG("adapter->current_discovery_filter =3D=3D %d",
 =09    !!adapter->current_discovery_filter);
=20
-=09new_type =3D get_scan_type(adapter);
+=09new_type =3D discovery_scan_type(adapter, get_scan_type(adapter));
=20
 =09if (adapter->discovery_enable =3D=3D 0x01) {
 =09=09struct mgmt_cp_stop_discovery cp;
@@ -1999,6 +2050,12 @@ static bool start_discovery_timeout(gpointer user_da=
ta)
 =09=09struct mgmt_cp_start_discovery cp;
=20
 =09=09cp.type =3D new_type;
+
+=09=09if (!cp.type) {
+=09=09=09defer_discovery(adapter);
+=09=09=09return FALSE;
+=09=09}
+
 =09=09mgmt_send(adapter->mgmt, MGMT_OP_START_DISCOVERY,
 =09=09=09=09=09adapter->dev_id, sizeof(cp), &cp,
 =09=09=09=09=09start_discovery_complete, adapter,
@@ -2007,18 +2064,32 @@ static bool start_discovery_timeout(gpointer user_d=
ata)
 =09=09return FALSE;
 =09}
=20
-=09/* Filtered discovery is required */
-=09sd_cp =3D adapter->current_discovery_filter;
+=09/* Filtered discovery is required. Keep the cached client filter intact=
;
+=09 * it is needed to restore BR/EDR discovery after audio stops.
+=09 */
+=09sd_len =3D sizeof(*sd_cp) +
+=09=09btohs(adapter->current_discovery_filter->uuid_count) * 16;
+=09sd_cp =3D util_memdup(adapter->current_discovery_filter, sd_len);
+=09if (!sd_cp)
+=09=09return FALSE;
+
+=09sd_cp->type =3D discovery_scan_type(adapter, sd_cp->type);
+=09if (!sd_cp->type) {
+=09=09free(sd_cp);
+=09=09defer_discovery(adapter);
+=09=09return FALSE;
+=09}
=20
 =09DBG("sending MGMT_OP_START_SERVICE_DISCOVERY %d, %d, %d",
 =09=09=09=09sd_cp->rssi, sd_cp->type,
 =09=09=09=09btohs(sd_cp->uuid_count));
=20
 =09mgmt_send(adapter->mgmt, MGMT_OP_START_SERVICE_DISCOVERY,
-=09=09  adapter->dev_id, sizeof(*sd_cp) +
-=09=09  btohs(sd_cp->uuid_count) * 16,
+=09=09  adapter->dev_id, sd_len,
 =09=09  sd_cp, start_discovery_complete, adapter, NULL);
=20
+=09free(sd_cp);
+
 =09return FALSE;
 }
=20
@@ -6266,6 +6337,44 @@ struct btd_adapter *btd_adapter_ref(struct btd_adapt=
er *adapter)
 =09return adapter;
 }
=20
+void btd_adapter_le_audio_ref(struct btd_adapter *adapter)
+{
+=09if (!adapter)
+=09=09return;
+
+=09adapter->le_audio_active++;
+
+=09/* First active stream: re-evaluate any running discovery so an
+=09 * in-progress BR/EDR inquiry is dropped right away rather than only at
+=09 * the next ~5 s re-arm.
+=09 */
+=09if (adapter->le_audio_active =3D=3D 1 && adapter->discovery_list &&
+=09=09=09=09=09=09!adapter->discovery_suspended) {
+=09=09DBG("LE audio active: restarting discovery without BR/EDR");
+=09=09trigger_start_discovery(adapter, 0);
+=09}
+}
+
+void btd_adapter_le_audio_unref(struct btd_adapter *adapter)
+{
+=09if (!adapter || !adapter->le_audio_active)
+=09=09return;
+
+=09adapter->le_audio_active--;
+
+=09/* Restore requested discovery after the last stream stops. */
+=09if (adapter->le_audio_active =3D=3D 0 && adapter->discovery_list &&
+=09=09=09=09=09=09!adapter->discovery_suspended) {
+=09=09DBG("LE audio idle: restoring BR/EDR discovery");
+=09=09trigger_start_discovery(adapter, 0);
+=09}
+}
+
+bool btd_adapter_le_audio_active(struct btd_adapter *adapter)
+{
+=09return adapter && adapter->le_audio_active > 0;
+}
+
 void btd_adapter_unref(struct btd_adapter *adapter)
 {
 =09if (__sync_sub_and_fetch(&adapter->ref_count, 1))
diff --git a/src/adapter.h b/src/adapter.h
index 583168f4bc..6ad8fb096f 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -119,6 +119,11 @@ bool btd_adapter_uuid_is_allowed(struct btd_adapter *a=
dapter, const char *uuid);
 struct btd_adapter *btd_adapter_ref(struct btd_adapter *adapter);
 void btd_adapter_unref(struct btd_adapter *adapter);
=20
+/* Defer BR/EDR discovery while ASHA streams are active. */
+void btd_adapter_le_audio_ref(struct btd_adapter *adapter);
+void btd_adapter_le_audio_unref(struct btd_adapter *adapter);
+bool btd_adapter_le_audio_active(struct btd_adapter *adapter);
+
 void btd_adapter_set_class(struct btd_adapter *adapter, uint8_t major,
 =09=09=09=09=09=09=09uint8_t minor);
 int btd_adapter_set_name(struct btd_adapter *adapter, const char *name);

base-commit: 7428ca2df9356363079db0f48412c20cbdb9471f

