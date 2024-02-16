Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0AC2D603
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 20:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708116613; cv=none; b=Jsxv6QwxL5e1qr4AglSKEfV+CZOgPPIJhptF8+wTDkWPMEFNKqCexzGH/E5gcMjC8Sh65DL2ZgcFj4hoRn+3OqNQENfoAJfJ2yEM4gCr8JhOMi1wG4hhV76R2DmZDed0KUsvKISSNmSZ6u9+urAcMNbWrql+hJDVeukU1fL3no8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708116613; c=relaxed/simple;
	bh=RfQt5AoJl3Zz+dm7YvMXhsNwC3cMYxKFFIjqjTrhhzY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tW4qDgUQjV1UqEfC+vxikOaGvdVnAj53srAGqSsyRU0wZsnpWzEHFyc8umUD16y2aXdwUAk4NRuRjsCApk6O+wmzl7WNoJsnMQ0oegPOnYWDea3jiRdFMDGW983IJY3bRAQrdDlmJmqSubIWMlW1GOfg0l6XDzIsJqLt/tPvpPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHyHgsVJ; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHyHgsVJ"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7d2a67daa25so1359221241.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 12:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708116609; x=1708721409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DbvPwMWXHxIoAutYoi9BmYEjc1HecrPVP1v//BsFqIo=;
        b=PHyHgsVJYi6qIAOb1bYDwuLf6mAL0JCHA/HC5fv+bE70tiyyoMBqNqaKczfbq55Ylq
         XydQ9Y0hN7rHFwk4W1nJjdSfTda6FdCGZzMt4MlZvElmIZ88tgcNrGETTKoDfhze85wX
         A0cXCvrYuNDcLIpqmBTUrgGQUKP+kwlVlJGUNnlBTrLbgRWk1KTE8MgYZCjI4r8yjD5D
         oZV8g/2sr7j4+CNaAMBA7T242yI8VAqkRQdqKtsdSiDZQ5pR6VIfTsSZpJgl5AdhQddz
         XcpVQc4QSfuM9eTF+1Nq3kZ55FbPn7pM1mOlEaeC3R6abl2ya5KB67gNR/yrJa8UG8+n
         igkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708116609; x=1708721409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DbvPwMWXHxIoAutYoi9BmYEjc1HecrPVP1v//BsFqIo=;
        b=FbTYZC+rsfh56dKADq0KkcU1SkurFc4XQkxdWq3gaZVJ95yZaBrD182h1Fe5E60SMF
         Q1DODbkSHh+TiFIt3e/oKyq4L4BOX54VAJ4C9dggxZm3tFX5vC+UUJOiDSVXhubN83IE
         FDV08uZ/uYdkZENuORDngKINZ7qts/huVUanNwWk084fowvtnweLrEjuYPPZCOa5fi3D
         QK/46XJRMHG58Icq+rlgP6ymu5fVqTKDzpqu6rocY8zirQwiSAdXtEIaWQlUbL7SM4gr
         LanWh9e2mfSJrKxpAyTqKQHYFB1guEEDI+ncwGizSkO2eb2N7VbPQ3j/LW/es4Gpejb5
         U+mw==
X-Gm-Message-State: AOJu0YzKb1TeP+WYzmwYEPoSTjtsa1s9f2Paiu9x9Y8AsUTPSft5trk8
	duwWd/XCIasJKssz6Ek9loG6y5mgKG4Jsep2wo5ZYh0SqaHp2xzT8a3pFegH
X-Google-Smtp-Source: AGHT+IFPv39lR3IqP9wjjs8SO/mc9KLepVmK3YBVe/FGNtWH4Pn8opWYmeH8+uDBWNj8Po2TDZL8dg==
X-Received: by 2002:a67:e94e:0:b0:46e:e845:3bdd with SMTP id p14-20020a67e94e000000b0046ee8453bddmr6210082vso.8.1708116608492;
        Fri, 16 Feb 2024 12:50:08 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id v16-20020a67ff90000000b0046d486b547fsm92274vsq.31.2024.02.16.12.50.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:50:07 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync
Date: Fri, 16 Feb 2024 15:50:05 -0500
Message-ID: <20240216205005.111967-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Fixes the following trace where hci_acl_create_conn_sync attempts to
call hci_abort_conn_sync after timeout:

BUG: KASAN: slab-use-after-free in hci_abort_conn_sync
(net/bluetooth/hci_sync.c:5439)
Read of size 2 at addr ffff88800322c032 by task kworker/u3:2/36

Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38
04/01/2014
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
<TASK>
dump_stack_lvl (./arch/x86/include/asm/irqflags.h:26
./arch/x86/include/asm/irqflags.h:67 ./arch/x86/include/asm/irqflags.h:127
lib/dump_stack.c:107)
print_report (mm/kasan/report.c:378 mm/kasan/report.c:488)
? preempt_count_sub (kernel/sched/core.c:5889)
? __virt_addr_valid (./arch/x86/include/asm/preempt.h:103 (discriminator 1)
./include/linux/rcupdate.h:865 (discriminator 1)
./include/linux/mmzone.h:2026 (discriminator 1)
arch/x86/mm/physaddr.c:65 (discriminator 1))
? hci_abort_conn_sync (net/bluetooth/hci_sync.c:5439)
kasan_report (mm/kasan/report.c:603)
? hci_abort_conn_sync (net/bluetooth/hci_sync.c:5439)
hci_abort_conn_sync (net/bluetooth/hci_sync.c:5439)
? __pfx_hci_abort_conn_sync (net/bluetooth/hci_sync.c:5433)
hci_acl_create_conn_sync (net/bluetooth/hci_sync.c:6681)

Fixes: 456561ba8e49 ("Bluetooth: hci_conn: Only do ACL connections sequentially")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index b7d8e99e2a30..4a28aef2f01f 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6670,15 +6670,10 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 	else
 		cp.role_switch = 0x00;
 
-	err = __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN,
-				       sizeof(cp), &cp,
-				       HCI_EV_CONN_COMPLETE,
-				       conn->conn_timeout, NULL);
-
-	if (err == -ETIMEDOUT)
-		hci_abort_conn_sync(hdev, conn, HCI_ERROR_LOCAL_HOST_TERM);
-
-	return err;
+	return __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN,
+					sizeof(cp), &cp,
+					HCI_EV_CONN_COMPLETE,
+					conn->conn_timeout, NULL);
 }
 
 int hci_connect_acl_sync(struct hci_dev *hdev, struct hci_conn *conn)
-- 
2.43.0

