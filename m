Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD730421896
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Mar 2026 22:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773093837; cv=none; b=UeMNIK7cf61oJXmGqJpHEzgkKoLyNIqVYdsy39w+bJnl5hQLQnKpU59/KeqTxDH7aCk5EuMJcYSpFrd0AcWRuz+caVAJTCu74WUc1ZpMPl2We4Z7n9bZw08vDZsO1c/6zfOEI6/Q78LU1bQegT4+eRax2YEGNhbGs7lFCTzD6ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773093837; c=relaxed/simple;
	bh=9WU+UqIhI6fWibFjh4L38q1WncIHJJzwJqm9eh7yoZQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NV/7fxG12Qr03zt+anUqbzzR7WwZHFTxxAsBiaH0RxFmd/2+5Qf4L/yR3/3fwxYgbUAOLDPVi3up0ebREjehFwIHJyhiuqP/VyYOwk/G+FLSkPol5D1bwIHjasfGZpr4L5qT1BJeB8IsXC360Ho5s5lhgLzLwu9Vnl7W81ZWJH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWbDOe8B; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWbDOe8B"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79800183233so165556307b3.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Mar 2026 15:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773093830; x=1773698630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jsGXPgU/xpnVoIYIXQgKNyGokq+Q9BjQuf987vZ6FgM=;
        b=fWbDOe8Beji5aP/cbyAg8fCV+TfQ88uS742gxFFWNu7v/XnvnaQxspKB+qimEM8PcE
         Yu8DZdj3asNbzZE4zBZqCsV0Txx/6L+bZtrAu+dQIgScyfRKyUQ2jLwYSDKJ83r2h3Ol
         xYMEOLia+YYaQ5W0FDh+HMOh0HVWeTUbiXLIUHd/IsB+zyZ1wsu3+XVBGFJJrd4PThPI
         OGTL9Xiw+azsUNmtXxkVwCFsokrfPhOKDQa37BNI1YToOmOXDcq/sLyZeMJVP8oytJnO
         PdekoqxxOGoEEMFxRSclpsRbs7WhiQb2rpUlMKn8MJ12leq4USt+5ddBjKWgJnaTskYK
         qyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773093830; x=1773698630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jsGXPgU/xpnVoIYIXQgKNyGokq+Q9BjQuf987vZ6FgM=;
        b=lUf9rHfvq2Ykt5ohQw9EnwiWBwEs4jlcNdEpQdbedcHaDy5+9cK+x1U+ohSFYhhPas
         dZjDu+2Ri9eIddEOhF2mR/k6VCCDEiKUByE4YsQ3318CT6x43nl40jRphQLx+PEvmG4F
         Zc5gaV8Owh4N5m8c6aSBl7OgMZX56imFo5BL4nA7Kz8Pn7RJwJYyNMjSXMDB7AJLY8/x
         Zcoom8GzHgdbTX07bDORJhDb1bFk21vqiuOKv3jlYVHOXWpzH9FPtRLEuU9jscXvdjdV
         M3IbO7iarQOxWE8DCM4TkE5+gvNBwdpTzRXT89C3RuLVUguY7OzOdL4sDFOYVVk/BMSz
         eWQA==
X-Gm-Message-State: AOJu0Yy1cQi4M3KoDkiEpAXI/saK+nvfEmNvy6K4RID9IdPXb9bFXWar
	d/G7/Oq/85NDUc4onZRk2tDpzHjOfG97H0dyRPAriWza3BuyBZc9RjmrDhOPUg==
X-Gm-Gg: ATEYQzw+9b7EuRDc8jVVgw1vHhxJM7Wmb8/tHZpUfMm+y9IMpwyagc6fi+UtkXdwTZV
	2D8ofdDvrJLUdYDD2y4A1Tk8/N5Xw+gOzi+RHK1HAMU7EiTjwKj73I15bu/WgKoV2HjWkSVR/0R
	NKQ5wMdb0RkOZp7fBAn6FOEAMQgtABigpiJjOTSAadWA67h5ZhsI3Nb+31Gnc4mi+ulWF50RKU0
	LiKRvAnAqz0pivUKb84WKZDodIVrRccVoF9Pxk1kLvP55ffyzzOJ5Z7NcVfHsPiOYzQpXeJCSlw
	aVQhFnXcJyGPcu4lDw+zMxy7TFGVd3y5hi9pgcSW/7GJE/zizrItot35CC7OH7z9Neg/fI9Clf1
	uX7UTTMssokDSHTERL+GWG+atr1tSP+PaHgS4oFVvMidGD/3+Qvg7yzxdHdzizTSQPiEGyVxLuS
	Zbxpd+NbD45A2i4CHguV+NhScpnzG7kcPEAiXZxy26NVkCnEjQSnJZgf/36a1AON/HkWzQ85Co6
	Al4jnFyKFHlRbgytQ==
X-Received: by 2002:a05:690c:7446:b0:796:3e25:3e95 with SMTP id 00721157ae682-7990a86afb8mr13370027b3.18.1773093830149;
        Mon, 09 Mar 2026 15:03:50 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7990a676fedsm5246507b3.42.2026.03.09.15.03.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 15:03:49 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: L2CAP: Fix accepting multiple L2CAP_ECRED_CONN_REQ
Date: Mon,  9 Mar 2026 18:03:43 -0400
Message-ID: <20260309220343.190372-1-luiz.dentz@gmail.com>
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

