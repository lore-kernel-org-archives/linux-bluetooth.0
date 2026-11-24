Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534748;
	b=KHu6cw+9sKiH/IqpLW+Tseuex5nJ3ftxWtYbMN6p1tmHqThHrplFHkzuhE+uPwGszLGy
	 r6Ymd/o/pESL/WuJhE4S/vZwCQ6CEQkwBRZaLZi7Bd6F5QsOZjZyNtc9YMadEIq92/1pU
	 SLh07iLqAkTOGR/7ht2vKC9mmPfEcy3IrUUGICJ1r7F59siL/yuNj7m6q+x98gZrNmRvh
	 LKCZJ+kHNb/0QFapzw1eBsRKlJ6JG+/Fk4TUBaWMnzI74qUI/Ftr3Q7ooGXs7pdxZAFH1
	 aQL331WXgxKFcJ1GRa0ThwMuP+WNHHeqJpYpBHvPnZ7bN84wLCaqxLTCXkx+8mhhABg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1v2Iz0UuewLZrIl+sD4//Z5OhsDcbvMJk6y+VP9T0rc=;
	b=UzS0vd0JXp9q/6uiVVTIQaMhlGWgtplHLReAmoj4RcfIPJJLnanBitN31iezRSX875Rl
	 VYXsLzWXrCUjkV2nPnrSC2I84Q4ye9760HzGp4nMs6D+3vi5cacIXLU+A8S7QqCf6cdrh
	 dOZRKk/m3FL5+8kPnzoCm1TOtZEvrjxSMcbr4kBPgyKLp0gGmAfYX2ZISjzXUPNOF181g
	 oAiTdes2so5OHivgiVHTM3tZKHo9dhkhIudht6QHz0b4moul6HjVp1z+E8KiI/50b+G7C
	 3L1a9XEaSJLFwvRDbPMrxQzdBmMM6EtpMkX5Jnylg3Y4RrOMXS8/Ty4jIFibXrudIdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RKnFUXKv;
	arc=none smtp.remote-ip=209.85.222.41
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07BC606A323
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E07BC606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RKnFUXKv
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-99071945aa7so2613576241.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 07:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795534747; x=1796139547; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1v2Iz0UuewLZrIl+sD4//Z5OhsDcbvMJk6y+VP9T0rc=;
        b=RKnFUXKv4GA0OMg8B3ol+B58LcNbTyFQfLvP81GkIfdZ5/V6slXavHLcLjRzSoeiCv
         +n69IERJ9C7BIcb/uoss0A4Muvth8eLkYOMe0bpbPufkmlOl0wsA3nuElpO0eC7un7s3
         /XXGEZwB4ckLzsUzuyuGM+pHvioSeBlqy+Eu4mJ1CDCgoljq1KFPhyg0YIJnylm8SEgm
         bGJFm9q8Gt39+puHltwzLrrProwtyqhgAfoo5VJaXAcfK1UAlMnNEwHRLAaPBv42GgvY
         nbwQa0YlkbpWVc78h/8t/Pda5ezdfaiAHiQMKBSUImP6yxbRpzWpTxpCX+MmRffzjbWE
         P7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534747; x=1796139547;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1v2Iz0UuewLZrIl+sD4//Z5OhsDcbvMJk6y+VP9T0rc=;
        b=1qCIMWXpZBEXhGiVqby0Mmepm+nKukP53oAP0rjsvFU9rUM6cJaqKOKk6qP6kJpWKC
         VpmUXBW19gkIHH826ZH70SikKVuFLXtaYqVKdLLnxPolb1N61ZMgsWsWFpBNSzeDEOc6
         81Ru6sFEL/NUI2ZVxx5HgHGt00hHbFYzCkMwTLJd8Nfs9Y0IwyvqtCQBE5gz9eXgAa5e
         vaZNcxDjr4DyWnHEZ4PIgYdtEIQqYaXl6y+0tSbczo7nhvZDLlXnn/G+Gz2AP8w4qd9E
         gqSMeFoEXkO/1WjAkwQ1qMwz5BCpitdIneZXKiBfj87ZgKpuxpqf+/c2YeuPPFBVVmXT
         bWWw==
X-Gm-Message-State: APuU4Z9F1I1D8VBa83axykVZ+s+hVWsaJvOnwuQJ1Q84lvZhKqt5iEf7
	mnhEf/ddaSt5edXPIPvQ0zPs4uy+kYwcTp04H8W0kv40/3K1WI7sDcSPEtE3OQ==
X-Gm-Gg: AZFdTZeCel26GB6eSOiQ4nA6na8qhJSCLYqMn31QsAEGdf0NnB+VMTz4uGgQprrooD1
	W0Y1ddIhqJ5/P+tFGjmtJnIIL3RfnbOPsqyYAgufajy2rl2n0mCt6Q2TLUfIzuk3ovS0nZup/B1
	nVbhPtPWP8QBWV2pHTf5MTvP5bVF8TUQiwPEsrZbsswuDmQ5WZgKRiZ57RcadqcMZk6kKYWWblO
	qfauT6DYh11m0f7rLtX0mzVdMgBN5rbq7xX0JHLuODfsPzgsXr9ZEXWCBP24oCVogVCjpeDCaVQ
	f6uY/1fGAlDv0oYbds/dbIPl1TfU8HPesraZ7kobIWhO1u5N1kZpb01vMCQPyqRXhL9oFO0c6Hu
	i558YS+GHGNINXbAnQ9THQs4GJOBdmKwukUjzrylxvZjPGi+HplFFTKXOdJEKnFg7zTC/GzLYJo
	IqDNBN3STyjC8wT+AZeAS0NVtrIy3rIoGjDnWjaa+VQmVHvlXPEN7KemNNJE3C2qWUF1xbBsovn
	cSuBmsrTlZ7NV0uiT1yK0RJHKALBF48EfqJKYRldE+WR2+rAWjYUywNj7Ul1nkZbdlMUdR9SD7B
	+/1HG1xeCQLMTJE6T4mfh6lBEU7yvMNfBpws+DD3reGjOHfswEST62BpyVYreRq6GkOgmPgj5ek
	31PMLTjf8kHq59xxRlfwFPfeFTRl9Gt9nNwIVbX2OrWbpMXpqyR+zXclyyNt2CBpzCQy/MyC4LO
	r2pHk=
X-Received: by 2002:a05:6122:628b:b0:5ea:d18e:dca5 with SMTP id 71dfb90a1353d-5ee8af76532mr9254566e0c.16.1795534746535;
        Tue, 24 Nov 2026 07:39:06 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5564a9sm14343463e0c.5.2026.11.24.07.39.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 07:39:06 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 08/18] profiles/ranging: Let StartMeasurement() pick the Initiator for Both
Date: Tue, 24 Nov 2026 10:38:45 -0500
Message-ID: <20261124153856.216054-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124153856.216054-1-luiz.dentz@gmail.com>
References: <20261124153856.216054-1-luiz.dentz@gmail.com>
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

