Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108597;
	b=V0h5yaWylffowLT52B709uAr2M7pSU/Ye+zeI1iZYyd11aMNdzsoAcWC5japawWEMiOE
	 7qPgm88PJVlCekaVBaTw3M/nhO/F7ff4lgG9MLtKx1UzIj/+oFY8yX4/tdFr6tPMLmmdv
	 7vUKH0JNTFZHI24zMr8bVkmCkpSdR45/rZiJZY18+JTZGtQFFQlLlH6BAPdUqXdBfFlML
	 M6mD0dmnKsolV+Ap2vF+8mRFTxaXtuXPxi7pKqwZ8DU5jtBZu2cQxVkEuWzXhb5bsKZ/O
	 5rNt8ekaoc+YQSdYaGXosFBqLNdUwmuIAq7cAIToW/wmf3gp5DN7Sq5qxS+P9UijDhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108597;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WwoylUVjr+iEAlXPsyZXRA1E6c4PH1t3s204TzCZlVo=;
	b=hQFe2ONymsK7wTYzEviWAWuvL4mo8TL4XLCuERVgHcNDjhzTLnrtOI3apFZL+pVEKYT7
	 hVd9tuB+0TApD3tO0tzzGq+ID5MnFv8kztjfBznDC0EOuhdaA4DojFQB4L8FY7tMWNzJa
	 ichqtRvrrxOjV4KUWCmdbwLoOxlyCJPLHJA0T6TJ+hJp4yXc8irY8TnoKqPKitfEFOtW9
	 h4mdF+va0Bp7jSDZnrqcBXV4pO4NrVl6pSWq5nXgIJhP/i9uF/BKe3W411RCtGQJ6+2OV
	 uPkFDgH33MBe2etFgteb70pioxP5oFgVxxD/ObbT2ZGcOB6FatQJGFOoaKz+gL3seow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=edI8llhL;
	arc=none smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3D3606A324
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 17:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E3D3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=edI8llhL
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5eaabf28c06so1707548e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 09:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795108596; x=1795713396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WwoylUVjr+iEAlXPsyZXRA1E6c4PH1t3s204TzCZlVo=;
        b=edI8llhL8syI7lRTdzdRCeMidazuZmmKqYspB9BeUMzuneGRNHG/Pae30nrue8r2Y2
         lC/a3BgeGrN2aUxfKS8TaU53Dk9wOjjx+kH6AT+RGo3cbdCw03b+STDd+VuGnhGiWMDl
         urh+6+Jh+eWDZBqbHpMcm9PPvt/IA5EsOWUh7chqgCE8w+BVr/x7B/rJSR3qd98xIg2E
         FmufIirgkchhmaSPOH124OQ5zgIrpJbp6BztfEkIG1o72q1S2D99hhtgqc8z+oULdvxB
         mDhTv2fV0nxbKY+Qc0eLz0kPJtORymcXyFyMpDAHgSuiy6R/jMIm4vn+8hVM5BVXZogp
         41nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795108596; x=1795713396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WwoylUVjr+iEAlXPsyZXRA1E6c4PH1t3s204TzCZlVo=;
        b=EbzAOxTilJh84ysDZHEdHrDl99gyNRaIBV6hlag1j9/yDa6RzIC3NBYWdIDCvNGhKY
         EAyhy8yo/4iXelSqopd8sVFUGMh5G4XLqe+sECY7DQ+P2RAaKAqkuFMw6fp2yC/DEuYz
         P5dpK9eEJxPKR10eUnQdEpjjQA6FOgUZu1o2Vnpb8VhN1HMf0VQGBDy7w5TM7eEHX7RQ
         LkJCwkNb5uJ8vRkoiB9xBHq+/cgQOaANvlo4Nr4kuJ+utlqLVopnxKuRi9glFWEXZc8j
         4IxJKG5QXCwVL1Wgm0Iv4JXRaXo6OHR4Q6cWgyH3nT9cNNzgUkDdfUSknvli6JT9NVda
         8FPQ==
X-Gm-Message-State: APuU4Z//6IJ+snAZfxMxHKHXkRI4pcCSyXhLKkbvgLDMVD9Hk+hLmxK+
	kWNVaIZ9rnSWWQ8iEnnAE05tN8jg4hly2Uk0sOZvffJjok5WcmMpYKufYUTbuwjIzgk=
X-Gm-Gg: AYBFou2WTUvMA8X2upGpaHH5/wYdKO2BblRMeqiednwsYt94G5a036B1clNWFs5wlFw
	8+V9431oTlS0bYK0/rEePHRHpxTwpGyNdDdoSKJpMckG/GUa1QoPXxVX5OwVAzPGV1/3pu2n4oE
	U2akv1ajIWRGCb/LYLkRLiTe2RZyqbWPjStgcjVHceRJp6CtpBhqCkEqolZzaBzd2x89Y/AANiu
	7H97rVRR5TkqDOrVxw6G/K4ZGzlBe6TejEDy4v7ZC1Ib2w3QFGuvfaS+MFFbj510WzQ2NpPQ1xb
	gPWsp/Oe12C5JPhYehhzvno+qwX23udsyJ/PmyVgLJkInAsbALXRw6K0JJX8ZIi390aq39dxdMG
	XH6WGM+UxqlbRfF+yvtLEUuRVz/pdCwvqn7bGTd8OOsC20zMZK3rSLnh3AHBiyt7PxA5E8gUW2s
	YQvrru+3W2VoihCTElWHDZ4Keh3HRfzjleZsFhtUKam1Hi0c0QzeGIHBN15Pm7W31rq8eJQwbmA
	Hr6xwSm6veAPe5nLMasxv8yjpn3REvsoLFioAfOy4+H0W83dEhh6NrnlDm8aYNF6QwFMypm7Ln2
	d378inJF3GttkPmMrLGZSObSCGOu9eSP9Wv05hPDVai2u/aiVSBo8X/KKNhVkTub6lqlO1SK0iR
	k7Lw/CIR+QyGixI108FbiJ5cGWE8gAZlglbBEC7mpHbfJcLvglmzUycopdp5k95AuSZYHKKKbe0
	8ZTas=
X-Received: by 2002:a05:6122:338d:b0:5ee:19bb:f8ad with SMTP id 71dfb90a1353d-5ee8af107camr284831e0c.17.1795108596309;
        Thu, 19 Nov 2026 09:16:36 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5a8fd3sm131881e0c.8.2026.11.19.09.16.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:16:35 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 10/16] profiles/ranging: Act on a CS configuration created by the peer
Date: Thu, 19 Nov 2026 12:16:18 -0500
Message-ID: <20261119171625.1014004-11-luiz.dentz@gmail.com>
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

