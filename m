Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FEF35C1A6
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 May 2026 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778229739; cv=none; b=KK5XjfSuTAwPaxidSSvebg8ocfMLq+g+utnY61o2OigpR7RqG7pQA8Z9tD7vObdeeVNa6GUAC/8Wyxx4dlo9wis2ba6O3GviJxdEZeqbIJPUMdai3RnzuMi0vslkSByq1N5Uie2yl5cBhzDy5HWYxOOxWUgK/zFS5cedXNL2AJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778229739; c=relaxed/simple;
	bh=u85YHATecIVRgKpfNOIDwDcORK6VX1SNuGbFdKLd7N0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DBML7srdO8LVwPGltSRULe9cdGxB+38gDCNNukdQxumrIEU3RYELDaSZPDBqBFYRJ4mXYlKWGzqajUnAAUYGJeJtAowTzrDZqkyAnala4202vG3jz4x4RqdoIVGB0E0zQEvF3Gfr7A5ce48l9MGL+JKgJ0lH9LmCgCPyTFPFpK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=ThCYLX92; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="ThCYLX92"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82748257f5fso1793718b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 May 2026 01:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778229735; x=1778834535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Bh9Icwt5+0ETWdyXuUVRLGVBe+vK407pyrzUFu3GVs=;
        b=ThCYLX92XMt27YshZ41vjuWcVcqOuYIBW/V48Yz7IIRlhUjvlRR3fWI40DK1eMCD1u
         DbJJ9zTse9yexR9Z0gfIT+paRZnZ1fFYjnG9Rk0LrA/7yNm0EW5+XX9jroc9HOkjos3E
         emJ5ih8WMmvXSxDsW9iTLF/D5InP7oGebb12r99KhhItatbIwxLMY4p+ZNG5JSpGv7HY
         nrEmJrHBXt93JHcHlC+aXKxFq28abkea+3PG3fCoG/8RS38rkjBjFMeWEufLCPRXUl3x
         cFwJjciNN+DJLQCEWZM9gx3+QaYpsJXNAXEdd0v1ZB3EPAisRVgP1NUVyKr1Q8iI70hz
         9fCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778229735; x=1778834535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Bh9Icwt5+0ETWdyXuUVRLGVBe+vK407pyrzUFu3GVs=;
        b=pby7SG4/Vfe1ZLVAoahnjlmW/dcRj6igHG/mVCxWk9LWCVm1BH9DmZyXf4ht2cjf8T
         TP1tBh/9v1hJB606Xq3oOdh212whtxaStmQlD6q5Vv2w96KF034xnU7ZGHDqcDQ6Kz1u
         +FPOtlCh/pyE45RbO/gJohlD/wfiubj47ReoTwLYIc51yFFa2FfkYnHD6Ub12Qit1LTc
         2KmjYQ9Gne4kfqhvlzsiuJR/Et88sBsCb/FGRshAKYKqguo1OOe86LcuaKuFmP3w6eR7
         F5bY+V/JEwKwpMbzGfY5IRBTJgwVcUrklX+Fk2MGzOA8hEWSBlbM9aLhUTqjruNa4k5o
         wgOw==
X-Forwarded-Encrypted: i=1; AFNElJ8vx1itXsWAK7i9MK4Do9/yQUMX1Yzp+5i1e/tC2ptyxPGMyDUVGmf4dBLdjeMZE/MFay0rKVGYTzF61duyFRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKEWQPIT+q9Yv6bhsUFkG5VdkWF4nBJjglcFlMCR43teYLg6Rg
	j2zZpylGYh9FUPjbURicM3Qq2O3AfNyq6lBi/IFWXxYJnYnyDs+rx9G+lry4FDnirfI=
X-Gm-Gg: Acq92OH9QiE/Zfs/vtcfa6xp6KlDpMqkC/RCOjsZX85Hp/Prviv4Bm+/768e9mmvWh1
	1zvojjB4yN/LGhtW2Lo3SqH3D5YtFDNluGJ76K8inr3XEi5vPETXDuhGPE3xiqHF85LToz0+efW
	jpN82J0Uil7GsqzgUEAjrDyayIepbuvSHHe0qwxazBZwCCQP0FmT+ImneunhDMUSO7ycACQ+Lkm
	tfrAO6uGao3PNB7HH96pV8VT45NQyN7kX7ga/IX0WJq6dOGQKkqCIOUs10rtT+pH+4qeILAD0qy
	IRdcL0d0vqHEsCj8p4+sh1i3N59QO3xz+9mQcjWSO1mjLgIZgczWQ3rx2WjLS5Z053sbTmmr39s
	9VHXnndVg5kqy273ZmQI+CUxmnwYzTPD5tnJSU5pWBhBF6mONTJwlCzSAgscVuBNxCmRnOm8vZM
	IzxuI72Em9N0U6ZUv88Tfjzq6msDmugMnEYx55OhNlRlmnlSoBsUPnk9btvkOSS7+E69sJaNjqL
	+gzSRvgRFP24bkATGhVag19BdPpSjl5Us/qEScuGZ/m+BO12prK09Ur7A==
X-Received: by 2002:a05:6a00:3c92:b0:82f:47ec:944f with SMTP id d2e1a72fcca58-83bb7aba933mr5031440b3a.16.1778229734627;
        Fri, 08 May 2026 01:42:14 -0700 (PDT)
Received: from localhost.localdomain ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-83967dbd995sm10518149b3a.43.2026.05.08.01.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 01:42:14 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: marcel@holtmann.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: virtio_bt: fix potential memory leak in virtbt_probe()
Date: Fri,  8 May 2026 14:11:53 +0530
Message-ID: <20260508084158.68765-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocated for struct virtio_bluetooth is not freed on the
error paths. Fix that by calling kfree() on the error paths.

Fixes: afd2daa26c7a ("Bluetooth: Add support for virtio transport driver")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/bluetooth/virtio_bt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 140ab55c9fc5..b34dd5ddd631 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -311,7 +311,7 @@ static int virtbt_probe(struct virtio_device *vdev)
 
 	err = virtio_find_vqs(vdev, VIRTBT_NUM_VQS, vbt->vqs, vqs_info, NULL);
 	if (err)
-		return err;
+		goto free_vbt;
 
 	hdev = hci_alloc_dev();
 	if (!hdev) {
@@ -400,6 +400,8 @@ static int virtbt_probe(struct virtio_device *vdev)
 	hci_free_dev(hdev);
 failed:
 	vdev->config->del_vqs(vdev);
+free_vbt:
+	kfree(vbt);
 	return err;
 }
 
-- 
2.43.0

