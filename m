Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741DD23741
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 06:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770962680; cv=none; b=oE3rZuadFCc3Nk9ugbhDZT5VhDXKcUVGWjCe0Y7yCGWRgvgc8TcMtPpz5Mq4oyMiObvt3DtvSyEpqWE2Ts4zj0E2XCIJMTCrRqUBVZ+ip4mA77VGh6CYNKA83ILLj7i8nlZX2kaaq2BXsKjCuWmGuQsv4t+8Q00y716Q2F8kluA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770962680; c=relaxed/simple;
	bh=vQxdkryUEJ+pArY5kJMAR+7YlXlMsv2XI7L1MiRhw0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYor1AQhE3O8n1GMFibcyorzCdFMd0x8KehA54LB9C7nbwslNC1Zc+mBQN+BA4pH0//ao+gEIDPF6Zs7LAg82vazvud7nDKvFGD9G5kmrkCpD9FtxRb+c8abGzljqp19K7OQ+Yoo0DaxWEN2G/3kkXrxi/+uOBxQxTJfG5JMOUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1KvAnRX; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1KvAnRX"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2b4520f6b32so718421eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 22:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770962678; x=1771567478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbsk2agQ8f3m0QH5WZrAhx9x+dI3Pqe/kCYQZSQSePA=;
        b=N1KvAnRXtNCeDd6avdmZNqC6fd5VXrKBg+Z1E/2UihIPKBPazS0hkNHC7jF1xFBl4z
         3lyvVeIDulK7XGEI10QZmBdCcsPE6b2l/wxyzSEssl38izDnu58XX4TqqgHhetJlSo0v
         HNhKwul3TitlpV8AVRBj1geaQPc5LWvMehRL/tEfGWr5zVfI3WDFGotfElX7yz1igp1+
         VxNT5m17Q3GKXGJznU1M1cGA1wBFzVNYRSn5+AQKsluh0C866pzbPUzMsYlK8U5KAXW/
         zYX50mAe/614YvUeKlpU0qRqAEQA7DBjfXwfO7NXu514HV2zKQEocdtYJPgsOgDYD6Ef
         Rgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770962679; x=1771567479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nbsk2agQ8f3m0QH5WZrAhx9x+dI3Pqe/kCYQZSQSePA=;
        b=b5lDM0WKi5si4BKSLM0fHvo50+gR6VOZKY8Z3Cymq0QoYTfz2WTCWC520aWsh5PxRF
         EGCye7EexrVGKTusICohrhuhOswL1JL2HwIF6hTMlHgM0Wy6zSPjtPWcMWxPwMgULQxm
         obc5l+Voq2D62FZZZdZjPaJZtgpASTIvIS4vlXoDA/NXZKJBijgMImsMPeqCx8Ubro5V
         ST2yx4pixA96k2oRoO8JzpASplgw8gAzSdU2mrAWc4h0BX+dozUYrBm+DTM2BldW20sn
         bH75usZ11jTqcqk68RWBpwGbj16Yf1aAvFUZh47k1QUiOSPrBBAzp3D488VxOACkmHbZ
         iqew==
X-Gm-Message-State: AOJu0YzChWQQ1fCXN8WLsa7/RNubI2K5qdI5sQbkfs1RsF166iZXnEBs
	2bLB8FZsv15rc9sBKvmKN+85OehVmX2u0Xnwdpd5lwj/RHMCk+xcGOWPYAU2RMLO
X-Gm-Gg: AZuq6aIQejqZ7D/OyvkMqjiXl4Lfylfzp6Qpm0OiPAiP7ScJNEVxVXTD5wgujtpw0eL
	rNLgft/P0+gpWyDYjUr5vS3W711DrVsK6rvzqxD0ZTzsOLJejiZlI3NRsmgT82p0ZQ1UUo2JwVK
	4LlmVJHVECoalZUuB0FkRcpglMvbc6RU7n3dYVbnKyO1pTC29rheTBGQ+SULU8sKhzHINRaleL1
	vPlqQIwg8zAUtJgez6aH8gjLNIrhhgH9+bFI0z56nl85URbjF/CKEs59oC5P4tkntAfd1rr280W
	tEi3HdFvfQw0Lt0b+7hKnqI3wu3I1D5uM2PdMbLS1G6Ws1lENBw53E0/SP7i6mV4FYbQl+YUlBP
	Fn1fsXjlCdtN4fzwPraWLSSqxIviHSqqwgubfR6jVnNbAM1rpWeQ36aAqtSToIdMgLKr+HRL/d0
	vPGWe7uleYONuVgbxrSbgsATTzY5PLxZz+pRoRw7ufaR+tUzE5ByzY/7mr1eMI9tHa3GF3MgLes
	Y3/B5sJa4Vx6MHXTfmQi8lVaA==
X-Received: by 2002:a05:7300:6ca1:b0:2b7:a27f:3a6a with SMTP id 5a478bee46e88-2babc3aa2f4mr230438eec.4.1770962678519;
        Thu, 12 Feb 2026 22:04:38 -0800 (PST)
Received: from kernel.. ([45.232.185.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dcead76sm4803025eec.27.2026.02.12.22.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 22:04:38 -0800 (PST)
From: Maiquel Paiva <maiquelpaiva@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	gregkh@linuxfoundation.org,
	marcel@holtmann.org,
	Maiquel Paiva <maiquelpaiva@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH bluetooth v7 1/1] Bluetooth: mgmt: Fix heap overflow and race condition in mesh handling
Date: Fri, 13 Feb 2026 06:04:01 +0000
Message-ID: <20260213060401.14200-2-maiquelpaiva@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260213060401.14200-1-maiquelpaiva@gmail.com>
References: <20260213060401.14200-1-maiquelpaiva@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch addresses two issues in mesh handling:

1. Heap buffer overflow in mgmt_mesh_add:
   The 'len' parameter wasn't being validated against the 'param' size,
   potentially leading to an overflow. Added a check to validate user
   input.

2. Race conditions in mgmt_mesh_add and mgmt_mesh_find:
   These functions modify or traverse the mesh_pending list without
   locking. Used guard(mutex) with the existing mgmt_pending_lock to
   protect the critical sections, as suggested by maintainers.

Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Cc: stable@vger.kernel.org
Signed-off-by: Maiquel Paiva <maiquelpaiva@gmail.com>
---
 net/bluetooth/mgmt_util.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
index aa7b5585cb26..eee4bc05f6e5 100644
--- a/net/bluetooth/mgmt_util.c
+++ b/net/bluetooth/mgmt_util.c
@@ -397,8 +397,7 @@ struct mgmt_mesh_tx *mgmt_mesh_find(struct hci_dev *hdev, u8 handle)
 {
 	struct mgmt_mesh_tx *mesh_tx;
 
-	if (list_empty(&hdev->mesh_pending))
-		return NULL;
+	guard(mutex)(&hdev->mgmt_pending_lock);
 
 	list_for_each_entry(mesh_tx, &hdev->mesh_pending, list) {
 		if (mesh_tx->handle == handle)
@@ -413,10 +412,15 @@ struct mgmt_mesh_tx *mgmt_mesh_add(struct sock *sk, struct hci_dev *hdev,
 {
 	struct mgmt_mesh_tx *mesh_tx;
 
+	if (len > sizeof(mesh_tx->param))
+		return NULL;
+
 	mesh_tx = kzalloc(sizeof(*mesh_tx), GFP_KERNEL);
 	if (!mesh_tx)
 		return NULL;
 
+	guard(mutex)(&hdev->mgmt_pending_lock);
+
 	hdev->mesh_send_ref++;
 	if (!hdev->mesh_send_ref)
 		hdev->mesh_send_ref++;
-- 
2.43.0

