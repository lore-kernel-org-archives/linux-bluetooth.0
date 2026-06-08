Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AC220125F
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 20:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780951820; cv=none; b=NnRY+QM2hb99xVxtdYMw/KNtmma705H9jcW4M3fN6CBZ46OL3wGi8odthazcy9oDu6f+O46827XXyLDuegw9BqecO9jKZwNYoGRcVdg7h+ir/V6BRytYwBpbxFy0R4xrrfuqRP1SHSc7g7bHDpLSz/ZCVGRE18HE7yMRin8LeeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780951820; c=relaxed/simple;
	bh=yeQbB4Zhf1OGdKtnGMU5GJsCa+TODuU3hR3TRvBysyg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pIT3i+asm/LHBEVl2vGtrw0F5Ih47eVO2J2QBfetYigLQyhdSj6yfvZ7cqNLB1W74hHVHfJxn0hTLiCTM3gR2RZGppXND11pGIQqwtaCPlmDnwnT12GMDa/evVJUn3Qw8ZiBnR6TOXgZn/QLb3+3OL3syfVorOkokSPmw/wwzNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIacXJvE; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIacXJvE"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-59dc1714d44so1490245e0c.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 13:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780951817; x=1781556617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IIDV447+wdtLZweO30xC7UD6QTS2SXrBy0f0QKAAjos=;
        b=hIacXJvEANxZyGdvd56UjMqAjo3z2mO75IAWS9Cnc43wMq04BKn3QsRn0iO9kw+lju
         OJ8Axn/CrIL3z4Gk1c3ziYOgd1eOCtq0EtiVqS3hFKDIdHMNvJEYs37UxCsjgldwYf3M
         /pDWqylAeKB7WhGNLg4XcZMNz+3nIJIk2b8gB5tsgko9HCHHcxOaUEK3WfQ7mFcMd9po
         1HwJmzwAehgPze5+Xu14DrQiLVah9/LG0r4QWKfhvsvCGTFmQeA7Zhmdd57l/OPMidPb
         FST365XXGIO1he18R+9ndf/seEwgW8HxhqTVwznHZreUn3pSswDCEVXb6g3FkDekfiVU
         wAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780951817; x=1781556617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IIDV447+wdtLZweO30xC7UD6QTS2SXrBy0f0QKAAjos=;
        b=Rb2PmDRj4Sw9o+KQSG6pne4viAf3rQ0/2iAkifwxY4ucRkcjuJca3WzDWl4tBXIHE4
         v/Ial9fNFlqYH+V2f0VdXFsuk3dsL5ntfXJZzV4KQjj4w06RcRR6BDDPFcSOrjDrnx6g
         wYc/oaRSCcqIoUWJoX5hsi4Fl4Z8aIchh9QjC9hli9VG98FeZTt/DGs4chqgk2o23479
         y9tH6ULgPJpiE5eHNRrg5rddIWdAFhFJ3CfIoT3f20Bkg6qUJNVram6uLmMzh3dW3U/L
         QS9MwiZK6+F9/f+1vuqftO3oV+n5RfFidAekmrq+DcdrFFi3t46ZQdTpyvSY3s98k6eF
         qmRg==
X-Gm-Message-State: AOJu0Yy0z1ephfe1V3cpFJm+5L5zAmTH2dlI/IdAOkB1/KjfYOcwL45P
	X1tAh3PnTb6TZK+cRZbYX1GSz6+A06x8U7HIZsPhWCQoqEsUYByt14UViZk/Wm+xBbc=
X-Gm-Gg: Acq92OFLqT3y/9FsObbAXI37ftnsyiiEu6jgByaQPEwZAFpCJkWLcfPfamGXqRKUDMU
	hHMWPSWrhw8506HUQ9Ik8EKwn3lX/koD/B3ky1spIThQlmGp0QPwsBrhihwAT3hDvZlvPWiNVAN
	yUpylSYsBaN0TpkYqwP5yOkgK38GmQurkQD2dmx9jfM2WKRI5gD4YFTQ31kxAv702rkjigslKHj
	hZhRec7wL1sdaKqdAlbletZYNNFC0hzBpUS7+QXdY35BLN0tys06tkowwjcat2xsVthwl1OdrLo
	IDSVgkFf7qzU+b31KKz8EwnOsc4Ck5c68Up/fONm2mryPjqJcrcMBRDnxof92yv4dSQliLRCJ7X
	VvsgDF9LYFaTlMYDQKh2qKKDV0oudB2HDrfp9ppi7CZQOWSKw7d31oaGNeZY0D3b73Ew6Tr0B4F
	D1LlUZ4hcLfPYRncOgd6BAwyZVaWj+rSYXpHA4yo/UOoSOIqJehUs6lM3e/O+aLvyRW/SCsdcdw
	3e/68zcmM8rLQDKTquBJjJGwJ4O
X-Received: by 2002:a05:6122:3d45:b0:573:a779:62cf with SMTP id 71dfb90a1353d-5ac4f952082mr7717077e0c.7.1780951817550;
        Mon, 08 Jun 2026 13:50:17 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6ddacc48bsm15679545e0c.18.2026.06.08.13.50.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 13:50:17 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] shared/hci: Debounce SO_ATTACH_FILTER with timeout_add(0)
Date: Mon,  8 Jun 2026 16:50:09 -0400
Message-ID: <20260608205009.97585-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608205009.97585-1-luiz.dentz@gmail.com>
References: <20260608205009.97585-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Coalesce multiple BPF filter updates into a single SO_ATTACH_FILTER
setsockopt call by deferring the update to the next event loop
iteration using timeout_add(0, ...).

When bt_hci_register_event or bt_hci_register_subevent is called
multiple times in succession (e.g. from bt_rap_attach_hci), each call
previously triggered a full filter rebuild and setsockopt. Now,
schedule_evt_filter() simply marks a pending update which fires once
in filter_timeout() after all synchronous registrations complete.
---
 src/shared/hci.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/src/shared/hci.c b/src/shared/hci.c
index 1aba7db1d995..e8586ab5014c 100644
--- a/src/shared/hci.c
+++ b/src/shared/hci.c
@@ -31,6 +31,7 @@
 #include "src/shared/io.h"
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
+#include "src/shared/timeout.h"
 #include "src/shared/hci.h"
 
 
@@ -42,6 +43,7 @@ struct bt_hci {
 	uint8_t num_cmds;
 	unsigned int next_cmd_id;
 	unsigned int next_evt_id;
+	unsigned int filter_id;
 	struct queue *cmd_queue;
 	struct queue *rsp_queue;
 	struct queue *evt_list;
@@ -485,6 +487,9 @@ void bt_hci_unref(struct bt_hci *hci)
 	if (__sync_sub_and_fetch(&hci->ref_count, 1))
 		return;
 
+	if (hci->filter_id)
+		timeout_remove(hci->filter_id);
+
 	queue_destroy(hci->evt_list, evt_free);
 	queue_destroy(hci->subevt_list, evt_free);
 	queue_destroy(hci->cmd_queue, cmd_free);
@@ -765,6 +770,27 @@ static void update_evt_filter(struct bt_hci *hci)
 	free(filters);
 }
 
+static bool filter_timeout(void *user_data)
+{
+	struct bt_hci *hci = user_data;
+
+	hci->filter_id = 0;
+	update_evt_filter(hci);
+
+	return false;
+}
+
+static void schedule_evt_filter(struct bt_hci *hci)
+{
+	/* Coalesce multiple filter updates into a single SO_ATTACH_FILTER call
+	 * by deferring the update to the next event loop iteration.
+	 */
+	if (hci->filter_id)
+		return;
+
+	hci->filter_id = timeout_add(0, filter_timeout, hci, NULL);
+}
+
 static bool match_evt_event(const void *a, const void *b)
 {
 	const struct evt *evt = a;
@@ -805,7 +831,7 @@ unsigned int bt_hci_register(struct bt_hci *hci, uint8_t event,
 	}
 
 	if (update_filter)
-		update_evt_filter(hci);
+		schedule_evt_filter(hci);
 
 	return evt->id;
 }
@@ -877,7 +903,7 @@ bool bt_hci_unregister(struct bt_hci *hci, unsigned int id)
 
 	/* Only update filter if no other handler for this event remains */
 	if (!queue_find(hci->evt_list, match_evt_event, UINT_TO_PTR(event)))
-		update_evt_filter(hci);
+		schedule_evt_filter(hci);
 
 	return true;
 }
@@ -916,7 +942,7 @@ unsigned int bt_hci_register_subevent(struct bt_hci *hci,
 	}
 
 	if (update_filter)
-		update_evt_filter(hci);
+		schedule_evt_filter(hci);
 
 	return evt->id;
 }
@@ -940,7 +966,7 @@ bool bt_hci_unregister_subevent(struct bt_hci *hci, unsigned int id)
 	/* Only update filter if no other handler for this subevent remains */
 	if (!queue_find(hci->subevt_list, match_evt_event,
 							UINT_TO_PTR(event)))
-		update_evt_filter(hci);
+		schedule_evt_filter(hci);
 
 	return true;
 }
-- 
2.54.0

