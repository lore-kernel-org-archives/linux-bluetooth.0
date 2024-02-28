Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5270913541F
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Feb 2024 17:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709140727; cv=none; b=jxV4Q7Ja9mmfKYLD0VNLqGSYP4p8r1R+3nFnbZk9ehbHydbqIIzHS651H0SCQrjBOIfXK89dcfvJIAJD4Y52t3+3K1sX9EA/6ElUfwOjM0QtUvwZFse2ouS3I4ZhxzSbJhP94C+qn3h0ht5PKCVawbm9LzjyC/c9NBLo8Af33Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709140727; c=relaxed/simple;
	bh=Q7ZH8bzPPKTfWUksDeKP0xIJaWEn1+Fr0DTy+Phjze0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uu0niEg0bPaiPKIzNA7nPltzzWcS57tArGR3oTzsqjPobQNNG12JWaTCGHYmZom5mIzIYGns3v8gRBi2pYhs1OiNwrnR5Uu+owDVRrzPLXZ2hx8e3L5Cm9aHpy+DgPUFHIQV+VjyjsIm2PhV8FPgQDFRU9Q+5rxubCwF3iBNjKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSJzP3AL; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSJzP3AL"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7dade974b0bso379726241.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Feb 2024 09:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709140724; x=1709745524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=felDF8qgwj7K2wUORV/pZCWpVpWKyzHzAB62pSQGbmI=;
        b=FSJzP3ALtcMxxz5xK80bykTO03QyTAqDgxp1uHT5hEzZx6riJCSemWa8VC1npDeRSC
         EhLo9dmJsQ7X2Fb6EJk3RNMFjQ+trLyHTvJp6IfRGpkJnfEeIvVx+UZXXgN3vV/BdXAF
         slv2y9xVWDGEgSPMcy6/Qv1P4pJ6y/6QZB79dYkjXyXiuOUqN2ebKugFSc5RfiFQnPBH
         tZur7Lz9TO/JfKH5DinCv+5YYlZ3Cv1JxBR3i1qAgajMSK4CXyHMFE39evbqIa9zRhLz
         fLV3jANGm7+iABqAdeF+ZToUPYFM62P5zcF1xkSrMTQQA4E14ErzZTkKWrzcF4FsorI0
         IZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709140724; x=1709745524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=felDF8qgwj7K2wUORV/pZCWpVpWKyzHzAB62pSQGbmI=;
        b=fcR2iPTd2iUsl2Ivp8WjLGsF/EAlqe9ZRrtyv1XXm3bErhOq4C0tnpRPNlhVK1YV/m
         MJ6uOmtaWTY2Lz7PIlD9PyGo+V9gFHRo1nVPNACFjyO/rh/32ITgYMgj2jE3jZWXSQhg
         HA0prYrvYLbBAf5ibsfC/Lor3x6OlgRYPFr6D6ODkdZ+JkRocQRjZVSlQigkNRrPYytZ
         AhOVGo4BxGIOYUSeA0dKTTrIBNQ0Mmf62mNXANXdRM5FziCKobl02o8oMihOf5zdM0AM
         W3XQOtDUp8V0Hsd7Xl18m+kQKyEdiCpP2LmXFM0950WEPXP7E8ES5aFgB3GjNSGJ2eNp
         yZyw==
X-Gm-Message-State: AOJu0YxR3FkQc0Mlmk18oCKQH8se9FkhfW7w55xpatv8wrXkdhUw9i8g
	Zz+Pd3A+cIP7Q9Aw6GgSxYYSCa6jl44ugimDj/O9j5VmNjpWM9spmzPGzsdC
X-Google-Smtp-Source: AGHT+IGBpPPHofmQo1M+gIgPca8qpNPvQJ+WSOJiHHnUxXo8udeAZGh7v7qm5wzy5CFObRRHHeLVIw==
X-Received: by 2002:a05:6102:3709:b0:472:623b:75ba with SMTP id s9-20020a056102370900b00472623b75bamr146284vst.2.1709140724058;
        Wed, 28 Feb 2024 09:18:44 -0800 (PST)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id q15-20020a056130028f00b007da5ea1638asm1488240uac.1.2024.02.28.09.18.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:18:43 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 3/4] Bluetooth: btusb: Fix memory leak
Date: Wed, 28 Feb 2024 12:18:37 -0500
Message-ID: <20240228171838.2414532-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228171838.2414532-1-luiz.dentz@gmail.com>
References: <20240228171838.2414532-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This checks if CONFIG_DEV_COREDUMP is enabled before attempting to clone
the skb and also make sure btmtk_process_coredump frees the skb passed
following the same logic.

Fixes: 0b7015132878 ("Bluetooth: btusb: mediatek: add MediaTek devcoredump support")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btmtk.c |  4 +++-
 drivers/bluetooth/btusb.c | 10 ++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index aaabb732082c..285418dbb43f 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -372,8 +372,10 @@ int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)
 	struct btmediatek_data *data = hci_get_priv(hdev);
 	int err;
 
-	if (!IS_ENABLED(CONFIG_DEV_COREDUMP))
+	if (!IS_ENABLED(CONFIG_DEV_COREDUMP)) {
+		kfree_skb(skb);
 		return 0;
+	}
 
 	switch (data->cd_info.state) {
 	case HCI_DEVCOREDUMP_IDLE:
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d31edad7a056..6cb87d47ad7d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3273,7 +3273,6 @@ static int btusb_recv_acl_mtk(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	u16 handle = le16_to_cpu(hci_acl_hdr(skb)->handle);
-	struct sk_buff *skb_cd;
 
 	switch (handle) {
 	case 0xfc6f:		/* Firmware dump from device */
@@ -3286,9 +3285,12 @@ static int btusb_recv_acl_mtk(struct hci_dev *hdev, struct sk_buff *skb)
 		 * for backward compatibility, so we have to clone the packet
 		 * extraly for the in-kernel coredump support.
 		 */
-		skb_cd = skb_clone(skb, GFP_ATOMIC);
-		if (skb_cd)
-			btmtk_process_coredump(hdev, skb_cd);
+		if (IS_ENABLED(CONFIG_DEV_COREDUMP)) {
+			struct sk_buff *skb_cd = skb_clone(skb, GFP_ATOMIC);
+
+			if (skb_cd)
+				btmtk_process_coredump(hdev, skb_cd);
+		}
 
 		fallthrough;
 	case 0x05ff:		/* Firmware debug logging 1 */
-- 
2.43.0

