Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193719;
	b=Lj0uFACDI1/4Pk6Cnh4FaBu0hb+9hIwiQKy0etR5nS/TioCDJeK4uDcHEqB1GyRqFnkI
	 Djzsd4BpmX/ZOaHHoHQpCSCAEFdKyvXokS7JXRKPQf1221Sl0Aaw8QyXZQJiQeARHQNyb
	 a4HT7fB5PJI0X3K6+cA/6h3s5d5NPR+beApk5xkmzk+WoYyDePiQfW2440qqiPvkFrA6R
	 72pMgsoZTo5fJZvH4pJtw+vV5Fzxbo9mO6Z6ZaMLws5up4t0bF8bfawsHbJfdn8RJgFRR
	 q/LslKdMq+qrvt9jtK+x7GpVaVVSMk+MpaWwgjbhTjWb3WzZ4UVc80A1WQhNLGuGbmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193719;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OS9VzfL5jwx67/K9XcB9Ff302hqOeUEgTDlnKQPmW4c=;
	b=J+DctneIL1xYHddYuiGH0PKMEkpniQXiNsa81xDm+vS2ForU3T464KP8ZtiolndSJwEX
	 8KK2l8tB36ykATELpuxHIn1qZITu3ohLwyZbM8LzA2xxusY+/jOg02ZL5X7XOxbPFguA6
	 KcLju+8z9/OqORGJZGoEXxZNCA8lwhL+ItkpwuaWG5OKRyaxSqDy1961dynWJo61LauxT
	 qGnfBxbqJGnxZta7bMBvLdd5eWnw55MQH7p9Fh/YHMP4LZgkLHIw7z6sU+aYE68sYAeWO
	 He0a6ZwM+nzbQR3+0RAKvgn3kIOBKFx0fV1hYwMfaWjToq28Sd/INqSzherobbBhpFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hPuWQTaa;
	arc=none smtp.remote-ip=209.85.217.51
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAD360A2600
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 16:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEAD360A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hPuWQTaa
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7a6e560f580so734590137.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 08:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795193718; x=1795798518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OS9VzfL5jwx67/K9XcB9Ff302hqOeUEgTDlnKQPmW4c=;
        b=hPuWQTaaUdYgqUNnu4YJA62XUlvyG27cw3B0+n70XuCsz90S4QaKGRzoFyQDStym3+
         QNqsheWmKd6RlNpm2HBIB/XIYiHMuRG+u3D26QPMUBUFcYUA4xpIfTPu20Z2XORqEhTD
         uWx4My7bOKXcNoMemthLauVvJTMHEVhn+g4SLJXbGiECxpdK3U0+AvLtDk4Sow1TPW5f
         r8Vc5RRYjpTKq8vxvzOPMMlGUDdvPLZjie+0l6rAfQuHF+dTYCfRdoO1JBB5UE6Lk/YU
         yfDpht+TRmLWOxV58zScWUySbgE77iPtXEmtzudfRaJruEYmQf95EjlKxe+fOhGebl9e
         2TQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193718; x=1795798518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OS9VzfL5jwx67/K9XcB9Ff302hqOeUEgTDlnKQPmW4c=;
        b=gyPeh4EJY3euvTzRTm4SneFpDJaVsvgmwiV8lFgH4UUG9x26/zcX19Cp873lB/r1Zp
         Ua0ZGJOF0qvUvCG+zYwutAIdMTAiciZsXFO1BFBMv1py1mT2YToHSc7A3ZK20G2JbWxb
         DAxgJqYfvDyawwAKee4QbpNwvsiMyyIhoTczau8pE5+RX05swUbVEGVrxm6UdIYSaqZ8
         SJeRhWyWrl+cY8hE+3DN7IfyGErhm/0hnKTH1pSiACh+y9VGHo8mNceqLg3RruehuG8S
         HCF1SuAhIMmg6k5fZSUz8vrN6fpQQ72rQQ89p2lRLnezNz1WYn+jpj2uSlwtdGxR7hDv
         gzAQ==
X-Gm-Message-State: APuU4Z+1rqBmvZCkiB4dmo8/iAx7/cQWgq48RywR4JcWjz36UB/aAHiD
	XznPqB1EE0BAUa6xRjVYxi3y+pZOU8IOe2pE7xPRqpFH3KBlD/LUEaRn4BYsa1rG
X-Gm-Gg: AZFdTZfwjCGV/TEEeue8g4OVzdBLVMYJ/38NODkGIsB5lyF7cIWRN3keaF6O45eN+TG
	a7P/R8Ygfzt/2WGBEayelWPXdKkIr2bFvOjoDazCSZQiceTCqm5VdtxubDBVDOfBZ1sWnf+cPqV
	dq4ZgiTBhQKrH0glhZ5H7dvnc3YXZJXLjx1He8JQGGVfaELb6LNi9M/5+rvhj48fWgfJP8Hfffa
	7rF2kp3niDlRwX2VNWHPkK7m3yJqujJ3dsE6B6yp1031XSFHkz4WQwY+P6LMhTj49RveQgW2MGF
	TOppyI/2U6Syb8R3egjTKqKAmitQz71U0uvfZw2kDQnTyfu8pU5kRDYvtm3QAoJUkI+X22EmVBM
	SzXnQgDlpwkKzPF9dxddx4WqSF5RiOVUHsQV8YHSCvfajp3dWW0NY9Odk/Odz38CTfB85cw2hBT
	TTd6yyWhZfWx+Q9LQPO+FX02/wkFpGfJYu6u2hxD8snkbOnHJAtJAyz8VkIxTfE9bLzy0xf9D1W
	pXkdTSfACZhCHCZcvdo+QoE6yFQhvl4qAG2N1dR+YZ3GU2ARFv0q4S+4pYo8JZauehRiNZCKSoU
	xPojr71cHaz/nqq4tGk7u1cZOUFL902jimpngvhTcDKt2P8ktFID5ln7BLjSv401k35zSxNt7ZG
	K2anK6Yflr8+H+mZWJQ1FOoPBGhkHZ7ZbiZpNG9yk4bfXf1+x6J2I0bc8t0mFxoLh14zNDM1tyW
	8t9oop1Gw4vWF8T0hhtdEw7y87
X-Received: by 2002:a05:6102:f11:b0:7d0:6cf3:d8f0 with SMTP id ada2fe7eead31-7d7393ff876mr2078058137.18.1795193717669;
        Fri, 20 Nov 2026 08:55:17 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6df8a28dsm3486193241.4.2026.11.20.08.55.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:55:17 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 06/18] shared/hci: Look up the connection handle on the right link
Date: Fri, 20 Nov 2026 11:54:56 -0500
Message-ID: <20261120165510.1858959-7-luiz.dentz@gmail.com>
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

