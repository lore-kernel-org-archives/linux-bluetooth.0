Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ABA2248AF
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Feb 2026 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771074429; cv=none; b=AYA5QkW64jZkJ/4Ihx+xzLjDY48Nf6YqUyJ6Id0QQU+0GzdRxAgAoMXVdSDB3ta2z55eJLqqaV4HRScBn5o5binHlmpAA5tvj7Zd7Xr+TlQ4FL68HrAX+gsDGmqByF3GjdNTE/o34CMJi+Y7Krcy5pJejnUag/d2gDpbAxia2hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771074429; c=relaxed/simple;
	bh=oFjwAFBbpEqkWb7J9rjxfaX2HDa2WcOxalZpGcADY7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WPbrM+cE70p5cmn+ouczyu40VeOnZ9QldBhXXtKY/BNS47D10BRFA5xSA5+9GdJZSEqK5lEteN4R6rnt4DjS8AD1rg0pcRprdO6nJT3xeoNM32ga99tZvc9f26SS1IzhjK/K+TzQ8AkxV4CQunTXwqtMGEYFisuGjuJP10zmDW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+aLND/e; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+aLND/e"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-124a635476fso2179664c88.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Feb 2026 05:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771074427; x=1771679227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/pWQnDuja70dnDBF3+5g2m3Cq8SMK2BPpVuO+rxHDm8=;
        b=k+aLND/eDgoJILFU1aDhhyEyoc4t6EOiKF2rTJMeCG+vPd1TLu+JAmibehjBrBwaEv
         Ss9r73qfhes/68FXgfNo4iq+6IpatBs1uzQVuRVEoKepL4gquxwy/Sb8IpQnddXvjiGt
         ovBbkJkhS1YiR7oqnA285im19lpvQXEXmKYOq1DWu5Kz3RmNfA2/XsFKui7Lmp63UZQu
         2eCfORabFC1xBKHhEuQ/h3LccEwN66VUBfsCtwY8TXDfkL2wCEjHYdpxYvCRbz3neELb
         BxVNwwvNHf+5Fk2Q94aiD0u2lDuQ6aUQPPWxqYjd1JRbTZpiUzeUrKMOuzuSnWABJuCB
         fPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771074427; x=1771679227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pWQnDuja70dnDBF3+5g2m3Cq8SMK2BPpVuO+rxHDm8=;
        b=iyarwEpuQClSEOv0H9o7tpsUuqlKk76n5rIa33y7tegev0bmPWHP9b+pe+ph76ieHS
         IPva2q6unB1bRtbdDLuplAhmVTpaugaOqSmMf5oeLWm/Fjk9MwhhEhFWsKB/zpF9bAWl
         u/eUBJ+lKOIcKQd9gSkgpDad6vQy+oGNB/oyA5Dzi/I3lHiLnFIf5ZwcrUN20xQ7AdRL
         gwjAMtHPOLdHYHblRjbtmXjsUSjqt9a7u4y+6ArqZdHquQHqVe185GTSulxjGEv6QpuE
         TQhOiNIf5zl9Kpol4ze0fnEvNZk18zh8D78tefdG5gIs6OkWSE9KK7ReuJs5zooH8mgl
         ZVlA==
X-Gm-Message-State: AOJu0Yzaz8KSyFEFtrCIn6PHdkumKQG/5liQT8f4N6SSgFkB85vfFMTJ
	/fiOyKo0LizgM2Dl/Om6zvpbY7U3rY+sjHUrDYuBI4D2/a4UE+aM+bJivF479QFy
X-Gm-Gg: AZuq6aK2uoThTJS9s4MxvPAShmYbxQAKpnMGQRT/U0j+3//R62SHv7E9xjje79szaes
	EDnoRYy6OS58ovSuncoJw99rPRHSQDSPnjxVGEKmbZVgXgGFOmlfyY3vVxq/nm3d867jBFACa3W
	QLEaAW8fUSANf0SraP6xcvdWVP9PvD7YPEldManMeYsOcjUyIGRu13dIjBjBxUzYPeQA6JgIawI
	enejuLBT0h82UJ1HgQy7IMpdv9xolgK4ZFPJ5XaHt93NhWvzj8IeWXp8ZUO5p+RO7GdvjIV9euV
	mNlUwYXAj4Ps+ScGzD7AjU/yjapNx+NfiTgO5wFs/yjdU9z+KmILQeP8OauSqUBi0kJa6BWBHcy
	LxV/mjCcZmitkZZ4O9QtWNy2zT/QfR5mVWIbHug5X18tIkmXtqC0HEfYTtboQwTRruIOsfL/6S1
	bMTNVdPRPwlwDo7rBR6ksl4GnlDP4G5fdYzkvQDEJrjAf/BdfHkjJZcLs3JqfsfqwtGhYv6Wx9T
	KUiQg64mDng171PA+VHAlSeAg==
X-Received: by 2002:a05:7022:4189:b0:11c:ec20:ea1f with SMTP id a92af1059eb24-1273ae40123mr2155474c88.33.1771074427199;
        Sat, 14 Feb 2026 05:07:07 -0800 (PST)
Received: from kernel.. ([45.232.185.208])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742c6430asm2170362c88.6.2026.02.14.05.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 05:07:06 -0800 (PST)
From: Maiquel Paiva <maiquelpaiva@gmail.com>
To: linux-bluetooth@vger.kernel.org,
	luiz.dentz@gmail.com,
	gregkh@linuxfoundation.org,
	marcel@holtmann.org
Cc: stable@vger.kernel.org,
	Maiquel Paiva <maiquelpaiva@gmail.com>
Subject: [PATCH v9] Bluetooth: mgmt: Fix race condition in mesh handling
Date: Sat, 14 Feb 2026 13:06:10 +0000
Message-ID: <20260214130610.68236-1-maiquelpaiva@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch addresses race conditions in mesh handling within mgmt_util.c.

The functions mgmt_mesh_add and mgmt_mesh_find modify or traverse the
mesh_pending list without locking. This patch uses guard(mutex) with
the existing mgmt_pending_lock to protect the critical sections, as
suggested by maintainers in previous reviews.

Note: The heap buffer overflow fix previously included in earlier
versions of this patch series has already been merged upstream.

Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Cc: stable@vger.kernel.org
Signed-off-by: Maiquel Paiva <maiquelpaiva@gmail.com>
---
 net/bluetooth/mgmt_util.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
index 6ccc3a3f68de..eee4bc05f6e5 100644
--- a/net/bluetooth/mgmt_util.c
+++ b/net/bluetooth/mgmt_util.c
@@ -397,8 +397,7 @@ struct mgmt_mesh_tx *mgmt_mesh_find(struct hci_dev *hdev, u8 handle)
 {
 	struct mgmt_mesh_tx *mesh_tx;
 
-	if (list_empty(&hdev->mesh_pending))
-		return NULL;
+	guard(mutex)(&hdev->mgmt_pending_lock);
 
 	list_for_each_entry(mesh_tx, &hdev->mesh_pending, list) {
 		if (mesh_tx->handle == handle)
@@ -420,6 +419,8 @@ struct mgmt_mesh_tx *mgmt_mesh_add(struct sock *sk, struct hci_dev *hdev,
 	if (!mesh_tx)
 		return NULL;
 
+	guard(mutex)(&hdev->mgmt_pending_lock);
+
 	hdev->mesh_send_ref++;
 	if (!hdev->mesh_send_ref)
 		hdev->mesh_send_ref++;
-- 
2.43.0

