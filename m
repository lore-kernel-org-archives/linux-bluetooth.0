Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55E8394EBD
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 22:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789856266; cv=none; b=PSnTBhpSxFKKJ4DUitaZ1mZJDg36/bSKqvmZAOEOKC3roPWOYc59Gxn6fJEOoZSUoZl6+jz36mf1KyifzjT3Qc5DX7NMzomYok/LdeuuOzKRxOjrrLEorcoixojQdVSc9MWrecMDub3FPX4h11SUUQldUe+FN4C70C4eDF0DmuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789856266; c=relaxed/simple;
	bh=YSHkjkJs4CsY0ILw6c3tAHOBfJsRlxF/vuZrLf/ebGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=clAyIrwC5CxGSGTETPCiFRhVgm8HI0xd1gw7OUi79V3Yk8zMkOXbc6AGYIVw/s8EAnIQPpSQk1jLQXRF0jOM6q3oqvGDeS1LHfW8O9LiOa3CW5jpdE/krhuE02x6WSOkpqK1Pw+k7L0gs9oeYeDXCn7nQEnShHRLxCGViiAvCEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OP7Lfp7+; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OP7Lfp7+"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4c08393dfso1519108a12.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 15:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789856261; x=1790461061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eqiQzbKzMiEybSTxBW9L4SlPZ7ERZ8e3u4vm4ptlPAo=;
        b=OP7Lfp7+eZ+ZFtMlR1Y8l9bBBtMRkC+RicGOdgFGdfvQ8te1FyIz5GUf6TMEBjyJ1g
         3oRLD0/En1x+gJB5qYsVBBH3WLbJsS+okRHT7DflBlOxCHHyq9dvzZwoDzg9tCgTDvoF
         FUbMZeZeO0BqbR/UldHPOTBjskA4mJjUhbXzV102rMfp+voS7CgYyMh9VF3Ra+2f1VaW
         E2g5ZDfKTxhuG1l1xD5z0lBI8Zgl/kKFaVeU0L4//dU2lOqu+KYqxuq+FtD4NXx9r904
         65d2cqW+Ncjf4UDeaZT7Qh+ib569NQUmlgCk+JUOHFBGLAZ6MLwA93pU7CiYE6pqzEdl
         1Ovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789856261; x=1790461061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eqiQzbKzMiEybSTxBW9L4SlPZ7ERZ8e3u4vm4ptlPAo=;
        b=wDO3aFFTmtQlV+/6+l11Tq24nw/fYZS9fFWfxsD/kZAle7Yv+2sbq3M0lWSmUSnkgu
         sWwwb3DnJMmYASRjyqiimzQaLIeZLfTg9UmATkdfLriFrd05TRCJ9/kDLPBRZblB68vJ
         m6VzsJPHJjNpeRhG3afnTBdCjVtUNW2K3aB8cqB0cKY1gsIRKwUSy0/8QkZeTGjpjxKl
         7hfNZ2NOXxIxRGJoRRMrokPxpclNjwgJCTeW7GfwFHZ4EAS0lhXZLp0TJamw9LtpKmv5
         IHD3UVbr7uQ2KkuBPsnjuqvAXxtMzcYFW5Lok9J0dv5fkzuFbNLD63J/wspocDkoxbh6
         74cQ==
X-Gm-Message-State: AFuF++nagnUadp3zpdt+flYEOPSkOdz2M/iJiQyTyXA+4Md6b2vThbGx
	FDWgyAEJ07a+ADWWuOts5hD8PLJvnnE70MX6dXGCKwCFR9pB4XIG86Tk
X-Gm-Gg: AYBFou1zr+RZG+X3l3XXA7ZAni/GW8KsTBpRnN5HPbcaAQsZDnYMYBkNt4cTmdQ/id3
	oY9nUOvYUK8sCoFi+xQmWk715eHbAz53Ia6Ciiyty4n0O3DK/k9pFc7nwL7cYMQHrrkQj7HqC7i
	UvsoWgR1VBfrYg8aGOPJtRuFi+KEcu1lbKtRsf9nYgX6DvcjkbOhCo2Ml53bUDXrH64X96PSeKh
	UWhSYxyNdEzJQgMn0dUXd2/CPrii/kQuQ/wdbgletavWAL+WfZwY/gQB3L0PIqKGGozJQmNs7BH
	uDDGLQRQagEgDkILwOjbsjzZF9DWsAr11st1Y7TvSXCJxOM45G+K5j0jCgO8lbbl9FIunGepiDL
	eV4WFhbgDPzYzIwIrWbSN9MMc8yHKMmBIIj8GN+Eh58pLYdrwR6VQK/g7TZlZlY4sVOcXdxnikT
	c2J1Zm39BT37qho2bfCe37UN8pk9xMMF/vCzma8MqQrs/mpYqBkMX9HlR60Kmi4oaqXZ+qk49K3
	YFJBGsjQ7VUr/NwX0Kur+SV+DHSNOrkr74yPyk2r5ABVWV5UgrIIE9sP+Obpd8K2BLqu2ZE78YS
	dx+S3caDEw==
X-Received: by 2002:a17:90b:530f:b0:39e:4c80:44be with SMTP id 98e67ed59e1d1-39e54e277d5mr11840903a91.33.1789856261250;
        Sat, 19 Sep 2026 15:17:41 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6ca4ef3esm6328976a91.1.2026.09.19.15.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:17:40 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sock: fix negative cookie IDA free and short event OOB read
Date: Sat, 19 Sep 2026 22:17:39 +0000
Message-ID: <20260919221739.3708895-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In hci_sock_release(), check hci_pi(sk)->cookie > 0 before calling
ida_free(&sock_cookie_ida, ...) so an unallocated or error cookie does
not trigger a negative IDA index warning, and in hci_sock_sendmsg() /
hci_send_to_channel(), validate skb->len before reading HCI event
headers.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 070ca388f9ac..ab960cf2efb2 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -115,7 +115,7 @@ static void hci_sock_free_cookie(struct sock *sk)
 {
 	int id = hci_pi(sk)->cookie;
 
-	if (id) {
+	if (id > 0) {
 		hci_pi(sk)->cookie = 0;
 		ida_free(&sock_cookie_ida, id);
 	}
@@ -177,6 +177,9 @@ static bool is_filtered_packet(struct sock *sk, struct sk_buff *skb)
 	if (hci_skb_pkt_type(skb) != HCI_EVENT_PKT)
 		return false;
 
+	if (skb->len < HCI_EVENT_HDR_SIZE)
+		return true;
+
 	flt_event = (*(__u8 *)skb->data & HCI_FLT_EVENT_BITS);
 
 	if (!hci_test_bit(flt_event, &flt->event_mask))
@@ -187,11 +190,13 @@ static bool is_filtered_packet(struct sock *sk, struct sk_buff *skb)
 		return false;
 
 	if (flt_event == HCI_EV_CMD_COMPLETE &&
-	    flt->opcode != get_unaligned((__le16 *)(skb->data + 3)))
+	    (skb->len < 5 ||
+	     flt->opcode != get_unaligned((__le16 *)(skb->data + 3))))
 		return true;
 
 	if (flt_event == HCI_EV_CMD_STATUS &&
-	    flt->opcode != get_unaligned((__le16 *)(skb->data + 4)))
+	    (skb->len < 6 ||
+	     flt->opcode != get_unaligned((__le16 *)(skb->data + 4))))
 		return true;
 
 	return false;
