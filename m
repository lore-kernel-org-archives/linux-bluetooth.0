Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2596355C1D8
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 17:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060889; cv=none; b=TTpeLhpCd0sKJLQfDqIGfd8x5MjMLmLyQ2UANViBxojjGm8utiap26+UTIykCHW1n455wruNLhbrmZVJtSoAxEyXRqKMHiiGtjDDY7rZztnvBiFPVDkE0ZlaT1PqfiNSw3LSa0m0RmNR8CwcpWODVaXPutzPjgW6hragMC2TURM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060889; c=relaxed/simple;
	bh=B3+KjSGo7ltdDvgyvOeJKkLqvPBIC23PgYv1IdhvMGY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hLmKKb5oWYFoWypA3uRZX4QTEFGLZ8M70t4DpJi7xTJoMkrpnmptt0fLdp62wzIhDMNUzj19xoOi2Y77sQvhOK0rkWU8nnC5WuBT8Ufl86vZBkgxmAeVBdE6QS+X0iZoEfofb7yhTMIp2W5vFIN+DarWXIc7imJMVQ49AcPN/Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUsbvUEx; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUsbvUEx"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c7e8a176c1so51651e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 10:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789060875; x=1789665675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uOCZIUH/hXMQJm/FqYS/fOgeWG1/Z0N7pWzO8al+EZU=;
        b=fUsbvUEx65XnyASkk9UHJeD2hWCxyTCNvTZdaGHQCl0uiOeV6QK4BMLDzI13G5MpO6
         iId3wmQW0jyl8ZKoEt33GBHTh1GqPh4c4EIcP9g5TOuydLOw4NqLZUFowtmNSC+WWoB4
         Ng/C4joWoLKhI88otaNQBh8djUXDRJ5U4XWaGGUQ71i8MZ4wiFW/WXW8uiXE3+gFlBgz
         cIvJ6s0THV8vKE7TZCrR/UPb8VNqALcG0A2kG5bfwN/SAfGZYKk1Cgfx/G7H9HJaZtR8
         p7unDuCjuHv2cWzlHNRhfJLwlV/bPsi/muTkUIzZ/mZwstaUsMZrZonDlD/vrC8qNjN9
         /sbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789060875; x=1789665675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uOCZIUH/hXMQJm/FqYS/fOgeWG1/Z0N7pWzO8al+EZU=;
        b=ozNgGagfqkbpzLQOYv+mYDAmSlFQa29aLpKM3JHbmMgoMPkwJRuRdLh3PTtwIIk40A
         ww7v0HCp84ekPkhtfxtJOpUmXNiKdZv+wH3hbnZkBeZGnyYWfTHqHuGu3rENPzpYKluE
         W+x55RvrpzpCewjz+4IQE0gwzjBXH98hRNzpfhCOCHP49gBNl6tVMNiYLlEqoEf8S3LO
         EeNHiDdRDmSQnFnkQExpGGuJhCXpko4u7O4+XfRa+OR2FSbNJcEoqQRh0I4cA9zounIr
         tPd8YdYVG1Pni7A+i37fMYzLBVv2izYDUDAfX4rKyZrQGbnqXekdFDjgEXRp14cITCK/
         7UZg==
X-Gm-Message-State: AFuF++karyramAgSYhsaZV7aM4pWKjxE7pi6DhK8o0lict+XKhVJwuJb
	+Im7cOrd7mqwG04Qn07QdTXwaa/ceknqggRFdlx6jgDPzKuZqxMqNtqdHgdtBLx9
X-Gm-Gg: AYBFou3w/qy9d6Qj0HXywIXyENZlrAFvLTSRDJItJ4z3oenzdiTpjSAvCHNt7b/U5MF
	dO7JpTU7V6hvOrib9hneY7f9j+WefumOopmAei7ou42RgioAn5nKKSuZaEp5DsNHLW2St7PVd9W
	rsZ7vzROsT4DRWf/TCNqK1TjHUFsDr5s0qUOW+08jQMdaWfyYNa7udRx5HsQHGCibCneFX29dNu
	Gf8D3cVmGZpssj7E0wUEbGDWS4BEf3k5YDrpN8DWOcuAZ78WK7GsRkZpy+vpbXH7Phz6YL/6Lj9
	DkcuJLPXePKEbfwqUBMgdu+vefkcB04407eyrJjTioEDt7aeBQcxlx289xat4Aojk7HWBcjACo/
	m2dU/uvlTTONQDjLJXl1NIZAxktACcf8qf8Z5xswkXj3facmsYf1kQjp14El5DsLpCn29bWIUXO
	rJoCjFDbWa1NVeWQqCCs1jgz6ONdSJuKA8Qx+GZ+gHB5VXHpFlc3Uc1523RDJ50kdXcNb5w9aq5
	jh6xANZ8K2hYK6DqTGxloa6BH7b41jbSt743NBRjCNo+rh3SgbfZ4H9q0IBYCysQg==
X-Received: by 2002:a05:6122:e20e:b0:56f:6cc0:681e with SMTP id 71dfb90a1353d-5c846074263mr1258965e0c.1.1789060875013;
        Thu, 10 Sep 2026 10:21:15 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-982ba16978bsm150460241.12.2026.09.10.10.21.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 10:21:14 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] workflows: allow the sync workflow to be triggered manually
Date: Thu, 10 Sep 2026 13:21:04 -0400
Message-ID: <20260910172104.1502721-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The scheduled trigger is heavily throttled by Github and the run can be
delayed for hours, which makes it hard to verify a change or to recover
from a failed run. Add workflow_dispatch so the workflow can be started
on demand.
---
 .github/workflows/sync.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.github/workflows/sync.yml b/.github/workflows/sync.yml
index 504a8d2ac9f5..c9e107ebc348 100644
--- a/.github/workflows/sync.yml
+++ b/.github/workflows/sync.yml
@@ -2,6 +2,7 @@ name: Sync Repositories and Patchwork
 on:
   schedule:
     - cron: "*/5 * * * *"
+  workflow_dispatch:
 
 jobs:
   bluez:
-- 
2.55.0

