Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch [109.224.244.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01A11714AA
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Mar 2026 04:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773028956; cv=none; b=K910WdIMJiLMcZRZqc7FropK0G5w53klCoK2WbWs+KulTLsG73wtfhXv+5EjHF3JcK999vfWdJoctiDGH6wosZ+cfSQbMmQdkz5NxiWF3GbZeDCljBsEhuLBb2e4ks1tFu5iDFrI3WV/WTq/2+SJrpPiq40gvg6MhD6sNfbhYuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773028956; c=relaxed/simple;
	bh=y9NecwuF6z1eVqZ2FBqJ79rgNZTxsiEDhIcJoGI53CA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mfyzcyg+xOuAkr+2MzGr8ppHtGJ9S5fIEJv75nw5yFp/jj40WGeGCnDVxuNAM+8WNffZFOHbDGW73MAd4Y8F3ahUk1v61GrkFuQX4jjmhcIpEoMPqC+rq2vO2vPW2crwlTwEFLxewcBxG/BR+90igZvGSmqpE53M546JK6neHpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deschouwer.co.za; spf=pass smtp.mailfrom=deschouwer.co.za; dkim=pass (2048-bit key) header.d=deschouwer.co.za header.i=@deschouwer.co.za header.b=YrrjM/h/; arc=none smtp.client-ip=109.224.244.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deschouwer.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deschouwer.co.za
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deschouwer.co.za header.i=@deschouwer.co.za header.b="YrrjM/h/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deschouwer.co.za;
	s=protonmail2; t=1773028943; x=1773288143;
	bh=hWlGh0RE6vMkMgBw78IeMEpKsvK+SeXjH9+DUMH0hlE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=YrrjM/h/237oSAvLcAvabjWYtkS+hWcyvhlUL3hxvDV9i5PDoZ1nUDDgPj+y8m8ul
	 d7jb0OTyM6MEZ9Shi3s9eTTpcrDYp7fJZvKqMnUUIfOc+uIpAD2qJomkB1Hks///Rk
	 jtonLNy5kwcN9+lJMD2s37PvXqtfO7Bi6eKtUJ7Q0meKZd7IVXAwGOuLpjXXxai/ya
	 bGRhBDmgDn51XApOuim+r5XiqW7B5qv2XRd3oqk2O2j906Xs0ej3FRAj92m2jnIdKp
	 XWULz3LQVP8DuHUeifpJY1gLyNq8dNpavo60P9cWVq3kwHXEXrnZQbYzhhwWK5j+Kb
	 O7o88tJkRM19w==
Date: Mon, 09 Mar 2026 04:02:19 +0000
To: linux-bluetooth@vger.kernel.org
From: berend de schouwer <berend@deschouwer.co.za>
Cc: berend de schouwer <berend@deschouwer.co.za>
Subject: [PATCH BlueZ 1/1] Stop and start some actions on suspend and resume
Message-ID: <20260309040136.159073-2-berend@deschouwer.co.za>
In-Reply-To: <20260309040136.159073-1-berend@deschouwer.co.za>
References: <20260309040136.159073-1-berend@deschouwer.co.za>
Feedback-ID: 50941660:user:proton
X-Pm-Message-ID: 573eec89512d0b0bea85681659a46fdc42656744
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------912e4262715fca10c09f559a443f4328ca0453296feabf78d916df4bfcd258df"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------912e4262715fca10c09f559a443f4328ca0453296feabf78d916df4bfcd258df
Content-Type: multipart/mixed;
 boundary=deb16f07603ad3bd89f69cb99524eeae0fb2d4cea3b2880860cfc1e8793e
From: berend de schouwer <berend@deschouwer.co.za>
To: linux-bluetooth@vger.kernel.org
Cc: berend de schouwer <berend@deschouwer.co.za>
Subject: [PATCH BlueZ 1/1] Stop and start some actions on suspend and resume
Date: Mon,  9 Mar 2026 06:01:36 +0200
Message-ID: <20260309040136.159073-2-berend@deschouwer.co.za>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309040136.159073-1-berend@deschouwer.co.za>
References: <20260309040136.159073-1-berend@deschouwer.co.za>
MIME-Version: 1.0

--deb16f07603ad3bd89f69cb99524eeae0fb2d4cea3b2880860cfc1e8793e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Stop active device discovery on suspend and shutdown, and restart
on device resume.  This uses dbus notifications, so needs a running
login manager owner.
---
 src/adapter.c |  35 ++++++++
 src/adapter.h |   2 +
 src/main.c    | 226 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 263 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 4e5ff219f..5456c7fc9 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -288,6 +288,7 @@ struct btd_adapter {
 	bool filtered_discovery;	/* we are doing filtered discovery */
 	bool no_scan_restart_delay;	/* when this flag is set, restart scan
 					 * without delay */
+	bool discovering_before_sleep;	/* was discovery on before suspend? */
 	uint8_t discovery_type;		/* current active discovery type */
 	uint8_t discovery_enable;	/* discovery enabled/disabled */
 	bool discovery_suspended;	/* discovery has been suspended */
@@ -2083,6 +2084,40 @@ static void resume_discovery(struct btd_adapter *adapter)

 	trigger_start_discovery(adapter, IDLE_DISCOV_TIMEOUT);
 }
 
+void adapter_resume_discovery_sleep(void)
+{
+	GList *list;
+
+	for (list = g_list_first(adapter_list); list;
+						list = g_list_next(list)) {
+		struct btd_adapter *adapter = list->data;
+
+		if (adapter->discovering_before_sleep) {
+			DBG("Resuming discovery on: %s", adapter->name);
+			resume_discovery(adapter);
+		}
+		adapter->discovering_before_sleep = false;
+	}
+}
+
+void adapter_suspend_discovery_sleep(void)
+{
+	GList *list;
+	bool was_discovering;
+
+	for (list = g_list_first(adapter_list); list;
+						list = g_list_next(list)) {
+		struct btd_adapter *adapter = list->data;
+
+		was_discovering = (adapter->discovery_list);
+		if (was_discovering) {
+			DBG("Suspending discovery on: %s", adapter->name);
+			suspend_discovery(adapter);
+			adapter->discovering_before_sleep = was_discovering;
+		}
+	}
+}
+
 static void discovering_callback(uint16_t index, uint16_t length,
 
					const void *param, void *user_data)
 {
diff --git a/src/adapter.h b/src/adapter.h
index 4e07f71ad..4843c04a9 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -320,3 +320,5 @@ unsigned int btd_adapter_send_cmd_event_sync(struct btd_adapter *adapter,
 					void *user_data,
 					btd_adapter_destroy_func_t destroy,
 					uint8_t timeout);
+void adapter_suspend_discovery_sleep(void);
+void adapter_resume_discovery_sleep(void);
diff --git a/src/main.c b/src/main.c
index 59df0ad4c..831733f55 100644
--- a/src/main.c
+++ b/src/main.c
@@ -67,6 +67,9 @@
 struct btd_opts btd_opts;
 static GKeyFile *main_conf;
 static char main_conf_file_path[PATH_MAX];
+static unsigned int prepare_sleep_id;
+static unsigned int inhibit_lock = -1;
+static DBusConnection *client_conn;
 
 static const char *supported_options[] = {
 	"Name",
@@ -1443,6 +1446,224 @@ static GOptionEntry options[] = {
 	{ NULL },
 };
 
+static void obtain_inhibit_lock(void)
+{
+	DBusMessage *message
, *reply;
+	DBusMessageIter iter;
+	DBusError error;
+	int fd;
+	const char *what = "sleep";
+	const char *who = "bluetooth manager";
+	const char *why = "stopping device discovery";
+	const char *mode = "delay";
+
+	if (!client_conn || !dbus_connection_get_is_connected(client_conn))
+		return;
+
+	message = dbus_message_new_method_call("org.freedesktop.login1",
+					"/org/freedesktop/login1",
+					"org.freedesktop.login1.Manager",
+					"Inhibit");
+	if (!message) {
+		dbus_connection_unref(client_conn);
+		return;
+	}
+
+	dbus_message_iter_init_append(message, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &what);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &who);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &why);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &mode);
+	dbus_error_init(&error);
+	reply = dbus_connection_send_with_reply_and_block(client_conn,
+							message, -1, &error);
+	dbus_m
essage_unref(message);
+
+	if (dbus_error_is_set(&error)) {
+		warn("Failed to register a suspend inhibitor (selinux?): %s",
+			error.message);
+		dbus_error_free(&error);
+		return;
+	}
+
+	if (!reply)
+		return;
+
+	if (dbus_message_iter_init(reply, &iter) == FALSE) {
+		dbus_message_unref(reply);
+		return;
+	}
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_UNIX_FD) {
+		dbus_message_unref(reply);
+		return;
+	}
+
+	dbus_message_iter_get_basic(&iter, &fd);
+	inhibit_lock = fd;
+
+	dbus_message_unref(reply);
+}
+
+static void release_inhibit_lock(void)
+{
+	if (inhibit_lock < 0)
+		return;
+
+	close(inhibit_lock);
+	inhibit_lock = -1;
+}
+
+static gboolean prepare_for_sleep(DBusConnection *conn, DBusMessage *msg,
+				  void *user_data)
+{
+	DBusMessageIter iter;
+	dbus_bool_t entering;
+
+	DBG("preparing for sleep or resume");
+
+	if (dbus_message_iter_init(msg, &iter) == FALSE)
+		return TRUE;
+
+	if (dbus_message_iter_ge
t_arg_type(&iter) != DBUS_TYPE_BOOLEAN)
+		return TRUE;
+
+	dbus_message_iter_get_basic(&iter, &entering);
+
+	if (entering) {
+		adapter_suspend_discovery_sleep();
+		release_inhibit_lock();
+	} else {
+		adapter_resume_discovery_sleep();
+		obtain_inhibit_lock();
+	}
+	return TRUE;
+}
+
+int connect_login_manager(void)
+{
+	DBusError error;
+	dbus_bool_t login_manager_exists;
+
+	client_conn = btd_get_dbus_connection();
+
+	if (!client_conn || !dbus_connection_get_is_connected(client_conn))
+		return -1;
+
+	dbus_error_init(&error);
+	login_manager_exists = dbus_bus_name_has_owner(client_conn,
+						"org.freedesktop.login1",
+						&error);
+	if (dbus_error_is_set(&error)) {
+		dbus_error_free(&error);
+		return -1;
+	}
+
+	if (!login_manager_exists)
+		return -1;
+
+	return 0;
+}
+
+int connect_prepare_for_sleep(void)
+{
+	guint sleep_id;
+
+	obtain_inhibit_lock();
+
+	client_conn = btd_get_dbus_connection();
+
+	sleep_id = g_dbus_add
_signal_watch(client_conn,
+					"org.freedesktop.login1",
+					"/org/freedesktop/login1",
+					"org.freedesktop.login1.Manager",
+					"PrepareForSleep",
+					prepare_for_sleep,
+					NULL,
+					NULL);
+
+	if (!sleep_id) {
+		warn("Prohibited from watching suspend events.");
+		return -1;
+	}
+	prepare_sleep_id = sleep_id;
+
+	return 0;
+}
+
+static DBusHandlerResult login_manager_changed(DBusConnection *client_conn,
+	DBusMessage *message, void *_usr_data)
+{
+	const char *name;
+	const char *old_owner;
+	const char *new_owner;
+
+	if (!dbus_message_is_signal(message, "org.freedesktop.DBus",
+				    "NameOwnerChanged")) {
+		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+	}
+
+	if (!dbus_message_get_args(message, NULL,
+						DBUS_TYPE_STRING, &name,
+						DBUS_TYPE_STRING, &old_owner,
+						DBUS_TYPE_STRING, &new_owner,
+						DBUS_TYPE_INVALID))
+		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+
+	if (strcmp(name, "org.freedesktop.login1"))

+		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+
+	if (!strcmp(new_owner, ""))
+		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+
+	if (connect_prepare_for_sleep() >= 0)
+		dbus_connection_remove_filter(client_conn,
+						login_manager_changed, NULL);
+
+	return DBUS_HANDLER_RESULT_HANDLED;
+}
+
+int connect_login_and_prepare_for_sleep(void)
+{
+	DBusError error;
+
+	client_conn = btd_get_dbus_connection();
+
+	if (connect_login_manager() < 0) {
+		dbus_bus_add_match(client_conn,
+					"type='signal',"
+					"sender='org.freedesktop.DBus',"
+					"interface='org.freedesktop.DBus',"
+					"member='NameOwnerChanged'",
+					&error);
+
+		if (dbus_error_is_set(&error)) {
+			dbus_error_free(&error);
+			return -1;
+		}
+
+		dbus_connection_add_filter(client_conn, login_manager_changed,
+								NULL, free);
+		return -1;
+	}
+
+	return connect_prepare_for_sleep();
+}
+
+void disconnect_prepare_for_sleep(void)
+{
+	DBusConnection *conn = btd_get_dbus
_connection();
+
+	if (!conn || !dbus_connection_get_is_connected(conn))
+		return;
+
+	if (!prepare_sleep_id)
+		return;
+
+	g_dbus_remove_watch(conn, prepare_sleep_id);
+	prepare_sleep_id = 0;
+}
+
 int main(int argc, char *argv[])
 {
 	GOptionContext *context;
@@ -1498,6 +1719,9 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
+	if (connect_login_and_prepare_for_sleep() < 0)
+		info("Cannot listen for suspend yet, trying again later.");
+
 	if (btd_opts.experimental)
 		gdbus_flags = G_DBUS_FLAG_ENABLE_EXPERIMENTAL;
 
@@ -1557,6 +1781,8 @@ int main(int argc, char *argv[])
 	btd_agent_cleanup();
 	btd_device_cleanup();
 
+	disconnect_prepare_for_sleep();
+	adapter_suspend_discovery_sleep();
 	adapter_cleanup();
 
 	rfkill_exit();
-- 
2.53.0


--deb16f07603ad3bd89f69cb99524eeae0fb2d4cea3b2880860cfc1e8793e
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - Berend De Schouwer -
 0x128CD671.asc"; name="publickey - Berend De Schouwer - 0x128CD671.asc"
Content-Type: application/pgp-keys; filename="publickey - Berend De Schouwer
 - 0x128CD671.asc"; name="publickey - Berend De Schouwer - 0x128CD671.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCkNvbW1lbnQ6IGh0dHBzOi8vZ29w
ZW5wZ3Aub3JnClZlcnNpb246IEdvcGVuUEdQIDIuOS4wCgp4c0ZOQkZXS2tVRUJFQURYdWlFWVcx
WUlnTm5yYXpFby8wemVsVHp4YkhDRy93V3huN0FTdWQ4eEhMMWpxWks1CnF4UVMvNldSYm5RdjVj
NURQdmsxT2Y2RS8yWFZzRlVRSmdSMVlGeEd0TnQxUUFsNVIwdmo3cnZyOG5CYmVRaGMKbUhzdndH
cFQ3YWJrZXZXRnZtY0hiTktmWGJjL3NmRHJDTW90UkZRQm9oYzdveW8rTnpPSk9RcEpxQ2J6d2sr
awpWbVZoVkhwdzhZenZuRDJzVkRxYlFPeHRXbXJjb2ZtOURiMjhORTBOY04yUDlBQmJOSnV0MVFV
Wld0WjFsbVc2CnJ5aGdLckM0dXhTei9ZTmNjNXpzMlo3NjFTR0tPU1k4UFZ6dlZrTGJLOWZiZFk3
amNnR0NGZDZHUllPQjJJM0IKN0NPOXVhZnVUb0NEeWhscWx1Z1dYcEdvQTVCN28vYTRaMWI3cWxO
c0VtcWxHaCtlRDk0SDhNL0xXOGR3WU5SSQpvVU5ZSWF5UkYxT1FwcmM1UHozaUN4YW9ub0lpR2Z4
R1pxTktUOVFXb0lnOHJPQzA4dGNyOHVqNG0xUmpKcnN6ClNqdGt3c29tMFV3cEJ5Z0hlLzNCcDR4
WlN4Z2FmTXc2ZEdTS1JzRFRBSGoyRkpGV2N0Tmx1WTRqdnhSWDdDdVcKNTlRMzVKSUU4bStPZ1li
Z0xrR1FmRWRVeWhjUnFCMCtWUjJXUmxYNXNLVVprV2cxQWhnY0w3RmltTmxsM2YwNgp5ZS91emJy
YVVZSFg3eGMzdjVDSjJaNnd4Nk1waFp6aGh4dUJxTGNZSkViTjlmTnNldlRPWWtFUUlzR0M3Tldv
ClQyaHkzdWplWUJQajNjbzJOZDRpV085dHB5c0xaOGdLMTUvZE5qTUJUc3ByUys5UlBxZ3o1QnRG
bXdBUkFRQUIKelN4Q1pYSmxibVFnUkdVZ1UyTm9iM1YzWlhJZ1BHSmxjbVZ1WkVCa1pYTmphRzkx
ZDJWeUxtTnZMbnBoUHNMQgplQVFUQVFJQUlnVUNWWXFSUVFJYkF3WUxDUWdIQXdJR0ZRZ0NDUW9M
QkJZQ0F3RUNIZ0VDRjRBQUNna1EyMjdnCmNaT0FvT25YZGcvOUVGZFJyL1h0T1liQmVsdGIwc05I
YVNQN1M0dmtscWNBdE9udFRZVjN5TUZOdjlYQlhYdkYKU0thR2wwbTVMaGVOQWtJdS9ZYkFkR1h5
U3pOVWQ3V3NmeWIrMjNpcTVVS0d0K3dEK1JvY0xaWTA5NHVBS2NRUQpUWndKS1R3NHRLSWdONHFC
dE9hTmlKd0x1cnNOWllBUDdKSUpGUFFZNTVwYSt5ZWMzanhmVFgwYTdydWllY29zCm16YXZRMTgy
VitMZGV2Mmtvckd2WTFjejQzclA4eGlMMURqdGNCVW5laWdiajUrTjBaOFVsam5SNlFrU1J1YWoK
ZHNHQkFYSG1rT3NCVi9vOE04dkZXYThOODN1czFHa3k1SzU0eFFPYVZ5TlJWclI0RUlTdjh5MGkz
M3J3R1l2UApCRCtSS2FMYWN1S2I4KzhLTlZ1UTVNMHYrNHBHci9GZVhwUCtuUHpWRGZiWlpoWDFp
d2VRMDY5TEthOXJlZjhxCkV3NFZWdDdBdVlGU3dlSFZNSUNBMFpHeUtKNWhaejdMZEkwdkFGQU55
VXQwS29XZWVLNjl4aWs4cnZGNzVlbzQKZnovV0p0Zi9BZG5DdVlwNjBvYm94L3NKQTdLclpyV1FO
YkRjbEplZmlTWlY3dHVIaDdqTEpxUXVma201RDVnbwp3QUFvNWdyTS82V0FOSFZ3NWlvak0vVUc2
ZjArdEZaWGdGTXlrMkpaeTljMnM4VlFnSTJVenJiVThKc0N0ZERqCkJVU1RDNjRSN2tsdlY1Ymt1
MzFBbTNSUEMyOWwxaGZZKzNVTGc0dzhtbXBKMjhwcSsvejBvS0g4Q3d5aWN1RlAKRkJHOTVsbi83
dHRlNGlmV2tmek1MOE9oMmJwdUtFYjJQV1I0NHNRMVpxOCtJQWpTMlh3TDQ1N093VTBFVllxUgpR
UUVRQUtYYUwvaEhueXdzRnlVUVVHNVdxYm9xSHRWODNTNEc5aEpMQ25MOWhnU0J2Z2twbTRjNi85
Mmt6Lzh5CmdvRTRjUjNHSmZsZm40OHRUNFkvWDZzTkZiSXY5VkhpWVo4aW9YVUc0bHBhMFIyN3pk
MVZZT1pXUStvS3RjRnoKb1djVlViOHQrT1BoM2tuME5WQWxFRnlya0k5YWdUc0p1OFJ0alNpMEV6
Wi9iQ0xaTStFMU9UQnpZUzFuelZlcgp1NVVid1FWbXAzbUlzS2JSVTRRbnpZSElWVGNFeDF5SGxC
M1ZkZFd6M0pnenVsWlF4SDdRREVGaTVBaDhjcUVDCjJSZ2w2K2JkdVBqYnJBK2RwV2VaTGtvUGhH
d0xZcVM0YnJxN0ZBbmtMMjFSTGVGQzkvY203dTNaMnozd1o5QXkKZWt2bmtPNnhxdGlqcDB2Y0RD
V3kxbldiV0tpN2Y5K1NQWW5xTTNKVFBqWnlobk9CQ2pWTFhUcnlYQ3BhRGFCYgpnWGZRSlpMOWwx
bTRqVzBoQjNEdlU5eGQ2Zi8zdW1vODMzS1BnMm5XenpnZ0tRODREUUd3L0hYdkFSdDVtR0ZTCmQv
REtkMlliTHc5QjJKSlpqb2kzc2VGWlN6YVZKZ0FWZk9neUk0NHRnN3pJSlVUZDk2VzVpeEE3SEVP
TkV4cG0KQ0JrZ3ArMmswZEg1SU84c1lXd1o0c3lXQk5kZ1cxeGd2Qzc1dm94TmZTZGJmcGRhMG91
YU5xYVR0YjdzcnlVZApsTFZ3bExZZkV4NU9EeFFVY1VyNHRKUDhsR1I4dkEwemhGSEJhTEdCcjBa
SU16UU5TcS9jS3NrNnNESXI0Wms1ClZMT0VVN3R3SFRrZjQ3bXpWTExCQmZ6alJJc2hXRnJvNnBj
NDFBaGk5Y3ArQ3hLYkFCRUJBQUhDd1Y4RUdBRUMKQUFrRkFsV0trVUVDR3d3QUNna1EyMjdnY1pP
QW9PbXkzUkFBdGpNMGtPQjN1OTZ0S0pieGpERnlUTjZhTk9WLwo5WXk2V2doRjJITldvN0hzbk55
dnNRTkF1cHhWMndBTGF0UGVjUFgrL04vdWVGUUtyQTMvd3FVUTkwMkw0VXhWCnJMa1d5a2RZb09P
cGd4TUxkUXB6Z2NRT1RTV1BDdlAwVi9jVnNYY1dKaVZFRGg5VGp1SzBLc1loRm1XR2E2bmUKNHVS
MVY2VkJ5SUtaay9vRGthSVhCanJaU1ZUT1M2ZzZWRi9XaWhHKy9NL0MyZU94eEJZMzdqWm5xREpR
bjNxWApoWTJjVE4wbTlrTFFQdjJqUE9LcjAzUHIvbFdIV1Rpc1EzRkNWbG1ZUTBJSUcyRlpKSmNS
RGNELzhOOGpoMWVhCnpFQmowK1lSMitMUUxzVWN6bDBQSkM0TGV4eERTUVg4MlRlV21nUklXc3Mv
UTM2VUNIOVNyOFl6Sk9BSkxWWEYKNUJMQXgybFlVQWk4bmN0cjhIMmdML0RQOHlOT3hBZ05QSVhy
QjNnQk9XYTF4MmNROHNOeDMvVXVYZFIyNXQyYgo3eGpseFdlWmM5ejJnTzlyZUVKRWt6a21HVjhR
Sk1QSFAvejZRdTZIUVlqUFlyL3I0T1FSSGFpN1RMSkZsTFBNCkJLQTJGVWlZNzFaTUxZWHRXUms1
WG85SnVGL0F0dncwU3JxcFoyRE5PeUtLZmJzMTRNOS84RXkzUUFVTklTSXQKUDQyMlJNQUQxdzha
WGcxWlBqSEo4TGo3Qms3RTJGN0YzVlUwSXFCSVVsc1J5eUJvMUs3SDdRT1pwdmJFeERRSgpnMWx4
YlhhS1lrRFEwREdhb2FnT3pVYVo5ckxCdkpFNHo3QzBTZ3BjWFpaMHJuT3lkdm5GMGhCWG93djdX
YkYrCmk0WlB5REJjM242OHJxcz0KPTlTWGwKLS0tLS1FTkQgUEdQIFBVQkxJQyBLRVkgQkxPQ0st
LS0tLQ==
--deb16f07603ad3bd89f69cb99524eeae0fb2d4cea3b2880860cfc1e8793e--

--------912e4262715fca10c09f559a443f4328ca0453296feabf78d916df4bfcd258df
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsGpBAEBCABdBYJprkZKCRDbbuBxk4Cg6TUUAAAAAAAcABBzYWx0QG5vdGF0
aW9ucy5vcGVucGdwanMub3JnT+XIJ0gnfPvDkj8c+R5ddRYhBBKM1nGLSON6
q6UFAttu4HGTgKDpAABepw//YI427kB+ZYW+zUjJ5J/JGCfEEkIsC8GAPKYv
AIJSKmMdG+kHhL3+6Oh8Z5b2zyqwDe6ZQY4Jo/rvS8rOutFiXDU++cYwDXTP
9hrtxJ4kVkjdT0+7Fu0/ojEHTc3ZULJjLGYjTm+5qp41W/u5QOvQTySnHk1x
cVQGbpIVxoLUfD3o60tq7JEEX/8IXFZDWYe3lC6WAl4pSlAWNn65sXapVRB8
7hnXMTqjcBBysra8dOxwtdfBLzq5/iuEAtzMyd+wj0AXlEeNKNnSMOSo8kaZ
8FvbJ2C8Gi/6s4yp4SKz1PtQDrqt7GWWJva0jOa7jJ9dqROwule4punJ4FDc
ClqiGY+HqvBGVK4L+QABp8d+SuZI8oxx42T+lfVt8nAIljwbXSZHjPAmvjnK
aDPmLgd+j1vQ+TefcN/lpr/Ma96eBsQvGZLrhDXNHchs1IrCYQiPonr1rhM1
43faaiP4KnjeYzreCeK+J6FIk/ztzPFGVw9kaZ1K4efYl8hqlMTxeH1RFIVQ
cbuYWsl6ZR4LdJOs/AmHSxIQgtAt1G6Xwx1Zwqn2ogqImh8bFwYm+KxTH58t
RjwiBHSNhFCoSlc+ltMO9tmc+8OLXIHP+4akHat/0Qrwu0qJ0pvpxWfVId74
m1zns1t0C8LGeBkUP0efjl0MH1H6ZSumuRbFdOWevYJuHLQ=
=wBgb
-----END PGP SIGNATURE-----


--------912e4262715fca10c09f559a443f4328ca0453296feabf78d916df4bfcd258df--

