Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1031C1740
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Oct 2024 19:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727812140; cv=none; b=cSteq2fEIoj+6q2JsldVM0CJOlGWyj4pR8V3D911dmKl5Telu7r3nKA9TDZmuVLAKgd74hYWGBUIxR340PvxF7C+dJXn/YXrRHi4izqlOXTc3Sdw9hg85nBvKS7PXhH98pv9iFT2merKL+TNjQCxxgNJ/aSytAXBSfoJa1Y/AOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727812140; c=relaxed/simple;
	bh=6Rk5RE7yodzYpQ+y3q9VN6z1hZQ+lcpwQaSPKmbzGJE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=queM69SQYSbIYr/LdgJO+hvV9FI8A6vK2aLFW32FydvEbGbC0ksqa/nSX/7tWTUmxqtE0I8V6zTqAeGNdrWQgIm4B8kYptaXWy3wH9mml8kMPcB04FQAAzUVZgujWOsZzsEIdQNgh2BDEOT9XZtuBZqlXukyT0wDG1TV8jaF96Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBwso2d0; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBwso2d0"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6de14e0f050so49124807b3.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Oct 2024 12:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727812136; x=1728416936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gtg4RyolX2O0b/lnwqLCcBciW7zTeCfQymbirnZqhl0=;
        b=dBwso2d0AlpcfhfHbgyFWIOivmQDZfoPfuhLO0Lo0rcJ1AqFIc0ZaIOdNXrpXo15Jf
         y0OeV7rBoPpXPi/zClGIZSqCYKLP9dygnwAmmiBE51TVmn7QcxK2u+mthhqv7VSNKGiD
         OrxxOqI3WP1v96nRIcnCOUwBgbTjfU6bhWWd54zuIlx/GlxLT0TYFUUYDCD4pzYzFGZi
         v9VcsbWKuQrCJqzb7BPuw+XZczCgdaNQGMpt1lUgBs/t2ISfXR8dIlHDt8cJ3TjML2dj
         upO+e94btXiDwRKal3PHwlXxRuYnSGMn17rnJK9vG0UfGustDjL66meDT6FDhLjygKM+
         ZA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727812136; x=1728416936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gtg4RyolX2O0b/lnwqLCcBciW7zTeCfQymbirnZqhl0=;
        b=Rj+zWs0tEyofwiveGBzg52/Rtypek4xKMgc7dU5Ysrmx3slAgTL8q9STaSdBDu6ZTc
         HJ4mRz4ysPouTKYzSdPn1sY+FzMvurO+bz80FbZxjkdw7oEUSLE7cDkJZmmOlip4Pd2I
         1ePZy55e8aavvWDXIJam3fbYFXcrSlxSpOQJOtmCCoZjHqTdx3VR6YoAy1xh+vBre4LT
         q1het8QsZxLh/KBL65gtJJpTRlkjJyPJcCzVFafGHU+qkjy8MptnLMbB634S0zJb7dHH
         yn4fP4l0VqlmqsnyCyJdzf/5xvUB0OlGHglzKhxdWCdrwoGAsDQZZN/DdkV9htlYv6UK
         taRQ==
X-Gm-Message-State: AOJu0YxUCb1od1qbzPrFS3y9cjy0a4WbFRNOTS50MXBeMEqkh1+Rp9mn
	/CQkUPsxPsfQs8L3qv83uHHXf9uuZAgAX4SDxzd9JsJa8XnwOr37dJ7QsA==
X-Google-Smtp-Source: AGHT+IEkXbMSlzX+OXae74uiImTuLFuWDfwC5cCgnkj35A5hA6aGfq10DYU5o2Ra556422w+4cHcwA==
X-Received: by 2002:a05:690c:7204:b0:683:37a8:cd77 with SMTP id 00721157ae682-6e2a3062433mr8850217b3.29.1727812136601;
        Tue, 01 Oct 2024 12:48:56 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e24536a80fsm20848347b3.83.2024.10.01.12.48.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 12:48:55 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: SCO: Use disable_delayed_work_sync
Date: Tue,  1 Oct 2024 15:48:54 -0400
Message-ID: <20241001194854.3186216-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of disable_delayed_work_sync instead
cancel_delayed_work_sync as it not only cancel the ongoing work but also
disables new submit which is disarable since the object holding the work
is about to be freed.

Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/sco.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index a5ac160c592e..f0604d7834df 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -208,7 +208,7 @@ static void sco_conn_del(struct hci_conn *hcon, int err)
 	}
 
 	/* Ensure no more work items will run before freeing conn. */
-	cancel_delayed_work_sync(&conn->timeout_work);
+	disable_delayed_work_sync(&conn->timeout_work);
 
 	hcon->sco_data = NULL;
 	kfree(conn);
-- 
2.46.1

