Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8259917A2E8
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Dec 2025 10:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766657575; cv=none; b=BqC70kcHICrPjAAljKJ2JM1c0863dfxPTGvPRxtRuYiP6guaZieXlmdIEyHV6MbFHn478BYrYgfA7WoEIleL2BYVeInRPCFsq8n1NPfWxU+mBO4pmGntgSCOyqduanFyk3F2GeLUbVYYInngH1S9CSgYlgaDHqLP6NrgMu7/lyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766657575; c=relaxed/simple;
	bh=q6TGceaWJjeYpfrlr/KxtLFmArYwINx+82CwKXi4upk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZS0k5SyHC7UH+fmd6/kQ6163fQfrcN/QfVxAIrLm1tYSqGTd61iz2Lj0fKYt5XnJKLPLNeQeNnc7fN1hy282+AQhgGK0PpvEuV6Vvcg0wEAlmCZ7H30JEYQgPIn3Ixk6HgwpaUhbIjh6WCJG6kc5u7h1LgRG4b372dCdgG+XDBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAL07QMO; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAL07QMO"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64b560e425eso8323868a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Dec 2025 02:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766657572; x=1767262372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWjMubZISi0FTDGXhZSVtiNSbKzg5CT4V6iUAxgUYJU=;
        b=CAL07QMOOrQxbZjpiFDrXaHbp1sYEh6jbd2YO84XUw5gaojNRcvLfvrfHXUOau1fdx
         1/D0jtwFJhhV0qfLsf6wtERFDAmaA8g/jWYL0MYmR+PHoVVpmjB35RFM1wpW9sONvcsA
         is0piMZu8L4zqZ3Hr03Fc4xbEfAvAgfN6Bl6ZwdxW2IR1R5IQoa1AjoiOjUfZ5dp5HYG
         vBOIF9Z3lTHCckL81wZHLj/gBW5cpZzCUO1JfMT3GYwMun247wA08B9UbVxmFIjMQdBw
         7kcwSwSKaE0Cr50OljdalTz2+ZVelmpXBZGj7B/vf880NhKgrmZztVyQTCD8obBP4hgc
         Ucmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766657572; x=1767262372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nWjMubZISi0FTDGXhZSVtiNSbKzg5CT4V6iUAxgUYJU=;
        b=VxHdCOtzsglMbXIXlz62yZsm/k12duAYGGFO/TgVTV56ye8HhBCf8hIivB76juvRfT
         rf5KxdLZiwUrfAXuwxEC0nsTTUzByvXO/5KiceFnLl9QQWBGaeVa82w0DspUw10UFSxw
         BncKOcCYuZdlqZcNOvjpB+TWOSMe1783+a5h8L9dTA9SddEpkHacvInegnb4kWLVRmBI
         vsuAc3X3hf4zFAX7xD6Jr0A2JScK45r7kk+ka0O4e/G0/AP63KD+zEC0vj0qhOEaoL0b
         /tKQY+MHbCnz6HIUAvyf4DMFk5iMrUW7Xak0jn7F3Br7b2juRaWsRQHdBEefpj+Qk8+q
         6CKA==
X-Gm-Message-State: AOJu0YyD3XGun1EmMFCrb2jv3b4KiVvCy/1RrZv4BJqCgFo+qoTfjkUK
	qLgkTBlE5JXysDWAxECRPyltuHHejdXf3f43T6CRXkqaMT6+qi4h7mNd
X-Gm-Gg: AY/fxX4aizJA8pAP+TvLJQIM0m9XcxFKvzoFheHsaDTnegTCDa+wAjj/nAK/GvqeFlE
	UgDjWB88CgLPZUV7xLjiEdWR5iBBTaX64An6dAS3RLq9htkaAL7vjpxu8jBRiosSw+CpNnWYi1E
	AR8PDcmLNpnGDOikdRgjeDtzoL9zz/VkPgXWcIAKyhBXGTyCEGOGLpWbmRhQoFn5QjN+XGrHdN3
	vY4rQj4CyJkJGG5n/JaNM1KJHRLqstwk0cg+bk2sk7yf677ojMHwLzfNb3pTOwJD1OHH9nUiEJE
	9tDcAkdg7cWx7QVndXCAHoJnwV/iZCV5juoxjBQWneKviZP1rEqDMSylLPBawB1fMvf4YEz15uS
	m+5t96QnO76/o4ybsP08fTQLT/rMyqHnsvGTUi8gaVYhfxyKvmdlLRwCi7kJ6+24y/mcKZd5ngU
	tb04zuhE5XaWx0AQ==
X-Google-Smtp-Source: AGHT+IFZI8cfw4SGRY8yu8Mc7PJ+owBERWrm9PETMeb8mbCXlfK1Cnq4ASL9Fz/YTqRdhnA/NgPbsw==
X-Received: by 2002:a05:6402:3586:b0:64d:88c:c2ca with SMTP id 4fb4d7f45d1cf-64d088ccb1emr14717333a12.28.1766657571677;
        Thu, 25 Dec 2025 02:12:51 -0800 (PST)
Received: from prometheus ([85.11.110.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b91599605sm19261043a12.23.2025.12.25.02.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 02:12:51 -0800 (PST)
From: Szymon Wilczek <swilczek.lx@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+4d6b203d625d2f57d4ca@syzkaller.appspotmail.com,
	Szymon Wilczek <swilczek.lx@gmail.com>
Subject: [PATCH v3] Bluetooth: vhci: Fix slab-use-after-free by cloning skb
Date: Thu, 25 Dec 2025 11:12:42 +0100
Message-ID: <20251225101242.23142-1-swilczek.lx@gmail.com>
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
The clone is modified and queued. The original skb is freed using
dev_consume_skb_any() which is safe in atomic context, satisfying
the HCI driver contract to consume the skb while ensuring the queued
object is distinct from the one passed by hci_core.

Reported-by: syzbot+4d6b203d625d2f57d4ca@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4d6b203d625d2f57d4ca
Signed-off-by: Szymon Wilczek <swilczek.lx@gmail.com>
---
v3: Replaced kfree_skb() with dev_consume_skb_any() to fix sleeping
    in atomic context warning reported by CI.
v2: Moved fix to vhci driver, using skb_clone to isolate ownership.
---
 drivers/bluetooth/hci_vhci.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 2fef08254d78..7c72c635965c 100644
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
+	dev_consume_skb_any(skb);
 	return 0;
 }
 
-- 
2.52.0

