Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795527081;
	b=JsGzj2Z08mvbL0n8whJVhRpAOBwXOKR+O+qAo7egvLk9wZ6+l+MXvJYTxr4tR2lbYW7h
	 NBjeQRVPOs5XPv0YU21MW+WB72Lwy9gBv1/NNfPE2ODp3K+s3XRk2WYwgMjfBGEGQkK0g
	 x+YoUOJRsMY9wSPM4hEUJcYUQBAVe2nhdbPTcMz9yWBPwZ7UIsEHjqwQ0j0PB//Wwo8Vd
	 2Dic7zsWNr9a/4hCiWEeOo2R4AdI+BrnLBlmFSgZrfLvNFcZV1A0SDFMlNtHzhT+yyfIG
	 b9S0embOLrhRgLi8rt4f8Z0XEOhtVIzNXWpn6FVhKS92FOR7/bYV5UCiEUni9a/R2FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527081;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ulSWuut7wZIaRb6jvQ/0ecvTcVL+TTKJQ9YQS6FiRCE=;
	b=1fGYzRzI38uLufI4LLXWkhf/mI7mh2SOR7RZFoRsenEUKTPiTN2uLn3yabspiDbAce7z
	 r3vP1rRWuQ49Cjj3I5lFAHhJURQdVC6wfCuHOZYh/cQ8DD7uWJye9YMaMB8GVqNF1fiv6
	 CqQitmOFIPfIxHMcWL/D8gqkcxWXBHWEZo2fmqggvC+X0z1iX/HwYKipCWnJsEIz0lG6T
	 VtaBItvkTIMoZocGCcwvwhFfjnLXjF22BuoftbxV3/mZ9DZsOrC52KfGJm8gb3zmDRH2r
	 f79cVzjKoRflajmucWdJi5riUT6jOjUAP8vCFNlFQiOn5IPQhKm0N17cLr8qN9IcBqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=qKO3pBlZ;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BB4606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 13:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6BB4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=qKO3pBlZ
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-492690dd5daso3439557f8f.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 05:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795527079; x=1796131879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ulSWuut7wZIaRb6jvQ/0ecvTcVL+TTKJQ9YQS6FiRCE=;
        b=qKO3pBlZlNfZg4ZexQOAVY1k+R0mcRiQhc9uAxsfCLwPVUopxz9y8xdndN97/HTCef
         2CiG9dpah49xCeTu7b8aviWAZUAm/eNU8c7Ww6CswTxu4XoyIEuvH+pWIn/FylMvdrwY
         CyQZly2su8MPjjEQoNfZCBpqffENGczABebSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795527079; x=1796131879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ulSWuut7wZIaRb6jvQ/0ecvTcVL+TTKJQ9YQS6FiRCE=;
        b=DDfA6x/5xgHvjo8CD4lXxa07OpkjZQHdtqgteEXmyugKr8P3XyeJ1Q4cXw4zwZKLLu
         9IQuepQUXHx+zZqPsfgnTDo895dmcU7gMVD+nke/W1w0xIBk1qZHUGcL3ZTvi2c47mjJ
         U7EZQlSJ8sv9PPdtGf8qDOnTma33zDzhURvN00Xbgc8SdV5fKu5rFYwC51nrQFgliyWD
         0CEKgRNLw8Nwcs9AONcjI4J/lm9NajQImBeeW59t97sPuIl6+j3NRrfuATh+rG6wXuyt
         aEvfUh4DyAA72akNULIJlyDLwV3uZmFp9fQgyH4ZNGSDJOt9rViHCRuuKCQWjmh7oONr
         tUoQ==
X-Gm-Message-State: APuU4Z9ORiMUSTs36vle1ILZYlQtfO7619GuR7EEfdkp6AsOS1SFKMR5
	sjTyJLXQ8C1NlQLx7Q/YWJzIz6KnCyAlt7rvNYKBPlU+ZEUgBEYWRZm/3zpuCmDUiUaVYewyxu7
	TDyYc
X-Gm-Gg: AZFdTZcu2RNE7gt4ndT8+oxZ6fJhNqeDxr+yKeuTbAjUwimBou+LMM4TWtEGJTPVV2G
	7MT/ONooiaxCv1yZGWyCLWs64tENPYdSs4v1GP6Q7U47DJjD1CDpTjYmmHqoT4FjybLkcFn2d+w
	Zz6VJ1TIGA+SFW71kRsmntNRHTZklzJgctTG2aOBJO1zCtn2zZ2qr10so+/clxXfa1bLQwL1cAr
	FTV1f81KTDR2Hmw4aXJEqK+ByejP+e9PrdllRug/3ii26tu1QVTKeeWXuPXAB65Hx5d5LtXPGBE
	ESTzXL7ojbrkvbddbBs4hQxX9QNkdAORoV7nrr0ZnE0sFu4EDYZV+ssxrISE1I8+7gyuaLF6Tnp
	+5XMbzLJIL3F2TPDwqjhGRVehngthw9gH9uWFiWFOfra/2kZ83UwYbc4feb0v+xtS5F9npCifoa
	lsCRztkBK/j3/5vDmPFtPBXDoqCUBNaVH/Cmz8Dp14wBJ0nthTuLygLZm1CZFpMPaXeY78XBMRf
	Cu9p1UrefpHE6MlsYSiDyyP3LlZzp/zUMJfRzJLOHJM2gXm0SYPSV5oxYuDYqy6gaKkb4FXvK7W
	VdkG0AkVGlgagvrV/JXg6cf+0TwO+V3nMPwbbV7zyk66aNdMNA==
X-Received: by 2002:a05:6000:45c7:b0:49d:7da6:7d4a with SMTP id ffacd0b85a97d-4abb3956500mr18701924f8f.34.1795527078904;
        Tue, 24 Nov 2026 05:31:18 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bb989eesm28145115f8f.50.2026.11.24.05.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 05:31:18 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 1/2] shared/bap: Don't fail an ASE CP write with an unknown opcode
Date: Tue, 24 Nov 2026 14:31:11 +0100
Message-ID: <20261124133112.3956249-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
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

A write of an unknown opcode to the ASE Control Point is answered with
an Unsupported Opcode notification, but the write itself still fails
with Request Not Supported, as ret keeps its initial value. The other
Control Point errors, such as a truncated or zero ASEs write, are only
reported in the notification and the write succeeds, so do the same
for an unknown opcode.

Fixes: b798cec4ca62 ("shared/bap: Add initial code for handling BAP")
Assisted-by: Claude:claude-opus-5-5
---
 src/shared/bap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 8fc28de52..e17e9cb60 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -4171,6 +4171,7 @@ static void ascs_ase_cp_write(struct gatt_db_attribute *attrib,
 	} else {
 		DBG(bap, "Unknown opcode 0x%02x", hdr->op);
 		ascs_ase_rsp_add_errno(rsp, 0x00, -ENOTSUP);
+		ret = 0;
 	}
 
 respond:

base-commit: 1608f836188610aabeff5a3164169ebe0360e443
-- 
2.43.0

