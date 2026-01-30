Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7826302165
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 19:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769801998; cv=none; b=k8QnfiA6chpkf/tDpO1sqhiVUnIn8wyAb2A8zJnZoYu1NXjy0/A4oAA/hSJh0S77dVZpaacrrKnp3rs2YvcD8KyKtjQpB5G3v2SRB+Wd1JctYl4aNs5GuqzBt+JYCDa77nMu2zu5l48SQYUSAVcgGmTLm1RbMOPcVofsWQGX1ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769801998; c=relaxed/simple;
	bh=Jlj1rKRjBVzxVgIBRyxKkutBwB8j4Tzz9JHRvDsiUBQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rf77qh5DZpxCD0/vXqf5p4SAGlbewPMDJLF6F2C1kDxtMTr1o5adAGbvUDKpp6zbpOos9JcvMmx6C6jm1+X6Xg525fFxj/J5nMhESKcAyMiS/egMGDm6oRnrxW4QDcMJ9eWSTFaasdvyDlpx1FORhlKqFO0irmRNsOr+Mk8IMs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flUp9iS5; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flUp9iS5"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-566360cab07so799409e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 11:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769801996; x=1770406796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MpxokMcsUKLLXK+q7Jo4BGBByS2O/KS/N+91aOel2yk=;
        b=flUp9iS5J5QoY1qTN3DXTjOB85DReU8Na8y5atCJrVexlaXq9YnWXiPQs+q296GDPU
         2DSR8kDxNmDcIrmf1F8u2BZzIzCL7f33twJ4jHEo/Y5jr6VQMMlPPWVeJpUjKYLTVH4H
         i8qCT6Uf41nFwogQhd7Pmwe06AqInUTQSYtJ3bMh6uyBx3rvLX377BWgm+NVUhbMA6Xj
         /Twa3RLMoG0XLXII5wBssDdByBDi+hEcCopfd153yd+xNtmqCVui3IcoknA9O2Cvk8yA
         ynuBGV46pjYbV6ymTvR8soFaWvZOXu0EVmLSWHHWAC4V2H8wsoJ95Zqk0wQMcrkU4bQb
         IPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769801996; x=1770406796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MpxokMcsUKLLXK+q7Jo4BGBByS2O/KS/N+91aOel2yk=;
        b=D3kEWveQI53Vz17s/C2m1SPGmuhJ821P84+0Oq7VcTgbstetat4QbBvE4MlMYpv/D7
         WnpBOnl1I3+KrQ8m91/NYCzqaYIhCY8yfDqXhLVS6C3AorN6q+Bxhwr0rpIesH8RaIQ2
         yy0QVYZ24iT0pr/COaZm4jD8Gr1yfA+KZmGTP46n1y+5MCibRQLMbQ7noKAMJNbFK65C
         jlULjCaGTA6gQYB78BL92WcXsaAqgV55BxHWWcP16hqc1kGa8ZVOAO6RPstwqCyNHXlC
         T1RcCidE45RuQ8QVekM83u8wgodmglVqVxYYTc1tQ3APQUE4MSH+NYVZddMNFcVfnWVR
         TyDQ==
X-Gm-Message-State: AOJu0Yyenrw5ZMuP5sFjvu40XtOs6ZmzZEt63azV6be87luomOuUPuKi
	YHtUep75FdNfsfa5nVp4h07SsZtBYC0K5e0LQjPlMrPlVuYLJwAvDWFZbbvYMw==
X-Gm-Gg: AZuq6aKPjgLZdZx0SbAF+0p2GGn5IkeCIghdOlKQ4Ahbc6y3u7csJqXzIZx22JBwdW0
	HieFiCKf7DosjtydJm4JzyPIrw/ewxMYbvqCOGG1nQFrqt6mlGmfYvX6ufMULpV77mXWGy4T7ks
	scEEsiEDHbhLqJezI6zmJ+sCVLOxvSRCMiRD4m/CswsAGGlRH6QzCn9Dshw5y9g/v7fdyBgprxp
	ITwbd1FhuQCksD+rhYGkY8IKxoHUB5RYG4+uASVATR3nbBvNZE8jyOYqs+meXyuJ+8xVckOfNR2
	xF9nhiCBQTy1zsQxINkWNx2r7TxJq5AJfwD1uEvweVg7BDfPoY576DpNXCDCc0W15zrW5yKfxjv
	w4V7bMLzG8MUDAOWTn9OrQsgWXGStU/bQWL1BKrb/DdGaoxEp7FTcfjoUEBaR8AoAyWob8BaEYd
	Q3LyDUV84j9dFHY2dDW+yr7Vqr8ab18Ahsu4+8qegKwHLCJwA92rw7o7Gg+MGWxQoNR0tzHUE1q
	cwckg==
X-Received: by 2002:a05:6122:168b:b0:55b:9c1c:85f2 with SMTP id 71dfb90a1353d-5669ffd8f02mr1363473e0c.1.1769801995759;
        Fri, 30 Jan 2026 11:39:55 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56685b0360fsm2523603e0c.1.2026.01.30.11.39.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 11:39:55 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 26/35] doc/org.bluez.GattManager: Add Used by reference and Examples
Date: Fri, 30 Jan 2026 14:39:08 -0500
Message-ID: <20260130193921.1273263-27-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130193921.1273263-1-luiz.dentz@gmail.com>
References: <20260130193921.1273263-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add :Used by: field linking to bluetoothctl-gatt and Examples sections
showing corresponding bluetoothctl commands for GATT application methods.
---
 doc/org.bluez.GattManager.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/org.bluez.GattManager.rst b/doc/org.bluez.GattManager.rst
index 2501530d8112..cb2a7f8ff86e 100644
--- a/doc/org.bluez.GattManager.rst
+++ b/doc/org.bluez.GattManager.rst
@@ -81,6 +81,7 @@ Interface
 :Service:	org.bluez
 :Interface:	org.bluez.GattManager1
 :Object path:	[variable prefix]/{hci0,hci1,...}
+:Used by:	**bluetoothctl-gatt(1)**
 
 Methods
 -------
@@ -100,6 +101,10 @@ Possible errors:
 :org.bluez.Error.InvalidArguments:
 :org.bluez.Error.AlreadyExists:
 
+Examples:
+
+:bluetoothctl: > gatt.register-application [UUID ...]
+
 void UnregisterApplication(object application)
 ``````````````````````````````````````````````
 
@@ -111,3 +116,7 @@ Possible errors:
 
 :org.bluez.Error.InvalidArguments:
 :org.bluez.Error.DoesNotExist:
+
+Examples:
+
+:bluetoothctl: > gatt.unregister-application
-- 
2.52.0

