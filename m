Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EEB43E4B5
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 16:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775059330; cv=none; b=nnmI0f8QH6yf6tZtFy8dF2v1DAsu76u/uKxih6bsZcMtJXCHU84G1HnPkhmWaUERAs4sMp4UEFOlaw0Y310oXAKnDE24BWWlYWWpmHyvornOX1fCuLATGoAGwe65AIE8VURFuYcC0m0Wp6yWiHUkRlGGSO3lJS5+82KExcPRHac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775059330; c=relaxed/simple;
	bh=dlnvrm2aUCqm5l1PrhF7v55mNBfLLDsqpwzDYNXJ3iA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qMStWcDJKNWLi8+eqwcs9zzj2zGRnOQ1yLiqNpmo629nfUIP2cUYuTPZ8CfTGohuMyhgmSkHde/zlqCFH7RDJvty2tso9fN4aAQ7hfjrGQK30At0FEchGMLNmkJKxMUe2QVyvvcPLO9tH+Ekk9Vn/bhyoJu84LnDX8kLfoX683o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBsnGtRT; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBsnGtRT"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56cc6fe8815so2916776e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Apr 2026 09:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775059327; x=1775664127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=m6PLcPZi+1MMFIyDuFd7fRt/ldZ9499Jbr/Kd0YS0IA=;
        b=YBsnGtRTHHPb59If1wPuZSPsWYBbeUsm6w6jVJnBKm8sFiWvoGGillcstasQmm9wNq
         RjeCYjlSL5hGFd2kvck+w6meLxTHX8vAGvss0y3zBBOe7idACgJaAQkMZebe56CniohE
         9Dc0fgZazpok5uiWmgLiRDYBpPBkk8RHZqekilP30wR4OXa0aYGjK1xCNpwzCvDhB6kd
         Yj84s0HNlhGZKtAKKCs6Hjkp+gt8oMt8oEDjQgylqCixaNkD7VoPbt4qjNOKtTxMSQnZ
         P8gulbYJEOKu1tIGuFl63oxJwBq8BfiSydKw5msDwrC/Lov649pKaGBXToRZC2HZeQEG
         u+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775059327; x=1775664127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m6PLcPZi+1MMFIyDuFd7fRt/ldZ9499Jbr/Kd0YS0IA=;
        b=NYZoHukXSG0QxGMXt9aMLCId9KpeZbb0wv5d2IgLqFSPOf0+ZxCQwboIkyzWvsJrJY
         Q+9rQdcmn14QXGsQxYWY4D9F9hl6gPJvfCYx6JJJq3PsWXdIZ360nM4vriwHaa6eAO5P
         AF8clh7Jm3kldo2EetMJwICYTyOfBzcyFD3T7CioXfyyK8XZcDiDnWv5w24iQiq6Kcem
         P3opucRnHiLsAtzj9WACcqbT9n7Dnb/XQLSaizr2eXFd7RYAMdxSCvrgI5dD+wxPv0qB
         jdmbdOLjbzcCD0Oa69iKhDHS+I9vf4aatZxR9z+nNkmFbonLTMsOARM8PCDEn9knbKgh
         Y91Q==
X-Gm-Message-State: AOJu0YxgAEw+btigXwfX+MG3PyGeN+1kbPBwQLH6MNlnU0hWvtEn3jdg
	bAU7towhOhSJeN/si4WIuYk4g3BXOyThjDaW3jZCA4lW9wCHM0yLe8DPzkfOg5Ra0f0=
X-Gm-Gg: ATEYQzzHIEa1CL2GSiyaSGD/uot4utGjQ1x1la+JXAM7HRpwsLMARWArwCLFvFu4o+e
	9XFzdj0GzRGwkDUxWfJigGwYV25kYcrTBljRyzR0cR1yloKapmxcmMnHJ4/Rt0gI4EQZH6uyxJK
	gpRjyc1Ln9R8/hf9s/tTApF9uPxRKgBKuH0eZisHOCJtw6aD5vNvWkYhwdhXCZ2p793DnIBzZN0
	CPzojJo3YHjw23EGUe8fcYvU7ZRNz+dgquiiwM3dZjvBgkq5FwVpVZCzJuWUWDlLsSfbvcSzFf7
	FQsi2bSRyWUf3v6tcvK0K8Xbe82TadeE0mavtXAixOzdt8ukHEturw1A/IZWQC4P5Butx05nKyb
	YKBVa/V7RNRbBXz0GPqEZxuMOMQliXPl8KpQR8ZIZ72vy2r8RiXstuaJacQMueKqpeh3yNU8i5c
	UCzsxt1P6iMHTPAsym0+5ze997xKS5ljN+t326yrzMfJMtq0HRMHJtw1Vk8poTjmfhT5oOT1IWP
	tA9uVbMabx7z56VnQ==
X-Received: by 2002:a05:6122:3310:b0:56c:ce8a:b07a with SMTP id 71dfb90a1353d-56d8a85b2f0mr1748647e0c.7.1775059323250;
        Wed, 01 Apr 2026 09:02:03 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d58893d37sm17907391e0c.3.2026.04.01.09.02.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 09:02:02 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 1/3] Bluetooth: SMP: force responder MITM requirements before building the pairing response
Date: Wed,  1 Apr 2026 12:01:51 -0400
Message-ID: <20260401160153.1980387-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Oleh Konko <security@1seal.org>

smp_cmd_pairing_req() currently builds the pairing response from the
initiator auth_req before enforcing the local BT_SECURITY_HIGH
requirement. If the initiator omits SMP_AUTH_MITM, the response can
also omit it even though the local side still requires MITM.

tk_request() then sees an auth value without SMP_AUTH_MITM and may
select JUST_CFM, making method selection inconsistent with the pairing
policy the responder already enforces.

When the local side requires HIGH security, first verify that MITM can
be achieved from the IO capabilities and then force SMP_AUTH_MITM in the
response before build_pairing_cmd(). This keeps the responder auth bits
and later method selection aligned.

Fixes: 2b64d153a0cc ("Bluetooth: Add MITM mechanism to LE-SMP")
Cc: stable@vger.kernel.org
Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Signed-off-by: Oleh Konko <security@1seal.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
v5: Address the comments on
https://sashiko.dev/#/patchset/bt-smp-v4-ea63d24bfcd1416f9da279190fab15fc%401seal.org?patch=14762

 net/bluetooth/smp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 485e3468bd26..deb8dd244b77 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1826,7 +1826,7 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (sec_level > conn->hcon->pending_sec_level)
 		conn->hcon->pending_sec_level = sec_level;
 
-	/* If we need MITM check that it can be achieved */
+	/* If we need MITM check that it can be achieved. */
 	if (conn->hcon->pending_sec_level >= BT_SECURITY_HIGH) {
 		u8 method;
 
@@ -1834,6 +1834,10 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 					 req->io_capability);
 		if (method == JUST_WORKS || method == JUST_CFM)
 			return SMP_AUTH_REQUIREMENTS;
+
+		/* Force MITM bit if it isn't set by the initiator. */
+		auth |= SMP_AUTH_MITM;
+		rsp.auth_req |= SMP_AUTH_MITM;
 	}
 
 	key_size = min(req->max_key_size, rsp.max_key_size);
-- 
2.53.0

