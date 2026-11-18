Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031935;
	b=sPR4y/SechHv1zZ58Wm4rMPZR0FZMawVEUL+8sBlvymFHzFxU9dvmesBdwuPIcf5hnhI
	 O8Qy3EODVSOf20BzqPeCcAbKNwR7Z71CoX/ElbsV2TcikN+di5Ff2K36/3Elcn6AjiD+q
	 Dn7MkkhjskOG4IVd6VbL5fnOO1AaexyJixIS/4EyGyocFITPL2u0eJP6h6KmqSjO6P+k3
	 P5NF4Nw6rwpgiD2tvRHwL1ka+rTVBUll+E3KPSRtbUmdkDIf/uTqJAzvyVfBPthfzUdrB
	 MuWhE+AdKNqoyRiAyFNwBnUWmNx9Ro/PW8LJudWT2zgpTTpMNcx7qyKVAh7CA7PYQRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031935;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=r7fOs1JCq6N8pmoA3KYXgNZyqLSfyJfJfC69YrpoTXc=;
	b=oBya+hXOZjSXwOaE/1NMFpy7xbnEiZO13h8L6r2Nx1oYUnQV0FQYyCH/JqVQ02/Ksxr2
	 WlZWWOCYsTCORgOR2JtpDYSuwk4h3ehnb+BL0k3JmYA0vUOsz+KX0u9gQAIWRJYHQV0Ix
	 NsEcm/bUUNrH3r4iSrIkz6+jjkzce2VkVwlTjnClPbsNSfTPona8MJh5kBVD7SZ6Hqb1r
	 HA4Jbtds1JOCIwX9HEL8Ls9yjvJX7Re/gtozrPiGwcOAl1zeDhC2+YckwZzvysHOr5jen
	 iD4ztGIKX7+Exo+rEn92X7yixMvMaU4hof0OJ9zXKDOgkcAHbAWY9XDI91UqRv61d3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v1LQKnnI;
	arc=none smtp.remote-ip=209.85.217.54
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808E5606A33E
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:58:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 808E5606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v1LQKnnI
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-77bf892b496so546650137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 11:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795031934; x=1795636734; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r7fOs1JCq6N8pmoA3KYXgNZyqLSfyJfJfC69YrpoTXc=;
        b=v1LQKnnIfyHvD63VI4ErQ3p8GF7sMbZNhtA3Q50Jo1yF0T/O7U12cbT6h9fZMYPyin
         HeWpz2s9nqhjNbj8oh1xNRvfy3OgE/cmBxHq+5BpXsstab5afpwviys3JzLLuofamU0+
         7xgnorUvMPMtXdajFoxS2SngzPKSwXekHbHCB0rEhCbzUYQbO0ShvHOnjkbn+hFE8jCU
         vek4AUht+8B0M53QIvuJPoMSXeZli6v38FPNdMoanhTWaiUjQ3D/sCdILH4ElHqX19EW
         54HMzwbwzB/A1VRTf6J19bn8+aF0U7cMcA1lA87nHgRSIYbdOIfZdFUGR8U/BJW8fsWV
         IkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795031934; x=1795636734;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r7fOs1JCq6N8pmoA3KYXgNZyqLSfyJfJfC69YrpoTXc=;
        b=15yLomaBIJfOfh6sita7GDKe5jbC4K0O4lxBxVXZF/oj8PPKnitbkFL0mpY2NxiawM
         C11YKoJQouGwXScTr5mlFJzqEWUEwOZQWLtcLRd/oWn1FIaBq0oSiajGX6HuUw322hQ9
         MASccuXbFvbpk5tEMQNTrfY+D3rq3nJTANZ2hzPeZ3tIA0sEdoEIDOt4nc6MAQxO+wcT
         gJsFij+HIvrgLg8ObVFKztuFvhkFGTnAYg6LxhkNdvFl75Ty9iSMFajk7LvN+sgrEQEx
         oYCEC1CCTln7ZyCvKkxlxQTbR6+53TTpv+Gty9Q1NEuFGQfQzIiVcBOzusG9QXHrOMbK
         usFA==
X-Gm-Message-State: APuU4Z8e9k7tDo/8uqXHFOb9VGOXjoRARAGff2+fNQkAmItfR0kvbdXf
	XiXg9ry8kLEfeEYmI4WMwxE+atyOtp3tIz9hzVusLuEYUjTlOt+6X7Q/9aGlAGq8
X-Gm-Gg: AYBFou3UvxwKyfSV39t4r8nHJ/elzvKNyI/QBfL24xqBYfNtC2FLs86bdDlSlXWgxba
	acd8nPJ01iH+Xfjv8ZNFAdneIEhYXiDugET20PxNw3TMN16DeTc+IfbjEJLYlyaHf5zlw+rTSAT
	jmU+qDxM8TMmB3A7qq8uFI1WDK0AgIkJi/4qCyAAR5aMzaeBeYBJh8sJC3H6LrbyRSIehfScg9K
	A084MP+ujEKh64W+sbfvF0uSY31MbhDwzqFEEPm4J3+GWEI7ev3FKsjpLTs1j4aAKb8GS5n5Cmb
	URj9e/8+9mV9B3rjf2mUlFhRACIKI+0u7tb4dB4xiFAosYFnbX+STAURo0eBavFZeg2VBIWNiF7
	RvqlpTSA9g3q6QtqENwmBpNyiaYvWWkN71zDOwG9rOhbJ9O0LAhDe/nbjHYLGu+6Ve8S/2Ojb4t
	xlDaec+YAyiWCn4II87zL+Juwn6Q9f03p2BurKVuOrasVCdTp6CFExHT9Wvvrp/RC62ub0pQJkL
	Xd+2dOz8nAr+SlnHt3c9HXc4YbYbOU6vpQsoaSvlDLjwIpCLsLolaXKEcElAsuE30guxAotGMO0
	XdaK8t3xTH1Cg5GJn7oab+qQeTE0WrM6NrMjG8omjEp6LoKkoAlTfj0jhBICt0Y3xywTeerg/bh
	fSQJW4/wOm1HIVV7Wvv5mcEqDU8+8M3md/3zF2WuHvFLw9BLIlOBnt15XEwlk8bhyfSn9ud4nDz
	gzUB8=
X-Received: by 2002:a05:6102:5802:b0:7ce:645a:13a4 with SMTP id ada2fe7eead31-7d6ba3dcce1mr1724512137.20.1795031934324;
        Wed, 18 Nov 2026 11:58:54 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b91e87f4sm2685571137.7.2026.11.18.11.58.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:58:53 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 07/16] profiles/ranging: Let the Reflector run the CS setup phase
Date: Wed, 18 Nov 2026 14:58:35 -0500
Message-ID: <20261118195846.393710-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118195846.393710-1-luiz.dentz@gmail.com>
References: <20261118195846.393710-1-luiz.dentz@gmail.com>
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
 client/cs.c                        | 25 ++++++-------
 doc/org.bluez.ChannelSounding1.rst | 16 ++++-----
 profiles/ranging/rap.c             | 23 +++++++-----
 profiles/ranging/rap_hci.c         | 58 +++++++++++-------------------
 4 files changed, 53 insertions(+), 69 deletions(-)

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
index e75535b97092..6e61ea4c1be0 100644
--- a/doc/org.bluez.ChannelSounding1.rst
+++ b/doc/org.bluez.ChannelSounding1.rst
@@ -37,12 +37,11 @@ Only one measurement per device object may be active at a time. Calling
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
@@ -53,7 +52,8 @@ path are the parameters that matter to start a measurement; every
 other key below is optional configuration with a usable default. For
 Reflector role, only ``role``, ``sync_ant_sel`` and ``max_tx_power``
 are required or have any effect — the remaining keys are accepted but
-otherwise unused, since no local procedure is armed.
+otherwise unused, since the configuration comes from the remote
+Initiator.
 
 Supported dictionary keys:
 
@@ -229,7 +229,7 @@ Examples:
 	| [cs] > start AA:BB:CC:DD:EE:FF
 :bluetoothctl start with defaults:
 	| [cs] > start [dev_addr] [duration_secs]
-:bluetoothctl configure as Reflector (applies settings, does not start a measurement):
+:bluetoothctl configure as Reflector (runs the setup phase, does not start a procedure):
 	| [cs] > role 0x02
 	| [cs] > start
 
diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
index d23c3f8e2e96..8c80436e34cf 100644
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
diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index 62760b5c092e..0eea018ccc29 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -716,7 +716,6 @@ static void rap_rd_rem_fae_cmplt_evt(const void *data, uint8_t size,
 	struct cs_state_machine *sm = (struct cs_state_machine *) user_data;
 	const struct bt_hci_evt_le_cs_rd_rem_fae_complete *evt;
 	struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete tmp_ev;
-	struct rap_conn_mapping *m;
 	struct iovec iov;
 	int i;
 
@@ -742,19 +741,10 @@ static void rap_rd_rem_fae_cmplt_evt(const void *data, uint8_t size,
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
@@ -774,18 +764,9 @@ static void rap_rd_rem_fae_cmplt_evt(const void *data, uint8_t size,
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
@@ -821,7 +802,6 @@ static void rap_rd_rmt_supp_cap_cmplt_evt(const void *data, uint8_t size,
 {
 	struct cs_state_machine *sm = user_data;
 	const struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete *evt;
-	struct rap_conn_mapping *m;
 	struct iovec iov;
 	uint16_t subfeatures_supported;
 
@@ -871,18 +851,8 @@ static void rap_rd_rmt_supp_cap_cmplt_evt(const void *data, uint8_t size,
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
@@ -1844,6 +1814,18 @@ bool bt_rap_stop_measurement(void *hci_sm)
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

