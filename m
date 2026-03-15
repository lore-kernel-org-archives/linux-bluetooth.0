Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F9126FDBF
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Mar 2026 13:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773580500; cv=none; b=CpVN4FK/kM10XDsJAy1gI1j5pMizH+wuaRv9Wov6XPd3kbmtkXT/rLz2WnCfoIhd7kqE0b6dSh8mOSxk3Ju82sZ0cTVM6fM5tJR0mLq5FNyrqDRjVMw3FLqrCWMyGpWw6mooKWtM+bDTcxUZ+P42ALwLhtWSaBkXm+qqp6v09mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773580500; c=relaxed/simple;
	bh=8cUuvbZj++AJsEUiZ1HtndOh9crxjzg6h035+lV8chQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fTgb3B8n4RZkf/WfnRP0pjKAtH5lmeUPezFwSMHk0iOSzHLyBvy0q8mzHt/cMN3iAGvUqoApoEhaWuSSux27MUu/VyIVaJvgMqNZrGCmwKq9b5axtOA+B01jixp8JKojwHiKjdjlaOaDsqXbCBCaBBbgjYiyxbL9Ph+6i0f0pSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0vVM+jB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0vVM+jB"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a9296b3926so28956785ad.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Mar 2026 06:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773580498; x=1774185298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I46N/58QdGpHKOmGew5o9rG95aF1afVdvwtVEFsZfWE=;
        b=Q0vVM+jBfPsAMGqR0Isr1tDmzAtXZdRUZx30xw6Gg5jKwyDpYdiuBDRenzZyBIq5o7
         SfRZ3tuan4v/Vlv+Bb9XKQUXrD/1wFlFwbCzkgYQKfFm4W61pnMg83reca2xFHv6TrwD
         WgEXiOzidmzDcKanVpJrY4pK0C6YPI5qeZlOvu4JWX90KGk5sVmwqGAyGccHqjJZhlgq
         AZ9KM/hzmlDGLgLTbCuKOZyNpjFPPJVniOk3xDeFDc/ZW8lSuk6AOVZn+6OuDLxzjvSC
         /NC8pxi338eQgdLYgNiNbPcV/rBLMkIxK0Wn6Er2rAFInjGwYjHIJQ4YiW+ziGwh9zG8
         q2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773580498; x=1774185298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I46N/58QdGpHKOmGew5o9rG95aF1afVdvwtVEFsZfWE=;
        b=Is9nuSSLMQdH51criqbIANt2l4BrY4TgGkMjLl2Ayej/tmfsTexNzbuGFJxdpRj66F
         itVZLVSYcmxt2oXKbtAhaiGJ411d2+RGy77eoNQgHZq4MZ8hrRwSvbwHmET+Sp+f5mng
         JBMfTOBAfSTUapwCuaIf+ApaQcqEvpp+Om2VS/MOojR+jsUZfOn3WHi+9l55fasKZjno
         I8bxDzzkmqHweekmqGIB39imoRf9yGpPq7oDOjIJuGelRr234vN6O14jl/JOaQOS6XKN
         GWuSF/KrE0/Gf5EFOvQG1ICw41RdjM7hM8O+oPg1O0Kmo8i4RCsdYVFqGAQLPCvvPPwq
         LfHA==
X-Gm-Message-State: AOJu0Yy0ZOKkGblQfo/2gQ9Al8npkZXWKo6iQFlFJp6t8AfUalpw2Qh3
	UxJB53xxnPHd/xzt5pxrbPCmhYzPSEyPNYTACcFuQhWIWotk5fUn0erD
X-Gm-Gg: ATEYQzzYEQZ1Gp7vi/UauY6tmP5Aw2FKBgrCml4Amp5MPu5DGGXwf7ujEpEWqsyZJ28
	iObE7f8Fmixk44+TC6v7W9iAEvO1gv+iyIh1ktRWAnUGOzn+09qxZkkKWHT15YtZitM4//d8CSV
	WEF4ZAG7t8Xaj0qgOu9emVRmwFVkjmJq7OuhfjcQL7xg4lj6+tENUJrRgHYcGuQfKGjIUYfOv97
	xDHlcjug0e4HlhqyrN+rAVHCKuQUa9bbnMIM+LzoX9b7pjFxPFXoZLUHyMlexMyMyCwVMPTxngE
	vFdqMQF9GkIzXFmGsaNHx5nRApNfMWt3+l7kBMqpGZFc8o0S1UNTNxwXpbGXq/K7Zf5zXrpGVCh
	OmNgGhRpbnygOYww0o/7Z2UIam1+ESP1v6dtNXu1w6CjzBNZwUCHI1Id44hjJjR3Cwn5+6fIvKW
	E128ykHRccVtIktbRGdWoYq3gyZW8mQPm/ZRObje7rg2k=
X-Received: by 2002:a17:902:e852:b0:2ae:be67:7231 with SMTP id d9443c01a7336-2aecaa4e319mr101641865ad.25.1773580498066;
        Sun, 15 Mar 2026 06:14:58 -0700 (PDT)
Received: from localhost.localdomain ([122.34.38.134])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2aece5c0f7asm80321555ad.22.2026.03.15.06.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 06:14:57 -0700 (PDT)
From: Minseo Park <jacob.park.9436@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+b7f3e7d9a596bf6a63e3@syzkaller.appspotmail.com,
	Minseo Park <jacob.park.9436@gmail.com>
Subject: [PATCH] Bluetooth: L2CAP: Fix stack-out-of-bounds read in l2cap_ecred_conn_req
Date: Sun, 15 Mar 2026 22:14:37 +0900
Message-ID: <20260315131437.10890-1-jacob.park.9436@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported a KASAN stack-out-of-bounds read in l2cap_build_cmd()
that is triggered by a malformed Enhanced Credit Based Connection Request.

The vulnerability stems from l2cap_ecred_conn_req(). The function allocates
a local stack buffer (`pdu`) designed to hold a maximum of 5 Source Channel
IDs (SCIDs), totaling 18 bytes. When an attacker sends a request with more
than 5 SCIDs, the function calculates `rsp_len` based on this unvalidated
`cmd_len` before checking if the number of SCIDs exceeds
L2CAP_ECRED_MAX_CID.

If the SCID count is too high, the function correctly jumps to the
`response` label to reject the packet, but `rsp_len` retains the
attacker's oversized value. Consequently, l2cap_send_cmd() is instructed
to read past the end of the 18-byte `pdu` buffer, triggering a
KASAN panic.

Fix this by moving the assignment of `rsp_len` to after the `num_scid`
boundary check. If the packet is rejected, `rsp_len` will safely
remain 0, and the error response will only read the 8-byte base header
from the stack.

Fixes: c28d2bff7044 ("Bluetooth: L2CAP: Fix result of L2CAP_ECRED_CONN_RSP when MTU is too short")
Reported-by: syzbot+b7f3e7d9a596bf6a63e3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b7f3e7d9a596bf6a63e3
Tested-by: syzbot+b7f3e7d9a596bf6a63e3@syzkaller.appspotmail.com
Signed-off-by: Minseo Park <jacob.park.9436@gmail.com>
---
 net/bluetooth/l2cap_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ad98db9632fd..abd091155d04 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5075,14 +5075,14 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 	cmd_len -= sizeof(*req);
 	num_scid = cmd_len / sizeof(u16);
 
-	/* Always respond with the same number of scids as in the request */
-	rsp_len = cmd_len;
-
 	if (num_scid > L2CAP_ECRED_MAX_CID) {
 		result = L2CAP_CR_LE_INVALID_PARAMS;
 		goto response;
 	}
 
+	/* Always respond with the same number of scids as in the request */
+	rsp_len = cmd_len;
+
 	mtu  = __le16_to_cpu(req->mtu);
 	mps  = __le16_to_cpu(req->mps);
 
-- 
2.43.0

