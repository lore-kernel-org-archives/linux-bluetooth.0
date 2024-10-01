Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5953D1BCA1E;
	Tue,  1 Oct 2024 07:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727768641; cv=none; b=OXoklmV2I7DeCJwcDwuijrwSXUiVKK7NP8F74euVUsaZJp1hUKzlz6b1QHTzKifCnXh4MhWPULyOK+eDIAdy8QhUsK9z7orCpmMW/qh7aTLKys+X6mKD+4qSpaPIClKAAvJ0KdprSqpuvR6YOJyu0tPVuRyAgbfQ3WRj/QwZR9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727768641; c=relaxed/simple;
	bh=19JFfEW6oTwpoLtJ5LBJjZzUTF94Yx0JvcCgsNjEusU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xa1/PAjzGVavLnuPy8i3glmpwnOPYFMMiBWFPjgLyUwONGk29aIybOmiCDU5zjAaw5QVmwl2snQu1Ls1CMArmAnNB0k44Ms5o3Cl4LDpPUUupkJ/S+BIWvluxZGO/uMcLpQEaI5c9jEMcgiPdsHnm2GJt6xCKgPziKxWgOaPC3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=IwuMJ+X6; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="IwuMJ+X6"
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4917hiBZ3709844, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1727768624; bh=19JFfEW6oTwpoLtJ5LBJjZzUTF94Yx0JvcCgsNjEusU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=IwuMJ+X6KSkk2r01nX/bi0pUebc2Fsa/T1cROhiPKJ8WkgJFIC0MVR2iihOvO431y
	 bpR8h+p3EJplAgAsZPAZysTPtjzha9cJfmD/ml3LU1WaXWWqDz3XW3Y8wjuQmWtiYr
	 GGAaTonv8CoM5uk0FumxNkTGb3v4vHTdvbqxBH+eblKQ6tK30b76efEqivUJNd4GpN
	 DDKeUPvmzdppN1zxRWEiZaTQB5TRSJc5oGa2P5QH68++IKIMJp1/ahQJeEkzD6VeQk
	 NNtV+rMu+LFvp8ZVeC9YpPIwbUZCM/hIoqx8zfJLLrae2GHBXSrZ11MZgQiLHO1/QW
	 o34D7OR1GWbBQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 4917hiBZ3709844
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Oct 2024 15:43:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Oct 2024 15:43:44 +0800
Received: from localhost.localhost (172.21.132.53) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 1 Oct
 2024 15:43:43 +0800
From: Hilda Wu <hildawu@realtek.com>
To: <marcel@holtmann.org>
CC: <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alex_lu@realsil.com.cn>,
        <max.chou@realtek.com>, <kidman@realtek.com>, <howardchung@google.com>,
        <apusaka@chromium.org>, <yinghsu@chromium.org>, <johnlai@google.com>
Subject: [PATCH v2] Bluetooth: btrtl: Decrease HCI_OP_RESET timeout from 10 s to 2 s
Date: Tue, 1 Oct 2024 15:43:39 +0800
Message-ID: <20241001074339.1160157-1-hildawu@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

The original timeout setting for HCI Reset on shutdown is 10 seconds.
Since the HCI Reset processing time is soon, so decrease the timeout
to 2 seconds for HCI Reset on shutdown.

Signed-off-by: Hilda Wu <hildawu@realtek.com>
---
V1 -> V2: Modify commit message and summary
---
---
 drivers/bluetooth/btrtl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 2d95b3ea046d..7128a8a0ba25 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -1371,7 +1371,7 @@ int btrtl_shutdown_realtek(struct hci_dev *hdev)
 	/* According to the vendor driver, BT must be reset on close to avoid
 	 * firmware crash.
 	 */
-	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
+	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_CMD_TIMEOUT);
 	if (IS_ERR(skb)) {
 		ret = PTR_ERR(skb);
 		bt_dev_err(hdev, "HCI reset during shutdown failed");
-- 
2.34.1

