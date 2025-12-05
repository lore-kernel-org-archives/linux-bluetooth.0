Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DEE2046BA
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Dec 2025 17:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764957369; cv=none; b=uHhszGobaoVxw/A2LRAomwXbBIpnDDReUBqOq3MzhLpYVAiexrjZyWd3EZCrIVbNcITQyQl5a9xN6vVgIjVBIq+o0ZPcoNKBDlaNCPgb1eodC/9R528PF+4sFTW6oFPmkLkoHOVsKniF1FbDOH5OmFvfaxeqAHBkuW7ddqTUo9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764957369; c=relaxed/simple;
	bh=cT+okyoUrHTXA45Is0Pw9F6TxfbUti+FzziBF41Y2dc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TTZd9Bda9vkGx9i8yanA308GpgsEOxfCwJvpUAxtSqRNGH02U3bKkRcQDKiFG1dCFFib/VPx5ZmCG9sZGx56PVJDJmwtyK1ZRkDeyX/AKw41qacoX3FJWuh8ZxBZK90vax9pZrfqicFxCd+qHV0S/bnVBY/3xTExhqhwx7mSW64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9aV+sGc; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9aV+sGc"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-299d40b0845so40507355ad.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Dec 2025 09:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764957367; x=1765562167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZlkRLK2kR7jmdSrjUTkpoX3kF+r/9UBuu/w/fSD0EY=;
        b=W9aV+sGczy519i1x2Pwh62V+43tJ1dPNrr0llLdd8N2KFtACMUBmtfjrvhqw/F/5be
         l3PczTqWnkxVvE21OjNXE3GqjeNgNm4fryvqdlyxQsnXmh91vfJxiZ0+Ogz8q4W2fWTC
         iINph9TUWa6QExTgIMDd8AO9oLDjwE5hU0Mk0WZoI7o9revZO6MBWkz+mjSTm5jyT+yf
         DTPA6jtiNwHPyqBX7kVvLqO6ezSIQE58VBMHu8r97OQxyuJH503MkYvEAF5PDUicQz+y
         Q5tCp0eyDGjTUdoTpVIFMWCY1NYyljUVBi9r0qVGTW+MEpg11n1p1QGA0MnnUFn/nM5Y
         T/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764957367; x=1765562167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZlkRLK2kR7jmdSrjUTkpoX3kF+r/9UBuu/w/fSD0EY=;
        b=DoZp/20Pns6RFT+qw72hLbYsxsSD+X4F++pD6X2riPF/MozUb/8R/rML+AH21E58QF
         G6Wwda5Tmrc5ff8bbcbk8f1amLJ9fknHhUOUQPJP3WtdOQL/ey00TmyyGyROMRUinV1K
         9nEYQhPSOKbfy1ToSyzVjGZP0pZW0fZKsOvaT+/jcNguCAgeM/22yDvZgtv2weIfXOTO
         fU6ORYu5ol3MlSJg0Pw757klV0+OKsccjQfsZr9T9DVOJLe74R6ownmYDC9lEDj8hdpn
         r1oxAXkdkl9lN4wxZg+O7MgGGPKGsJfIJyGjYao96UNSmeiDZ17dD6zieZL9xJ+XgpQu
         IgdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMaN297oSPLHMCO8sKA+g+8/NZuU2mFfOYwesCCLEni0lj0dIWRBiWuono5R0bddbYYocnSAf8xaS+6Y4vQBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBLm+wQ+I5+y+w5lltiYw2uB/l2OSMz24fHRK1JTcaybhg3vzz
	VlMqTn4ZJfDnjvHkpvAVPLB9fEmZkIstKVUJ38hrD9+BiMviiIW678DS
X-Gm-Gg: ASbGncvVN8WTOPWWDVMIkMOpPxQeaxb+NrT5ykNuaLb97nBoPUtcaRVEH0ytrOIYBHq
	kUdaUE1y6QIDXh5fJAues6X+nRiyWzFs9b0gmp5AYLgCrBMJa//nahXATHxTPSTCQ4dz2bN/Rvn
	B6VduPZT8yy2lGI/BA7/qPXRWJwfhj7ykM8ytmGlr1qVkEsB7e2PmniN7UDQPqXJnp9UHsuIdHP
	F5eOs+tz4BVFNrT5wnnKlmyHv53zI0ekqmUtmB4JwCo5UwGyyNTSPNo+jrKvKNEgqGP7mtbYRUl
	m9m7wXgs7cWEidT8iW3qEmgDiD8EBbVQS2c9Daa+P6KPQ7z0+LMGyNoQK/W3q4NmbaPBTgPYmVo
	kRyEhfOFIobEHM6XZvsf2cDUacQPSJk379x6e6E1Xg5G6M5xoWBQRUaDRuSIf2wd9vjCTxsZFMs
	MfjaeJR/XAOyeyBsTiOTyt+UdN2qG8sLcIvhK7vro4VA==
X-Google-Smtp-Source: AGHT+IEMZtS5OhVis+tAJNWxbgTpnD1LDhwjU9539YkWmdypSP2a1B96Klyjr09ref54U4oS9Qg8wA==
X-Received: by 2002:a17:902:f790:b0:295:596f:8507 with SMTP id d9443c01a7336-29d9f51abe1mr89758185ad.0.1764957367074;
        Fri, 05 Dec 2025 09:56:07 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:8839:f626:f539:b6d1:1913:1426])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae4d3b5dsm54459245ad.40.2025.12.05.09.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:56:06 -0800 (PST)
Received: (nullmailer pid 619889 invoked by uid 1000);
	Fri, 05 Dec 2025 17:53:27 -0000
From: Kathara Sasikumar <katharasasikumar007@gmail.com>
To: alex.aring@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, david.hunter.linux@gmail.com, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, shuah@kernel.org, skhan@linuxfoundation.org, katharasasikumar007@gmail.com
Subject: [PATCH] net: 6lowpan: replace sprintf() with scnprintf() in debugfs
Date: Fri,  5 Dec 2025 17:53:24 +0000
Message-ID: <20251205175324.619870-1-katharasasikumar007@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sprintf() does not perform bounds checking on the destination buffer and
is deprecated in the kernel as documented in
Documentation/process/deprecated.rst.

Replace it with scnprintf() to ensure the write stays within bounds.

No functional change intended.

Signed-off-by: Kathara Sasikumar <katharasasikumar007@gmail.com>
---
 net/6lowpan/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/6lowpan/debugfs.c b/net/6lowpan/debugfs.c
index 600b9563bfc5..d45ace484143 100644
--- a/net/6lowpan/debugfs.c
+++ b/net/6lowpan/debugfs.c
@@ -173,7 +173,7 @@ static void lowpan_dev_debugfs_ctx_init(struct net_device *dev,
 	if (WARN_ON_ONCE(id >= LOWPAN_IPHC_CTX_TABLE_SIZE))
 		return;
 
-	sprintf(buf, "%d", id);
+	scnprintf(buf, sizeof(buf), "%d", id);
 
 	root = debugfs_create_dir(buf, ctx);
 
-- 
2.51.0

