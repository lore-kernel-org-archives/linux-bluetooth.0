Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14022176AA1;
	Fri, 27 Sep 2024 06:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727419312; cv=none; b=G0wVwvft2K6+qGpW062CFrFjEZ5wOc6FeBY6V5JNzlyu4iK0xEOMXqCJaoJElzcEnTRbkParXodAE/ansCQTkY6xZUmorDsAq8w7vWuLAlvtpd7cAYDDzu7CDylnL4kwnJsYeQdEtMJypc0kNRmvQ0ymfpQFDw9ZwB4F45EC4YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727419312; c=relaxed/simple;
	bh=5Ajp/bAuAIVeMn4nOVPTw8CCO3UZi7PNRY4n7CLFsrQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hMblweCaTGdH3BDnoj5N+nGlgr1k3GdZTglM1MN8fkG0KH+esZY/+aeqt8U/eOxzEJqcF9ji/UOzd+NqdEdBHG1qNkpWHqIcC98/1jLm7Ddcgiq59TTuK6nYz0rnsRBqjTmRFHR3F2kdcY8Qpp05T3M4u+VtnRU/qAvmxD8Anuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=EJ0oXAjo; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="EJ0oXAjo"
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48R6fWDV13155247, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1727419292; bh=5Ajp/bAuAIVeMn4nOVPTw8CCO3UZi7PNRY4n7CLFsrQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=EJ0oXAjoNOIq9LHtVn6UeSALK9OqLgRWDxPPNsk9aFRGYxfoWcxPVBlYxskgB+uDx
	 m/NR/bE2hyBGKBj2edpqqcz4r5YmNnUNMkwB5yyRaBrvkiGAsVWxZv5+l5ph0qtDgn
	 HP0Sz+u+vw1zyUdzZ4DXCG5AJhWAJUQMe2Re+NMdsT55kZ8SW5lW6eGK3sS24MxrbK
	 EfCA2Go0rHyTxPb4ky4YhtUQP9OwOlaKwdeHepooPKjhpw5H45QDk8YVvFvSJBrD2W
	 BABYOlCX6WwAe1f/woo0SZhlT9ePTHUg/LdGwCZV2XQBz9y6MVi8AsWEzEFsyR0ezA
	 3maNfVJOf4Z1Q==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48R6fWDV13155247
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 14:41:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 27 Sep 2024 14:41:32 +0800
Received: from localhost.localhost (172.21.132.53) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 27 Sep
 2024 14:41:31 +0800
From: Hilda Wu <hildawu@realtek.com>
To: <marcel@holtmann.org>
CC: <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alex_lu@realsil.com.cn>,
        <max.chou@realtek.com>, <kidman@realtek.com>, <howardchung@google.com>,
        <apusaka@chromium.org>, <yinghsu@chromium.org>, <johnlai@google.com>
Subject: [PATCH] Bluetooth: btrtl: Shorten HCI_OP_RESET timeout
Date: Fri, 27 Sep 2024 14:41:27 +0800
Message-ID: <20240927064127.4167789-1-hildawu@realtek.com>
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

Shorten the timeout for the HCI Reset on shutdown.

Signed-off-by: Hilda Wu <hildawu@realtek.com>
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

