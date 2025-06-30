Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766CC79D2
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 18:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751309852; cv=none; b=eSbJP6kcbyENZQnCsw+DM9NVX24pGN/4BoUr2w+0Q5noEOURZTEKCCnlE4yzKS65eoGxPbfnw6LeYujI5TaCiApK0nngf2TE1ujBDp8baZVSQd8L2t1tG3A6krHQP0vkfDJo1xlwKfnCQjEe1qQbwaEL7QeJUm0K8yHuSvcB/KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751309852; c=relaxed/simple;
	bh=5CXKWiBWR+eOG9yu7gWEurNeiokAYqdSJthOucHyiNA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=R2l1q11U/lYVYkUiAbeHMBRgQpowqzb50of2hkbbHhZxmtx9WGQMiON8ogw7WZTet2YHSmUU17wuQPLT3IAxpbFPwl5IrZAGHBWgqW0ddsg5n2bsvRlE8U58UGulBQ9oxSWButJlR3fnvmUQ8u5uoVphn8GWgNyIU7YVZ0QD5pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtisI4uQ; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtisI4uQ"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-87edd8f4e9fso1182552241.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 11:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751309848; x=1751914648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wztoeBTpk0pNmRe+Fye5rILtJ6SSNaKVBjPJr+BcOMY=;
        b=FtisI4uQ4OqxodKyGE2YnW/G85Ke4pbVbSTZCYCEwZmnwSq0zoxzfpiIL/UrdnJZgw
         ZYQqKSVxsGXaZ37wXgrQ/v97T80NfHMAmKS4CTi/acSXK25q4APPIOC1+VaEVNRMW2k5
         5k8ri5Drf1f883veIhF82ZitIRUwEU+7wgHGwtJfBmq0uQVC+UpWBX8zcS59mJa8G5ie
         /b3vMip512OJD+NyWfynFntrDYdsGGyPtbAzsXZOAfL2JZ4ziSTkHcMHHqqerExF1Ybl
         X8SFh3JI9l6XkrK/leN4HpwfohPoTTEG/s1qjV0+XumNpxkGZsJYIG+mYSZ3EXQ9f5Hv
         1m9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751309848; x=1751914648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wztoeBTpk0pNmRe+Fye5rILtJ6SSNaKVBjPJr+BcOMY=;
        b=t+O4FX7tJaONNYES0hbf0R8ID2ANb5SdZlxDAtvPyewohqUdfcEz84vMeOQNz4R/Ax
         8DKZtCtsg2UbOkXX+HE1xtnJ4E9ZPS/j64KLeICUyjYvPSRfy43mJPIASnaK2bc9vVWU
         U4hEE2h0utCHyA+/VlnbGitdCV3T7cOgqxdJVe8NoO0QbXvAajLzjg2h8SoYzMtIgQen
         U3ZCfB8rE8mLnFaBIF/FMfdCphoxhM4/qrLtrpmIQL34oZmZ5VhXKCbDvt20NEg/7uMO
         RPSIl7EZYf/ZpO9DoGXoMXtTk0xJQo5jaMfaEu3EUbxaVGFV4WtUZ4wT7mGwEshNyafG
         mgnA==
X-Gm-Message-State: AOJu0YwprIdt+hG5ROAI9cWo8K3iI+bPyeIrJW1wy8jgLbUbTvbp+KlB
	iNGKNlR1AihX6xL4NkngwZsHV/T+UZPh7UWwu/W44eS8GuirSNgFakQPW1gnwUZQi28=
X-Gm-Gg: ASbGncveFtAgrBauZ21gsTdo5xJi57cjxEx2DEBucGmR6C+MHSnduPWNu+XnkJDJeJs
	gUBGbauji/j4ffH3HhjTl8Qh2MMYe1SB2mUOSpfU2htCB0iYtXZ84nS9HGdNiRj7FgDgxiUgj01
	U2JIljhKSq3Z5WBWaQl+BZxqWjQ5vQxor9aajkndz72CAr4k2OngODnnoJHJSvz6c3QWclKojZJ
	IMthUdz4FHus3rcKfKNKRbgzm3vt76waGyRqqvuCutZ1RHyoIuO4mN0eV25E0O/fHQk5nSBm7Vm
	pMtxt6OFq6u4tvNYuPU4onQg3FodQRsHnibQfoVOLuBxZstjqhWm6B+6PYgzR0hSMCtXUdQOhPp
	5yuLdTNj3a6vP1rRpzSSEXJDjKKIy4ZCFUEym89j83w==
X-Google-Smtp-Source: AGHT+IHTJmCc2AykaujRnCPJuOrWCBnxoPFUOsEcxYKDU3krNFGUEY5AdC8MDG9Q6Z0dK4MSPVJP0A==
X-Received: by 2002:a05:6102:e08:b0:4bb:eb4a:f9ec with SMTP id ada2fe7eead31-4ee4f78fcd8mr7538451137.16.1751309847586;
        Mon, 30 Jun 2025 11:57:27 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-533091bf1bdsm1458408e0c.23.2025.06.30.11.57.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 11:57:26 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: SMP: If a unallowed command is received consider it a failure
Date: Mon, 30 Jun 2025 14:57:24 -0400
Message-ID: <20250630185724.979029-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If a command is received while a bonding is ongoing consider it a
pairing failure so the session is cleanup properly and the device is
disconnected immediately instead of continuing with other commands that
may result in the session to get stuck without ever completing such as
the case bellow:

> ACL Data RX: Handle 2048 flags 0x02 dlen 21
      SMP: Identity Information (0x08) len 16
        Identity resolving key[16]: d7e08edef97d3e62cd2331f82d8073b0
> ACL Data RX: Handle 2048 flags 0x02 dlen 21
      SMP: Signing Information (0x0a) len 16
        Signature key[16]: 1716c536f94e843a9aea8b13ffde477d
Bluetooth: hci0: unexpected SMP command 0x0a from XX:XX:XX:XX:XX:XX
> ACL Data RX: Handle 2048 flags 0x02 dlen 12
      SMP: Identity Address Information (0x09) len 7
        Address: XX:XX:XX:XX:XX:XX (Intel Corporate)

Fixes: b28b4943660f ("Bluetooth: Add strict checks for allowed SMP PDUs")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/smp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 47f359f24d1f..bcbdd4cd5b52 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2977,8 +2977,13 @@ static int smp_sig_channel(struct l2cap_chan *chan, struct sk_buff *skb)
 	if (code > SMP_CMD_MAX)
 		goto drop;
 
-	if (smp && !test_and_clear_bit(code, &smp->allow_cmd))
+	if (smp && !test_and_clear_bit(code, &smp->allow_cmd)) {
+		/* If there is a context and the command is not allowed consider
+		 * it a failure so the session is cleanup properly.
+		 */
+		smp_failure(conn, SMP_UNSPECIFIED);
 		goto drop;
+	}
 
 	/* If we don't have a context the only allowed commands are
 	 * pairing request and security request.
-- 
2.49.0

