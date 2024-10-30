Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE6B1990C5;
	Wed, 30 Oct 2024 08:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730277838; cv=none; b=e23c1uz7m6gpc0oNWygswTYWXy+VHspZqbn1kAjiVeZbNJHFOd7/evz8t2nTHPBpLl9FOqTHXGmVdhwQJNgC8oiGXB0k9kc8mQfIpGEGCG7/BBix7aFLvd5cAVugBOS3UovyOnjIw2rJlr1MG3BXRzremOk20xj3/O+2UB2yGLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730277838; c=relaxed/simple;
	bh=nON4sMqSAvd9n8ClRLG37QnCL3NBJJRIXO1tYAucTZc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TyD94GBJrfta+fjBR5e7VZyfhnPIoBKJsKvNZdXi5+vcvp29YdAVJo/S1g5takqsq49ufwapAs6VY6KZvOD0wOV1vE8yEQVj3euL5j+emsSjqCjx2FyX9ESUbhbT7z8/sdg28VHK4v/uKhAeDAdywFlYLzYHVXDl0aFQiGJpQUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=XA00ENYD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="XA00ENYD"
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49U8hgeX73761067, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730277822; bh=nON4sMqSAvd9n8ClRLG37QnCL3NBJJRIXO1tYAucTZc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=XA00ENYDcchY15J824PGOCtZ5gcb24VLSi2zGEGNbFLjLml7bwaa0996b1lPOxr4p
	 QC4Oxw3sVx/SfqvhZ/DNKMbgRsUPinO6TdzC9U10PcoZ2uA87r/gddWWEINmRNF3lj
	 KKsRWOJFeco5LJOfcVn3gKEPsgN3sH2EjhwpvGlj5ZZe8upjNfEZC8cdl1VeIQV7mo
	 igcO0TG2qM8ZLPyhNhs69BjXsYdbT1EdxpnhYu7y0qpe6BRfudW8eB9rVrjAeT2xGN
	 Ujbg7XICRjHNWBQkU5G+U2zy6NYIOszONxBOb/GJ1aTZMm3kjTR5SE1ujg02nhuUl+
	 vx0e7FDx/IY0g==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49U8hgeX73761067
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 16:43:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 16:43:42 +0800
Received: from localhost.localhost (172.21.132.53) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 30 Oct
 2024 16:43:41 +0800
From: Hilda Wu <hildawu@realtek.com>
To: <marcel@holtmann.org>
CC: <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <max.chou@realtek.com>,
        <alex_lu@realsil.com.cn>, <kidman@realtek.com>,
        <howardchung@google.com>, <apusaka@chromium.org>,
        <yinghsu@chromium.org>, <johnlai@google.com>
Subject: [PATCH v3] Bluetooth: btrtl: Decrease HCI_OP_RESET timeout from 10 s to 2 s
Date: Wed, 30 Oct 2024 16:43:34 +0800
Message-ID: <20241030084334.2740513-1-hildawu@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

The original timeout setting for HCI Reset on shutdown is 10 seconds.
HCI Reset shouldn't take 10 seconds to complete so instead use the
default timeout for commands.

Signed-off-by: Hilda Wu <hildawu@realtek.com>
---
V2 -> V3: Update commit message
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

