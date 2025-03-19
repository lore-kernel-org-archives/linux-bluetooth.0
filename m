Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED53A22259A;
	Wed, 19 Mar 2025 23:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742425961; cv=none; b=KmQd0N9ILK3D/m+vwxRJ+4fuuou5iSYheTdaSIawnuCULVRlB2e5SC2GJoz3x5V5vZvqZfgDsjUQHqRO4jY3OxiQrywE4OpGzZQKw9t3a1fQbsFaMIxPRZTSTzWLsI+r24DycY00p1mTPqp4DEkON1HnpORGYgCyogROXMoKXRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742425961; c=relaxed/simple;
	bh=9cK7bQp3Pr97NdgKEUGXOq7/N4nTvJKne5rn61jVlM8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nlfy+n4eqbyZV6jabZMvEG92JMO9qnf62ititaDwGuO12hcW66qM5KQXCyaScQW2kqAAsLzAy9IQYgd9tHDhiv8n6XXwWKcR7adahIvzHQAowPu77QBeV/3t1IyDn9ekMOt2qVhn9CciAf8a1g9jG6GvCI6gumKVrqQ1vcLpHqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-72bbead793dso176663a34.1;
        Wed, 19 Mar 2025 16:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742425959; x=1743030759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WKlXKZtfh+uTRH8fTklVVRhTwhTpAog5CHSTPWg92Es=;
        b=lrIhP3Uh3HE0ecBKDFg3MU+YeDenDk0zYWk4WEmpa+wB6iiST6CLSBJUYGjmhjqhOR
         RA4lXFdefe6grmMiqL1C7dnpLfOiG9z7XyR1vCMxA3FnObTKKt5Juz+v0R0Abnf3Idvu
         /cPz0Z/YgILG43vsTCnxjWl/x+WpL+quDnCnOJZ257HN02RupSlqE4FvEce0fMKTyCl1
         IcQtiWt4c6VpcyxeMTmMk56nSApFOx02uPHqXZBsfqpooKjWo+m4dSBdngfg2XhQbvvC
         qfJrgi7IKZEUzqcLkKYx71ibTaS9wkeLFO2AW0EtT8Lr/Mt6GHjmec/SkfZUgEIw+BsQ
         lSgg==
X-Forwarded-Encrypted: i=1; AJvYcCXYRd5H0183XhfRCsDv6EhZCD1+6gI0A8Ohbokvh0HY1Kt1uIO44EtwIaFihJLpzNE18ARZAKIBD3BtAuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIxb/4i3NhZwenWBxyAYt0uUAssvhCbRRi8Hd7nWRtoRuXQhpf
	6qcanV7uuuAWCv5mXbZF5wi9Hmemg6Y6Uc/bf23QkfBqMCwf7ksb
X-Gm-Gg: ASbGncthcW8V+yczg7OZ890x7L8VBKxogwI/WTsxzsm3ukmRp5VN7WemreMCyyWq2Eu
	sN0f7VV1HPNwT4TV+SPeTsFtilPxxzS54s/66Gv9Xx54yjfsXT9f3DDNEGD70k5um2/aUzObJNq
	wJ7t4YVYSwLLJb9VxoYR8SjZ9IbkRI2NEE7ew53FoqL5U16qD2QCpOWs8P4CjW/3UqHOk3G5OQc
	mgU+L2Bri1A5UV/XXcuSAOO/guseqMdCVpboLmRwSRzr3yMiPeVp+RKSp4cX8oS09h/soyA3Cx7
	q0lU44L7bi/yA0+t7spCrzlz8zJ5hHyJ/YtF8BeeJSEtdsMXFmqyGuzkGskVuw==
X-Google-Smtp-Source: AGHT+IGMcnuShI9r2n5jMm4bysoWLa4SeT4RJoNs1Q1Zu6ZafknXGWanWoen/4zNNHoLqX3qtvk0dg==
X-Received: by 2002:a05:6830:640a:b0:72b:9bac:c044 with SMTP id 46e09a7af769-72c02d6e351mr1163983a34.0.1742425958916;
        Wed, 19 Mar 2025 16:12:38 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-601db7a2a17sm2749735eaf.25.2025.03.19.16.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 16:12:37 -0700 (PDT)
From: sean.wang@kernel.org
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>,
	Wentao Guan <guanwentao@uniontech.com>,
	Yake Yang <yake.yang@mediatek.com>
Subject: [PATCH v2] Bluetooth: btmtk: delay usb_autopm_put_interface until WMT event received
Date: Wed, 19 Mar 2025 16:12:35 -0700
Message-Id: <20250319231235.812700-1-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

Delay calling usb_autopm_put_interface until the WMT event response is
received to ensure proper synchronization and prevent premature power
management actions.

No public link for the reported-by tag available, the report was sent via
private email.

Reported-by: Wentao Guan <guanwentao@uniontech.com>
Co-developed-by: Yake Yang <yake.yang@mediatek.com>
Signed-off-by: Yake Yang <yake.yang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2: add a reported-by tag and mention it was reported in private email.
---
 drivers/bluetooth/btmtk.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 68846c5bd4f7..01832bc6a259 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -620,17 +620,14 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
 
 	if (err < 0) {
 		clear_bit(BTMTK_TX_WAIT_VND_EVT, &data->flags);
-		usb_autopm_put_interface(data->intf);
-		goto err_free_wc;
+		goto err_pm_put;
 	}
 
 	/* Submit control IN URB on demand to process the WMT event */
 	err = btmtk_usb_submit_wmt_recv_urb(hdev);
 
-	usb_autopm_put_interface(data->intf);
-
 	if (err < 0)
-		goto err_free_wc;
+		goto err_pm_put;
 
 	/* The vendor specific WMT commands are all answered by a vendor
 	 * specific event and will have the Command Status or Command
@@ -646,18 +643,18 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
 	if (err == -EINTR) {
 		bt_dev_err(hdev, "Execution of wmt command interrupted");
 		clear_bit(BTMTK_TX_WAIT_VND_EVT, &data->flags);
-		goto err_free_wc;
+		goto err_pm_put;
 	}
 
 	if (err) {
 		bt_dev_err(hdev, "Execution of wmt command timed out");
 		clear_bit(BTMTK_TX_WAIT_VND_EVT, &data->flags);
 		err = -ETIMEDOUT;
-		goto err_free_wc;
+		goto err_pm_put;
 	}
 
 	if (data->evt_skb == NULL)
-		goto err_free_wc;
+		goto err_pm_put;
 
 	/* Parse and handle the return WMT event */
 	wmt_evt = (struct btmtk_hci_wmt_evt *)data->evt_skb->data;
@@ -700,6 +697,8 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
 err_free_skb:
 	kfree_skb(data->evt_skb);
 	data->evt_skb = NULL;
+err_pm_put:
+	usb_autopm_put_interface(data->intf);
 err_free_wc:
 	kfree(wc);
 	return err;
-- 
2.25.1

