Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534749;
	b=r7m7a7UwTqSDuG6L5CGIdcrZFXIPWD0DzGqSyb/N+YWFi/rPruMpdZzSAE325sqQW6dN
	 e95XPiQkHTrn3arUyjCQmxUjE8yMqsovfWNfT5ZdR9v5KMH7uXNnTjJK6pNiADOSC6i/C
	 bRgF85A7njiNbJctoOXMaTqXQOoogJhmOHmXyV+h+DucALGmoU0iWA9PvO9O2mZAaCvji
	 3t8vmnF2J/SHqozWE9NNmjVp1Z5qJ89O7cF8MP1ICIUtSjnKMUh3os9MFYzv/yusMe32R
	 KN3nAvSjWUzZI1EWIoQxKZTRziDfPMsbHWsoilwMP7/1gxnzcJKCv/35E6neOPhk59A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534749;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WwoylUVjr+iEAlXPsyZXRA1E6c4PH1t3s204TzCZlVo=;
	b=KiVPNH77r5Z0F2uCO1kdYEnogkC1jdwG2cn+hiNVTQwaE9/LpJRSZDSMBtdANhyc3YYS
	 JXdVs9JgWwETiSmS2uniqcDXsxACHPATX0FZ4q87mIZjIe1/nd64udOXD/ZZaXR6Gq7s1
	 JGlX7ZCqJ4h6Vjd7ftBTrhvR/TLEVzQZgnKcnhsFiIVsxFd1icVaZgoSclfrdJce9dqvJ
	 /e4oRfrwoitT6RI7iJjblAoBFasYlvnzdhsyC5qPGK7Kv1M4c6pHyzNDyXZYDJex//wL0
	 ba2ib3IPWZ78f/+qfnYH/xmeaWoDP6p8nusuRrPcUrcRWOt0jR5Imsq/XhPBZAQ6mwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="hso/A7K0";
	arc=none smtp.remote-ip=209.85.222.47
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130B8606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 130B8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hso/A7K0
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-99e1babd683so2616797241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 07:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795534748; x=1796139548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WwoylUVjr+iEAlXPsyZXRA1E6c4PH1t3s204TzCZlVo=;
        b=hso/A7K0EAHtyQqIxqWD1Vo/lSWBWYDXTwsHr10xU0dYgcYiBYrehnI6C66JuZzUjR
         QxoTESOnUkJERkzKf6Ut4E50SURupNUoashjAqAx6o6dkTvkWQCh1e2PQWo6SJZXFAa1
         NRNY3Btz1+BeHm7ICWa4iX2WTLK1nQxerAyQZ+xYM6D6BlZmGYOnUYvXPKttfsdSrqnz
         8vLeWgD4u54AwWl0PAUrJhyfvSw0Y0B1ZeG9hEP5WUKQebK9/N2wb+/Va9ponG9sEYVo
         tAI8GKc14dYoADbdFJFjZnpJMdWqW0eA9EQr3/XJlE6n4z/Bx3lesDnwqRXBP0NK9QWn
         6Qdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534748; x=1796139548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WwoylUVjr+iEAlXPsyZXRA1E6c4PH1t3s204TzCZlVo=;
        b=WRE14E+KlfoZWDtpPDNoUDeR+chpKcDkKRM0ficJjipHGXg+JxLPPH317GnFi+q3e9
         YBHmu+7AcljXSIrnZwV5EuDiQKTprHXpxUWkTWbqIbtM6PUBHj+aelDOK7ze6onSB56/
         vPrEseUekDQ2+06HEQOcAqJXOpOMirgS7xzIuPEkK0OFBu2bwAQlx7dKLeiAaumDszZw
         c027EmpkQqgv7/H6PqgsYGDO0BnSND4AFxnGMgB1OeQGCxchkQkLzDHpV8hu6rG5s8l0
         fpKso9QVBvrnn+qDbbgGckqUpFrtAnEtBLbKCitYuKnRlzgl0BbBMkCHQilCg/X2Jf05
         z97g==
X-Gm-Message-State: APuU4Z8YacMtXKvPkQH47xEU/+Bizw4EBYyv6aYSzzwCW3n0LHfyH5rH
	BFgJB6oZZuAfCrXGaP6Vxhz4+gLzeL3mRVB6OiBv8fUm6jHS+4o8610J8E3mLA==
X-Gm-Gg: AZFdTZekEQa7Zq9J0qSbSAskTb0EOXP9nicJJdCixo5NvmgH4mJF+Qff9jupgmsKWqo
	RD1wYEl0q8+9Fa/p9foubztrqNuDh6pkU4P1rH0FzbSSjHg1jJ2OC4VHbvtAsldoIr+wO/J0xKr
	wcovCTQduf/vigm/yc9OG9TmW1zpWpdT6S1HTN51CAT+7qIFdz9X6HKp9zQhVhms1ZJwUyk1Oyr
	mkCLd8zWatun09GUXKY4oX0nCAR1HtchYhqZvqVmnFg4qdm7FIYKcxPO+Obpah6/t7CDk1Y6HbB
	M2q/GSqCntig7l1Z/TMG6XfZKoxZRTxSCoOc9x1UJ8ZbDN02o/mHeCJ0CNoCaqlI+4IN6fKS//S
	3pNgRB/ZoCwTq9AnOA16jkbGPdMXs8u5MIEIRMp2Tb3hk2WlF6i4bufE2KCJA1MJmPC5KhV3+O1
	jHDpnNRBex+ORUGLuuyvABdn7p8NHUCkIdqY+lJ9fnmJKr5NM9bpssfz1UGKkgv4P8lxyGgWx5S
	d3G1sWFJM5VZM7YiOId80tGJkw4XbMrCRHKYl5jySiXbQuCNuA+727MeBm+0J4LakoJQucWuHT5
	xUSJcoDYGCJRO3eDVaVXm/7PM0xK1t38eFBi/KVVUvDXX2vsOVKQOX/LbpOGwlPCiJVBl+V0is1
	72PKcksSMPmpX3VlZXlaW2UOMzVm8W+0BcQW8AY3U624zCFnPiIoX0hCdAiZ9DRaY8bcXZHwULT
	AN0rA=
X-Received: by 2002:a05:6122:c84:b0:5cc:4a63:4a01 with SMTP id 71dfb90a1353d-5ee8af45a2emr8680427e0c.11.1795534747947;
        Tue, 24 Nov 2026 07:39:07 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5564a9sm14343463e0c.5.2026.11.24.07.39.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 07:39:07 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 10/18] profiles/ranging: Act on a CS configuration created by the peer
Date: Tue, 24 Nov 2026 10:38:47 -0500
Message-ID: <20261124153856.216054-11-luiz.dentz@gmail.com>
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
Content-Transfer-Encoding: 8bit

From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>

LE CS Config Complete is also generated when the local Controller has
responded to a configuration request from the remote one (Core v6.2
Vol 4 Part E 7.7.65.42). The handler required CS_STATE_WAIT_CONFIG_CMPLT
before parsing the event, which is only reached between the Set Default
Settings response and Config Complete of a StartMeasurement(). A remote
Initiator does not wait for that: it can create the configuration as
soon as the link is up, before the local setup phase has run, or again
after an earlier procedure. The event was then dropped along with the
role it carries, Security Enable Complete and Procedure Enable Complete
failed their own state checks, and no ranging data was produced.

Parse Config Complete in any state. Every state machine on the adapter
receives the CS events of all links, which the state check used to
hide, so ignore Config Complete and Security Enable Complete events
whose handle is not mapped to this state machine, so that they cannot
overwrite this link's role or advance its state.

A successful removal (action 0x00) leaves the remaining parameters
undefined, yet it went on to the role check and, if the undefined role
happened to be permitted, to Security Enable. Ignore it whatever the
state.

Assisted-by: Claude:claude-opus-5-5
---
 profiles/ranging/rap_hci.c | 42 +++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index 84b94d8d453d..91dea3d91a9e 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -890,13 +890,6 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 
 	DBG("size=0x%02X", size);
 
-	/* State Check */
-	if (cs_get_current_state(sm) != CS_STATE_WAIT_CONFIG_CMPLT) {
-		DBG("Event received in Wrong State!! ");
-		DBG("Expected : CS_STATE_WAIT_CONFIG_CMPLT");
-		return;
-	}
-
 	/* Pull the entire structure at once */
 	evt = util_iov_pull_mem(&iov, sizeof(*evt));
 	if (!evt) {
@@ -906,6 +899,35 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 
 	DBG("status=0x%02X, handle=0x%04X", evt->status, evt->handle);
 
+	/* Every state machine on this adapter sees every CS event, so ignore
+	 * the ones for other links: acting on them would overwrite this
+	 * link's negotiated role and advance its state.
+	 */
+	if (!find_mapping_by_handle(sm, evt->handle)) {
+		DBG("Not for this link, ignoring");
+		return;
+	}
+
+	/* Action 0x00 reports that the configuration was removed, and leaves
+	 * the remaining parameters undefined (Core v6.2 Vol 4 Part E
+	 * 7.7.65.42), so there is no role or configuration to act on.
+	 */
+	if (evt->status == 0 && evt->action == 0x00) {
+		DBG("Config %u removed", evt->config_id);
+		return;
+	}
+
+	/* This event is also generated when the local Controller responded to a
+	 * configuration request from the remote one, which is how a Reflector
+	 * learns a procedure is being set up for it. The peer can do that
+	 * before the setup phase has run here, or after an earlier procedure,
+	 * so do not require WAIT_CONFIG_CMPLT, which only the local setup
+	 * phase reaches.
+	 */
+	if (cs_get_current_state(sm) != CS_STATE_WAIT_CONFIG_CMPLT)
+		DBG("Config created by the peer while in %s",
+			state_names[cs_get_current_state(sm)]);
+
 	/* Both sides asked for a configuration at the same time. The Central
 	 * rejects the Peripheral's request with LL Procedure Collision (0x23)
 	 * and completes its own, which the Peripheral handles instead (Core
@@ -1052,6 +1074,12 @@ static void rap_cs_sec_enable_cmplt_evt(const void *data, uint8_t size,
 	DBG("status=0x%02X, handle=0x%04X",
 		rap_ev.status, handle);
 
+	/* Shared HCI channel: drop events belonging to another link. */
+	if (!find_mapping_by_handle(sm, handle)) {
+		DBG("Not for this link, ignoring");
+		return;
+	}
+
 	if (rap_ev.status == 0) {
 		/* Success - proceed to configuration */
 		cs_set_state(sm, CS_STATE_WAIT_PROC_CMPLT);
-- 
2.56.0

