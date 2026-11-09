Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239110;
	b=oqekEOxgK76E0kO7zqrFpZ+BWzXWYMfEOpGtlibBR0lgIBLpGVZnovbfUjJCTfNl1Nb5
	 GXLLeX0wWQv1cVL4l8EBW2SN+UiH97hOcc6iA58ynvmFpV399iXNqeyySfcd3tJLvyLr3
	 /LYO7pPPY72j12OKp5sNexqF6/GDrUJkK8jVmhPXqJc3zgjaHVSpxHR92LA7h1nWDLAph
	 dZs7Zdb0u26ZroPfVK2vptHMCRcEc6oMmZj5P/S8AAzGn185ie/C6ehK+y8HNkS3bOLnv
	 IxApe8YZKv5Xh0i9wckbKVQ6nX8n7G6QyPiSjcYVv12IyWtfMD6QE6PbnMW7dKR36Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239110;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zSVgTzCt3kw3LXdZfQKp/6Zs4bC14XrsLgN/u35pK0g=;
	b=t85ZS50qvGKOqc+7YR4SGtYzN/96rX3H3gUnJyKOUjNMmlANBvPrWpbbq5QnDAawCkcR
	 f2L+8V6UrN/s+1t+JHOyIasg3IURxDhmwpMXiErqYahS3oBjaY6RdubchQK00JsixvjI2
	 ZB85QgHlKGdzlpwDiHT530Y5zUr+HZTVWR0xmg3LT+o9TZ4tOV2L/BHhonqfOnCtDp8Ts
	 tNsXzG3gFIFDvuFz6N84qO8XTvIfEPChYx+MrGRnpQ0LHzQ3QFIZZxlBd2ctRD1fbkCo5
	 lCl6cd6CxejOJJq5xlCXU0mCTPEWJNVTlGXD3PyX9YfPRbsAgT0QoPdfEkjee/xwiOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="DO/LVpG5";
	arc=none smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F4B606EEA1
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 15:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00F4B606EEA1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DO/LVpG5
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7cc91ddf447so396518137.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 07:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794239109; x=1794843909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zSVgTzCt3kw3LXdZfQKp/6Zs4bC14XrsLgN/u35pK0g=;
        b=DO/LVpG5gqQemmF5ccmjfjHxiOwgdBpQSRUeGfPAsQlv716apMKuFtICzWWunfyRaT
         wZevRJTUjhyqBaRKAXldH9nfD/IOYg0ZtXOLgzZ90bp1MMSt+bIskbZo/hNqHpIry9fi
         D0+lUNRX1y3Nec7ZoHNjDng8AOwZemes25/5egXI6vVYenkDD6pMpU9M2mEdDesFgONv
         dWcqVAQV/yXuvi03Plgkl7Vw+wjWATqYd5Tvqb4VhFbNO+XwJEBud3JTNFZNICeEJ/hg
         q/T8y4pU9Yc2HfbeaRSf/+7exD+Cr1sRMg+tqHFC5z3xHZekIVz8NDS4PzO99SnuYHnn
         m/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794239109; x=1794843909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zSVgTzCt3kw3LXdZfQKp/6Zs4bC14XrsLgN/u35pK0g=;
        b=c0OTRspW6A+lKHXTXphvN3Rcofq/OExsGGC/Cvs9tRW702AW2IrdZp3d8B37p1A9zT
         VsVsFCo3VTJcJVH+wCKepGIEBshmpocwoKqBXDzJTo2kNxxh0taMdKLce0L/Pe7pdPe5
         rqyvgFfinqq0RvzAxUgK6SYhvoLuZ5Q5DYlJGpMietpYR7x1TP44EzBC3JuTGWJNQxQg
         VeA/h6JVr4UFazVPsi48oPn8Gx2pNS55U42LR0EAO8XVc7LGTKmSRks+VFVB3TrzpwL9
         VRYhvp13VmIMsjnBVq2Gz5VoFdeHflgXhvp8cGJ1eYHczd41G4QJcoTdRt4DMrPVYYZb
         b+3Q==
X-Gm-Message-State: APuU4Z8fTHopBL3XRm6r0fxrgBFvSpOrek/okFIvZJMEta5QgQdTwXEA
	W7Y83EK7QzRkjQ82/wkwi5C3N6QOas9T/JsoietWeT3ws3MQBiqad7Vry7Rizg==
X-Gm-Gg: AYBFou1U96CT8aHWVKQJseYlfv8xlMtgamJWjzA37AmMZgLMCEukP7p0z54abQSVZqA
	eZ42mtuGswdwEe7K/3V/BiqYsga7Nfchq78Z79b31DEZ3j56G7agE0ZG2bjII6gV+cVyiV5DJSf
	KHLatNJ9IyLcmM0rySFslo+8IufGguYQv0iTLKYdwHqlQLKXHzb9P4iK9kxT9HKlT18En3ec3uk
	/+DCIp/cP9cIomApBynpDSqFJFMHqCU5zzV6yicZecAgWng7x14zSFkQ4uPtE8M3P+AUKTgu1yN
	G9+o01m1YHiysfaTWp6tuznS4zkDCI7KVgUKRCACSU68p20ZPFzFTTRBB4uWGTyjxNFy0ESQFvZ
	2IMRztfkkcNAxscDsQu0W29zQJ+gM3aSd1iPcb5btTAYcNVzUQms1SlrglzXAnFejLxBqu+Ltq9
	Z/5vP12DfcLOuNnLFoPsikXAQDbUCRYoXvt+mBprYoWUP71aJY2bZvszpPPImiCBHaKxDS4XWm4
	qjCj+cthz0VMWRjmTvOIXjoeK/I6O2Nu3V6ir4cFSNBoVNkbVij6bB0S61831JwNm52VT6gs1xp
	tfDFFmfcnKjCSiwyRdinv08jfANgHN8rjQ9OLc7G5etNXyj0gaDKK9j8bI94UEJSbFs8mBWLJDp
	j4zq/OMHZ1Djcfe603o+lkJ8e5WAWsEwF8u7lKj3Bbl7CgrfNCH4MA0raeyqfvPKq
X-Received: by 2002:a05:6102:5ccc:b0:7d2:da5c:6f7e with SMTP id ada2fe7eead31-7d2db10279dmr958898137.21.1794239108645;
        Mon, 09 Nov 2026 07:45:08 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c02a60a83sm4097474241.10.2026.11.09.07.45.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:45:08 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 05/10] unit/test-gatt: Add malformed PDU tests
Date: Mon,  9 Nov 2026 10:44:56 -0500
Message-ID: <20261109154501.1362649-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109154501.1362649-1-luiz.dentz@gmail.com>
References: <20261109154501.1362649-1-luiz.dentz@gmail.com>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add server tests for short and oversized requests, which must be
answered with Invalid PDU, and client tests for truncated or
inconsistent MTU, Read By Group Type, Read By Type and Notification
Multiple responses.

Client tests that are expected to fail initialization use a new
init_fail step flag.

Assisted-by: OpenCode:claude-sonnet-5.5
---
 unit/test-gatt.c | 175 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 175 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 267bcc61802e..ad8e95453be2 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -352,6 +352,7 @@ struct test_step {
 	const uint8_t *value;
 	uint16_t length;
 	uint8_t features;
+	bool init_fail;
 };
 
 static void destroy_context(struct context *context)
@@ -645,6 +646,15 @@ static void match_services(struct gatt_db_attribute *client_serv_attr,
 static void client_ready_cb(bool success, uint8_t att_ecode, void *user_data)
 {
 	struct context *context = user_data;
+	const struct test_step *init_step = context->data->step;
+
+	if (init_step && init_step->init_fail) {
+		g_assert(!success);
+
+		/* The client is still in use by the caller, quit when idle */
+		g_idle_add(context_quit, context);
+		return;
+	}
 
 	g_assert(success);
 
@@ -2495,6 +2505,10 @@ static void test_notification_short(struct context *context)
 						NULL));
 }
 
+static const struct test_step test_client_init_fail = {
+	.init_fail = true,
+};
+
 static const struct test_step test_notification_short_1 = {
 	.handle = 0x0003,
 	.func = test_notification_short,
@@ -4953,6 +4967,167 @@ int main(int argc, char *argv[])
 			raw_pdu(0xff, 0x00),
 			raw_pdu());
 
+	define_test_client("/robustness/client-mtu-rsp-short", test_client,
+			NULL, &test_client_init_fail,
+			raw_pdu(0x02, 0x00, 0x02),
+			raw_pdu(0x03, 0x00));
+
+	define_test_client("/robustness/client-mtu-rsp-long", test_client,
+			NULL, &test_client_init_fail,
+			raw_pdu(0x02, 0x00, 0x02),
+			raw_pdu(0x03, 0x00, 0x02, 0x00));
+
+	define_test_client("/robustness/client-read-by-grp-type-short",
+			test_client, NULL, &test_client_init_fail,
+			CLIENT_INIT_PDUS,
+			raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
+			raw_pdu(0x11, 0x06, 0x01, 0x00, 0x05));
+
+	define_test_client("/robustness/client-read-by-grp-type-data-len",
+			test_client, NULL, &test_client_init_fail,
+			CLIENT_INIT_PDUS,
+			raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
+			raw_pdu(0x11, 0x07, 0x01, 0x00, 0x05, 0x00, 0x01, 0x18,
+				0x00));
+
+	define_test_client("/robustness/client-read-by-grp-type-trailing",
+			test_client, NULL, &test_client_init_fail,
+			CLIENT_INIT_PDUS,
+			raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
+			raw_pdu(0x11, 0x06, 0x01, 0x00, 0x05, 0x00, 0x01, 0x18,
+				0x02));
+
+	define_test_client("/robustness/client-included-short", test_client,
+			NULL, &test_client_init_fail,
+			CLIENT_INIT_PDUS,
+			raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
+			raw_pdu(0x11, 0x06, 0x01, 0x00, 0x04, 0x00, 0x01, 0x18),
+			raw_pdu(0x10, 0x05, 0x00, 0xff, 0xff, 0x00, 0x28),
+			raw_pdu(0x01, 0x10, 0x05, 0x00, 0x0a),
+			raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x01, 0x28),
+			raw_pdu(0x01, 0x10, 0x01, 0x00, 0x0a),
+			raw_pdu(0x08, 0x01, 0x00, 0x04, 0x00, 0x02, 0x28),
+			raw_pdu(0x09, 0x08, 0x02, 0x00, 0x01, 0x00, 0x04));
+
+	define_test_client("/robustness/client-characteristic-short",
+			test_client, NULL, &test_client_init_fail,
+			CLIENT_INIT_PDUS,
+			raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
+			raw_pdu(0x11, 0x06, 0x01, 0x00, 0x04, 0x00, 0x01, 0x18),
+			raw_pdu(0x10, 0x05, 0x00, 0xff, 0xff, 0x00, 0x28),
+			raw_pdu(0x01, 0x10, 0x05, 0x00, 0x0a),
+			raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x01, 0x28),
+			raw_pdu(0x01, 0x10, 0x01, 0x00, 0x0a),
+			raw_pdu(0x08, 0x01, 0x00, 0x04, 0x00, 0x02, 0x28),
+			raw_pdu(0x01, 0x08, 0x01, 0x00, 0x0a),
+			raw_pdu(0x08, 0x01, 0x00, 0x04, 0x00, 0x03, 0x28),
+			raw_pdu(0x09, 0x07, 0x02, 0x00, 0x02, 0x03, 0x00,
+				0x00));
+
+	define_test_client("/robustness/notify-multiple-short", test_client,
+			ts_small_db, &test_notification_short_1,
+			CLIENT_INIT_PDUS,
+			SMALL_DB_DISCOVERY_PDUS,
+			raw_pdu(0x12, 0x04, 0x00, 0x01, 0x00),
+			raw_pdu(0x13),
+			raw_pdu(),
+			raw_pdu(0x23, 0x03, 0x00, 0x03, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(),
+			raw_pdu(0x23, 0x03, 0x00, 0x03),
+			raw_pdu(),
+			raw_pdu(0x23, 0x03, 0x00, 0x09, 0x00, 0x01, 0x02,
+				0x03));
+
+	define_test_server("/robustness/read-by-grp-type-malformed",
+			test_server, ts_small_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff),
+			raw_pdu(0x01, 0x10, 0x00, 0x00, 0x04),
+			raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28,
+				0x29),
+			raw_pdu(0x01, 0x10, 0x00, 0x00, 0x04));
+
+	define_test_server("/robustness/read-by-type-malformed",
+			test_server, ts_small_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff),
+			raw_pdu(0x01, 0x08, 0x00, 0x00, 0x04),
+			raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28,
+				0x29),
+			raw_pdu(0x01, 0x08, 0x00, 0x00, 0x04));
+
+	define_test_server("/robustness/find-info-malformed",
+			test_server, ts_small_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x04, 0x01, 0x00, 0xff),
+			raw_pdu(0x01, 0x04, 0x00, 0x00, 0x04),
+			raw_pdu(0x04, 0x01, 0x00, 0xff, 0xff, 0x00),
+			raw_pdu(0x01, 0x04, 0x00, 0x00, 0x04));
+
+	define_test_server("/robustness/find-by-type-value-malformed",
+			test_server, ts_small_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x06, 0x01, 0x00, 0xff, 0xff, 0x00),
+			raw_pdu(0x01, 0x06, 0x00, 0x00, 0x04));
+
+	define_test_server("/robustness/read-malformed",
+			test_server, ts_small_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x0a, 0x03),
+			raw_pdu(0x01, 0x0a, 0x00, 0x00, 0x04),
+			raw_pdu(0x0a, 0x03, 0x00, 0x00),
+			raw_pdu(0x01, 0x0a, 0x00, 0x00, 0x04));
+
+	define_test_server("/robustness/read-blob-malformed",
+			test_server, ts_small_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x0c, 0x03, 0x00, 0x00),
+			raw_pdu(0x01, 0x0c, 0x00, 0x00, 0x04),
+			raw_pdu(0x0c, 0x03, 0x00, 0x00, 0x00, 0x00),
+			raw_pdu(0x01, 0x0c, 0x00, 0x00, 0x04));
+
+	define_test_server("/robustness/read-multiple-malformed",
+			test_server, ts_small_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x0e, 0x03, 0x00),
+			raw_pdu(0x01, 0x0e, 0x00, 0x00, 0x04),
+			raw_pdu(0x20, 0x03, 0x00),
+			raw_pdu(0x01, 0x20, 0x00, 0x00, 0x04));
+
+	define_test_server("/robustness/write-malformed",
+			test_server, ts_small_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x12, 0x04),
+			raw_pdu(0x01, 0x12, 0x00, 0x00, 0x04));
+
+	define_test_server("/robustness/write-cmd-malformed",
+			test_server, ts_small_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x52, 0x04),
+			raw_pdu());
+
+	define_test_server("/robustness/prep-write-malformed",
+			test_server, ts_small_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x16, 0x03, 0x00, 0x00),
+			raw_pdu(0x01, 0x16, 0x00, 0x00, 0x04));
+
+	define_test_server("/robustness/exec-write-malformed",
+			test_server, ts_small_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x18),
+			raw_pdu(0x01, 0x18, 0x00, 0x00, 0x04),
+			raw_pdu(0x18, 0x01, 0x00),
+			raw_pdu(0x01, 0x18, 0x00, 0x00, 0x04));
+
+	define_test_server("/robustness/mtu-malformed",
+			test_server, ts_small_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x02, 0x17),
+			raw_pdu(0x01, 0x02, 0x00, 0x00, 0x04),
+			raw_pdu(0x02, 0x17, 0x00, 0x00),
+			raw_pdu(0x01, 0x02, 0x00, 0x00, 0x04));
+
 	define_test_server("/robustness/hash-db",
 			test_hash_db, ts_tail_db, NULL,
 			{});
-- 
2.56.0

