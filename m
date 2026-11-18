Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031938;
	b=2CESJ+T74wB/wEVJSi/2WP3N4evYmVN9U91F6JdCK7PNf8+D1RCQC3UVUlEOIELATllO
	 P/OcnZRPWxwPgg76ZKm/rENbGiFjgyOlSsqNb4Yt94QuojV1/rqiLRwDneFuP5tNgpbCZ
	 fKB2wfvEsHaC9G6tc7cdL5XChCnWO9mmPm2DR34jynB5raJp5HHfOIWY16KyJmL06FhYd
	 6d83XjyT63bx/vGjGLdEEaLk7mc7C7trcwjKYr06+sGJolfC2fcbVxmm7l+m3dzrtyblP
	 0lq8qhyagTBBRTjAyRnLlyFL0V5Q2FGOR8ReERRKO3ARjET1DiePbpoB6lVOWgJLxHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031938;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/uIbmF7EZ1jfDi0IXD2LCITOj31X0o2rJ9O0r6hbmu4=;
	b=vQJPSDFkVvQg0LJgbs06y6KWIqS7ivW5Vf6MSB+u6RzUpwoby/ZgxNGJW0zkGniZEM7K
	 4VdugMN0ww5pAwMMrpiWX04bOfi/h3tpXHE6LMfgZRkMurGztCTnaen6uRukdMV1dxbxE
	 qitcvfQuqeOiOTIXWJ7K2XKG/booVbjQNBTStxfZ2OPq0myGVCXxMuyJk7RvkuUiWv0z5
	 8NW5n6PGk4s/PHPwatxzPyCug0KUbk7Mc6kD6145eQh1sNV17/LNRMuGUuhQwPl3C7ytN
	 SRGbuYTqQUOn1b2SV5NPFFkqFdZicwyw/2XN3LXItftcXKSLDN41K2qQUelkIMVEzzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sCfMCh1P;
	arc=none smtp.remote-ip=209.85.222.44
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983B260A2611
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 983B260A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sCfMCh1P
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-9906870a9baso714325241.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 11:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795031936; x=1795636736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/uIbmF7EZ1jfDi0IXD2LCITOj31X0o2rJ9O0r6hbmu4=;
        b=sCfMCh1PYWCZumS7H9nVuxakrt3fWmo1xWSUsLexFO6rELM9MkccljPALA7SQ3uFhB
         rk8DVBQXQZ6v+ISdz1UtKasKuHm6T1hfxaD5hT8QZoRuXlmkTe50rxJ+LryZl9XeNs5w
         u+W1/1W0UflpoJ4MyRtqQlRdDvHR3P8JzOh5jmvn1v+vOxIbLbYIpiJkXRqFu1amVDo0
         Ogb5oq2LCbFyApxlAYOEwCIWIDBmyewGJZ23NVjq0cFrrCJOfSaMYR9P7MoEdl8xvTDK
         NYDLLfvxeZ4GTWtkGid7Qgo76gSVn3NTv1ilVJf0rEnKbDZs/PL0vhTumDQ4bMjvamZb
         j1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795031936; x=1795636736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/uIbmF7EZ1jfDi0IXD2LCITOj31X0o2rJ9O0r6hbmu4=;
        b=yL9s1rz1lOZ/dWB0vy92QmWEqJyQiWEEhGZbhMD19vALO/WT/+pLe0JWSXQHu6eQLz
         N8tuRMwxi2AvXTMEA6LHtflxwAD0Hfbyjm6DNepLPxbIFtuvkI+Ou284XokT3V5Gywkl
         FzYXpyw84UmJFczsvcoUf7BtSt9G4iRzXz5drjnUjhNJsIcpnXnKS4U0vllPRrKqMlXh
         iK9DX88Bgnoih8h9dA10E/rlS0epVjTPYWc+eAEsAsmvIsSaQ+yYoEP2kFZg/ibedWe4
         agiQ72CPUCIVbbIz8UH9LCAXprhUZVxrYBLC1N16N2DuH2shT0YuVDY6kQs7OtEXmyHm
         8uqw==
X-Gm-Message-State: APuU4Z/OgND3Ka+jkNMB+AY1+m5zZfR2yTWFqPchu2NNQePdu+wE0G/v
	N59yERTNDI/Qe0nIxmH8dJRturu6DygYHRLqyaSc1DqDm4caoUHC46FWDcjpfawe
X-Gm-Gg: AYBFou2pseS8/j66B5ZEqGU+wrNfF6/vsVbwVVSvMNsy3/A+0z+kSi0MC74e0SZ4oDn
	ITvrrZqRBl+9+MgHNrOQ50SnJehsyout759BGmnoN26XfrRCVKrli2KCe3Zr51V4NRMubUJbjFk
	o/IxVZ8QuPpAKShdF73GdcLiyjOJPe+31wd0/cPgzY/VgGNBvkAuCXnWABJD3RlA/+4z7xOXB+V
	jIaUbQca6loTLyd1drROK9gafHG5QmmM6swskxkPMkRO0aoxmR0J/PU2rKZrJ3Bx3mrsVxzPeEd
	nojEjDfTNG2eBQNzBdldPUxCUT4C+nM2uTby3ABe/4pmhcQvvbhC3woAyc+KhhHMd9cLDT/b5+Q
	oCYENxwfzdTS6sQxV7ZMX4eHXa0fXuTZx6VpK3irnslFWmScEJrfTTTEbJ/zNDVDhuUUOqLfOJx
	sLhAWb8IARWRxqZ405cB1RDbRdVqKw4yzP7gukGQyl/mGZmqIL6AfSqQuY/UCWkckDFxJbpLKHM
	+5u8pI9GIGYlBxx8YbJIBeIcjSmGuy2lMUwrmsg9zSCaXdqs3J2pCJdk2AXnyyXM8g/hLNvVgKV
	N+Tr1hmm4QVlrFfc7xmeAGSA5s+o1sVWroY1ugTu3TOlCluzG0tZvr1/TRb+F/G3IUlSJQstXro
	aKsaiPRKgelFze2xVMQpQftuTLwpY6zVNfNZsVGEZtT+AxRM7Zr3TOoBBpsFdsNBmEPfhNrOScJ
	qRTlk=
X-Received: by 2002:a05:6102:14aa:b0:7d2:d45e:5c93 with SMTP id ada2fe7eead31-7d6ba3e9fa3mr1872308137.9.1795031936463;
        Wed, 18 Nov 2026 11:58:56 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b91e87f4sm2685571137.7.2026.11.18.11.58.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:58:56 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 10/16] profiles/ranging: Act on a CS configuration created by the peer
Date: Wed, 18 Nov 2026 14:58:38 -0500
Message-ID: <20261118195846.393710-11-luiz.dentz@gmail.com>
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
index ef01e60c559a..39b167ba80d1 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -882,13 +882,6 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 
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
@@ -898,6 +891,35 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 
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
@@ -1044,6 +1066,12 @@ static void rap_cs_sec_enable_cmplt_evt(const void *data, uint8_t size,
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

