Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13102951DF
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 19:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745869898; cv=none; b=DlmQ1P1vQBMSdMt5+97ZmdNPU4fLxhv1eoWc6tFnET5lE8kq3WuPRpX0WE0QnnBKMsExX5jU1fSHHqXQ5ftwEugiu1kdaBH3OTBBYVYs5V7rg0jsFPTeCxe9FWsauOw8g8+yRkdHyeu4TQZ2OOuoiBD21qYNBlb5UgU4a+iQNqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745869898; c=relaxed/simple;
	bh=VGPDVXLYyZGw0bswnM3YvhKRJv+uPjNA+y0WcnAKPS4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MME3cLsXO2r6sflXUViVnFBRddX3LFS28d7VFPkfdBNOgFO0oZFs1vTIOC396+6x/eUnhqX3CcYT8lEf4hNNy0FJeq1EbqAS8yfmXMeGnUmpEjjThTdBY1H9nNqGl1Asm1ZOd+HeDPDM7HdD1CboseD02mMetLdNWn56JgHsfu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+26PNcb; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+26PNcb"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-51eb1823a8eso2879105e0c.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 12:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745869895; x=1746474695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9Ao0Hz/2YmXb4eX4MMkkt+UrMh9rLiTbSqgklBFTss=;
        b=H+26PNcb0hdw4W86wBd9rP57fSabl2cKpxS5QwxJYLqvldl6/gI7Rg/n4ojMdeFTv7
         qQRL8fnOV/8FmBuJvANINogE0Ifz7/KpUF0dTy+pUIXsrK9jM//BYn6Bs1IUMAk44lEy
         SELYBTc8iiN8eJOvBWUugFhnio4/gBTkOT5OaceuMzHerXudN5C6TpdHtFS1vtaPF+iV
         A6WjBy2aE/GNS/sCKXhn4KwhwFQV5+QOqMgMFM9xc0c7i5LJ0DgevccaCLR05JNeel8z
         6o+10o4C1re3ZUp1Qld1h6dWl9cplkoUx1eEG4KPyWsrCQ2CkaQiNuI3k9+JKhXF+32D
         o4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745869895; x=1746474695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9Ao0Hz/2YmXb4eX4MMkkt+UrMh9rLiTbSqgklBFTss=;
        b=TvY4ZF7jn9pZwZWc9tzV6av4lCjG+X1L0ntNZeyqaw5vSL9ZsHqrl0FuoWg0TfPNvU
         F0bG08RXC1/wmXw0q55L/dteQjyDhBsoPB4gdq49jVfIO7nWXaCT3EZL98Attj4U2U1i
         rW6og3yIWlhI5q9ztVunjbVuPuhYMJlYYWnfhqgLH5VyRG9L8fvT3+/qP0T1nqMdEB/7
         SPBigK7vxbjBeQ2F2IFjDIKYQ+ljm7klUCDAtW5hvk9TV+jpectI16h7k7c1LW3jDK1B
         nDLufH2uxynte8ZExy3v/Xpg1+CZQbg0yR7wP8VsPnL8i92L2wlr7xufnjNxhEZVHNAn
         mMfg==
X-Gm-Message-State: AOJu0YwVrXRe0o3ijaFikETjMJ8MKBXkzVlK9tsvMMP4M751whBjkmQe
	v2ukm16MmaedGf2i5pkVtQHZ2zaDo4DvhzvzmGChQ+zrEICYCcwClHmap7znooY=
X-Gm-Gg: ASbGncucya+ppFChdT4N458jTRt155CuepiXjHDoaGefKuFCTMXz7l3KVLk4OcV4x1i
	8ItoE20+UdObx4oBaRAw29u+pzuIlw9SRVsnpcO0p96/dVAQZj+E0Nnyk+z69Yssh+nP1Wjhqjy
	pSGJ2NHGYmr73Ck91yWhh8O7bNI3lYTAs5Y4j7wdDXH18uu2+aI2oANdjHWGREtYf95ASHeVgN0
	KR0v3Ivfq8lnLIypwnJLhBphR4z2iAs42UkLH29Ol2B9LbtPNRynkVhu0DzYI4uZ/LVQcvIAjtk
	zSJGq+uTDsb5xn0LX92wz2ysD+2LP2epKY0VcNf+hH7EgcxN8h90Px+fVwrzR75otu/O3PPY5x1
	3L5myY7k/qw==
X-Google-Smtp-Source: AGHT+IF6fMl4iDmqzSoracgWRuQt8mzzAvE/TU14ZuKId/HWs/vlizTVontEVOmMbF++BtOyP+Haiw==
X-Received: by 2002:a05:6122:3c95:b0:52a:863f:4189 with SMTP id 71dfb90a1353d-52a97132b78mr6461683e0c.8.1745869894725;
        Mon, 28 Apr 2025 12:51:34 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52a99279c2dsm1067669e0c.27.2025.04.28.12.51.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 12:51:33 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 5/5] shared/bap: Too few arguments to formatting function
Date: Mon, 28 Apr 2025 15:51:22 -0400
Message-ID: <20250428195122.2000808-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428195122.2000808-1-luiz.dentz@gmail.com>
References: <20250428195122.2000808-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Each call to the printf function, or a related function, should include
the number of arguments defined by the format. Passing the function more
arguments than required is harmless (although it may be indicative of
other defects). However, passing the function fewer arguments than are
defined by the format can be a security vulnerability since the function
will process the next item on the stack as the missing arguments.

Fixes: https://github.com/bluez/bluez/issues/1221
Fixes: https://github.com/bluez/bluez/issues/1222
---
 src/shared/bap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 4c5b38b1e3d2..2a08f3eea7b8 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1630,7 +1630,8 @@ static bool bap_send(struct bt_bap *bap, struct bt_bap_req *req)
 	DBG(bap, "req %p len %u", req, iov.iov_len);
 
 	if (req->stream && !queue_find(bap->streams, NULL, req->stream)) {
-		DBG(bap, "stream %p detached, aborting op 0x%02x", req->op);
+		DBG(bap, "stream %p detached, aborting op 0x%02x", req->stream,
+								req->op);
 		return false;
 	}
 
@@ -3138,7 +3139,7 @@ static uint8_t ascs_qos(struct bt_ascs *ascs, struct bt_bap *bap,
 
 	ep = bap_get_local_endpoint_id(bap, req->ase);
 	if (!ep) {
-		DBG(bap, "%s: Invalid ASE ID 0x%02x", req->ase);
+		DBG(bap, "Invalid ASE ID 0x%02x", req->ase);
 		ascs_ase_rsp_add(rsp, req->ase,
 				BT_ASCS_RSP_INVALID_ASE, BT_ASCS_REASON_NONE);
 		return 0;
-- 
2.49.0

