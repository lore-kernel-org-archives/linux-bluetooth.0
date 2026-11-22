Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795362732;
	b=ouSy1jzBCa1JSEfY9x2gAsPPxSd6dXGGFSv497Gb9N1OPSRCMPmgg5KuvxLgpsoSEvnw
	 tYjg/6dJSmvIAgBw+UBvWij6TnpmoXUio79KxMFHhs3CTHqBA2dVAjYtFZHsE2OgR0vdj
	 tSRgZ6g8lsV8Rnz0SCzAbfiT5N+D+PjsnfLg13yX989qSnSKMgPIN7ISvmme5tpakPjTh
	 cZasCVmwoT4XhP+SXRPLPojJ+2zHh1xEsr7mdRDITbx77GoS25ItFtSEuyBSj7cylwq7B
	 IwUOM8N/M9hsdZwflyB9zaTqD/vAKwH/HcD0fTjnbu2TAPq0TQVd2/pwh+lMe+bjJlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795362732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=YxIAABR+jMl4AhQaZ0kLUtleBQnLNmC7oOVwDxxSMCE=;
	b=pTvhr439b8Iaw/GG/GIT5lOU7rY+SNIsve5GLFIf26VC4wxOiFk1jmWDFgJ/5g+B8AX+
	 MXMILYQ+PysT06Nb9kB/pxVHHhZ5h/90AuvOYXcsAYi7t/rFXBZLYko21l+bcL5vAVES5
	 M0xraUyjJYuib+sIoQJvaZgyhtxKT7KuLJ6ocDWFeWN+w83+4g4Y4aWs0UTBt8CwK+d5G
	 lBRx/wWF8ohKDRo6Nu9g8ujSnKjTY1xBoZsWbMHLQJLISc1dGmxM/RT5jIoTyclqv2Smr
	 2rIvrQRRbPtltMeSsYvIHTk/c6ab4UHn7FdTrBgwRWx/U5f1mSF54dgyfvh8g/C47qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b="ul/rAZ04";
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AFA606A320
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 15:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71AFA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=ul/rAZ04
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb6ba3b244so22972395e9.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 07:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795362731; x=1795967531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YxIAABR+jMl4AhQaZ0kLUtleBQnLNmC7oOVwDxxSMCE=;
        b=ul/rAZ04m02k7SmdKc8vjUqeYNAxCWK+Wafbi8oxiRtVBNSsaG37nVFFpg5tb5aWQv
         /WhLG4/baJJqCpBbcWugO6HtNsihLrGdFAkr3aj06gzudbJfxPB9blpzTds2acIUMQBm
         q9G36q1E6o/OyyNHik91ljnuQR1ux9hNYct+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795362731; x=1795967531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YxIAABR+jMl4AhQaZ0kLUtleBQnLNmC7oOVwDxxSMCE=;
        b=E5ew71pG7ahJwAws1IMJpi3UJEELcgm7vphybzrl6sN5wMxKmYR7oo6ARhmQO5uHhc
         WOTFjk7FRmZsqCC5BOwDWyrl/tirfxjGoYwYbqFTd7W3xWPOFdFfL2d5UN0aLD7eRtSo
         UEspSvTl6lCgsDT6CqwZF+W5SC0nRcOIobJhlE5306mxqFXXm6KideQeRU+dLN12cCd7
         82N1FXFZ2XbOZHKi9kG7jUlTIVjKmRlvCRQuCi0I/AeeNT65CFYaJaGlsCZ1wQAQcyiM
         PvVvt1S9gE4JgZgu46OriiymbRo1Gv/1ER1nPgW8S0l+UtJJnH+yyAwXskYitST6ulUd
         GZcA==
X-Gm-Message-State: APuU4Z9aX8jb7UOi1XJPT5IIBOUHHBZxBnKAxYthMgcRgxCaDexCebzQ
	FHgQUkcNSVV2SWAXekXLAIz6gvJ9uE6spyI4gRGCwP7kHo8w7WdumyODjkYKxAjmCPVHHsKXfPJ
	VAXoc
X-Gm-Gg: AZFdTZd+jKSdBmscGrtJ1Q4O0N11HH8wtG0WNQdAC4Dt+LfL4Eb9VQdHfXmY2QA7zLz
	cmOln3IfPtHCOnkY8TDbMfBtKaYM+1YWzPRbsIW/KAaCwOUkaMoZnoiZNDJWYF79D6Xz9Rae8FH
	KgtDDf133McwtbPfcFChOYoamUsHXXDH4OJFCBtPZ1Hmz0YZrrSUvGXWIMKJnlw2FPqFhg8WkoR
	Ao2TXru/Rd3vs5yU7vrUeMzQWW51LnEI3uh5kmB2nrYmQ9llWzYvOHt7NivF/ib7j/6JVLHiG/k
	nzqY+I//a3K9fLPp6bIPTlPGrN9FBQ/IYjTn34xeiSa5ETCJ3n7IZz5rkXffUh+GtfBEwVhUkf4
	Jy+avIIHzKdS+Bh1BFg8kz2GCuq3aSmGhQ2ewe1R0YpxwJHbqR1tZo6ein0oqUmq9/b6BclhkhF
	vitQ74tCnxLvG0c4bP58K9A7QI5kFXZxbXcQGDIXFet8DIis/5uqjOSsRppPGodx2WUoDl/AixW
	0O962LeRZN73Xziexh2hPomNZHEDqsot6RIrVDOBg+9BLx8YicnoVzGedtTCKouQ7Tf4PR+UQyL
	dCF/E9mryYb6PAaFGZPOfEUv0unpOwG528ykeLokpZQ0glXjU/2bOGE4QxJD1EUVBYqhskI=
X-Received: by 2002:a05:600c:4f84:b0:4bb:5f3b:25a9 with SMTP id 5b1f17b1804b1-4bb88820f39mr179933155e9.30.1795362730772;
        Sun, 22 Nov 2026 07:52:10 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b2437sm419751475e9.13.2026.11.22.07.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 07:52:10 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] Bluetooth: hci_h4: Ignore the RFU bits of the ISO data load length
Date: Sun, 22 Nov 2026 16:52:08 +0100
Message-ID: <20261122155208.1549223-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The length in an ISO data packet header has 14 bits and 2 RFU bits, but
h4_recv_skb() reads all 16. Some controllers, for example an NXP one,
set the RFU bits in the first ISO packets after a BIG sync, so the
packet is rejected and the rest of the receive buffer is lost. If that
holds the Command Complete of the second LE Setup ISO Data Path, the
second BIS never gets ready and its channel stays silent.

First bytes of such packets, handle 148 and 149 with length 108:

    94 60 6c c0  (handle 148, PB 10 and TS 1, length 108, RFU bits 11)
    95 e0 6c 80  (handle 149, PB 10, TS 1 and RFU 1, length 108,
                  RFU bits 10)

Kernel log of a failing join:

    Bluetooth: hci0: Frame reassembly failed (-90)
    Bluetooth: hci0: Frame reassembly failed (-90)
    Bluetooth: hci0: command tx timeout

Steps to reproduce:
1. Start a broadcast with two BISes on another device.
2. Join it with such a controller on H:4. Often there is no sound or
   only the left channel.

Fixes: ef564119ba83 ("Bluetooth: hci_h4: Add support for ISO packets")
Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
---
 net/bluetooth/hci_h4.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/hci_h4.c b/net/bluetooth/hci_h4.c
index 86f809018062..ae0224b36ace 100644
--- a/net/bluetooth/hci_h4.c
+++ b/net/bluetooth/hci_h4.c
@@ -120,6 +120,11 @@ struct sk_buff *h4_recv_skb(struct hci_dev *hdev, u8 *alignment, u8 *padding,
 				/* Double octet variable length */
 				dlen = get_unaligned_le16(skb->data +
 							  pkts[i].loff);
+
+				/* The top two bits of the ISO length are RFU */
+				if (hci_skb_pkt_type(skb) == HCI_ISODATA_PKT)
+					dlen &= 0x3fff;
+
 				hci_skb_expect(skb) += dlen;
 
 				if (skb_tailroom(skb) < dlen) {

base-commit: 4fe38719e6738feaa90486e36b0790dd5d960a96
-- 
2.43.0

