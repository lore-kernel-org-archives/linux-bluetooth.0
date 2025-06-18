Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E9E18027
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 02:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750214398; cv=none; b=bZ3KSQSgmAlG/ZXjv4ELgH2NjCHa5c71STJ3aoq26QcGs8x9COJcRkE/uw7fLrE2JuM9jrb9TKXFqwPIqjKWKB9w/ban0O8tBKornNlzhE7q83s3gq0PS2dl6P553uCo9qXorzYvQd/xAywNF4UtSY2jwLVh9+lo5vl/lqq2iVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750214398; c=relaxed/simple;
	bh=3N9Wdul/yia9X09bArat8rd7bw0uRgeYfhnCYJFURcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AnVVuu8RYNs1APIPiJaKtfZKZ9KMPjR+hmgC3ADJALVAmHvT405jd9101WOqVzgjJBu3xhwzBSS8G1Q44vOfL4rI3KTHz9IwZDgXN+HkkczUpcIeMSA5YHOpKk4xvM77HWZslU+PxtdAUrgs97WnNERTpGPXKInxTJ/u5cBA9dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3QZrZ4y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3QZrZ4y"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE386C4CEE3;
	Wed, 18 Jun 2025 02:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750214397;
	bh=3N9Wdul/yia9X09bArat8rd7bw0uRgeYfhnCYJFURcY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=t3QZrZ4y7qwxdSCqXnpLTzeQdrxIJHeRcv9S83zT1v/3bZC9Tw4hcrcZea1Gmxn6n
	 aEJ0n+N3QRY8JdQJpGIwrPj7XTjZzzXN4yxi7QUPem0wnuILBL/U2G+HeDrSi75dAl
	 eBxiO4H1NIDKBuJFr6+QqGmhhDvMKWIkbtE9SPblWoCFlNOEmq6qU4XHmJBb3XnOt6
	 9VHuh1IvXKjAFrNbSQV0wxTOWUnXnyGG8ktXs8hbK5cN3Lm3a1z4M8dtWlzG4kQywd
	 Pf8brb/91mkugaExeY1xsNPX7kqK5WZP4v9adYvNuItyMp3cd88swZ794zFnzM2uIg
	 xyJsw+Jm2JNlg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38C5C71155;
	Wed, 18 Jun 2025 02:39:57 +0000 (UTC)
From: Ye He via B4 Relay <devnull+ye.he.amlogic.com@kernel.org>
Date: Wed, 18 Jun 2025 10:39:52 +0800
Subject: [PATCH bluez] device: Add bearer info to Connected/Disconnected
 signals
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-device-bearer-level-conn-state-v1-1-dca5df09c0bd@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAPcmUmgC/x2NzQqDMBAGX0X23AVNUdK+ivSQn6+6EKJsVErFd
 2/ocWCYOalABYWezUmKQ4osuUJ3ayjMLk9giZXJtKZvh85yrFIAeziFcsKBxGHJmcvmNvAd5hH
 7wUdnLdXIqnjL5z8YyacdX3pd1w86B02AdwAAAA==
X-Change-ID: 20250618-device-bearer-level-conn-state-3e29d56bda88
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Ye He <ye.he@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750214394; l=5408;
 i=ye.he@amlogic.com; s=20250225; h=from:subject:message-id;
 bh=5NJLCTJGyuiY5wQYw++2OOdOnlJ+lHfP9kxxF+ljbvU=;
 b=IpMRwyN717ur9af6m+i0N3mhR4xIgrG1AxKb5fzgSXW/iCaFmQ65sEpYsocX4dBXstZT5+HRv
 OtwoXizfR/BC/XFEX6y7+hOjRKfBgUGDCNhBYpxU62KolohNUe9EGpl
X-Developer-Key: i=ye.he@amlogic.com; a=ed25519;
 pk=hiK/p0mkXYSkX8Ooa496DfgjnbtdcyXSPFwK2LN49CE=
X-Endpoint-Received: by B4 Relay for ye.he@amlogic.com/20250225 with
 auth_id=348
X-Original-From: Ye He <ye.he@amlogic.com>
Reply-To: ye.he@amlogic.com

From: Ye He <ye.he@amlogic.com>

This patch add a new Connected(string bearer) signal to indicate which transport
(LE or BR/EDR) has connected. Also extend the Disconnected signal to include
a bearer argument.

This allows applications to distinguish transport-specific connection
events in dual-mode scenarios.

Fixes: https://github.com/bluez/bluez/issues/1350

Signed-off-by: Ye He <ye.he@amlogic.com>
---
 doc/org.bluez.Device.rst | 33 ++++++++++++++++++++++++++++++++-
 src/device.c             | 34 ++++++++++++++++++++++++++--------
 2 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
index 646e2c77ec2ddcbf7e6897336165d228c349fe00..1022402d95a1cd34dea88103ba66fb06f3007de7 100644
--- a/doc/org.bluez.Device.rst
+++ b/doc/org.bluez.Device.rst
@@ -157,7 +157,26 @@ Possible errors:
 Signals
 -------
 
-void Disconnected(string reason, string message)
+void Connected(string bearer)
+````````````````````````````````````````````````
+
+This signal is emitted when a device establishes a connection, indicating the
+bearer (transport type) over which the connection occurred.
+
+Client applications may use this signal to take actions such as stopping discovery
+or advertising, depending on their internal policy.
+
+Possible bearer:
+
+:"le":
+
+	LE transport is cconnected.
+
+:"bredr":
+
+	BR/EDR transport is connected.
+
+void Disconnected(string reason, string message, string bearer)
 ````````````````````````````````````````````````
 
 This signal is launched when a device is disconnected, with the reason of the
@@ -208,6 +227,18 @@ Possible reasons:
 
 	Connection terminated by local host for suspend.
 
+The additional 'bearer' field indicates which transport was disconnected.
+
+Possible bearer:
+
+:"le":
+
+	LE transport is disconnected.
+
+:"bredr":
+
+	BR/EDR transport is disconnected.
+
 Properties
 ----------
 
diff --git a/src/device.c b/src/device.c
index 902c4aa44d21eb89076eff3a47ffa727420967a8..ae6196eb2e5b6eca10a8e1c3360b85023dcddec2 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3491,8 +3491,10 @@ static const GDBusMethodTable device_methods[] = {
 };
 
 static const GDBusSignalTable device_signals[] = {
+	{ GDBUS_SIGNAL("Connected",
+			GDBUS_ARGS({ "bearer", "s" })) },
 	{ GDBUS_SIGNAL("Disconnected",
-			GDBUS_ARGS({ "name", "s" }, { "message", "s" })) },
+			GDBUS_ARGS({ "name", "s" }, { "message", "s" }, { "bearer", "s" })) },
 	{ }
 };
 
@@ -3676,6 +3678,7 @@ void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type,
 							uint32_t flags)
 {
 	struct bearer_state *state = get_state(dev, bdaddr_type);
+	const char *bearer;
 
 	device_update_last_seen(dev, bdaddr_type, true);
 	device_update_last_used(dev, bdaddr_type);
@@ -3691,14 +3694,22 @@ void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type,
 	dev->conn_bdaddr_type = dev->bdaddr_type;
 
 	/* If this is the first connection over this bearer */
-	if (bdaddr_type == BDADDR_BREDR)
+	if (bdaddr_type == BDADDR_BREDR) {
 		device_set_bredr_support(dev);
-	else
+		bearer = "bredr";
+	} else {
 		device_set_le_support(dev, bdaddr_type);
+		bearer = "le";
+	}
 
 	state->connected = true;
 	state->initiator = flags & BIT(3);
 
+	g_dbus_emit_signal(dbus_conn, dev->path, DEVICE_INTERFACE,
+				"Connected",
+				DBUS_TYPE_STRING, &bearer,
+				DBUS_TYPE_INVALID);
+
 	if (dev->le_state.connected && dev->bredr_state.connected)
 		return;
 
@@ -3747,7 +3758,7 @@ static void set_temporary_timer(struct btd_device *dev, unsigned int timeout)
 								dev, NULL);
 }
 
-static void device_disconnected(struct btd_device *device, uint8_t reason)
+static void device_disconnected(struct btd_device *device, uint8_t reason, const char *bearer)
 {
 	const char *name;
 	const char *message;
@@ -3787,6 +3798,7 @@ static void device_disconnected(struct btd_device *device, uint8_t reason)
 						"Disconnected",
 						DBUS_TYPE_STRING, &name,
 						DBUS_TYPE_STRING, &message,
+						DBUS_TYPE_STRING, &bearer,
 						DBUS_TYPE_INVALID);
 }
 
@@ -3798,10 +3810,16 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
 	DBusMessage *reply;
 	bool remove_device = false;
 	bool paired_status_updated = false;
+	const char *bearer;
 
 	if (!state->connected)
 		return;
 
+	if (bdaddr_type == BDADDR_BREDR)
+		bearer = "bredr";
+	else
+		bearer = "le";
+
 	state->connected = false;
 	state->initiator = false;
 	device->general_connect = FALSE;
@@ -3854,15 +3872,15 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
 						DEVICE_INTERFACE,
 						"Paired");
 
-	if (device->bredr_state.connected || device->le_state.connected)
-		return;
-
 	device_update_last_seen(device, bdaddr_type, true);
 
 	g_slist_free_full(device->eir_uuids, g_free);
 	device->eir_uuids = NULL;
 
-	device_disconnected(device, reason);
+	device_disconnected(device, reason, bearer);
+
+	if (device->bredr_state.connected || device->le_state.connected)
+		return;
 
 	g_dbus_emit_property_changed(dbus_conn, device->path,
 						DEVICE_INTERFACE, "Connected");

---
base-commit: dc8db3601001de9a085da063e0c5e456074b8963
change-id: 20250618-device-bearer-level-conn-state-3e29d56bda88

Best regards,
-- 
Ye He <ye.he@amlogic.com>


