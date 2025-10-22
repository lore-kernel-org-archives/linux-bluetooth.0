Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721DB295516
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 22:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761172729; cv=none; b=u9ea1RWlbUH8dvyZAus8Ghlus90D0cWLv1fguPEbZ+qAjP76N3iI4ByuWZNqIRzKerEYNzgT1XXgShNtCv4TItQiK081geJy8bfwOSOHdSdMxzrScXryxFe9Yeu369swXo5EiK7ghdqn0YVJyUB04oy8/yzxS6y0xWlRGc3dh38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761172729; c=relaxed/simple;
	bh=ULKv6OA6DP41wT5L4cbEcKCtaPLTWzh9900cBvwjo/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WNNZlBGQGasL9tI/BKMjqvJagvwBYCA0Q7vgMmo4CNK5A1r8TAWbEdJmPSESZmexXJGtgxg6vupveft+tUvHFPmZeoGu/Qhw3OwqSVrOQUo4LU8Od4IbkKhqg0aBjCGPvxF4//QLuhVoC4SLKT6gu2BIJsepJaCmsNSeD5zY2No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/TVuzfV; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/TVuzfV"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-88e525f912fso15105685a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 15:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761172726; x=1761777526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5VocPRDtVk+dIE3iw2ib7QtB3Kc3D8UgJbJMrfJb3wI=;
        b=R/TVuzfVwi9fOhdMrqNAFxbxvXM8zSXaPBUkEUb1fCuM2OTalT6qao+D2Aqx6nXrua
         Xas+ZUG0SH8YH0kWz/gTGsBT+Ql1SIlO5ci5s6Quv7E7KoxKu0JPCvDtsRERo2ZoUWZi
         8S4ghdPZEAW3IN9b1QilRHGSAtdWkvyYf0h21hA9XizEH+HOq2G/Y2K2Rtk8iAY9nPVT
         Kqu1ONF/jJcFu+6ExSyV2YzF+yRBP+NwmeO104eCWWKs+NISz3J7HidGCG0mN6JmpMM8
         AnnaOsmn2l1yKqNHRK2I3SvvyFvLCfj7D/baTLwbM+rclPAnhCqxLwZUsaQYLuSv6ukA
         OxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761172726; x=1761777526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5VocPRDtVk+dIE3iw2ib7QtB3Kc3D8UgJbJMrfJb3wI=;
        b=ImigraQmyPUk+LNpxCurremvYENKn4E0/ecqYdn6CxqOxqMJ0C/fbJHUqbSDKr/Koo
         OtqgOcWxzVXwjWTSJYcKD4KW9eo7l7wPKfuNuMpNR7reZxsUF0TYYMVHB9M+8cz1uNq+
         WeOgvX618zQCS5ZUDiYwKmgtUQ3DW04dpwOuVxtr3GXDrSU8y50158UHqH1slkxiuIFo
         skUxNRTO05MuB/wtADbf1g8RYRg4DMyX9dWGckMqBdSGfbfadZ9n6l/8s338NaEbo4Pg
         9eiO6Tq7qLEamO8r+cL7j+0YvyuPtYYA4pIp43onJjrGtvG1GzphADSqkuyoa7H5Xlo5
         XJYg==
X-Forwarded-Encrypted: i=1; AJvYcCVTHnZuSmr5J6ym5N5AtH1odcJDE7whWpiJL64l+quhCLFyNmXfLATLAHy26kraqo1x+W2QRMWEUBwePCRE77Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxQS6oiUlO/TT3BtLBYhnAMDQ+Kb/nD/JftcTZeiQJccBJCZh0
	rDdDR8Oc7W3KXce2GqT1kEk7moIyFwaHmzDz78VOE0IV9eu8k5s9pbHo
X-Gm-Gg: ASbGncs1G5kDtdiuCQnyNL+/lamRgJ+ihtwC7zsqt23O/pGs1VowUq3qyq77AH/NDmt
	NzruI64Z6oO5MCLUwipgCgVvHIOY82Bn/EYXVrUG8TC61qLRt3SP00/FNNRD+JJoKa0Z9dl1sIt
	A+3pnzhcmJzJ0hH59CzY2Ztqxhk1INSusfn4EBCWZv5GTPdWUkHtElnOKfr3G4WwmMrdygVkxz0
	aprdv3xV0+DzwaiAMhWB701mr+BDNp8XQlp/0m9pgFKew2EY6SZUQqZIn1aT6htQW19nOXEt2H+
	kSr0HFzDQOKXHrIKNFDzMJOiGY6S6G6hWT0iLAP9MfWs97aOXmfbj6y2XwdqBCrJzyywSbVvImP
	TIvJlgjqcFGbzf0JXerem5pKN2fgRYjfotHFhI5mdGW3PVusk/we12xrrBbYEX7Pn2z61/v58p1
	fpGg67eeyR5/0zUzjGM83e
X-Google-Smtp-Source: AGHT+IEwf7KTlPfmIBbi2nVEJKfKO6Y8rFXq7vPh5m0MioYFQ+fvpto6UGE7cIpu3l0BBWVrrjj6eQ==
X-Received: by 2002:a05:620a:1724:b0:893:5433:741b with SMTP id af79cd13be357-89c105a9550mr92282885a.40.1761172726364;
        Wed, 22 Oct 2025 15:38:46 -0700 (PDT)
Received: from rpthibeault-XPS-13-9305.. ([23.233.177.113])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89c0e586d32sm30609585a.18.2025.10.22.15.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 15:38:46 -0700 (PDT)
From: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+a9a4bedfca6aa9d7fa24@syzkaller.appspotmail.com,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org
Subject: [PATCH] Bluetooth: hci_event: validate HCI event packet Parameter Total Length
Date: Wed, 22 Oct 2025 18:34:16 -0400
Message-ID: <20251022223417.139332-2-rpthibeault@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There is a BUG: KMSAN: uninit-value in hci_cmd_complete_evt() due to a
malformed HCI event packet received from userspace.

The existing code in hci_event_packet() checks that the buffer is large
enough to contain the event header, and checks that the hdr's Event Code
is valid, but does not check the hdr's Parameter Total Length. So,
syzbot’s event packet passes through and uses the un-init values in
hci_event_func() => hci_cmd_complete_evt().

Reported-by: syzbot+a9a4bedfca6aa9d7fa24@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a9a4bedfca6aa9d7fa24
Tested-by: syzbot+a9a4bedfca6aa9d7fa24@syzkaller.appspotmail.com
Fixes: a9de9248064bf ("[Bluetooth] Switch from OGF+OCF to using only opcodes")
Signed-off-by: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
---
 net/bluetooth/hci_event.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d790b0d4eb9a..5e1498cc04cd 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7565,7 +7565,7 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_req_complete_t req_complete = NULL;
 	hci_req_complete_skb_t req_complete_skb = NULL;
 	struct sk_buff *orig_skb = NULL;
-	u8 status = 0, event, req_evt = 0;
+	u8 status = 0, event, req_evt = 0, len;
 	u16 opcode = HCI_OP_NOP;
 
 	if (skb->len < sizeof(*hdr)) {
@@ -7585,6 +7585,13 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		goto done;
 	}
 
+	len = hdr->plen;
+	if (len != skb->len - HCI_EVENT_HDR_SIZE) {
+		bt_dev_warn(hdev, "Unexpected HCI Parameter Length 0x%2.2x",
+			    len);
+		goto done;
+	}
+
 	/* Only match event if command OGF is not for LE */
 	if (hdev->req_skb &&
 	    hci_opcode_ogf(hci_skb_opcode(hdev->req_skb)) != 0x08 &&
-- 
2.43.0

