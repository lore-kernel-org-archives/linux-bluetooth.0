Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D3D58E2DF
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 16:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788886463; cv=none; b=huA93j77aLC5HM2uCr13CStWnEJRn/c2S9jBjoDOk0haaPzSzmczA9zw9SjhasGlTUnE0wvU4zwKxP78U3cfT4k7Krpbx+kCZzjKWkfXspRUy4zPKSkWNlyevs005yGIzim0y99YEUiUVcoKxAfKgeIPdnaMt/G2DHONwZexhPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788886463; c=relaxed/simple;
	bh=vcvOvb7CfSolquWCtsTU/Hekl6HvtR3StQ5xpcRfncw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tY/PxA2gjQX5M4ZE5zLLhQKPD8GjD4qnxhvvMdXNpZ2qo+qsARrP5wB/t0haiTefk5EDFLf3/mn1Lcfb536mU2KHpFwv/PLSpXfp3toi4i6hNPqaJNOWp5MdNgWCgowMgKm/CMD1URuuCx0vpWL65C/ulu0WyBBOY6yUwZRx9us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXgQhtcW; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXgQhtcW"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5c681c2a6a7so1887944e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2026 09:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788886460; x=1789491260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AFZiJhCz1KLVTjd7DyHosxf2D5OIZoZsQdKvW5PZrSo=;
        b=UXgQhtcWV3gGTC6N/2A0ccnvmD8cwsYx7wapTYHiVwhbYbVH7QS3s7SYQoRdKTDHJr
         kQ0QP1TsaxewZN3kh/J4hmJzWck0NNyLeVJMdFFkf3PszlPW8c45Y7xeCM1+wAyBSifl
         SBMkJvqMG0txbbXouZXafAX0n39fdv6eSVslOGRBKfYNL1rhOXlUgzEzPbalHsDeygj5
         hFFdSjKX+WF2FVUIOvjVxiZkgz5wDg8Qv6rE8Yvh6hCpdU9jWvuuzuR1CXjCwsVG25R4
         mFJM4IRKJqpVIcFdDE4HkqqZLxqUuUxQbpzhpCq4CfWde+mlITeXfh1vMvPYl3WsLg6M
         txvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788886460; x=1789491260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AFZiJhCz1KLVTjd7DyHosxf2D5OIZoZsQdKvW5PZrSo=;
        b=eaOlpe1u69nMch39D8LMi/2paeZfNIUWfHDNfoACaBDtcueyIjEHW49w6F1uMu1boc
         pXBt29TOZxXXQ8mper+F5xPRl0Z7q3Ck2oHMfd9INHBSNLZO8SDQe+wf6ureyx+eVlX8
         7Uk4Cr+RDhbPmWbwLQJBkayJy0sF20IPEGMUK0fMSjL9jIB8c6DZgzTiheAOeFLC2P3F
         6DWe73Tt2BVFP2HXaFzYzK4PLj6vgHIYj6ThamNvuP/g7sYAp4WqmG447Zp/veHf3V7U
         Jl+qR/w2NWqpFTrqFd+41cwbjBGMjHI5XyQgqb0U5SqOSiRwRZQboh3A8ZlqzclqB9X0
         GkdQ==
X-Forwarded-Encrypted: i=1; AKwUvBzuyUp6TCSrjeCd3E+hkSBVEl7AiRUbe4/RTkVLNgRzSktLod7HRCIHnMjAUcWhXcHUAycKoUKLo1u//m0TvwQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mJbougK5EXKK0MeCT8m8fy9Ix/WqbSfcutjK70z3fuErAoqyW2
	FpeQxoTemzFCQd/8yNP608aXcKNZWaO9L3/Rs/OcoD1lL2VaQcQ1KA7y
X-Gm-Gg: AYBFou28tz7fb4RIhRWesZdbmMYGzZrBtDbx+RyDKyDoDphx9nWCjgKQgi+b+aLXIY3
	6GL5tDQNaoiHSs5RfnC/haqxHQBa3K46FFCnjI4vcX7BGOjxf1CYZD6aPcfDXdOJKd9Ah8mQUPt
	sIwzxKvKl2icSMXbzVhw5aQ6CPZQoVOExVZCFohXHWvJTHM8YXz5/CsJ4aJRBJcizoUB7ia5+ZA
	KDgx+WIO19YffWSv/DIHbmFCVKbCnFGpmv07y9dwSKyuCk7VyWaDT/qc5Nl3CfhJM/BXvezrjLt
	vg0FplhEadzHnTy1ve0rG2fW9sO3kYnxGcnCilKHHH06Q0yUAIrqP+2pa0Qrl1il0Y8eP5m1Hz7
	bVM1tscW9+BudnyAlFi/Sz+fFEoDSDjKEkamaGQsGZLXLMBVbv8FOv138BO87FfYkxusfWyPboW
	ONWH1gdzoSfAAFpAnnxrXqFz8/pGUl69mVK03kbVAYmWKuXhmeRxrgPIhlZq3Gig==
X-Received: by 2002:a05:6122:e189:b0:5c7:a9ee:dcfb with SMTP id 71dfb90a1353d-5c7ed3d6e42mr360785e0c.5.1788886460411;
        Tue, 08 Sep 2026 09:54:20 -0700 (PDT)
Received: from adriano.lan ([2803:9810:3d22:1608:9be0:137d:43c4:cc14])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c81c506f31sm2668280e0c.11.2026.09.08.09.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 09:54:20 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v2] Bluetooth: bnep: linearize skb before sending
Date: Tue,  8 Sep 2026 13:54:13 -0300
Message-ID: <20260908165413.75026-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel_sendmsg expects contiguous data. Linearize the skb in the
bnep_session() loop, before bnep_tx_frame builds its kvec, so it
is not split across non-linear pages. Drop the dead block and
FIXME.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
Changes since v1:
		- Move linearization to bnep_session loop, before
		  bnep_tx_frame builds its kvec

 net/bluetooth/bnep/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 0dde82e9a085..e8b4672628dd 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -480,10 +480,7 @@ static int bnep_tx_frame(struct bnep_session *s, struct sk_buff *skb)
 	iv[il++] = (struct kvec) { skb->data, skb->len };
 	len += skb->len;
 
-	/* FIXME: linearize skb */
-	{
-		len = kernel_sendmsg(sock, &s->msg, iv, il, len);
-	}
+	len = kernel_sendmsg(sock, &s->msg, iv, il, len);
 	kfree_skb(skb);
 
 	if (len > 0) {
@@ -524,9 +521,12 @@ static int bnep_session(void *arg)
 			break;
 
 		/* TX */
-		while ((skb = skb_dequeue(&sk->sk_write_queue)))
-			if (bnep_tx_frame(s, skb))
+		while ((skb = skb_dequeue(&sk->sk_write_queue))) {
+			if (skb_linearize(skb))
+				kfree_skb(skb);
+			else if (bnep_tx_frame(s, skb))
 				break;
+		}
 		netif_wake_queue(dev);
 
 		/*
-- 
2.51.0

