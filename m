Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031934;
	b=0bx6Wktaw1wkDLbKNR7FjHvbSmhnsJU6j2ye9HcLOnDpyy5NBTPPEqHgLMhD+bY+jl/N
	 xV/1ufuYdq07D+skqI3RZUt/iuB//rVte1ZWMHwd/YEY7wY/jC5ggoVxHb0CRPfuDP3xW
	 ndSIBWBvc8fjJ/OTMNi8tEbTrBpFe96OJG0eOf/ML3SMukIl3eqn5uYbWnibp83401uoY
	 vvEJuXyz24UYiEL57u8TXDOJbvjqwSByJ7tMLmbHciVcTkKb7OQi58GAlTLU64zz3bBfW
	 UiVCUF352P5iqlZCmncCovIZkWnSnjoExkkTIS6CfFCqYhBynNO1bcVfHiUl8Cf7Pcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031934;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OS9VzfL5jwx67/K9XcB9Ff302hqOeUEgTDlnKQPmW4c=;
	b=Gh//UOtT19ekFedAQeAQD9lEFQ0ZZgGyvioGfPNHCI/nGRJNfD2oUml1sID4nkWzIYRW
	 s+1ME5V1IlkGZR5aEeIou+5k4GSB4ZmjggvOlLDVdUm7OC46pFqssw+d3iVLUe1FNyQpJ
	 pF1DdJwevD7M+NL80yPRCHI19fBN0bL3RWSQs5TDR4uVgtPa6poZl2m94sbiBb0vFqBS/
	 QCNBMUq9VzOYrtFqoZQKyLBQbw5aQmv/MBzavjYeK3e6zLDKQxpZEg3btEB/ZwhqVNrbY
	 6CTYgsNetZAdoNwJ2xww4wmRIaRg1Rdw/U2H2Z84adgvuroJQCb/BMXxovijyBdhBdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SgLE+Lvi;
	arc=none smtp.remote-ip=209.85.217.54
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80324606A332
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80324606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SgLE+Lvi
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-7cc2bb73cd9so543057137.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 11:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795031933; x=1795636733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OS9VzfL5jwx67/K9XcB9Ff302hqOeUEgTDlnKQPmW4c=;
        b=SgLE+LviARoi4He+r61MudJ2CR0yN4lt/K1u5fAM22/vXgN/7zT+/vb8yGa4ryAI1t
         sbqeIBe18XRh1hyJLsU2p5tBIT7ebQs+4NJockLpMeuz18X2jmu30y06PdoStGKn6b6z
         OLzx+xvoBk4fWf5Zj3YwiSsEmY7LU9sB94D898bUwLpQSgc+cE1KkI/fIqHXeZn8o9ZK
         tQq1c3j/U7gZvZs3tZ8BX1Tf75pgqXYatMKrddHDn+ygrjxqfs9nxD8s+hqG7hz0FSwR
         KND9ZkiS4fbI5zHLIIheonN423ixQjwl8C/V2+g5MoQ//0FXb9WqfJPzXhp5OVZTCinV
         A9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795031933; x=1795636733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OS9VzfL5jwx67/K9XcB9Ff302hqOeUEgTDlnKQPmW4c=;
        b=yMluTcqoKdeEbnGyJeLxFClfEVrO8rsa+i8HvTcgO2vaJN3t0rM/jqxvGY2OLZkfN/
         d8TGjvlTGNuWm67hXS/SRp7pAyP6Aer+XAIV7+555mhF3/BIp9ld1yi6QU+KnFF5HEcB
         QFr3zdl6/frjWHvg1Rwy1iLxYzbd4i+w5fOGMISxiPkmgRv3EbSqT84vSxLhGKCo7WUS
         P6xsTLsmZ9Ea9/Q07ftZy9lo+86EYlr32A+VVpvsB/wFdLW6W+mVL6/Mum205gY5JD+B
         6mUYNt/nM3n/6NBTnXthkXItA4bkKt/kFTXEfErz9DsUafj7YlARungr3jvKP3/GywJV
         61xA==
X-Gm-Message-State: APuU4Z95hYMqO5uH7wuLRI8Th3ZMvK39aeeY+Y6mBUphAiKGQ8t55fch
	SfQJoeBe6Nqn7lglJaYCSUtY7DLIDWLMIArqfUvAuvZgDWjxXuwZ2/PHppE8p58S
X-Gm-Gg: AYBFou08jbe9FhOwcbMa56QkHFxDIyPBfOebZaP4Rj26A6zFhZTNcoqw+JbOe5qj1sX
	IN11RSgsucAXvwHLzDWriLITfhTy0RfgQJ0AweQgb+UZCfXlr0NdZi1bDSBKeXDTAXC/b5tO2zh
	vycKO2SW8sLw6xnEAQ5+WXj5fOalKfjQf4A7lYWLo8R1uyrPf4uT+m2rpGoSesXt4wGm1Br5nE3
	54yKXoRPWaPI7sQpML1QQrmW4aaIijwRF5SwU9c1FBWLmmRk9Gww0MERwof7H0Zx8KqnA4O6rgp
	JcSWhiJqJPfukl2ijBGWdFKQ7IN+rbgV+2kFXgaJCKWI4W/KxOmbLb/UKxaVpq1DXHKmY7iZfyX
	liF+ODzYRyvWXrcLtqVoDuI575xnRCVgqvhobAX1G99fU1aWeepwFP99y5r6Jqv/g9clgRSvrDU
	6ipCWpVfEJD+gJj1rnzhJ9MwUEB/q6V+6ew1bG5pn8xiW69X1hUGLuHBc8K1Lqq+02VYjhbGh8J
	wqu5FbIzp13EW2EuiaprVnK2wH7GGRnwJ3VLPZxgRL/SAc9gbz9ssOMhxtRy/hUnWxfwiFiPYBy
	L9XHeg/4OgwDxjzXaP/9JtaVk8WDrs2nhIrbj14kOQKM/L5++9iNK0wQ5pXzn8mojQ6tdJjYlD7
	jDHwKMp3ItzsuTkFf1Fpnnnlvi50Ia803B5aibvywfYEkNp2XyS+y8uN8SLRfJ4I2LiW7REc+nb
	XktwM=
X-Received: by 2002:a05:6102:d91:b0:7cf:61e7:e789 with SMTP id ada2fe7eead31-7d6ba472205mr1269020137.24.1795031933398;
        Wed, 18 Nov 2026 11:58:53 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b91e87f4sm2685571137.7.2026.11.18.11.58.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:58:53 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 06/16] shared/hci: Look up the connection handle on the right link
Date: Wed, 18 Nov 2026 14:58:34 -0500
Message-ID: <20261118195846.393710-7-luiz.dentz@gmail.com>
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

