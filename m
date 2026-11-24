Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795530971;
	b=J1vXMmpr8p7XkbONWTBkgLk+lc44k4rzFdT9zzqf4YoH4J6NzqSKwr39sFbaK429Qfmt
	 136ziRBD16Wv1dtGCL4pk0iaDcy189U9yz2GnaHNm1xDPl6e7mUiYuRppndAhH2UqFXvR
	 Q0DTdU4yGg/ess1LvTVvSxe62e442q1qiq1b4r1pGbfGdOFsIrvTQlrHHTkbd1oTqwa2D
	 VWaKSkgEHrvlpczhTsXQJCeAZ9gC70VnRPZKOb8panbu+5nj4PzT8q/2Jkt0o2f/EBY6D
	 QP8niKh266i/PQD0/2se6OLiuGkV/J5+IcY8RaX4mpGNYNFqpLowqnCIKwzu8w8c/Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530971;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NvZ/J9pSrVNeYLvjFX+QadpiWl3r6qeFhyPRGXEJmAo=;
	b=Fb/a3I5PoO3V4zyuLjX00Clol4qSqD+pbMTHEdwB8Yzn88GKQ0eb5ucl2x/VSu5NEFt4
	 w/a3kt/uA2W177qOUf4oRkFlzr8HU0v98As6fY0DUkl8P3OV1+pXLMOnEYkAVnmRT6rpD
	 5pUSb42it9AYFnNflF/h6tm1riOjNCpOJJ9VP3eszrY/BVoyWPV1JvkLpQUW1RAJEk5a7
	 ygXm3PpymKGEBgd8EK7pMUt5gb7Gmu1OKapjk660ptCcZ6Tj8a0wGPUZu0uCZQSe2JV43
	 18L6N+ihcAXnMdb1AYhhcAe6irb7UYyURRmzitBV4URGO435oR+8M+m3INYoxS7ifAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=MzexKDUN;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B772606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 14:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B772606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=MzexKDUN
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4a68190a2a7so3793248f8f.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 06:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795530969; x=1796135769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NvZ/J9pSrVNeYLvjFX+QadpiWl3r6qeFhyPRGXEJmAo=;
        b=MzexKDUNcozbTxl3WiOSh2a99kFGEjQLxIe5UkD4gp1QuuSUMcqAod6yqYLB2hxn/z
         KSJiPoTLkus9XUz8Iv+f8JKw1bzjqC/vQ8trCPz2vSJOrcEr/+ZZa34gpMi4YAMusust
         jqwR+dCmHE2JlzJklN6wl/pHFyHAXvmtBnVa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795530969; x=1796135769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NvZ/J9pSrVNeYLvjFX+QadpiWl3r6qeFhyPRGXEJmAo=;
        b=oq1vaRjXXGaTAhBQZzA5ILJhwh+1b5QJsi7Dp+vpQgl05pqGGrugnbrX0vd9ceWvIW
         1lkh5+RrkabVdmyJgaD7CtpzhDgyg8ELSAYPNLfECIjaZpIW6RoL7WSJHQOU7RjBqptp
         0++ByIKgFfNGWDPo/9baOlVZeS+GrHpoGcF/H47k8vgOtrmYEc3+u989Ua+DmK4Taj8r
         qzlkPPxZw7VGYwcL7dlJtSjVhzwxTz+8qb2eVI8NM5AfW3klz0MKyrwK1bNxzZlufTeQ
         CRJNpTr9igrsAxzA7pHeTnKRYbl/n0h+NSFqkazksLp8VfZtvb0nEbdxZtD2dC6VTMAW
         Yzjg==
X-Gm-Message-State: APuU4Z+qUT2iClcMDSKz56OvvLM8s/KgGUDHnfLJYUSefsans3UlbdHY
	AjS6YmUYXSYFK5ihmU2x+O6NbEvzPk4kzqBEbyWGqUvsuJ2pOynu2jmAyE6eD+IpzeneXRcnjgN
	WahyA
X-Gm-Gg: AZFdTZcBeH+CmI0Jbps4skKUwR0iH7XqE9pA5GMEBKFHkG8WJwIvlLqoxfqJgM/nfus
	li66+UqAbLLSZIk/ABlmYecZ0XzCQNB2dMQ20vQJed7iEHADx+oSv4sp2JNmNgie9Cr3RlB5Nxy
	HkbLvr/ssxmjcTFN02TKRRT0/7ifJId9EChPCthsibOf3BACVKsi+Kff76Ws2xcDk9Mpj0G+Bi5
	m4Ca6L2a7IDmxZ8/WjxklcCjZsHVYcyg2fxIVoMMH4XM0+sOJZfAD7TGfJQ9vUi487gPZEfLZU5
	YTqszHB2GJ+bNEu9eouVy+0hE/xExvKd5DkKcuqSo8oAFllyXYBkGo5O8D6TapD65dwsf/mPfXL
	wTobtvUVzj7nxtLBaevVp/Wb429nPyMIS7J81Mbz8tHJAKfx5iZcID7L/ErIwWsZY3fyFiwqz/E
	v/vdugLL0LdACAaHHvinN8mH99qOYN0F2GpnoeoKwAxil3V8sbOCF4IQ4PZ2Z7yVQJsGVs5dex5
	GlAKX2pLU9ktBWuzJFowfmbqylzctz6MmTX8+KbF87isFwiywZLKAedfI5jVSnKvuEOmKEnb1TG
	kEZ4ALQJ6NCHCoiBLRaMR8mSgXBi42Cby49l5D4mcnmhJx9Tzg==
X-Received: by 2002:a05:6000:2913:b0:4a7:7bec:e16d with SMTP id ffacd0b85a97d-4abb0c5d670mr29692260f8f.20.1795530968558;
        Tue, 24 Nov 2026 06:36:08 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4b33a596f9csm9019187f8f.12.2026.11.24.06.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:36:08 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 2/3] shared/vcp: Keep Change_Counter on operations that change nothing
Date: Tue, 24 Nov 2026 15:36:00 +0100
Message-ID: <20261124143601.245340-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124143601.245340-1-simon.mikuda@streamunlimited.com>
References: <20261124143601.245340-1-simon.mikuda@streamunlimited.com>
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

VCS 3.1.3 says Change_Counter shall be incremented when Volume_Setting
or Mute changes and shall not be changed otherwise. Every Volume
Control Point operation increments it and notifies Volume State, also
a Mute when already muted, a Set Absolute Volume to the current volume
or a Volume Up at 255.

Leave Volume State as it is for an operation that changes neither
Volume_Setting nor Mute.

Fixes: b8a113ecbabc ("shared/vcp: Add initial code for handling VCP")
Assisted-by: Claude:claude-opus-5-5
---
 src/shared/vcp.c | 55 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index d19bd9210..197084f50 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -578,6 +578,7 @@ static uint8_t vcs_rel_vol_down(struct bt_vcs *vcs, struct bt_vcp *vcp,
 	struct bt_vcp_db *vdb;
 	struct vol_state *vstate;
 	uint8_t	*change_counter;
+	uint8_t vol_set;
 
 	DBG(vcp, "Volume Down");
 
@@ -602,7 +603,14 @@ static uint8_t vcs_rel_vol_down(struct bt_vcs *vcs, struct bt_vcp *vcp,
 		return BT_ATT_ERROR_INVALID_CHANGE_COUNTER;
 	}
 
-	vstate->vol_set = MAX((vstate->vol_set - VCP_STEP_SIZE), 0);
+	vol_set = MAX((vstate->vol_set - VCP_STEP_SIZE), 0);
+
+	if (vol_set == vstate->vol_set) {
+		DBG(vcp, "Volume Down: already at minimum, no state change");
+		return 0;
+	}
+
+	vstate->vol_set = vol_set;
 	vstate->counter = -~vstate->counter; /*Increment Change Counter*/
 	vcp->volume = vstate->vol_set;
 
@@ -621,6 +629,7 @@ static uint8_t vcs_rel_vol_up(struct bt_vcs *vcs, struct bt_vcp *vcp,
 	struct bt_vcp_db *vdb;
 	struct vol_state *vstate;
 	uint8_t	*change_counter;
+	uint8_t vol_set;
 
 	DBG(vcp, "Volume Up");
 
@@ -645,7 +654,14 @@ static uint8_t vcs_rel_vol_up(struct bt_vcs *vcs, struct bt_vcp *vcp,
 		return BT_ATT_ERROR_INVALID_CHANGE_COUNTER;
 	}
 
-	vstate->vol_set = MIN((vstate->vol_set + VCP_STEP_SIZE), 255);
+	vol_set = MIN((vstate->vol_set + VCP_STEP_SIZE), 255);
+
+	if (vol_set == vstate->vol_set) {
+		DBG(vcp, "Volume Up: already at maximum, no state change");
+		return 0;
+	}
+
+	vstate->vol_set = vol_set;
 	vstate->counter = -~vstate->counter; /*Increment Change Counter*/
 	vcp->volume = vstate->vol_set;
 
@@ -664,6 +680,7 @@ static uint8_t vcs_unmute_rel_vol_down(struct bt_vcs *vcs, struct bt_vcp *vcp,
 	struct bt_vcp_db *vdb;
 	struct vol_state *vstate;
 	uint8_t	*change_counter;
+	uint8_t vol_set;
 
 	DBG(vcp, "Un Mute and Volume Down");
 
@@ -688,8 +705,15 @@ static uint8_t vcs_unmute_rel_vol_down(struct bt_vcs *vcs, struct bt_vcp *vcp,
 		return BT_ATT_ERROR_INVALID_CHANGE_COUNTER;
 	}
 
+	vol_set = MAX((vstate->vol_set - VCP_STEP_SIZE), 0);
+
+	if (vol_set == vstate->vol_set && vstate->mute == 0x00) {
+		DBG(vcp, "Un Mute and Volume Down: no state change");
+		return 0;
+	}
+
 	vstate->mute = 0x00;
-	vstate->vol_set = MAX((vstate->vol_set - VCP_STEP_SIZE), 0);
+	vstate->vol_set = vol_set;
 	vstate->counter = -~vstate->counter; /*Increment Change Counter*/
 	vcp->volume = vstate->vol_set;
 
@@ -708,6 +732,7 @@ static uint8_t vcs_unmute_rel_vol_up(struct bt_vcs *vcs, struct bt_vcp *vcp,
 	struct bt_vcp_db *vdb;
 	struct vol_state *vstate;
 	uint8_t	*change_counter;
+	uint8_t vol_set;
 
 	DBG(vcp, "UN Mute and Volume Up");
 
@@ -732,8 +757,15 @@ static uint8_t vcs_unmute_rel_vol_up(struct bt_vcs *vcs, struct bt_vcp *vcp,
 		return BT_ATT_ERROR_INVALID_CHANGE_COUNTER;
 	}
 
+	vol_set = MIN((vstate->vol_set + VCP_STEP_SIZE), 255);
+
+	if (vol_set == vstate->vol_set && vstate->mute == 0x00) {
+		DBG(vcp, "Un Mute and Volume Up: no state change");
+		return 0;
+	}
+
 	vstate->mute = 0x00;
-	vstate->vol_set = MIN((vstate->vol_set + VCP_STEP_SIZE), 255);
+	vstate->vol_set = vol_set;
 	vstate->counter = -~vstate->counter; /*Increment Change Counter*/
 	vcp->volume = vstate->vol_set;
 
@@ -776,6 +808,11 @@ static uint8_t vcs_set_absolute_vol(struct bt_vcs *vcs, struct bt_vcp *vcp,
 		return BT_ATT_ERROR_INVALID_CHANGE_COUNTER;
 	}
 
+	if (req->vol_set == vstate->vol_set) {
+		DBG(vcp, "Set Absolute Volume: no state change");
+		return 0;
+	}
+
 	vstate->vol_set = req->vol_set;
 	vstate->counter = -~vstate->counter; /*Increment Change Counter*/
 	vcp->volume = vstate->vol_set;
@@ -819,6 +856,11 @@ static uint8_t vcs_unmute(struct bt_vcs *vcs, struct bt_vcp *vcp,
 		return BT_ATT_ERROR_INVALID_CHANGE_COUNTER;
 	}
 
+	if (vstate->mute == 0x00) {
+		DBG(vcp, "Un Mute: already unmuted, no state change");
+		return 0;
+	}
+
 	vstate->mute = 0x00;
 	vstate->counter = -~vstate->counter; /*Increment Change Counter*/
 
@@ -858,6 +900,11 @@ static uint8_t vcs_mute(struct bt_vcs *vcs, struct bt_vcp *vcp,
 		return BT_ATT_ERROR_INVALID_CHANGE_COUNTER;
 	}
 
+	if (vstate->mute == 0x01) {
+		DBG(vcp, "Mute: already muted, no state change");
+		return 0;
+	}
+
 	vstate->mute = 0x01;
 	vstate->counter = -~vstate->counter; /*Increment Change Counter*/
 
-- 
2.43.0

