Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774441E1A1C
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Oct 2024 17:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495726; cv=none; b=DGw/5Glu3K0SLqIEnnL4TocWfIepksfxvB5pA442bQODvL/1XdyTOcHU/PaKzcrkt7ZG3CCTkQsxCZFse6YLRSx2wJSVxla//nweUH2UobXcQCqusZskfEyQeE9fu/UsB7cGL74zd+gtgktQZWOmo+hXTep+efkDtUPzZlYYiSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495726; c=relaxed/simple;
	bh=EKKtXBmbTsgg5aJfG+bqnKrO3lF5cL6lJybtQvaFXls=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ajL0xlxvc5sSmGJ3p35rL4Q/J6Mjz+iGATQjQd1UUQ92AfzWdgYUt2OIxXqSXJYZ2uZahZy4EfSr5Nfh1FVpZiY/PNH4UKVC4c0/Xl/ptHvFaVyEaWHJyr8+Z4v6GDi5e88cLPguvmq4ut0IZUeRkh2pqYbd4D42RVkW9amwi/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9o7avNo; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9o7avNo"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e28ea358f65so93934276.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Oct 2024 10:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728495723; x=1729100523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KK9o9FLLSOpGDDJwgR8CE1uDvUbDAUP113jniXxEl8w=;
        b=J9o7avNopQv4zc4jWk7qwBPXw4Y/il0AKc94lJVAJtGY6M/RxP8SXY6KSeAS4/kK55
         VEHzYIgP1wqC2mtabD7GQNsFrl47KJFQdyxsnQ6wFDkOttULaziievGADZTxT4tgjSz7
         rpZl9EvofInrLZXwIIL2mcaG+f5IasJkQikFs0Fsj89p9/ShQhSl4OQGXzM77k+0KXby
         ax/PzUfYVgJpL26fzI1Agy3QIApba/65HElEH/S2l4LQFXahEuhHVy34ZlUJ6M9wY3lm
         FeKytFV2QZI5KAss+HjZMelvAuUTs260qvreLd3OPW5y5zoJxz+F6FW8SchAh+xHhfb+
         LaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728495723; x=1729100523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KK9o9FLLSOpGDDJwgR8CE1uDvUbDAUP113jniXxEl8w=;
        b=mlz8C0cnrhBBYJ1uIKhildmajaDkvw8IDoGdqsopt5kEMomKMfDkkQ3Q8c4xXKCZWJ
         b93hiV3XIms74gL1mVG+u9F208GqaP2PjMLAyoIyXIUEeq+SUlqBKpW0sw3847yUoB8H
         W3ysfsGknbX9KJqJLGP4geuanHi6ia/97QZnYQGz5BEwBJMpXqG7hTfaudvdlhQnuRLz
         mC1NuuxIzo8l4/D8JaBsIHl2V6yk8TwSWDbzYQLgbuPH6qAfmqIHN4sDrY0XzQBYPTZ7
         Dtr0QByjnJ4kXsXcMeAQaSPtaPLKLGxqgLTWxHQ+ZIZcl1VDASsYHY8wf4JLF49Skmxe
         dLZA==
X-Gm-Message-State: AOJu0YyL5EsNPUzgO3W+mRmsejPr334v20R9B/GyVqrfBW2kKJhUN9dE
	+8o05Cp3BShs+O7eOOa9kzNqF2Q5PMCGSmaG1y57mSw4Zr+AzPHXTDQbcgcY
X-Google-Smtp-Source: AGHT+IFVNxhjo+4+n9Di826hZUZHxmgmh5g9ZfELlKI72Fy/9IYUWmk/UKkSYp8YFNFWU02dhtCm2g==
X-Received: by 2002:a05:6902:114c:b0:e28:e4d8:f6ac with SMTP id 3f1490d57ef6-e290b7eb2b0mr516539276.17.1728495722707;
        Wed, 09 Oct 2024 10:42:02 -0700 (PDT)
Received: from lvondent-mobl5.safetynetaccess.com ([50.204.57.18])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e28a5c3755fsm1850405276.17.2024.10.09.10.42.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:42:00 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: hci_core: Fix not checking skb length on hci_acldata_packet
Date: Wed,  9 Oct 2024 13:41:58 -0400
Message-ID: <20241009174159.15658-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes not checking if skb really contains an ACL header otherwise
the code may attempt to access some uninitilized/invalid memory past the
valid skb->data.

Reported-by: syzbot+6ea290ba76d8c1eb1ac2@syzkaller.appspotmail.com
Tested-by: syzbot+6ea290ba76d8c1eb1ac2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6ea290ba76d8c1eb1ac2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b2f8f9c5b610..d5f917076e0e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3765,18 +3765,22 @@ static void hci_tx_work(struct work_struct *work)
 /* ACL data packet */
 static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_acl_hdr *hdr = (void *) skb->data;
+	struct hci_acl_hdr *hdr;
 	struct hci_conn *conn;
 	__u16 handle, flags;
 
-	skb_pull(skb, HCI_ACL_HDR_SIZE);
+	hdr = skb_pull_data(skb, sizeof(*hdr));
+	if (!hdr) {
+		bt_dev_err(hdev, "ACL packet too small");
+		goto drop;
+	}
 
 	handle = __le16_to_cpu(hdr->handle);
 	flags  = hci_flags(handle);
 	handle = hci_handle(handle);
 
-	BT_DBG("%s len %d handle 0x%4.4x flags 0x%4.4x", hdev->name, skb->len,
-	       handle, flags);
+	bt_dev_dbg(hdev, "len %d handle 0x%4.4x flags 0x%4.4x", skb->len,
+		   handle, flags);
 
 	hdev->stat.acl_rx++;
 
@@ -3797,6 +3801,7 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 			   handle);
 	}
 
+drop:
 	kfree_skb(skb);
 }
 
-- 
2.46.2

