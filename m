Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AFF30CF2
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Nov 2023 13:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sH2Vbork"
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F272D5B
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Nov 2023 05:46:34 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1cc281f1214so45509615ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Nov 2023 05:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699364794; x=1699969594; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KRZW8kevjh4aZ31PiUOxCku+9NRp8iX+bdfbv+Qzu7I=;
        b=sH2Vbork7s2X3eU4RjIVBjkHEe2qAJzOOE4K7IfELcpA+Aztp4NvlROoZxxRJcMPY3
         t7NeMlc0VsvkyguWQGhyZcB82XXNFRkptKeVSk4WulLmVQd5/ek6AfmNABDENsEeyTVo
         rceYCWcO0Sz96gPc877UZ5cOoMPCyqClLiQEggSj/xwOPVA1SYWqhH+HVSGmzCWSCt2R
         TM7ntVhjMgj6g9hD0Q2y6dG8dMvRGg6eqyYYMcvoa4nP0BnBZjvK9eU4EEqlsb7DJzoP
         1NkZpHqfTCEcwiqWgMtKgEpwk0TB5Kzlx96RzmFbpUZzclQ2tXV8jFBBHSP5X65xmN5u
         79Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699364794; x=1699969594;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KRZW8kevjh4aZ31PiUOxCku+9NRp8iX+bdfbv+Qzu7I=;
        b=kOiikVD8mkWpSxIu3xlmut7HbhEj64CaAZBnXw3ydIgl3NpRuPaglbtRlVmdEv5PEh
         Y43+aQkrbxWUHzQpHyZFvatU+cxeH5NqvZE4xXl/1dB2kKmSn4Fu8H0la74CLHuarjr/
         ENTH6iPgzitZryz++ET5qFkQNaTWNFIq/aQhib9hR8H623BNxxUzmf8KNt+dvxzrFpvo
         frVMIdsdx7x3HQeIV1viw0a81o7qaFwipILa4j0sbUX6nfTBdK+EIG4/FfwVs1NPJAhX
         A77BITYnkZov/gMMc9zc0gBZa5wSqWUyp0uBt5//sSzMmLwPRTvehiHtzo1GQB1NDAdS
         Zg3g==
X-Gm-Message-State: AOJu0YyxxodHawUpNDShBEO3a/MS/l8+7KAZN0nQ2fbVAgs0QGfbbr0z
	0WCteihIm5d4ubtK7zRpcYj51bSFnGZzCA==
X-Google-Smtp-Source: AGHT+IEwFapbdsh5pEB9VSu6Xx0POX8X14oXwHK2HqW/z8ziL+svc7eapTp7HYjscOU8GhqJ+Pj+oCpEClThjg==
X-Received: from mmandlik-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2893])
 (user=mmandlik job=sendgmr) by 2002:a17:903:2591:b0:1cc:bb7f:bd5a with SMTP
 id jb17-20020a170903259100b001ccbb7fbd5amr144886plb.6.1699364793747; Tue, 07
 Nov 2023 05:46:33 -0800 (PST)
Date: Tue,  7 Nov 2023 05:46:10 -0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107054609.1.I4c7ab22148e168e3cde00f27b89748ff4bc651c2@changeid>
Subject: [PATCH] Bluetooth: btusb: Return when coredump trigger cmd fails
From: Manish Mandlik <mmandlik@google.com>
To: marcel@holtmann.org, luiz.dentz@gmail.com
Cc: chromeos-bluetooth-upstreaming@chromium.org, 
	linux-bluetooth@vger.kernel.org, Manish Mandlik <mmandlik@google.com>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Tim Jiang <quic_tjiang@quicinc.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Avoid freeing NULL skb when hci command fails.

Fixes: 20981ce2d5a5 ("Bluetooth: btusb: Add WCN6855 devcoredump support")

Signed-off-by: Manish Mandlik <mmandlik@google.com>
---

 drivers/bluetooth/btusb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b8e9de887b5d..a0359702c0a1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3463,8 +3463,11 @@ static void btusb_coredump_qca(struct hci_dev *hdev)
 	struct sk_buff *skb;
 
 	skb = __hci_cmd_sync(hdev, 0xfc0c, 1, param, HCI_CMD_TIMEOUT);
-	if (IS_ERR(skb))
+	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "%s: triggle crash failed (%ld)", __func__, PTR_ERR(skb));
+		return;
+	}
+
 	kfree_skb(skb);
 }
 
-- 
2.42.0.869.gea05f2083d-goog

