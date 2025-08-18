Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D4621885A
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Aug 2025 20:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550090; cv=none; b=NdS9bx8LE9DXAAPkyM+Z1qKFC3BN4ynPu2bCzaYyWwyWgR48aaNYDpI7xki8cIvyNrlYnDRYzxGXZOq3uyiBRB7BmCfhY+fNG/zEHPt6+zwYVj16GenQYlV/37rn0vKs8LWh60EfsMKOWAxLetzcXxvc2SIymdCI53hBVqqq5gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550090; c=relaxed/simple;
	bh=cfbULKpfGK//dmoImA34B0ihmVFMSk6kO791MumgEIM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WfhgdKE3q0aD1DIIIGfYDxr83QEydIK9aaXec1jALkIaOokfhNipOtZiiCexwFJSt78lrfIgyKHyrN5KWuA1Fw23Yf0Np28Dz/brEk0D375mAIfObuWnJiHD4aYl1BdrWgnC23hZRDiB3zcVFttKsdiJXzJy5/idb8shA6eIKuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3fqx2AT; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3fqx2AT"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-53b174dbfceso1584410e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Aug 2025 13:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755550087; x=1756154887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PfyLExJIZRIDV96kK0zsVNt6NMv2kum8BM3bnt9BFgg=;
        b=C3fqx2ATIRpGMqMjD7Agzt49V8PgibtnKWEeFSQg0VaFGLTJEOzkz/xlZzYyztGuQj
         EJtkSeefnppmWeL23aXWvEJxTFdhtR9dCi41t6s8s29WBfy4MQlDQ2qQE2UKhwF33jWj
         jB7OX58wjwCuwc/ZajNTrb5st9C+0KmiGkdfzBxY08+iCz/ykv3Dian3k9wGIsnnxctD
         X4CAcQpoJC385PWIwBotVbuRoiVSRWDz6sWoo3+yMHtQx19LhhLjKJLOn/anGorrBY0B
         SSUVPs3iqU9FqLOM/CPFAUZ0HB5plXOd4qmLmu2yECt9S+8tIhT/pb0CktPME/X/udo6
         E0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755550087; x=1756154887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PfyLExJIZRIDV96kK0zsVNt6NMv2kum8BM3bnt9BFgg=;
        b=V//o3KeuXSjqS7HCgy0qjHYP8L+OxmGWmAjtmSKV2bP2Brzthh35gM3b320D2Tglj5
         m6ySqKJg1Vvw8c5bX0kqvMBTvrTh/7aZdiKfBKjFUccwGOcm86G662ozRR09OXYfUTW1
         7jwordqzx5DOEt4xqdic6hzERhl/7kb7MPSuz1YtSNIgas5kGCx38s2hYjsglPs7spHr
         Zc2bMIq3nylv5d6dHe/lid2Ye1pScXBHogRcbEYUtggCKBLY/eecGKxQ3JuUhZ851TXH
         tqL3psQH48dUO2tOCITHBId3XFuz82irzkyJXboNXZgLoMPJHl6X7Og7V11+fIceoL1E
         grtg==
X-Gm-Message-State: AOJu0YzvmwD2QHZX/87Pb8GXAs6xPvTaa/oJOmyJ25vsuiHBnnMfhTA6
	qN9g1qVhg0nAm5BV686chnMmcYJ+lLmyFofyOmau1qIBgUhq0K7O+a3ULJQPQMcP
X-Gm-Gg: ASbGncuRZ6p3oqEkXvpfInuYz+Xb2nja3i0hTyHWYIZy5nyb0+/ZbPRhDRfltHrNk8X
	mKnHJfRET46cVGMSP1oKwTZq94l6oYQ8gTRtEifeM8LVXReGMC7jB7rNYClu95lhj3Ynf4LvQ7w
	p6zM0AG61sWd1Kat5rkfqusRENIWEaNs+Vr8Qz9ZArKZz9PcjeNAZAwlc6PWOiVJ1h7Z3db4yrQ
	w7WNGsU5itgW5MxLufcPcz/XiviLQFwrJ+XLczgFtbCe8hfKSEv++HRgqe2nKnsYCdfw/Vbc1Nh
	avToZBRzXEbfgCnel4+oCmFp6GHtOoq0jDHmBpgw1sBqMC2s4riuhIv1Q6NHHpuhbEGc3DtH+KE
	X2lA4id5ujd0zRnwtK9CONkT87+4TC+pUVjpPbDf6DUAZUpa8OKWckM0wCEwpCg6hEkP+agH9Un
	YR0HkLBTzC7A==
X-Google-Smtp-Source: AGHT+IEWcGV81KCQ+mzLfbWL9DsYI2z+JSCDYHH6VRaY3KeDLjNcTIk49+4eD8QPRt9Gv9P+EQbE3w==
X-Received: by 2002:a05:6122:20a5:b0:534:7f57:8e30 with SMTP id 71dfb90a1353d-53b5d47e550mr56483e0c.10.1755550086481;
        Mon, 18 Aug 2025 13:48:06 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53b2bd553casm2101079e0c.2.2025.08.18.13.48.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 13:48:05 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/8] Bluetooth: hci_sock: Convert instances of BT_DBG to bt_dev_dbg
Date: Mon, 18 Aug 2025 16:47:49 -0400
Message-ID: <20250818204753.1203949-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818204753.1203949-1-luiz.dentz@gmail.com>
References: <20250818204753.1203949-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This converts instances of BT_DBG to bt_dev_dbg when logging to a
specific hci_dev this is preferable since it does prints the name by
default.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sock.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index fc866759910d..486ca9254688 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -205,7 +205,7 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb)
 	struct sock *sk;
 	struct sk_buff *skb_copy = NULL;
 
-	BT_DBG("hdev %p len %d", hdev, skb->len);
+	bt_dev_dbg(hdev, "skb %p len %d", skb, skb->len);
 
 	read_lock(&hci_sk_list.lock);
 
@@ -365,7 +365,7 @@ void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!atomic_read(&monitor_promisc))
 		return;
 
-	BT_DBG("hdev %p len %d", hdev, skb->len);
+	bt_dev_dbg(hdev, "skb %p len %d", skb, skb->len);
 
 	switch (hci_skb_pkt_type(skb)) {
 	case HCI_COMMAND_PKT:
@@ -810,7 +810,7 @@ static void hci_si_event(struct hci_dev *hdev, int type, int dlen, void *data)
 
 void hci_sock_dev_event(struct hci_dev *hdev, int event)
 {
-	BT_DBG("hdev %s event %d", hdev->name, event);
+	bt_dev_dbg(hdev, "event %d", event);
 
 	if (atomic_read(&monitor_promisc)) {
 		struct sk_buff *skb;
@@ -1625,7 +1625,7 @@ static int hci_mgmt_cmd(struct hci_mgmt_chan *chan, struct sock *sk,
 	bool var_len, no_hdev;
 	int err;
 
-	BT_DBG("got %d bytes", skb->len);
+	BT_DBG("sk %p skb %p len %u", sk, skb, skb->len);
 
 	if (skb->len < sizeof(*hdr))
 		return -EINVAL;
@@ -1655,7 +1655,7 @@ static int hci_mgmt_cmd(struct hci_mgmt_chan *chan, struct sock *sk,
 
 	if (opcode >= chan->handler_count ||
 	    chan->handlers[opcode].func == NULL) {
-		BT_DBG("Unknown op %u", opcode);
+		bt_dev_dbg(hdev, "Unknown op %u", opcode);
 		err = mgmt_cmd_status(sk, index, opcode,
 				      MGMT_STATUS_UNKNOWN_COMMAND);
 		goto done;
@@ -2200,7 +2200,7 @@ static int hci_sock_create(struct net *net, struct socket *sock, int protocol,
 {
 	struct sock *sk;
 
-	BT_DBG("sock %p", sock);
+	BT_DBG("sock %p protocol %d kern %d", sock, protocol, kern);
 
 	if (sock->type != SOCK_RAW)
 		return -ESOCKTNOSUPPORT;
-- 
2.50.1

