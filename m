Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2E82E11C2;
	Sat, 14 Jun 2025 04:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749874761; cv=none; b=iuuYE/OWCwqG+DL3dpQhoxcUcbM3arpX3PylSyq4NcjlNo7iMhBc89GGOQ1EiP0znzZRmj26Zo2aj9S07ZuEG/hsmWVxLyE0N2CmoccIXtUiSIaLDda+cLMSeMd0N147IAU6RhJjuXfo4UthOLIVkQFjuzofa/aj4xVKKyKGovA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749874761; c=relaxed/simple;
	bh=mun96Luc7WjojlHpp8F1GkkE+TO/jNykUTXsT9IPIYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oiNZB3vQmb00JxQfh3GLUJrBQQEeL73aI2V6UFwfFt5c05Mb3l/JoKnD89J9Jqh1EqVUpvQxXDlaAyZfsaPuEy4KXxwJE3f0dflWkScbZt2ZjKGMG5V2Co4lXqj73JGtkgobDcdjNhkuQs1XXf8y3wgp4yX6S7FM/l+LG8hg4xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfQrVMnh; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfQrVMnh"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b2f645eba5dso2836728a12.1;
        Fri, 13 Jun 2025 21:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749874759; x=1750479559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vZ5hW+QTkXwD2YGYp7qAmb/lVCnwot4fuQufFS2iflc=;
        b=jfQrVMnhTT/m+/srmkV4D6MlkPu0zb2oVhHUr/UVwmh2Rk9wsp3tfI/JqlTJSswnc4
         aKjUMRsRFbi18riO2MBCDQ/9ipTynFythFC7W80w8SrVSmbnMlLoTW5Oc/fjs81M6wJ6
         BSmfRDdVqtmZ8DQF3XPHroArQp2SSHICLzE7Y3B15uO+KXH4xhV31Zl8axhY7h4KCJ1s
         XNz0Qj9Iyc6up5xssAn0WG7xTJKzOwNUq5PFvKRIi6hxQNJHnvy8x9GTxEY3Gtv0km6e
         OGdlvZZ7OBWpEAL02zUKJ8vb9vAjGCyexsdi7Q0LFBXU7o41zkuCfywkNcrbrHaJ/egA
         XU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749874759; x=1750479559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vZ5hW+QTkXwD2YGYp7qAmb/lVCnwot4fuQufFS2iflc=;
        b=AowpC4idaRidaybXlyDDvnJ2Lu9+wlY/R64KW43t4QpjcvIYiF94k+IIqu95sF+2MA
         aOA7kqxzJUfUoDMwKztUff+Ch+i8Ua731xANZ8wL/z7ZQh8/s7bJpNZFsEBBfQZQ5C8a
         GSpIukmiz9qMSLlpgdPOaOhHpdEbZkO4cKfvVN2SZ2cZGaF6faxGZPBpV+eJhtaNK5xW
         Si7TxqRoR9UL2YHUTQXqo17cZIKDtF8RLKo0eOBDpOIg/KwB84r0VBPcyyGG5JyvU8hq
         Kc8Mig0TRAiD6NqV5kraAJyTGRurbM3BM8l/pc8FY729SRQI0QGJRWyAk5eeBg1IUEZ4
         JWkw==
X-Forwarded-Encrypted: i=1; AJvYcCWvjbxDXQXw0EKzAT+aJn6U3B3avs54gU6QOPuGKotQzc0elHk2bHSWkvV+X1XYpTreuZO0qkfO02+tRV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQlZyrFRZt07Also7WLbmBS38mTeoytrya/eanohFbv98Oqu7g
	z++ORVV9CcNjFaq/zb7BVNjmhzPS5+QJnh68BqkK8yVJ3iEXq0D6LTwxnV8jmABlfRA=
X-Gm-Gg: ASbGncukIPhqRBfVMEqjeEopT84SjLLPPwxpYEtK9UYDPmKDl2Mp9gU848S8zkFEUe9
	8QuozCkOCTUcrTxCR4QgzyI9hudSL1VKBQeeKkkqVQ3oSHkcfwWhAwCqQFMrcKscQLwNSXfc4Qj
	EagKO8++SdCPcbsXaaHp03uhduaDECMch0RNpWSRoXsIgXDlNQY+VF9H9Bv/sGNYzut4dl2c6Cc
	u5AKjADGKkBCK0UA4mcpfwtjBINnUihwUF8B1g0buXKYEcDws6vU6NypwvGBheMzAQ4Ow4kwUZA
	PtKY0wS0Bat7A9e2zbokRojvrp3LjXqDJvgmOBOsfTb1jJgsZhM6mrgWEg1yADCxj0RyJk4gSYU
	1mygWTBmswPuQDJJE0+kMUzVuL1pqmYr/FfoGhlU=
X-Google-Smtp-Source: AGHT+IERadNSQgL17fWczK/sR5f0zRvR0CxcR4ZGDlmN7DonkoNDaQHAgm8UzsR0KQyT+WizdqHbuQ==
X-Received: by 2002:a17:90b:4c09:b0:30a:3e8e:ea30 with SMTP id 98e67ed59e1d1-313e90b17a4mr4480894a91.11.1749874758864;
        Fri, 13 Jun 2025 21:19:18 -0700 (PDT)
Received: from ipravd-Nitro-AN515-55.hsd1.ca.comcast.net ([2601:646:a000:5fc0:6f16:3f22:e287:d010])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deaa9b8sm22857885ad.165.2025.06.13.21.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 21:19:18 -0700 (PDT)
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com
Subject: [PATCH] HCI: coredump: Use tmp buffer with dev_coredumpv
Date: Sat, 14 Jun 2025 00:19:10 -0400
Message-ID: <20250614041910.219584-1-ipravdin.official@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create and use new vmalloc'ed buffer with dev_coredumpv. From
dev_coredumpv documentation:

`This function takes ownership of the vmalloc'ed data and will free
it when it is no longer used.`

As hdev->dump is used after dev_coredumpv, create temporary buffer to
hold hdev->dump data.

Reported-by: syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/67eaa688.050a0220.1547ec.014a.GAE@google.com
Fixes: b257e02ecc46 ("HCI: coredump: Log devcd dumps into the monitor")
Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>
---
 net/bluetooth/coredump.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/coredump.c b/net/bluetooth/coredump.c
index 819eacb38762..1232c9a94f95 100644
--- a/net/bluetooth/coredump.c
+++ b/net/bluetooth/coredump.c
@@ -243,6 +243,7 @@ static void hci_devcd_handle_pkt_pattern(struct hci_dev *hdev,
 static void hci_devcd_dump(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
+	char *coredump;
 	u32 size;
 
 	bt_dev_dbg(hdev, "state %d", hdev->dump.state);
@@ -250,7 +251,11 @@ static void hci_devcd_dump(struct hci_dev *hdev)
 	size = hdev->dump.tail - hdev->dump.head;
 
 	/* Emit a devcoredump with the available data */
-	dev_coredumpv(&hdev->dev, hdev->dump.head, size, GFP_KERNEL);
+	coredump = vmalloc(size);
+	if (coredump) {
+		memcpy(coredump, hdev->dump.head, size);
+		dev_coredumpv(&hdev->dev, coredump, size, GFP_KERNEL);
+	}
 
 	/* Send a copy to monitor as a diagnostic packet */
 	skb = bt_skb_alloc(size, GFP_ATOMIC);
-- 
2.45.2

