Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795245325;
	b=fX2TybmVrjrliRPkW8ZFnIHbq2qp/81spyXSgRRnWGtUyNyP45Iz7XsCTCFC02TCS72q
	 dTPnpYUAfTlW/FslVhig5lEWwRoGl4K5+JQ2taWIDJzWi60umaPgmS9/CpWwUk2ZKlNVq
	 rgjWnmdgZlS4ZrHyiTDJnl4iiNkXh9z9gMlOW6nv1b3zHH+/5RRuFi1EtKVdZHkkYowG3
	 10gSM6UmwOc2UhyGLUiBEkN3n9bVsZrO/3Y/RYCWx7ekryNSN5eP4aQ1vDauR+ubSbcax
	 Vuapgsifbw+hzmhrU5bz+P+bpOut6L0U3S1aUAOWkCn6qBXxfDy8QHhr0bD5m3qx9Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795245325;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=zzioOxlkcVp3dTuKm57v0/MU3pavFbjKKtH3W6hDDvY=;
	b=reEOIegYJry4dPMPxWagfIwIJ/ZgBLgQitokxm8QnevEz3iWfU7xewNcXLXLRATHU5rB
	 Na1hg+q6QFkxd4yaeKZHlCEbGU3Lb0hNMYtamaqLzymgKxLBrB7s2WOxFhAjdPupNjoXI
	 Ybb9V7eY5ch3wAJRjUWXFZHjFe9YoEVgnfMiJzel9za2NizzyUUb7CzKZPRXU7bzsL+Lo
	 XNP7sanr1zveNz1PkwYCrOTiJk1cA1SDn3V7Kv3UrCgfYVRT8jGDipF1mT2/OzaL31Yfb
	 wmESLap97qRDn4lAytDglcu9PsAZw65ocu/dsPDzila4XOGPPuWarx6mk3i6wyIz4Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z593fwZu;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48705606A320
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 07:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48705606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z593fwZu
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2f05b465cd1so3689435ad.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 23:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795245324; x=1795850124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zzioOxlkcVp3dTuKm57v0/MU3pavFbjKKtH3W6hDDvY=;
        b=Z593fwZu64OW9fpBELLINctYQBs/+O2/bVgeOTcOiBIAYwMqP42vlTcmUFqpZtdwOU
         MZPWxW/llJufQxe7CE2/dUSsl0jXzV/aChSVh/nLfUQFT2QPIViFX4khM9ovW9y7BJ9n
         wZrqiNrUJ+Wd8CzMlrf+w+C+AQ4+74Qr5IcC+84WT6sphalVWD29bfWXCd2vrXtTgkXJ
         Ffjx2j4WLfklvPEZZLlRY1i/Ruz2iWQ2C1Yz7PmDU2KRTgjR6qAcUgVT/t2IvXm1ct6p
         tXbgPLxoCEug0kc/Vg3JCN7S80iAD5kyE4Wk8yVemNY5UsO7QFwDI0XBokbkiU1ttDSG
         sSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795245324; x=1795850124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zzioOxlkcVp3dTuKm57v0/MU3pavFbjKKtH3W6hDDvY=;
        b=T9/agvDDRoGSKU7EDhhYJxgfEdHhCPI/sKaYx1GwKDk4NSmbeUptYrYb0HbtPLgmyC
         0GVkEzIz0JHKkYF4FX70iaqcBtT6HvswsVYihTaQEINwCZw9WYf9rRd9YF0G/qGqF0hp
         zcAlNrRkAFLghSGhdYJKR7FJzOaFPje1Rzyz0JTbX3+Y5g0GnfIq0gozSDPp17+weAIZ
         5imz0U8ftQSacbV4d04ppj1YyOp/hbJvpYI8Y4QO0AeB5fI+U63IQakG77/hmW28KsbP
         vtdaUYMQL22fY6PxgBd8M3Tu+RDOawy3iC3zvrJY08cuORiBJLrEvqfVB8bKM0Mbcd2z
         s0Yg==
X-Gm-Message-State: APuU4Z9GbuQCc4OlRZMNPo3qrDtPRGKCC6Bv5WXe8nZTYy+ZeNy3MOs/
	6KXPJ36DEf8I80cCvTANeJxThRVHlBGgG0gpBWMjAdOqzGk8/rgmDQXq
X-Gm-Gg: AZFdTZe8YBKr5Z64v9YQ9k2wpd8E2EnD5Dc4pCFkqr682lyBtEgSgjZJbaKGb2inGst
	qxDYqVcWLAqQXa5i+HKnnx9QhPwg2TyUV8+qZdlPBz58CGC6vGpvKBI4V69047GjxZgwGgFdVns
	VfTtFh8dQDT4OQxiohNsFDmgcOx88aSIb/3dDv5J6ek0EoxPGFMysMDIvXYH7UISKGD5NoTxGFy
	YKh8B72YBBiMuyaGr2mdGgNn4EHIzo4NIJssZRVmm1zlQDEWwUNU+lGMTFhrEj4OZ9vkK3vsgXt
	rDVpN8xow4bfrtDH2tSK6DM41odbYt0Y/GThmU8qSVdrHw3fkqasyqa1yDb5AtmFkSHoc+Jqf7V
	FdyeyQiA3QatMjZzj8OBa2ln+RlKtx/2PB2LcRvjQdTdB2e/67qw7Yx8ywPkHW3DJXWGARP2X/2
	1/jxX/LORVW/wSQTcx/QUSSSwW8lnsYbKrfJtiWKrLST+dBDvt3ceWGz6PUo3exEPPgNVXogvN9
	NNpIy4CIzGZGAX29if5B2CwkaplTVHxezkPEiS/fklbwriPgAjeZ/jMtnji9KfK1+D388Xn7rn7
	vJ/cTTrbqme+Tk4Exw9VUdgl
X-Received: by 2002:a17:902:db06:b0:2ef:efaa:17ae with SMTP id d9443c01a7336-2f03f1bacacmr49222005ad.71.1795245324420;
        Fri, 20 Nov 2026 23:15:24 -0800 (PST)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f04f6049dfsm13508675ad.19.2026.11.20.23.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 23:15:24 -0800 (PST)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH 0/3] Bluetooth: MGMT: Fix pending command races
Date: Sat, 21 Nov 2026 15:15:15 +0800
Message-Id: <pm-bluetooth-objects-candidate-0167-v9-45c99868af18e41665a3-0@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Keep the socket alive across SET_LE work, use the existing pending
command claim for immediate pairing completion, and serialize extended
advertising data with pending parameter requests.

Cen Zhang (3):
  Bluetooth: MGMT: Fix use-after-free in set_le_sync
  Bluetooth: MGMT: Claim pending pairing before immediate completion
  Bluetooth: MGMT: Reject advertising data while parameters are pending

 net/bluetooth/mgmt.c | 54 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 11 deletions(-)

---
