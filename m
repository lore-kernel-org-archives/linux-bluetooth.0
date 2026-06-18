Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AE03ED122
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 10:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781778124; cv=none; b=ZrGES/UZBR6md8WfKt6EY7Mh7x3Ivrx3ltM5M7lMXjD55q9TjTzgIowiANzQiStC5d0DkYOuD99LcoenHKTexquVTyTCsBbp1f5FAzh/RYMMiKN3edKcZMvtU/R2WqreWhaOEJHQBMEmMKJl7MHwYCPDt2ObsAtFNLaTRzCqASs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781778124; c=relaxed/simple;
	bh=GuRUxuyBM/jgJRuEQdC9cuuhV7C5V99Gc6YG2EEW9i4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KDj6NKhWeA9PbNKIYbS41wkNUsexg+coMAFp5/+sCL8nvp4SAQJ50jq6+waH8NZKxo6OsW8Qbc/8D20FtTwsSa+WTjFCyIgBte1eEAhxJZBmTSDe7agGd1A6chrrfQtJa2eUcgKWmbWng7B0KsyM7lQQqVRdM6psoZeHncEzMM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b78N3kH2; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b78N3kH2"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c6b3f71648so10075845ad.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 03:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781778115; x=1782382915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=12aw8L2LxvabE17+3w8O0vXmmi5lXIQ6VLJurOZaRHw=;
        b=b78N3kH20WaAMiXAzPP5ne92bj7hAko4BK3Wv/Rtq8KwF9fK1jMSaVgwTqxXkEMkNy
         Z80SL+SaseHm8QSzJvtwGk7bb9tyLcH/99RGsaHs+wDcNYl80zjcjWvgkhFUUZ3xKbap
         0qjty6uzAheb9kIjZkwatvFp4N0CXqN/h9Mh5EWSTUWKggu8vH5JwmRmOwIUuqdjlcRW
         sXQCdttJSjF2aCqO1uEkjQD4LOrjcS6nFrRl1Fm6Cngv8MDQ/pwXgzxg7GZ10y1D7SZD
         1oEWVwmmhwu2zMoFZVdbbLoRY8ftcThXRn4sqndfTnkGbllL5WrGeWOJBAg6q4zOCFYt
         z2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781778115; x=1782382915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12aw8L2LxvabE17+3w8O0vXmmi5lXIQ6VLJurOZaRHw=;
        b=EMN3nRafGGejsBML2fsD9NuQDbwx06eQ9lRxwD7AaO9nS6oK7gpWhRsR43tmWy/hG6
         5vKDJPspmxkAAoj2fIwOukw9/z1ikf2oc0zlHzRfCPFK+Uk62ikuWyijxfIq4IXuTL58
         ABTi8jkooPS4oqrgh2h1axovTC9QV2gcf8FmV1c2Ftl5/ptC00uu4JFLP07n4D8s4yPY
         86i03qlFbwdDBJLu1woK0CEZgx4Smtpw533UsWEpqicjK81w0PLJir90cD894RgnqLET
         ZTI3B5XqcWYQuU20vJsJHV3bodtQCdqDjvFVUvatcbg47TgbT7BiBozgQs/fqFjQ+t1w
         fDOw==
X-Gm-Message-State: AOJu0Yw5YFPE0S4ezQMd8rA4NzL7LD/qvOIMbI9YY86OB4zHQk6Tmk9Y
	OVl2nLN+C1yfSogXM6qxpPa0iQHfPDFOT+k8qUxJLNo/Yvg3IlFxwlqe
X-Gm-Gg: AfdE7ckjCswwLqPn7nQL+rAkXbgq2/lklYMnPdsX8+ILY9niak0UXEYrTZpVv1QKTh3
	hFZKF0Ik/8In5wuTCjW+RwBTYROuHNQaViEygWPFj3v2g3lI9RrJN3oN72kbh4VQZxjpp0lzcIV
	jOVH2W/znQp4pRXl8zEKCaD3TxqxwGxTKnfCQUb81kJnbjohOE8O+RbNr1CLe8HigQLOh4HbIrb
	NQXyr48eR1ak8w41d7vWz1YpHUTcC3PUUCkWnfZwYWPhUf17dvel5EWVHle7tGZ6GpO70Qknn5E
	BnFflTEi8+MnorkVF1XMEfX/ZZJ59PfrOOrGcNfsEFUnyiaZKMHizSizjj20z8X8EKdaCuPUqjz
	pQvEHQ+MZoLyuxl5r+0HNd6G8zlh/i73oBRgxCQS/eWrZ7SMb1nn4yFfK5hC/2a4C4aQWg9dkAs
	S9elDK978=
X-Received: by 2002:a17:903:2305:b0:2c2:15c7:ad77 with SMTP id d9443c01a7336-2c6bc277a05mr79625915ad.37.1781778115508;
        Thu, 18 Jun 2026 03:21:55 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6a1878426sm76398575ad.64.2026.06.18.03.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 03:21:55 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	baijiaju1990@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] Bluetooth: hci_debugfs: serialize force_bredr_smp writes
Date: Thu, 18 Jun 2026 18:21:50 +0800
Message-Id: <20260618102150.3340673-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

force_bredr_smp_write() calls smp_force_bredr() without hci_dev_lock().
That helper checks HCI_FORCE_BREDR_SMP, updates hdev->smp_bredr_data, and
then toggles the force flag.  Two same-value writers can therefore both
pass the -EALREADY gate and run the same enable or disable transition on
one hdev.

The buggy scenario involves two paths, with each column showing the order
within that path:

debugfs writer A:                         debugfs writer B:
  1. parse enable = false                   1. parse enable = false
  2. test HCI_FORCE_BREDR_SMP as set        2. test HCI_FORCE_BREDR_SMP as set
  3. read hdev->smp_bredr_data              3. read hdev->smp_bredr_data
  4. clear hdev->smp_bredr_data             4. clear hdev->smp_bredr_data
  5. call smp_del_chan(chan)                5. call smp_del_chan(chan)
  6. toggle HCI_FORCE_BREDR_SMP             6. toggle HCI_FORCE_BREDR_SMP

If writer B reaches step 3 after writer A has cleared
hdev->smp_bredr_data but before writer A toggles HCI_FORCE_BREDR_SMP,
writer B still passed the old flag check and can pass NULL into
smp_del_chan().  The double toggle can also leave the force flag
mismatched with the requested state.

Take hci_dev_lock() around smp_force_bredr() in the debugfs write path so
each request observes and applies one stable BR/EDR SMP transition.

Validation reproduced this kernel report:
KASAN null-ptr-deref in smp_del_chan+0x31/0x90
RIP: 0033:0x7faae680d340
RIP: 0010:smp_del_chan+0x31/0x90 [bluetooth]
Read of size 8
Call trace:
  dump_stack_lvl+0x66/0xa0
  kasan_report+0xe0/0x110
  smp_del_chan+0x31/0x90
  smp_force_bredr+0x69/0xc0
  trace_clock_x86_tsc+0x20/0x20
  srso_alias_return_thunk+0x5/0xfbef5
  lock_acquire+0xd0/0x300
  ksys_write+0xd2/0x170
  full_proxy_write+0x9e/0xd0
  vfs_write+0x1b0/0x810
  find_held_lock+0x2b/0x80
  do_user_addr_fault+0x65a/0x890
  rcu_is_watching+0x20/0x50
  do_syscall_64+0x115/0x6a0 (arch/x86/entry/syscall_64.c:87)
  entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 300acfdec916 ("Bluetooth: Introduce force_bredr_smp debugfs option for testing")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 net/bluetooth/hci_debugfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 99e2e9fc70e8..89cc93f5984e 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -524,7 +524,9 @@ static ssize_t force_bredr_smp_write(struct file *file,
 	if (err)
 		return err;
 
+	hci_dev_lock(hdev);
 	err = smp_force_bredr(hdev, enable);
+	hci_dev_unlock(hdev);
 	if (err)
 		return err;
 
-- 
2.43.0

