Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50993546D7
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 07:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789718315; cv=none; b=QJMr2sdkWxK46RLgKGDWXZGXE+Hrgz6HVeffgDo5NzhavAdr+vHD7KSuPWDn6H03SMurf0xG9ARuD69Yl2XhHBCCixHoBons+Kdigr6UhzhvBY9DLMsPxQTPTXABy/JdYASwM391pTtuiEKd9mSY2hCMS+fa5UxkOzmeF49Umf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789718315; c=relaxed/simple;
	bh=58Ov7X4cQiiV8yVtiAcfIEpAgynsoG2QRdaTFGCXiZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Aa3YezPf6LelTYkDc+Bc3mYTDBwlmhqH/mlId/U6gpIdcfatYqObg+YmjW9Qe5N1pFf2WRAg2S2xVHLGBkM69kCin0xV9Fl58Cmr6REPXWdRUorjyO9afP1Z/Cw0Igrk3cPsfopVQtCbyaH3xcO8zc53U6yTEOaCgLdUFyOLYr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1w/lVsy; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1w/lVsy"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebad4adso295826a12.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 00:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789718311; x=1790323111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h7AV/9Z4iSdAqXfI+wA+QLkfqj4NMH3iyjMDb2Tzlg0=;
        b=d1w/lVsyKIY9Kqx9HaICxKXkuHz/uDIpcXI4tDmrOHdWzdwW7//j92Rd7UMuyaDP/L
         tcTSOA1YAxN1LTnudj82nKe6aJAGoR2vwxLn93irkxo+fNeQ84264H5lSttvo9DoBNjz
         W+HcKcG1B+ctM4y2nW6rUTBiT2g7kHsLen2Wk36B9ln5NqpgLoNMNxENgw1vFE1tBsj4
         rqtKSagcFO+1K6jKYr7jbxMiKiVLZNvF1OnByfCz/u2bvJFfJLPmK8gQJ8s0HM2uDvLb
         2YJxnY1woCwHwtIv6YCelvQOxZq6NRueeBuQRK7UZlOSs4IwQaNiyBGjwfCqSlaHzX2l
         GcaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789718311; x=1790323111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h7AV/9Z4iSdAqXfI+wA+QLkfqj4NMH3iyjMDb2Tzlg0=;
        b=r6tdR/4bTP9zhc86E+IQgssKocYtRga+QdWQQQRle2zOd6xs1czfJqaqYehHNJ66pE
         PO5/niJLt5K2R+ASTvzPG4Wj5pQBR3NJmGRXjJKo3/3XXnOp59BvLUhTayBbRKomoFTy
         sqKuPKhQzSN77Dgr6z4Hy42ST9I9EbFItBc59gNMRbxjlL/37qfyxtdq2lv/TwZJMm8i
         uE2Ou/CEq1G+uh/2YZZwDM6XGgCKX2llKK3z2PcLGuKLvDxOz00nVpExIcIBvMQv3MzN
         dxDIAtUdaS2uB3gqnfFlOTeW7DTYt31gUXNysc2qrN7oBEPWcKMUSdgptu0M2piddmaD
         ezdQ==
X-Gm-Message-State: AFuF++lm+6isebf7/xZINAZEcaRKbvAAumIOl6pazYaHEB06hyklgyA7
	9MndEw/ig4rE5OagsQu3y231MDjWsJkoGTEBI9+uaMEvG/bQu7DAfEiG
X-Gm-Gg: AYBFou1/4WOdI9XA+eU551O5ckJ5vOmqZ9JDEXn6yvjmLA6NflwZ1Ut5MdDVaWU1BJg
	MR/UAZ13pTn3TPBQ0UVkRW4JLb0l++XPoLRNkhLn+IQHwnnafFEeSqtE1Ozrt5/DpN537UNdcfb
	PCFsgBjbBj6FQY0lKKrz4Zm/oFQ8i16qOyYbwYIFUEULOMp8IxwTaxMqpb/vgZVuFoqA1NNJxt2
	Dh3LApmYuzv/tQeEXijZezr8iVggxssB3HTCynP35XQsH8QOkHqEN14ev92FatZjCJPELNrnHDC
	CWjgAR0O+oRdzN1pkxKaiPdkb1ciyFXB3oe2JvHw4/5sR7DHntwEF2bvhthbc0Wuhd72YFG4QMb
	TqnfWayl3Gsokf/x7Aqou4TTWEj/iEXRvDlYOzXrdXQdfSIjD9W3PcnTjHfDEjS37xd8y/dkPRI
	1B5KbaKpPMiCjlHoU4nMuKT2T+Siutq68iwqRDIQ5lgPhW8cfU+wfn7YS1desjt0d6xw1m3lR9R
	Q9qV9EsFetY5YzjO5eC6zvBnn2tbXuFjE8enqxkqonULGk/ng9h5LLniusk8e+yMibWxX/JyKIo
	bnBvdBkMJw==
X-Received: by 2002:a17:90b:2243:b0:39d:f773:37b5 with SMTP id 98e67ed59e1d1-39e549c5057mr6360189a91.0.1789718310947;
        Fri, 18 Sep 2026 00:58:30 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e36115cc8sm9018249a91.3.2026.09.18.00.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 00:58:30 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH] Bluetooth: RFCOMM: Reject short EA=0 frames in rfcomm_recv_frame()
Date: Fri, 18 Sep 2026 07:58:28 +0000
Message-ID: <20260918075829.2203887-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While rfcomm_recv_frame() verifies that skb->len is at least
sizeof(*hdr) + 1 (4 bytes: 3-byte header + 1-byte FCS), an RFCOMM frame
with an extended 2-byte length field (!__test_ea(hdr->len)) has a 4-byte
header plus a 1-byte FCS (5 bytes minimum, sizeof(*hdr) + 2).

When a 4-byte RFCOMM frame with EA == 0 arrives:
1. The initial skb->len < sizeof(*hdr) + 1 check passes (4 < 4 is false).
2. Trimming the FCS byte decrements skb->len to 3.
3. If __check_fcs() succeeds, skb_pull(skb, 4) fails (4 > 3) and returns
   NULL without advancing skb->data.
4. Because the return value of skb_pull() is ignored, the un-pulled
   3-byte struct rfcomm_hdr remains at skb->data and is either queued as
   application payload via rfcomm_recv_data() or parsed as a multiplexer
   control command via rfcomm_recv_mcc() on DLCI 0.

Fix this by extending the length check in rfcomm_recv_frame() to also
require skb->len >= sizeof(*hdr) + 2 when !__test_ea(hdr->len).

Signed-off-by: Hui Peng <benquike@gmail.com>
---
 net/bluetooth/rfcomm/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index f7463f092..d91e2a6ee 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1817,7 +1817,8 @@ static struct rfcomm_session *rfcomm_recv_frame(struct rfcomm_session *s,
 		return s;
 	}
 
-	if (skb->len < sizeof(*hdr) + 1) {
+	if (skb->len < sizeof(*hdr) + 1 ||
+	    (!__test_ea(hdr->len) && skb->len < sizeof(*hdr) + 2)) {
 		kfree_skb(skb);
 		return s;
 	}
-- 
2.55.0.1082.g2b9226bbc0-goog

