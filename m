Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794433772;
	b=FIifSr7TnqTNIts+wkaEjf5eCvuQHcCfFC/bgDcjUkJCUPfDDm4WQMy3Bqoq3UUIW2Fw
	 LN4/uzpyvFWYDl51HavDTtn+9OojtmOvnfKy2LqE/05qJxEq3MztEc5HS8AZ1llmHXdwE
	 fSwdzYAjewoAibNpD49qVErCzw05Htl9NJjU/YQ8EUrQjBQvR1QxRqpzSeJ2qxM82qZ5r
	 SkVmtaYbSty0RjLyalPwX1XKLZajuKTXv8REQO0smwe8xcXJ1pD3XEq881RvhuoS1WbGH
	 WQiuZ970TKusgIrHCTrTvdXjH70Q4QZ3x+isPZHSUb4IGGmIIuvsB0Cy6fGai/ptFsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794433772;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ghwIfE96OI9y9XOfb0MeMDcamu6SW78slBiWypbpbcM=;
	b=Rw40MoWjjN+m0SnbDUujUT1C8Ouyw/t4uK9LEeLnMLAChAvJ+aNgKX4INv9wvKB2vCRm
	 1bwFbwzMfGpcEuwEbUP8WAXBz5x5zZ0HlagVZy533DmtyomP84cMJxz5+3qLSVUj1tB2J
	 ToJafE+36inHo7ck638Bfn33n3g97X7ALudx+fsI0Y3YQvdhfdVS0awpGcP232uq4Y6hm
	 KW8eLDi+JrvyxIofrM2za9yjbYciC23vbGFiRCCVK6cPoIsHeqgHxlK32HYg0KaDCVg6k
	 FrGaJJxyTXmjmMqA5EH7EJJfMEwFW8Ots5+T/Eg7B09aypbBkQ0S8wqKYPCkwPvnh2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=udAPqJer;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1763606A326
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 21:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1763606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=udAPqJer
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-825b40f8a26so1667191a34.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 13:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794433771; x=1795038571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ghwIfE96OI9y9XOfb0MeMDcamu6SW78slBiWypbpbcM=;
        b=udAPqJern4cV9Bh6LXrHWrTixhlYTe5DhEO5f2N57XeXVF8uCvHX3eIxz3FsbGtyW/
         b8+wiGvyDwZ5yRnDkKd+4vLt9tnUp98WyhVDuDPYzBC/mVCO2VEMWpRoJl4nuVUTvRyi
         oOzgYIt3lkmmzEuTTVxHkPBnCZSHSm5k75ZG4blFcHdWdV2L40kzxBGwqTmxMDfY2Yx9
         oyl7Lmq4qbuoAazcMDvcJZKKWw2AaGyV4Wxw+sehEq1qXy2Xb7jZHHzmcdEPnvMUDVSI
         ysuvj16vQIUd7dHDJ201FrLoxGpQOIIx5BWwDyBBYc1bc5qDbes42p75NLr/p4UPPxMd
         +yKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794433771; x=1795038571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ghwIfE96OI9y9XOfb0MeMDcamu6SW78slBiWypbpbcM=;
        b=zX+ZoS2DHBKzDBHofm6DZLow99QzMOt7DohTEGCaDTkN5CXYIZrAZlN9xq4sEg4wrY
         mOlFslebYYcAt4Ywl2UUoj/cXrUvH45uG0dJYj92oDDv3sb9D2+sv8MAjTy6QvPbTOxN
         oZIx5LSZEHto3kwc51iXYXDXO/De30zN3ZS7wtLg7OIdHyat1Ygfj11IbpqU+o7suHn4
         575VxWNcEnQhUuG/yEJrZxn37do0UJefyBn7Om/OYeG4+aNidw6QIqLilfcf5D+ZBG/w
         UYzS2CMOXY/c6bADYGlCke+CeR2Sn3MmVyHX5nOltmAA5skQcebMyqoG/B6bWCq8xSZI
         Jd8g==
X-Gm-Message-State: APuU4Z/FGvN4nhVpaDI5pbCU56LOwHw6HcJnTgBrSvLSlpmJFRs+JlWJ
	9ATuqTeQAGwEa8Tzslv0pam9wzctTFVdAFxPacknfX+ZWxA0AvFgPkBjYoFbub2e
X-Gm-Gg: AYBFou0RhuRzJWTuUpDBmOp9ie/dJE6P/vYiA9Q5a8PscKvocjQyBRTlfhpBNgY64/7
	8L2xvmZeesP3Lppz7Xn5tN+S3eTvaZ4ph4mjY+FExKd+OPJpVfb7M//QnuIb44izfXAG2hr8QxM
	twlYpI21B23nlg/Zam0uTA3Ix/xRD7Haoy6PwjKZ8Yd7+YFsthCEv0PPFIe6bfkQq9+Qvqs6zFg
	B+HGkdFcp+cFusBrfDAGkSNfnl207Fl/OYzwtzAIeKhfF8t0ixmkBZEPL4en7QaqCoOcxH9iUo2
	LnE/uXFfD8Zu9ct8vPqN8Xe/QkAoIrP6BgN08pJmAlZSKpcL3LWYdp1NvMKxDCV6n/J3CEp3Dfg
	v3Fq56t3Rz12i7Ex3ODh6ir/qKmfpSI5NrvoDLS+H5TEFbl+CXnCuwAIWf62P6RbxnTyXWwJRYF
	M/bkqfsDebNZJEsNPAyaDt3Hf2WwVO20RiLsmoKGe4/0IaYdfqvxCmVJvK/rn8AQxr3/RK9naHX
	m9OuB3D2/MLcENztI24gS+JATgnx8E3g04xo0N8PNpnZJXIgk7nK9QXngrHyC6//rCQINIIVuWx
	iBk5ZJo80TLT/6YvCzV9LXmQ
X-Received: by 2002:a05:6830:254a:b0:818:125c:f4d3 with SMTP id 46e09a7af769-860f28740afmr4236916a34.14.1794433770817;
        Wed, 11 Nov 2026 13:49:30 -0800 (PST)
Received: from en1.. ([204.144.167.9])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dcbebfc6sm5124610a34.18.2026.11.11.13.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 13:49:30 -0800 (PST)
From: Amir Abudubai <amirabudubai@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	surban@surban.net,
	linux-kernel@vger.kernel.org,
	Amir Abudubai <amirabudubai@gmail.com>
Subject: [PATCH] Bluetooth: L2CAP: Fix size check for receive buffer space
Date: Wed, 11 Nov 2026 15:49:05 -0600
Message-ID: <20261111214905.518429-1-amirabudubai@gmail.com>
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

Check that available receive space covers a full MTU-sized SDU and its
overhead, rather than just the overhead. Otherwise, credits can be
exhausted before an SDU is completed. This could result in a deadlock under
some configurations and SDU combinations.

This follows the SDU-sized credit policy from commit 96cd8eaa131f
("Bluetooth: L2CAP: Derive rx credits from MTU and MPS"). Clarify the
comment by replacing "packet" with "SDU".

Fixes: ce60b9231b66 ("Bluetooth: compute LE flow credits based on recvbuf space")
Signed-off-by: Amir Abudubai <amirabudubai@gmail.com>
---
The exact SDU length that causes a deadlock depends on build and configuration.
On my machine, 13090-byte SDUs caused deadlocks and this patch fixed it.

AI assistance: OpenCode/GPT-6 Astra for testing and analysis.

 net/bluetooth/l2cap_sock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 7a2551ef7f50..8603e63defb5 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1229,11 +1229,11 @@ static void l2cap_publish_rx_avail(struct l2cap_chan *chan)
 
 	/* Correct available memory by estimated sk_buff overhead.
 	 * This is significant due to small transfer sizes. However, accept
-	 * at least one full packet if receive space is non-zero.
+	 * at least one full SDU if receive space is non-zero.
 	 */
 	expected_skbs = DIV_ROUND_UP(avail, chan->mps);
 	skb_overhead = expected_skbs * sizeof(struct sk_buff);
-	if (skb_overhead < avail)
+	if (avail - skb_overhead >= chan->imtu + L2CAP_SDULEN_SIZE)
 		l2cap_chan_rx_avail(chan, avail - skb_overhead);
 	else
 		l2cap_chan_rx_avail(chan, -1);

base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
