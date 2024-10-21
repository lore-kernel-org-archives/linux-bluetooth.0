Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6451D2B30
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 12:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513521; cv=none; b=NZP6r+GsOl4G5VAsvEL9fPkWUIRsa4eQnM/t62G1PCrKP0CrShaVfzBvfiAGKWRmMhEVEAP4nwUDfvNWGFYUBLoRyDPIh6IWvihoayzknSx5nZJ0l/5k8y4uC9AizV6ScQFqiD+GBNch4npjJiZHZ8VptiDn1xjbyYR7FBjmAtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513521; c=relaxed/simple;
	bh=z8QLtaf2HV0nB4pWA8w/hDk459V8SWnfayOhWuOx8PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+KI5gqnTSWsUMecowfWzCXv2acN8QrUTCOjx89g2PsnqqUw9z5Y3IMP2iwwQEcphr2jLI5x8idOeiMHQGMw6sjNqQgGiv3F/yqOprD/cC8FnGxwo6isEFxk1svdAaihMjKlMx8ExwHUA7ApXKaS4ju2BhuQn/wQ6xMLtHUfwXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGp8/VOE; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGp8/VOE"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f4d8ef84so4464498e87.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 05:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729513516; x=1730118316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+bvq4LBKer92wGB1irQ9H2szcRsOrHNYpz/SwdgEls=;
        b=BGp8/VOEcxSXLUiUQoa/5q/fI7MIBKvYuBzmqgoAoBQK+tREG47riKOmnA0m+WQ2uf
         PraSIk4Qls6UQUW3kvhQccyiEd9Lpgn9RFYSCJ44lOrOpRWmBen+hlEvKuic67gJXifW
         ET798YLXCBVQJmS2QsDSEGE8ydndTGr9fjb7qQE0mxb9SYti5Rs/q9Uo/4mtlNZNfyLS
         czeCbUTPqnvQQmVFUG34KFkWCFcrxND7n4TctxuT4ThUqJ/MeiseB06ZiJnr0v696EM2
         8JsKGKTO8XEtnh5XsUnKCymsWZP0SWw84t2RY+r1osV7DPNWrS9LX5g1cIN5rNaNVwxM
         0d3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729513516; x=1730118316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+bvq4LBKer92wGB1irQ9H2szcRsOrHNYpz/SwdgEls=;
        b=RpdAj2pJTeKTWtvXOEtv1tLRxMijlqTBJNRg1YENLlIlsNz5SyPNOcgaYjRQr84eGh
         7nfuvlB4x88iL0h5sXIWBGoTCwkIrl8FHDudS15HrUdOAgstv5BWeY0b1CfwUT0eiPzv
         Fw5wG4na8dy6AAjZ1Wxi+IvTFLCnOJL+qzh4TcVGvFtOLU/zHaKWdWNYMBmMEY6yxOJH
         rFx1OhRwPobb7qm6FsvxF8dyNus5fUlTMzWFDQbO9rgh0eI3EzOFuy/SvqS5/ns1nXxV
         LNFm46BkD3gdOQIrT0w2qC39kth9e/7RVadX6JuSbTN9n9IYVLF38PnpnnwHDII8aYDV
         Ej7g==
X-Gm-Message-State: AOJu0Ywt5CiYPpYFFG05xedzT2/UBGD2bdF+it/so8Bkhi+lKkDmy8Jv
	BieAeQ/u/RQY28D4Ht9hkatsBa89mJ0rekAEOQlh8c2f6Iy21dkmfwAetl+yEdk=
X-Google-Smtp-Source: AGHT+IHcaTBgWpcVyTLGJu37MnhtoQkoted8NxP7KnNvqiffZcDwY8oPTyUP+34hom88T9sr85armg==
X-Received: by 2002:a05:6512:3a93:b0:539:f36c:dbac with SMTP id 2adb3069b0e04-53a15441a99mr5383789e87.4.1729513515863;
        Mon, 21 Oct 2024 05:25:15 -0700 (PDT)
Received: from ha.lan ([185.52.141.89])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223f02c1sm464015e87.111.2024.10.21.05.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:25:14 -0700 (PDT)
From: Danil Pylaev <danstiv404@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: uhrmar@gmail.com,
	raul.cheleguini@gmail.com,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	Danil Pylaev <danstiv404@gmail.com>
Subject: [PATCH 1/3] Bluetooth: Add new quirks for ATS2851
Date: Mon, 21 Oct 2024 12:22:44 +0000
Message-ID: <20241021122246.1569235-2-danstiv404@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021122246.1569235-1-danstiv404@gmail.com>
References: <20241021122246.1569235-1-danstiv404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds quirks for broken extended create connection,
and write auth payload timeout.

Signed-off-by: Danil Pylaev <danstiv404@gmail.com>
---
 include/net/bluetooth/hci.h      | 14 ++++++++++++++
 include/net/bluetooth/hci_core.h | 10 ++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index bab1e3d7452a..4f64066915be 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -300,6 +300,20 @@ enum {
 	 */
 	HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT,
 
+	/*
+	 * When this quirk is set, the HCI_OP_LE_EXT_CREATE_CONN command is
+	 * disabled. This is required for the Actions Semiconductor ATS2851
+	 * based controllers, which erroneously claims to support it.
+	 */
+	HCI_QUIRK_BROKEN_EXT_CREATE_CONN,
+
+	/*
+	 * When this quirk is set, the command WRITE_AUTH_PAYLOAD_TIMEOUT is
+	 * skipped. This is required for the Actions Semiconductor ATS2851
+	 * based controllers, due to a race condition in pairing process.
+	 */
+	HCI_QUIRK_BROKEN_WRITE_AUTH_PAYLOAD_TIMEOUT,
+
 	/* When this quirk is set, MSFT extension monitor tracking by
 	 * address filter is supported. Since tracking quantity of each
 	 * pattern is limited, this feature supports tracking multiple
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 88265d37aa72..94ddc8684973 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1871,8 +1871,8 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 			   !test_bit(HCI_QUIRK_BROKEN_EXT_SCAN, &(dev)->quirks))
 
 /* Use ext create connection if command is supported */
-#define use_ext_conn(dev) ((dev)->commands[37] & 0x80)
-
+#define use_ext_conn(dev) (((dev)->commands[37] & 0x80) && \
+	!test_bit(HCI_QUIRK_BROKEN_EXT_CREATE_CONN, &(dev)->quirks))
 /* Extended advertising support */
 #define ext_adv_capable(dev) (((dev)->le_features[1] & HCI_LE_EXT_ADV))
 
@@ -1885,8 +1885,10 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
  * C24: Mandatory if the LE Controller supports Connection State and either
  * LE Feature (LL Privacy) or LE Feature (Extended Advertising) is supported
  */
-#define use_enhanced_conn_complete(dev) (ll_privacy_capable(dev) || \
-					 ext_adv_capable(dev))
+#define use_enhanced_conn_complete(dev) ((ll_privacy_capable(dev) || \
+					 ext_adv_capable(dev)) && \
+					 !test_bit(HCI_QUIRK_BROKEN_EXT_CREATE_CONN, \
+						 &(dev)->quirks))
 
 /* Periodic advertising support */
 #define per_adv_capable(dev) (((dev)->le_features[1] & HCI_LE_PERIODIC_ADV))
-- 
2.43.0

