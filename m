Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD4C1172A;
	Wed, 16 Jul 2025 00:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752626339; cv=none; b=GbEa7pmV+wEyFvB78jtJ20QGU88XJGe4dJOzdE29Petsf/WMMtpJHaGtKUs4BzdiQ6PYiTHyEzHXkYDLI4rPia0DM44SUNXFLPoQkkQ8HjCA79Tx2Jx2gDrkZa67Fp8/zeeVMXvkK0KUnUB9m08wP5HPc8Dc7XE++VuLWVu6soc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752626339; c=relaxed/simple;
	bh=p1GANUfXiRHg8VaqbQmPx3rBJfQZ32WzbGBU5vAfTmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FZpH3+sqD+2DC1MFFGuKTTgiIxOJ9s0gS9rbFm0kLOUReI+JhXBHTHuPB1+ZWjcUU2oXKTQLwdfTwRJjF9dFb485d1SVAmS1RYETmr/6awLMRyIYzZ75x9PpHk2Y/KkpitUQdtA2qlVEjDtDEMpUQqVQBILi1RuJGblmihH8U4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgwApAU2; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgwApAU2"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-31329098ae8so321733a91.1;
        Tue, 15 Jul 2025 17:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752626336; x=1753231136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/8/SpxrVW39XGNacOTMEQXkBAgWgvCGxE1meHI4Z2rM=;
        b=XgwApAU2m3Z30FOsyPu62x1T+WCKA4NVCaUGch17wQsd9sFiy63ZcfSfzayJj6VCsr
         ESsX386bLiCfKF6z0SlvD7rwEjtVStAsk8vibOnOzzclasvqDRPbPeYlbyWRYmv+LEgW
         Lk/dj29LH86TSQ/Aydnf5XnjCPImUWPRKQXM62cT7pfD9WCsBO9tgHh07y669CpzuWHM
         8sxLmXaVxThtx8dZGf+8I4FD1GPz39H1GrOjeBCRKvD+HXROlzWv1kExFkVkYnzJeNey
         8L1clDMqpp2cndrGBkFFHLSxi0KUpW2sH9tWDZKDnTmBh0wM9hyADRZUJ9WKh+e8+Sf1
         AEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752626336; x=1753231136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/8/SpxrVW39XGNacOTMEQXkBAgWgvCGxE1meHI4Z2rM=;
        b=WlAer8DTZEA0HfgpxoD3qJwLI90mJ6GG7B1HjljUYj1kgozxT0VWDRWVz5qBBBqa0F
         BHtC2/6U7vfhMkNC/znUeZ4hCJUOLQ7si1PP8aP0866toPJZ9lkhzkSw++v5vmlFAm/Z
         +eVKlsZrI+n4aBuyP2oEjyEeLp4pR0wZidSw6LxNaqKRAKMK5+tRYJ5FUH3OLsu/Y8Q7
         onOQjIkbA1F+C7fVtwHyyAIfF/Vx4/bA02kUnYhUAWNMvgj6SJAluAI+u+tDaEbzCUa/
         rgKtepl6J6MzhQErnGSaFNMqIaje0emWwv0sOfxl6ePxMRa9z/47Kb69N7CIoqgHTdKR
         V4IQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4PTQz4re6+KCHt85QVkuzFUi22a9TK+Cm0lICF/+bv/L0plnBL8TqAxp91XqkiiiRA+Wrth/qbWK6m0r7@vger.kernel.org, AJvYcCWtB4mMQFmsa+7d2OXOVbQAK5h4qVxGP6NTuEy1MZqD1GzB9Dif/V//pDZoWmHgkdGHn0i27+goCag1PWutJAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJmeXQCXAoIsgXDDVls3NIu9uqbpZksUsoV3FemqF71eteEhn9
	IuJ8gMNo++ktpRndIO0qtYQjF2lWNxy1AWzvWY7WLKcAZgG6Qw3PB60T
X-Gm-Gg: ASbGncsGu2vz1Ts42Gio2BGN8LWgeKLyAs4EFkd2/n70NkcbyxoCfGeuey6pe1rpw66
	NavFu+mNA11NmtZs+YoBR7JjSkhN70I8EGUDOoacU4mPfsQwBRjvwKBSG3iR43HG+5MPbYIWWJS
	IuAXWTaoT5T2EhARWiU8bRYl/QGXVwNuV3YhVJ4lCRZGwNopKWzB9zGvu4UY9DIhkw5ioTAuBC/
	e6u2in2V8s7b2/ahvWSURvcxRUy76wgtQSrtH6Y57RkZA/wGVdb3/1es4k9B4N7Y61vI+r1SEF0
	yfP8WoYjagObF+LCWJlQyZNhd+wSMVn2CmLBMbUWSCdaNhmbNdYepTT0H+FnJyliSpMx3bAxG5S
	6gqv7mi6qCxJNbK5dLP6L5n+jJ6K9g9h5ANkzWhYBC4d9hZQStMVx8ZNYhVVFdnbwg1iZSZoYeg
	==
X-Google-Smtp-Source: AGHT+IENCNp98Mpy7+gmQGhDA7h9LD4Q8l3ORuqgJnm7vOJ9eVbfN+YACysiTt2mt4ctA7gIDEoY+w==
X-Received: by 2002:a17:90b:1b4d:b0:2ff:4a8d:74f9 with SMTP id 98e67ed59e1d1-31c9e73efe6mr1714893a91.10.1752626336111;
        Tue, 15 Jul 2025 17:38:56 -0700 (PDT)
Received: from ipravd-Nitro-AN515-55.hsd1.ca.comcast.net ([2601:646:a000:5fc0:cbd:b87b:a7dd:f79d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f29ddcbsm203912a91.36.2025.07.15.17.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 17:38:55 -0700 (PDT)
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ivan Pravdin <ipravdin.official@gmail.com>,
	syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com
Subject: [PATCH v2] Bluetooth: coredump: Use tmp buffer with dev_coredumpv
Date: Tue, 15 Jul 2025 20:37:26 -0400
Message-ID: <20250716003726.124975-2-ipravdin.official@gmail.com>
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
v1 -> v2: Changed subject prefix to Bluetooth:

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

