Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C383E1E861
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jul 2024 15:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721142094; cv=none; b=OcyXb4MUSnpgXvranL7LiMqs4YOEGR1c7RVlk45ciRNk8y+L9zxCbRbksrLAAk01cIga3YgAoCxCcKoCKsjzMSIYjUB84LDIzDrxEGmW4+8DwpRJcSnYjR9tS9193p4aDdwPuGck0a5a3Jm8F6tPY1L4tSg8zDsKXbam+q7PQwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721142094; c=relaxed/simple;
	bh=m30GmcIqSvUNR/IaCpHLBjkCsm8K0SHD3uDs9D6LszY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Ptjr2oUXctfmFnurFMMN/tpu2aSI4brgNqxn/gxfuGiElb8l96XzIDZ4KTJilQtCy6JPJlh6r7CPhJ0+IuEZCgO3TlYh/lveZilfdhdGkj2p8fdh7tPulAnc32qJZpwxUxRmKJMg99NvT9vTOe4VeKT22ob7Rt5xt5rOy6pC3JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5y0rk2t; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5y0rk2t"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-81f01f88e8eso24241241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jul 2024 08:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721142090; x=1721746890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KRtHzmuOfZHmYnEL0fk5FhfvcfETgoqcEp0llGUSGlU=;
        b=O5y0rk2teEC59DrtPQVL/aemZyfgwygPs+oUyIax/5FgduPtQgs4/dIEgL+MI0Jczn
         n5GaY1O3AQl4HPRDIPWKtSHT1dk6q6iJ5pSkdTcqx+vFyTV3kzTw7xjnzWepqXnZV7JR
         l1HSwXuybaF4IUlIUG9Tck7Qp+NbW2oYXskMbw3Fy0LhpWRWe+mBZQ7Hi8/H4FB1gZwv
         Abj0GPy6DazIksOjEBYjZtFOwwbYLqQPJiE7BEzpC+WwTaSs+CAPBSb3eTPCoSWDS23h
         KT1qO9UlnMd00nPukfXa1wT3Gz0QnTW86tbXOTGU05sJ7tIUR/8eRt4leYCugbe1RXs4
         8/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721142090; x=1721746890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KRtHzmuOfZHmYnEL0fk5FhfvcfETgoqcEp0llGUSGlU=;
        b=XMyluRlB9G54m52VmdZZQfovakoWxNRoD7wZJkb1cUNXdflRGm/Lk4oYOGgUiCHEpm
         z8ooXMPJO+nfWwLDmvzg8m5NtONk0KS014iebvS6S2bkn1rbEh4kSrESn1F7wBFtDoDu
         3dgMuEHsrjItapH0WJq3VI6HX6sm0o2UayHd4DwpeFDCjUzUSQ1uwcLVvyOyIV27jvWH
         OEp05L883MxszrddGu3OxjXepKhz4m/pUZD4jJG2+Y6smeUkXpfH7V7q1pi2FHG7fFy9
         WB+hMAMqxwIsNPvXpL1oZel9d3QazD8m6Z+/q0qSn4dqkmX75GCnCw0rskE4tMpJGzNH
         fL6g==
X-Gm-Message-State: AOJu0YyRdJ9RcUpKUmpXiEtY42qD2nMIkiLU4lERajysrdd8Ql/vUdoK
	qsIkRXnS/g3tp8aSy0cPPJZcgg3JzXd0hig0JoEbAXJnnroflTpE8xDjPw==
X-Google-Smtp-Source: AGHT+IE8vtgw1ZdStk/E0ku1xiTUq2c/B4pXjJXmrDE26dW9QroU6QkNRI+b0DDYaG6b2GX3GImV3w==
X-Received: by 2002:a05:6122:3d07:b0:4ef:53ad:97bd with SMTP id 71dfb90a1353d-4f4d6f061f7mr1352989e0c.3.1721142089714;
        Tue, 16 Jul 2024 08:01:29 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f4d6eee6e9sm102226e0c.2.2024.07.16.08.01.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 08:01:28 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_sync: Fix suspending with wrong filter policy
Date: Tue, 16 Jul 2024 11:01:26 -0400
Message-ID: <20240716150126.512727-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When suspending the scan filter policy cannot be 0x00 (no acceptlist)
since that means the host has to process every advertisement report
waking up the system, so this attempts to check if hdev is marked as
suspended and if the resulting filter policy would be 0x00 (no
acceptlist) then skip passive scanning if thre no devices in the
acceptlist otherwise reset the filter policy to 0x01 so the acceptlist
is used since the devices programmed there can still wakeup be system.

Fixes: 182ee45da083 ("Bluetooth: hci_sync: Rework hci_suspend_notifier")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index cd2ed16da8a4..a31d39a821f4 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2976,6 +2976,27 @@ static int hci_passive_scan_sync(struct hci_dev *hdev)
 	 */
 	filter_policy = hci_update_accept_list_sync(hdev);
 
+	/* If suspended and filter_policy set to 0x00 (no acceptlist) then
+	 * passive scanning cannot be started since that would require the host
+	 * to be woken up to process the reports.
+	 */
+	if (hdev->suspended && !filter_policy) {
+		/* Check if accept list is empty then there is no need to scan
+		 * while suspended.
+		 */
+		if (list_empty(&hdev->le_accept_list))
+			return 0;
+
+		/* If there are devices is the accept_list that means some
+		 * devices could not be programmed which in non-suspended case
+		 * means filter_policy needs to be set to 0x00 so the host needs
+		 * to filter, but since this is treating suspended case we
+		 * can ignore device needing host to filter to allow devices in
+		 * the acceptlist to be able to wakeup the system.
+		 */
+		filter_policy = 0x01;
+	}
+
 	/* When the controller is using random resolvable addresses and
 	 * with that having LE privacy enabled, then controllers with
 	 * Extended Scanner Filter Policies support can now enable support
-- 
2.45.2

