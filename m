Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193722;
	b=hzarjUFmEFHI8/8/oAB6/04SJMjor6zZFz472cS69Trw/MwuZ4Oj0Bmir2N8waasB48S
	 9d0qJuNzIPU72FDVcaQEyH5+fF1ffNtdYFQrB8xV+m68FZvGVP1O8S+ucsgC9AOfbtEoH
	 /Ce70incKigounNjC4Sl3vacF/SWbUyb/LJp4g/J9MhBnLF1dSdRLPRrYxXan6PPiI+zf
	 oDGtV5DPislw4Zaw2JdImKyjPd+LmGRNVGZtc0EukFtBLcpF6R8HKA2Goo4gl7jFhcxN/
	 YWlIoN/KtT7dh8AnlMLXinGRC7kIQOvjAdLouYoLfSHDsSDTuECLPfFt7SxD/MqGInw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193722;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WwoylUVjr+iEAlXPsyZXRA1E6c4PH1t3s204TzCZlVo=;
	b=K72ypNv9+XEW2dSlwAcZJXllAhSiwEAmFu1CFifYs7Nv75nQ/77QgvUmaTSFV0NF0P2C
	 TTQbmW63X+nvzE4xE58oVq8b6qB5bB29ilCtLhuHHrE1QYKjN3GZVBJV2ddLkk4LTvwss
	 un3wYJfyLjGuTK57IB42GK2wc7jQzxOUkRuf9k+LDCoGRYXCxtvcGUHprKzyVaW6WIktw
	 n0AOF75X5xne+rPSlMMNQ/FQoerRs/1ZCniUvHnDpV/wJJRycUyJqUFVuQydWRpH08MQz
	 RfJgd7LdBEDf3wJFNLAP5nTXxLVkoq6Q1LT4U+g6DLEhqfv9PY5Tr9Gpw606rJlUAgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yH3ptQCr;
	arc=none smtp.remote-ip=209.85.217.48
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7D760A2614
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 16:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB7D760A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yH3ptQCr
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-7d2ccd3c7a2so376895137.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 08:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795193721; x=1795798521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WwoylUVjr+iEAlXPsyZXRA1E6c4PH1t3s204TzCZlVo=;
        b=yH3ptQCr2JYPRBHiLZP63XWIz9eIqAxc/oBeiXLGIo3Hktwh7EQ1AFRDBLTFDXKEg3
         nWjK2qWd7X7a19A5H1yQFVM/oIUe/dEJkmjX4u9SZ0ojXFQFWVcc0p/b9iJ38w/8em0A
         GEZfdc+yXpZrG8rVMdzXtWKK2pLHVqXPVrwTt6t0AHnaUfPz4wKuCLNyNImOVpmP0Mgp
         mMDuqPqzA01L9etm5o6fjI1neVzZiyEvrBUfct1zC7toXntsdyIdaQiJCmBbWWIPMRRV
         pqeDlW10WR6OhIjQ+M5827UWmY/6iSSeiwfHpVzvP7ECyi8BF7O9UOeZ5/XqsAOyodDs
         B9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193721; x=1795798521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WwoylUVjr+iEAlXPsyZXRA1E6c4PH1t3s204TzCZlVo=;
        b=XaAJaZ35VhE14/cMmS2yH4aqAr8W0Zs+nHZmejzr00ZpHmMNwD9TE51aDzFFsJ+k0K
         wqkujOodUmra7NmJdWnSZirgiIqHSTakz1atl/tvmVDN3BN5cestHP1V6WNUMPZg3gbh
         xW+HOmUx+3mGJhYCWA+lfeM9bDy8wskqOQ1s+u0L85XftJMOvx7YsUyZtPSAA+cF9/Ue
         CCW3kLXYXMlJUiXaSgWf8K7btGIUizyj8zAlwG/jwrwmO/DBNFy1UgY600xgHmW0eFVD
         8AJZ8TB5hWC166ILRB3kR3eT9OiUzqj+6elc0cbeU/GRHuPk5FjXnu5IHcR/6taTvUxL
         TC9Q==
X-Gm-Message-State: APuU4Z/yfwthRPDmBK8xt7DH8FfCX+uoNUICYUUIjv9bev5dOx5tdrFF
	Tyc+fZYUHGjHpmgqeR48AG4QUYV3MlcVbEBogNGcT9DD1tL7oMXqHM0B2xKbKlGz
X-Gm-Gg: AZFdTZcgNafdUriXm66YZM4HjHpy+eLyPiAq+jveZWXWoeztz3UM7JrraxsaOWLzh+S
	rTpvn179WdoW5aUBRhrsv5T17+IUMy8SE03UiqKj0rzAs9M6MLppP9GudQ3RZwjh0S+MScUtjbN
	wwV8Y+J6OkAG8ItQJp0xNusWb9yKnfX5ELOstiBRGO3bkh7lW4aR7CzL8zc55TOAP8eb5A6fLoX
	frICCPI2cW4PdYclDg1sJfSwsdkkB655iv7uVkayZtM7UzcUAeeQtbxiC/a3m/s84kMaIeuljiz
	M77+ehtHPYfolHUYp11Dpv6PGCqHHR34irpioThfnt8PlRM9vrN5JYu7UACm1gFuPsbzJBCcTod
	vL0BpcMRBsj9f3I9x8LSeB6orDScknYaHMurUWy3Tj4rbFFMbIQ7a0N5fv/rWUw1ffRw0u2Xgbb
	MUdgsGV6yRp4YxSy4DQoa2KIBe8+5KkcTJRGokJwgSXU/OIG/0mUqj/ZfEDUb2ngonldFbyLEze
	B/yqVwU1dOHxOHm3apAwPYf/uxpI2MAC43C4//aJRUfG5nvMtAOLiZx4VUigh2ZF7Fv9zTYGfl8
	O54YtcAcQ/X1RpRrOCVZyutR+Ijw5kuDz3QiFUu2tMFazd91RQ2euCnzAWoJfCCgjZdIoHrOvUG
	3MbmidUnXfekGO5F8tNwZdZcmbLzfmOq4wZRMi9/rMRSEyhw8EIStq314n8FtCPoFIQ/wNA224L
	9nR8g=
X-Received: by 2002:a05:6102:3ec7:b0:7ae:c2ca:8e1 with SMTP id ada2fe7eead31-7d7393581a8mr1601084137.11.1795193720753;
        Fri, 20 Nov 2026 08:55:20 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6df8a28dsm3486193241.4.2026.11.20.08.55.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:55:20 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 10/18] profiles/ranging: Act on a CS configuration created by the peer
Date: Fri, 20 Nov 2026 11:55:00 -0500
Message-ID: <20261120165510.1858959-11-luiz.dentz@gmail.com>
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

