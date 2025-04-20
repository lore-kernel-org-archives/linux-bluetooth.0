Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE026524C
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Apr 2025 21:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745185012; cv=pass; b=ftnoy5MpTMVRB3K03JZmSkyxygad8BIzEN8EuYDq1Cst4gAbkLNYpzOJREvNZe3sP52FWDv9Dikr84U7yKzevqnYVcgJOslbV+rVCs+lACIT/5lJRdJTVdPceJKmIlJn7xiv6GX2hfOn24C5nmTkg02akeAS8/n4Q7OKRX4g9/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745185012; c=relaxed/simple;
	bh=F05B5sOJlwbk/+LOxxcftihdczWZMk4/A3UBx0StvY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eljj8yxNVjPqjrtdDAE/H2oFGqPwaFjQT/boWVeWEXf+3cThaBQDfJuF/rp9UAm75E2H7bdVL6zZy7us4YYIds/CEw6oZq9ytD6Tzs2xD55YE707TjKXXy46ECQoVwxfULL75xBxS5iWSd0QU/XIc6l899YyPR5GzYA93QHl9cU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=PCS9pQ0W; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="PCS9pQ0W"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Zghdx3rW5z49PyG;
	Mon, 21 Apr 2025 00:36:37 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1745184998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ho9np3w9tlpRRCyOc5gCXzlBd7YTdOAkH1wL4JT5AKk=;
	b=PCS9pQ0W/9Rkoqq1yIaFugJ4Vu2Lx9CszFQIcNWg+3/Pf9p85LQiRQASIN++74e8cxmNSz
	SlU77IZ1HcD1wA2KOT4nV7VPN5YsjRpwIVSV+HL1fIKahzX7OU3Id1jTm6Ma6GWDNJBZ/c
	OJ1ynvM54clf0FvCRbVdunyiPP7zea7pOsc/k06FtBCwuZB7Yi8rVcdvnEhl3jLphBdVE2
	e84oSqChFjBwALPtTAKzBtGRH5Pyvh5Ld4uL5C/hcNAdXX2tRH7nM4LLBVYqti/YMneoRq
	rPJ9n4eUBlOOa1E2QcAjiwimiGptQOq5lKdYylM4r5Oeo704b2j7+ZYXryDMCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1745184998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ho9np3w9tlpRRCyOc5gCXzlBd7YTdOAkH1wL4JT5AKk=;
	b=j4LySwIBraHsFc5NJfQF/6nT807TxfqINQVMD6XsogK7LnMzbo3a8Pr5HP7bnUhhTKV0nG
	Ge+ICttOB3ZmeNBaD9i46+UzbDbSIgikwV/Oy1Ybe0xCSAU6ago1GCAzOoCTZb4rk/RiZJ
	H9TkfjwzfwnwkY42kL+srF6i6vC6f/ckQNUFNlt2tfd64kwhTZuxobV1G/n/7Tt6KHpC7P
	mEsJtSpC7/dGR8iJuL3ICeB5x38bF4irYser2Pp4+8KW0aWWQSmosc7EHpqdpIUPGRW+ke
	RGJXtNcYyFftpN24b9WcnonFnadmmsr5iXPr6T8Mg4ER9AuwHVjbakbRl0itGw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1745184998; a=rsa-sha256;
	cv=none;
	b=ebBLP7uRCXJtfclPev4Zc4JLryHUR6UrzGMTne7y/GCvuFeH/QLFXGACypgzq3BA9eJAx0
	UKthBj8Y2/nrXRBDp2PEb4kqjF+uwNCRLUVw2sgXF2RAWL1T2MYSTzuw/LEIyWfahiXddJ
	6ojKlhglTK9MfVEL3XGB5CUso8guVxKfMcTAXR3BOhCwoc46JF39o9KT6Tx2YL40cV/HkI
	P4QMXng6YQLEfq6sQMXumrHiSsihgpmPfTvqwf8GtPGBCO45Cp16DXSUyPAT+5GbTziNVD
	qqDR9QxG+n/9PUOxih+dESKBbNlCdBQOH6A3U3zANKCYjF5CB5WKA47Hum/Xjg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] shared/gatt-db: fix crash on bad attribute index in get_char_data
Date: Mon, 21 Apr 2025 00:36:32 +0300
Message-ID: <dd2290eb0393dc0c9978c94ad07ad6ae06ea3115.1745184652.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix AddressSanitizer: heap-buffer-overflow when index == 0.
---
 src/shared/gatt-db.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index b44140523..8951079be 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -1980,8 +1980,8 @@ bool gatt_db_attribute_get_char_data(const struct gatt_db_attribute *attrib,
 
 		/* Check if Characteristic Value was passed instead */
 		index = gatt_db_attribute_get_index(attrib);
-		if (index < 0)
-			return NULL;
+		if (index <= 0)
+			return false;
 
 		attrib = attrib->service->attributes[index - 1];
 		if (bt_uuid_cmp(&characteristic_uuid, &attrib->uuid))
-- 
2.49.0

