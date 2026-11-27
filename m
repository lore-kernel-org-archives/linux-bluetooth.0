Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795782434;
	b=ZwMVwQsmpSGp1It1q8D3qn4ROclphcgC3IoR33qHghklwXnLvK1DFlLifcBDZPbp5HY6
	 GDIzUrPxj0Ano8z9s1SR811VoBwCIL0j9DYCVYKQse3FPAXb5w0A6mvW/4SaZCrlmQfem
	 UHpD2KlPNjqKRJTRSaoQ3mHPjuGKEMYneKsbKXOthK4/ZJZ3sjHbRCgGF62/VHKM4yxEI
	 6JIcvEroKdamqM2PNlLkuBSqe+i83N2OoZRTE40WJt4uU9i3GensNfYswne3fNgjUGcLH
	 SJNx8FrPZwbm7GP2K4WtqrvDUtyeF0qlN4y5Sa5CH/acphCRvcqUNB36Uo5e9r0qCEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795782434;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iX5IEkWfNSNQncHjGXi404WCMZ17urlgEyllmgnBpTw=;
	b=X7xSjwBgyHMUCxPYs/pyEYxXdyoqVZJJQXFikKmDN13osR3pYNa5S5Hy8xNSUzYFNW7j
	 mltioQEBgjDcaOHwOXAVeQkQE7il1UMpj3IIqKctiYo2JKfgEk4VivmHQjLN7PvAROvLV
	 Seyh2q/2zTWGZY1UxnHECD6KhK5hqaa9rHIaIUEVEQz8ta5v4Ji/lTMUQEK66LqFXa3Wo
	 4ivGX0qDqOrG6JN3c0IsNGQieWWm+W/PpSWcErFtLq5+V0oQgo5J385O4Z4OgJyD+u6PI
	 oedTn3j5ef7RCIX53JC6BhIVLcKzjwhVlMsvRsNAjKRuhvtlEPdryUXEAO5rQ9CMfLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=uBRShkv4;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1717B606A323
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 12:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1717B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=uBRShkv4
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4acb44dcd7bso7239421f8f.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 04:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795782432; x=1796387232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iX5IEkWfNSNQncHjGXi404WCMZ17urlgEyllmgnBpTw=;
        b=uBRShkv4yIPr9l1KsmPso006RXUsr57OFNu5FWsgVDZZXjhvwqs3TVHrnZIJ4Q0FaF
         LcObuJJRxNHcbJIQVD6k8qmaU2QckkdjOY31tgdRtjhSZ5Q+EXreyyQMd54UmGnWAU1b
         m2Y40oNPdxIf/pOhkF9ZAMMWepBC+p0+l/g7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795782432; x=1796387232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iX5IEkWfNSNQncHjGXi404WCMZ17urlgEyllmgnBpTw=;
        b=j2bN+WLFELPfQhXvqV0iilXRsdJDNxbMJ5gQ8NMdbhhgI6iZgYUpoaR4gSlGs+wx8j
         lCm6MWGujSlHJHms6CiXHYLGzJbW0iO67BrZ2i3mOqJjlyYscaH6MHBnXdkd6Q+QcJuw
         hGDQbqgHRK5+0OfOi7aKQrMCY6m8//GVcw9WtBQfRpBbT/YMk/apILpmBQtHQxdFvjiD
         /Cwuu2bIxpYGc4ehut46CnPagZndAamq5a4Z4Baam1oHVuuxb8hDB7NRtRGgSWamie6c
         cVjMMyMPo4s9Kcd872sccqKHPpaeSmqMk2/KAvqZ1Mtt/FVQEcjdGCtQiCJ95XKUtrH4
         QO8Q==
X-Gm-Message-State: APuU4Z8z3r1ZmWoUlNzSmN/3fuO6az3waDj5TDMEKBqyMIcvgV74cq/2
	2I0VT5+k8GfwKXWdSkbhmh8LKgPIgeJS/bCpIj0JIAEP/rsfUTNahWDn8F2DpaddD1gyCHHgwpF
	aMgWu
X-Gm-Gg: AZFdTZfw/kEovUZrMBXPWsrnP7cZu5JgBhdOBUkC3ZWIqadxGtqJ+vZ8pB2G2+Z73/f
	VbsWwP4ajfSUoY+hEvFpqyuAuczMW3COSb8gr4HqcgnGJpIphfCtkiOBcmLjfCEzScJZxAZxEWF
	8CGQSNMWJSqnquCdLkfguByhoHfDLXqy0IvG9G9OOCmu5bL+3w6RVH0tVgTJ55wWm2HE2fnf90G
	McONDMUSPMcAbWrmmcTCmBnG0Bs7LKBOmALDiwIWBzu84Th7s9Hi4NRxAKqaX2aXUeY3pu0rYGj
	hs55Z5xkrckAWZauA0Ifhnw7gR5HziDPiqM7+JXapmlYy2p1MT3cSUbgniZIXLNzM9FGb6VRwse
	6l+3vgPBdehlmR0NgulEQB/e0NgW1V8HVdplFlZKaME/raAcM0swE9jR23ILrcvQHSyhFUfGiQA
	aIsFJSqfL5nTK40krLb4Dx/a0nUH0SHmuWWZyKPa0K5SYjFh3EwjSpkZ77jsOMvtpsBgN3/LmxP
	icR1drOQIleo/LQnKHJJDcHDgtL32KtgH0QAreXsIhAF9c7BLRtm8EHZ9TImOyNwhLytFlHaD/d
	glMWFvbKpBmbZ2WBhwee20xc7L3fpyOnh3JNFMGwTS2iCXzT8CZEMYWF07FHwHSLOARzCc2c
X-Received: by 2002:a05:6000:4b03:b0:48d:ff71:dd9d with SMTP id ffacd0b85a97d-4abb2ce4d3dmr48149968f8f.23.1795782432481;
        Fri, 27 Nov 2026 04:27:12 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:1a97:1eed:9575:b56f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b10b1ebsm48053420f8f.33.2026.11.27.04.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 04:27:12 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 1/3] l2test: Size frames to the channel's current MTU
Date: Fri, 27 Nov 2026 13:27:03 +0100
Message-ID: <20261127122705.2393602-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127122705.2393602-1-simon.mikuda@streamunlimited.com>
References: <20261127122705.2393602-1-simon.mikuda@streamunlimited.com>
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

Without -b, a frame was as large as the output MTU at connection time.
An enhanced credit based channel can be reconfigured to a larger MTU
later, so each frame is now as large as BT_SNDMTU says when it is sent.

Assisted-by: Claude:claude-opus-5-5
---
 tools/l2test.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/l2test.c b/tools/l2test.c
index d7a52fe0d..dbfeae50a 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -1059,8 +1059,24 @@ static void recv_mode(int sk)
 	}
 }
 
+/* The channel's MTU now: the peer may have reconfigured it since connection
+ * (enhanced credit based mode).
+ */
+static int current_omtu(int sk)
+{
+	uint16_t mtu;
+	socklen_t len = sizeof(mtu);
+
+	if (getsockopt(sk, SOL_BLUETOOTH, BT_SNDMTU, &mtu, &len) < 0 || !mtu)
+		return omtu;
+
+	return mtu > buffer_size ? buffer_size : mtu;
+}
+
 static void do_send(int sk)
 {
+	/* Without -b each frame is as large as the channel's MTU */
+	bool follow_mtu = data_size < 0;
 	uint32_t seq;
 	int i, fd, len, buflen, size, sent;
 
@@ -1096,7 +1112,7 @@ static void do_send(int sk)
 		close(fd);
 		return;
 	} else {
-		for (i = 6; i < data_size; i++)
+		for (i = 6; i < buffer_size; i++)
 			buf[i] = 0x7f;
 	}
 
@@ -1105,6 +1121,9 @@ static void do_send(int sk)
 
 	seq = seq_start;
 	while ((num_frames == -1) || (num_frames-- > 0)) {
+		if (follow_mtu)
+			data_size = omtu = current_omtu(sk);
+
 		put_le32(seq, buf);
 		put_le16(data_size, buf + 4);
 
-- 
2.43.0

