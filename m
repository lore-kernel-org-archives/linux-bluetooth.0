Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794019635;
	b=kQa9NDfQB8ZJymW5sLqdiJQnZ2quq9VyQDDDZmNVXwb3988t7QdXEaf3br2LZe7c9M84
	 77PIAR8QpB3HeXnzSlsVjnIdP3yH105Ozfoi9Z+vl3I80CBTGRaq14AgOfMHILI52xHh/
	 G+YKf4DyeiSfy83SOnI6KtkihAsEn9pg+UuyG5fdCVOKcADoJbla5CESGRV/o/2I6DQWV
	 LdMZ09VxiRo/E8IFuSVjPkrVJx89X5snh2HBGJSzBBCF1fnA6pOsspSouj6joweOqHXC6
	 ycyVkEEjo+iVLd0w3V3B3DC5eeaNCPSk3GbFIqRP6wbahJGe+Ext8ep5WB+QxaJGGfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794019635;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=5T9z6KzrTLURGfAu00IBE1IhHZx6lEJ97cRiKVCtRZM=;
	b=KZgzOY+lLbycNi0QtrrT+LCKLQnrILzMBUqzpLoPouyyAIgZA8nS6oCV47U03QgXuJRD
	 HQcdcclCjc96ig6kncJeTG0kdgeQODWQ7EPdMoW6dd0vvSjHBT0T4rDKtS62XIBMVySAY
	 DvqH3ND5UMbjxlcnVAqOuETaWAiziUI6T9EVC6QoUPU8qmWz7AQIpTTxaiQ88FeBz5jq+
	 qoPzD9D81ELZMylIO2uScsdBmPMJVs/aG5pa4yDOfkBXPHlzaU3rJNEUqss+S4MJsgxTN
	 JwklpYIY2gruQWBzQ2r8Q6lX2DjaucYu9PC4mJs5mBBjG0nRH3j1lrw5L4qELCP/rKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=of7xesae45fijizgekhphhupf4.protonmail2 header.b=MSG+u7eo;
	arc=none smtp.remote-ip=109.224.244.18
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331E4606A32E
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Nov 2026 02:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 331E4606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=of7xesae45fijizgekhphhupf4.protonmail2 header.b=MSG+u7eo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=of7xesae45fijizgekhphhupf4.protonmail2; t=1794019630;
	x=1794278830; bh=5T9z6KzrTLURGfAu00IBE1IhHZx6lEJ97cRiKVCtRZM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=MSG+u7eoFAL15UZYdwBhDOyD9oCkFlj89dN/rSGV0iwhLX/WAfsUDP/d/gfO4aA+t
	 Ug7kN48Pj61acjvdh5VLylXa88BcRq2eo6V7wEjq3yidzCcFf54V6kcEb5DT/z7yvE
	 IrO1QwCt8T6u1GWrLtBN8DnTdoasxhB5lHfifl8/T8tgSxoh7Zzb6KurJfHn9hZIdX
	 qYLvGeGkYJYBw1VO2AtGiniB4/v2Rpltz3ghGS1Ycs92zZFWGikvHyA6wWHwRsPS46
	 GSb8gSdQIbMGRGlYRIuSHcKmdddtD37KvsXKw0ZJqAqkTdrU8JqJli1OKMrZeLqyin
	 jsFblZlwmRelA==
Date: Sat, 07 Nov 2026 02:47:07 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com
Subject: [RFC PATCH v3] asha: Defer BR/EDR inquiry while streaming
Message-ID: <20261107024655.1481992-1-cochcoder@proton.me>
In-Reply-To: <20261107014841.1452698-1-cochcoder@proton.me>
References: <20261028133243.262314-1-cochcoder@proton.me> <20261107014841.1452698-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: df8ddb93714b629430ac19f423a4db7b6bcf8858
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

Defer BR/EDR inquiry while ASHA streams are active. Keep LE discovery
available and preserve client filters for restoration after audio stops.
Return Busy if a new request leaves no permitted scan type. Recheck
pending discovery starts when audio changes.

Release the stream count when START cannot be queued or its callback
reports failure, so a failed acquisition cannot keep inquiry suppressed.

Assisted-by: OpenCode:gpt-6.1-sol
Assisted-by: Codex:gpt-6
---
v3: Wrap the unref call and shorten a comment to meet the
80-column limit. No behavior changes from v2.

Previous version:
https://lore.kernel.org/linux-bluetooth/20261107014841.1452698-1-cochcoder@=
proton.me/

v2 CI: CheckPatch failed on these two long lines; the other
11 checks passed. Native MGMT/client arbitration and isolated
hardware validation remain open.

 profiles/audio/asha.c | 47 ++++++++++++++++++++++++---
 src/adapter.c         | 75 ++++++++++++++++++++++++++++++++++++++++---
 src/adapter.h         |  4 +++
 3 files changed, 117 insertions(+), 9 deletions(-)

diff --git a/profiles/audio/asha.c b/profiles/audio/asha.c
index 8e625fdca3..d1fcddbcee 100644
--- a/profiles/audio/asha.c
+++ b/profiles/audio/asha.c
@@ -60,8 +60,36 @@ struct bt_asha_device {
 =09uint16_t imtu, omtu;
=20
 =09unsigned int resume_id;
+=09bool streaming_counted;
+=09bt_asha_cb_t start_cb;
+=09void *start_cb_data;
 };
=20
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
+static void asha_start_cb(int status, void *user_data)
+{
+=09struct bt_asha_device *asha_dev =3D user_data;
+
+=09if (status)
+=09=09asha_set_streaming(asha_dev, false);
+
+=09if (asha_dev->start_cb)
+=09=09asha_dev->start_cb(status, asha_dev->start_cb_data);
+}
+
 static char *make_endpoint_path(struct bt_asha_device *asha_dev)
 {
 =09char *path;
@@ -91,6 +119,7 @@ static void connect_cb(GIOChannel *io, GError *err, gpoi=
nter user_data)
=20
 =09if (err) {
 =09=09error("%s", err->message);
+=09=09asha_set_streaming(asha_dev, false);
 =09=09return;
 =09}
=20
@@ -107,8 +136,11 @@ static void connect_cb(GIOChannel *io, GError *err, gp=
ointer user_data)
=20
 =09asha_dev->io =3D io;
=20
-=09bt_asha_start(asha_dev->asha, conn_data->cb,
-=09=09=09=09=09conn_data->cb_user_data);
+=09asha_dev->start_cb =3D conn_data->cb;
+=09asha_dev->start_cb_data =3D conn_data->cb_user_data;
+
+=09if (bt_asha_start(asha_dev->asha, asha_start_cb, asha_dev))
+=09=09asha_set_streaming(asha_dev, false);
 }
=20
 static int asha_connect_socket(struct bt_asha_device *asha_dev,
@@ -171,12 +203,15 @@ unsigned int bt_asha_device_start(struct bt_asha_devi=
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
@@ -190,6 +225,8 @@ unsigned int bt_asha_device_stop(struct bt_asha_device =
*asha_dev)
=20
 void bt_asha_device_state_reset(struct bt_asha_device *asha_dev)
 {
+=09asha_set_streaming(asha_dev, false);
+
 =09if (asha_dev->io) {
 =09=09g_io_channel_shutdown(asha_dev->io, TRUE, NULL);
 =09=09g_io_channel_unref(asha_dev->io);
@@ -371,6 +408,8 @@ static void asha_source_device_remove(struct btd_servic=
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
index 6588a6e2bd..16a0920923 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -304,6 +304,7 @@ struct btd_adapter {
 =09=09=09=09=09 * without delay */
 =09uint8_t discovery_type;=09=09/* current active discovery type */
 =09uint8_t discovery_enable;=09/* discovery enabled/disabled */
+=09unsigned int le_audio_active;=09/* Active ASHA streams */
 =09bool discovery_suspended;=09/* discovery has been suspended */
 =09bool discovery_discoverable;=09/* discoverable while discovering */
 =09GSList *discovery_list;=09=09/* list of discovery clients */
@@ -1886,6 +1887,8 @@ static void discovery_remove(struct discovery_client =
*client)
 }
=20
 static void trigger_start_discovery(struct btd_adapter *adapter, guint del=
ay);
+static int update_discovery_filter(struct btd_adapter *adapter);
+static uint8_t discovery_scan_type(struct btd_adapter *adapter);
=20
 static struct discovery_client *discovery_complete(struct btd_adapter *ada=
pter,
 =09=09=09=09=09=09uint8_t status)
@@ -1964,6 +1967,11 @@ static void start_discovery_complete(uint8_t status,=
 uint16_t length,
=20
 =09=09discovery_complete(adapter, status);
=20
+=09=09/* Audio or filters may change while START is pending. */
+=09=09if (!adapter->discovery_suspended &&
+=09=09    adapter->discovery_type !=3D discovery_scan_type(adapter))
+=09=09=09trigger_start_discovery(adapter, 0);
+
 =09=09if (adapter->discovering)
 =09=09=09return;
=20
@@ -1987,23 +1995,39 @@ static void start_discovery_complete(uint8_t status=
, uint16_t length,
 =09trigger_start_discovery(adapter, IDLE_DISCOV_TIMEOUT * 2);
 }
=20
+static uint8_t discovery_scan_type(struct btd_adapter *adapter)
+{
+=09uint8_t type =3D adapter->current_discovery_filter ?
+=09=09=09=09adapter->current_discovery_filter->type :
+=09=09=09=09get_scan_type(adapter);
+
+=09if (adapter->le_audio_active)
+=09=09type &=3D ~SCAN_TYPE_BREDR;
+
+=09return type;
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
+=09new_type =3D discovery_scan_type(adapter);
=20
 =09if (adapter->discovery_enable =3D=3D 0x01) {
 =09=09struct mgmt_cp_stop_discovery cp;
@@ -2047,11 +2071,27 @@ static bool start_discovery_timeout(gpointer user_d=
ata)
=20
 =09}
=20
+=09if (!new_type) {
+=09=09struct discovery_client *client;
+
+=09=09/* Reject new requests; keep sessions until audio stops. */
+=09=09client =3D discovery_complete(adapter, MGMT_STATUS_BUSY);
+=09=09if (client) {
+=09=09=09discovery_remove(client);
+
+=09=09=09if (adapter->discovery_list)
+=09=09=09=09update_discovery_filter(adapter);
+=09=09}
+
+=09=09return FALSE;
+=09}
+
 =09/* Regular discovery is required */
 =09if (!adapter->current_discovery_filter) {
 =09=09struct mgmt_cp_start_discovery cp;
=20
 =09=09cp.type =3D new_type;
+
 =09=09mgmt_send(adapter->mgmt, MGMT_OP_START_DISCOVERY,
 =09=09=09=09=09adapter->dev_id, sizeof(cp), &cp,
 =09=09=09=09=09start_discovery_complete, adapter,
@@ -2060,18 +2100,25 @@ static bool start_discovery_timeout(gpointer user_d=
ata)
 =09=09return FALSE;
 =09}
=20
-=09/* Filtered discovery is required */
-=09sd_cp =3D adapter->current_discovery_filter;
+=09/* Keep the requested filter intact for when audio stops. */
+=09sd_len =3D sizeof(*sd_cp) +
+=09=09btohs(adapter->current_discovery_filter->uuid_count) * 16;
+=09sd_cp =3D util_memdup(adapter->current_discovery_filter, sd_len);
+=09if (!sd_cp)
+=09=09return FALSE;
+
+=09sd_cp->type =3D new_type;
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
@@ -6358,6 +6405,24 @@ struct btd_adapter *btd_adapter_ref(struct btd_adapt=
er *adapter)
 =09return adapter;
 }
=20
+void btd_adapter_le_audio_ref(struct btd_adapter *adapter)
+{
+=09if (adapter->le_audio_active++)
+=09=09return;
+
+=09if (adapter->discovery_list && !adapter->discovery_suspended)
+=09=09trigger_start_discovery(adapter, 0);
+}
+
+void btd_adapter_le_audio_unref(struct btd_adapter *adapter)
+{
+=09if (!adapter->le_audio_active || --adapter->le_audio_active)
+=09=09return;
+
+=09if (adapter->discovery_list && !adapter->discovery_suspended)
+=09=09trigger_start_discovery(adapter, 0);
+}
+
 void btd_adapter_unref(struct btd_adapter *adapter)
 {
 =09if (__sync_sub_and_fetch(&adapter->ref_count, 1))
diff --git a/src/adapter.h b/src/adapter.h
index 583168f4bc..d5cda2d96b 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -119,6 +119,10 @@ bool btd_adapter_uuid_is_allowed(struct btd_adapter *a=
dapter, const char *uuid);
 struct btd_adapter *btd_adapter_ref(struct btd_adapter *adapter);
 void btd_adapter_unref(struct btd_adapter *adapter);
=20
+/* Defer BR/EDR discovery while ASHA streams are active. */
+void btd_adapter_le_audio_ref(struct btd_adapter *adapter);
+void btd_adapter_le_audio_unref(struct btd_adapter *adapter);
+
 void btd_adapter_set_class(struct btd_adapter *adapter, uint8_t major,
 =09=09=09=09=09=09=09uint8_t minor);
 int btd_adapter_set_name(struct btd_adapter *adapter, const char *name);

base-commit: a8067198717b38391ca183ed7f41a69ec4b81b6e
--=20
2.56.0


