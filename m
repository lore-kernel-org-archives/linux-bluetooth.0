Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795262489;
	b=uQeChBGjPHrmBPwDnemXI7AjrBx8wAy6+E7hBPTeLDp8AC9psiteU9MAIZcHI/qqnzdW
	 P00ejqYOusDRJ+fOdItY0Ph3fv1plP3L9RG2koWN3HRFvczdy8yO8AbapJ7eQOyUmLUAX
	 fI3SwyCL669hB9urfeXq+yGLVLkmv2590iWdQTc51cfMRzjp7OHU3WUCGXZ7oMOb/BAnQ
	 pOceW2RhJbSmM4bghjvMAHcF/K5KZam4DWRRC0D51gWIfI+4e+ERW8kIs1nIFYu4XIpss
	 2hING7ZdldpbG5m800u5JbOfPilzrtDONYd3eR8UQExU+qiNtU/okxkaCGemeuHpBQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795262489;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Ci3P64xa38O00hMX/k7f2bmsUDxwfYwySYQ2yHWRji0=;
	b=jf24Xkou+nvo/1FjrNX4bejcaQZdEiYEhVbkGpzcGp/X0Api4AWlZmyPa1Q2qIpW3TvO
	 WGslPVqxxjTJumQayqugnSUr5ECrdV3M5CdPW0hMiJWf4ABKVOL7xf4pKFH8iMRtmQOWK
	 r2XMCGmDvnqpvmDF44G280VDsab0MvmvYtwZhDAjKJRct2cqHxavV43elUtFSU38EHomS
	 YKnP8VEZnEtuHZhb8ThvhYg+x6UyJJl4HRZprAM2xsOLxVY4juRx91l2KsiYgnt+LhQNh
	 6qzS5yBNDZQbu5I8a7PR9nkOHTPBlJUUJ0lMn35Mbl5OWmSkd6/89LvMX0TywspmGRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W4uGXw7W;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D91606A32A
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 12:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09D91606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W4uGXw7W
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b439e37813so667165a91.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 04:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795262487; x=1795867287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ci3P64xa38O00hMX/k7f2bmsUDxwfYwySYQ2yHWRji0=;
        b=W4uGXw7WjyTLVvD7OZJuIB2YeKLFjPrWw5X+YKHFSrHJQjc/OMA9EWQwAJb2IW86Wm
         P4Vhx2n/cGvLhIBQm9AdWD44IYWujl/6iuHlWKVdESoMhDIXeE45gpRsFkn8zbEdJQWe
         4/rKwPdmu/wkojfZgKv/UWNjZ8WY8cbq+1tANxLRm9PK1tPxmX09SLHRZ5evQ+hmEsz3
         uGTURAfyV+8c8hWFP8OzsB497zq7AlLSgfeAfrFlTLloAyW5mXHdmJOrlHCBjru9gVAx
         684/gd/33kLxJW338CCnEFqLkJ7rg9COazFu+3zgT7CIU2Rsk9F7kqR4nHg7ZxtaasGz
         SU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795262487; x=1795867287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ci3P64xa38O00hMX/k7f2bmsUDxwfYwySYQ2yHWRji0=;
        b=2Vd+peabk0o49N7aS5g3mLo95pKnC3xMwQMkWHHtzfioiiGKP3EGuJoPBwlCVgAUwo
         ZkE+P9u25hARXSZtRp+nHch9Gf5Rr79M4bz+0kaRhUnMtrfDXVZf6erQWuMNAv2uaTNq
         7HaefwFdkIJygP7lPg07NsUX+tJHf1uiDREUeNfz7qwdLC/OlJZZv3Pn9dtm2SfNnLsX
         7e41hQt1/tKSM4do3IufxF6cxxugO5DimXKEB5wV+qyCq4RCiBLa3GMFI0mQlPs0skUF
         Wdk/ZUk56qUv9/FfKEg3oxmqwo1saN2XxGd07HJYB4Q9+UlfguQbrdwMzC5Uf8M8H7AG
         r9zg==
X-Gm-Message-State: APuU4Z/h0vI0MmBFfZiEuG0bR09aV+eyUeN68cqaUJgRhqgO/XpJRGA1
	esoNBdKtGaFKpHquPghKkUGMdE96s+/mqG7rZfYEUNZKoYn65WOlrFnUCdlp3vlM
X-Gm-Gg: AZFdTZdECmMtYsacu6n+DdqYkGAs/xcuTUoI4oV0y9alFDlcHqJEFB60CQ0oOTsr3Vh
	fxny/dsiZG5BiYvF7JuSZDsxy3sKYvZl7Omd9Wq0RiR5rKMMDmFd1UQl4k4MKpgV+N4Zp0J9TXX
	vma0XVGp3FTspaRFaJLsxBYmoHu3YPZtWSR2fAtePknU2qZ82NgnjvbvLubkRFNGl3TxoE4Qb8g
	HV0Hu8+dwyjGnhTw7yW8wQkcJbL9ZsjCrb+yXRwObaQQZnMD4kEDqUvetvQv3v3wVmevSbXTGOL
	0WM2EfO9cG+C/imBTgatgCDqwb4Q13Yy2nOttOYWHbOFZyhlkFd8ntfrxRHyZprewdwVaLhqAgJ
	+WsAOUweLEk/5VMMp+r2LPbn8Ws7g9vsgvhzDzhHrciozie7A183i9wAKR8706jF7k8D0xmVfOK
	9qOtPrmn45KT/udcJkdKifv9VgkR3ekZLNShvRJn4lgnoIT/N2VOzSHM8dfVoMTqHRE3LqHb3BZ
	tuhua8QVZ3IsKevgw6TF5Ks9JNDj83MECPXF8fyD92huy5Q6yHxUHNSk2y+9xAZ+MqI4ravVsKS
	JiTBkz7pVj9L6S4JxFyg1iHwHvDBHHkll1mP43Qna8nE9Isr67/oBw==
X-Received: by 2002:a17:90b:4b:b0:3b4:1265:740b with SMTP id 98e67ed59e1d1-3b41c9cf6efmr4903980a91.28.1795262487338;
        Sat, 21 Nov 2026 04:01:27 -0800 (PST)
Received: from DESKTOP-UCPRL76.localdomain ([113.200.174.114])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b8733e6sm1573965a91.3.2026.11.21.04.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 04:01:26 -0800 (PST)
From: Zheng Shuhao <viennaoffh@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: invoke destroy callbacks outside lock
Date: Sat, 21 Nov 2026 20:01:20 +0800
Message-ID: <20261121120121.576-1-viennaoffh@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_cmd_sync_clear() cancels queued command-sync entries while holding
cmd_sync_work_lock. Cancellation invokes entry->destroy(), and
add_ext_adv_params_complete() takes hdev->lock. In the opposite direction,
le_conn_complete_evt() holds hdev->lock while hci_update_passive_scan()
queues work and acquires cmd_sync_work_lock. This creates the circular
locking dependency reported by lockdep during controller teardown.

Detach the queued entries to a local list under cmd_sync_work_lock, then
run the cancellation callbacks after releasing the mutex. This keeps
queue updates serialized without invoking callbacks under the mutex.

Testing:
- Lockdep-enabled QEMU baseline: reproducer completed twice and emitted
  the circular-locking warning once.
- Patched QEMU kernel: reproducer completed five times with no such
  warning.
- Bluetooth ECDH and SMP self-tests passed in both kernels.
- Both kernels built; baseline build logged a timestamp clock-skew
  warning. checkpatch.pl --strict reported no errors or warnings.

Fixes: 1c66bee492a5 ("Bluetooth: Fix race condition in hci_cmd_sync_clear")
Reported-by: syzbot+fc55a609cd9deea4ea37@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=fc55a609cd9deea4ea37
Signed-off-by: Zheng Shuhao <viennaoffh@gmail.com>

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index ea2014e74..65b8aa4ad 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -683,6 +683,7 @@ static void _hci_cmd_sync_cancel_entry(struct hci_dev *hdev,
 
 void hci_cmd_sync_clear(struct hci_dev *hdev)
 {
+	LIST_HEAD(cancel_list);
 	struct hci_cmd_sync_work_entry *entry, *tmp;
 
 	/* cmd_work is disabled, the pending request can only time out */
@@ -690,10 +691,13 @@ void hci_cmd_sync_clear(struct hci_dev *hdev)
 	cancel_work_sync(&hdev->cmd_sync_work);
 	cancel_work_sync(&hdev->reenable_adv_work);
 
+	/* Run destroy callbacks without holding cmd_sync_work_lock. */
 	mutex_lock(&hdev->cmd_sync_work_lock);
-	list_for_each_entry_safe(entry, tmp, &hdev->cmd_sync_work_list, list)
-		_hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
+	list_splice_init(&hdev->cmd_sync_work_list, &cancel_list);
 	mutex_unlock(&hdev->cmd_sync_work_lock);
+
+	list_for_each_entry_safe(entry, tmp, &cancel_list, list)
+		_hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
 }
 
 void hci_cmd_sync_cancel(struct hci_dev *hdev, int err)
