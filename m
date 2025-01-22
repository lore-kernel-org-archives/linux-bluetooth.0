Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C0A1A8419
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 05:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737523262; cv=none; b=Vtftfov6JG+7zUJGn8roBkHUyk4vBeSoPkc0CC7fA9Bj9gb4DlMV6xdqJmXCjj0fzZMc2GJmFL2H6Dq4AKSJKC7iTTxG/hoMdeiOM/cxNcwmDZGxm3jsblMF5s2/VDOW5WPiBDv0RetQmIFXzjSljk/bki+O3HU4v8/nWUnsaf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737523262; c=relaxed/simple;
	bh=Qhkh799K+yyPiAQ9JNfkcwuelIGY90tmfTWVIa5Pi18=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MT3Es2wb65WE2C7g7evhnHUNTt8Bo3lqp4A1winovbOdFFYTvtYmWWsSGtBpq/rVtO+b2rlOH8eHgGKrQs458eCsc33lxnNW5VTcv4sE+97Bjy1JBpUHm45iOchQhhNaLL46Q5if5byOD1+URB7gqI6mhU0K3icIY2jqnBJkoe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TxojXV6O; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TxojXV6O"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2163a2a1ec2so199922955ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 21:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737523260; x=1738128060; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bSPBwvKYvguZInPoYBw9TBpllTosgpEh9yMZr7TxVOE=;
        b=TxojXV6O5sfolRWqC3ZkbhPZBYElA/ai5FSw/EdFCoG3RwT1KLmTurJ3LBvHzvQg84
         bCxfcQ4QVSQUDjYS4If5GRSh+qleV4rrqf7OtVIxsgOYvF+wYZUAjfWe3/yB3xW07nxT
         hCDl/nktz0khXuxF9BFPmyoOlRP7M3YL71bm163lwvOAkyQDeGEaU9aIL/mIrxOUg97c
         WElyvpmHxF8l/xNYVOg3EIqd1N1X4/9lbUdNrdWUwy9emk62xhPKKYpmyQrZ82DFl6ya
         e6QBjtzd8chMNNzE984i8bZrE7XiM8upuUlSbqe9/QMQa8GIL7pi0DNQ7coLU1Fiyd2i
         1nDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737523260; x=1738128060;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bSPBwvKYvguZInPoYBw9TBpllTosgpEh9yMZr7TxVOE=;
        b=R9vydC2WFnemNdKYXHGoT4NA0hTtz7nVwI+VyBX6RB9CkiYJ4r1eHSseyaADRmrpRb
         vT+x+2L9/xPNGmBLxLSEU4mnP9MMuQICHJ9yAWyubDchB20IVDxwR4j+mrwpiCwBfi3v
         y5KRwTUeNUWoFv7X+e39IJMTmyPOCNS+m6GOYjyZjRpVkTZkeV4/vhz+V2lOa5+4R2sN
         RHUu+YzqmMwxqQCv0hKBZxVh6VNpP3aaOayKNPK7yOA28g1Lr7KJYkIGWfRc8+AR5Tkd
         yUobMsKn5jprocu7kmXSwg98ljL9Th45+ikFj8T9K/WFVcXQlGNSjmAco3kZJw/LNqIJ
         Jx4g==
X-Gm-Message-State: AOJu0YxYWoMpUXNb2JqzKDv/ixZS+DH7rTy3PcBX5QDED/rPHYg2mZ6C
	gQtYELHZVpOmLaO8E9Bv4d9PHbXYMJeH2gswBBJ9pQWxL6mDhLac6ZYy6mL7uo8iyZkct8gzAm8
	BuslxtDQuYtkNWxWnCoeEKUyRNWGTf1aiV/rxIfzxuv1XlE21qmKRP7OaBrzuSi8qpQo52MH/ft
	RTrXhJSjU+WVW+Kd9YDZVs0OtoXyJD+yJTnv76P9edJHGAMtgQ7w==
X-Google-Smtp-Source: AGHT+IFlrBSmWao3+0MyCPymXOJR9zgksXH6ZKuoFGvYzaisnesEfS4OM+Ixw8sSvrN9lWtrRUoQSV7Klz0o
X-Received: from pgwg11.prod.google.com ([2002:a65:6ccb:0:b0:7fd:5126:2bab])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:72a3:b0:1e1:dbfd:1fde
 with SMTP id adf61e73a8af0-1eb2157fba4mr30670475637.27.1737523259477; Tue, 21
 Jan 2025 21:20:59 -0800 (PST)
Date: Wed, 22 Jan 2025 13:19:26 +0800
In-Reply-To: <20250122131925.v2.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250122131925.v2.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250122131925.v2.2.I6e9e94dcded65e4a9ed42ad23ca8a5d81f680382@changeid>
Subject: [PATCH v2 2/3] Bluetooth: Always allow SCO packets for user channel
From: Hsin-chen Chuang <chharry@google.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Ying Hsu <yinghsu@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Hsin-chen Chuang <chharry@chromium.org>

The SCO packets from Bluetooth raw socket are now rejected because
hci_conn_num is left 0. This patch allows such the usecase to enable
the userspace SCO support.

Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control USB alt setting")
Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
---

Changes in v2:
- Check HCI_USER_CHANNEL rather than just remove the hci_conn_num check

 drivers/bluetooth/btusb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index bf210275e5b7..acfa83228b25 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2104,7 +2104,8 @@ static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 		return submit_or_queue_tx_urb(hdev, urb);
 
 	case HCI_SCODATA_PKT:
-		if (hci_conn_num(hdev, SCO_LINK) < 1)
+		if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
+		    hci_conn_num(hdev, SCO_LINK) < 1)
 			return -ENODEV;
 
 		urb = alloc_isoc_urb(hdev, skb);
@@ -2585,7 +2586,8 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 		return submit_or_queue_tx_urb(hdev, urb);
 
 	case HCI_SCODATA_PKT:
-		if (hci_conn_num(hdev, SCO_LINK) < 1)
+		if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
+		    hci_conn_num(hdev, SCO_LINK) < 1)
 			return -ENODEV;
 
 		urb = alloc_isoc_urb(hdev, skb);
-- 
2.48.1.262.g85cc9f2d1e-goog

