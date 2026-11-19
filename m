Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108596;
	b=XUBH3SytfQDUfrXmr/dERluCESbMhO9BOqTxlPsNJ7FRQZBeiAuAKO7M9W/jeQDDbYFV
	 FfyDuvKwDhiAW331x54GpiTjUK6HSpKKu6IhxCBqtw4xvMW/CjL3DH6fRIBM/0Z7CDb5+
	 wYp1hSzj3CE1f8x7XC9q2KsLaS/oOPEBqcy5NJrvtwog5lBqgy/J8m1NeW7q6FIuwhMez
	 s55SfrKKBc4/CDSJ/OSD8CRCtflNqcexG9wawHLInYleDJ/J/7ElpQY9Q1vK+XIBsIJgA
	 4m9SQUzv4TIllg6EnRrMUyKg440jTk2BfIabOl6s6BoDxITGYt+zv+Nigsd//6jAl/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108596;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1v2Iz0UuewLZrIl+sD4//Z5OhsDcbvMJk6y+VP9T0rc=;
	b=obI0DGy5K5dZYXJzHiGaCEFSU3DrqH3LTDR5ALRmV/5MInqNSsFl0OVbWe/+13bcngj8
	 TmNAHHmcUBvxHXhTuGHmDJVVWXlmUkXDFBQOiCbt2ltGGId2K+5vcIWgsxFGs8sL/vWjN
	 if1hj0vMpwXv5X74A48f9dcvRVnagFyheOzmbzQ2I362c8Jnrz68qXbtK8D4g8GgJyEIT
	 axr/3ygB8kWtWKJqdk+9QNwhP1ZGxEGaE3W3MVrFMy4FebTloY4HT256qO769ywrOjNtL
	 Zfqm88oh8DPuNjmh7+hckjsDwJA1TNzdpL53F9OZBlLGh6NiZhdFIzprGK91/MjwB2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bhEqZpQW;
	arc=none smtp.remote-ip=209.85.221.174
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D75606A32C
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 17:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07D75606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bhEqZpQW
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5ee27c9eec0so812849e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 09:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795108595; x=1795713395; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1v2Iz0UuewLZrIl+sD4//Z5OhsDcbvMJk6y+VP9T0rc=;
        b=bhEqZpQWTMJz6y2u1KPD9YQLwYrEgJ9UNOHErShOQUUG+ZmXqOqPLbGETEaIDK/qZK
         AGwZI2thumV5tNNKI36yJBfRf6PHn0Z5Lj8YbHrC3fEPBc1XJHJfEakKzbca2qz/zGg4
         QA8u7IwacDLcbzu4FCnN/uuiwReD8k8ekG6BlhNvYCtVNjUiXuaXD3ONDjNF9QK8inHm
         wIdMgGiJjpgrFXY9UkrwsfaBt2XGsrpfP7P63JUnGOZPHmnwspbC7902H1rU+50Lc4Bf
         FYFIA+lpCObsyDSPTj+Cu9anN0ZGyG8ERxXTP3gLoYN5mDEll6h2Tpgit3kYqiQ1zmjB
         7oiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795108595; x=1795713395;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1v2Iz0UuewLZrIl+sD4//Z5OhsDcbvMJk6y+VP9T0rc=;
        b=MlGgEbgm3ooyQ9Fz9GCgmBHw0hK9OiU3+3Sx5KOFMcdKG6QKv630TAYLGJ8K3Rdlfs
         RT6I4xLE2XVutMxlyAkTjbcOK/JkSbsD+kOPAMyOW3tEqkUKN3XBDVOGl6mQLojtnfpU
         seBzTg+ANJ80psBUtnvBXMnYY+43yUqTmZZqXuLNEoBoQ3Gt7q/vTy7h2+4BWb54nkXa
         uqbQA+TpUPWiRJ2DCTUgg1wYYyt+iqBqW2fS0cG3I5LDzCJiLFsRwCGc4hI52iTmQURb
         GEpALmdc1Ou1twgx43+FCjjUGJMqPkq1KnmwiTQ3DHcBiKjnh5xBrIcLnsdbNMmjfHwH
         9NvQ==
X-Gm-Message-State: APuU4Z9K5cASCaqexZOIYGyerjv95ungkIxJ+3a3hf8nqOyCdhlmSi11
	ts7wMOlDLk5fmXqxWlGpVJJf6MkYWbs+sMd/iYQjRg5kBeYfbB1lzaOC22A87vJ6Yhw=
X-Gm-Gg: AYBFou2TXn3xPBVaeBby8g7DSlu+OwHShGCCzNVDSvQn7/NtPKC2/hNa/jSa2jGzhAP
	A43/6ywy+xw+P3ows+C9K1NkPvEkRLDWVMEsWH9zpHIQki4Bpw9pCeONYtPyfNlbXCYn+hBUMBq
	Az1/fDhhqRuHYVxR9GLegEIzBlXCbT86Jd5ugzet0jNMUm9PLRMRUE8b3RKelc2HjwGVlxmK+F6
	THC+8vDX68tktTZp37rqyymfEaAUZwZHqoUGshLouYi93bibtpCekIweQWN7BX73gKH29wCrkjp
	ku1RZN8eB2abq2tEPAqQ5AHd6/szJ39hQEVlpR4/Xw8ucgiHScdIZaxqB/mNGjbBWFMUcmiAZSv
	0UikCnIaoxfkc8Hp12L5PYBmMUcKoQhCrODgDoywVjuWqZuI2OBXdX4Wu5KkFyjliwWXDVwv1CM
	8ai6nwNDq/JfIJtPNNl4AfwxANIqt258ZUo/zH2ZyNSy779nXd5rGBR04Akq6I+zVNRpziYXV/l
	diuz6ppz9dVsmONLBCWOvUV9+D1ofQTOFWzezSgimksn2cF7hFE2EgRBosfVgioqk53pegW1WUR
	H0bZWVW8WByQFl2F44kHsQHQ816oCWBr8ofD259paLVHDFRzUFJi448sqluVo8Bj5+O/4nmQP0O
	UgCWWbDVsEVE/lrrZQS7d/cYyqGIkvwvXK2PqOtqC2GIanmf8N3fLjVAhDVg4o3AUjlrkWCTfIZ
	GaH9M=
X-Received: by 2002:a05:6122:46a7:b0:5ec:e522:70d9 with SMTP id 71dfb90a1353d-5ee8af2f1camr300792e0c.16.1795108594778;
        Thu, 19 Nov 2026 09:16:34 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5a8fd3sm131881e0c.8.2026.11.19.09.16.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:16:34 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 08/16] profiles/ranging: Let StartMeasurement() pick the Initiator for Both
Date: Thu, 19 Nov 2026 12:16:16 -0500
Message-ID: <20261119171625.1014004-9-luiz.dentz@gmail.com>
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

