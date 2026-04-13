Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC0B27470
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 08:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776070566; cv=none; b=rsG+vSKABQIsumlsOiG0PjKz4Vwld5QXHVOF6dgz+CMRWBKxDT8a0LAe/OUooUUQYvbzskGkQ7OmhbEEu+aPAwNTx5CeS180kwfWWNxQDJFnOVPQrIoW4YEsikx0qICGYCFjjdlF7jMPd/uV+aEkpEzwDhugMK4keNDUywY3euU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776070566; c=relaxed/simple;
	bh=VjEIAOK1yAv/mKj0X4b6KUosnKjqWfS0PR3gOIZ4MCU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TkhLhCkFnxTEBVDyNKKCD7eyUa3OH3XD/VRbjgNnQRJNS9J9dlchEzuUHNUFbCCFgPKiWGpRnLhMx526ZSLe47BEPggvuMHgv8xAs1oTL5Lxn/raKMf+tR3EkJT1eMOqGngl2Tz9iGroM8Udnp81zbzq+CBIilzv1wX5WRrdhMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWLkuWXq; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWLkuWXq"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35d9f68d011so2619247a91.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 01:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776070565; x=1776675365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C3nNiRxnsZk83nKlatJO1j+RQ/n9gREshEGWLEucaww=;
        b=ZWLkuWXqDHtB9mOHMAKWdrhJ413kK4Ee5S9DgNcYU59lJcoaYP1A8rPEuIB1598cUw
         Rt1k4fXJX2trGQ6+tmhLrCyS5NHo68yuHvDI66igv5ENVyOCT5DHhEOUOlyC9zSlh+N7
         WjQWZJbvTJhIvUYrjHwgndFeQOhLhqDkXau1/vuxIXZ4Xp3mPzbiMhtx3MT7+wCgt8sW
         PHZRKAviuJm+8vUzveAoUEwbzZDMRKIDILnRFTOVxzqLjWF53vPy7fJemgNLYwbvzGE8
         e1Kajk6xVua6TBdoitvv/0tQI2IBLEtX8uzPCvdA+uZGazLu8h0t1oC8dAginGk1gjfa
         nrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776070565; x=1776675365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3nNiRxnsZk83nKlatJO1j+RQ/n9gREshEGWLEucaww=;
        b=HE9uoEdDXNki4rPugBNYaOAyneAlFAaTT+/mBJCdauLPq29ZgoYvGedi/Sq+pgro4Z
         55JexLkOOm6RZJdXZXa3U+kDjpXamaI6Kx7xvGAZjkApD5OFp/CvHJ0xGyNqDjO+WeDP
         0m6esM/D5fDn4HebsQLqhSgh7iNE5zR+BN1KXfA+y66cqU87rjntdB08GZ8p/sZ7/TWq
         8JQfGZtOGEpgqXS1Bd6kd4HQrP1gAxmYQMeameCngBNh63rjK7atr1p2L4/oxn1rsVb1
         jMud4x85SL1WQ7k5/MgANDxQkMTmBRxbOtf8FVtHsOfZjqGoEZhxBITNqoGAJuJFZKCR
         q0Gg==
X-Gm-Message-State: AOJu0YxgJ1M1jN9gCr0aTjK4LUSRbPynBvByp7pn1GHTvVHbNA1iaT3Z
	YnAL3HlC1EUsEwRcGXcmPZl+Zy8upYkNY5xo1FIB+TIPNh0TRLa8yYh56vkAFA==
X-Gm-Gg: AeBDieu5TkLdUwdlcQeVr5VS/J7quwmlx2RDb+yzVdfQ8FNSNy5Y7Z2A0NGhlUoXdOW
	fp8Sev8CQotKuZUmZnnXzeYy76YSzAVwOG+RdQWHpQzjK4qSLFP/pX6HRSxH6XzuAEgUvcbnHi7
	T0Z3WZQm5t0zOL0Fo7I7woIBgGTS7Dw9pQj5sSVXYw85abdAqCqqBzHjm576dzU1/h3SlVmwIDz
	oe6yOgm8tCxDPPP4z8a/dLNS4TxuiG4kN+zS1/Vp/rnu3Bj53N0l05syJkdSfcQuR6Tcx+hQXOx
	+1jvtpE9oP8SshSY5tmAT33eXwY5PDy5UgcNPNFNkp1WDYgYmGD7OJzPQKrpc5QR/9cRBKkoJF+
	pu23bmCUn/c46TSkBwl/XjR3+p4j7v+4Chxix6Mq80duB33rfOFZJJkxKL85H/sVh4Aks86Hc97
	kgy1xqkRll/Awtf4K/SNrJVC4n7qdGxBcpQar+Ra9FrPc6SzRjgSSANdE21b5N3aaK
X-Received: by 2002:a17:90b:390f:b0:336:b60f:3936 with SMTP id 98e67ed59e1d1-35e42749271mr12771194a91.12.1776070565049;
        Mon, 13 Apr 2026 01:56:05 -0700 (PDT)
Received: from gmail.com (69-172-89-235.static.imsbiz.com. [69.172.89.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e57a99062sm5129858a91.7.2026.04.13.01.56.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Apr 2026 01:56:04 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	Dudu Lu <phx0fer@gmail.com>
Subject: [PATCH] Bluetooth: l2cap: Fix MPS check in l2cap_ecred_reconf_req
Date: Mon, 13 Apr 2026 16:56:00 +0800
Message-Id: <20260413085600.75248-1-phx0fer@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The L2CAP Enhanced Credit Based Flow Control specification (Core Spec
5.4, Vol 3, Part A, Section 7.11) states that if more than one channel
is being reconfigured, the MPS shall not be decreased. The current code
uses `&& i` (loop index) to approximate "more than one channel", but
this incorrectly allows MPS decrease for the first channel (i==0) even
when multiple channels are being reconfigured, and incorrectly blocks
MPS decrease for subsequent channels even when only that single channel
is being reconfigured via index > 0.

Replace `&& i` with `&& num_scid > 1` which correctly checks whether
the reconfiguration request covers more than one channel, matching the
specification intent.

Signed-off-by: Dudu Lu <phx0fer@gmail.com>
---
 net/bluetooth/l2cap_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 95c65fece39b..b069f965a339 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5428,7 +5428,7 @@ static inline int l2cap_ecred_reconf_req(struct l2cap_conn *conn,
 		 * configured, the MPS field may be less than the current MPS
 		 * of that channel.
 		 */
-		if (chan[i]->remote_mps >= mps && i) {
+		if (chan[i]->remote_mps >= mps && num_scid > 1) {
 			BT_ERR("chan %p decreased MPS %u -> %u", chan[i],
 			       chan[i]->remote_mps, mps);
 			result = L2CAP_RECONF_INVALID_MPS;
-- 
2.39.3 (Apple Git-145)

