Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECDB270540
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Aug 2025 21:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755294266; cv=none; b=ASaBWQUFHYtsmlOtNOOUJu7qQrkATlljwxjgYyBMjFA1uOcG/tnu/mx/bRINkA59FMmygNrDhWeCxPmXRf67wvT44Bl+UTkNeUqw7ulhxMgdoZI+b1kzW1nrLpmpFzgk37/s+b1baTY+ohtC+LijEccBNaRbKLRv5/6RXlxfnjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755294266; c=relaxed/simple;
	bh=cfbULKpfGK//dmoImA34B0ihmVFMSk6kO791MumgEIM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=miMhZ43OJCzQpOjP4mr56yvAqlSZR6WHip+E54gtHpmvbFLlSaEzNpGCpNm0Y6Im3+CfeDCxgLPXgMzdw37+rWrc+WQ0jLTw553Rh4wTlGvs6/nHGSLVGz5GZ4/ZkgTeHHf7W2KuPCPeMbK2ERD5b/jHBqtCaDUscVGzrFYzp/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFyMvWdM; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFyMvWdM"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-53b09bdcb73so2531733e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Aug 2025 14:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755294263; x=1755899063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PfyLExJIZRIDV96kK0zsVNt6NMv2kum8BM3bnt9BFgg=;
        b=AFyMvWdMIVtEnjKvhI2Kc9wrCDzDDu/XcO1WDQ8A61ArEzD3LSrcVwuX3b9Lcp4m5M
         FUpCazsHQCo8PX3S8EzArIKFLZZLbtsjTgoCCh6BYSszxlJwkVL4tfjnFON8XudCrpYg
         MYPRHAWJkV7nB4YHbk742P27Gr3ot7oPinlyNW1kHsCFm74Z5KDBNa+a9FYqero5i2ZO
         /nFd4HQjB0o2VtS+aHGIQYZ7EF0MTLD3aVL9DNP2Mqh6rd0fH6NvC54BZ0ZqeFF+Iizs
         UTTsapVRRUBN/g9YhzWSX3yIKlS0PzxNFsh/7ZnI+wYBXkz9G8P0/AS5TalQCx8yx05B
         4jQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755294263; x=1755899063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PfyLExJIZRIDV96kK0zsVNt6NMv2kum8BM3bnt9BFgg=;
        b=EO2uvCIrBYHMOWe1Rm9lKCH9wJCOS1mOPKEoEFBVYlub2HtaKItTaIPIHNx/6j7D5v
         hfet/h5R3RBd7red3/b/UaGok3r18G9fXYGfpuyxfiiCdsy4BE6od7A+FvElGIdsnMWe
         dT0VcLnO8mjVDu51NJURnP3KiHob/RuTkNKZwTlYxV+SSPxFuKx25372Sa/+bBLMV9dC
         5wQao+Kcxi1Lcy72zzySTlHgeFmgB+ys66WWESAD6W2LNeoZ+bgeVLfWNBArrBJ6wJxP
         Vu32tW1USkImsZ4l0I1lcsW7RidqvdWDlZYdpYuZ6ZT8SvXKO4J4y23KpxtxEkg3x+V6
         tKeQ==
X-Gm-Message-State: AOJu0YytFeonoTizFLc/hBMOrnwKRxhy+fk9QTZl9GD1ChTVAfTPbzRl
	WUd42spGouRs78Mzm8Yrx8R6PbWHJa7suE3ukCp7cUAFrI6MRhBcHlApnTJzHWc+
X-Gm-Gg: ASbGnctCrl6fmogRbS/tsQnSJEEH96dFeukHZtsPuQGATz+VvX702aKKee2AudRuos6
	3Yl7hz6drk2nQccMwcZ4BHPU1L/LqmABhK1CHXCYf1rzs7OmJ1Cfj4zPzigZ4GZ3B9lCta5Ig8x
	FPb88RLq7Yl2BptwvcuJdJjGLKE7n5lripMqAPrwfwfqffIDF6bFdlmdfPq6DQHKigvclDIbIoS
	A3kNgs7K3jCgUomzTpDakyH7QxohCJ4KXFSmKttfSQxwoj692qTjbMpqRvru+yRJUvXu9oEf5GQ
	SlFkaHBa7KWwQE4Wakh/S2vD9k+jL6whl9sqkC02Lh+ApjVZyW6ytO5SBQR5gfCoU9CqbKo1YUN
	Y6UlSpw0C6oba0G6hYOJeZMfqwTkHkMRl2J2BEOVIsX/eWA+hrYx1/mx76Juas6pO7QkiBwJjcl
	MpZyZxhZgB3g==
X-Google-Smtp-Source: AGHT+IHKruTkXgkWQv5iL35sIMCWySO3tnxddh15c19ujqu5MRML96Qc/1gA2W9LVl/+tRi6bmDkFg==
X-Received: by 2002:a05:6122:6585:b0:53a:d808:1ff2 with SMTP id 71dfb90a1353d-53b19c32c7cmr3602329e0c.1.1755294262803;
        Fri, 15 Aug 2025 14:44:22 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53b2beff1c1sm472053e0c.24.2025.08.15.14.44.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 14:44:22 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 4/6] Bluetooth: hci_sock: Convert instances of BT_DBG to bt_dev_dbg
Date: Fri, 15 Aug 2025 17:44:03 -0400
Message-ID: <20250815214406.514260-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815214406.514260-1-luiz.dentz@gmail.com>
References: <20250815214406.514260-1-luiz.dentz@gmail.com>
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

