Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C24D35AC18
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 10:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776768507; cv=none; b=SZokdNQzGyFTiiWBy/UJ/MTuGIGzAYitSdZ6JALiXW6LKD0/plnepDTJGkPRtI3440SZcX0vizH7POq4ZlZx+cgUfBKDIlrIF3y7DKjJmMZFN7EbizK1QmgXt/rWrRrA6kSFXOxkiCP88wNi7xSfJYkfr2UgenzS5dk9NHFkjBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776768507; c=relaxed/simple;
	bh=FgFyEEu7SzAMRI//XWO7zdbV++r3zoDQ/MgG+dqm/7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EUrHqu6IwpzeuqJDouYCdflOHnsrbwqaaWm08tsOtuWj2ziOxWyyUCpna/aYR+aLj0joH9Lb3zJkiWEWN+lyPMPtnemVJfzmfFgCqlJwUhGTTPtax5tYPhpOpn4YsFclIpwxt1+K8Yu0ftoIFo4EddDt48danZn+nUFPbDHG2rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGuhvpOZ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGuhvpOZ"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d572f7437so2693352f8f.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 03:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776768504; x=1777373304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f+ooAKgHIuKcQdMInfKY/BCUWonIks5RSqvPScUktgk=;
        b=jGuhvpOZ1+sHmiFZmO7UMXLvK1JqUfIrTPAIuSO4Jtb3DN1AFV1n6ge4Pyh1QZ6KlI
         OwuJD7v40siKsyMtDDkgCYJIa7QixBUx1Mf8VY8hG8ldN2ao9AbelSfEJa492ZptAYnQ
         zz37EFRrfgyTgLlJHGHVh9+6yzzYdtAROB38jLXie6ngehlXZ7OpFF88hWxGvZXT+uXg
         2SUu4yYlQflRZa3zlIHwfVC3irEZhkdAhMGESWh51ZPaLcAUkAgu/sJB/uqZLQm6YzQr
         e6ImOk42YOsywu88Vjk0fHLrN9xyoCxhNQ8kGj2HR7jmzvsu51US32sGAA5hoIhGUqdG
         D2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776768504; x=1777373304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+ooAKgHIuKcQdMInfKY/BCUWonIks5RSqvPScUktgk=;
        b=CDckGfWvuhSEBH+CJAypz0PbfKF0fEgOCjH9M3vLxqzKHvTE5fBY4Ay+yRznhfMttB
         r7mZpV7iFAxf7/NMerbI6CtcDr9s8DPxaBD2tlajz0WR228kYhpVHXNWnxYscl/cY5v0
         1yT1Gsx3CoDoTyPRAWRgrKOFcwZZrGRTAUf9sOL5ri2ozSeuc5T9x28emWLLzxqkqjDT
         /Sl7RaeLedfwXw9dIoXguBHniCicBi0IOiWrYSc39cCJenwS3zZQ//a9ipTgFQdrRlLD
         Iil7tVy5aALEglwAwzJhZarb+giI6P1Bvya34TBeeeMeVP/ZbC61pn7F1HeR8daCEQ0m
         n38Q==
X-Forwarded-Encrypted: i=1; AFNElJ9ECo62Faz15IzD7899WmPuq3YayJSubKhOxrVB1zYGK5tqX8eIUmBqQ6Gegc7imtqMJDEcO9TWNTohbiiYxYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRKnUCM3DErk5wDhxKhNys5FzuCyzJ1213YXBNG8SUN7GPIw3N
	CEyq/LtO00uMZVdr+HtUsSTES+QsKxWyT6cIlVV7gxNZ4WaOpeuYbHGoK3oy
X-Gm-Gg: AeBDieu6l2iUoVkgJyvDtg881Sqiw4rlaDL2YVVfjGi+XnrQ0/HNKJmoOx0QCA6Ivdz
	Bt0j6DdA5/TJJxf+ke/1pVSHAU+hEp4RERMPNgRpzWm8iEfndfBcKWB7UdoKUV/evlbVisnSUIx
	tnEQCY31TQfvmSjvp+ulXQiCTemTyi6b1tXjo0GL0yQ0EY7eQgjB+zk2/v8mOQzNsnTmTUxw8kI
	Zq+FN4FXwfBM+gySpKuaI2JUMz3siVVgZQho3uL1MzRDG2jBTQwjPs+k+oIU5X11OuweucNSiYG
	+Psb+GLX3VBXlBQt8EkaAmFHv4r8bAypd1tT2Hn5H+NO5St6o7WeNH/6iS+neWOmnWXSNQKx2jp
	Qmzo72/p9OVA4jTqtOnNQac6eet2JmW5NwHtvgLOf9duA+6cb7EqfF+Q+wNWtc8fN8EAfYhuRZw
	5b0DR4yTxYeKDbfw==
X-Received: by 2002:a05:600c:8207:b0:485:3193:6ddb with SMTP id 5b1f17b1804b1-488fb73cf74mr265162525e9.3.1776768504275;
        Tue, 21 Apr 2026 03:48:24 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc14a61asm332563105e9.15.2026.04.21.03.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 03:48:23 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Chen <mark-yw.chen@mediatek.com>,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v4] Bluetooth: btmtk: validate WMT event SKB length before struct access
Date: Tue, 21 Apr 2026 10:48:22 +0000
Message-ID: <20260421104822.2498025-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

btmtk_usb_hci_wmt_sync() casts the WMT event response SKB data to
struct btmtk_hci_wmt_evt (7 bytes) and struct btmtk_hci_wmt_evt_funcc
(9 bytes) without first checking that the SKB contains enough data.
A short firmware response causes out-of-bounds reads from SKB tailroom.

Use skb_pull_data() to validate and advance past the base WMT event
header. For the FUNC_CTRL case, pull the additional status field bytes
before accessing them.

Fixes: d019930b0049 ("Bluetooth: btmtk: move btusb_mtk_hci_wmt_sync to btmtk.c")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v4:
  - Use skb_pull_data() instead of manual length checks, per
    Luiz Augusto von Dentz.

Changes in v3:
  - CI all pass (CheckPatch, BuildKernel, CheckSparse, etc.).

 drivers/bluetooth/btmtk.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 6fb6ca274..b1a96ebae 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -695,8 +695,13 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
 	if (data->evt_skb == NULL)
 		goto err_free_wc;
 
-	/* Parse and handle the return WMT event */
-	wmt_evt = (struct btmtk_hci_wmt_evt *)data->evt_skb->data;
+	wmt_evt = skb_pull_data(data->evt_skb, sizeof(*wmt_evt));
+	if (!wmt_evt) {
+		bt_dev_err(hdev, "WMT event too short (%u bytes)",
+			   data->evt_skb->len);
+		err = -EINVAL;
+		goto err_free_skb;
+	}
+
 	if (wmt_evt->whdr.op != hdr->op) {
 		bt_dev_err(hdev, "Wrong op received %d expected %d",
 			   wmt_evt->whdr.op, hdr->op);
@@ -712,7 +717,13 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
 		status = BTMTK_WMT_PATCH_DONE;
 		break;
 	case BTMTK_WMT_FUNC_CTRL:
-		wmt_evt_funcc = (struct btmtk_hci_wmt_evt_funcc *)wmt_evt;
+		if (!skb_pull_data(data->evt_skb,
+				   sizeof(wmt_evt_funcc->status))) {
+			err = -EINVAL;
+			goto err_free_skb;
+		}
+
+		wmt_evt_funcc = (struct btmtk_hci_wmt_evt_funcc *)wmt_evt;
 		if (be16_to_cpu(wmt_evt_funcc->status) == 0x404)
 			status = BTMTK_WMT_ON_DONE;
 		else if (be16_to_cpu(wmt_evt_funcc->status) == 0x420)
-- 
2.47.3
