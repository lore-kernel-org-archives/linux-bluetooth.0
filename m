Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AB13502B1
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Nov 2025 16:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446390; cv=none; b=YCaRLgemRKjDPt94vzva9it96uA/patAyoSw2Ou8pCh4ZOrRUPvE3aif1rLUFoRNkMIAH0eMhfQuTkg1Mu+NeT9CLxsMfCpufN7jRXNMNg2Tx0hHOf8Scghg76HTTQnU2xVH06AbPUD6nD/RcwS5Qz/wBCNpf8haMv/2UbALjzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446390; c=relaxed/simple;
	bh=03iL+MrJCZIb22dUm5GFGPSBSc4oObKGQ1674twGAoA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WmGbgVSjH0Vho9o2Nsod7wR4dmic42Kp/awVu56v6WUY9m++9z4IHZ8MiY7uPdP7Dja+L087qEKPIYaR5Bx7cM0aPdsRtePNUPHWuKFdyYZKybRwYCHEAAW+NCnQwnyZs6j5etDo11/5flW4zpwzBlU1PI+Z+G/wlExQeoSalEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWKkWHcO; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWKkWHcO"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5db1e29edbcso439465137.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Nov 2025 08:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762446386; x=1763051186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YLm1rQ2FtRBpKOFPnpSkr7MK3VwWtNthgSOvuX+ttKE=;
        b=CWKkWHcO7Tkm28hpDUE2veSGcuFyhulsVUg5S6k2qBbDNClfyLuQDRFxSigrACZ374
         7hKeXGCLnmtBZjMVrTouiv5APZspeCbAeE8dhiMrpLjuxv1KbBDMzQUjPxH5lZCZV63R
         D+BDFt44z/eZcinOXJ43o00/FkmFvQHzHsXy2555Uq/mRxLlqy1NCaXscmeOwp0ZvNFh
         +paTxgcT6hZ/ctNPE7jvWucpStmleeyzCGSo33T7k4X5MNOkxMoHGXQyZXXVJyJRTWY2
         qOLjeq1tUNszlHnZ83S1iN50Xmm20JConzIBeXc/gyDmQpfDDI5TOgue2qtFF0CTl+Vo
         oEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762446386; x=1763051186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YLm1rQ2FtRBpKOFPnpSkr7MK3VwWtNthgSOvuX+ttKE=;
        b=aBfFsZmnHDbAjaFfJG2rU0htHcxpRBw6ShBQC1yhsDZ0T9az/EhVNbj11Mocx9VRhC
         OP+oWe2JeHkjhhnf0SgfxZf4zfR2+XuEK1PlnXWGEsUTjMy5ef1R81DH+iHlIusq/LlO
         tqDxrACi/2iLCmhvgqd1jVh5ctl9FTZ3eo6BWRx6CxF1jx8DU110nyMOlcPVhFewpaCZ
         tFRosCvDcCPo6ZSYlXZyZef/2UCpQ+D/fJOUJ9zrbgNa7Nc2WTKWe5OwI1guB2B49G32
         L/wwPZQNqb+m0aU86ZxM5Ow8sEOY4rrYqweInUZ3c1egQ3b87YwpL/Z/0JnlJvKCAh2K
         uUjg==
X-Gm-Message-State: AOJu0YzARTXG0m3t8FKsAeHbi7LBZ3yU725vXoM+0o++EujRQ9ZHFSpW
	jX6O+TNLVnbNXaU1TYa7gz8ObqcmnP3ezIw+fCDm/YJXqXRGSzLLy/dBRMsb7u9s
X-Gm-Gg: ASbGncs/Qwpg7RlqLueRn7uMajC+WkbcG7yZrBVxoGxgaACS3xVDMH2jopIeoilLcMs
	oENbssxdYp35Ekcqifi/2LE2uBZQrVJBb49UYAGHWo3X6EReeyxo61bCydWTNrRy3z9zNSFR6W9
	IO5NC10qUndBbIfAmKrOri7WMhfChWC6YQjI5BAFbPu0IAVE4xuRS8ByW3eVy9eFaKf4cTUWLan
	7pYBnAlFPQro5gBgSabJPDYa+EIZ0Qne/KUo1hD6Pb59QHDKggjl0W7cS7wW5rlzAVejVeC8HkJ
	3POby596J9H4e18j5ri2I4DeK4xXdBCvJjXSp/E91roIr0fhxnpJfK3Q7l3rcWiQSNpszUMpalu
	vTjUXhYn/K2FcoqGnXE1v1xQd8/8nenXHEkTZi3mVJdFYqkt/nWvThJ4WbeSMZDU12b5pcWmC+j
	3i23PSg+EhCokuJg==
X-Google-Smtp-Source: AGHT+IEumv05uuI87aPuagLcpKftj3CO0vH5OoYMyKgrAPK5lyvUOQWJO1E9R4IGwX5ZFK4zYjWnjQ==
X-Received: by 2002:a05:6102:ccb:b0:5d6:676:2af with SMTP id ada2fe7eead31-5ddb2129f57mr11673137.12.1762446385922;
        Thu, 06 Nov 2025 08:26:25 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5dda200bbb3sm1204944137.11.2025.11.06.08.26.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:26:24 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] github/stale: Fix not removing stale tag when an issue is updated
Date: Thu,  6 Nov 2025 11:26:15 -0500
Message-ID: <20251106162615.745878-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In order for stale action to automatically remove stale label from
issues it requires the following permissions:

issues: write and pull-requests: write

https://github.com/actions/stale?tab=readme-ov-file#remove-stale-when-updated
---
 .github/workflows/stale.yml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.github/workflows/stale.yml b/.github/workflows/stale.yml
index c6d6134d9d00..bf2c20226cc2 100644
--- a/.github/workflows/stale.yml
+++ b/.github/workflows/stale.yml
@@ -6,6 +6,9 @@ on:
 jobs:
   stale:
     runs-on: ubuntu-latest
+    permissions:
+      issues: write
+      pull-requests: write
     steps:
       - uses: actions/stale@v9
         with:
-- 
2.51.0

