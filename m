Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5508F1C84C7
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Aug 2025 19:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756495278; cv=none; b=VocEzQZukL/1FVQNFXh+sDyuBPkXGhQw8PclTm+v7me0J+ikH1NI1MaEsxJeTQFBGZEwlEQKRpZsBZmgflYc1te3dfN0Q19POUQ+MvlAA1uTpEVFurdUwel7fRYSZ1E03FWJVOLtJqJVeLhdoU0N6nvFJLJsykVXGSB1geg+HLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756495278; c=relaxed/simple;
	bh=np3FSwEne3iK9y37+WLh0cvnBU3hKNqGhT7s4PwGT2k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dOIlI7kUr6iActcst/8p5EwthB29xJ3KDniLS2OSVLky8Oam4LZ5PMEF17Bv7wuxIdNM5t/Ol2ur1P3QI9p3+jJFB/hkgzjUGnu71pUdwRcjmbJC6IzxP0035UjmHpia/i4oxPhv2hU8H4v3ZvKxi2ope1uJk+2f37NtH5uDqRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PR37wwPc; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PR37wwPc"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-543d38bcd94so1024755e0c.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Aug 2025 12:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756495274; x=1757100074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=R+zLCuynYQBBT3ZiuH/lS8/9X/ez2GelsfBbDswjauE=;
        b=PR37wwPcEbcmr3sRIJVlsQSBPrmMmSwIxyUqrMZcpMxqYhwXwa8svJoN16MtlmXyyI
         wdI+7WKisNXyFSi5ObLZEIMBHAtueLwEmNm3cd72I2h42JykTHPl+zFNWzojA5CgmaZU
         KWbgqjyFkHAYjtqE9RvE/4LHP5lwnLYVQ3jhRulwWgw9feFt7iRlr5hS18xUVACcoHeJ
         K3n3UkXgr1CkHDEPxaTZK5hSIu3tm83qrQDVub9viI+LhKN+mJVNVAJEFjdhm+hl9HM/
         EHdpQ4fPnRKAAfDuxuKwv0tEuwcHcujGJBKgCJ4WuI62PnT5hg/kJVjYvU8y9R3EZgpI
         K6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756495274; x=1757100074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+zLCuynYQBBT3ZiuH/lS8/9X/ez2GelsfBbDswjauE=;
        b=vfeXK+M+AZRVoAft9sQf6pg2nKy6N0yxiR/8reuB8KIhF7EXtCeQDrVlTVb1l3/Kyr
         iKhstBIbcVRYuxXDlKl8ihiu+3D1r49fQeQsrIaOLL9Qb0DnPopVjUmdNy2o+qWD1oso
         V+wMLuXrquEidRR71d2QSbvNGSNaXUnaaP6Kj4WfDYq0sCXTyLt2iGMmNtTtPbeWsqiU
         fmkhHEm+spUu0/hQmWtZeU+25JeInq/7ejBQAlT5NiKdPha0imeqWfg9omytjvDlabCN
         RixHJ1j4MdzShCUMcTWia4zvkkb7g/ANLIjkChJRUcqDVucbKbCXNj6fgcFH73X7sm4D
         R/Dw==
X-Gm-Message-State: AOJu0YyAx1Jx6gUkNkcgn5CP6s/iJE/lX/M8x/W8Rh53zeU3txII2eMt
	FzNyevd4QQRvK5I/B4abymSUkISaQbh8rNUK4ilaHzVPio6dlFiTwgkdViVYBXne
X-Gm-Gg: ASbGncvqOdPmhseZdB2TbkWjDqIb8XbVBsudPzoMTqktw8ks9eDpLxCFmZz2kWZa2Mg
	UmEIBeoXIaxAMHaQMdpLjaFOaeC4EaLiwXjJgt3HZdMhw85zkDkW3PP3ICrAm2tKLFPGuFt8NZj
	Vqfx8F2G9c7jKVV912Rh8lyl10bCBujmuzfH8qBNB0ZoGBe0z0un6PmtPyxb369KcqOotITMHxr
	e9982XzHDBCzS/QatO9PU6r/WYgScwallc7vVZz8pH8DUj0XRPMAXWcBSY7he4ltmZpjzUAROp3
	bHPm6s9QHwyom/HBhz1APG+D4gxh8e127dxoJTqsODv45HL7W3sPKQxqVulJyd9wLADgw2ZSMqQ
	9arDDiLeumcKFPVi8fKAJyg7Cnt6aMeX4imGuDiWZVQdJqLcCdOETBqaihICtI7SkOaDZPyRHa8
	gBeb3GFCTLTDNnehvzkIuDaA6+QfQG
X-Google-Smtp-Source: AGHT+IFO9fZ00HJlttWDvIqjBZYyDuYaXwYRqrFrR4fQ+zP2Toe35NDUs9j7w5ixoXAfVGuqqYQ+Sg==
X-Received: by 2002:a05:6122:1d42:b0:544:75d1:15ba with SMTP id 71dfb90a1353d-54475d1183bmr3487401e0c.8.1756495274441;
        Fri, 29 Aug 2025 12:21:14 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-544912c6d3bsm1417526e0c.6.2025.08.29.12.21.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 12:21:13 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 1/3] Bluetooth: MGMT: Fix possible deadlock in mgmt_remove_adv_monitor_complete
Date: Fri, 29 Aug 2025 15:21:02 -0400
Message-ID: <20250829192104.2010557-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following deadlock:

--------------------------------------------
syz.4.423/7568 is trying to acquire lock:
ffff888068c48078 (&hdev->lock){+.+.}-{4:4}, at: mgmt_remove_adv_monitor_complete+0x9e/0x2e0 net/bluetooth/mgmt.c:5524

but task is already holding lock:
ffff888068c48078 (&hdev->lock){+.+.}-{4:4}, at: hci_dev_close_sync+0x3ab/0x11a0 net/bluetooth/hci_sync.c:5200

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&hdev->lock);
  lock(&hdev->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by syz.4.423/7568:
 #0: ffff888068c48d80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_dev_do_close+0x26/0x90 net/bluetooth/hci_core.c:480
 #1: ffff888068c48078 (&hdev->lock){+.+.}-{4:4}, at: hci_dev_close_sync+0x3ab/0x11a0 net/bluetooth/hci_sync.c:5200
 #2: ffff888068c48690 (&hdev->cmd_sync_work_lock){+.+.}-{4:4}, at: hci_cmd_sync_dequeue+0x50/0x1f0 net/bluetooth/hci_sync.c:887

Fixes: Fixes: b747a83690c8 ("Bluetooth: hci_sync: Refactor add Adv Monitor")
Closes: https://syzkaller.appspot.com/bug?extid=e8651419c44dbc2b8768
Reported-by: syzbot+e8651419c44dbc2b8768@syzkaller.appspotmail.com
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 989321b1ea27..9c1ee6ae7c66 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5189,6 +5189,14 @@ static void mgmt_add_adv_patterns_monitor_complete(struct hci_dev *hdev,
 	struct mgmt_pending_cmd *cmd = data;
 	struct adv_monitor *monitor = cmd->user_data;
 
+	/* This is likely the result of hdev being closed and mgmt_index_removed
+	 * is attempting to clean up any pending command so
+	 * hci_adv_monitors_clear is about to be called which will take care of
+	 * freeing the adv_monitor instances.
+	 */
+	if (status == -ECANCELED)
+		return;
+
 	hci_dev_lock(hdev);
 
 	rp.monitor_handle = cpu_to_le16(monitor->handle);
-- 
2.50.1

