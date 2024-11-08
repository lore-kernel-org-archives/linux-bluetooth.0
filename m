Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C674208C4
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Nov 2024 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731083175; cv=none; b=FbirnVqhWNxtHD0LXiwphjCmfryZnCKidoS2T/uqs4aWEfzcQhsy3kZnPOQF8K7rm2SOJzqBMTiWnUQpjbwVDN4e9gHDXAc9xarFTqsszE5As4I8U7TmP12NFjgpYIuOafs2vj0H1IRd85GKa6AhFxhaGAkzSBblCBGqFn+vNgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731083175; c=relaxed/simple;
	bh=lTmRW3wV81KivDfmlU9hT7T4YmeTRHkU2/k51Msdw6g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=I2rpJiWidoMTBDlpewRgrzE3Ds29CvP4VL/rDAmbz/qeJG7my3mLS2Ve5bi3FKKTupJqnmS5eTIIvy1YmYD9b/5xZoa8Gl0dgVXI3xvkSp6bnlPMeTCaePj9XcPY1u5VDqnvvuMljqUc4sslU6guoQ8TNT1BKzgkIC7lBzc1y2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aE+/F527; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aE+/F527"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5ebc27fdc30so1287009eaf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Nov 2024 08:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731083173; x=1731687973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=N4QZDTR3MQKE9cBljWo+2yICAL2lJ5inYrxb28Q45IE=;
        b=aE+/F527OuXAKO9DPd4jhwp4SYvAC7HVhiJzm1pZ+m7TCwwk1v5DI6rlUIM8qYfuNZ
         E9mt5TjSgXZgMGLhoR5FWi4vS5/hZLxFshaKRL6OzGPRmx0RnhapPzHxEmIZt96ToGhS
         tZ56lQoaF9xCuMIXd8FsO2iCbJDuD/l2+535I6neLT8HNP5pOJFdYBdAAl303ImVQGfM
         P8y71PXGi90N0pLdGyBFZwY8v7Hd7QtVH8hcLsQBjMGWVjOzc2UFvMxKH8DZyIXaY7DL
         gKWWae9pLP0vQDHxNuSX3+JlgiwyghGdtJpCuFfxp9TDGFnx7dtAb96Mxdwnl8Tnj/UM
         NJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731083173; x=1731687973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N4QZDTR3MQKE9cBljWo+2yICAL2lJ5inYrxb28Q45IE=;
        b=v7Qvr/2wQNNVA5f50T9XwxrJidlt2rlaJZN7PZD8PAc3n59NdenMwJZPwd/yCdY6cg
         WG/Nxf4Y9u6VHW9DRMmIk80pAZgO++5QvQnzTUzFAUmwuHiRqntiIIuBij393SYXN1zV
         V8yyZ523j8wv8nzD8JK0eKpZ9WZChYiNEH9B1c7STDGxpx2BjxkWnhFbDr8n5fQlbMmx
         g10Sf7mAQOj1oGDK+yI42U1YbaTpsKGPfRKZR43CtTmhGzeNxj7NPqaskFsgPU/zAfxH
         MihTEXJruME25Jm9D75sCnUqS9AGLw7OMD72Qn+gbGdnw+yHwPOCmDlxFgcKfLibzs8I
         NekQ==
X-Gm-Message-State: AOJu0Yw6yd8Fhb8Kf4tl02l9nvcXUaO+I3byS93ToYeGiRzslFW2ok6B
	FHCnVYPTA0j8ToFd5DJWOBV94Bc5bekj5FxwR3cCMAaoNyCniYDzDdc08w==
X-Google-Smtp-Source: AGHT+IGQCmo5XgX3/w09f1lxhS3NHVSZRrbLg7iuTdwrMZfMgZUynjx1Pqp35YLZEL00r5IJgKE10Q==
X-Received: by 2002:a05:6358:848b:b0:1b8:211a:e7b3 with SMTP id e5c5f4694b2df-1c641e75181mr271760755d.5.1731083172731;
        Fri, 08 Nov 2024 08:26:12 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-856557e0498sm721524241.36.2024.11.08.08.26.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 08:26:10 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_core: Fix calling mgmt_device_connected
Date: Fri,  8 Nov 2024 11:26:08 -0500
Message-ID: <20241108162608.262188-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Since 61a939c68ee0 ("Bluetooth: Queue incoming ACL data until
BT_CONNECTED state is reached") there is no long the need to call
mgmt_device_connected as ACL data will be queued until BT_CONNECTED
state.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219458
Fixes: 333b4fd11e89 ("Bluetooth: L2CAP: Fix uaf in l2cap_connect")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f6cff34a8542..f9e19f9cb5a3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3792,8 +3792,6 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 	conn = hci_conn_hash_lookup_handle(hdev, handle);
-	if (conn && hci_dev_test_flag(hdev, HCI_MGMT))
-		mgmt_device_connected(hdev, conn, NULL, 0);
 	hci_dev_unlock(hdev);
 
 	if (conn) {
-- 
2.47.0

