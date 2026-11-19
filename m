Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108595;
	b=uJ1/1oLaQJI63hrr00KGnUaeOJWaBv1qsDiDvFSM+1P8lD322xxCRzInXE7S+AbMBoYq
	 rKFdjnjCsbXBIj8aUKVkEUiHKyWXraM4p8y+CluQOA03Gj4XiVFkICNZe/84F5HHWzkmU
	 lSsX1UQGJo2WISfKJkWMOuwKhOaAyTTFnI0p+6+ZtFzhelwrqzcCd8YJCdGSZ7nUb5jGN
	 5JW941GRIaM4lF4xdy+bxNDsFe+h4TAjxhOzEy0NP3JV9d0/NU6H33q2MvDFyR1Ahgr4A
	 RqGvlLl59TfnEKNPyPOKqajc5JGvLeky10UE6M+ZAKsrrIe9/mLSnM/9gr1pgNTgkOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108595;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+Y+TE+Tx0yDhbICHeyMhiUDF/j0xFrXpFkthqsl+fxI=;
	b=vRkpOwCM8qyZyiefkiuy21nuiV5m9xHdzOy2kRYgXm6vk/lM4OBD/GSSuAKWt/J3Ce1d
	 +2vUQeRYA3B3aOzSOYTRZFgnNF3R1sEJlRuuKR/OeVSEgL3gMiIUMpFN/AsBexgHtpAiH
	 CAh8cCQwWc4PkFA1k+IxwrnhC4pjezw8cN2rS0gTw0tKwjBbq1vBTauIiPxLWsteJ1lNF
	 X1aLSWmjCHBxh83myK+1NKBvN7pIvNjvqK1j4q1Cfemc7vh8GtRo6e5vUKPeEwQSXSpbY
	 PMTvzrTyU5dEoAcmG0rCXDWjsC91U4RcXVyHvO6/R1cDrJR3E5pMsX0cigIvplTsB0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q1AwLJj3;
	arc=none smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271EB606A326
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 17:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 271EB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q1AwLJj3
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5eac7220e9cso910834e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 09:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795108594; x=1795713394; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Y+TE+Tx0yDhbICHeyMhiUDF/j0xFrXpFkthqsl+fxI=;
        b=Q1AwLJj3/ZaKUzsExYJEE9+RBsNLqnDKxtXNIzl17Uvg69TAViDjiHqWFtG2HaFG+8
         9+OBtXYR+e06yBPTeEY4V9hRoS1WEEpqr7xNkmpnqjZEW91jnXWTHoYiAQ3rY2QigxUm
         MAadDmZ4K0a9Z1xn2xL6xRsnupffj7MKluy3/3Vm3gR8jAQu1nj0WnK9NFUWXaYYIJIB
         fNrgwcY31rNufxypL9WkD+EU6bsiOG8Xr5VxoKeeeIS2AW2i9SdHv3mqdQaIYrK62l05
         cnkcS0rbkTQT48WUY5CgvCI8H/KCZ9KM8ksS67kWqINU2CMzac2HOIbVUOTS7qCXGmbO
         4D+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795108594; x=1795713394;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Y+TE+Tx0yDhbICHeyMhiUDF/j0xFrXpFkthqsl+fxI=;
        b=PIubIhRFBOXtTK5j14Q7B00ZzETVv78qAicmlz/kEvJSHBiqRK87CO1p63VqTNaiPI
         d2D+3jLJ73fMfnArUi2dUbOxldcS1ODvnEEuEWcdYqSlgJ3zsEDi6ABaQv5IMMzk4U/h
         ya8KVRjMu+4ZYk5HG2inJN/jLryYxiLSAbohdGkd8MuGMmn19dZLfuzToMn+BeBEBBMd
         5ZeyqTr4nJPyqS7uIfLEVtV2Roc5qVq5pim+T8QzQ07bZxCjQEok9AaqWj5IhBPBAjso
         X2/IFNTD5Pey3oKyeSUCSFTFTNCSLo1rC7ENhD7nUfFN95ihSZAwgRVS18qXDRZiw1hJ
         uLxw==
X-Gm-Message-State: APuU4Z+2yQ9oE22A47x6r8UFfzQ5egb6IMON7DbgzWnxqYqp6RTGqqpW
	npwTjsNf2mo9ZduJ0CuntgZzTW6AI7pgKK1F/X9uD6kQnUeLkugap0cKOZbks4+NsOo=
X-Gm-Gg: AYBFou0Ei1sl+5cfiRYHoVHWmS+VfZDKqxMCxH4ss5XqLVPSY8c0UKtuSpQ0GPt8bWj
	7jtdDCV/Rj8UwvaTt7BTL8ovasHf/BRFyVGxo2wyn/cGRFmFv6AjIrEI7nPB7cYk5OKmsafbRXp
	uuorP7EGaToQdmo02Va3GqwEpr55YpGeK9ORPQ9c0rDTxdW1N88T4hYJUDrdR0imqU01gNTOVk6
	bjpFtXl9Y5Tl+oOUDBaeiBFpAPplnHldz22Kg/tWn8YR3yNRqehv0scCKGQXDO2KhifV9ih4xbP
	slrIsdVfC3TQ57Nx7peVt0QDb4c9QxEV29X8pyRoOXaN1KCX7OFUGzgUUOHM/qj2/L+G4AMln5W
	rzynnXnZRJkdgmcT7xGLdrzt1ORBRmopygakdgJZNmbXia73uFFW8ww04DEtapKZ+3/1UQxAtB5
	EsJGBUPGzTNy2VwEMed/VbugDe7F3EuBqk23Iuv7SKKTxpA/720tiW0hdt3dZy92605XiMABGr7
	0PadcwysWw2ZA9k4YvobBqu5DZ122ggGReE/pUgKAfciNaGh5xl46Davv0iGNReK2j0wIHQ9cIe
	42xmXJONbg+LOnd8OKyD+0AqVydRsvtGU0ZFY/IDp6mssK3u7p9lKBs/WVrdeTL9eUaQw/NeBP2
	gVv1KJGt+AeuT++vzf6zxtD07JHVV5TmUlBmF/YJVeymkZ5n4LFx3/cXEdCePnDV0jCnjs7tKv6
	yZcVs=
X-Received: by 2002:a05:6122:1350:b0:5d4:a734:fb80 with SMTP id 71dfb90a1353d-5ee8adf6a05mr274479e0c.3.1795108593918;
        Thu, 19 Nov 2026 09:16:33 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5a8fd3sm131881e0c.8.2026.11.19.09.16.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:16:33 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 07/16] profiles/ranging: Let the Reflector run the CS setup phase
Date: Thu, 19 Nov 2026 12:16:15 -0500
Message-ID: <20261119171625.1014004-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119171625.1014004-1-luiz.dentz@gmail.com>
References: <20261119171625.1014004-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>

StartMeasurement() returned early for a Reflector, so the local Host
never read the CS capabilities or sent LE CS Set Default Settings, and
the state machine never left its idle state. The events driven by the
remote Initiator (Config, Security Enable, Procedure Enable) were then
dropped as out-of-state, and the Reflector role could not be used.

Run the setup phase for the Reflector as well. The FAE Table paths
skipped Set Default Settings for a Reflector, and for Both on the
Peripheral; send it on every path, and leave Create Config to the
Initiator, which rap_def_settings_done_cb() already decides from the
role.

The early return also skipped the Ranging Data subscription. The RAP
roles are independent of the CS roles (RAP v1.0 2), so a Reflector that
is the Ranging Requester still needs the peer's Ranging Data, and it is
now subscribed the same way as for an Initiator.

A Reflector can now reach StopMeasurement() before any procedure has
started, and the Procedure Enable it then sent was rejected by the
Controller; skip it while no procedure is running or being enabled.

bluetoothctl now keeps a session for a Reflector too, so that stop and
the Active property work for it, and the ChannelSounding1 documentation
describes the setup phase.

Assisted-by: Claude:claude-opus-5-5
---
 client/cs.c                        | 25 +++++------
 doc/org.bluez.ChannelSounding1.rst | 20 +++++----
 profiles/ranging/rap.c             | 34 +++++++++++----
 profiles/ranging/rap_hci.c         | 66 +++++++++++++-----------------
 4 files changed, 75 insertions(+), 70 deletions(-)

diff --git a/client/cs.c b/client/cs.c
index e029da881898..01d92cd9b53d 100644
--- a/client/cs.c
+++ b/client/cs.c
@@ -1120,29 +1120,26 @@ static void start_measurement_reply(DBusMessage *message, void *user_data)
 		return;
 	}
 
-	if (cs_role == 0x02) {
-		bt_shell_printf("Default settings applied on %s;"
-				" Reflector role does not start a local"
-				" measurement\n",
-				g_dbus_proxy_get_path(proxy));
-		return;
-	}
-
 	s = g_new0(struct cs_session, 1);
 	s->proxy    = proxy;
 	cs_sessions = g_list_append(cs_sessions, s);
 
-	bt_shell_printf("Measurement started on %s\n",
-			g_dbus_proxy_get_path(proxy));
+	if (cs_role == 0x02)
+		bt_shell_printf("Reflector armed on %s; waiting for the remote"
+				" Initiator\n",
+				g_dbus_proxy_get_path(proxy));
+	else
+		bt_shell_printf("Measurement started on %s\n",
+				g_dbus_proxy_get_path(proxy));
 }
 
 static void cs_print_role_hint(uint8_t role)
 {
 	if (role == 0x02)
-		bt_shell_printf("Note: Reflector role only uses"
-				" role/cs_sync_ant_sel/max_tx_power;"
-				" other CS config/frequency parameters"
-				" are ignored.\n");
+		bt_shell_printf("Note: Reflector role runs the setup phase and"
+				" then waits for the remote Initiator to create"
+				" the config; it does not start a procedure"
+				" itself.\n");
 	else
 		bt_shell_printf("Note: Initiator role requires dev_addr"
 				" and duration_secs; CS config/frequency"
diff --git a/doc/org.bluez.ChannelSounding1.rst b/doc/org.bluez.ChannelSounding1.rst
index e75535b97092..d3496accb899 100644
--- a/doc/org.bluez.ChannelSounding1.rst
+++ b/doc/org.bluez.ChannelSounding1.rst
@@ -37,23 +37,25 @@ Only one measurement per device object may be active at a time. Calling
 ``org.bluez.Error.InProgress``.
 
 When ``role`` is Reflector (``0x02``), this method does not start a CS
-distance measurement: a Reflector never initiates a procedure locally,
-so it cannot start one via this call. Instead, all given configuration
-is applied and stored so the controller is ready to respond once a
-remote Initiator begins a procedure, and the method returns success
-without arming a local measurement session. The ``Active`` property
-only transitions to ``true`` when a remote-initiated procedure
+procedure: a Reflector never initiates one locally. It runs the setup
+phase (reading the capabilities of both sides and applying the default
+settings) so the controller is ready to respond once a remote Initiator
+creates the configuration and begins a procedure. The ``Active``
+property only transitions to ``true`` when a remote-initiated procedure
 actually starts, which may happen well after this method returns (or
 not at all, if the remote never initiates one). Clients that watch
 ``PropertiesChanged`` for ``Active`` (as **bluetoothctl-cs(1)** does)
-are notified of both the remote-initiated start and its eventual stop.
+are notified of both the remote-initiated start and its eventual stop,
+which also ends the Reflector session: **StartMeasurement** has to be
+called again to respond to another procedure.
 
 For Initiator role (or Both), ``duration_secs`` and the device object
 path are the parameters that matter to start a measurement; every
 other key below is optional configuration with a usable default. For
 Reflector role, only ``role``, ``sync_ant_sel`` and ``max_tx_power``
 are required or have any effect — the remaining keys are accepted but
-otherwise unused, since no local procedure is armed.
+otherwise unused, since the configuration comes from the remote
+Initiator.
 
 Supported dictionary keys:
 
@@ -229,7 +231,7 @@ Examples:
 	| [cs] > start AA:BB:CC:DD:EE:FF
 :bluetoothctl start with defaults:
 	| [cs] > start [dev_addr] [duration_secs]
-:bluetoothctl configure as Reflector (applies settings, does not start a measurement):
+:bluetoothctl configure as Reflector (runs the setup phase, does not start a procedure):
 	| [cs] > role 0x02
 	| [cs] > start
 
diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
index d23c3f8e2e96..8f99572574c0 100644
--- a/profiles/ranging/rap.c
+++ b/profiles/ranging/rap.c
@@ -837,19 +837,16 @@ bad_type:
 		return g_dbus_create_error(msg, DBUS_ERROR_FAILED,
 					   "Set CS freq params failed");
 
-	/* Reflector never initiates a CS procedure locally: apply the
-	 * settings so the controller is ready to respond to the remote
-	 * Initiator, but do not arm a local measurement session.
-	 */
-	if (settings.role == 0x02)
-		return dbus_message_new_method_return(msg);
-
 	/* Nothing is subscribed at connection time unless On-demand is
 	 * configured, so subscribe now if SetRangingDataMode() was not called.
 	 */
 	if (!bt_rap_ensure_ranging_data(data->rap))
 		DBG("Unable to subscribe to Ranging Data");
 
+	/* The Reflector runs the setup phase too, so that the state machine
+	 * acts on the remote Initiator's events; rap_def_settings_done_cb()
+	 * leaves Create Config to the Initiator.
+	 */
 	if (!bt_rap_start_measurement(data->hci_sm, data->conn_handle,
 							duration_secs))
 		return g_dbus_create_error(msg, DBUS_ERROR_FAILED,
@@ -940,12 +937,20 @@ static const GDBusMethodTable cs_dbus_methods[] = {
 	{ }
 };
 
+#define CS_ROLE_INITIATOR	0x01
+
 static gboolean cs_property_get_active(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *user_data)
 {
 	struct rap_data *data = user_data;
-	dbus_bool_t active = data->active_session.active ||
-				bt_rap_is_procedure_active(data->hci_sm);
+	dbus_bool_t active = bt_rap_is_procedure_active(data->hci_sm);
+
+	/* A Reflector session is only armed while waiting for the peer, so
+	 * only report the procedure state for it.
+	 */
+	if (data->active_session.active &&
+	    (data->active_session.settings.role & CS_ROLE_INITIATOR))
+		active = true;
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &active);
 	return TRUE;
@@ -976,6 +981,17 @@ static void rap_proc_active_changed(bool active, void *user_data)
 {
 	struct rap_data *data = user_data;
 
+	/* A Reflector session only lasts for the remote procedure it was
+	 * armed for. End it with the procedure, so the Active=false that
+	 * follows leaves no session behind that StartMeasurement() would
+	 * refuse to replace and StopMeasurement() could not be reached for.
+	 */
+	if (!active && data->active_session.active &&
+	    !(data->active_session.settings.role & CS_ROLE_INITIATOR)) {
+		bt_rap_stop_measurement(data->hci_sm);
+		memset(&data->active_session, 0, sizeof(data->active_session));
+	}
+
 	g_dbus_emit_property_changed(btd_get_dbus_connection(),
 				device_get_path(data->device),
 				CS_INTERFACE, "Active");
diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index 62760b5c092e..d0610a22c160 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -716,7 +716,6 @@ static void rap_rd_rem_fae_cmplt_evt(const void *data, uint8_t size,
 	struct cs_state_machine *sm = (struct cs_state_machine *) user_data;
 	const struct bt_hci_evt_le_cs_rd_rem_fae_complete *evt;
 	struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete tmp_ev;
-	struct rap_conn_mapping *m;
 	struct iovec iov;
 	int i;
 
@@ -736,25 +735,24 @@ static void rap_rd_rem_fae_cmplt_evt(const void *data, uint8_t size,
 
 	DBG("status=0x%02X, handle=0x%04X", evt->status, evt->handle);
 
+	/* Every state machine on this adapter sees every CS event, so ignore
+	 * the ones for other links before acting on the status.
+	 */
+	if (!find_mapping_by_handle(sm, evt->handle)) {
+		DBG("Not for this link, ignoring");
+		return;
+	}
+
 	if (evt->status != 0) {
 		/* Status 0x11 (Unsupported Feature or Parameter Value) means
 		 * the remote has zero FAE, the procedure continues
 		 * to the Default Settings step.
 		 */
 		if (evt->status == 0x11) {
-			m = find_mapping_by_handle(sm, evt->handle);
-
 			DBG("Remote FAE=0 (No_FAE), proceed to Def Settings");
-			if (is_initiator_role(sm) ||
-			    (is_both_role(sm) && m && m->is_central)) {
-				memset(&tmp_ev, 0, sizeof(tmp_ev));
-				tmp_ev.handle = evt->handle;
-				DBG("Init/Both: send def settings (No_FAE)");
-				rap_send_hci_def_settings_command(sm, &tmp_ev);
-			} else {
-				DBG("Reflector role: continuing after No_FAE");
-				cs_set_state(sm, CS_STATE_INIT);
-			}
+			memset(&tmp_ev, 0, sizeof(tmp_ev));
+			tmp_ev.handle = evt->handle;
+			rap_send_hci_def_settings_command(sm, &tmp_ev);
 			return;
 		}
 		error("Remote FAE Table read failed with status 0x%02X",
@@ -774,18 +772,9 @@ static void rap_rd_rem_fae_cmplt_evt(const void *data, uint8_t size,
 	}
 
 	/* After receiving FAE Table, send default settings */
-	m = find_mapping_by_handle(sm, evt->handle);
-
-	if (is_initiator_role(sm) ||
-	    (is_both_role(sm) && m && m->is_central)) {
-		memset(&tmp_ev, 0, sizeof(tmp_ev));
-		tmp_ev.handle = evt->handle;
-		DBG("Init/Both: send def settings after FAE");
-		rap_send_hci_def_settings_command(sm, &tmp_ev);
-	} else {
-		DBG("Reflector role: Proceeding after FAE Table");
-		cs_set_state(sm, CS_STATE_INIT);
-	}
+	memset(&tmp_ev, 0, sizeof(tmp_ev));
+	tmp_ev.handle = evt->handle;
+	rap_send_hci_def_settings_command(sm, &tmp_ev);
 }
 
 static bool bt_rap_read_remote_fae_table(void *hci_sm, uint16_t handle)
@@ -821,7 +810,6 @@ static void rap_rd_rmt_supp_cap_cmplt_evt(const void *data, uint8_t size,
 {
 	struct cs_state_machine *sm = user_data;
 	const struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete *evt;
-	struct rap_conn_mapping *m;
 	struct iovec iov;
 	uint16_t subfeatures_supported;
 
@@ -871,18 +859,8 @@ static void rap_rd_rmt_supp_cap_cmplt_evt(const void *data, uint8_t size,
 		return;
 	}
 
-	m = find_mapping_by_handle(sm, evt->handle);
-
-	if (is_initiator_role(sm) ||
-	    (is_both_role(sm) && m && m->is_central)) {
-		DBG("Init/Both: send def settings for 0x%04X",
-			evt->handle);
-		rap_send_hci_def_settings_command(sm, evt);
-	} else {
-		DBG("Reflector role: send def settings cmd");
-		cs_set_state(sm, CS_STATE_INIT);
-		rap_send_hci_def_settings_command(sm, evt);
-	}
+	DBG("send def settings for 0x%04X", evt->handle);
+	rap_send_hci_def_settings_command(sm, evt);
 }
 
 static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
@@ -1844,6 +1822,18 @@ bool bt_rap_stop_measurement(void *hci_sm)
 		return false;
 	}
 
+	/* With no procedure running - a Reflector still waiting for the
+	 * Initiator, or a timeout left over from an earlier measurement -
+	 * there is nothing to disable, and the Controller answers Procedure
+	 * Enable with Invalid HCI Command Parameters. A procedure that is
+	 * being enabled has not reported yet, so still disable that one.
+	 */
+	if (!sm->procedure_active &&
+			cs_get_current_state(sm) != CS_STATE_WAIT_PROC_CMPLT) {
+		DBG("No local CS procedure active, nothing to disable");
+		return true;
+	}
+
 	return rap_send_hci_cs_procedure_enable(sm, sm->active_conn_handle,
 						false);
 }
-- 
2.56.0

