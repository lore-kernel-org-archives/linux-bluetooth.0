Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DDE2F5A0D
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Dec 2025 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766654371; cv=none; b=CDn2aLhtszFRiWW5afT0rQrhudFJMgR5U5p+U/xmoeTRRvj7Rj+qj6riAT05A3TEZ4XRE8jg+cNP4mdXf1ehTQ5rL9kctNQQsgTuErww+eItPqA86oAd711s6AeZIZY4yAR6ystfKRV1Ce3lDwxRHStpb+nvnw/7B1H1QLrGvI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766654371; c=relaxed/simple;
	bh=CgRcdEBiqDFzFR1DVBuJW/uYXCOWI9kW134p04jPezM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KdZGrhsuPXL8U9+cp5E+FDuYoAKjzQeXEcODYkyzfx75kHdDi5ZUanvhsNv8wLntHvKe/P6scUxxnOwYmTYUqDlQbJUKjjdOz1w9yQ1yzLRsC9z5lecnTWSBjUsOKXhn6g+y10YXNRu7PnypuKkxJ05sajQowkkEq6h3IRB/5eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dR60T/4C; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dR60T/4C"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64b4f730a02so10607746a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Dec 2025 01:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766654368; x=1767259168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ukH8iyz+dWZCGVJbnwfUac+lLzJbX1fzUN62SEN4Cw=;
        b=dR60T/4Cp8ssCiVCOuRTmJj2zHP9sKBqozHeomqzkh7vnXFydRYmpCsr1W9SkM5Hrt
         WgGiy/ORoyF+KtnGJ0Q25/nVXp1hznaX1OlrtKKKuV2Q0Dzk2yXOAijzluIpszSaxaYO
         vX+iW7gV1qJZl+w3OuYZZCTpUUFiAhrbePAAiVOhUKBcO8sYI2OvzwQjv9eHvlFFTV1U
         o7uZImBkrmAXiXrDygLPT19BXCKYEq8KRJlJI51hv8OrvddxtCPJsx6/QrtSW/andAP0
         UT3jDkqRVvpJrE2N+MjL9DsgrzUqoD87Rw6GLlZPAo/qDYqRHA+FfIFW+bLsp+EgSyGG
         6lLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766654368; x=1767259168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+ukH8iyz+dWZCGVJbnwfUac+lLzJbX1fzUN62SEN4Cw=;
        b=lOLZBmDV20csqPBkr342zOtP2z7xzUrO+TMBOI94fYszY4PMyyKQhvlITljn83/P01
         0dH7acd/Ulou5a2EljO+oRiDiCJhsyhoHPu+0A1kMEofLFJkzS5clKyydGXdIEGC9Lgg
         XY/eKMwluZnr5FRjizRy/HCpYe7p7wnMsEYofzNHfNivHHrmjI1kr+OjLT5wTxXUT995
         egrG2UHrt4/ZQJ5vvik5eTmF0oiz6dQ+cgSNlVRL7amALESodVGdEKxhx+wRztZYpiuH
         UJpwnKhsPX0utPz+aAWHJA8VF8XJeYngb1BFcneOYdk5oa89pyvHEaWkq3Nz34rsN7wN
         24kA==
X-Gm-Message-State: AOJu0Yy9Jyp5t9PzZ58EzF67HOkl1MjxPz7en9VJHBufsayZOkc5HmwK
	R0mCIEyrXaxRc1dxiqi7MPwotjTldZ9M162jraHqAqYyZFPxaWmD7/sa
X-Gm-Gg: AY/fxX7oyd4wHs0wG8WmU/wH1Dw/lvVZMM4V7VyaK5lnjQwXCdQiA4s80B1oejaCrXY
	LIMTt7LwdRmMMLpysSJKNMbTqKVRHio+Ca+nn4i1xIdiWILRzD1a5ma8igQxY3ykik2h2gl1omJ
	wp8Pk0hYZx5STGESw2SBbZS0Wsqbq3glgL25Q6YMAGpaGScKraq8lKfaiigbj9QO3VG/BqGiSNf
	mPW5ts4NxEFqTOGoIprbEpmTppCvW/xw58Ah7nTiRXbFX6uEdj45SWheysyYGAOkpeSp87k9NaV
	KBf9xikbBcjBsT1kXoGREH7YyarTJZIu+i4mzE/YuTaUSX5kULDWs7KO60NjuyRfxW4jutlVyFJ
	pJOS/kMBYZ5AzrXmK31E+Erbc88xAoY+oAe2I+TiwLbJoC/HC0Rb7lHzXEMnWEkUHcne3Sdd4sK
	Qgyd7b4GyE+zy1qw==
X-Google-Smtp-Source: AGHT+IHjIV0ldku1ElyQq0/8RBbxwKcIKEUIwvsePPpVM0/Px1jfR+ImplEIsuNkdOirk9GMkdpuyA==
X-Received: by 2002:a17:907:86a4:b0:b7a:6eed:b590 with SMTP id a640c23a62f3a-b8036f2d024mr2168100566b.25.1766654367664;
        Thu, 25 Dec 2025 01:19:27 -0800 (PST)
Received: from prometheus ([85.11.110.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ddffc7sm2033173366b.43.2025.12.25.01.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 01:19:27 -0800 (PST)
From: Szymon Wilczek <swilczek.lx@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+4d6b203d625d2f57d4ca@syzkaller.appspotmail.com,
	Szymon Wilczek <swilczek.lx@gmail.com>
Subject: [PATCH v2] Bluetooth: vhci: Fix slab-use-after-free by cloning skb
Date: Thu, 25 Dec 2025 10:19:21 +0100
Message-ID: <20251225091921.14860-1-swilczek.lx@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224235407.46333-1-swilczek.lx@gmail.com>
References: <20251224235407.46333-1-swilczek.lx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hillf Danton pointed out that the root cause of the UAF issue is the
lack of isolation between hci_core and vhci driver consumers.

vhci_send_frame() modifies the skb (via skb_push) and queues the
original skb to the readq for userspace consumption. This means the
hci_core caller sees a modified skb (corrupted headers/data pointer)
if it retains any reference. Furthermore, if vhci_read() frees the
skb immediately, hci_core might hit a Use-After-Free.

Other drivers (like btusb) create a new URB and context, isolating
the skb lifetime.

Fix this by cloning the skb in vhci_send_frame() before queueing.
The clone is modified and queued. The original skb is freed
immediately, satisfying the HCI driver contract to consume the skb
while ensuring the queued object is distinct from the one passed by
hci_core.

Reported-by: syzbot+4d6b203d625d2f57d4ca@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4d6b203d625d2f57d4ca
Signed-off-by: Szymon Wilczek <swilczek.lx@gmail.com>
---
 drivers/bluetooth/hci_vhci.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 2fef08254d78..f2901a4b5b3a 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -74,13 +74,20 @@ static int vhci_flush(struct hci_dev *hdev)
 static int vhci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct vhci_data *data = hci_get_drvdata(hdev);
+	struct sk_buff *nskb;
 
-	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
+	nskb = skb_clone(skb, GFP_ATOMIC);
+	if (!nskb)
+		return -ENOMEM;
+
+	memcpy(skb_push(nskb, 1), &hci_skb_pkt_type(skb), 1);
 
-	skb_queue_tail(&data->readq, skb);
+	skb_queue_tail(&data->readq, nskb);
 
 	if (atomic_read(&data->initialized))
 		wake_up_interruptible(&data->read_wait);
+
+	kfree_skb(skb);
 	return 0;
 }
 
-- 
2.52.0

