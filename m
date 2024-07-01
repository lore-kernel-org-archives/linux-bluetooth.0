Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9137316D328
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jul 2024 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719850266; cv=none; b=TmdLcBkHVipxHggCgKBDwhYVQbkpoiPMzn6bXblwHlnBcCiMYJGeVxeB4iMUqFaVmEowJsi4MUddI/X+hgzB0kzlbt1uTSwmYZTppCAhEmg6YA1mVlCmY+d+otEjemc7RcjMN2oZpyUiWTCu59PtitxIRD5UFTa43kMXGlcV0gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719850266; c=relaxed/simple;
	bh=36RcU8IG5DFGJrrYfvCJQTz0Va8nRp388pQsHitaIdc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LLWniqD45nqtEqQJo2CwbXc9Y+DXtpdjDf0AlC2BUCqJXlhDHCbQyhjSKdgU0w9rM+omOfflj5k6Vha2Fs1elXWoGB7qk1yJg/Bh5Jdd9n+wq0mDzOG/QXPfFzMX4ke0S01jbGwJKM/6yU+2B3Hc4Nepq9c3EGRav+3/b0peq/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+jbWtMa; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+jbWtMa"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-80fc4fe7a8eso1581573241.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jul 2024 09:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719850263; x=1720455063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=l3WLfGdKEkxx+aJkR8A5WpusSlI2aKjMQ31oAdUHPFQ=;
        b=A+jbWtMaL/3Vdk7VmqC6zkpWzdVviduT3hEjaDsAS5fJQ8vocNKJoylaeft3Qvbrhl
         NL3gfyp2tvKNBT9jeWoG/02KrW/iGQXNHDgsKDCb5EAJAt3pb1zv8MK512+2zYlAY5UL
         sS5rC9KmiBUUxDtvbXrwXZndZTghyIdFk6c4Gjk7VygKR18wAdEUXCafnmL42om0Fv0q
         9piMSCtglBhG8AGuuUMR+vfiLIXkp46xbmxM4byHik7rZqtj7iJVqvcTMj7I7GJ7f36d
         a0GtC1xpOjwQMnv05QlsI1407QPA06FWWIdPAuI4JR1mzG8GVTyKYQosj9DRz5sz3WYo
         w/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719850263; x=1720455063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l3WLfGdKEkxx+aJkR8A5WpusSlI2aKjMQ31oAdUHPFQ=;
        b=VypL9B6n3NqRKTSJ7phW9CrFqPO0wX/n8nSO1T/CP4ifrSer7RnFTI4yoT5TSkL1R4
         /8PulmDvrC5JS1l6BMDQwEUk6b2PZ87xGpAPYsOR12IHEGt48cL5V353Qo4PvYg+2DDc
         nzyHkHeINPhjCoQScU79jUyqp2ytw9Rxv2qbQZYDGGucbDkh8tvIbQrTvXfdG1Bhad6F
         4FcyBleWpU9XEgd6yebLp+gH484soEBoqiwqgr++ks8Imr03id/P19YTGFyuGs33Guhm
         605zdeGJzFzaLAkIXM4BEvpmBZaeENclwFyDAM0N3nvJFxfWfgwgT0I/ERxx2R9gKjRm
         LLGw==
X-Gm-Message-State: AOJu0YycdBd6Kc1+TLLtSSs2nISxzGKieAj2DODJWOdjhmmubHSoTsnd
	0erUVX3/3QKQiSpYCPg6hDGSWW+WoDrydoagzqNN1MX1Fg1L2JNDqI5N+A==
X-Google-Smtp-Source: AGHT+IGeuYhjs5vHDY/tzeXtEVjP9+IqhFlha33N/Pd5tCxvkMlVQoAqyGX3fIBoi/cp8iO9yI7itA==
X-Received: by 2002:a05:6102:3546:b0:48f:1adb:7e54 with SMTP id ada2fe7eead31-48fae8c9acdmr3897428137.9.1719850262758;
        Mon, 01 Jul 2024 09:11:02 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-48f9b20bd25sm1433491137.20.2024.07.01.09.11.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 09:11:02 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: Fix usage of __hci_cmd_sync_status
Date: Mon,  1 Jul 2024 12:11:00 -0400
Message-ID: <20240701161100.1317685-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

__hci_cmd_sync_status shall only be used if hci_req_sync_lock is _not_
required which is not the case of hci_dev_cmd so it needs to use
hci_cmd_sync_status which uses hci_req_sync_lock internally.

Fixes: 6851d11d389c ("Bluetooth: Fix double free in hci_req_sync_complete")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 144e85ebfbdb..db9b9bb7d74d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -718,8 +718,8 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 
 	switch (cmd) {
 	case HCISETAUTH:
-		err = __hci_cmd_sync_status(hdev, HCI_OP_WRITE_AUTH_ENABLE,
-					    1, &dr.dev_opt, HCI_CMD_TIMEOUT);
+		err = hci_cmd_sync_status(hdev, HCI_OP_WRITE_AUTH_ENABLE,
+					  1, &dr.dev_opt, HCI_CMD_TIMEOUT);
 		break;
 
 	case HCISETENCRYPT:
@@ -730,23 +730,21 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 
 		if (!test_bit(HCI_AUTH, &hdev->flags)) {
 			/* Auth must be enabled first */
-			err = __hci_cmd_sync_status(hdev,
-						    HCI_OP_WRITE_AUTH_ENABLE,
-						    1, &dr.dev_opt,
-						    HCI_CMD_TIMEOUT);
+			err = hci_cmd_sync_status(hdev,
+						  HCI_OP_WRITE_AUTH_ENABLE,
+						  1, &dr.dev_opt,
+						  HCI_CMD_TIMEOUT);
 			if (err)
 				break;
 		}
 
-		err = __hci_cmd_sync_status(hdev, HCI_OP_WRITE_ENCRYPT_MODE,
-					    1, &dr.dev_opt,
-					    HCI_CMD_TIMEOUT);
+		err = hci_cmd_sync_status(hdev, HCI_OP_WRITE_ENCRYPT_MODE,
+					  1, &dr.dev_opt, HCI_CMD_TIMEOUT);
 		break;
 
 	case HCISETSCAN:
-		err = __hci_cmd_sync_status(hdev, HCI_OP_WRITE_SCAN_ENABLE,
-					    1, &dr.dev_opt,
-					    HCI_CMD_TIMEOUT);
+		err = hci_cmd_sync_status(hdev, HCI_OP_WRITE_SCAN_ENABLE,
+					  1, &dr.dev_opt, HCI_CMD_TIMEOUT);
 
 		/* Ensure that the connectable and discoverable states
 		 * get correctly modified as this was a non-mgmt change.
@@ -758,9 +756,8 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 	case HCISETLINKPOL:
 		policy = cpu_to_le16(dr.dev_opt);
 
-		err = __hci_cmd_sync_status(hdev, HCI_OP_WRITE_DEF_LINK_POLICY,
-					    2, &policy,
-					    HCI_CMD_TIMEOUT);
+		err = hci_cmd_sync_status(hdev, HCI_OP_WRITE_DEF_LINK_POLICY,
+					  2, &policy, HCI_CMD_TIMEOUT);
 		break;
 
 	case HCISETLINKMODE:
-- 
2.45.2

