Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349171;
	b=AAB/8lOJjZXtPv79YFhy9zP/fhFsa4BFwzsmIJm6NoQKh2recZqaJB2BLeDo9PiaHD4h
	 +C+nNIuFoCYOLVo/UN2WKS3Qyj+dXndBvvf5DlOnC9+DJ4dbwlawsXy0j7DqQ4g/Qj5Sf
	 coi2GKprU3KOY2Fb3jPmb5lrDPhb3G9FH8KxMaEJv0XYjq+2MyYnCPLtmn6uPTRP5LFHk
	 WtQ35JlaOy5x06OEvdwRJ1Dy2QFwkSd3rov3oEZqgh8nWxsnODBFfJCrVFOH5y7NFBrJU
	 Wolhd7suWZbFdVv5LEkSYuUnt6/gHbif417NPEvldEhrhe97vwOJSh49pCPjJTJq6LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349171;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gVqBmnvDUXV0DwkZ98jzmkOKoo2BoG25ZN8wXgWB40k=;
	b=Mjb0X6M46yb6f5aVk30asUQeugjlhfwI912vFYmA4xFzOl8iY4I++qU36MPAUQC2VcH8
	 +/YEhRAzaT8rXhrWC0VovpqcEw8MbMm4jaZvywQ2HpTJZW1z++sF4UMDJKLCWfd3iseA4
	 RPPbigLIL/XsZchuALkRhKFyfysuOizoJy2YTB2h3ncnAmwXgOnDS4P6HDrt+EiIwvHDf
	 Hv9lews2FkeZySev4tv/atB4EcD5vD9YLv5nIO0V9QM0rAqvlaAgPPp5L9f6rH0sGaY+X
	 SXfY3fdBSUGyO+GledDxi2nBfdECvJG5sptHeTG1Cs+5Rj26CD/cEtoPcD4wCl04DPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bmnor6nK;
	arc=none smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D20606A332
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 22:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5D20606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bmnor6nK
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5ecd9a400cbso1462322e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 14:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794349169; x=1794953969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gVqBmnvDUXV0DwkZ98jzmkOKoo2BoG25ZN8wXgWB40k=;
        b=Bmnor6nKkd2GsnmkYrBcoblcPoUda0L3vdWu85IpDCN28aDTN67ejIP2ZxKn8BB7jV
         ZqcEZaO9ZsioES05g8z3IyTzL4peWiHVy7zSIdSzN9vQhrNJsmPMbHFXT5oTKjTvDSN5
         fFdvCI7rK45CbpJUoxUAzTQM4vrd/8nO9owIVxU9m+aIHWy6Bnb0fNm/N7WBlqG1UnBE
         I6utVYtZWFhevvdwZu7WvZKetS2rJ3OzIqLLjRyompmsqg0Dd4Exbu6UYGTzFEYnyccJ
         ptbSZ2uiwBhlome09f9axEOk5m6IcYg8aoZIRnHajmzSQ4bk4rHAu1vV50cXT8GiUzdk
         ktCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794349169; x=1794953969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gVqBmnvDUXV0DwkZ98jzmkOKoo2BoG25ZN8wXgWB40k=;
        b=W0b2HTFdbhQPPAW/GVhwqVXQxqghiKhAtQz5tpLUtEwUE9ikm2nK4RuxZdk/to6vYO
         GXSg7l+wfyKxflhjlfTVehPpTn8mbaxAQkozyFhXz0hcOWYre7Hx9aQIM3Oh4b9uR9Cj
         zfkkIs8sQKiTERRic2AZGuyUYAHgn7Jsgnbd2AD/DH2pXu8aFhqT3XckFnTEFKL06ty1
         S2VHmHnCugScbSaKOkG6d2thddsd5LA10Pi9Ncsm0mr0bQFxsNn9i2DLFFrhw3bkT8gq
         QkDELYOzSVJtF+Wvgyite3ylSSODL9hN3GcPx0gshhzooE9AFDl6NP0CW8XLMFpssO+g
         du+Q==
X-Gm-Message-State: APuU4Z8GSqzbPZsuIRGy7UPlse53ethhe9Id0Ag/p/wGr4UKhNM+1BuI
	qcuiylqmoX7PkTnhKH31EX/LpxP/dRBO9nuXT3CysstYm+0DO4+UbMBHraVUhw==
X-Gm-Gg: AYBFou3tqdRCAvGzPzEqNS7R32KhZtKR3TMJ7/oFODazPbDYeq3GBsCLrf8Anhi5Pma
	xXZYSVz/0pLnjhxsnsx5ZxODW94YY670CX1jLFlJl/AasWZeS9WYMfTx8p4G/GMc0rWXRis18Ua
	IlNH25VG8RAvM7PAY15qW+dumrp0OZH+C3wNIjORyEx9bEHYvV/HPL2F93OvSXU8NSIfd/PpFQI
	cG1TUeG2H9J14TgvDh76MjuqP3NGEVH/qBOqQe82i4gvzq2kzPkds58q0W8U5/XmMfgWO1PrRbj
	m/RtVQ+IZXynJJIbOfcN/8eVkTNu7NoJTHWw7xyM5Rz8+MWRarSGQzGnWvY47tkd26qyW19cnvB
	XmSewTC1CNSVFTXjCelEuUWod2vjt/t9PXzqx4tnJO2O8/oqHi8G3WKO4k5u2mNjLEgyFwkwdMD
	zoGyzUm7X1dMddyFMhl8x4wyCAzjYSzXYkWyuYgl+wrwSiM8kSK/MEwG33VXd0u6pG6PMWLxeUS
	c3BSJlAhtfpDKe9BdFNczgNLGiAMudoCFWy6TfDIqj6S5vDtXWwccG/vhU+6iBhiAA2Q150l4zQ
	B9AwXE6wrwMhw2KnKu0JsVh9tW+3hG44puf6kySOi4xE36OQGWKsKwXZrIr0qMEF+TSGPBYLf1g
	i8fLtvp5dnTfhHyzSxF/BFNcu4g/1fIL8qE24B/Sp+koC6RZjW7T194OzxflizP411Q2B71SvgS
	jbDOc=
X-Received: by 2002:a05:6122:e448:b0:5ec:d70c:633a with SMTP id 71dfb90a1353d-5ee1c3db091mr106996e0c.6.1794349169431;
        Tue, 10 Nov 2026 14:19:29 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c58ed55sm2605244e0c.5.2026.11.10.14.19.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:19:28 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 4/5] doc/functional-bap: Document clearing a cached configuration
Date: Tue, 10 Nov 2026 17:19:07 -0500
Message-ID: <34234ec2cd409ea2c45707ac201b00cd6162ca17.1794348982.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794348982.git.luiz.von.dentz@intel.com>
References: <cover.1794348982.git.luiz.von.dentz@intel.com>
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

Describe the test where the initiator clears an endpoint twice, the
second time releasing the ASE whose codec configuration the acceptor
cached.

Assisted-by: Claude:claude-opus-5-5
---
 doc/functional-bap.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/doc/functional-bap.rst b/doc/functional-bap.rst
index fc367e0f9181..ec9f056d9f83 100644
--- a/doc/functional-bap.rst
+++ b/doc/functional-bap.rst
@@ -269,6 +269,30 @@ test_bap_unicast_duplex_enable_one
 	made active through its link, so the test checks the state of the
 	transport rather than the result of the acquisition.
 
+test_bap_unicast_clear_cached
+-----------------------------
+
+:Setup: As above, with both transports created.
+
+:Steps:
+	1. Initiator: ``endpoint.clear <remote PAC Source endpoint>``.
+	2. Initiator: ``endpoint.clear <remote PAC Source endpoint>`` again.
+
+:Expected:
+	1. ``Configuration cleared``, and the initiator removes the transport
+	   of the Source ASE, which the acceptor moves to Codec Configured,
+	   caching its codec configuration.
+	2. ``Configuration cleared``, and the initiator releases the Source
+	   ASE again from Codec Configured, so the acceptor moves it to Idle
+	   and removes its transport. The Sink ASE transports are left in
+	   ``State: idle``.
+
+:Notes: Releasing an ASE in the Codec Configured state is permitted
+	(ASCS Table 3.2, BAP 5.6.6) and is covered by BAP/UCL/SCC/BV-106-C
+	and BV-107-C. Without it, an initiator could not get rid of the
+	codec configuration an acceptor cached, as it no longer has a
+	transport for it.
+
 BROADCAST
 =========
 
-- 
2.56.0

