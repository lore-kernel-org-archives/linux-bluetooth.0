Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030C234B421
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767719970; cv=none; b=ZBm3JKvhAbgM2HWaeZq22mZSIaLm2oUblZFmszQE0BFjr+zgB+fAFOfuiFJ2DKdTKimS4dop6Y5ht9NY5hrucVSxQS9yCAwDUm5XoI/DK1eI/RdUdpxgzAC9+HJkyfQZ9mAarIwxKR8vOfxdUSgECN1UKNzPb8Hl9/5k8k4o6Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767719970; c=relaxed/simple;
	bh=XCtkft8bohaeimnq+lp2cMogo+aH8B2GI3J6/21tYXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bvnH1w9pP3gZHiE/Z47ghfX9tBCDX4rqejgV7DMXdfaiYIPSQGVdeXjb5tfUhNRvdGLes4aoH+T4qu3mdpxiwj8ezrdj/X8Vn1EtREoVpAp/Yz5e3KoTRS7BHc4L3K40iaJYNvBb4GxaiHMT4Jceos6hmOXHXoXv18ypxh7P8+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pwe4Tu9b; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pwe4Tu9b"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b6dd81e2d4so1145431b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Jan 2026 09:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767719968; x=1768324768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8+OyAyzrGoNWAXYfPY2DX52zu0b6XYq9idfXYiJBSBM=;
        b=Pwe4Tu9b0OaLmgLmvZmaVKTP0GmkRSi2lgsvI92d9NCFsr2H7z5Q+T6Oy28n24qt43
         xsxW3qoSb0kUbT8oxK4rXLWgk9L+HdARJ8ddjxiUFv8ilBF29NYLgKlbX3kHDaiZpQ+e
         jM3g+03FP4bC3FYW5IZgHzkLztw5t5OCWgw4L66hF3huiCI9pq2ZuwqSemhdCpX9wLdU
         g1CWdjFmpqOcNFFMmNXalXkF7t+1Vb5Ul5K7sgFrsyjZ2zrqfQNEoRoCuUQJI0Ks5Qzk
         IKlk5OR/vVeQ46/7IGrqQ/WOU/4OQwz9z3sH7tVX4Fidfk9cwr+pEJppDGJ7byI5E+Xx
         njpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767719968; x=1768324768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+OyAyzrGoNWAXYfPY2DX52zu0b6XYq9idfXYiJBSBM=;
        b=n78Z8BLw23Kbq9H+vnpSPcRGXaTHthwLcPMlUApKMl6taIYyijo1mnJEYypRQkO7xN
         JVh2a8z4ln2E6p5veRRIReG6J+mGBUbNVbyObyI0YOE1LmEH5VQT/tQmLQw+G7ISlAqO
         G+HfXU/9PG8Wlyg2zYNI0A5npcoy18dRJq0pOzViLHDRfdUoxoW0SrxOTEH0XPAWAnsv
         iqJIbynp0CiksNTlHrqrCbFK99ZGvyYLwOsTekYU2rwiPdbeCJ5XHNR9BPKOvhuUZa/C
         htBHyGpZsci0f8cK2kWxmn/2XLxP0DFueOSz62dM+sKR3lL39z4NPC8pzsYkzuChoQHl
         fyfg==
X-Forwarded-Encrypted: i=1; AJvYcCWrLN0SIyLuwiSQ0u4FcAPjfkresR8BJsUWBRkv063TMn39OOKC8LZ3WhdHlGfiACnLlEkPz0mPKop7+KJftA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAwQRpQkgQqGf2G5wnOePFX0f23R1MdwGY7eZA1Y6ekN70h2U8
	uubWgHcSXUYQMYPoSj+enbUvZI+o0sAA8wBRtcjOqYTnoKovXrGYp375
X-Gm-Gg: AY/fxX60o+FZf/l5YMRw/0yFo6l9FLgxInYoAZgryQK6hzMpEg+3i0MoM4NvkFnajH8
	d4TXIo1pYdgH7t/HmQgZlwcoFaNGY5K6hp0NnIBZc2PXdEY1DvBkZi0vvKmo8kNM2qyKMQFy1/F
	6N5VQwqMvSY96czWbTwzOwAtW6Sm70bTVwGmOpSKfSndEK2EkcKqiG0bzdnVyU5EtssqfmOArp5
	auFbkiDfbtplB8j5tRGoC3M+x/uDsElydquX9JgCfBCH1/3Hr7ef2KbR5DB+KbuwE0Rp+yBYehL
	7QcM3TwfgHr8ZN0Tv3pwCNdvPKn3scRizsZPfqkMuUZglRA+5/gBm4J+zkcLR08xufNyea6uh4H
	7u5vxMeAu8pfSRgjmfWcVu3jUcdwv9fYOO+Ukrm7bjTwCDoXyJYAE03YMbIbP7Gpx83XofHALHd
	gDRukX0RDqFnjbiH/mauBN08zVoXIieqirvd0NeYi+QA==
X-Google-Smtp-Source: AGHT+IGYSvTn1Ci9vinRdw7r0xeSkSd2eacLOLCfjsA7K6i+z4Vc1na+KoVQcKiKdfAdirkFse65rg==
X-Received: by 2002:a05:6a20:9183:b0:363:e391:38a2 with SMTP id adf61e73a8af0-389823a7fa6mr3325497637.46.1767719968136;
        Tue, 06 Jan 2026 09:19:28 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:8838:65fe:636c:fbb8:d9e1:61f2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbfc2f481sm2875157a12.10.2026.01.06.09.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 09:19:27 -0800 (PST)
Received: (nullmailer pid 124163 invoked by uid 1000);
	Tue, 06 Jan 2026 17:16:29 -0000
From: Kathara Sasikumar <katharasasikumar007@gmail.com>
To: alex.aring@gmail.com, horms@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Kathara Sasikumar <katharasasikumar007@gmail.com>
Subject: [PATCH v2 net-next] net: 6lowpan: replace sprintf() with scnprintf() in debugfs
Date: Tue,  6 Jan 2026 17:16:11 +0000
Message-ID: <20260106171610.124138-2-katharasasikumar007@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sprintf() does not perform bounds checking on the destination buffer.
Replace it with scnprintf() to ensure the write stays within bounds.

No functional change intended.

Signed-off-by: Kathara Sasikumar <katharasasikumar007@gmail.com>
---
v2:
 - Updated commit message wording
 - Targeted the patch to net-next
---
 net/6lowpan/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/6lowpan/debugfs.c b/net/6lowpan/debugfs.c
index 600b9563bfc5..d45ace484143 100644
--- a/net/6lowpan/debugfs.c
+++ b/net/6lowpan/debugfs.c
@@ -173,7 +173,7 @@ static void lowpan_dev_debugfs_ctx_init(struct net_device *dev,
 	if (WARN_ON_ONCE(id >= LOWPAN_IPHC_CTX_TABLE_SIZE))
 		return;
 
-	sprintf(buf, "%d", id);
+	scnprintf(buf, sizeof(buf), "%d", id);
 
 	root = debugfs_create_dir(buf, ctx);
 
-- 
2.51.0

