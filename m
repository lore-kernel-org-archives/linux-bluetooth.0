Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2722414884C
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782731069; cv=none; b=p5t3fRjh+uyuCLU5CbnQXqXomjJs13e+xoieUs+pGa+kjzsJJgFW7WkxQDtINzbvYMDh4YZW/fvvUT25yynHUvAXkWHvVVHOjCW1QdxoTSs0xZ+ZT1s0SFiQSYr/1p7vK7A9KltwmGJLRbJsNlSxyElkGfnGTybdY6GXCIPLcpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782731069; c=relaxed/simple;
	bh=WnWyCT69qqAeBtcSs5TAxdDrYRVZzP3DQEXySulJOog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TizP1oghpjE3epZYc0LtAXCEPzNnfGm/ygDHL1mgY0f2SkrOywNbIhNnY0oz8iU2vFe0Gl4PNLNgHX5FAr92iemaok08cwRummuv+S5vHWxV1yk2zxprCanGg+1VMkREJLUHDknUqoCURO7Geno/TEiAgYCkqrvrrWegDNJg/u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s7eoRtdY; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7eoRtdY"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84780c95e2eso463664b3a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 04:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782731067; x=1783335867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1hHHsDIbbNW2mvKYCvO+OggmhpHSR1woASylmKNhS0=;
        b=s7eoRtdYDGTktjwslQC8ePmlGxAZpxmktj1BOakey8+so9zoM/HFSHpCjX6yOhAiIH
         RFFNSMho8hYpoghG4V7/jBNKmwMdfD/pAUd6/beHfqUAzeXHK74MwxVOZw7N0KttR727
         WKKHVksIPm6UXvKy5xRcZKtvMbDblP2sohsrxnowyek53JiHnIsQQAlrd9Bwl0yM/oQB
         y/of3jtaulNlaZMxRZqBzsIoUPXjPmeGiZ5fGRtVXw18eDknbQM1cASReB8d7VLQPdAH
         sCCSlYLx656ta/tDpgbhU4qcwqsGlEGpaR0lp8GuGPOS9H0jDEVoRdAyTI0/FxO0xNAv
         EjKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782731067; x=1783335867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b1hHHsDIbbNW2mvKYCvO+OggmhpHSR1woASylmKNhS0=;
        b=Mq3UzCKeQsjtx+5Jk3rci0QLLgWrUdyW8k/rFDoXOcYu/hNd+F4eEhsWjY3ypcVK5b
         ahoEubSCATrIQt2JgoJuDyPE2oGKQTeftUAn/u1ltGazC/rOllZqMa4dcb5OIhx/+Squ
         2y5HQ5xwmFD7Ufs/63AKzjwN86ITqFW7F+APePecwsjXt+3WCoLV1SJJl5UGJufdbT2W
         9VgsiHkUtDDAMFk7z572l+dD4EC2f4yyc1w+vG6HSQcyTIIdIEcfKkoma+xy98EHLIV0
         tRfHPiV/XWTUhWYR596FOtbZXXJwkIG2BxE2dPZ+9QNdr6rSQzp4M6IoNXiAxNLtWEKu
         RcuQ==
X-Gm-Message-State: AOJu0YyHWeQE8nvNNvxkNK6bRzCnnTgiQA9h2c5f+7u8E+sU0TY73XrK
	XP7Ous+bPezX4KIaV0wDH5nYMRF7FjXOZPZ6V1ciQyvakxVAeCj2JqJM
X-Gm-Gg: AfdE7cmvdmR4lMuiS8qxRpDGqbQsk0V8Mr882YA58QH+5YloyChjXdPYGdAKbzJVdXl
	cG2tr8law3AbP9HyV9WrsFmo5oAKo0IWGAaLy07lXNwn7HRbZnSoOvwp4r+yagFd8GhtcNnoDWv
	QQT1rIuHRzPEPNe6WAlw15NNTp85LjEz7RSnv1DoHwsDGNzhvN0lqG8CUQ2cNhgzep9aDzaAm+Y
	8Nf09Ma33FyeOkgXiOTbnSXIUVzojIkICyVHO5CslYrMgN3Q4XZs2k8Z3h7eA/U/16dh854/nMA
	RqOt8NUMeKi7RkhHY7X08Xe+pqfysjDPixNVonbLDH69vJTP/hrir8tc7vElEZcCtUtQ/k9prE+
	7QVCDkZ3Glt5gMopbEChWlOHFSzNUXi3O1UYk+DpTnfFlMDLWJSvNUKkjOzfeSTd6sZbg0wQVE3
	2+foAW/rvRGfTzp4vDKvI2XP3LUHs=
X-Received: by 2002:a05:6a00:12c1:b0:845:4142:b8b7 with SMTP id d2e1a72fcca58-845b3b714bemr15729492b3a.24.1782731067401;
        Mon, 29 Jun 2026 04:04:27 -0700 (PDT)
Received: from localhost.localdomain ([112.166.204.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845cdfac944sm5858964b3a.12.2026.06.29.04.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 04:04:26 -0700 (PDT)
From: Hojun Choi <ghwns6743@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Hojun Choi <ghwns6743@gmail.com>,
	syzbot+9c40ad7c6ed7165e46e8@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: Fix slab-use-after-free in l2cap_disconn_ind
Date: Mon, 29 Jun 2026 20:05:15 +0900
Message-ID: <20260629110515.29689-1-ghwns6743@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <6a043270.a00a0220.3890a0.0006.GAE@google.com>
References: <6a043270.a00a0220.3890a0.0006.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2cap_disconn_ind() runs from the hci_conn_timeout() worker without
hci_dev_lock, and reads conn->disc_reason via hcon->l2cap_data. It races
the teardown path: hci_conn_failed() frees the l2cap_conn via
hci_connect_cfm() -> l2cap_conn_del() and only afterwards drains the
worker via hci_conn_del(), so the worker can read disc_reason after the
l2cap_conn has been freed:

| BUG: KASAN: slab-use-after-free in l2cap_disconn_ind+0xd7/0xf0
| Read of size 1 at addr ffff88807ee53278 by task kworker/u9:1/4933
|  l2cap_disconn_ind net/bluetooth/l2cap_core.c:7430
|  hci_conn_timeout net/bluetooth/hci_conn.c:646

l2cap_conn_del() is always called under hci_dev_lock(), so hold it while
dereferencing hcon->l2cap_data and reading disc_reason. A blocking lock
cannot be used here: hci_conn_del() drains this worker with
disable_delayed_work_sync() while holding hci_dev_lock(), so the worker
would deadlock against the drain. Use a trylock; on contention return the
default HCI_ERROR_REMOTE_USER_TERM, the same reason the !conn path already
returns.

Fixes: 2950f21acb0f ("Bluetooth: Ask upper layers for HCI disconnect reason")
Reported-by: syzbot+9c40ad7c6ed7165e46e8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9c40ad7c6ed7165e46e8
Cc: <stable@vger.kernel.org>
Signed-off-by: Hojun Choi <ghwns6743@gmail.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/l2cap_core.c       | 24 ++++++++++++++++++++----
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index aa600fbf9a53..a5d82f9f3871 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1733,6 +1733,7 @@ static inline struct hci_dev *hci_dev_hold(struct hci_dev *d)
 }
 
 #define hci_dev_lock(d)		mutex_lock(&d->lock)
+#define hci_dev_trylock(d)	mutex_trylock(&d->lock)
 #define hci_dev_unlock(d)	mutex_unlock(&d->lock)
 
 #define to_hci_dev(d) container_of(d, struct hci_dev, dev)
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 1fbd52165fb2..1666601ebd1f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7498,13 +7498,29 @@ static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 
 int l2cap_disconn_ind(struct hci_conn *hcon)
 {
-	struct l2cap_conn *conn = hcon->l2cap_data;
+	struct hci_dev *hdev = hcon->hdev;
+	struct l2cap_conn *conn;
+	u8 reason = HCI_ERROR_REMOTE_USER_TERM;
 
 	BT_DBG("hcon %p", hcon);
 
-	if (!conn)
-		return HCI_ERROR_REMOTE_USER_TERM;
-	return conn->disc_reason;
+	/* l2cap_conn_del() is always called under hci_dev_lock(), so hold
+	 * it while dereferencing hcon->l2cap_data and reading disc_reason
+	 * to serialize against the free. trylock because hci_conn_del()
+	 * drains this worker with disable_delayed_work_sync() under
+	 * hci_dev_lock(), so a blocking lock here would deadlock against
+	 * that drain.
+	 */
+	if (!hci_dev_trylock(hdev))
+		return reason;
+
+	conn = hcon->l2cap_data;
+	if (conn)
+		reason = conn->disc_reason;
+
+	hci_dev_unlock(hdev);
+
+	return reason;
 }
 
 static void l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason)
-- 
2.54.0

