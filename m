Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7A318C0C
	for <linux-bluetooth@vger.kernel.org>; Sat, 22 Feb 2025 05:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740200858; cv=none; b=BR7YB+CanDgYb9rQoVRibTL1mKQlk6G8A62RIvjRqerxGIKBqVHAMC4+diOnkooVbeZkMKPC0+HOUf1Vj6FAtEwJ8eYBz40q96Vlmfy5gja7JVZL6Lbz8ylscx/YBN2e+5u0MuCt9xc7dSiimdGOespbrt+BNODA4T3d060WkoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740200858; c=relaxed/simple;
	bh=AZGoBqaIToNAQem+7Q2qMaSVXhEXqaGfeuRKhHJ8lUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftztMMgiamIemxXrfsQno/aqCeMm5frzhap+crDN0Qt87wXhBpIfmiiw+X4TRPZUOdwZnfnWOnT+5Y8bc9OGlhg1lYbD6XOTd9JNbLiYMRo+6kvYpko4KRniHsBDIwqeuuHmqFlIZXDgrxw2MCc3PVVfheI062sAhnlie+O+430=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBCeZHLS; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBCeZHLS"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2f441791e40so4454404a91.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 21:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740200856; x=1740805656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASgIoc7mLm8FGBKrKVZWao7J0F0383McnLf5Mgv/XJA=;
        b=FBCeZHLSxiwuDIHW6RtnIln0l8mHMFQy10SyQ0YvjOerGoHlmIzVWvxy1VgaP1vZU7
         RiIZPHS34xcZJed1LFOciEBgfQ3MPqKFooRFbvTlc+x/pjd12zqd59UCvRxkvUJtJMdP
         KqQUcOOOz5M0+jA2MOuvsDqTka/PuDJ3WSGdH+1aK6cViuM9LBAol4w87SAP3L29GdjF
         czUEXz7ow5muBIp+oamllHhwXK0IdhJESG5ZIyi9Wk1ByiwYeFXX5NhGU1NNEDVuHCt9
         Y8eVfRelOl0hAf2kvPt+9qluIYZlESflV9PJlmKmEsoytBl03Prs6sJ8BAEqIBIx+t+u
         hY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740200856; x=1740805656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASgIoc7mLm8FGBKrKVZWao7J0F0383McnLf5Mgv/XJA=;
        b=I9IkN7qzQZWQUH1hZFMA92CWDk7qwAjkZuocaZICLJ6WQEYh/tod6oKMm9HCMLrrDk
         Guy1vkP0+92rj690ff0RDuxOE4bMETLL8q4WRvr2xid6saCgjlhDPEYNXXO9zQ2zKISm
         Rg5jDETit50bCENiGp8dgktSXd+VQTCKP63YXga0PONWrVCcZWKOy9CJM4tI/b+bWCXc
         ei4WfyH5iYyO2122R5S8/xGy3rofGHLvE4pLuQn12LvnDo39NKM/FIRJXRuLZ3sL5LzT
         kaL/igfoB/7pAYJasRkESY4NZhQ06vdFLa+EMUoiVda2zGSRT2FnTa7ubUQS2juEzGiG
         7/mA==
X-Gm-Message-State: AOJu0YxA30h7Au3oqHO61rRfJpdSHZ3sXbHwCoMoftAYig8uKDil9VOd
	pFobYsLyY/vCDPvYp15VU2nEkTgBecrSPQJSQ1exZifIGlBNmj2ivC+xCGNg
X-Gm-Gg: ASbGncv3KcuOziu5q7Q+riTpgGrRFOmzGtw6g7tm3sUcekbSbPgOeLS63f5Sa0QbjXa
	XBXPcocqGlTdLPOCJyfkMCZIFEvbQC8SVGviiVtKTxfG20Z04XPdBJlZKNfUJihjCW8d/kwGiG0
	gEdTJhqIXC7O2XynXzQAiy1nhlMh2eOUR9evv4LSqf5HbKBcNE3E5yxXyXO3I4u50hs/0OeYGVi
	wu3UBJQ0OYAu9DBBixm+9qCucAR3ALA/j8S72jIBaHgAEAoiA1jKJhEgs+29WkxjzxnRFPSenPq
	vnuT/gl6u0NNwoJ3kWuBmsDL5zpsD9BmYveRsPV5INwJB2MJ1F5sTl3kmJWHu2cJsSl3NeDXyRt
	V+ACgeR7nCVM=
X-Google-Smtp-Source: AGHT+IGNDHUvwMhneiONW3ZVhuxDn9Qo2dJM5o0ZBY4D389P6VLIQkeD9fB+m/MZSgxRX2c75qbzIA==
X-Received: by 2002:a17:90a:da87:b0:2fa:1f1b:3db6 with SMTP id 98e67ed59e1d1-2fce875b1e1mr8996164a91.29.1740200855988;
        Fri, 21 Feb 2025 21:07:35 -0800 (PST)
Received: from localhost.localdomain (168-228-202-11.static.sumicity.net.br. [168.228.202.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb06539csm2265849a91.28.2025.02.21.21.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 21:07:35 -0800 (PST)
From: Pedro Nishiyama <nishiyama.pedro@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Pedro Nishiyama <nishiyama.pedro@gmail.com>
Subject: [PATCH v2 2/2] Bluetooth: btusb: Fix regression in the initialization of fake Bluetooth controllers
Date: Sat, 22 Feb 2025 02:04:39 -0300
Message-ID: <20250222050439.1494-2-nishiyama.pedro@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250222050439.1494-1-nishiyama.pedro@gmail.com>
References: <20250222050439.1494-1-nishiyama.pedro@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set HCI_OP_READ_VOICE_SETTING and HCI_OP_READ_PAGE_SCAN_TYPE as broken.
These features are falsely reported as supported.

Fixes: d0b137062b2d ("Bluetooth: hci_sync: Rework init stages")
Signed-off-by: Pedro Nishiyama <nishiyama.pedro@gmail.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8149e53fd0a7..903361456acf 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2436,6 +2436,8 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 		set_bit(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING, &hdev->quirks);
 		set_bit(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL, &hdev->quirks);
 		set_bit(HCI_QUIRK_NO_SUSPEND_NOTIFIER, &hdev->quirks);
+		set_bit(HCI_QUIRK_BROKEN_READ_VOICE_SETTING, &hdev->quirks);
+		set_bit(HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE, &hdev->quirks);
 
 		/* Clear the reset quirk since this is not an actual
 		 * early Bluetooth 1.1 device from CSR.
-- 
2.48.1

