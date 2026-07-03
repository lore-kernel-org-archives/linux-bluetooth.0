Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A1236AB61
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 08:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783066480; cv=none; b=MXylBIRI7TtT0Q4r9uCzuuVXN4dX5SnbQHybIlxPp2yS3mjsWSZ8v73STSq9cqkvfeadHBPXvt02YAG2y0IAKrFclfCvidt7FtiSr/SKEsOChOE5luNFVt0jTbt6Z/8Y7ILBMcE6cslga36mAOqDRSG2SmRAhr1NtN854VR50aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783066480; c=relaxed/simple;
	bh=6bKqHtFO+DauaFpgFf5QuP93CfHPUt12Hi+cDPmEObk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=igXO+Y8+hYux4KkXfYukwjGLe21n+A060zyjRiPZTsfqQAQYi55WB+eCfJRk8+T5WZ3ReLQXYeoQYYfHFbLrQpOagXLMQ0vuXurpxiC8YQhZYPn38UyfPabFRMUOp7LnzlNtJxDKl9C+qJSYMu4C4P/jNub4S5q/2wVDpXPUN9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r5AqmDNd; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5AqmDNd"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cad8076b01so3178835ad.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 01:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783066479; x=1783671279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XrSItDvCvM2Gm9QmTR8V/Uvz6S0MhMAOvFdfQxVoEkg=;
        b=r5AqmDNd86/BDIAZp87f1RDi8Jz2OIjy7cQ/nRge3emkYhG6bKrmvDqThRKeQsytLg
         g64VKAPYWGiAfJrQIFBrbPZbyBcaDe3szjZO4ZSTp2kCrPKM4mfmWCZpQdmDsR/zg6Jc
         d/KbXOK5oUvX/aVWD3tmvgBDWgKJDR7BhFuBUcGaPz5yhu+ZmtTMblxlD6Xm+CTFzNnO
         7RE2n40ff5gu9no/7OTPbtl33QskkSxjtQOH1c/PZX/2KjR2Vt46RIhJ/gATIzu3vbLT
         8qXVAR65r4y9V5VWTs0c+gACfqJHiBHWhkQc1rsoqHYmxwo9UjrHXJfJuvXove38QjBo
         oSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783066479; x=1783671279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrSItDvCvM2Gm9QmTR8V/Uvz6S0MhMAOvFdfQxVoEkg=;
        b=O0LpeEHM4ofGZU18KnwG9aniGpVCqlJb9okAHG5lGHant8CKlaPvtvU44t+ZwEIMI+
         zQQMKiKzQg5nW/Am+cNURXZELD0dlyCxCSUIOyxKemRlWkXNED8Gl1a2o9Qlag6v/P8A
         oNIqLGBTsfWJS7VrBlN8d2bJo7sGAbOIO8eqAkXLwnLqGczHyM0HrwR0j0cDp72ALVEb
         ilMjx1wa88Y2fRHnE9TsdlphNaIMHzuy9rtN2NtrMPmvjA0kmBWJUL4MiDcCUvWiAfJV
         Ksrurh7NTMvSj2yjFJQ4Y927BrgmR5tYFOai8noeB8esAMWPBAfZKv0NZZR3oU63kQpX
         AaaA==
X-Gm-Message-State: AOJu0YzjFFcyCjd1WVQ9tTPo3r3zNowOuUqNWHx4XAUWht60myLvNV4b
	At7M3cQGhBmeqNY9fYWTDc0+KS2mjbmUrdDKUjdj6t2lOlQfIqy9G9r2
X-Gm-Gg: AfdE7clH3SIzxon3/2Ql0VqToxzzvJwoki2cReKSSPkNA8WxJu5lK0nwx21twThUh1U
	P/YX2W0Q32t9kELSFhOxDyh20Nq6IOCner+OMWTRVavevSXoVVW4BAYY3uSLaPO7OPkIDwWcdyh
	+3RO9vwb91gfAbtOl9yEeOSUEhqaCS99SntavO0aCKLi3b1N0DRN/k11QZJL5gH+Icvv2yR9jvM
	N5D/DBhgc0krHW2aHBj1cNCX8nitEIBI6fguzNSAF4W/iaHdT6FQ66LSdPx+JKI4LGuEWU7HzhO
	dPC8tkidVa3tAOn/ALqCB8fGDPgPqFMNIQpVasgKp+g+cXiiIAox0jUdO0jsrt1o/1El4wo1CK1
	G/et1RfZey6o+1osJLwZeafemG2cM/4UfTptiRfomP5AynCNh91UsvQO22GH1MeNF8jdSH90+fI
	3uDVStPqA=
X-Received: by 2002:a17:902:cf09:b0:2ca:7131:cace with SMTP id d9443c01a7336-2ca7e7551c8mr94523345ad.31.1783066478408;
        Fri, 03 Jul 2026 01:14:38 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad7765810sm5636455ad.53.2026.07.03.01.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 01:14:38 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	baijiaju1990@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v2] Bluetooth: hci_debugfs: serialize force_bredr_smp writes
Date: Fri,  3 Jul 2026 16:14:31 +0800
Message-Id: <20260703081431.922054-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

force_bredr_smp_write() calls smp_force_bredr() without hci_dev_lock().
That helper checks HCI_FORCE_BREDR_SMP, updates hdev->smp_bredr_data,
and then toggles the force flag.

Two same-value writers can both pass the state check and run the same
enable or disable transition on one hdev. On the disable side, one writer
can clear hdev->smp_bredr_data while the other still observes the old
force flag and later passes NULL into smp_del_chan(). The double
transition can also leave the force flag out of sync with the requested
state.

Take hci_dev_lock() around smp_force_bredr() in the debugfs write path so
each request observes and applies one stable BR/EDR SMP transition.

Validation reproduced this kernel report:

  KASAN null-ptr-deref in smp_del_chan+0x31/0x90
  RIP: 0033:0x7faae680d340
  RIP: 0010:smp_del_chan+0x31/0x90 [bluetooth]
  Read of size 8
  Call Trace:
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
v2:
- Reword commit message to avoid checkpatch's 75-character line warning.

 net/bluetooth/hci_debugfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index b7f682922a16..ff344564c923 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -520,7 +520,9 @@ static ssize_t force_bredr_smp_write(struct file *file,
 	if (err)
 		return err;
 
+	hci_dev_lock(hdev);
 	err = smp_force_bredr(hdev, enable);
+	hci_dev_unlock(hdev);
 	if (err)
 		return err;
 
-- 
2.43.0
