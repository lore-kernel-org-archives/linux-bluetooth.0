Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795456295;
	b=wVCwWs+M7E1gQpT00tRr/hiA1vfOCZCZWku/SKu9tdhA3gTFp6KNeBZkmXjuf2AtehrK
	 1shdJUQqJzlQTH/Y3ATSxDCRFaMdcQ2ZZtqga7qgBd3r6ZHWdgPJKyFePy/YH0YF4xLhK
	 d8kQKATuscnygTWSyRDx7tO5tHwAvjVyk1qdVryIVYZB9tb0pbujOQMkTSrkLq1HUDOlj
	 aT6dORTuBdnOvBhZbKh9SwavC7TNKLYDXg0bmByyxvbaJkp2OOY28C6eOammj7RU0Pjbu
	 FasXwsJVz+uP19M5Z4IdDqaBLoHqCUjqRlf6Rx26UNEEeBakJDRND8Kg7jyrsfVhxeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456295;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1v2Iz0UuewLZrIl+sD4//Z5OhsDcbvMJk6y+VP9T0rc=;
	b=luj9iHNWYCYOZUWgut6EKb62kBsrczbKmz6cPcXlLCc8FbcLe1DwQl1PfYPT9lTqLPKJ
	 K+JBUq3BcwFGCe+uFLxA44szIYDCv/oTMmTSZ/yHs8SRTUoFIA1rDNtO5Sm2JlOrWXUM5
	 7fYp6TckYclobYSRLd67dlAeS6QfKseGzNgggTVHka/fZpV3QdDI0bjvt/L0OgyvOc1Mp
	 Gt0aMEBbD7HmmckTNW9sX/in2gicJXLhr/rysXu8JWrcYtU8Y9Fwy9eZrKUDMXMyuNfdH
	 NPn+jGmCqcofC/3H97IA2NLzBtdn/UIc5jdXvLXI7/CPA6Y1O0/0t/4UnmiqSPUdhvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XjN4xtVB;
	arc=none smtp.remote-ip=209.85.217.46
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9188E606A336
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 17:51:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9188E606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XjN4xtVB
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7d88baba78dso735731137.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 09:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795456293; x=1796061093; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1v2Iz0UuewLZrIl+sD4//Z5OhsDcbvMJk6y+VP9T0rc=;
        b=XjN4xtVBAhUdCFd+1Fxy4nRXuMohNE77xpUy8ts8VtgT9SGb1nPmbOAZiutPBjupaH
         qfj6AvpHpFUyIQ0gwYC2+i7ZHs4yiWl+qQFmLhjT7fD1g/PEF+PYwGV0sr9VwzXHMax3
         hcnd+2jYISu2brgBbykxyCUrLXG8K3PfS4x4flt5iIsCYo7adxzJHIj45QTDjoVuio8+
         YD58Q7g7GD+ciaDrW2Zl1kdPntt+590R7J1fESjoyah7Y1b9VgCgj/V4HKgGyNnrBC9a
         g5dVbrsTReLeK9KFn1hG9gn5uSVXPHy/iw5Ov5GC7aTd5tEPQD9tMAgquJGg50n9naHe
         EKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795456293; x=1796061093;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1v2Iz0UuewLZrIl+sD4//Z5OhsDcbvMJk6y+VP9T0rc=;
        b=eENqhIF+dmbVG4wBmgge7v23opzb/6dajUa3392n7NMfTugLiieqDUGE3hII1eMVu1
         ppWxKtL2oKqnAKKXP5KGgLnxx5eV1hx13/IVPN7YPP4V9oDoFmIjSi1/8ucmmpxGkfS2
         ieVPlZ2pwLVzCnu+fa4XK6C8d7rwY5D93jT02lUO6g4g+5q7loXcG0jgMo4MuKfTXxSP
         FQ9ixbShLMO5m9JcbOTQg+ebPxhCtWR5KhQl4VQ1HjyxDE950Zrk6JA5nij+9cfrDZsx
         VvgomduDu9oqHi3eOYx7SsR12JpHOIPlQ1hsZhkf8+s0+NbgnEqAl3WxJGdjxORempW0
         8eVA==
X-Gm-Message-State: APuU4Z+XdBUftuttAQJfuYVst+QwrUY4dImRqvxEkjsE71DPoCR0uOxP
	+Q3WeDx8lPus6TCC3Wfo8ZN+womOreLC4QR5foRaYivZrPMz1hNVccKU2g6xCQ==
X-Gm-Gg: AZFdTZcetOnllVUBbcRQHt9wFG0/fWBtwlULKojI8Cx5Gxgb9ou48yNHcmRCrWKVT2N
	HHVJ9qB88d0VsQh/oByaeMvbE9UXKOQ0z/MbAivibsMJv2WQV0vPpPi5rHwg0axgJ1huP79s0kl
	00DlzyNkKemAcjZ4tZkix5Ar6v5iGRUPXaBK8HspAJB5LUZ4KaxxoZigXXX0bjHyzqKR1LSjSXJ
	1uh1hMHgX69CXmB4dZAxmZ9zY9razl46lVMihkvD5PyOPNfYq9q5GoC2fOApMG30JORPqO5f8gJ
	aPKi9lkacdQGFDy/Q+4savIxOknCUIlyopJDAj0JO4tjO6JtinFb9GcwmhcP/ggU6CzL2zx/rZz
	rEQY/lDmpdnk7hgC1kncrTTmhUtFcGA5HnL0pAteY3dYQIxp20RhCV7koYnWC+HIOfYv4AQ6Rvz
	32VnCgSyoGwEDdeqNyezykVp1jwaOJ7Er0Ln117xRaQJbgPar5TWp2oxH8wRF6F0TO7k09cQm5E
	oQ70K7Mhq7OWr0/qdjajs3NGIxqMzbMIoY9ZnTNHbaW72//7d2GSATeSIZBFwcNBJ18HPSMl738
	uGFVEcb9yrynO0JHo0PCKau1wV7dVWqDrb6yvqz8EOvjac4CarYNd9uoMVuhKcG5zouKs+gWyL3
	idemLoDj/f5WGWEZNKV6dWeT6cCdIuYt+AZ7tDGIyw97cZK1DJXkTgPDkXuJAofRdAyDfNze06W
	WoazY=
X-Received: by 2002:a05:6102:580a:b0:7c2:635a:4f4b with SMTP id ada2fe7eead31-7d73965e735mr5880370137.29.1795456293262;
        Mon, 23 Nov 2026 09:51:33 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e7f92680sm12795393137.5.2026.11.23.09.51.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:51:32 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 08/18] profiles/ranging: Let StartMeasurement() pick the Initiator for Both
Date: Mon, 23 Nov 2026 12:51:11 -0500
Message-ID: <20261123175125.3642617-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261123175125.3642617-1-luiz.dentz@gmail.com>
References: <20261123175125.3642617-1-luiz.dentz@gmail.com>
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

