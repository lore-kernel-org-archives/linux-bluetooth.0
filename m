Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAB63EBF3E
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 05:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770959780; cv=none; b=TR9vy7BpO++QVwPnvCHoNBeZOJy13lhomJrRYAiR21jghDDfaC1D5RJdqjaURZydproapicHwT+IVg0Dhx8veoGlD7hFimRKNG7NXYxG4v+7YyUx98pM5FbUAor8YcyAZCmlK/5Z6QwnQM9IGvaWITVZq63lceD9oXaC1rEAAD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770959780; c=relaxed/simple;
	bh=vQxdkryUEJ+pArY5kJMAR+7YlXlMsv2XI7L1MiRhw0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U7XMHbZgtYSWHRe3njtzlK2Ovad22rjmVMs+BpGchH639tEsSJyq8ax0cmKJuiPr2+uFtKFMUWW96sEftZ3i3yuLXPhwgmx4qO+cgDPIV00mO9guLQu1X1hvcwWUg7iM74r+Osll9CmTfCH/LBRXujZW1PP9ESFHSb8EThrF3KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYcNfkRW; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYcNfkRW"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso589560eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 21:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770959778; x=1771564578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbsk2agQ8f3m0QH5WZrAhx9x+dI3Pqe/kCYQZSQSePA=;
        b=fYcNfkRW+alZCoaq5tzCZXzoMQlTe9PSusCqc8oOUM2ZcKUNHMX6gSXi35ZcxzwNnt
         f8P3Em33k+aDrml+Bee5SIBk/ruSVR8au0sWTx8JbMLitU4uKE5R/iEKTdEG98aQ++4d
         hD10UT5ZN7j0borF4JvcOWkcSxdJjqB7s04GQCfMKT5lViycsCNteB4muocLb+sh/g8M
         aMtlsUa/8UblUb5FU/MJh4YwsIZkt6m9SnfG6oIhD/v8+HeDny0gXZyBxBX5fpAUi7uK
         3f/XSL7XOLmjRSj79fJJmSeSOY5E24PJW+pDUxJa/jfqfg/qq8FpFoyOS5rW6PHxPB34
         LaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770959778; x=1771564578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nbsk2agQ8f3m0QH5WZrAhx9x+dI3Pqe/kCYQZSQSePA=;
        b=rFnRCY7M/wYvA3qC9J/u6EAP/mUJ3jkkwLtw6g5YWJxBGXOwmTVi2T2WyI0OcZKJ+h
         PA2gH19NDLFo545rtG3sWYj7GzbKKiHtxf+TyfsY1HSrl7A5GgAVO6gY8TI+AmhWDx89
         ZbpRMAXeN89MJVAyWMmahp1AUy99x4Ni5SieCmgWHXZwRjy4CXUmcY2sjwOKfS5X4YD1
         deaff+PWs4s78fX218XieuPTJhbY+j1UgCGxgy7u9eOpedk2eS9OnZyb0+9Tibef0GVp
         TXH/Lo6/rPDdm6tBUSzWdCcAd1Gq1og7Gpw4/HHPLxAdhj2mzt9CcnBHXXvCYu0hXM9f
         sWEQ==
X-Gm-Message-State: AOJu0YwC65LBWa9auOUYfOm0hAGGdj/HpNONaPDRzrVSt4A94l4osz3S
	LtzErplvakFv41gQoxW7nRC/By+RejLPgl+3zKkl8gFkqFlPlrCw1h20QQZwKw==
X-Gm-Gg: AZuq6aKqMpGTLaG7awsXH14oGAxs2om+wnk3RmykqUQnARhgejngSH+nuEhqolEkg+3
	stMYQgufARaiGm05+u0cbkCmhhb+QMZ6/slNHjoM47f4CwBm/8C94JPf99Uyh3D2fLMoAqhtEYb
	MolEy9UzzVhc490NARK9ucHUfOHJ77O9tZQqONjTbKXY3hTFM2nzgJHnCOZ97um/EXPuKHad1iq
	L34FTHB2bXq1mAVSFDT0LIP4kBdybETpZdDzcdTkgFCI5aVssFi8FeQqxgYEVuuyDHTz/3iTZHv
	P7jyR/qcJPvbYjV5HHBO8rPuiUcd6zX7w6+n7ohlqjodpeHovgFy8fD5J0BZVAFVl0Q0nJN5k6O
	u7f7nhvcn2BdONXbwI9abupPYSuCmK9ypfuaWWApS7g2pEm4rJ1Lo5bnkgHHcUZ0PcJo8eZE1TV
	jHJUdm4eOrDR5ItNUXCZ5GZ6SdAPx+vhH8wlgEuJDqaKxm2ndC47+o54BK5lUhfnsgfS92kqtvv
	d12f9wdksomGrAQ+N4JPeqAYA==
X-Received: by 2002:a05:7301:5784:b0:2ba:964f:fa67 with SMTP id 5a478bee46e88-2babc47f313mr251923eec.24.1770959778187;
        Thu, 12 Feb 2026 21:16:18 -0800 (PST)
Received: from kernel.. ([45.232.185.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dba2ef2sm4958483eec.3.2026.02.12.21.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 21:16:17 -0800 (PST)
From: Maiquel Paiva <maiquelpaiva@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	gregkh@linuxfoundation.org,
	marcel@holtmann.org,
	Maiquel Paiva <maiquelpaiva@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v6 1/1] Bluetooth: mgmt: Fix heap overflow and race condition in mesh handling
Date: Fri, 13 Feb 2026 05:15:25 +0000
Message-ID: <20260213051525.10945-2-maiquelpaiva@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260213051525.10945-1-maiquelpaiva@gmail.com>
References: <20260213051525.10945-1-maiquelpaiva@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch addresses two issues in mesh handling:

1. Heap buffer overflow in mgmt_mesh_add:
   The 'len' parameter wasn't being validated against the 'param' size,
   potentially leading to an overflow. Added a check to validate user
   input.

2. Race conditions in mgmt_mesh_add and mgmt_mesh_find:
   These functions modify or traverse the mesh_pending list without
   locking. Used guard(mutex) with the existing mgmt_pending_lock to
   protect the critical sections, as suggested by maintainers.

Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Cc: stable@vger.kernel.org
Signed-off-by: Maiquel Paiva <maiquelpaiva@gmail.com>
---
 net/bluetooth/mgmt_util.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
index aa7b5585cb26..eee4bc05f6e5 100644
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
@@ -413,10 +412,15 @@ struct mgmt_mesh_tx *mgmt_mesh_add(struct sock *sk, struct hci_dev *hdev,
 {
 	struct mgmt_mesh_tx *mesh_tx;
 
+	if (len > sizeof(mesh_tx->param))
+		return NULL;
+
 	mesh_tx = kzalloc(sizeof(*mesh_tx), GFP_KERNEL);
 	if (!mesh_tx)
 		return NULL;
 
+	guard(mutex)(&hdev->mgmt_pending_lock);
+
 	hdev->mesh_send_ref++;
 	if (!hdev->mesh_send_ref)
 		hdev->mesh_send_ref++;
-- 
2.43.0

