Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192632EB5CD
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 22:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810602; cv=none; b=gPmJAlbgOQ+nYneIObPzOG8p9rx5aKoSEDKnztgYXMuN+6GX+cqUbySs4bUkqoejIaRvEyo/e4EiIr5sx9xiDQdQNoT+akYU0o62pjqXK3Bq4tTXtyvXmx4Nx0utT7irh+IZOkqw2VA3tsyZrRHAWqevCDNqJVzFddln03ynHAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810602; c=relaxed/simple;
	bh=kS7qcyg1JzC0JX6oQ5lTeUunDZ7FfpkyUMDyLc98Eg8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRyX0pxN8JPC/wAmVKgwzOB0+UcinLY67+/qnyOz1s8naFgLZDS+4tFnhp3awBj+fuowEx3ErXNiEpDRI6F28xJu4hootiocUPatZqhElU1jOMy+vBd46zi6BpCYhDt7y5ZPxD5MLxU4oQWAQuHzZgUqTXYTy0Xi5Lq0NFYN0lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4PiGQr8; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4PiGQr8"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-9489bf609bcso171783241.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 14:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769810599; x=1770415399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lOZel/RR3FVXGtQePbnVhx7Fp0+hXbVh1nNa9FJksSU=;
        b=K4PiGQr80hJyx47Clrd/TarNfhbJieklO5Gqs8EJWqQSVCDm8L/vnqYyIAUcYS7zKt
         IFkxwE5PtCnaO+fSjZWtkMnYSjDnB6nep59Z172n/w3MfDu2A6Uppm2v+apERJfz3XAx
         IcGy6jBsbscVmXre7rU8Nve0Jw3bMLturCeulCGR7J58JIh8HFEpKYZ6h9s8mKgePByI
         yUOZt1EL9Omp2Gc7cTV39vrlocnZRfY/Pr4GHht69FZtJyA12npREyo7j/mX0yXcda8q
         l8p6IDGutMAgU0j/ef3+cYkvJbiuhiVEFEYNQKI5FwylUPUyYW/qQf0uBk+E41YLEu0v
         +lAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810599; x=1770415399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lOZel/RR3FVXGtQePbnVhx7Fp0+hXbVh1nNa9FJksSU=;
        b=kBdgyWPRHTh18k7KKdSDlyZ5zQZgJC1koEk2sQDQmt273pNkkTdbOhCpt57JrpSDG0
         eoXK1OH87Jo3xiQy/agU72VXqxZ42yd6IYh1hJRBjSdbEZ+QZ36tR55vpJ+MUV9/qdGB
         owWJLFLG+FEpH+ajJESjDHHPf4RzvasPyuG4FVV6K8igCuLz6u0qGQlZKQkhwEdsDzhx
         WMOMLJlrkWm/JBBVJ3V+IEbMoiUHkF5ZDAIfwaQx8TaKS/Ctt8YspH+zCcnJWii80mJx
         OtSpRgi3i3enzvzghKqqF6G6/6kDzgVuK8WZW5IgnJFrpcqOtcAlVb9kuZXtgwqZGY79
         G0MQ==
X-Gm-Message-State: AOJu0YybkhUzZ47VNnq/3oJBCpYQdhWRPJd1z+68vdL1Wm9p3/Yr8v5k
	CWAe4VxkaZdt0oAiSYp+i8+95bKGZ2UWX8pOXS3HnexwyFKYCu05EvmZqae3LA==
X-Gm-Gg: AZuq6aJ0v1wf+AUJj0pABFt3sjFVzQwjoogIedLAUwloTDUBihMB+mk1N76qEpnRL31
	NnsGXW7QAUZMzvBj7+gpB8l5xoFw+Zh1WNONs/Z+z1WyIEL25fZAxiy1Ai8ejV5Gxi5DNE87XLV
	M2w2RZAyAOsmdYoHyocym3YwySFHrlvu0KcO+TPi5zVVB+rCaEqrOcBxmk1ZrlODl/J3wK1L7Dj
	CnaIJ13aZtLLkyG9QmSs/4SXyNDlAeDpRjQz14XniEwblBMQznB5EgB/CAd2p05rUsEP6gClsJh
	/FVtJjK2R5l3b2dO3ugQRJdAzWlVrUgl1VvwMBQnzl1ehuYHvXwE6Fev+jvlxIa5r/oowHgJSgQ
	hjBkQhV3UvKp/ir3cqHONxBgA3EgE25NxnzRiTrV6BnOaHR0lsTQE/Id5MshQoJwPDxZjk827yq
	4leFTWtmT0CoeGMMvfUbPsH78N6ZV/NH5HDLnSC+kwLIXPa3ZUoV3BJTD7MrmKw+HtQAhx7Hd9M
	jkgaDrDCzIkAgg/
X-Received: by 2002:a05:6102:3243:20b0:5f8:e373:50cd with SMTP id ada2fe7eead31-5f8e3735e7emr799120137.16.1769810598618;
        Fri, 30 Jan 2026 14:03:18 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948723adb7csm2404052241.2.2026.01.30.14.03.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:03:17 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 32/37] doc/org.bluez.MediaEndpoint: Add Used by reference
Date: Fri, 30 Jan 2026 17:02:23 -0500
Message-ID: <20260130220229.1346261-33-luiz.dentz@gmail.com>
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

Add :Used by: field linking to bluetoothctl-endpoint for this callback
interface implemented by media endpoint clients.
---
 doc/org.bluez.MediaEndpoint.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/org.bluez.MediaEndpoint.rst b/doc/org.bluez.MediaEndpoint.rst
index 8202b2fdfec2..d1b9c8114052 100644
--- a/doc/org.bluez.MediaEndpoint.rst
+++ b/doc/org.bluez.MediaEndpoint.rst
@@ -19,6 +19,7 @@ Interface
 :Interface:	org.bluez.MediaEndpoint1
 :Object path:	freely definable (Server role)
 		[variable prefix]/{hci0,hci1,...}/dev_{BDADDR}/sep# (Client role)
+:Used by:	**bluetoothctl-endpoint(1)**
 
 Methods
 -------
@@ -91,6 +92,10 @@ Possible errors for A2DP endpoints:
 	:org.bluez.Error.A2DP.InvalidDRC:
 	:org.bluez.Error.A2DP.NotSupportedDRC:
 
+Examples:
+
+:bluetoothctl: > endpoint.config <endpoint> <local endpoint> [preset]
+
 array{byte} SelectConfiguration(array{byte} capabilities)
 `````````````````````````````````````````````````````````
 
-- 
2.52.0

