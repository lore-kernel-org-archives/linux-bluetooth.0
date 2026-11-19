Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108594;
	b=J+K74c02cz4htmTXetSRSxUQTFbwvEz9Nmgy052AFSJmSSgTF4P1i0tqZe+49/1i+vfZ
	 8HqrWb5U3wpTSnqIuX/wAaZ8Jpu25lfngvtC62/zDMfxh/wTHcmFhpSkHjxnkYcuMkZP9
	 ZHtsgJG63Et+hwroQcb2Ra9icSebSPSUEytuQ3TuDoQZxTRXF2mXRoLPVF+gfqP9G6GGD
	 s8Yltqp2am4RO/t3X652EeM1g/rEbcTCQzUh1GASm2IfDfcRZzzsdeh1y71FaSW/LEq40
	 gOyXyKaB9D8dqfSbp3Ov7p0Tbkb44NBadhbl5GAKhHXoEEpA+647dyQB30bLin8Ud2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OS9VzfL5jwx67/K9XcB9Ff302hqOeUEgTDlnKQPmW4c=;
	b=k2zqioR9/QUdvYge7lFOrfXPFMQyR+n4YCs4WVhWUohULbEZ+InghHD0MrEvd6jzOfTN
	 LQDGT0IElbNMwh/XJIbfTTKsKfAx56VNRB+iqVAoEnhW3QfEEyvwMOzT7txIArG0fTelo
	 J8zoiuD4fa1Sxao2X8mdH27rpPNzlyQm2qHLc/3Gr9TyzZf0LWKJU1I3qy3vslP69olK3
	 yxNMh6Ra7CAtdlDf0knThm/XOPDGVpklJRs9ytc23TtQwkXrB6BW5F30CoH2vtYU73zKv
	 5IzgynIyQoBfXz/tNi2744n9OODP3fMkGXNjIyJsLbOlzWmR/KfKtso2RbNv6oWyudA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SHvwx2H+;
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59840606A320
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 17:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59840606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SHvwx2H+
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5ee36376a0dso1301540e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 09:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795108593; x=1795713393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OS9VzfL5jwx67/K9XcB9Ff302hqOeUEgTDlnKQPmW4c=;
        b=SHvwx2H+rLCNfejx3FYWKPFchjNJAN0zXciCCkwONqY+oPysJzhoLQbLJP21dhuH2X
         SSsh/X5tTNXB6XAha5LEzj4LyyUju/kQBkipOM/1b1RhcEYE+wqZUScGhYjM9eAdLbTr
         dU9Uca9DuemlAw7tmwm2ouMwRzjgI0ITu1o+bO1Z0JoTal+frokRQLzLVUUPAFFT8Jib
         S0DkEc3MO/aGNy6uUHqgpBN17KDV/v1RVUiJjEYCSCKQkDXbODAVIwoBloDEEcoyNKkE
         sIfxIOdY+86EwbnxUk5bHSICO3HZI5iah5LwofGIcPm8smYF1slSPoFTwOxijNi8TNCP
         p//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795108593; x=1795713393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OS9VzfL5jwx67/K9XcB9Ff302hqOeUEgTDlnKQPmW4c=;
        b=dRQWxK1uEL3N/3gXGjLPttk+lNkhecZpTrIWjwRW8waTfWJA47mJFyiPGRKrva1Z0C
         B5yYIpsoLQ9NiG91KDOwSDxrDmg4cjIwJVvBZz8gxujWoOfFACI8pPa88qX5fMmBQCU7
         4PXmJVmYL0E93JCCtre9EYaR2egwV6hbybfDYf+wck6eL52WbE4TjUj1uCSOyHxZ+7wa
         MFasSW6OoNNLYSXslyIajP0yQrC/XlWBESmBso7OdbnOFQiBl1NAwl/KkZDoxcOIBukA
         EGi/gWKIK+jhowBYuHGoVjVfGr67QBU/VjEmnTZDjqVV9e2Ye49qq25cbAQX3ffyXWNC
         9/PQ==
X-Gm-Message-State: APuU4Z+zeLCy3N0epR94xEZXiuWZsgRr/sF5TTR8Mo2VGPxpPRqSNy+Q
	281kvGnwn8+RKS0rz3GXCCAE4O6yP1IJ1yjLDuXXTZ8psBlhCqZVP8HPTqZXXdfQr1c=
X-Gm-Gg: AYBFou2bRZ92wIC2L26pFh3XfONUvLRcw0Wabj9ycaSCzpyUTzUscAOb+yIuZfekSsq
	uNccSv9QiAiOIxjrjQgYRQlxesE11kZ/40WF8G+KlUbzadBDYjN0VJ1Jpumjsk8dDU8PjdeqSp0
	ZR+hDgGcuhu4SgQWRTrw7c7gF8JztKTrR8MNa+yvbb1YQG5vbUlX78jUqobqi/n9zE2gFOMvqaA
	GczlUc+AeHBiNJ3DyyDyq49sToMpDX7tscuNFenLU5DEmOvR7holl0x83Gj9x/ZmHoxaH7Ew1V9
	F6sulwO32sNmkwR/pHnD/Pq9mH8v3yaVePRRzPeFK8jfDdkfr7+cFotyvzPAECtjz6BF8mhGsy5
	TYD/jXA+OwWYF5MaW8suc4Q+Bb9q+0zFG2lmbfGZGYg2aB4cbqlURJupQiZkQUPk3Nii2AIXIDx
	LgJRCOIB2xeQmVwXG3u7HR63l3+A+Sxf/i9CVimm+dGGMijzjOkZtMhLpIUlIDb0NutXHK2nifg
	L3iMvpiibN+0sxQWE4jav49pHuTixr7EMdiFHB5I4Gbp6TO8KU0xD9rflusdvFCJOM8GyjKR2ub
	+x5ltpJMqX4PupnY/J+X1GAEWqJs9JlQaeXoPy60AniMZByaHu2zJnsGyL0Tu2/+f1FNT11SjGJ
	ocDGMYLeN/mfVri+nchbAy2srQ/1blVFVyAAQyReYNk2cjnX5S0WffxoIAC0xIvxbfrdux0uL81
	+EdEcpQ+wFqZ2laY4Om7yAhRKA
X-Received: by 2002:a05:6122:3d10:b0:5c9:c60e:5cf5 with SMTP id 71dfb90a1353d-5ee8af2e0dcmr293652e0c.19.1795108593040;
        Thu, 19 Nov 2026 09:16:33 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5a8fd3sm131881e0c.8.2026.11.19.09.16.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:16:32 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 06/16] shared/hci: Look up the connection handle on the right link
Date: Thu, 19 Nov 2026 12:16:14 -0500
Message-ID: <20261119171625.1014004-7-luiz.dentz@gmail.com>
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

