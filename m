Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534746;
	b=aCUut7E/akAY9iseEKzSIOfGNnAQ66/0/iZ12tNSAYCDhD4kjspcO5+Km+zOuOXN9V7L
	 kRsO8++A+Fuh6ZuBTo4K+w38MuBhDM12jCw0xmmazUEDk6yGOlybJK6ApOfchFTRFXnVS
	 CnSnY1W9WOhQwiHmywACgJe7fjfBZt4HF9plj8MoOHSePpx8i30zjTr2ZHOzN65k6h46m
	 QR0nzkKctr9VqnjrWhVTtB1NK9f0tWWyq00YQENTgibCfnZPyFNX0TArF3/Zr1KRNQgns
	 pQE/X95e71dbRfbv4AeW23aAN1pdeRhWH3DCAo7v2hvKRvDhAmO4l7V/ziXgtrNS7Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OS9VzfL5jwx67/K9XcB9Ff302hqOeUEgTDlnKQPmW4c=;
	b=Anyj+k5KTmm4os3T/O9w/IkBZS5KSGfTH+jQ76iRtjFmwBCgKzTRwaIVhjk31dKP9v+a
	 lNeiTP5/+6sCafxljrTbqSBM2yQpOLat6OXmgdHXEd1+UG7kknbMYRfYIxf72+yoTAtMA
	 73atwBLxhAy5GqKKLj8C478iS48iCQfFkv6UF+dT4KKtqZ37GG5SAFDzWHjTm0DoH+FNC
	 G0FPXEauUP5637Kgc7FCDWdGOmXV++1RHtFleRu1/ithoj3Nn5JAbwkPGWNkUfZYij17L
	 jGutuVBsUVwCBYx4gJngFMNM7Os5/oveHZv1GGrpIvIwQe7bT8Psksa378jwCdAlfyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oeX2z5Xn;
	arc=none smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9B1606A32E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A9B1606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oeX2z5Xn
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5eaa5e03c47so4627867e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 07:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795534745; x=1796139545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OS9VzfL5jwx67/K9XcB9Ff302hqOeUEgTDlnKQPmW4c=;
        b=oeX2z5XnROeIw4X3fAf+COLxvlZqEbFuW0yCQiYMcsXgWKqERJkO+lMlHIvkH0YYif
         Z3xs89G/uiZ8HZhzJJiefFYoB3oj5Pqf9IQNpcWX5i3Kzo/W3jvd+ACDk+/FQ9uSBZ6/
         34tHvXJMxsAA+06S6Mrzr6X9ONauMjJfYjD0ajKzAgtrduSr7wLEEgA6ETQahNxFnbUD
         Z0ZQedF0HGtTlin+spF50/YNx361AvJsZHkJv7j3hD0MasOA8vf63KwMr+imZVDDNLk8
         gNLP5IeEhN3P83K8PFPq/AUw/HUA3kLH75Fb5sGbs0ZToNJhaRIh/VTtnGsSfC9+wfmx
         XOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534745; x=1796139545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OS9VzfL5jwx67/K9XcB9Ff302hqOeUEgTDlnKQPmW4c=;
        b=QizJwGUpJQt1f0bA8/2KRfupIDqaBFOE32gfWr+BVfnJm1nwgQErLCCbBgG+dBQAOx
         pEt3h4+/HR5AXQ9WI0kKbSzouGE/jl68TpqRhJrRUJZAmRAFr2uYDalw0MgLsa9mV4Il
         KE0KqizKN6stj9SDs3EYMU92D8CN6jNyuRNlbLcvfyfXC6I74peetc2U6UqAkxT4SIOK
         up1dGseFEuARXET9JGH7aePkNjRGHgdCyTQg7VdM9tKGZMD8xM7/ueupZS8zCqWIpZrL
         Hc7lDAW9otIHwBFWACWTYlbKe+VMoEh5YK4m3HyA5QGSQITYb+8dJt03AwQQuchSimId
         yCKA==
X-Gm-Message-State: APuU4Z+cnjOe2hxpF23V6Y0xWLYbyiSW5wvSpuLjTdiAVeAUF4U1TExi
	K0yMf41zf7WD+vZNRGCIUPkBLXRjiNwqDmAoxSXx5ina/aHyqIo3u0rdoh4cNQ==
X-Gm-Gg: AZFdTZexV/Otay0u8lgD1QWECAP4BHQcXgvP93xMUlctokmIs1Pyrfsb4wLcN8P3okN
	Ea1ILHB0vWVTIUOXlJK4DUe6TJlYK4a0D81bFNXf02fH5IB/Zh4hM4xOw5ZB2XfBj+CvuknJjyh
	dIEOpe4EoG23d4akfaxOMIr+rwWTWZEix8TElCtsxqYGqDoQwAM9XqVt4QLwtTEHITKSIt1oI1F
	ScoxX3xI09DQCrPCy2W9BCs92rFgbPMncNMDY48KeCJMBgNQzG5CCU2neYN7UdNaPBuklWKS0JY
	skn+WEKfbjZWTT0Y9Vt/44fGKDuEmlC6VY0QGnNNC1mWsFGeLAEH9+3eHkRCiHeGZz+Jt44W337
	lormoh98Cu1AgssTZ/d1hdb8oWlt3M55PlUXkTjK7hbb8TidveDqx4SOxmOl+VSra9Fpdg5ysqg
	irisgsDyoMZTFSj+YX+EX5xbplhF3tdCYbBv0P11yP0LZGUDBOXG4gQhYfPZBNnEbuDN9qmwf40
	zMPoeIkzfenYnCk8tbDZxUW/g1l0/wjl0iucrzPX+Bbh24fOMqDwot//PABKAfxrGb3wl55G0iS
	4qpmShYBL5ejOul+e+H9H6LTdm+rgR6snV+kysZcHvfSMNhUexmUwMoM5M1FazCBzMCIzatfllD
	mpOCe2SkmG3bVC1L78+1H5/FmEYkdwLphpSM9PuVYo/umLBXBVyN9yJa9tdytw0CDmaxlVOD1Xm
	dQ3rI=
X-Received: by 2002:a05:6122:6e01:b0:5ea:b8ce:7701 with SMTP id 71dfb90a1353d-5ee8272144cmr6224081e0c.10.1795534744941;
        Tue, 24 Nov 2026 07:39:04 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5564a9sm14343463e0c.5.2026.11.24.07.39.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 07:39:04 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 06/18] shared/hci: Look up the connection handle on the right link
Date: Tue, 24 Nov 2026 10:38:43 -0500
Message-ID: <20261124153856.216054-7-luiz.dentz@gmail.com>
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

