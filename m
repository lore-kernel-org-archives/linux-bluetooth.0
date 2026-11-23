Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795456296;
	b=DKBqWLQWrIxmGCnZo2hkkneO0LbfnrqE6fx7BfOPYYI44qQaW0xZmqpsY4DLtRyiwkGD
	 LDdbePydC/x1R5JST4qlMEL3GoprnYYeGXo5y35cUMm6FLyt8VUv3TXsbVeFq/pqDrtfn
	 k0pnn0mHj4KWLCOr7Ig/EM2urkQFdzl2A7deTLds0xQppXSKgq44yp+mNI//1CiMI3toF
	 3z9HS94/OwCsfj+6cJXrn/rhKrY7j5KD5arGNurJejLV17qXlA+gaR7r7RFsefUtvhE0s
	 OArec4aVnyFfAU/fn/g7HjFxdLNW+OS/dJhioNGnr2DBDRptQk5eI905aoz0YQbTn2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456296;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WwoylUVjr+iEAlXPsyZXRA1E6c4PH1t3s204TzCZlVo=;
	b=QWQqbsRrSkRj/JSfiElM8ObbpFD8WCdfazwFFEyLDEBd4y92ijXMhry1FCEHCUz6Jivt
	 zl5YkSsMG90iEF2B3KiVkN/TtCi6nBu7vDwwInF4oLAYwYW5TNguO6DtTZLG0wYze4FdY
	 pLX662G+JrgwfycypIU3hUXTHXOCrC1299W2z01YoV4lIn6ftlvyxvJTy+61ejpmCVJVK
	 L1nhNTuGgbPrR011qPPVwDMiHyB6cZ78MfO+tlJ9hGSd/in33nFGiM3d4pUbqIuL4Gfv/
	 f/Jb5bCmQAUcYpsfQ3E//g+lnCsju6VAd5PW+cdMJhysqhOnXaYpIQ3EyIbjxIwebvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F0GpmiLI;
	arc=none smtp.remote-ip=209.85.217.47
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A417606A32C
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 17:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A417606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F0GpmiLI
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7cc1cf48a39so1490966137.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 09:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795456295; x=1796061095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WwoylUVjr+iEAlXPsyZXRA1E6c4PH1t3s204TzCZlVo=;
        b=F0GpmiLIy5OpxS7l7BkYwGq9efqt9MVd3CbT14hjfyZ2iEFPtBvsJVo8zl56j+Gn0Q
         izfUylnQy3547XYjOfHctg/UBkBKm/JHg2+LfnmMx7cdiMDANHsxrroaQfSsN5VM36yA
         xh36GbFXbtz/Si32vH3O1DuBbqS5dsutWmWHFc7sMvgLy2sW5yD8NREkTe2wk47MZ49r
         yk/8LhfCXhBA7aOt1P38SYkhmCk3z4Uw1rQcqt3Jmew1IRYd6Xkw6T/VKueX6jy/rDFv
         65wZfkJmGo7KurAdyTxGxawbyRJhRBeX8GoNr25J2QEVW+w5RHpkCXOWCA55WyOjc/O2
         Q33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795456295; x=1796061095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WwoylUVjr+iEAlXPsyZXRA1E6c4PH1t3s204TzCZlVo=;
        b=AItGyi+t0gRMw0dBuf0PVIr+pIREEHmgAWCwTa9sUcyKftX0FG34ufAXeLLfrSXwmA
         AO9eF6x179G46858GSB5an90dAGE0YBPIMJK8+uvcQJ4kLsIcEzzBbG3XBM9GP51c5HL
         nR53w1KkZ21T0MVjUSHYcx4xD4gnX0vyxNqaZuxbXXxBbNWypuPb/1ChvBIZ1tWtKntT
         CKBGK5ouqcjbaG2M9CVgbLmk93NOoT77eLVGYcJr8JZjowPa4S2J+8aZ0C6Ew037dlGl
         sQI2u8R3ChJfOKvkYeKe8AJSzD4sidYL1WHnAKhIHiBNTk55IEa2Am7UA6KMR7mxW2R3
         HCOQ==
X-Gm-Message-State: APuU4Z/PmUWoGHSVSPyGUQzzIQGheCwLp/W6ri/BWJNW2/HqBOJVBADk
	bNjn01oWqP9Ux3krfAbgld/rp5Cm9jP/m/mkilviX+dWPKWn4TJdOo64lIA6ew==
X-Gm-Gg: AZFdTZcREBIle+6KCk6z7aaHJBPDYVLezdnD1uc/FinSsdVRD0kk+zZbXE0/jPRXNUR
	p6b1qCy0O+97tVNg8ZVRzp6zNusTRf3EulcvAomImWlRpPXqOPNUXABLuLqmkXltAJOnCQicfu9
	WDK8EcfuWa8HIcdO3CW6fhxJ2GDyGE8jPABPGKSL36HC8fctOvfc6INn/mbb2wVFAxMvaNFw7MK
	hePDtAAG8l9rFiJO0gWd/S5FRjV87cFipWg3pkByYetIcwDxr6MJC+tGyRHZfzlRXVpFOcZ99U4
	3jA6FzHulBS4UiNnJjiDn8pnbvNt927WKGpp9AhQ96KVDowhqBIFKGXMZ/1PvgcGMyKwwXCfsew
	/imeDmxlKGKRih+LIk+hGqr8++g2a4R2O/ceL7LEx4opZNJUi3XRYKBkygNDfAfWbNl6EyAA/ys
	3AXsCpzjYC11P2DmN2u/k3DTvsAdO3+/0OAzR7s97LlLg97GSm8htplXOXfFly6UAftNHbR6RMu
	cv96J3TO7QCYV6mTx1b75eajRA4ISk9CG69FcJnMvBZUZHhomCzVzJwgR8+AKJo+tIvGLpS6X5q
	a/dcbEDkVTVAzbA7A0YjU3pqBPoNJdCbOlk/RUlJQ0Si62+RkTsUvIsYyjLhv24IMY2PosAjrdb
	Zp7tifHseICRrDYR25qpAmxjWJymFBj7P0fGGPrDU48vtrIyxN/dLLStBbKV9rjeYuc9fZJp6un
	5Ckqk=
X-Received: by 2002:a05:6102:644c:b0:7c3:873c:b3fa with SMTP id ada2fe7eead31-7d7392a4bddmr5827862137.4.1795456294932;
        Mon, 23 Nov 2026 09:51:34 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e7f92680sm12795393137.5.2026.11.23.09.51.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:51:34 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 10/18] profiles/ranging: Act on a CS configuration created by the peer
Date: Mon, 23 Nov 2026 12:51:13 -0500
Message-ID: <20261123175125.3642617-11-luiz.dentz@gmail.com>
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

