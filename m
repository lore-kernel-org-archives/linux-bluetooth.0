Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5717C3806C2
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 22:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810604; cv=none; b=mqxjj9dTaqufSzyZ3v78XWwr0jHhexlOvjh+ZR5vGy3oO4al/OZUbADzQAsvZ1G2fkly94MuD41Vz/I2V3itjQzuMlrZ0achfQeVEbxMCqZiNbXt+OUBwTH10VHyBCdsNtPdUmhdKvljFrv7m4RjnaKclk6fAP6gVyu4W+dlTdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810604; c=relaxed/simple;
	bh=qlWZUrBrgZuFtEt9pb2464Rr4oOwVaAyiP5aLu3v+OU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8S+mrSvgp14B9a29oZsgubMme2gILiqWyrXMByXnSmZe36+9K0+sPNdZaIpqBGprrhQNlASJgqq9SOnCQ21VPZO3qV6xoJP601s9UZK+glSYH94ozj+L8p1uSyagj4lPau+scOgUpcF9GD1mlzKv7PgiMm65RiULx1oE5SDhPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYHa7BMV; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYHa7BMV"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5ef5c04151dso884067137.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 14:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769810602; x=1770415402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lXdrJ8g2K+RDFxjvauNU0DaAoedEmHuaVAb97N8/dG0=;
        b=MYHa7BMVrXenfz89W9rfveLH35xj6Jtea1xonB25yjk4xNua8RC8Rt2/Yl9Z3iqcyl
         TkdLI5czezQqsTcmzOS4NwYwrCCL0PgM+Gc+arudy9Qz51umk69rchZP2h0sRYZyWPry
         PBKDQreZ3jwsk1PkRhfMaYGLntGiHdhX6WC3zzZYF8eqTuixleu6Q4nN3ME9WRpjf4oT
         s4vcfick5wWJEebA53zCh+NVuzEH4kwoW2xxxAUS2ue5QL47Q4DkJXt7tLXOqGFWhV0c
         Avb6tGBM4UGbhaX4K9JjetfwC476CK6/zdtPt/uEV3RkPAR+cnQBShtmNj9mdeSmy2ix
         80Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810602; x=1770415402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lXdrJ8g2K+RDFxjvauNU0DaAoedEmHuaVAb97N8/dG0=;
        b=eo1nzLCT3QyP+9SxT/nTNlYSIWoBDeplFFToqWcsM7aViQoM4IVQ+hpjJrAr3/kc5t
         28cGBlpyjLNZ7iVPQ+Tc3Fvixd730wNxNdVuCzQa0KWWCDA3vDsCHp6pDobOrGz1mWFZ
         vqTtks9S1390/nTyy7qvevznuUZiC2QN9MmUV9GrqvKQj8VyqMOmIqdYlcg4ckpnQApv
         CtlyGEbROBfNCo+E66zXjl6LDH1UAkuaqA51K818Peh/yr1Y9nPwtzYOsUMGgmJI+OJ9
         ddWejVuprmw02MkJv06D17Ik2+JBUdZUycVxm/9pBXX16dP4hc49XCpdIrBUdLbC6wqU
         u6eg==
X-Gm-Message-State: AOJu0YzGXpq1q4CvvafOTIQ4SI+XMdBwglzV9rgD5k85QaO/SK8TEq7I
	scb0O15tqdySJYCTqnwa6EFDqBg01i/M/mhlIgJQtEUTK6NwNlA3LTbg0wVyIQ==
X-Gm-Gg: AZuq6aJt6gZRjC+q9/3r3po0y26hoxTsPsGlEYXA6TGlpomKNNqejAz6IwoqfrYZxFN
	0unpBYfL7MsbKdMFAHOmN0dKFQ1gCFZ+mrqXGgRz0IQDteNZGediYIb+cw0/eFFL5CxY2TOSKEM
	OjhRtCMDV10Sz9EUSCr4gYF3KeGT7UpJaOtrTWgiM6OaS6ziiQSMgIJE5MITtp4fyiG+zTh9WXb
	b73dzPANGgCr42U+s6UOF+M0d5/LtL3mSJDPJ0dzlXwzrhfXDas/uY2hieANSVJ3QDUQqDAjNqT
	+RI9D4fSy82xNc9ji0/+Dq05sly+vE2kDE+jrQabCQ7YKV2WU1TGL+89qWkopBgwSbvfNpqAYEE
	5wCnxsgRnSj+dLhwRab0ddQ7KRK6W+uLhGNjdvZhh7W2eRv83e4VEu2m7KQAwPBCqlvP+1vxzAg
	Ln/Ggg/ymdd2CiLiglL8hlNKRi0PIb2bD3tULsti1DaE3cQNYtAKQFj9CqKQA7X+LgpSw6AUidZ
	19zsA==
X-Received: by 2002:a05:6102:4407:b0:5ee:a8c4:18f2 with SMTP id ada2fe7eead31-5f8e26c4586mr1169554137.26.1769810602152;
        Fri, 30 Jan 2026 14:03:22 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948723adb7csm2404052241.2.2026.01.30.14.03.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:03:21 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 35/37] doc/org.bluez.Telephony: Add Used by reference and Examples
Date: Fri, 30 Jan 2026 17:02:26 -0500
Message-ID: <20260130220229.1346261-36-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130220229.1346261-1-luiz.dentz@gmail.com>
References: <20260130220229.1346261-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add :Used by: field linking to bluetoothctl-telephony and Examples
sections showing corresponding bluetoothctl telephony commands.
---
 doc/org.bluez.Telephony.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/org.bluez.Telephony.rst b/doc/org.bluez.Telephony.rst
index a722e2a38394..4a2159e17bcd 100644
--- a/doc/org.bluez.Telephony.rst
+++ b/doc/org.bluez.Telephony.rst
@@ -17,6 +17,7 @@ Interface
 :Service:	org.bluez
 :Interface:	org.bluez.Telephony1 [experimental]
 :Object path:	[variable prefix]/{hci0,hci1,...}/dev_{BDADDR}/telephony#
+:Used by:	**bluetoothctl-telephony(1)**
 
 Methods
 -------
@@ -54,6 +55,10 @@ Possible Errors:
 :org.bluez.Error.NotSupported:
 :org.bluez.Error.Failed:
 
+Examples:
+
+:bluetoothctl: > telephony.dial <number> [telephony]
+
 void SwapCalls()
 ````````````````
 
@@ -113,6 +118,10 @@ Possible Errors:
 :org.bluez.Error.InvalidState
 :org.bluez.Error.Failed
 
+Examples:
+
+:bluetoothctl: > telephony.hangup-all [telephony]
+
 void HangupActive()
 ```````````````````
 
-- 
2.52.0

