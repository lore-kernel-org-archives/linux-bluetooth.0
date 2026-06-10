Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078F3CA6F
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 08:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079672; cv=none; b=rl229qnCcJC34vO7KeN870p3ZoErAUhe9FfKum+mye0Z6MAq93pTxabz4XoiXBEg3MtnHy04ug091M2HS/zeRBbZoF3zuzZvUR8dcu5yj2IT0myB8aNuJqS+6FHbkAC+ARm87AkPSUwwODeluClRyskhmbO3IUBTA1PeIw7BoME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079672; c=relaxed/simple;
	bh=5hiZuRZ3R8BKeQdwu37rQhfnOzwV32ZTNgddlIkb+t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvSAeowWArdnqkoe9s3LsLqgld+o5lLGVSD5s+x8VdVv7vX1vRTDh+Puz6usdL6wYqcPX+rOkWN7M6LSP1HA4GFNxWSSXDofR5fLrXJEa9y7Y08BGmzyVYY3nc83I7hW+gl/aWAhNz0EwjbAbm6NwS24Ksd4hSkDkfGELBmlhjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=bhiDDdqe; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="bhiDDdqe"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45ef4223be7so3506920f8f.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 01:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1781079669; x=1781684469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXe7IH3a2yzN3R7m5sqi3kEoDvOvG6hGrdGYhZgZ96s=;
        b=bhiDDdqermV5yX2760FxnzMmYc6SfQ+8HkIvgdRPgywxVAF3z+hiscJQ/v4vAZ7J3X
         suM/2nnrR1zCotQuQr/+lVtn5tcq4GiJSeovKZHpZTtT0RLbs0qgh4oax85FAc/Mxdfu
         7nUYS/qhd7FoaPrsuSHcRwMEeq/toWXPJA1NM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781079669; x=1781684469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HXe7IH3a2yzN3R7m5sqi3kEoDvOvG6hGrdGYhZgZ96s=;
        b=q5fMBbaocXP9JNCrF2pZs+95eMu5Pe7v4waDQnxXMqAfmzLwYAr/HhGn9ibPPVw2n+
         TaMWDIMQzmNHiKvE4/axfzuJAwmP33nyIyhGa/bwQKxXBqCe+6LvQ0cQuct3YE+J9ZMX
         xSXSDeHdnhrB0KfmcJn0zM0sgSMtyeFHTTmpcXwYD0QUAqEG+oK9gqIq9piEx+6U9QDJ
         Vu4sYS0mhTKBaTzVuOUD8E23dSWUhF0HeHOa/gI3uNZYbK6X0klBSa6J+A4bL6oHjsrc
         R6c1vCr3RUifxdZPzBxUn3BVzTgAz+1ycmuPMfUrSVhDbedsKDOYr/d4z5/eU6rV2FsD
         R1bw==
X-Gm-Message-State: AOJu0YzC0r3oj08jEF9pnAzs25gtkfVN/+Hb96YQAI2PC1l4GP3271p9
	kU4IwoHuvZ4UnZht3vfkP9txtMjTs04Y39lBO9I9UrtqnS9lSwvE5EpiKRiryi2gEiSQhyNVmNp
	hxr6p
X-Gm-Gg: Acq92OHJ0JRTX6NenFRleKKZkgkme025XHd/LPLiE5xlRdi/vl5fgSpIvKdVSKWWqt5
	aLy9nkpsXQ8ct9Tj+rbn/wreX4a+Jv7zPHfCL2hg9LrUwxiwlpd51FgZjIs286ED5ljcOOOU/kw
	5Aw9/H6B8bxYCH+FNAJ8I1dG91c1FG8ie2+iE2TKToXjz5onSfOyI+NNoePxgf6mDtrCwurKoii
	AV0y/VL15UtU54C2Qf3FK5SiHmZfptnqi1zHxDpxgDYzF6bj3yzaX4ZMDe9to+QhrD4zjVe+RR/
	eWCKoovzq7ETz/ygBDTgu5+WbH34qy0kXoW7xDcOC1PvaaeOtEVbiH4hb5ya0ze9DO1IeJkSSJ+
	Nn//uR0PbPe/L+LENNZPUs0CUa7RaUbKR7zMKrYWDLnAy66QyifX4qigjYZZlo1YFr1eK12nib6
	QQ9xb6B9lo7divsnmI0et0UstEbjT/xUHjk5YcDUOsjsSVwV02DD+LuFg=
X-Received: by 2002:a05:6000:1844:b0:43f:dd91:b022 with SMTP id ffacd0b85a97d-460566ca072mr8794537f8f.35.1781079669411;
        Wed, 10 Jun 2026 01:21:09 -0700 (PDT)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:e2e3:d5f1:fbcb:c827])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2f67c6sm67204770f8f.16.2026.06.10.01.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:21:09 -0700 (PDT)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2] adapter: Fix failed bonding attempt after LE link disconnection
Date: Wed, 10 Jun 2026 10:20:54 +0200
Message-ID: <20260610082054.3915366-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608111034.3684632-1-simon.mikuda@streamunlimited.com>
References: <20260608111034.3684632-1-simon.mikuda@streamunlimited.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

What happens when issue occurs:
- device is connected to both bearers BR/EDR and LE
- bonding is requested
- LE link disconnects
- pairing keys arrive

BlueZ would finish bonding request with error and mark device as
temporary. Then it would be disconnected+removed after default
temporary timeout (30 seconds).
---
 src/adapter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index cc753fbd6..538f63e0a 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -8622,7 +8622,9 @@ static void dev_disconnected(struct btd_adapter *adapter,
 		disconnect_notify(device, reason);
 	}
 
-	bonding_attempt_complete(adapter, &addr->bdaddr, addr->type,
+	/* device could be still connected to different bearer */
+	if (!device || !btd_device_is_connected(device))
+		bonding_attempt_complete(adapter, &addr->bdaddr, addr->type,
 						MGMT_STATUS_DISCONNECTED);
 }
 
-- 
2.43.0

