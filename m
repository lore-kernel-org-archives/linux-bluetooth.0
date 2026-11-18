Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031936;
	b=2kLLpuB5o/627okl78cTRrNF+Bs6L1+x9oJT4lwOqDOybUy/qg/dCR5yloOIBvf9CMKw
	 NkB8o9E2R8ivONyaHfi+gIh7od1v+RcDVn5GDm0y8s60iZX55r1WPOBsGBhPnJ5S++HAm
	 aTU45WL8F6JzV4bcGMujyygjXu83eytvm7f1VTCg4uI7GwTPV7WgJXoNS/XOrJyG0Jmc2
	 zIVlFUQscoC/YoBYnRjq4bQXvhHnpF+Xi/cMRA8wgtXzA5S1JTR7CeNYdqpvYpNu4N76d
	 dely011Lin3vlWiax9vmwmzL7VB9/oar3/csXee2aviUSQoH+JHlsQ/fhyXzlPvji2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031936;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+ecXziPPNhfX7H/xqvM6Tt8kq66RjlQ/6NioJpkcfhE=;
	b=gZSkM6sD3jLdqeHUTmswP/M2eTreNoCyIMrTvjw/vL+wcxMZ19ZVHG5m9JECC0YQ2gYg
	 dRxFYfDQqbOKnqqicRiMb2fO1P7OXU/KeL1l8nSdY6bijpz6AmnbUyKPmSK8i5/d06HsS
	 P118/VSRecGGaOeQbOisiolebKl1EIP9m/SswDWVNjHS/DOHI6oN4SnYBsiPOPDsTAkAs
	 UZIPcE2eUH4Ip/MzsPPFYFPG1HqQMf9HssZ3klE5/chH16C66yk5msYrgthR4xMV+V+GF
	 gsFWkcI/kiU4RaWIOf9tdcBFhEBfO7SS2GMjomAC37BbTefSoHAb1xVd7fZXqofxjDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iUURLX7y;
	arc=none smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2422A60A261B
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:58:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2422A60A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iUURLX7y
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7a6e560f580so951074137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 11:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795031935; x=1795636735; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+ecXziPPNhfX7H/xqvM6Tt8kq66RjlQ/6NioJpkcfhE=;
        b=iUURLX7yWSQbBgDsaOhTk4NhdE9ZtNXaPEMhBkQ/2CQnnBl45ycN2u8dWImlxM/DQV
         rxsDiAwZo6CnpBZUQDzO1n4TKjmvX0Cxr6GUnIyzx+BZbQe0FfYra7JpRNgdMMMFXYaW
         1L1RC1djgKVjX/Jh24mV6w2W69AhN2lWVeo7ywGDhqwbK5oOh5Xaj2iXHXypQFvmiQkf
         lbJBTOYy2FuJPxx0QmPf0FgT9Gq8+DyD4C/1xujT359Fr47YEpUHhhGDIbf15RD4Nxd/
         cXWRbsSNlfB7wOS0ZJC1EA1/Q7/89wd89E6Xcl2NpoYe5zIaCEztXefDr9zNs1N/pnOo
         /YiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795031935; x=1795636735;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ecXziPPNhfX7H/xqvM6Tt8kq66RjlQ/6NioJpkcfhE=;
        b=H6fdK1mVFFU6pHbyEl/z9lBDaXvBTVBkljxv0aTkotfIQPGhtyQUJQ26TAulnDKzHD
         Znin6PVCmkosBE7zRg+tFJKgmWJAjltiTqi78AemHVd+8Xl1eGrljGDQhM1zqxNBIW9/
         Tc7qTe+Q7zbURhc1BYAsOPwkJ91BPh13mCekFQqxoo5NgNfFsG9++daxiIb00SAiU2xP
         +bYI3zSeJdV2hBo/6NUv9ehfn/KxFuuAKWsbHEhnv4Q2u3uafcqBus+Ryye30jHQdrLn
         PsUfnetTxFDtV3DvM2GdJsbIPtPaEU8JW0ZnLWFPfl8C3FB5MLZB4xs9WG25ZyqsMj8Q
         15Rg==
X-Gm-Message-State: APuU4Z+eHQcje1lk351iVrDBCvl5098DtzS2lqpOTSQOlx4iJ4SxclJQ
	HplfFbKofFYAI1Tq2DochneD/KTvPD+Ebhmyem7FQ6mFukPPhNLttFsh8rpf9q/G
X-Gm-Gg: AYBFou2/1nKZQ6SchEXRZ4JE6TY50V1nV3y0SlPeaf9lmHKGxOe4U0Gq3SuW+3ioVUw
	WZgeU/x2xeVQ4Rw308Jn6/czsa604xG0vlYeUW3Bg4ROy7s612kdoND7OkMuToSAKslxZdBv7wW
	PQz2qLHD4i5mCtnFyXIGmuIZNz9k1MxAn4ft1DY8+s2WK9iEYxEazdw4jGPNHkjWdnoH+SMGJ7U
	s+aRHGSj4hLR4qxGkLUeCykgH+paC2692Qt98T5QLpMLw8yVzhTv775BPp/poThj4QuSjTzVzvi
	s80ChBlZg77ZgOWhVX6g3FeDq/QyxWWvjRafgaPFt/7gy7GWMNBKGuOyAizzvcwv0+xhGzeMfpo
	GuBl0u8P/tbn8Ww6lcx8fKDi5t2LQobmrCoKHCB1m9+8Jg1sn0XINbPJJXkedBnPvqlOdNIdRbV
	zTcJ9n/CmRqAH4Qzo1Q/kfjdfkLGUUmBuCmj73xS0vLWiBlZm+ajBp/kPkV0TLqXvxB6tsqz6A8
	euFkQLifIXRadaAIyTllUjkrx00zjL61u+f/LCEIoYel/j/ryf1xovUbpRm0K/kpnRi27i4pJR7
	hEUM6jy9bTGhC6jUtwXu1ZvpbAPHxQ3rKLbNlutShvpZ59mWSFCvQUrFQtYAOOesESAG3I7Y2Sr
	Q9fVObD3iDsa5JM8QpBaZIcoPiHl5rnCSIFOw1Ck18D/dtJf1kUqpxKNgAV0RHH2plbKWC3vYZT
	nxPYg=
X-Received: by 2002:a05:6102:6046:b0:7d2:7be1:271f with SMTP id ada2fe7eead31-7d6ba4a800dmr1527147137.31.1795031935034;
        Wed, 18 Nov 2026 11:58:55 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b91e87f4sm2685571137.7.2026.11.18.11.58.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:58:54 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 08/16] profiles/ranging: Let StartMeasurement() pick the Initiator for Both
Date: Wed, 18 Nov 2026 14:58:36 -0500
Message-ID: <20261118195846.393710-9-luiz.dentz@gmail.com>
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
index 0eea018ccc29..f23e89cfeb3c 100644
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
@@ -889,6 +892,18 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 
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
@@ -934,9 +949,7 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
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

