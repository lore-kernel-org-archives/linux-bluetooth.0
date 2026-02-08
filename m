Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E67622339
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Feb 2026 08:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770538630; cv=none; b=JgTU+QIgYfOM6zoBht/t1GdV10bSykExAcTEQO2v/Fid/HTeGY7hXmoEpbyoFvKXKB8KtK+4TFJlouk/NjtJwzd/J3bJOyoCKNDgKD/xblKWYv+oCuCFBsHhpZwKRqA+++hcB9GTrlz4end9Dq1anXTaZPtDd516RcasM3jlV4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770538630; c=relaxed/simple;
	bh=96xld+DCWspLDg17ZejKbFvZZbmlOGwLmt7mdx2FSlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HeHlUatPH3CzI0JM/gy1Bvdf0rt+5/hU2IoEJifSCQFcfxEPPwgCvWtEpK1Uiy2v4kB2fRCGpgms9cl22GH4dmlISvgtA3fJAPS0HuzeXGcj0TmW6kwj/xTeh2gDZjMxtAu1tXXzEcyZevjO7eKzPDbs6SrzdZatqAUh0r8fnpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T57tyYaP; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T57tyYaP"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64ad46a44easo1335347d50.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 08 Feb 2026 00:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770538629; x=1771143429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cw03+oSynXoyvfX4mJDGrIXnO7wDDDQdFtNcgwK8ukE=;
        b=T57tyYaPOAiHwo+2d1WnorEQNTkDD3AzXm1kLFYt+MfJgz8QCHHzLqc/J5OBi+ANUh
         Qb7TJZlcSVXEMvNk0jb482EhkDZwABrljIDp/OCHZxNGnC//duLR9xOvbf472YrcEe0f
         Dg79Qv0zJVhhlPDCJduC9rnaJPx4vk7p4zHGCcQWd8DNb8yOLa8EprxdGIfLdehuFaq7
         uNVgJgzzhPPCPkx+NhP9VsBR0CKHwqbK3BERkhpRHuXiUC0MGAPOBauXPVm9fviBK41m
         k+8RaeUjdruW27IDMl1/jb6wfXury7C0OnoThbcoYzkNbZ0s0XOzQGLEH4R7cxgq4vvs
         46Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770538629; x=1771143429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cw03+oSynXoyvfX4mJDGrIXnO7wDDDQdFtNcgwK8ukE=;
        b=K3UsbqqaHVAMXjst4NMhP/rx++j8m6mc1105c7cG+RKXyJF7zP3bBeXMBAcn7DpxYL
         h1jrEPISlOLlQd0b2zxKkncZVquK1aTUugB9cPHDY3zKcIHpuezX07gC6ZGjqdlf9Mw1
         oKVGkT3jTm7f289t8toQ2fAsLcncRKTDrKb0cCKQYPiFr4rd9BCNpG2eUxV6tuySvaBR
         FstNNaYFe74HEj/dskNvwAkKcAeBQUxlXvDkQP37RD0rnCDICo8H75QYx1SrjR6/90F2
         Pzqjjqj2zIU6CQt8gQ3Upg+b8LmOtRnyTVou8nrb1p9zfKTaDCplhhXTNDVN7UTyyk/o
         Dn4w==
X-Gm-Message-State: AOJu0YwcKekrjVuzpXSiUPIhYnM6WuRzojdWX3WFxAUtWHJl3deUSVB3
	TCzGCdV4gbiv2H/ao26twdrvUwNhui9gOf3WGMPwSmx101Yy5/yNSnWgIttBWg==
X-Gm-Gg: AZuq6aJsPvdGL6mawgNO/DUYe1oP1CijRGOIei+zK/s1RDrherdTJsGDB/GorDsL/nP
	tG7uioVuGCYFuyGYiwdYII1xc09RPgcSxpT3PyJ5f9V+oixxwjMXhLeLeSqQGIOIlWFWp9frM5I
	ML/CMaT3GSE9sdYeLmpgp5pAhi2HDCErha+GK3FPdaVio+LGxzUqC6VzxFhKf5/uBM7IUmU3fYY
	NJEbfJnWTYVpyQdAGLtX4ia0ZqpOIYAmzZriaGE4+q36zbjtVNoxRcqNGpw2AXDWLGIMfDuxask
	vbuSAai3frRgn1PGdDlstXRrNzeovZJF95Gg7Jchvy0IWigcNh+II/rpQz8wxsjvZGPbpw9xvbU
	TxF3fMHvHBVJ0ydBW4vXDolDT9l01O+NZMgHESgIiMbuax5HirzucA6t4joMbSBRIwJ0ApEO86u
	GtaM0pXwBJYJbsHi4c58CXa8y1Ug6qpW+BHvotLoRiDtk2BSkYY8zk84TwJK1216A0fTa+
X-Received: by 2002:a53:d013:0:b0:649:b2a9:92c9 with SMTP id 956f58d0204a3-649f21ec127mr5681322d50.93.1770538629103;
        Sun, 08 Feb 2026 00:17:09 -0800 (PST)
Received: from binary.. ([177.39.58.68])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64ad8a12432sm3521745d50.21.2026.02.08.00.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 00:17:08 -0800 (PST)
From: Maiquel Paiva <maiquelpaiva@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	gregkh@linuxfoundation.org,
	marcel@holtmann.org,
	Maiquel Paiva <maiquelpaiva@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 2/2] Bluetooth: mgmt: Fix race conditions in mesh handling
Date: Sun,  8 Feb 2026 08:15:59 +0000
Message-ID: <20260208081559.44983-3-maiquelpaiva@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260208081559.44983-1-maiquelpaiva@gmail.com>
References: <20260208081559.44983-1-maiquelpaiva@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The functions mgmt_mesh_add and mgmt_mesh_find modify or traverse the
mesh_pending list without locking, leading to potential race conditions
and list corruption.

Use guard(spinlock) with hdev->lock to protect the critical sections.
This ensures atomic access to the list and reference counter, preventing
race conditions and avoiding sleeping in atomic context (which fixes CI
failures).

Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Cc: stable@vger.kernel.org
Signed-off-by: Maiquel Paiva <maiquelpaiva@gmail.com>
---
 net/bluetooth/mgmt_util.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
index bdce52363332..af9194e44943 100644
--- a/net/bluetooth/mgmt_util.c
+++ b/net/bluetooth/mgmt_util.c
@@ -397,8 +397,7 @@ struct mgmt_mesh_tx *mgmt_mesh_find(struct hci_dev *hdev, u8 handle)
 {
 	struct mgmt_mesh_tx *mesh_tx;
 
-	if (list_empty(&hdev->mesh_pending))
-		return NULL;
+	guard(spinlock)(&hdev->lock);
 
 	list_for_each_entry(mesh_tx, &hdev->mesh_pending, list) {
 		if (mesh_tx->handle == handle)
@@ -420,6 +419,8 @@ struct mgmt_mesh_tx *mgmt_mesh_add(struct sock *sk, struct hci_dev *hdev,
 	if (!mesh_tx)
 		return NULL;
 
+	guard(spinlock)(&hdev->lock);
+
 	hdev->mesh_send_ref++;
 	if (!hdev->mesh_send_ref)
 		hdev->mesh_send_ref++;
-- 
2.43.0

