Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795580244;
	b=B4d9CW15G5I+WvJ3x3RXrDAOtnESGaHRZscL7xIR/zHpBTq7qpy5tQK79gwuxTqwhL4b
	 +vxrOLifyKEEImMtv94oNsAaMCDfAqHYV3O8VUPpHiU++bMqwJUHQCqeEe11+Ut+l72a1
	 Jt+zw76/jsmpjGUJ6ribpYj7RAsjC5O/gR5B+p6bzHB7fTiSJKALDPx5pEAnSfC2tzvCh
	 3CiJNAQfFXgJIBbSttBIRJbACAgaRf4xUpKpKSi+QUAOoDcuq865DIRjWPFXsMuLcsRwW
	 AVRlFxLjKNuF8whnlMG3WS3HWs+T5Xeffy9dxe/hYPZEi3OO9gN0EUBBLTNMzXRPIAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795580244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LIO1sP104PSuoJ60QVIJG8+BBcro6jR5oUnpvzMAIR0=;
	b=iorJ2hbhn/tnETo929SBgCQy+4BvjaR4dZJZ4hLDlimaN8Yq5tiLZtOomf+PA+oCeeJi
	 AwfFJ/0SuiQBVyrECWbP33CfJtK+l1bEqYXwJtdcX0uO1AZomHqtxyHhO6u/eAjCrUvlu
	 SVLMFAXRMw+0EPlICZB562UTd1dSrJ3poyq7O5Vi+Qs1knXeRMrZ8CD1VLHkuVhZEpXPt
	 XemECu+KtUIBVRrwHdbVwQ2Fyw0H2ghKxc5l3RGS3G5wplqdhLzMHVxesSGxNB4orK0A5
	 23k6bWU7SQ1HWuXdo1wS/Wkl0hUrvWn6SCruwkzFrqQrTBGfzMAhfPtFHvYVm3Yk98A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uYh8HfAy;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9A0606A335
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 04:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C9A0606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uYh8HfAy
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a0880a46e7so3175737b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 20:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795580243; x=1796185043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LIO1sP104PSuoJ60QVIJG8+BBcro6jR5oUnpvzMAIR0=;
        b=uYh8HfAyKR2swMshwGyzdsLLFpG2qvO4IO0ZC51QfnJ/lrbT+SjVNU4wuq3bvKKc0U
         Rqc1qtxjJWGIviJcZIKWdS9RL1waT83mthRU0tCQemX7at+SYT0JqvA+K5+XgNTSqljc
         ZhCH+UCyX8sOSWHBFrJBc7zMU+/nuwCJ5WDz18XIMKnrx7jxttnNDSlqZ9o80phsrycQ
         e6thK4WiJg3yGwlqOn0dprscjnxuRWooDe6oJrTC3JKVPsjzaHK3+dObrOSinM0OP0jk
         Yb0Hyc+1Knl6XCMhfmZuT7KpY192Q6jiS6o8ieZqohWT4y9hTLgd2pyG+3EPqrudJU0P
         /mFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795580243; x=1796185043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LIO1sP104PSuoJ60QVIJG8+BBcro6jR5oUnpvzMAIR0=;
        b=UvoYngQ6+MhDC7iHvsO5zqL/rYOQDTaaIwUdZ2Dc5Hi5CtOysy1/OsxkjWKDOh/AXM
         LWp/UTrOdShYq7pcxJodOoBThwJ2CCtIP+YEzYVjzjShhyAch+Jsq2h/y8Y/BP0NXGib
         zzJ/JYPL6m1k1AxhmfiNo9AyWreMhyIFSTArHD4rt6ZdE7FfVcpqrRn69ZWJvmk/aQYY
         PpGAlLPoKr5Vh5qk4N7YRzcrpEVwlWmlQW+unV6cyphkKUzjkwE5N0a+xqzNMmN6mqnW
         uPPZc7svTygr6fr+s9b1vmWYFX3tXTqK8od4XH0o1pmzTRJcN6q4TmVxfe3l92Lan/9O
         1DOw==
X-Gm-Message-State: APuU4Z9KbG7Oo5omf/yHPvQ0S7G+EpJ5Uug/FfWeOk+nRH4b53V/uu6t
	Sxdcn9mje9b8SiFWaNMYwGmR0edPPJvuk/sIG6lZU4iqY8NQ2+qECTD5s4FRHA==
X-Gm-Gg: AZFdTZfK436oy+nIWQQ9hmy5REy3RhxmVG+V/LG3nq+r7jRxioOTJoOx+eO7LA22VnF
	CIrvWZrE7mGCWdUCHIlqs5sYzZXpQaVH8vA+e2MV77AVBzp/BVV5P/KN1SeYFWhU51wkj4ku3VK
	H8L09uXZXwY2LYv1F+7a5pN3rmaTmGo39KUQh5AClDc92I6VnFchzlp5j5iSaYjBXOefhpXD7ki
	Wg7iZSjGE/wf/iCL+GRU3ypw65IUDZRDRV23EbSz1G4mPzMjDgyJhif5T8rNH9NtcbNTgPTSaLM
	ZJidx+CcVGS3KQZxS9LzrmUlLLo4ntNDz0JI7MExXMQT8Oz46zWhAdUyx0Yyyo0nSgW1fYenBuh
	erb4NdFBdjgpD2fpYw9/lwoAWDiLD77lOLq29CaLG6+RNWA1Y8WAl8/0HRSuX+ggNwNLcm9wNRJ
	QOdKh+lrSkcMawh7pfAFjb6J0dTWMyF3kr10lNj6d/ym2mPzXmqx0PFjpwgsmA0YEDlo3uX6bE0
	FLJOZyh6sgFuPqWxMeXbCcZ+atz7T6ioUglf0abhzx/Xy0hiEU3Qc8JZQreNS18592wqTPnWJWU
	4iy5M1cpgtK2Jb1tr1vF8qiD43U8MhjDlbfqmzKW2ugnIP3ZGcrUfqXZoMattx+IiaHudqIQ
X-Received: by 2002:a05:6a00:1706:b0:881:236b:748a with SMTP id d2e1a72fcca58-8c87c670aa2mr10800000b3a.16.1795580243361;
        Tue, 24 Nov 2026 20:17:23 -0800 (PST)
Received: from fedora.tail791dd8.ts.net ([2601:1c0:4300:57a:5830:187:53e3:add2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87343f726sm8503875b3a.36.2026.11.24.20.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:17:23 -0800 (PST)
From: Dylan MacKenzie <ecstaticmorse@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dylan MacKenzie <ecstaticmorse@gmail.com>
Subject: [PATCH BlueZ v2 1/2] device: Add btd_device_get_disconnect_reason
Date: Tue, 24 Nov 2026 20:17:13 -0800
Message-ID: <20261125041714.2691802-2-ecstaticmorse@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125041714.2691802-1-ecstaticmorse@gmail.com>
References: <20261125041714.2691802-1-ecstaticmorse@gmail.com>
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

Keep the reason of the last disconnection in the bearer state and add
btd_device_get_disconnect_reason so it can be queried per bearer. The
new field takes the place of padding so struct bearer_state does not
grow.

Assisted-by: Claude:claude-fable-5-2
---
 src/device.c | 7 +++++++
 src/device.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/src/device.c b/src/device.c
index 36a980d1e..720b4af69 100644
--- a/src/device.c
+++ b/src/device.c
@@ -155,6 +155,7 @@ struct bearer_state {
 	bool svc_resolved;
 	bool initiator;
 	bool connectable;
+	uint8_t disconn_reason;
 	time_t last_seen;
 	time_t last_used;
 };
@@ -3864,6 +3865,11 @@ bool btd_device_bdaddr_type_connected(struct btd_device *dev, uint8_t type)
 	return dev->le_state.connected;
 }
 
+uint8_t btd_device_get_disconnect_reason(struct btd_device *dev, uint8_t type)
+{
+	return get_state(dev, type)->disconn_reason;
+}
+
 bool btd_device_bdaddr_type_connectable(struct btd_device *dev, uint8_t type)
 {
 	if (type == BDADDR_BREDR)
@@ -4071,6 +4077,7 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
 
 	state->connected = false;
 	state->initiator = false;
+	state->disconn_reason = reason;
 	device->general_connect = FALSE;
 
 	device_set_svc_refreshed(device, false);
diff --git a/src/device.h b/src/device.h
index 047a894c3..4527c16d1 100644
--- a/src/device.h
+++ b/src/device.h
@@ -127,6 +127,7 @@ void device_set_flags(struct btd_device *device, uint8_t flags);
 bool btd_device_is_connected(struct btd_device *dev);
 bool btd_device_bearer_is_connected(struct btd_device *dev);
 bool btd_device_bdaddr_type_connected(struct btd_device *dev, uint8_t type);
+uint8_t btd_device_get_disconnect_reason(struct btd_device *dev, uint8_t type);
 bool btd_device_bdaddr_type_connectable(struct btd_device *dev, uint8_t type);
 bool btd_device_bdaddr_type_seen(struct btd_device *dev, uint8_t type);
 bool btd_device_bdaddr_type_initiator(struct btd_device *dev, uint8_t type);
-- 
2.56.1

