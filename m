Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABBA3D6F;
	Mon, 30 Jun 2025 03:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751253837; cv=none; b=RFJajZcsYzF/YvWQac8F0byLFqYD1CJcFnjIuSM7vUrnq7zgGXosPXeIxVW/vC+UE9SIoFGrx/z0a1HrtfXkZlWYQ88mBtPgTJ7i6k6FDK4yhadRXoaP8PM5u1t079qoHawWiobV+jc9FzII7e8S4mkGKO1DCRz8wrg6DOVixzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751253837; c=relaxed/simple;
	bh=nUnKD4t2oC6+/m2WbqjH/Yj7qnmYdAYy8/5qle03KCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nxl797YNFUqjZl+Ish61YOzbRrBfas25E/aMC4K86RQVevA+6VppGevt/NF3NPICdpIM8RZgzkYTerhDGRW1Pkl4YSvjp2NKRRYNn1P/udi4kaSew8EsWWLsZVwXy1At1hE9tFxjHpbP8V80J5DML/2PewSiYcaxq+Y21LUl0TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhoN/Fvy; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhoN/Fvy"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-748f54dfa5fso3483599b3a.2;
        Sun, 29 Jun 2025 20:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751253835; x=1751858635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bt40NLOekWCUP4N5pOq5H/L4sYgVc3vJQNm3hCjDNnk=;
        b=bhoN/Fvy7nih17aQe7eNhUHjFPd6A2cFhEPNKEw+fR3U+la154gbTKwqZLAGmYMgur
         VBfGjBWqRw5zhntx8qWnaHtZWVYvNt4KIyNXnB053tJvkYnTp7cUM/mzCzGY6WiSoTeE
         s9rV6pvnPSEVGTH+q7rY6+svIPePxm4xXbtvqYoYYKlKsOaY0vZH0qTc+0WoFWBOg1Kl
         RRwIkXdxOKKvZqW0bQzYBoKoQ033Ohb9HCO9wXJZxl3e5YypLW+bu/OetUfMS5hBlNaa
         qQS8NMRetbrPyvHIlbgsIjuDti+hxQwWstq2xsDf6Y/yFcFyZHh2eKUzogC2Ti6JGxTN
         W4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751253835; x=1751858635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bt40NLOekWCUP4N5pOq5H/L4sYgVc3vJQNm3hCjDNnk=;
        b=lDSeTrJe9SjpsWrztJFgCCSLK+zd2okhLZv4/NL1EBBJ52eq7eB2t8uvuFojxoO8pd
         NdqqFlpzzc0fA1gbEQg+/KXft8NwEJMl+8f+Wv61ZqXKkjp4BLfqn/BOSR1IwqxqyWj7
         h7Tu37vdDHHMcDHYIL5LOYiIFdU8tlksQcWU7OXvHEoW/8cLpDIgu3r4T/DMAV+qxiRH
         /E9Qx1WEAkwvSpOWwc1GGtqFkhFce2fvJy0ika9ibvvNdIDB+bXhUiOFFbTiju2nWs7M
         4z7LMPFysDxKHKyRAllqtNbnR2MgEhWeZ2CHUCq5Xd01E76dW7RnzKYeZnne/aAnKt/T
         nfiA==
X-Forwarded-Encrypted: i=1; AJvYcCX2pf9Hk1jjyJ/iJonOMrot0Y+JJNom+t/VVcLDetDGrbS8Fuig5r5zN0lbx7C+9D5VVkoUA6MdONu0/z9lpIs=@vger.kernel.org, AJvYcCXitEYKpyK0XkmK6fbMcHCORwlnvsGZ7PCws7lo2HUhUDOkgYN156xJ2TVS0X/8e4tyiRgpAk6yd4wSlFqO@vger.kernel.org
X-Gm-Message-State: AOJu0YyWtdojCmzik0hIuaeDPOvcPNqQlRUUuW74TLCY7Jec/pQ1svoV
	6I8FLCA+tvW+T+gDkNJhnUDqW/MVLnozb8LJy15Y6KdU7xe0V+T6SA5c
X-Gm-Gg: ASbGncvrId0Pc0CyLp7TjLRj+J3gaQ4kjKH4Lof3pk+pFDTkUUV3YpmfaeNzK6vgs4/
	cUTB/3qaI+dW5EqQWWuHR5PuiamMHG4Efzt9idM+50SknrNtf7RY3Z54N5MqSs8bJ/ycy5gih4D
	YcS3ZwV0JGF4eBAeFGtLmbNQAnKGqgocPnp7rQuI55VzrdKN4DNhiuSzbCw+xT8tpZmGsXjhdpj
	unEkXy3k+oxHHJuAzj3GVCnrRF3zUy5ZwcLTLweONjLBgFpaagel5c0sxlizQTXlFdj3mgQQFrF
	tRHooHwFg5mAAd8fUVNUWLBCEtuc30eENlY7acg2cn8b/YxEJmWG27VoKYH8E3jPAhV7co9DF4J
	eOiO/GEhnGNep/YqINSd9RHUI+LMmLsop+UPYxpA=
X-Google-Smtp-Source: AGHT+IEweQDpqbFoLegd5G81mQV+h2WunYcZCHxDgyatO1uuacJRxYQuuA9LTPUZYHMhBdlFOYEQ/w==
X-Received: by 2002:a05:6a00:170b:b0:748:fb7c:bbe0 with SMTP id d2e1a72fcca58-74af6fde46amr18069903b3a.24.1751253835362;
        Sun, 29 Jun 2025 20:23:55 -0700 (PDT)
Received: from ipravd-Nitro-AN515-55.hsd1.ca.comcast.net ([2601:646:a000:5fc0:84f2:7459:db60:b146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af54099b2sm7752501b3a.28.2025.06.29.20.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 20:23:55 -0700 (PDT)
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ivan Pravdin <ipravdin.official@gmail.com>,
	syzbot+4ed6852d4da4606c93da@syzkaller.appspotmail.com
Subject: [PATCH] Bluetooth: set bcsp to NULL after purging
Date: Sun, 29 Jun 2025 23:23:35 -0400
Message-ID: <20250630032335.473671-1-ipravdin.official@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set hu->priv to NULL after skb purging in bcsp_close to prevent NULL
pointer dereference in bcsp_recv.

Reported-by: syzbot+4ed6852d4da4606c93da@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/67b0cc5b.050a0220.6f0b7.0014.GAE@google.com/T/
Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>
---
 drivers/bluetooth/hci_bcsp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index 610d0e3c36d4..de9a6ed3a8aa 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -739,8 +739,6 @@ static int bcsp_close(struct hci_uart *hu)
 
 	timer_shutdown_sync(&bcsp->tbcsp);
 
-	hu->priv = NULL;
-
 	BT_DBG("hu %p", hu);
 
 	skb_queue_purge(&bcsp->unack);
@@ -753,6 +751,8 @@ static int bcsp_close(struct hci_uart *hu)
 	}
 
 	kfree(bcsp);
+	hu->priv = NULL;
+
 	return 0;
 }
 
-- 
2.45.2

