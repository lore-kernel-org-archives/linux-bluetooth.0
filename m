Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3422E8B83
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Apr 2026 16:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776529623; cv=none; b=undo76HjTlmMrIUCi3Yldtd8YNGCCZ/lzacr9uGELxBlSMK5JrJlm2lH0xzL6wt/Ou8hkNpWYjKHdOhOUPvxRDP/DVDTTnz0qAn4any0XlgnO+xQjdq809eY22p5PjTkKkeThkZJpZlELFgtwMFhYGpaia7HRj1BD+zABv+WwRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776529623; c=relaxed/simple;
	bh=EMv713bu6rLltkrUGcU31lQfDklcCaytyNHzIYqIhss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khkjX744tyNOTsaYIDc28Rk56/0hoB/xZHey/Rnb6dsIn2xMX1YM+dxhiS2BzBRb2fnIjKzd6qkj87O9N7ZitA8qHI36gdX8ndal1acecx88cTiOcujkmGn/GuvSPEutPIDhi80MZQcROcx/Cy0/YcgwjnsVb+dGoMUciUv3XHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGIkzRgj; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGIkzRgj"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488a29e6110so14819735e9.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Apr 2026 09:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776529619; x=1777134419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1z94owYXX9n4dFeOaZ1Wv7/kBQxfkHENluA/04AquBc=;
        b=GGIkzRgjuD5JgHXr0MtS4YQAeHYLwajNVUu+xif6ybGMpga/rF217QZxcfTVf1yqP9
         W8i3DBXbVGs6wMZ8EkNgZ1CYu7HMSZDWYWS0jmxOSE3/8gRgQSTMkKPcqbKclYBIqQ58
         9oU7b6ksPqqFX2wEMLJ7NPUdI6qwL+ukfzmKJd/ds5dtK7hvSOIQUDhCNRGNluzgr0Af
         jpStYnK/KY98ezz7XdLBvS8kNgCQrlsDMB39Kl6+Ba3GGVmyz9R8O9hgYFfginawQZDn
         +RBrQCFTBQ63OI5MLkAaV141LfrfrIQEwiDqnyIiH9v0mKeGSv1BcflsBqkpdM25PSlv
         wKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776529619; x=1777134419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1z94owYXX9n4dFeOaZ1Wv7/kBQxfkHENluA/04AquBc=;
        b=AVZkSoBJYTNr/QoyfNhKzNwwft7zcyp3kOm4vUw5txIM4iw65VD7y84/vq809IUU23
         spXE7pANjzFWdqOshW9d3o696sIK+WR093QMyYB8kiQYIbB3sDi/lUjBgqa7HVumjKMR
         wIkScc1GZ7e/6+nPvEqnkA/e7l1e/zzzqNxq8Rw3GVNDTBwkxZf/ZmCAuAWI1Ka2d1ie
         dmUmi55mCiFRAgMq76rheMstAThSYF9QanHaam7jdCNOovvh0JY4cICNzddH/o9JKE9U
         1B+5q/g1DQa9sdqVaXovSx8kPfTFjD0bwQbiL+X2iOH+LRcRvh2qizBrmYU+23jngWf0
         pGPA==
X-Gm-Message-State: AOJu0Yzj9VmRzLIjWxHJPbWCXygbIAnjDGX7LPD09DPidH4JYKBlmV1v
	BOzNpS9EiH/KwdjYueTnmo7psol60pKK8jbgbtyvHY5IVZ3fPip+6yaCg2b3WAEh
X-Gm-Gg: AeBDievedjroJX10F7GQL3eLWkK9aG8U7lkzuhg+lOsjrg21BxsVyt935dG28C4qpOw
	silwFHyRsZ58pXaYN3RX+mAGk2lg2G8IuyeD+YPVC5wJwqNtQ34hXla0Z3SF1zUY073fSE21fE0
	1CMk1MPPTlnEtbCZQcbD43BDCxEzFtr8UtqZvJzQ+KXr6oCwHxm40RiTJl651iPf3GpRlbDk5MD
	iZd71sR55HxB2RcVIU/ulHC7/ZqETjzu57XqkGP/xijewdrgb2m/S5CX4vdGLkZuHBop3Oak8/0
	b1ETb7pfDXXvJR3F2hg3/lXWXjTBhrn4YoaiStyEqnZ7y1IjsLzoNA18ZUuPVUC5Q5ww6x2nRiJ
	OSuWd1lPqSdKmoO2UybNBXQUNReovug/+Bl1BFkWXeqDfV2YCmdSFmPAfXmd687OCgr4mlx/Oyi
	QHoXizmfiTvh3bJNdljkFp/21md1Il393OPrkzwjKPNvutKDWvTQ8lLnbxj3h3eptp5MlFV89z4
	+042IY8iijy5GRv3KaNxLUUc4f7i+ec+1LvO0zNn9CyoKxY
X-Received: by 2002:a05:600c:8582:b0:480:690e:f14a with SMTP id 5b1f17b1804b1-488fb77d3a2mr77087395e9.14.1776529619191;
        Sat, 18 Apr 2026 09:26:59 -0700 (PDT)
Received: from server ([5.14.142.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc16f93dsm214456115e9.3.2026.04.18.09.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 09:26:58 -0700 (PDT)
From: StefanCondorache <condorachest@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	StefanCondorache <condorachest@gmail.com>
Subject: [PATCH 2/2] adapter: remove connected device from kernel accept list on connect
Date: Sat, 18 Apr 2026 19:26:52 +0300
Message-ID: <20260418162652.287637-2-condorachest@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260418162652.287637-1-condorachest@gmail.com>
References: <20260418162652.287637-1-condorachest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When DisableDiscoveryOnConnect is enabled, remove the device from the
kernel accept list once it has successfully connected. This prevents
the kernel from continuing background LE scanning for a device that
is already connected, eliminating antenna contention on combo chips
with shared Wi-Fi/Bluetooth radios.

The device is re-added to the accept list upon disconnection to
restore auto-reconnect capability.

Signed-off-by: StefanCondorache <condorachest@gmail.com>
---
 src/adapter.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 4a18adfe0..48f0f2cc4 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -9533,6 +9533,7 @@ static void disconnected_callback(uint16_t index, uint16_t length,
 {
 	const struct mgmt_ev_device_disconnected *ev = param;
 	struct btd_adapter *adapter = user_data;
+	struct btd_device *device = NULL;
 	uint8_t reason;
 
 	if (length < sizeof(struct mgmt_addr_info)) {
@@ -9546,7 +9547,18 @@ static void disconnected_callback(uint16_t index, uint16_t length,
 	else
 		reason = ev->reason;
 
+	if (btd_opts.disable_discovery_on_connect)
+		device = btd_adapter_find_device(adapter, &ev->addr.bdaddr,
+							ev->addr.type);
+
 	dev_disconnected(adapter, &ev->addr, reason);
+
+	/*
+	 * Re-add the device to the kernel accept list after disconnection
+	 * so it can auto-reconnect in the future.
+	 */
+	if (btd_opts.disable_discovery_on_connect && device)
+		adapter_auto_connect_add(adapter, device);
 }
 
 static void connected_callback(uint16_t index, uint16_t length,
@@ -9593,6 +9605,15 @@ static void connected_callback(uint16_t index, uint16_t length,
 	adapter_add_connection(adapter, device, ev->addr.type,
 					le32_to_cpu(ev->flags));
 
+	/*
+	 * If DisableDiscoveryOnConnect is enabled, remove the device from
+	 * the kernel accept list once it has connected. This stops the kernel
+	 * from continuing to scan for a device that is already connected,
+	 * eliminating antenna contention on combo chips.
+	 */
+	if (btd_opts.disable_discovery_on_connect)
+		adapter_auto_connect_remove(adapter, device);
+
 	name_known = device_name_known(device);
 
 	if (eir_data.name && (eir_data.name_complete || !name_known)) {
-- 
2.53.0

