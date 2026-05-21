Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEE839FCAF
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 08:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779350708; cv=none; b=AIOTa3ptrmB9IRzNhvbvOg8II++cK6rfMyUUDm82A9CbOdDKOx0WkqBY4J4EvCKpWN9q40rGUBhDCqcXnBgXABroCeWuFLWcGLiqhSYJ3mgS392jx5+h6lzu5FRMmdd/9blPY48PW5ceM1h6aEB9Jvu0GgGMcjk09RXYhX/oLoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779350708; c=relaxed/simple;
	bh=RL83CSKyQUpDiyBsLzSdeCnSEtC6fKm5Rq4HrB5Vzao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TgeSO7DQVRbFUblTfLP5w79JIXAm5W12Ho+GdaOHlZcUmWF0MRoAEH7HiXPDF+XgLNW3PNvT/OVTOi6xnKMts4oOK+L+p9k/v/QXTtYDGdg7HfgEDb1Z0neWFMgqpBmTGrfr5ynZzVajmfDVbO5w+mJSTDz6R1JfhLXDojOWAAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQljZwvQ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQljZwvQ"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-365deee00c3so526234a91.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 01:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779350706; x=1779955506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a2KomId72zCewKwGpKqCRi1v/6H+d0pzbRCY7T9vPPE=;
        b=IQljZwvQ57N9v2+gt6xdjTbg2+HXAjWm7EH4E469zxgf42bfglIeKNoUCI+UyhUlLw
         0kp9ayyYYGiqLKaR1tuEXjRBKkz0p+IY2l2eNTm6p7Lv8sa9q4GlkjKklfJn6GnMgmfF
         00Q6LxH3TS0fhxMSBcSbzonE5MXI8CM4OCUdfeqEjnDRs+oTyn8qa1sJLB6+l1qv5hcM
         43fRqMVstBTeperqIetOfOjSMdxxctIMd+E2HfHaPtSO4LQIA5S2edyGOjwcbjWqcCBD
         AyreiMS9p9DZnELzKhnsVGZhcbhxoa+O6wJR59s5ccdcO/0UUU7Y9J+03eF7UZrnTdjk
         0iRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779350706; x=1779955506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2KomId72zCewKwGpKqCRi1v/6H+d0pzbRCY7T9vPPE=;
        b=YUK0zaFddL9LybHF1vkcW84dU6QXLAG029U9RLmQttCHBiKTS+oa/5ldvZqj4grqSH
         UQuSJ1h842wLsK0GApI5fYnTmbBdjUOEdT6BcDGgkJYtuvJt5vwHjH5tfV7Iyvj5Xdpb
         UhaWDHRmUdDeCvwFdrS6VAda9Ah7ZK9OfLWtx0hVM+AF1BAUKdvUQFknhwPlUYoM5FAZ
         Kdrw2blGxDc02qB46LPL8F+q1yIYExmEmwyFjjb2hVsgfXPUDd3M2zLg0ffRSMbWzk6L
         g5DruHOXw6iTY+UaNEtqo+G2z5psQIC9OgZJi/4uSIW46Agd8VhHqXNvse46Q8B2uUsQ
         RcCg==
X-Gm-Message-State: AOJu0YyBb39x1Ax8UnACD631xHGPiBrB78ysjlBcs4VxI/ObVqgaE3b+
	jr9dNW8jsqSf4vv3CBdzj99DSpm5X6MWVxg0BykJGB4Ie3B9UQSiFF447np2w2Ie
X-Gm-Gg: Acq92OFZHhMPaGFCDs/rzmk7+bq65PDQzArhZeuFBJ66Lvg9JGiZjcbnRxU39L/uWUf
	JuVy0rV4IkKVa7ywo9/8tL4oadYiSm0V3lu3EPCZLYMqJRgIAqn8kpR3iYpjHiEdfT/2YyQd7/Q
	9GdvXc+Xcsfxeunr8k9WccfZFHXVeVrJxhYTI5tIi2SqYFW2TyD2/s22YK44GOkCRyRPHK9/R9I
	/gZGgzQnqh5iKnwMxFVSnXxKfQ/R5Dw9TVhO+kUsrYu4AyqdSo1cY5FjzxJacjneU4WQDZRweah
	hGSq3VkGECK1V8S3QNnyDMw+/O8J5XZCyPUHCu8fDI97l2jqRu9fXSPWmoROmxbfTTKUOW93Dhp
	rKUcqehuJAfdaMx0ooJS2vxQIsBF+uy/SYH57Z1mr59t36VxM7aGp7lYcoczgiX+lUYQcsHWpt/
	CI9YvNiVPBBox54X7EAmvwe106ASFF
X-Received: by 2002:a17:903:174e:b0:2be:9c3b:7b0b with SMTP id d9443c01a7336-2bea2fbb7dcmr10885165ad.2.1779350706128;
        Thu, 21 May 2026 01:05:06 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea9179ccbsm2992325ad.14.2026.05.21.01.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:05:05 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yang.li@amlogic.com,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH] Bluetooth: hci_conn: Fix memory leak in hci_le_big_terminate()
Date: Thu, 21 May 2026 04:04:14 -0400
Message-ID: <20260521080414.44460-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_le_big_terminate() allocates iso_list_data via kzalloc_obj but
returns 0 without freeing it when neither pa_sync_term nor big_sync_term
flags are set after evaluating the PA and BIG sync connection state.

This early-return path was introduced when hci_le_big_terminate() was
refactored to take struct hci_conn instead of raw u8 parameters, adding
PA/BIG flag evaluation logic. The existing kfree() on hci_cmd_sync_queue
failure does not cover this path.

Fixes: 1ffee96604de ("Bluetooth: Add PA_LINK to distinguish BIG sync and PA sync connections")
Cc: stable@vger.kernel.org
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
---
 net/bluetooth/hci_conn.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 11d3ad8d2..9c5a3dbf8 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -803,8 +803,10 @@ static int hci_le_big_terminate(struct hci_dev *hdev, struct hci_conn *conn)
 			d->big_sync_term = true;
 	}
 
-	if (!d->pa_sync_term && !d->big_sync_term)
+	if (!d->pa_sync_term && !d->big_sync_term) {
+		kfree(d);
 		return 0;
+	}
 
 	ret = hci_cmd_sync_queue(hdev, big_terminate_sync, d,
 				 terminate_big_destroy);
-- 
2.53.0

