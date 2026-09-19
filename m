Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DE23921DE
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 22:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789856265; cv=none; b=aNjWBuY6VGZEi/quZOrzcGQAknTTZpEpWAFLVaWSMj6am76NEz+uQrvJ/ez1LoEEwfBCGnw7mmQaLYnq5GptybxXp1nG1uNx4JKFOC9BT0aHSNccKQzYYH0LeooyHxaAszNV2VideCcWDBYBKjMRg9KvTJqxKplAkdq4/hHhuPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789856265; c=relaxed/simple;
	bh=NU1V7efEsMjoFddAIFDeymEXDxM9h3owttcQe+ZcufU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F8XnCIyWRQ8c73VPJpacy1e0d0xiaJn1Kdp6Hm2Z6YECLSt5gODHzWwHIhKmKCVsX7WPg/txHVQ6YY1N3559trQR4CJdAPj2UBbSxK4ZrEMTSa4u3IHhrRj3wVKURuefX6MQjQsfsYHf76e4bL94BkYAvGqRtcWF+OSlGMCdLfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWplY6Q/; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWplY6Q/"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396cccbba91so1277421a91.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 15:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789856262; x=1790461062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QKyHp2gj5kAq6oO4ZJR2AabuUHXJyMAyfsTBtas9GC8=;
        b=bWplY6Q/JoZtX/ZyZMUwVPO7B0K19h2O3qEILpulf2E2/Ywt6wR0DXnWe1E21ZGuYb
         u14+ow2lBPzV+VOzw/VfKjPWH9OM1lX5R143P93+UHcDVBOb4ZM+08ymvwypjlNq7yV1
         4Ej+D6Ni/FKt9cxQD3jFfqIIbEbJ4M7knDAcFT14vtB++IQFfSWRDCSeguPbKenMCvg+
         WAPtQ8AKkctnYKCoQuYK1hrliQKEdeNxfk2ltCogYhvlQIRmjvQOwqOXWZdM7tvtn0vm
         FsmOuYEBlJF/X4o4ZF46nuyzGnGGJ1uyhijRl3yIfOn1R6i94uCDbS8Alq3NTx6nz0hp
         WP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789856262; x=1790461062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QKyHp2gj5kAq6oO4ZJR2AabuUHXJyMAyfsTBtas9GC8=;
        b=MVZnc3X7qjnLh/4862Sq66lEs/0XkAR2h/t42g70AAOCT0hM4SXC/WYQtzA6z8I9BT
         LxZxhIzZuT8eDTki1wz550e0/Eig63DdBvL0J21ilD8PKEnH9lK2SOSWwrQRbD6Rb4wB
         vE/CPEvfGOmNCQ/3pICW29Urhh/kHBQvdTaqo1ocFcmYpuVzkHA9uQKl83y6V9VfH7Hk
         TfJoyY8ztsz9IJXo+08AS1fa7cGpeFG0FYeniKSqXKl7wOjYqyu6sNXj9uVGUxW9/cwv
         v79VdsyYwt041tTv6FJmDx6P0D10bEHPxh0xT09nYPfOwWcaG4MlsSrfGemzWrEjDwoP
         OEsw==
X-Gm-Message-State: AFuF++k34y4w/ApfjzFlyLxFhw6IXSlcgectAAHlTQcj4Dn/Xzshp6Bj
	gE75XgDtECA67fTknDxmRY0rWuGWXJMHybNBu1vngxXfwsolQDvhGnM/
X-Gm-Gg: AYBFou2dIeArYNc3M8EbiJ21su0PDTLcFUOJCFWO/yuwWJENjFaUBS4zyEBjZCLyvPw
	tJpWqKweX6cZiS5LpckmZGo3PpmfBvXP/yeYOAEWgpVZSdRhL0AmjqxXGczXAAGppfh+pnRlE1D
	SrEx7zhuilS13itweGaLDle+kSGAeEhic17+WeQG00RGyIZ7/cc7SvblZdj2QcrU5GRd5gzsDRe
	RFp/rcYLuTBwqTHHbocKoNdIckiUeZ+y4PiidxMwpHhAGB+gk1AOSzE1EveuKxFppAzCN5LFW9R
	H63dy+KlICa93WYkZbROtPa/qWvJQBDo1rmyOizjM0ouYpSmQQCFk0Br+1fnDGl7hYMjhcVoxf7
	pl3hxdesc+pL3RR44Rc1Lf9a19BqDa+jCeTJr6ChFUb2xE71pRGFHu2gl5yJ+mngPRe8w4PRuP5
	fdizNud5fqgPbxZmUUXpew5efMK7quPIea8cyUy6pbpTKema6o805Ka8biLkaCpTfCiSJlWIPgg
	rpeLb/StAG6HGz2xh9XcEwsKguuc1CBoeNE71GRCnywBX1AAPr9xlkbzNROKMJDPv5swj3ww92c
	iM7KBsH4Qw==
X-Received: by 2002:a17:90b:57d0:b0:39e:6c6a:2098 with SMTP id 98e67ed59e1d1-39e6c6a22cbmr5027254a91.57.1789856262468;
        Sat, 19 Sep 2026 15:17:42 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c3145dasm6266246a91.4.2026.09.19.15.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:17:42 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hidp: fix out-of-bounds reads on short frames and report_return skb leak
Date: Sat, 19 Sep 2026 22:17:41 +0000
Message-ID: <20260919221741.3709254-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In hidp_recv_intr_frame() and hidp_recv_ctrl_frame()
(net/bluetooth/hidp/core.c), check skb->len >= 1 with pskb_may_pull()
before dereferencing skb->data[0] and skb_pull(skb, 1), and free any
stale session->report_return skb before overwriting it or when tearing
down the HIDP session.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index f5bdf9f1ca63..7fc1b3ae585f 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -321,6 +321,8 @@ static int hidp_get_raw_report(struct hid_device *hid,
 
 err:
 	clear_bit(HIDP_WAITING_FOR_RETURN, &session->flags);
+	kfree_skb(session->report_return);
+	session->report_return = NULL;
 	mutex_unlock(&session->report_mutex);
 	return ret;
 }
@@ -520,6 +522,9 @@ static int hidp_process_data(struct hidp_session *session, struct sk_buff *skb,
 	int done_with_skb = 1;
 	BT_DBG("session %p skb %p len %u param 0x%02x", session, skb, skb->len, param);
 
+	if (skb->len < 1)
+		return 1;
+
 	switch (param) {
 	case HIDP_DATA_RTYPE_INPUT:
 		hidp_set_timer(session);
@@ -548,6 +553,7 @@ static int hidp_process_data(struct hidp_session *session, struct sk_buff *skb,
 		    (skb->len &&
 		     session->waiting_report_number == skb->data[0])) {
 			/* hidp_get_raw_report() is waiting on this report. */
+			kfree_skb(session->report_return);
 			session->report_return = skb;
 			done_with_skb = 0;
 			clear_bit(HIDP_WAITING_FOR_RETURN, &session->flags);
@@ -615,7 +621,7 @@ static void hidp_recv_intr_frame(struct hidp_session *session,
 		if (session->input)
 			hidp_input_report(session, skb);
 
-		if (session->hid) {
+		if (session->hid && skb->len >= 1) {
 			hidp_process_report(session, HID_INPUT_REPORT,
 					    skb->data, skb->len, 1);
 			BT_DBG("report len %d", skb->len);
@@ -1000,6 +1006,7 @@ static void session_free(struct kref *ref)
 	hidp_session_dev_destroy(session);
 	skb_queue_purge(&session->ctrl_transmit);
 	skb_queue_purge(&session->intr_transmit);
+	kfree_skb(session->report_return);
 	fput(session->intr_sock->file);
 	fput(session->ctrl_sock->file);
 	if (session->conn)
