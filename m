Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795456293;
	b=rvAkptBo7vBvxTLwnZJalm134pr9Kf8X1p0L/y7wB3zK3p+dSBEpWVdPvkZfN0OuPQ4n
	 tqvqrMzA0A+UHthT0zEeqmEQQh0l8XZBi8wn211hF0lsqU3rNftOR30BJ+1UabexF2YY+
	 c8SpLLKIX5zwQChmd1R00sUOtwgwONghMRZm8UY3+o52ExXqb3qIBlK10aoE+hcDUETE+
	 4DF3R4UO6SlSvAXG7w+C3TGF2GnRulDjIkMSw20kWeuKOf/ZF4k3VnFG+qKQyIlSIFfTu
	 +51rGWlZod75B30e6n70F6V/XqJT03rIOFdluxD8GaDK/sQFuG7mCyRtSgQjkKdkZsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456293;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OS9VzfL5jwx67/K9XcB9Ff302hqOeUEgTDlnKQPmW4c=;
	b=wZ9Oips4nFmZ8g3FAH1hD6/Hekotoz0BTT1Zr/wCIDu2B1QiQBSroAhaX8OtPK0Q2H+U
	 YQpnFrnezh8YWfnE05vT72A8hjBR2QzhNG+8BEA9JM2nDlBiCjfm3kIMDeT6MPs9BKW90
	 BfZVgmo5uQC1iioG1kT5ELg6LuO4PjDrxlXsstOvUhUZrb7x/pgMdnNabEETQTmBCfkMr
	 YFGzPVdd3K8fSWWsRTMm91BanomWvcPf4D/uLDIKLukCqTJ1sGxQLeARbv/Lf+j+A+8GW
	 H9kemZYkobPRLweGqzySHliXK0FyY+dO4M7bzDJuYa2adJBYBPblVriPVONmycEUCxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mkTTJu79;
	arc=none smtp.remote-ip=209.85.222.44
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD59606A32C
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 17:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFD59606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mkTTJu79
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-992f6d8cb51so671902241.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 09:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795456292; x=1796061092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OS9VzfL5jwx67/K9XcB9Ff302hqOeUEgTDlnKQPmW4c=;
        b=mkTTJu795aQ0b5hYt85uaLxju2enFDJPT4TaLy0xqorhWjE4ys8NtGxIV6F67zWNyB
         Ygw3qPX90N4bgFX1A8/JL5dBt5d4kwVfxAIJXunyVWw+DThEhU0po7B2Nh8X8DbnuaAy
         J1lBRA+iz2+ZcGfk8LqTlj6aVh2/Vb+y8D55uNrpwXooFDGEAGss66d7MFmJ09r8zAjh
         GS/4Xj6wzDam8kD2+QNE2jFcg59P+NvWmknUdIXo5X+XtPmNWGaUt2lduyaSlIQNgt/G
         NLknhkMrSqcvEXZbY3fyJuJE+wVPTv3zWS5d7vtHx9cRmrSx/v9P0XO9nFEfcWzzSaD/
         jj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795456292; x=1796061092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OS9VzfL5jwx67/K9XcB9Ff302hqOeUEgTDlnKQPmW4c=;
        b=dNWgG01w0p8M94tnBEUNMN/Dkbyomk4xG1AVPKHYkHdh/4LCZQI4RrGMDAIbDI6V2+
         VwAEviMsOeOqWAR2jdDIrdlxjDqitlgnvuHvPi5tKBPOQUnUtPMpJ1yeZUlJAgyIGcNX
         RSixr/7hFunTN4gBvaEZHyWMthF6QsAW3rKfSWgDpAMquvQkSRRvW01Q8nMl3oYhNwC1
         DG2WCTn2P7ZLfYe6Y+HwYGXiniS2IAQuQ3rrg/RSaja8iZca5huFx5BDjIlISntZTD1L
         RjlyyZkVhfOU2gcTVCu86SiDOAnQAFbX4YcErKo2gdMtuv3klWrhVq5FtLtzsckr4IGB
         n6lw==
X-Gm-Message-State: APuU4Z9uBBa8+qBDtSAkDg5IBw57M1Vh9isWGe+XbUUvl5HuY3UR5GW+
	SPRP+3hDBlPiZzcHeTuXxKs2ZQVt73WgtRFoY0F+L2igjtq35R5a+PYqzNUa1A==
X-Gm-Gg: AZFdTZdkajh+UCaL7EQEQ4YFwcZ5nGwjXlGMDKqbBfxh3cMBOAl1TwiB8v9quWdFUiR
	IGfnaaIuRFgBLkgaFLhD0sLiTwpsXKAbGA30RD14hQf+1BZ6wu/FKWXvw355tJKGPajFrrYBAQi
	oecbmv77Q384eLfyXJNOGUZDH4mtruTV/AzwSU/mGOLIw7zJsySkaPSJ7H2xDlV6CrS4AnI9bLj
	QbMviC+rIK9x6T1tQKiBmbjMjCSOHhGge97zK+vnUj7OF7d35FGJoI5T9Wscsn+E8Cdbu+T0TLI
	YWSQVfHT5pr8eZmfy3wAjcsLvscTWYD8gnIKOAwR62Wf68uzK7GYDe41fuHn+nnpMvE5SjPtaVk
	1HVsL1UW5ENGEmrX9Yrw2z/XCNqRA9eX5k378jIabD7KXXTclXWI2v3xZy1erNEoOW99K+hlxSi
	zdLd07dHUMY+hP7MQSUGmV+ctjQojDK1Ml3vvBFSGuom3qtHhviWKTypBCGSJe/Eaq56QFSTqwD
	5fyTmRrfudaJJe2Kd76969TV4IN0waW9xh/O3h0xWbzHKQ3fjqB7EL+7en63el+TuheSSDfWKpU
	WIRqfRWUc2oK2DZhbkeAhOZiF6AaGUH6pj9JHs8QDlLrrR53IIR6310IbiURdxeKKt5hOWD8sWs
	YQajS4Ti4cOm+Uqh6o0Gw0YLi85lUvtg2vxvU9bOz6Cr/cLRT/J4zQV5qLjejl7k84rXjBPT8/h
	VLfCU=
X-Received: by 2002:a67:e104:0:b0:7ce:78f9:adfe with SMTP id ada2fe7eead31-7d739457064mr4504324137.18.1795456291830;
        Mon, 23 Nov 2026 09:51:31 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e7f92680sm12795393137.5.2026.11.23.09.51.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:51:31 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 06/18] shared/hci: Look up the connection handle on the right link
Date: Mon, 23 Nov 2026 12:51:09 -0500
Message-ID: <20261123175125.3642617-7-luiz.dentz@gmail.com>
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

bt_hci_get_conn_handle() set dev_id to 0 in its HCIGETCONNLIST request,
expecting the ioctl to fill it in. The kernel reads it instead, to pick
the controller whose connections it lists, so the lookup always went to
hci0 whatever adapter the channel was opened for.

The list also holds every link of that controller, and the first one
with a matching address was taken. With a dual-mode peer connected over
BR/EDR first, that is the BR/EDR ACL, and after a quick reconnection it
can be the old link that is still being torn down.

Remember the index the raw channel was opened for and use it in the
request. Take the link type from the caller and only accept a connected
link of that type, so that the function works for any link type. Add
LE_LINK next to the other link types for that, which also replaces the
local copy in hcitool.

Assisted-by: Claude:claude-opus-5-5
---
 lib/bluetooth/hci.h    |  1 +
 profiles/ranging/rap.c |  3 ++-
 src/shared/hci.c       | 12 +++++++-----
 src/shared/hci.h       |  2 +-
 tools/hcitool.c        |  3 ---
 5 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/lib/bluetooth/hci.h b/lib/bluetooth/hci.h
index 2e4aa394e13e..6f51a2e10fe5 100644
--- a/lib/bluetooth/hci.h
+++ b/lib/bluetooth/hci.h
@@ -210,6 +210,7 @@ enum {
 #define SCO_LINK	0x00
 #define ACL_LINK	0x01
 #define ESCO_LINK	0x02
+#define LE_LINK		0x80
 
 /* LMP features */
 #define LMP_3SLOT	0x01
diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
index 2d8b1a7a1364..d23c3f8e2e96 100644
--- a/profiles/ranging/rap.c
+++ b/profiles/ranging/rap.c
@@ -18,6 +18,7 @@
 #include "gdbus/gdbus.h"
 
 #include "bluetooth/bluetooth.h"
+#include "bluetooth/hci.h"
 #include "bluetooth/l2cap.h"
 #include "bluetooth/uuid.h"
 
@@ -1099,7 +1100,7 @@ static int rap_setup_reflector(struct rap_data *data)
 
 		if (att && data->adapter_data->hci) {
 			if (bt_hci_get_conn_handle(data->adapter_data->hci,
-				(const uint8_t *)bdaddr, &handle)) {
+				(const uint8_t *)bdaddr, LE_LINK, &handle)) {
 				DBG("conn handle 0x%04X for %s", handle, addr);
 				data->conn_handle = handle;
 				bt_rap_set_conn_hndl(data->hci_sm,
diff --git a/src/shared/hci.c b/src/shared/hci.c
index e8586ab5014c..f1d663be111f 100644
--- a/src/shared/hci.c
+++ b/src/shared/hci.c
@@ -34,9 +34,9 @@
 #include "src/shared/timeout.h"
 #include "src/shared/hci.h"
 
-
 struct bt_hci {
 	int ref_count;
+	uint16_t index;
 	struct io *io;
 	bool is_stream;
 	bool writer_active;
@@ -463,6 +463,7 @@ struct bt_hci *bt_hci_new_raw_device(uint16_t index)
 	}
 
 	hci->is_stream = false;
+	hci->index = index;
 
 	bt_hci_set_close_on_unref(hci, true);
 
@@ -972,7 +973,7 @@ bool bt_hci_unregister_subevent(struct bt_hci *hci, unsigned int id)
 }
 
 bool bt_hci_get_conn_handle(struct bt_hci *hci, const uint8_t *bdaddr,
-				uint16_t *handle)
+				uint8_t link_type, uint16_t *handle)
 {
 	struct hci_conn_list_req *cl;
 	struct hci_conn_info *ci;
@@ -992,7 +993,7 @@ bool bt_hci_get_conn_handle(struct bt_hci *hci, const uint8_t *bdaddr,
 		return false;
 
 	memset(cl, 0, 10 * sizeof(*ci) + sizeof(*cl));
-	cl->dev_id = 0;  /* Will be filled by ioctl */
+	cl->dev_id = hci->index;
 	cl->conn_num = 10;
 
 	/* Get connection list via ioctl */
@@ -1001,10 +1002,11 @@ bool bt_hci_get_conn_handle(struct bt_hci *hci, const uint8_t *bdaddr,
 		return false;
 	}
 
-	/* Search for the connection with matching bdaddr */
+	/* The list holds every link of the controller, so match the type too */
 	ci = cl->conn_info;
 	for (i = 0; i < cl->conn_num; i++, ci++) {
-		if (memcmp(&ci->bdaddr, bdaddr, 6) == 0) {
+		if (ci->type == link_type && ci->state == BT_CONNECTED &&
+				memcmp(&ci->bdaddr, bdaddr, 6) == 0) {
 			*handle = ci->handle;
 			found = true;
 			break;
diff --git a/src/shared/hci.h b/src/shared/hci.h
index 5be48577f9db..a91d245233a1 100644
--- a/src/shared/hci.h
+++ b/src/shared/hci.h
@@ -49,4 +49,4 @@ unsigned int bt_hci_register_subevent(struct bt_hci *hci,
 bool bt_hci_unregister_subevent(struct bt_hci *hci, unsigned int id);
 
 bool bt_hci_get_conn_handle(struct bt_hci *hci, const uint8_t *bdaddr,
-				uint16_t *handle);
+				uint8_t link_type, uint16_t *handle);
diff --git a/tools/hcitool.c b/tools/hcitool.c
index 1903d859bff1..fc4fc1709ff2 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -34,9 +34,6 @@
 
 #include "src/oui.h"
 
-/* Unofficial value, might still change */
-#define LE_LINK		0x80
-
 #define FLAGS_AD_TYPE 0x01
 #define FLAGS_LIMITED_MODE_BIT 0x01
 #define FLAGS_GENERAL_MODE_BIT 0x02
-- 
2.56.0

