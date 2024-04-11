Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D3BC147
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712846540; cv=none; b=CJfhPMwEWX+HX62q9Ewd5NNrTdk49IONasp0K/cYb+ZaAMIQ6iJNgBsVsOpn8+Y5sIzudVItBqUhZoJIqr7mZp/mJXWZpkp3NvSdgjkAfTZJYIndOAUsHJNqimM6FBiXwdWKOXjvcPPWqg2qK4DtPLgoN5wRay44pWjyk54HFiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712846540; c=relaxed/simple;
	bh=z2tx8sW1CtMy/8L9ZNiITaD6OOUGKZvcmbqse8xrOUA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CwYWixJmG4jV4sR2Im/6PmnjKdMiwzEO/SF1DkRcGFBP3vmx9neGv+vCEIkRKSQmcL3kFYVXCJ+uPw35jjtx64Sy3YGb4xSOQVuZeIYml/jxelmjL+muHX1wION2DtH9z5wH/UNjyy4t0o4TxcCSDrVtu70DGSnWpu2ywwxjcL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRAkJXar; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRAkJXar"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7e7cf5cc1d0so535023241.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 07:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712846538; x=1713451338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WAzam7+xxR9ClMOmOyhrwQjSSR+VlXAULEGHlqEZeM8=;
        b=LRAkJXarCyR3WNE7/IPBd+SUnTXvDVVmt3iyUR9f5/g3j3xa3o5DlDu0g2JfgSSjdI
         1dZ7feiFUC0Bi24VuY5+z/LvEXjD1j0SQjdMFbOygNPGYEMF7/M0Khw7Bd3MYGF5XcWy
         GuuYag4eEQBBKI4ThmBL2m9gJAHq2sE1gDwkfyvHTPIRcbQEYzPwg2qg5lE0cG0LdMx2
         Kfg7bOfYyAE55juaUl36MVH/RTjWOvoyP/DGvUGw2+jf70ChDdvKq4+l0bbh4Q40RoT6
         fbrJRmWK3wqzpBBCxps6G5KCZ0uy5y89P924D/ZLrhatOr+2rlLEyFaTgjZFyggVVMaO
         23Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712846538; x=1713451338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WAzam7+xxR9ClMOmOyhrwQjSSR+VlXAULEGHlqEZeM8=;
        b=QF9TJIP+Lpq1RTJCzlHALaL0/JUrMRzeudyUOjqOZAlLRPWS1OGrYzml9sH6h8+kSL
         Vegm+UkVZK0aL2K/suu3p4vldURPJ987/WiNjatKpxcVT8Gbaq0Q3FdPl1pxaYcF2dB/
         SuTRrCa5Kead1D/7ukPApsBmKfQRUPW80IfoyxbNnPO1T5FBu3s9bquPWM7OMNLNVO0n
         xVBNAeDizaN9TWNUXXFHwbwRtWmogKLnKXqBfiYsPUfM9KnNF5HkljXWSHmBq7yzzTor
         hxCg/o5uC51+2SQBVWazYM2qRya4ws2ay8XPbobTYQhqvJV9DzPax6oee/WT0xBMDj74
         lUGg==
X-Gm-Message-State: AOJu0Yw/FlnNxyXAOc9kqyscADSC/8VmVeqFVfzw2nlF28AfNuVKpJmq
	0KHvqtPXTRyqnDHxksiop60MeyfVk0N5psNNUuxZUKDvBp6FzNWv+HSd7g==
X-Google-Smtp-Source: AGHT+IHLRmHDsoHKQ63qOhKlhiGg+o2aKHq8d2a3lw4I9OruJJjqvxcbYL96eUT33aojxt24Cep4ig==
X-Received: by 2002:a67:c487:0:b0:479:f383:1927 with SMTP id d7-20020a67c487000000b00479f3831927mr2464004vsk.6.1712846536818;
        Thu, 11 Apr 2024 07:42:16 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id p2-20020ab05482000000b007e818706332sm93535uaa.30.2024.04.11.07.42.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 07:42:15 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/2] Bluetooth: hci_sync: Add EXPORT_SYMBOL to hci_reset_sync
Date: Thu, 11 Apr 2024 10:42:13 -0400
Message-ID: <20240411144214.109478-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds EXPORT_SYMBOL to hci_reset_sync so it can be used by modules.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 4c707eb64e6f..908de8df5599 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3486,6 +3486,7 @@ int hci_reset_sync(struct hci_dev *hdev)
 
 	return 0;
 }
+EXPORT_SYMBOL(hci_reset_sync);
 
 static int hci_init0_sync(struct hci_dev *hdev)
 {
-- 
2.44.0

