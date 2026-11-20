Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193720;
	b=s0wR2O1EGFAwpopgvjjJi419LcnGgpxLcPGfuFFUrM/I4EsGXTQBTBRcL4+a6nELz+bH
	 Kl4h7kahliIG/5lxqqs4l3ijeOEQR1HxvlAj/TVbzljCN8bJ9tMKXw54YhWQ97ON/CGWa
	 V+0gipraQllzW9VwV3D0Dbnmft/XxKuZK4QY4pwEAQHt3zlKhFNojFl2rnBxlgtkoZGUY
	 koQGsJ0htm7wUM7pXTc/yKippCkLAf7dJlx4tK8TZlVzCvPtIGad8HjCTeTV/qXiqOicQ
	 VeV8h9J9ftJ8Cz6Q4mx497FT2wgLzJQjgnIOzQPPS67VuAKW+7uLrobhpza+MPOvqEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193720;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1v2Iz0UuewLZrIl+sD4//Z5OhsDcbvMJk6y+VP9T0rc=;
	b=rVV3+uMg8o0aqssYw9IvYLEKtbWZxGf104vtO46G9fqlCmNGv6+hqGj54SNXcgABg6w9
	 q7/dZK9wwMtU1XxNwHfmbSRspYhNI/9KvhOJtClBK7Al1Mt1CmfBJYmc5poT/PRWYuC9A
	 vSNyEbdAE4ND9xJ7fG6ZqmKNHP49h4qs50el4eMHx2Tfbesy3qaEOtZUbkwAatP4io+pb
	 RvjDPIasf+vDDdM2chwdz+L4C67rfTkDRS3pUVy1b8OSjZ+Cy0EJIhX9036LuH/rR+l9j
	 HdewwDTEW65wZYiB+mCPHm4y4AeiiR0yNq7R5+I6Z5G/vbZXmDaMx7kVvG+4NLR3Nog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CrG14wvX;
	arc=none smtp.remote-ip=209.85.217.50
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5A760A2614
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 16:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C5A760A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CrG14wvX
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7d2eba2b74aso645072137.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 08:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795193719; x=1795798519; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1v2Iz0UuewLZrIl+sD4//Z5OhsDcbvMJk6y+VP9T0rc=;
        b=CrG14wvXhbpbNL9hsZIGJeqf8Kr9RaBa6iG5X+48KyqEMAfrWj5hAy6KOOXgUZEhmI
         D9qS8iuURO1GhwKrpzZBUGqu0+Gkk+vkG9Zypm/nWwIl3YCU+323IYTMU5hiHoST323q
         yyM1ejYiRjKyGHd6GnxWFcekrf9djaJi2bBypWDTJWBaZQ3inkHvXPdSLigr5cokInbv
         AhPAY/td6PKlHrQ91kAzFQT/C91ivZe7kOZfiCLGcudGc1a8Ca565YsD+uObhVGBKHB3
         8KxqlQ+AICkaWtS2xeU61CuZh2Y9NyY1OuFCZFHsVR9P59dnkz6TsMhBy+jsOQcaqyRH
         sw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193719; x=1795798519;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1v2Iz0UuewLZrIl+sD4//Z5OhsDcbvMJk6y+VP9T0rc=;
        b=F0GB4vZ8ge+FP+IAj4c3Ow41aB9SxUiBjtBYvRLJSmzgWAil8PZu4VAsxdo6X3P2B7
         V8MDOr1mKNTIVYJNbco14Dy2XmJ72u/Y8gNcyPQX4YPxipdNLDZ7LwdakF6LLZbkdsaI
         frHxOVuJsT88oFwsPXEOAZ71c5Y797m7O4g74Bf4iIhFjumBbv8obbfCwN9o6mwAPTVd
         uWyXo2IBGhfnV6k7S78yIwv+U280wU+MRpsUxRd/RZ8BXN3gta7pdD7sZU9lbtRF2oiI
         XU37oaXno/doljV6pZ3c9Q7TplqDAhbVkDrvIOj7u991qgbhkLENsAeJ8WibFEDP/St1
         i/8g==
X-Gm-Message-State: APuU4Z/XJNU4+UA3g4AFwnb9ec6uUgHmrD0MtoevmMSihZioiEJJoqsB
	BOvAvc2zS9odt6g0ObPWrKKyzTgoL3T3s3hynCGiYreF4iAPjbz1woquXWrJLZYT
X-Gm-Gg: AZFdTZfIwRtbU7TFKX+7dQgRoriuQG58yx3/0DoIT4UP8GDhGVSLJ6/idEk31JVDwL1
	jvGEPSHCjudEAxMKAIoPcJ99wfmcUAeJ7zLxCELdVDSGii9s3HSchgT/XYtNGa3FiS4d/SzJ60b
	p2nfZE+ZN5JLQy626OsPPNa0rOavvdHqo9eS3+pXyIi0BcxM82455rXtvz0neFQVppl9Fdymmgo
	z6XoBjTvy4mt2SafX+wv8yI8rzRsnUFjLE7BjJwpfmEQ2hu3jXhETXDZOz5Lp33vTaoPKG5JoWb
	pJmYrKl/dF3oLQmqMZErCslg0GrCgkHMK+WFVtRoIM8ZkcIzI/0ODn4QZG5G4oXuxEDWCZS8oCm
	Vexe1qiDT82LCdi6wqfXT+euO3q2PSNL16ZHLYPvrHPUaZVErTsQGTgocW818zyqrgUUPlrAOSQ
	ajHcyaBHWFzUJpOHdFHbnZ5DgUjikr+Lkigtb5SM8MBikrgJRiI7Mo9o2OM1rlj3uQziS03p0RS
	DdqUJ3zHLukTcrC6tW2k7cW3p6rboIJzsBF7eeP4gh1qDeB3Uf6hbxS274XBnZzlhKVU6o/1ooE
	ws9ST7CAzK0moVKhJ/3o3Fbn8t8c4h0HubRFj3+eEAihl1w3VE9vEVrx3yUMW6Xnk0jzw6BIswb
	vPlAtS8Ufc2TUEsCVEnvXZRKAxJddARiJlq6u34pqHQGcbEkYbcpCFNQzbTsVUW9F+iKAwbL/yA
	kryZSZcM6GChpA3uuaCJj8r7YB
X-Received: by 2002:a05:6102:6489:20b0:7cc:9a7:7b83 with SMTP id ada2fe7eead31-7d7393ff595mr1527322137.15.1795193719374;
        Fri, 20 Nov 2026 08:55:19 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6df8a28dsm3486193241.4.2026.11.20.08.55.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:55:19 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 08/18] profiles/ranging: Let StartMeasurement() pick the Initiator for Both
Date: Fri, 20 Nov 2026 11:54:58 -0500
Message-ID: <20261120165510.1858959-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120165510.1858959-1-luiz.dentz@gmail.com>
References: <20261120165510.1858959-1-luiz.dentz@gmail.com>
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

Role_Enable is a bitmask of the CS roles the Host permits, and the CS
roles are independent of the GAP roles. When Role_Enable permitted both
roles, the setup code let the GAP role decide, so a Peripheral that
called StartMeasurement() still waited as Reflector and took the
Initiator role only when Role_Enable permitted nothing else.

The setup phase only runs from StartMeasurement(), so the local Host is
always the one asking to measure: take the Initiator role whenever
Role_Enable permits it.

Both sides may now ask for a configuration at the same time. The
collision rules let the Central's request complete and reject the
Peripheral's with LL Procedure Collision (Core v6.2 Vol 6 Part B 5.1.25
and 5.3). Ignore that rejection instead of removing the config ID, which
could remove the configuration the Central has just created.

The Config Complete role check compared Role_Enable with the two
removed helpers. Check the reported role against the Role_Enable bits
instead, which accepts the same roles for every valid Role_Enable.

Assisted-by: Claude:claude-opus-5-5
---
 profiles/ranging/rap_hci.c | 59 +++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 23 deletions(-)

diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index d0610a22c160..103431847538 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -348,17 +348,30 @@ static enum cs_state cs_get_current_state(struct cs_state_machine *sm)
 	return sm ? sm->current_state : CS_STATE_UNSPECIFIED;
 }
 
-static bool is_initiator_role(const struct cs_state_machine *sm)
+/* Role_Enable is a bitmask of the CS roles the Host permits for this link
+ * (Core v6.2 Vol 4 Part E 7.8.134), not a selector for one of them.
+ */
+#define CS_ROLE_ENABLE_INITIATOR	0x01
+#define CS_ROLE_ENABLE_REFLECTOR	0x02
+
+/* Whether Role_Enable permits the CS role (CS_INITIATOR or CS_REFLECTOR)
+ * that LE CS Config Complete reports for the local Controller.
+ */
+static bool cs_role_permitted(const struct cs_state_machine *sm, uint8_t role)
 {
-	return sm->role_enable == 0x01;
+	if (role == CS_INITIATOR)
+		return sm->role_enable & CS_ROLE_ENABLE_INITIATOR;
+
+	return sm->role_enable & CS_ROLE_ENABLE_REFLECTOR;
 }
 
-/* For role_enable=0x03 (Both), Central acts as Initiator and Peripheral as
- * Reflector — the link layer topology determines the CS role assignment.
+/* The setup phase only runs from StartMeasurement(), that is when the local
+ * Host asked to measure this peer, so take the Initiator role whenever
+ * Role_Enable permits it. The CS roles are independent of the GAP roles.
  */
-static bool is_both_role(const struct cs_state_machine *sm)
+static bool cs_local_is_initiator(const struct cs_state_machine *sm)
 {
-	return sm->role_enable == 0x03;
+	return sm->role_enable & CS_ROLE_ENABLE_INITIATOR;
 }
 
 /* Helper function to send read remote capabilities for all connections */
@@ -503,7 +516,6 @@ static void rap_def_settings_done_cb(const void *data, uint8_t size,
 {
 	const struct bt_hci_rsp_le_cs_set_def_settings *rp;
 	struct cs_state_machine *sm = user_data;
-	struct rap_conn_mapping *m;
 
 	if (!sm || !data || size < sizeof(*rp))
 		return;
@@ -521,22 +533,13 @@ static void rap_def_settings_done_cb(const void *data, uint8_t size,
 	if (rp->status == 0) {
 		cs_set_state(sm, CS_STATE_WAIT_CONFIG_CMPLT);
 
-		/* Send CS Create Config if we are (or will act as) Initiator.
-		 * For role_enable=Both, Central acts as Initiator.
+		/* Only the Initiator creates the config; the Reflector waits
+		 * for its own CS Config Complete.
 		 */
-		if (is_initiator_role(sm)) {
+		if (cs_local_is_initiator(sm))
 			rap_send_hci_cs_create_config_command(sm, rp->handle);
-		} else if (is_both_role(sm)) {
-			m = find_mapping_by_handle(sm, rp->handle);
-
-			if (m && m->is_central)
-				rap_send_hci_cs_create_config_command(sm,
-								rp->handle);
-			else
-				DBG("Both role: Wait for CS Config Cmpl");
-		} else {
+		else
 			DBG("Reflector role: Waiting for CS Config Completed");
-		}
 	} else {
 		/* Error - transition to hold */
 		error("CS Set default setting failed with status 0x%02X",
@@ -897,6 +900,18 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 
 	DBG("status=0x%02X, handle=0x%04X", evt->status, evt->handle);
 
+	/* Both sides asked for a configuration at the same time. The Central
+	 * rejects the Peripheral's request with LL Procedure Collision (0x23)
+	 * and completes its own, which the Peripheral handles instead (Core
+	 * v6.2 Vol 6 Part B 5.3). That configuration arrives in an event of
+	 * its own, so there is nothing to undo here: removing the config ID
+	 * could remove the one the Central has just created.
+	 */
+	if (evt->status == 0x23) {
+		DBG("Config collided with the peer's, using the peer's");
+		return;
+	}
+
 	/* Check status */
 	if (evt->status != 0) {
 		if (evt->action != 0x00) {
@@ -942,9 +957,7 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 	 * (CS_INITIATOR=0x00, CS_REFLECTOR=0x01)
 	 * which is different from the role_enable value sent in HCI command
 	 */
-	if ((is_initiator_role(sm) && rap_ev.role != CS_INITIATOR) ||
-	    (!is_initiator_role(sm) && !is_both_role(sm) &&
-	     rap_ev.role != CS_REFLECTOR)) {
+	if (!cs_role_permitted(sm, rap_ev.role)) {
 		error("CS Config role 0x%02X doesn't match role enable 0x%02X",
 			rap_ev.role, sm->role_enable);
 		cs_set_state(sm, CS_STATE_HOLD);
-- 
2.56.0

