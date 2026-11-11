Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429485;
	b=0vXvSp2W0CTu/efe5OwfvUTflhDMmr1uojKdACbWe/iyMaFtejRQOie8Wo2Td8+1Llv9
	 Za+M218gmmho4Afy7QqNNQQqaQplD8kioRODjFSTgMHbKT8QowdVe3tCQI+yelrKRQ/IF
	 KtQ7qWSpo+3nKKCIhoySoAuC+PprvaMoc/S+8GywWEC3U+HHAxSchbG6cKqJbyX3H9qnP
	 JnsGzWL1JYWBwDcStdOAkvO9bSMXm2NTO6c1QizCAORXhJouwkjgoFjgO+gVmAqd1TWZ9
	 9XO6wypkCejNX0oZcjxqILm5/X4wZmG104Xt2swPHNeiSbRdXb0YX47wh/QC3opSlXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429485;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pkRaUBe9pdxVeXLuqR1fMj9AzhBZtgAAKRF0jBb6TvU=;
	b=Y59673GolC9+ejHJstSLjGcGDdy7FFELwdNlDho19hHbYyUNLIQhXmTDkjHMSrzY1HB8
	 PuMPxzR6NT0X5EQdk4wd1hZQ/PzwFJu+zewKJN/stv9NzSh2g3g027B6Z/Xp+AzPmgh1f
	 pFuORg459rRlS0plyePDJ/KBs7eUwOuy6dzRlNHQKvNkAeeNIX8z3+3/HkxwvBOyOyxzl
	 79ryHeK819x6Fwu7w0D3TOlIPmk5mrXaMDsdrkgM/es9WDNwh9s2hy0Voa54dYLCiOfX4
	 9TOJBPiHx+gkzp176WVI9AVXbBWbkpV/0fs2bBP8LenBW4bAsRQeVHzJLDs6kiL7qhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QTm7Q9wA;
	arc=none smtp.remote-ip=209.85.217.54
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C2660A3809
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 20:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3C2660A3809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QTm7Q9wA
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-7d2e43ff4b4so185810137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 12:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794429484; x=1795034284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pkRaUBe9pdxVeXLuqR1fMj9AzhBZtgAAKRF0jBb6TvU=;
        b=QTm7Q9wA18FEnXT9ZRRipo3QVh7Mc3KGXdQaJeh8aPHk4tPtNuoqD7/RYJxx24YdE/
         0c/4CQ+2qBB/jg8Mv2a38mq9EyfChqgfSCW79nnyIuLX+h7phmm6dENhqKqJ48xrGgK/
         5KsshxddzKz8LQmNE+1PWnQeMpa2ZKYHyj3VIcoOBYb/3kwxaIxPa77r28OmMotYLCwu
         tYMGJPVvxj4nZrFRDjXH0h0yRRvZ4StANsCLUqD2NqaYCrywNz08ywumo/BSB+vN0KBr
         AZjYkSARhJ9JtLV+DbTKX5WxhcHv7EYd9sxv9AqhN/ZpKQIq3uxUT1jHrExiUAqmEvUQ
         zTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794429484; x=1795034284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pkRaUBe9pdxVeXLuqR1fMj9AzhBZtgAAKRF0jBb6TvU=;
        b=0j3v66D2ffQNf9bezsnJ9p4lAOZWH4WAmimiVPGiD+PKnQunsRVlV/QaBboeRRzJe1
         YlAP1a3W875rSKlYkgmdWXvAl30ChKIYAU7HrKvonUuyeJoRmJMJwwyYR+T4VGhQaF6r
         XoQiEXOEfUHzckSMtzfQjjrznSsR4LgJit0sFB6QAkJ1WvihOH1Y17lbOVRp8r2iJ9Xo
         V3U/3JTC1+KhQxhToVqSMgJxVUpzU9pqlEHShMRN80tYP/fBMEgMS5DJgjsNdRZm9/6u
         iEa2mdTA/zxApcshZeLIHlzEKkoxzPUg2AK0m807Y8JVUhWfDgmIxSbt2lVzgHV3pL2c
         7PpQ==
X-Gm-Message-State: APuU4Z9PEwNg+5Ly8E3zAlFCYR+014GSuVnrLWXGcy+LzdqHHsyYy7lp
	v+zqeM+wnHvC3zJJgiHQcxLqY8Ob0BAWJMuY3+c/DsyqER8b8EDqXmWNZ95RUg==
X-Gm-Gg: AYBFou1nPG/VgNEpi/7qLdamj6Aqw5WF1zK25QpCUqg1f3mg51MTDulyjAwGiT6WNdy
	2pixHg6fopwGj887R4+56DFYKt4r/4ljJ9TnBcJT4Do412LCplpD1yp7M2zLVvOnuCWv0i2Be41
	M8eSfj1oUZ59E0yNcmG0tcUTpSqvjXqt8Ix0A1IBGD9ayv8bRed/Hk7S0H14KwgXUFbuIciS1q+
	s8eAigpYarkDjHiZ2Jiue25MmDeH6qpXsQmnBIv+j4d31OVgZNSJefxJIsnI8yPTifI/mc9XfPw
	x1wTLUN2O2KkW2fOpZa+KWjhdqeO86tqCwfgLPGwgdKw9Ly2IOPUpH12+Kb6GY+MQSNdfznN0Dx
	5lKsHRMTKdKkaIwOmKY54lEelH4efdYiZ7tiJZn1LCuS5s8KH7HcQ3W2yHn4fiQoSPD66kVivHz
	ZCB5bRaAnPYptz2AYsMeRTxM3FIYPBmea6imnPvUgMA6MZpKTT7zKiAcaAdaGbKziqOTiIrXvW+
	r6fI3FTb77WbPeoGGiH03UAQc02HtKIlUydOHnBU0AuyzzcxLdJsk1w8tUPQJx73qe1ev2n6xoX
	5iIhgje05D1yF3iLB2mxYiI1YZRw+rTyRcTrT8bd75qvJj8gBQv5R6zcgMSNSP+QxZSctq3X/x0
	nuq2W8vukYHexB1U3LUpAA49zGm43NRxgYkapidHtnNGM7djpifkzvXCYb9gEVNjJeUJE/5qTry
	dZLg8=
X-Received: by 2002:a05:6102:160b:b0:7ba:b5ea:c4b8 with SMTP id ada2fe7eead31-7d6313b4f8cmr226839137.1.1794429483884;
        Wed, 11 Nov 2026 12:38:03 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d302359221sm4762571137.6.2026.11.11.12.38.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:38:03 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 7/8] doc/functional-bap: Document releasing a shared owner
Date: Wed, 11 Nov 2026 15:37:41 -0500
Message-ID: <b7dc0119efdd5f30b994e07ff3e48249a64f60cc.1794428234.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794428234.git.luiz.von.dentz@intel.com>
References: <cover.1794428234.git.luiz.von.dentz@intel.com>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Describe the test where the audio server of the acceptor releases the
transport it acquired, whose link shares the owner.

Assisted-by: Claude:claude-opus-5-5
---
 doc/functional-bap.rst | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/doc/functional-bap.rst b/doc/functional-bap.rst
index ca8e1ed14e2c..739d64b7170f 100644
--- a/doc/functional-bap.rst
+++ b/doc/functional-bap.rst
@@ -346,6 +346,31 @@ test_bap_unicast_duplex_disable_one
 	owner between the two transports, and set it only to disable the
 	ASEs one at a time.
 
+test_bap_unicast_duplex_release_shared
+--------------------------------------
+
+:Setup: As above, with both transports created and linked.
+
+:Steps:
+	1. Initiator: ``transport.acquire <sink transport>``, without
+	   desynchronizing, so both ASEs are enabled together.
+	2. Acceptor: ``transport.release <sink transport>``.
+
+:Expected:
+	1. ``Acquire successful: fd <fd> MTU <read>:<write>`` on both hosts,
+	   and both transports of the acceptor move to ``State: active``:
+	   `bluetoothctl` acquires the Sink ASE one as an audio server
+	   would, and its link shares the owner.
+	2. ``Release successful``, and both transports of the acceptor move
+	   to ``State: idle``.
+
+:Notes: The audio server releasing the transport it acquired has to
+	release the linked one with it, even though a transport leaving
+	streaming hands its owner over to a link that is still streaming
+	(see the previous test): a transport that is being released has its
+	owner removed by ``Release`` itself, so the link, which shares it,
+	has to follow, or it stays owned and never goes idle.
+
 BROADCAST
 =========
 
-- 
2.56.0

