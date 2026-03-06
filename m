Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C06A36EA84
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 18:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772822384; cv=none; b=THstuXcaGluZL9u9Lu+vkSITDmAygnbtKIN7j28yrV+fLYT/M7N0Vo6kqJ14edEmGunwtwfydwyR2z4MwNTHw9NYeU2s36UBPfdgQTB1Qv/0+WsTzMcsWviv4bgRypG3JymCKcSDE5aoboYvgW5k79/YJBJKudeM8bJlirUimuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772822384; c=relaxed/simple;
	bh=9WU+UqIhI6fWibFjh4L38q1WncIHJJzwJqm9eh7yoZQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZU9I+Jy3C3EMRWdwrtcpJOOsFOYGMDHUWFBi5ah0PFyDOGsQcsfD0zWhzMPtuX9d6ugQ5KkA3fBmVo2mZlEuwyBzOVtTHPSr5XMt7YXsC2fm+vMwHBEdDMzKnNN4w0sBZOqzQ+YnTBn+3xd6z881TEwxwhlcZqp/d8vg+n3d5rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFfkLGaK; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFfkLGaK"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-56b0dfcc67cso341403e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Mar 2026 10:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772822382; x=1773427182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jsGXPgU/xpnVoIYIXQgKNyGokq+Q9BjQuf987vZ6FgM=;
        b=YFfkLGaK3CR4qvi4NXz30XDgo7xZ4px7qcEuEt+NWlNBIbCNHgmbhoRnil0zc7qDGY
         JJJk+zoIiWDvm2LYbF39qNzqSEp3qyJ4VITbuh7gi2znkgpWhBMjiLU45ZHCDpoKRgu0
         EXe9a/itHBXp1lJJsZR2kQhmQ/32XDsqUy1qvh9j9bLTeuUmf5YsoIwTdn1HdG+EMh4I
         ABXetYphQIUnjxFrk4aAh2Fkxx3RBHyCdlDJuzDDxnTmkCVVnZqG0fVkJmJJY7w8Oxeq
         NcpbUGM58AiRembk6TGKFucxvrQKGeIddEEVauyXGfF4PJg6kS79M5/M4pad4JzS/ZrQ
         cJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772822382; x=1773427182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jsGXPgU/xpnVoIYIXQgKNyGokq+Q9BjQuf987vZ6FgM=;
        b=phPP9AgBaTB20w/PNB+MCLn5+4aXq/X9DcpUh9LkEhEMK7OhBZlXgQPFI3S00iDDrH
         So0haUpczuXr314kjfRHIyjPLnpt57cKE2rDb41UBev28sm/6EDWk0O/1u4Tb5qaD47p
         J4y8bFjSgnkm21/n/mRtLW5vzLU49ed5lmOhNmiadUvws2HGUg5W1dkpycZGa4Fuw5pZ
         /k93perr0e2ykJcaQxFwPRJMvGpEI0hPJoG3QmNXgEzolXXIIJ/Hp9n1EinNDM7Qpnaa
         Ntg3DRP+S7bFF4A0kFIFYMGELtK1F683BXs42EcJxhzok7Mkc1O5aGhgMfdWO4bca28g
         1O/A==
X-Gm-Message-State: AOJu0YwZXInjSJuwEAHeFn2BfSMpEIEiEjqp36ye5ckx7My2a8TTr1Ve
	70rxOGXMjoGpo79ScFbsbo8oFnwroBUShlnwc5QsTBWpu4xCE4hDi5t3LyB8sA==
X-Gm-Gg: ATEYQzz5eql87FcdZII8CV3yrpPy4sbA/KNadYJQdgEFNjfcOLC0oX3ZGXfto/0kYHr
	8gvOIhwahjUrzl2fW17ohfaHnwj+RbVNmF3fj2DIpP5tWM1CsiVaUHa0ufDXNPKwY57SlKllyLo
	4KmvoOc1ccWnjqKkSETwBmSPnwcfyso347txECdN41qS/G9TcPULCsPNU3H/5iWb4udtbi73Jwz
	P3AvPUvrTPeAgdikQ96XDGsdqAQy+5aXpdeLF0dM3uulp6jrJuQDQI88vpR1x+PFZHxzez2s/c/
	V1qYerty/fqNkNSCSAMxskV+nIGh7/ZxpspQ5r7Egbp5m0hL0StI0QuB6m0EuAg/JEq+D47Nqew
	TruQjKuT9XgKbVhH3BoCzRx++1iGO6Bawz5oZK2atEUg6DVFttiVFEm6ZUr2OMqoYP2d1+DVp9y
	1ysJw3x81NXp3yG/GmIwPI9GTKTwJ7iTqKNkbllO7Lgpivd12aJmaYA9fYm8SY30CSCy/uoS+Fq
	o5RN2oINapYskEi5bT6Gz8pk/v1
X-Received: by 2002:a05:6122:65a0:b0:566:4689:46eb with SMTP id 71dfb90a1353d-56b07aadd5emr1151342e0c.0.1772822382265;
        Fri, 06 Mar 2026 10:39:42 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b09b4d42dsm2627631e0c.18.2026.03.06.10.39.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 10:39:41 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: L2CAP: Fix accepting multiple L2CAP_ECRED_CONN_REQ
Date: Fri,  6 Mar 2026 13:39:32 -0500
Message-ID: <20260306183932.631223-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Currently the code attempts to accept requests regardless of the
command identifier which may cause multiple requests to be marked
as pending (FLAG_DEFER_SETUP) which can cause more than
L2CAP_ECRED_MAX_CID(5) to be allocated in l2cap_ecred_rsp_defer
causing an overflow.

The spec is quite clear that the same identifier shall not be used on
subsequent requests:

'Within each signaling channel a different Identifier shall be used
for each successive request or indication.'
https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core-62/out/en/host/logical-link-control-and-adaptation-protocol-specification.html#UUID-32a25a06-4aa4-c6c7-77c5-dcfe3682355d

So this attempts to check if there are any channels pending with the
same identifier and rejects if any are found.

Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 14131e427efd..f8f0f6f455c9 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5072,6 +5072,13 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 		goto response;
 	}
 
+	/* Check if there are no pending channels with the same ident */
+	__l2cap_chan_list_id(conn, cmd->ident, l2cap_ecred_list_defer, &result);
+	if (result) {
+		result = L2CAP_CR_LE_INVALID_PARAMS;
+		goto response;
+	}
+
 	cmd_len -= sizeof(*req);
 	num_scid = cmd_len / sizeof(u16);
 
-- 
2.53.0

