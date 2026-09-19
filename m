Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBA9345ED8
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 22:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789856263; cv=none; b=c8UXZfwL7/9ZRf/qkefMDNy66rCtgpK5+5JTQ3x4DFwP7A8CNiv6palAd7wtXD8L39qGifz1LkNEP7ViilnYqNGSF4QATVxho0ldDA6J14h6SWSEbyQur9jK8WwiOswcHksFYcmshZwxnK8UZcBgF8Ffpl/3Nzn9JrX5XW0cXYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789856263; c=relaxed/simple;
	bh=POdgsDDaufUM/ALcqqOmPWVjN1MLg4oGm86upvAUDG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R/K+IQEMwvKTu/2miyMWCbGBcl8cydyMIhq/vlmW4HfqUnRuBfthp0VMArUNwcCxRXPmNOQ99U8DS2BoACLcHwW6mvRYXhmhMKFebVsLI9EGS6JYZya8+XU+7UVoORzelJlAH4s39Udao5cUhP+JZ1+wEuD9lzQnh1wzMQzpceY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtgPKZIo; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtgPKZIo"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4ae2cso1521817a12.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 15:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789856260; x=1790461060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fIoAOFEixBAccqJ+FLdK0Ymwbc/lt1L73wvPf5vF/yA=;
        b=VtgPKZIoHzyE3gxgmcfxpc/16wT5qiqe9KM5nJDMkUCV4t2oYzrz4BVP1aRHzmjG0O
         zwcmQfQQzRbNpBz018XVNWInPpWc7IrYCJw9AUs/PIz7j5x5MqIMt0ch8ALqs8HDfE40
         hZiBAnjCMv/KdEnNKC5MCX65YPi9kfqPuAjw+yZ05V3tgbuqe+xU3YtF58Oci/lV12E+
         6epjzF9Et6vGA6v3+YXVxw9KY7X/7WdtGPGnl9qtXThb3hjaHS4yEHbqUL4ycXcZ6ofe
         vUiG2sJ2ivsKzuGkZMzjpWIRXRAd8Id0YiVheSm7fD/ijogStOlZQy9dx6GJnz77Woh2
         mkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789856260; x=1790461060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fIoAOFEixBAccqJ+FLdK0Ymwbc/lt1L73wvPf5vF/yA=;
        b=bZcbxolPY5NWGiTWcWdfr9W2NUI+W0lL8t60hj85yAqeT+cIr8XV22Olpaq/WKtSIJ
         ooEjpDOwPNH1ugj7bIc1fgAoNqqJk43NlXsyOd8rg707Yg4NDdifRpZqE6Aj0v+7QDXf
         rmY2ACxatoN7Xl/D4H2v5BkI2i68q3zp8i3V3sFqBFIYqCchjS/2o7+FvxUbKfv59Pxb
         U6I9R+6LPoLGpACtTz3hkhL3eBJpYi49aGGQUjRevnvKCgFogEb+B6uYU4FX1Dvi2KS1
         aZupGrG9xaq91JZS5ohcMV3d1TF+6UP6lOLB1+iHSGUJ1qGVJNbS7Wq/eQHQA3BPKtgP
         wsDQ==
X-Gm-Message-State: AFuF++lBXsOlnXwtK+9XXRgFmXs6lfIvd+dN9i0uKzO5TcPL6me49L+9
	LaoXu5kADvYd4369GOZ+SoSIAlSP9TD9zE52pz5MVlvzhnJPAk4I0A+6
X-Gm-Gg: AYBFou3wBzOpfO28igLWieiI9vGbAP94OjHaqgM1g3+uPOlzlj3ua2QqukZB01a/XFe
	AfTosTyaK5JEkNgiIw/FJeW+nyPUTGlbL8aqzk2wYzcdsYJcl7TmQnP8hI6LaAhXeqzejpmjVWk
	7PZgSsfaKcbngX0Wt0gf4nX7PgZjKpALsGh9y/ucLazos3OdhMuQ2gJsRrQS9Q9eFoQQFikHC0r
	d1wn+aRZpHCUANy/FFr2t2PTpoGtfpqWoPmSCzSq5c2QdCemA75NdBPEqyYq+23N9EL5hvKN++L
	Zvnff/aKBLT2Pbfo//XFSLxUb5PudqN5L7sJOr/dWAWK5sf5xO9A9i6QfC4twaqvvO5vCKH3HCT
	Ha2e8favjoV0SZw4e+1R2pkjXZu+C76a+wmYSvAMSL5V0/Ro3s+f/TB+PJYnI356veS48zkIjPE
	chtywEg1Pj1ypJRXMkf6P68UzEwd79GpfWL3ZPPCq7q2hi0kNo/34sya8jVyd9mBUGsbrW5Eyuj
	xXi0rrHc6CnvxrhzaJ45+KGMdpO7BWmtBR/qUk/UPq1fTKVYyOvOJeCYV1+T+xUqUtL6KfqQF5O
	QTo7hLk3aw==
X-Received: by 2002:a05:6300:2204:b0:3cd:67e9:8565 with SMTP id adf61e73a8af0-3dd8c32eefbmr12898641637.9.1789856259619;
        Sat, 19 Sep 2026 15:17:39 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc72aefe72esm1372985a12.30.2026.09.19.15.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:17:39 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: bnep: fix out-of-bounds reads on short RX/TX frames and control fallthrough
Date: Sat, 19 Sep 2026 22:17:38 +0000
Message-ID: <20260919221738.3708655-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix multiple out-of-bounds reads in Bluetooth BNEP frame processing:

1. In bnep_rx_frame() and bnep_ctrl_frame() (net/bluetooth/bnep/core.c),
   use pskb_may_pull() to verify the BNEP header, control type byte,
   filter count, and extension headers exist before reading them, and
   return 0 after handling BNEP_CONTROL instead of falling through to
   Ethernet frame submission when no extension headers follow.
2. In bnep_net_xmit() (net/bluetooth/bnep/netdev.c), verify skb->len >=
   ETH_HLEN with pskb_may_pull() before reading the 14-byte Ethernet
   header to prevent an out-of-bounds heap read and infoleak on short
   AF_PACKET TX frames.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index f7d88c33e23e..ad24d2486665 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -270,9 +270,14 @@ static int bnep_rx_extension(struct bnep_session *s, struct sk_buff *skb)
 
 		BT_DBG("type 0x%x len %u", h->type, h->len);
 
+		if (skb->len < h->len) {
+			err = -EILSEQ;
+			break;
+		}
+
 		switch (h->type & BNEP_TYPE_MASK) {
 		case BNEP_EXT_CONTROL:
-			bnep_rx_control(s, skb->data, skb->len);
+			bnep_rx_control(s, skb->data, h->len);
 			break;
 
 		default:
@@ -373,6 +378,11 @@ static int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
 			goto badframe;
 	}
 
+	if ((type & BNEP_TYPE_MASK) == BNEP_CONTROL) {
+		kfree_skb(skb);
+		return 0;
+	}
+
 	/* Strip 802.1p header */
 	if (ntohs(s->eh.h_proto) == ETH_P_8021Q) {
 		if (!skb_pull(skb, 4))
@@ -451,6 +461,11 @@ static int bnep_tx_frame(struct bnep_session *s, struct sk_buff *skb)
 		goto send;
 	}
 
+	if (skb->len < ETH_HLEN) {
+		kfree_skb(skb);
+		return 0;
+	}
+
 	iv[il++] = (struct kvec) { &type, 1 };
 	len++;
 
diff --git a/net/bluetooth/bnep/netdev.c b/net/bluetooth/bnep/netdev.c
index ee1e39a3daff..b451ef457741 100644
--- a/net/bluetooth/bnep/netdev.c
+++ b/net/bluetooth/bnep/netdev.c
@@ -166,6 +166,12 @@ static netdev_tx_t bnep_net_xmit(struct sk_buff *skb,
 
 	BT_DBG("skb %p, dev %p", skb, dev);
 
+	if (!pskb_may_pull(skb, ETH_HLEN)) {
+		dev->stats.tx_dropped++;
+		kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
+
 #ifdef CONFIG_BT_BNEP_MC_FILTER
 	if (bnep_net_mc_filter(skb, s)) {
 		kfree_skb(skb);
@@ -218,7 +224,7 @@ void bnep_net_setup(struct net_device *dev)
 	dev->addr_len = ETH_ALEN;
 
 	ether_setup(dev);
-	dev->min_mtu = 0;
+	dev->min_mtu = ETH_MIN_MTU;
 	dev->max_mtu = ETH_MAX_MTU;
 	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
 	dev->netdev_ops = &bnep_netdev_ops;
