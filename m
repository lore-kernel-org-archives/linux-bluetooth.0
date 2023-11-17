Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PEG1Ry6b"
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85005D4F
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Nov 2023 11:29:43 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6b74afe92dbso2776177b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Nov 2023 11:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700249383; x=1700854183; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7ZtpR5VBZnnk4soDSw6IwamiHkMHtshmq2RkQ7zs14Y=;
        b=PEG1Ry6bk3xe23gXUeibAY60PYqMqIFQf5RkDsat2en1DIbkh8m+ExE0T7nNCW/4EE
         ZtoQPu/C4Lr8jLphqOa2txNnNCcBLZiTb5a/hy7W/1mMc7K+6TfVMtrRm9oOhtb4rh/W
         BA+vmEo9J4FkbYXB39b4Ookem5y3SoNnl3ANXMRt4YeH7WTW/tXp2/0s4lBiNehtqYoX
         XAsTVliTDHixJb05WFDWVWyp7CwBKo/Fuf2MNU9GC/ClnI9WeYcNpkDOYuWmWJVyep06
         7ioEMhSJ2br8iHgdkNLbBBlBX4CACOEUo8RjNwPsz6VOlMKlrPTrIQhkUOT34g51crBk
         Jvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700249383; x=1700854183;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ZtpR5VBZnnk4soDSw6IwamiHkMHtshmq2RkQ7zs14Y=;
        b=Y0/4HD2DQt8qyOOkU63GwR9g09/zx2duEE4KJoAg1rvY9XR/0BapWtN2g1x4iEIqln
         xM5HlTPvXe+4EcfakLnAkKY/yVP8+euTbrWe5JZxW/80g5vxzEZ3dxwF8tTLYmV1qvVO
         SVGGUsS50kZfU1jVbBGP+KQ9L/vLIdq9LHGDuk2M547+14+qAiIrv37LAKb5O1qQXpBb
         X3qIcbRwJUs3W0VS+f62yvfiOuUURVkvysFkNZfNtbo0g5kYzbi3yjd88/vHRH5w11zG
         TahsNqihiPyDY3TYsDmsdCrtt1Tzi1vk0X6b7H6CGwfieJinj5hjmerPmQASfeSPnxPJ
         vcKQ==
X-Gm-Message-State: AOJu0YwM2/mfqpthwNT2R4cBSG/1NaVy6L1tDwrbVl1dmpzzO5AeAC2M
	QQ466aCDcWSoJsrzOWSiUc+08FUeOLmJ7w==
X-Google-Smtp-Source: AGHT+IFslrvPLsq4BT5PcXEkzGg0ZUVP85qVwKubrphQcon4Mwiuor6/RqEk3QS/vc3/a5OeGoXksoaO5xM7Cw==
X-Received: from mmandlik-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2893])
 (user=mmandlik job=sendgmr) by 2002:a05:6a00:8d93:b0:6c6:b762:ad83 with SMTP
 id im19-20020a056a008d9300b006c6b762ad83mr112843pfb.0.1700249382992; Fri, 17
 Nov 2023 11:29:42 -0800 (PST)
Date: Fri, 17 Nov 2023 11:28:33 -0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231117112833.v2.1.I4c7ab22148e168e3cde00f27b89748ff4bc651c2@changeid>
Subject: [PATCH v2 1/2] Bluetooth: btusb: Return when coredump trigger cmd fails
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

Changes in v2:
- Fixed a typo in error log in btusb_coredump_qca()

 drivers/bluetooth/btusb.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b8e9de887b5d..35a26440cabd 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3463,8 +3463,11 @@ static void btusb_coredump_qca(struct hci_dev *hdev)
 	struct sk_buff *skb;
 
 	skb = __hci_cmd_sync(hdev, 0xfc0c, 1, param, HCI_CMD_TIMEOUT);
-	if (IS_ERR(skb))
-		bt_dev_err(hdev, "%s: triggle crash failed (%ld)", __func__, PTR_ERR(skb));
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "%s: trigger crash failed (%ld)", __func__, PTR_ERR(skb));
+		return;
+	}
+
 	kfree_skb(skb);
 }
 
-- 
2.43.0.rc0.421.g78406f8d94-goog

