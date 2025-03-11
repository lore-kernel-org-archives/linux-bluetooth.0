Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435381D6DBB;
	Tue, 11 Mar 2025 23:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741734997; cv=none; b=J663FfMPR5b62ZXRXi6Q31xCD8ZYcfyc0VnMM7aRoCfI73UDJvUMx6mz7ZwYdWDLJjXhwHdun4q+/ydRsbAJ3+3cmUqiYRkE+VJHk1PED00gLYOjxz2k+eVx/8rFvPJEtUYy3Ur0ak4jDDrPXtilYLnGjQW7Oa+OlfiS427LVZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741734997; c=relaxed/simple;
	bh=vFKn9KFzy4ZOURbADObnCPQdkfa71sW9tJpVeAApJxA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QaMGVkcRDkfScDiQX0e8eV3POmfkeuJYlWbPs9yIakfFjuBo4rwJsBesidvXImyjLScbS5TzxDlbyRGRY1YR6gXh+Ue6aDLqDpdUNfNFVXupFj+JmaruPGLpPs2XaZ6mLSo5DItWiPu00tCyn2edjF+mBYigPbnadreuHZoGsoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3f556b90790so1800684b6e.0;
        Tue, 11 Mar 2025 16:16:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741734995; x=1742339795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NT3ET2M4CvJfrjc7UtUz6A9ZzH+M6UROsJOl9KIGkA8=;
        b=cXbgyvuLOBMm7z5PON3aAC+uyUZyowaM+PxsH6IUY/5lSXe+XadSBiqUiAhVIcVlk8
         rQFUBgRvlauaybjbt1inzvHakS9r5BRxkRwVW+sv2hY3ctDdjmwXs35zs3jg5kIHYzXA
         Racvt9kxWnkr9Qe6ueYgUY+Omijvs1VM8DUwJz8pJ2y7qe7P2VhMy4em+0Xb5LKsIpAU
         IFEs0iWUf/+CMeB8ZOKVV9SOZEh/iCxlWwUlKnV/Lquox8cHnC9n5ABD9zXjbCoin/yd
         68mPJqnn/9dshLBoZPA+Bx3E5cQIk/0uqfIIaUOQStcumgJEi2TbQ+AyTGSB7UA9MSj9
         jqgA==
X-Forwarded-Encrypted: i=1; AJvYcCUYv0m2UEjfuSgqsHero+8haNnd+5HSbEy9iWHpWnKX/YuusyREEAMWBfUvy04+sZrrVuUQEGImZzeSLyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn+fYNCgdu9aIsaFaU5XN9G7QosHDOOvP/VbIQIRo4sXV378Js
	y/LJSDyAZ0//vR5bIC/m5Byx8YvTazHmNyr4CNkUhbD1DitAeD3b
X-Gm-Gg: ASbGncvF4JtqY9hogf7xKQ7hJDZqiklKLxpe891slRt1NBrNfaROpVnT2kc1SoRgIBs
	yrYdcvBaAGw+juL22gKUIS2NcE4VTx9/suhdwxbaO/TT6/LJtutY5QS4KJvGE3YDhHmEkvymoYr
	y09Ct6nbZMp1T0iOgzzk587+k+EnhcF934uhPs1xchE84PPYzHqtg8o6Q1vTfeCB3tZrBgwibD6
	TQfl7YEPHW53xR3BzHqI9hPYN9Ws8q68Ja93Rqyhr02poyl5p9IQTPsDoqPVp+f95b9z/olFRBR
	NNrC3/QAvV9rgFgEjW7q6hWpFLFutsCqERKBmY80mR9B2JCPoxEGNck88Xji6/KIZ9/rI/LG
X-Google-Smtp-Source: AGHT+IHvIh7HOKUF2kSTrwl4yZYSR9cniot7aBmMKPsu/SKTAalazf30n182yH5QwSl2BrLtR1sAWQ==
X-Received: by 2002:a05:6808:3996:b0:3f8:effc:938 with SMTP id 5614622812f47-3f8effc0cecmr5870095b6e.34.1741734995283;
        Tue, 11 Mar 2025 16:16:35 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f92706ce68sm868016b6e.26.2025.03.11.16.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 16:16:33 -0700 (PDT)
From: sean.wang@kernel.org
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>,
	Yake Yang <yake.yang@mediatek.com>
Subject: [PATCH] Bluetooth: btmtk: delay usb_autopm_put_interface until WMT event received
Date: Tue, 11 Mar 2025 16:16:30 -0700
Message-Id: <20250311231630.35255-1-sean.wang@kernel.org>
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

Co-developed-by: Yake Yang <yake.yang@mediatek.com>
Signed-off-by: Yake Yang <yake.yang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
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

