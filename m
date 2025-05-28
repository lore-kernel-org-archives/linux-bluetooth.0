Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C559213E91
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 18:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748458396; cv=none; b=dKo9BDcSD0nkBFp1nGfSRqhSsBNZc0rjkta1fe2kDPfUOCg+ynnfNs7O7JwIdqdlr/ML1P0UJ878N5d/gjaxtvZ2Zq6TxBbLESJtK6teJz3KxTT6ckHEf3H+H61O/79jxuKzpY3TCytW/Lhx1H7utgUv+dT2r1mRHcnXIWtwX64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748458396; c=relaxed/simple;
	bh=7mJ6/yL7rOxF0OJFB7oEwIXZFP3I6/dhl0F7rsYqAYk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=a4z39UvD/+DuOV0R5QrIDbWgojWz6QRC+HvTabcey+oncDuWunz06HW60ub8OLB1hmW0KGnMSZ5UN47K5t9GZe7BlcaFar13845oo4SLNoSI5/dPGGQD4ZCrPUlyD2ZNr83MtmyWp3PPrzdAueu7G6gpcShHV6VItrXfhn/G85U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WeRAu+mi; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeRAu+mi"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4dfa2aeec86so47416137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 11:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748458393; x=1749063193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sclf9uUEpt8UBhswt8kgwvZDxm2lcGF3z0i6H0qAjdc=;
        b=WeRAu+mi+PH392xnMrKNqnzTgVgknwqWES552foBWUEQJVrq/AvOnMnQW9Zz7cCPMz
         IPju7gYt4I9mbzqAxzX18lOd8ae5BvjhIzXAY2SljW8phjuaeSt7rIheNLCpPSkBUm0K
         qeW3EkPGb2sHGxbyNdRqJC7T3xNlPkgaaNxxi7Bd9PMIOYh7WMF8L/E0Ntq2pRhF1E0g
         xglOVmA/BX6jlp5iHSSmYQlx3UQwbTFGPAs+bfGSz3z+7dplcDvh1nhlfi9nZ+O1kSCR
         cwMKhmRA7UWdq3fwKUc9cVmyYjol9g03zRIxu9Wu911w8dbMXnGHLO2wkdTJEiI/k9+N
         //mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748458393; x=1749063193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sclf9uUEpt8UBhswt8kgwvZDxm2lcGF3z0i6H0qAjdc=;
        b=WOYoA4dvzUpxikXwdSgxs5xcBF2EIVMrhQbOgMpowneBvtaQ7+ResQFE6KuRb2JCbH
         QBEOB6ndLJdwFwfWnUsOZkBs073lSCOCq6n0MUPzK6+Bmg8TpFuVUSblN0PE0d/knhkO
         Y/CMQz8JPAzuOQ4YBFB0KJKUIdO5ajYMWMowPmCdGI/RLza4Pewvpec0SfjnXM4rq5jn
         2Flv3JHZudV+Hsrz3vnx2I2qkht+0Xh+5Pvi9QF6urgbDTED2jXPeepv55mal+tSygNs
         0X87l2+bC2OGhYKawOxJ9zstI8vWFgcsZ4Oq010dTRvzfNJIQpqs/prkzWObx4rz3y/f
         KtMw==
X-Gm-Message-State: AOJu0YzGXpQZ7r/d5k3+5UMC4au5wYOZN2LJEg3XqpIFmqSS+qA5ibBL
	4xOdcXjNCFlTwOoYUzuV+PNKVuUQQtKvKYpDReu2Slskcn0AA2X+81L4CARnrg==
X-Gm-Gg: ASbGncvrYATwp9/eMb87Xc3AI/D8Ld2f0oxq+Z2qOF3+LDdIgvoVfDTQIfNPG6crfTb
	XFP48Kvg5D+XPUR9sEpMEVkGeXDD0l5cShe2BRoi+OVSFW1Qst8YPSekfts1pqhdg4RY5s8oScG
	fdoCgo2c3dWyuIWIAe3YpiSdp1TkvCp23S+ocwgBUki92lB0t6fGad3R/OsVqj6ROewYRnX2MP+
	vtwZ7fmYFlnmK+e2Xi5RN+FuBBDznJaWWO6xkxCW07fDn2mEGsnLuKayn8+fEdSPk20RMs2v8iO
	/TGlXbJwErOrp2iFzwd5xR40XkCshtgyIBWprRtyS4O29APmOKgHJP1jOy/0fvnxK2FAVQQOVtb
	PWOzghQZwA+9ceMbLJtg6qhQkuwh5doo=
X-Google-Smtp-Source: AGHT+IHPwDRjt4iP+RbryAsnoIWYiKOfvoovuYetQFlshZnNb9R2AA/D/Pxi2+euF6Aryq0F4vTk0g==
X-Received: by 2002:a05:6102:2912:b0:4e5:a83a:3cee with SMTP id ada2fe7eead31-4e5a83a402dmr2417294137.14.1748458393333;
        Wed, 28 May 2025 11:53:13 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87e1efd0ef3sm1322398241.5.2025.05.28.11.53.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 11:53:12 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: L2CAP: Fix not responding with L2CAP_CR_LE_ENCRYPTION
Date: Wed, 28 May 2025 14:53:11 -0400
Message-ID: <20250528185311.540919-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Depending on the security set the response to L2CAP_LE_CONN_REQ shall be
just L2CAP_CR_LE_ENCRYPTION if only encryption when BT_SECURITY_MEDIUM
is selected since that means security mode 2 which doesn't require
authentication which is something that is covered in the qualification
test L2CAP/LE/CFC/BV-25-C.

Link: https://github.com/bluez/bluez/issues/1270
Fixes: 27e2d4c8d28b ("Bluetooth: Add basic LE L2CAP connect request receiving support")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 042d3ac3b4a3..a5bde5db58ef 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4870,7 +4870,8 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 
 	if (!smp_sufficient_security(conn->hcon, pchan->sec_level,
 				     SMP_ALLOW_STK)) {
-		result = L2CAP_CR_LE_AUTHENTICATION;
+		result = pchan->sec_level == BT_SECURITY_MEDIUM ?
+			L2CAP_CR_LE_ENCRYPTION : L2CAP_CR_LE_AUTHENTICATION;
 		chan = NULL;
 		goto response_unlock;
 	}
-- 
2.49.0

