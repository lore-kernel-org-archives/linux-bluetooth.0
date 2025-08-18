Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9C91DF73C
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Aug 2025 20:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550092; cv=none; b=MSt/n+xGAAavC9lIC36F30+eJKjBeB9ki+ZDEgwEhRaPicuOU2Vvzfr1sTBqzQqK5Z1ZkmYcg/cqcQmnMswlehsY4Xv2rU6J6sItmN3T2403ebp0ddo5M9DG479pCrBzptaoanQIFLpye09QzRhOQ7B62oCPJCO/P+4OUqW8Ezc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550092; c=relaxed/simple;
	bh=U6DMXDDka9JL3cI1Dud3UrwyI3E+9z9qgsLpSWTd0xo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TH1jxZ+vixEdusZda1G8z+0LxGLMsXWxHmCumbvo4T3gmOE6MKd/BPNo58oukR2jrI6R4G0iIlryCy3atiwaRsLRIbQkQFMK/3YXlbXbH36cgn+aRNJo8iSl+qgjgzjBCK+b4HpTzB0XJSOCvsXD8MdAlKShcOvSHxi29vzBDO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVRE1UCB; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVRE1UCB"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-50f88cd722bso1360107137.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Aug 2025 13:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755550089; x=1756154889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uKeXikMdbGomAkcD+oMdTSPhvPrbJuo9ZEtpNO4Nx/Y=;
        b=RVRE1UCBwUGEQsnSTKlmkdqqwBbbIvnBkc8vdEzsGfPEARHf4vhxLGBmzGNd1Qf8Hz
         ltOHubiEOGXvtEBDpkHuwziNnJhmUQX1HNOTvmho8L8Zcd3MFDYuu60mJxvYHfe1Ywmk
         CW1MMXMVzQnf2U8Jpy8wTK3ef4lDWVzGrPq9L/HWNvQIzXy7UkoB5kDyEYwjWNoIsnTd
         g9WHQZrRI6jpWwy3d4u29AngLQOgThYq2cLw1nfxweP0hE+vZE/wC2RlJ/EsActWjcEa
         LwI2jeliD2gmRviRx4k/sTDBedPMgevJMYXIMWlYQ2Ps+55HRqkF0PXqrfdZvqq/FDM6
         XxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755550089; x=1756154889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKeXikMdbGomAkcD+oMdTSPhvPrbJuo9ZEtpNO4Nx/Y=;
        b=QDMtU/Dbw7yw53nZn9WhowoWpXes6Q2npxiun2/1UA+kawe9YodcVGm+8tKJVRSJXJ
         U0FOkzAO/yBfX9ppK1Nv4vjl7kI1534ohjxM0ljWfZYTyzR4NaP140aX2f02w+ImiWFL
         6m4l40OFVra/RrH6ZgBts5SjHER7luUvFxz1qz9esAR2lDNfSUVmzdyoczhc4HckmkFT
         twpLNqlTbepm4rXQAWtRB394YSc1wDCZm86j+pPy75RfR6RLQFp5Yo6CKXSBonymIyTJ
         z0lfRiUFVgOMpZ2H4BUv0SbfrZmcJxlB2VhYBawl879GdpZXBeuZRnbzxxQvDsxzEJkB
         LYsg==
X-Gm-Message-State: AOJu0YzUQgrji1N/TdTd5DrwxfinNMP9E5QpidM41WEYA9hom2dH6hpR
	Gj5WcNzxSaA5+xLvLPQVBVNp2NfuIaiDrOEUylQX6RRNjsMCP79Bb4Z3Yu6FVqu5
X-Gm-Gg: ASbGncssyhf7hqzNp8NhCb6LAWEt8BvBkeVMQQjbWpoZtXrZRI7kQ4sSc4RNOFfXy9A
	UR77jPD8YxYHLl1HNs37futidzAdSua77Nsm+4OYivIXbNYXzCDVdikB9v2D54FlMc2GtgLtYA5
	HJCqQR8KB30fmi0MG/rZ4c/foBU8cGC3mDZ2xknwmFr9NEYEtVCgjFPbP7f3EWD9Mfd09azp8l6
	nduqIOO4rGf43/HPJkj1FiexwTn0uIPQe5KmLW04PEOi6dlnH3IcoUgPhvXdGmjU5cIXST/gCCy
	MosVTxY8GbQJ7tjVk/iOC7O8q3+HWSUqnEQaW1XyYthfbOodnnhPtgsmItRZg+oZx4fDqO4/IVI
	UJ2LL8T8+TLhXVrTehFR4RU43rYXxEC5pdpvMsAaEByritWFv3qBJ0GyT3hqqsPSoR5L+Ew8nr1
	Y=
X-Google-Smtp-Source: AGHT+IHu0iwo8Roym231v/vl2UdECZwVl6knqeNDwxDefwtiOKTOjNDEr/CKukUxg/W03LQnNt+m5Q==
X-Received: by 2002:a05:6102:8021:b0:4e9:91b2:c74c with SMTP id ada2fe7eead31-518f5a5ef0emr184378137.14.1755550089549;
        Mon, 18 Aug 2025 13:48:09 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53b2bd553casm2101079e0c.2.2025.08.18.13.48.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 13:48:08 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 5/8] Bluetooth: hci_sync: Convert instances of BT_DBG to bt_dev_dbg
Date: Mon, 18 Aug 2025 16:47:50 -0400
Message-ID: <20250818204753.1203949-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818204753.1203949-1-luiz.dentz@gmail.com>
References: <20250818204753.1203949-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This converts instances of BT_DBG to bt_dev_dbg when logging to a
specific hci_dev this is preferable since it does prints the name by
default.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 31d72b9683ef..46c20476dae5 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5189,7 +5189,7 @@ static void hci_pend_le_actions_clear(struct hci_dev *hdev)
 		}
 	}
 
-	BT_DBG("All LE pending actions cleared");
+	bt_dev_dbg(hdev, "All LE pending actions cleared");
 }
 
 static int hci_dev_shutdown(struct hci_dev *hdev)
-- 
2.50.1

