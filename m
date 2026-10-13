Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0D03E0C57
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900189; cv=none; b=jqZkYpNVcJrBVP6o2TicaW5dS+ifeZeKsuxfdG6SF9TRzJNQsZ1MLcDtvyRrOcNa5tOrZYtPNEEV2MHGF6KRmUpDqCmGMPhn1QVeNS0suFFTSBN9OVpGctTS1uYa//dwwHh2FM5/eg3eoWuHZdvJJLSE1lzsLsPC+g0TKlUMYYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900189; c=relaxed/simple;
	bh=F0c7kds7KFBvTXysgeLskNjIZNhIz7Cw+Xa/Ql3q96w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rtzhwbin3t3sO0tO9WRbi+oAd5K2x3vX8z5HZ/5XoNwtFAdO7YV7Bhhu2cIJArWSsQdBh6hKRCCYbFQXhQMSPB04IGnMx1HpWUYfrTfWxKEyofCfP2ZU3EZv7fgGNoEPGmrbkt0h7HCogvMoPZkk9tCrJv9PHmzfc0N0h1XIzz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pGHFB7Jz; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGHFB7Jz"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5df34e70a50so3328563e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 07:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791900187; x=1792504987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DaFEU3zqKeBt7Q9jUCKPZGltUgoLRenaVWeXRietBYQ=;
        b=pGHFB7JzD5ehDu1pVoBWzAuWHowMFdrb4NvGlM8JuhX0IZthiMrtikA2b9zv+HgFbH
         7gciH3fevK45RK4o7FTQ72sGiHxhS9gYnBFozv15BSsdOfJSVgk2GaBU1YLLw5ivELDe
         q3/kHn7WUwBC8EFk2YJYv5+OcTX76ZPQsR6SgYwQtucYFa9YwhU60l08OlPeGEP6jyVt
         SJYG7G5GPQjUuqPhvp8cjZv6FRKo2+qH5Ub18jGK/MalHqOQs3QW3381PiCz/jwe9xuh
         0pjIrbK0Z6SG3kNRHVezcIAc+6mLHC0paZSKuHN4tfCNhsHnHk7RLaPw3wbduiLzdhJ/
         2w/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791900187; x=1792504987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DaFEU3zqKeBt7Q9jUCKPZGltUgoLRenaVWeXRietBYQ=;
        b=B78PhFGFLfSgb6iqlF3UhnqgDpxSjb8UZ9qwpDPxQBilq7bglrhZ9uBc8sKnWJ8WL6
         kC1Ac0xf2Bc6G6FaAL5Lb4D3iqSJ+l0NTBuGMXWgUgkE8ab/wcm/7cAxDLWgSTbVwkRB
         n6Z8x9hv0jgoQgJfNK0u4r+Vw4oK1uQ9EoE7mzgnlrP3SGLZ20EVGq/pcnuGcOLi2aCy
         czQfnqhdjex7cPi5Y4GDKXZ/QbWj2KApvyEth/MSZ3E9ms/mWCYG9O61aUQXC98gw8t4
         A9uRIOoB1UOIu1GIoQXFrOMZ9M46IRG9yE2mxkGNfzV9hMI5dv4UGTS4caMxrK/WSbZh
         3Qbw==
X-Gm-Message-State: AFq9FYL0//HYMxLrgVMxJQQpyXtbUpTkEIDe7MSq4yjCAaH9Gb7hSiBM
	zuekL7YsQSqTG6qf9wTOg7LUvqHNpCA7QBNylJ4H0qPyXzVM2/y2JGFR9lKYFA==
X-Gm-Gg: AYBFou3HXhgJ3/qEkgYRzCacdK9um5f4kLqe3XWqyGcTFV4C0I8Wu+WliM5wMBH/hvK
	fdIOsD5jzycFNp/AIiPMA97UOvw78SSKE1s6RcCnqRcm2/41hpCJCx4YZTctdg+jZXMreFBQInq
	N2xZm9e+DUYQLpEHkEDqy6fStqsGxwODxs+ZRiFRO1cKYlDQ1PV4u5QblDOENHuUkE8okUez2LX
	JWUsvAkKgRvNYpnvZw2N4piJI++QdeVTRqMel9LJ70UVboWDrlyIZ62PIzYWE+G9VLbrOcobCv6
	Bv7RaEHGFSqj/kCq/RmoTjlP6mwM/KarYW8RW1qCPPfEnAsxh44WJAXdrx88JSUrw8XoRq2uMPI
	FpfEld8Aw/u+3YCZ6j3IDX8gtywrnJSCdzMqSRdgPbZ3mxmP6YeL5fVMAdOPMwVThcJfhC2oQFc
	hJK/De2OUIncy0ijivfO1gRIfhyR4Px0te76iaL6p5Pcch2viilRfV/qKa716CCvBi/iZK0WVeX
	3ZYoVUnyrcukPRGOC/kd9q4leeh2PwpO9rgS4S43lVr13oKrn7hAb4mIkBbQRaM
X-Received: by 2002:a05:6122:6004:b0:5cf:dd67:cb32 with SMTP id 71dfb90a1353d-5e91e5b32e8mr2351967e0c.6.1791900187083;
        Tue, 13 Oct 2026 07:03:07 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5e91cb3117esm9062554e0c.9.2026.10.13.07.03.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 07:03:06 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] emulator: Add Minimum Supported Connection Interval
Date: Tue, 13 Oct 2026 10:02:55 -0400
Message-ID: <20261013140255.521668-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261013140255.521668-1-luiz.dentz@gmail.com>
References: <20261013140255.521668-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Fill the Minimum_Supported_Connection_Interval octet of the LE Read
Connection Interval response, reporting 1 ms, the same lower bound as
the interval group already returned.

Assisted-by: OpenCode:claude-opus-5.5
---
 emulator/btdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 0c556c985b1b..67eac8fd082c 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -8044,6 +8044,7 @@ static int cmd_le_read_conn_interval(struct btdev *dev, const void *data,
 
 	memset(&pdu, 0, sizeof(pdu));
 	pdu.rsp.status = BT_HCI_ERR_SUCCESS;
+	pdu.rsp.min = 0x08;			/* 1.000 ms */
 	pdu.rsp.num_grps = 1;
 	pdu.grp.min = cpu_to_le16(0x0008);	/* 1.000 ms */
 	pdu.grp.max = cpu_to_le16(0x0c80);	/* 400.000 ms */
-- 
2.56.0

