Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0DB315D5E
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Nov 2025 14:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762352605; cv=none; b=qz3A/x9GrSn4nl4u9pdnAt9OqxIH2Xt7qxC4SDsS8lKf+uXSCSTsrRpsyuifaluMFmd6BkSBetT+cZU+JxAhJqGn+PyM8hUbjlhHdB7CLDUnzCLin4yiAKBVd/JkAf4LtA3H9JehLV5qlUUvLOtzF3rZC8WSKsETopVknEpmWkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762352605; c=relaxed/simple;
	bh=qpmJTC6YKospDeO0jUXU1ZaIBfIL9Uhz+7Oos97PVAs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DJhNZzOLPfT5SDWxEuGD3LBBv87RqVBdpmNiiY/Fre2OmwSPtB1ntqXBYa+lFdXEY6NFJcU+IFbB0G7ZZcr8Wm2+RVkyUUkLsVZ8Ehy0fkrVGLQNDudnsLr0XdswC4L44eNevV9sy0dzb+zmyyBfx0UL5AsnH1Ar6q0XSXDvOEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=S3QptWGN; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="S3QptWGN"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7aea19fd91cso693893b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Nov 2025 06:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1762352603; x=1762957403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y71Q4Or9q+0cg0Yv4fMcIkVRqD+KfzfM2pip1To6eSQ=;
        b=S3QptWGNkkbtbB8GH8QNRrsS5wlxAmTrbj4czLeLVzNyCcaP1ztqpAnxttfA4Ssmtp
         cZ8p/3mKXaLv7nH0JELmqmAPSS0BLUVsKZ2w5Ywzf6Vt4c/HnH3mepfvM7yVFqMvHjnH
         ForR0ukVyTtqhn8XMPFMfiu/bfuGTo1xeH/X8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762352603; x=1762957403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y71Q4Or9q+0cg0Yv4fMcIkVRqD+KfzfM2pip1To6eSQ=;
        b=TKONSPzufyZYBXuA9872sLQ4Oq1glYUjEuw4bZO6lxypyYtr+FJ2AeoyOyAjIJ12vf
         YFo09sApg0oE070sRAbdEdjYpORgPQ9SrtXzXVQIVRfnL4jCKmW3+tDP4+Xiy6ZLluQL
         iuj7cBkBvavMvofOwB0I68zy840INWIu0XI9gKkk9U2AA2T1qLncBMv4lA40AVOEBmqV
         KwYs0EvZC+wof2cntrr97MklK9FhjgXf/vZXLPqrStFFSlf8LrGKpgSVrVml3rGiaP4W
         e+iFn5khmGXsAbxU5tnmU9M6OCGiAm4LK5xhqBGcq9Nd5v9D9XHrkLqG3/oBhSbSDKzk
         BNhg==
X-Forwarded-Encrypted: i=1; AJvYcCXwqRnQlSufw9Cf8FQVJiaT6MrQhABX/5PjA1tPWHB9Khc5l7R2kafSGknEr8IPmqwTyRR5rA/tKDEia2whLmU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyol4qAA/V8yRL1kA78r5SXnxkqoS4nKmPbrp0M7zwhTZuxg47d
	bz9RtnKswe8EwSyXzEhBgeueFzqCxn8g8Hftfqh62P2O6+rP5biNjVwY64BsU+bJQLUaU2fpzGx
	qn7iZLVc=
X-Gm-Gg: ASbGncuaQSPozQhngV1OspR0pFQ8gknx0BFhLYRANybYcT30V7WnPDn5ajDMekee0LY
	WltTMUiIM+QZHpCzzrCniTB/P5KECUwup/NCMzsnFLMVHpOTbuglYpcAgWfK3oGHE6Dyw4j8BQ3
	70V4nDma0JvubzxKtacMm7QxPa+NY//agsW1Mo0dCmijWBiCjpHypgtB6AD7tro0wU6I2Pj0I4g
	mgVj2LCnQzFit/qMuJBv5kgNpcyrlQzQQzTAK29spfjdTqpQlAqRX/J696AJ6eDpCvaDqj0gKxP
	UDFzppQwzRNPGA2VOwJ2acH3N5c3N5LjJjovLfxmk3HfvLbyeGquw9vVGx070IBs+CQg8Dj4yON
	avHQi4cC/hfHBa50wZ7O5KSqSx1jroSQOHe4Tz2Byjk4WmHXx7QYfcDvxQDgejLw8YadNJWxTVn
	BIHiKS9PZp1IW+59EELJO5bGhmgsbmMQa+PDuPAamTnB2Ugg==
X-Google-Smtp-Source: AGHT+IFQQjNZZXg3azKMLg0M8p5F0zJHNipEU0X4Cm3Gg9oyoPK3H+JFlHZpPjn/covtWTqzUQ8ZLg==
X-Received: by 2002:a05:6a20:a123:b0:34a:f44:1ce0 with SMTP id adf61e73a8af0-34f843107admr4405601637.23.1762352602792;
        Wed, 05 Nov 2025 06:23:22 -0800 (PST)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.. ([110.226.177.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd3247ef3sm6485299b3a.11.2025.11.05.06.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:23:22 -0800 (PST)
From: ssrane_b23@ee.vjti.ac.in
X-Google-Original-From: ssranevjti@gmail.com
To: marcel@holtmann.org
Cc: johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
Subject: [PATCH] Bluetooth: L2CAP: Fix use-after-free in l2cap_unregister_user
Date: Wed,  5 Nov 2025 19:52:51 +0530
Message-Id: <20251105142251.101852-1-ssranevjti@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>

Syzbot reported a use-after-free in l2cap_unregister_user(), caused by
missing reference counting on the associated hci_dev. If the device is
unregistered while L2CAP users are still active, l2cap_unregister_user()
may access a freed hci_dev when taking its lock.

Fix this by taking a device reference in l2cap_register_user() using
hci_dev_hold(), and releasing it in l2cap_unregister_user() via
hci_dev_put(). This ensures the hci_dev remains valid for the lifetime
of registered L2CAP users.

Reported-by: syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=14b6d57fb728e27ce23c
Fixes: c8992cffbe74 ("Bluetooth: hci_event: Use of a function table to handle Command Complete")
Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
---
 net/bluetooth/l2cap_core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 805c752ac0a9..6a880f8ab6c2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1688,6 +1688,11 @@ int l2cap_register_user(struct l2cap_conn *conn, struct l2cap_user *user)
 	struct hci_dev *hdev = conn->hcon->hdev;
 	int ret;
 
+	/* Hold a reference to hdev to prevent it from being freed while
+	 * we have registered users.
+	 */
+	hci_dev_hold(hdev);
+
 	/* We need to check whether l2cap_conn is registered. If it is not, we
 	 * must not register the l2cap_user. l2cap_conn_del() is unregisters
 	 * l2cap_conn objects, but doesn't provide its own locking. Instead, it
@@ -1717,6 +1722,10 @@ int l2cap_register_user(struct l2cap_conn *conn, struct l2cap_user *user)
 
 out_unlock:
 	hci_dev_unlock(hdev);
+
+	if (ret)
+		hci_dev_put(hdev);
+
 	return ret;
 }
 EXPORT_SYMBOL(l2cap_register_user);
@@ -1735,6 +1744,9 @@ void l2cap_unregister_user(struct l2cap_conn *conn, struct l2cap_user *user)
 
 out_unlock:
 	hci_dev_unlock(hdev);
+
+	/* Release the reference we took in l2cap_register_user */
+	hci_dev_put(hdev);
 }
 EXPORT_SYMBOL(l2cap_unregister_user);
 
-- 
2.34.1

