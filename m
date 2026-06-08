Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999E0286419
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 23:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780963024; cv=none; b=mKW8MwFfwdiBevbVVFODWfb5cIj5xxz46Exr6rQs+vB6UTfHtIiL2Egsg3N/ORkrvuigJ6708L6YWwD/r8ujEAsorT9YEbORgaO+vXir7Fn104OdmzBQgYU+RP3EEoom4HAPzKUjfxnzmnI3C70tpjl8+emBuujc2sxyuKFAjug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780963024; c=relaxed/simple;
	bh=1e60y1YvUvuORJYbuhr7jqlxOPjvKFhYPwJp2niIn6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jpdtuUEEOtN6Qx7sfbsgA7LeYSOlkbYHJ74Vj1BAAHEwDFqjt5tGBrYySr67j5CWoPgAmwJbj7tg50wMPss5mcDhFPMsA4Axls7qrXBhgAjanylctIOoCsnhFraVPdzPdHFGt71p5CP6He2J9hsLPEypuxHPy4pS2my5W8orkm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=E7NYRlAq; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="E7NYRlAq"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8cceaacd07bso54353336d6.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 16:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780963022; x=1781567822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2csAZjIYmZB0vxCmR03xoe0HVBnxRLdQ9Io0BwGsIVc=;
        b=E7NYRlAq9LVFpMWf6lpX6WRYMCJu2eRmy/Fz/2xqE4J5XPMOUVD5Gzy3mkBZ5WzjdG
         07ojuQnQscwgH0dycURxRPaOUxOR1v6NYO1QBtMK9I6Oi9AfpttMrmsIS30eOmWP3C+/
         toS5kvBrFkd9C4DGxEeH54JPwcktsTFT30Rj6r2AiIrjLc9XnDb5yd3oFkFuLuPajIrp
         fvVBiq++168dqgnKRNljCOyj3LGrGgNeayZA21XxoMqlt/bvll6CIp0SU5LIHP22VVnG
         k6wExDqXALHt4TwoTFF2bsspUS/dAncz34t0mG2/yYkuei1ywqmdm4YcsVgeuTvqHyv/
         lrnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780963022; x=1781567822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2csAZjIYmZB0vxCmR03xoe0HVBnxRLdQ9Io0BwGsIVc=;
        b=AQ/895n7gEXWtN8z9lVjlMmSg9PLK9uXqTrhtlFwibKOi/zD6SmFhKQ3ZNYX1j28Jl
         FEyGziq6ZnoaPAzCgF/0x0uoIMSgNpWRtRQWiGHQ/DIM2S/nX6vurclhwPOtTgemQoqX
         LcgX+eW+NBqaT3b0rnP8Yq31YlN3IAHlNH6CXLYc+Q+Yhd0aLbWG9XwESBafQaLMIt+a
         NHEl9uB7id7bQsRXF01GXyfF0HMNjDQvqj0oxzrEKLYH7PhS346w27un4S/HlF6ku3bu
         jpKM9+lQVxGLknnfzvDFqsxCP4/Y3j4A/Q4e0d2q8HOh47Z2CDALw4eG35ONo9/m5hjJ
         +ywQ==
X-Forwarded-Encrypted: i=1; AFNElJ/xknlortc0ttati3A9CLagZwGc9pxQN1yUtPkyOCK/Ra66ZnFdUN1GjA34ug7lB/ynoOVtxACVa4WBhi5fTlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcqdRu4l7jYRH56sk72IgNDZHRNgg6Y2AMYy7fzxkRhMlyz/16
	eJLjT1JIGBooYS4horDp7LN9Se3y1kbsnChXUSz4uBeXNFOn213aoV958zQX5l7KkZY=
X-Gm-Gg: Acq92OGTF96Sgnw6dRJz8mMhmalfSJQN0CYpd+lKpFiiV3a7Mz7SMT+G/aGRA+CgPbj
	A82bb/JEBTc7MJ8Szwq6KISm2duXHhk+FzZUDedXUbaOrOPGUDX8U2VCuO2/tbJaC7F8z8NJo95
	59Wxt+VVATGDTJRpFb/nS4h0yxuOaSgEjgdWCG/rLnTH7LwBCxbnRbtNvqe9+SHhsH/bSb59DiI
	Mti3E/EWHPuBDkYIurs1OPU6i0CYw3/W0KH7D5lFQcyCNoz0RjZsr5k3LAGjzFuZ3XC1m0kZilh
	yubBmRFFjNgx9iD442M00NtDXzFCy4xtDmJQNQmXV3xOlN1wjtSPHhk43ayXAx5L+Zq/dd6kV9t
	rY0tIUQqVmptLVovZh7WZIJV/lTT5Me513K2IHUOoVHDoyqYRnajInmdDqAX78XPEB4V2XNIZTU
	7Va3kTpBXMyw1zniScez6nBmd8UGE+loEtKYm+AA==
X-Received: by 2002:a05:622a:4cf:b0:50d:82db:773e with SMTP id d75a77b69052e-51795b60f16mr261294271cf.47.1780963022607;
        Mon, 08 Jun 2026 16:57:02 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-8cecd275dd2sm178779946d6.47.2026.06.08.16.57.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 16:57:01 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org (open list:BLUETOOTH SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] Bluetooth: hci: validate codec capability element length
Date: Mon,  8 Jun 2026 23:56:28 +0000
Message-ID: <20260608235627.1233330.bc5338ecae62.bluetooth-hci-codec-cap-short-oob@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Read Local Codec Capabilities returns a sequence of capability elements.
Each element starts with a one-byte length followed by that many payload
bytes.

hci_read_codec_capabilities() checks that the skb contains the length
byte, but then validates only caps->len against the remaining skb
length.  A malformed controller response with one remaining byte and
caps->len set to one passes that check even though the element needs two
bytes.  The parser then records a two-byte capability and copies one
byte beyond the advertised response payload into the codec list.

Validate the full element size, including the length byte, before adding
it to the accumulated capability length.  This preserves all well-formed
capability elements and drops only truncated controller responses.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
 net/bluetooth/hci_codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_codec.c b/net/bluetooth/hci_codec.c
index 3cc135bb1d30..5bc5003c387c 100644
--- a/net/bluetooth/hci_codec.c
+++ b/net/bluetooth/hci_codec.c
@@ -100,7 +100,7 @@ static void hci_read_codec_capabilities(struct hci_dev *hdev, __u8 transport,
 				caps = (void *)skb->data;
 				if (skb->len < sizeof(*caps))
 					goto error;
-				if (skb->len < caps->len)
+				if (skb->len < sizeof(caps->len) + caps->len)
 					goto error;
 				len += sizeof(caps->len) + caps->len;
 				skb_pull(skb,  sizeof(caps->len) + caps->len);
-- 
2.43.0

