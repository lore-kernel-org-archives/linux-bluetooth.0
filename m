Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D194689
	for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jul 2025 16:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753979184; cv=none; b=JQA5tbfeUoZznLdglGPHwYCfixLkJRyK1LorLhwbnHDc72BfxBw5cG5q3omkflOMehyfupj8ElZQdmN6qdlzuEBlhQ3TKIz8e0CDJ/XLgTrgTCInOWa8tmxe54SX4wLEr1OKy4WRR+tGv5O9O8jDkTzaron0GxKWyYfHjkc9ehI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753979184; c=relaxed/simple;
	bh=wtR1+GF4GFL2vwzd5UAGAJMcJrfqOkDfw7GXzWTyyig=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tic/ns39MYpqgu8EwWAP3N9DzZF0dzbliymV3kspqmoywbIgBfr8QmF1xx0hkI/AtEDkI24cUdjS9WzzCV+GXZjprqcrS5SBd0DwH0Ry3CpNKPFNQldT+G9YRJPAXu29Qa1jjCwz7eLkm6w/EkBPDWEMDUhxyVPX2PRw6o0M2X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJgcRlge; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJgcRlge"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6157b5d0cc2so1309945a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jul 2025 09:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753979181; x=1754583981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YDFdcpAQ+ACN3MEuPaUZlcNB3gbdgXn2SRgWJnDSUyQ=;
        b=RJgcRlgeg6ZO8wvPpRIP5ulgUI4WBnFhas2ckns1EOzIMK2Y9f3bYFdbWMdxMU0eZg
         hs0YF4QdFPmT9qzlqoMS6AECVUKGSOdwsPVosLMOQgh467bPvpIk1B1arCU+QSxsXP5k
         00gpHFR+zQTzTNKLklst93kMFv8CNVLMCcWGUSNELKwj+Zcux3ImM2s2Vz0TdXoKNQcC
         h+LpBAISci3s5WLr41WrxycB3tVr9J+bHYOy73WyRXzEvzuvAqa6V0+0U0BHS5zl+RK/
         Ms2IArtsinCGnmYeJP4fV12mLUggvtkr9eKsiE9AZjrHlJXMSood50aPXXa7mmYerepE
         6nzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753979181; x=1754583981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YDFdcpAQ+ACN3MEuPaUZlcNB3gbdgXn2SRgWJnDSUyQ=;
        b=flJwOj58NwxG9s0WBLuE+UaBs2ozi6+SUjaCDlxoZZ3+AM/9rzfm88EAmacTBRtvZc
         1qJE+wbgV3ROV/2/HXoVAyJC7S8JOKKn8fcHafoqhA9+WqgoeOjB0ZFwXBQ2PA+NXEG1
         Xi0SF0xqo8sqC37InpCkfjgNbLsfg4hqGPoI2xIse5wI0zJQHulNW7ZUK/7Ao+A1wzLM
         h98FzUzCxcTVeIRsG8onHTNiXZM864CEMrNWBlvgikOd6mL3ezhkfpdKrlTORuCSjZWV
         13349JCJddNj+RrJGj7p6xbYUfzQ2xQBRtmYEJ/fCWpagO3K6V5pijWkNmU+AmU19jTe
         b0rg==
X-Gm-Message-State: AOJu0YxAbPq7vyjqcUl0+2Ay6Z5a4jLlY65EevyB5OiZ/qMlJqAz/yzp
	dyrmpqY4I9SJNE2i1AK8udSU7LuXxWsA8Y9+SKMcqbSfJ8xrEnAg/MU7eqR9kyse
X-Gm-Gg: ASbGnctuTphpDTayy+8SkjJmm3Xjw3fhB1z1r4XIW9kQmFhPcve/uwu5NjU/Sxk5Z50
	vcpGNsK4KhvHvXgSlaIIk4tosn8xtmdFHqCFadjvfe05z5AsQWRQ4YYlCKwA1iC8N21v9rrpElo
	5IylYsl8WT9zim0+/H1ZbwLVQVv37kgR0kBToX/bZeXsZzdVUF7mFD0s0SRJ43SQ4X/TPd1h1OR
	7/FNnZyP6QZjTDYROnfhcLn7Ls6lnuRnkSpR+7xYnfmsN31e2zvnxNSfjTz0/46ZNVJik2WBfVa
	1ZoQimCqECGDGTlHYR5O0pTmOx+Z4G9htm0vB1WF2M/wVT+YSaIPrpG4sYXnfSUAebppxNvcwPi
	jw9SeHOY9iLfMMLDiOm+I/BAZxc4UUPYOKKbyIVXR5mR7mtsQv21W368WrfBuI+9cVp1+E0n0Ri
	4uDY0Qyh2wia4PdvPw/FQEtzdWA2en
X-Google-Smtp-Source: AGHT+IFA2iSnez5X0rU4jfC46wdqxGUwbtt7tIK5MsaZUn9Aa7Xj1VbCTOSQXW3+5ebyW4pY/GtqNQ==
X-Received: by 2002:a17:906:f5a5:b0:aec:56e0:c4a9 with SMTP id a640c23a62f3a-af8fd91a1efmr896265666b.28.1753979180149;
        Thu, 31 Jul 2025 09:26:20 -0700 (PDT)
Received: from localhost.localdomain (46.205.200.232.nat.ftth.dynamic.t-mobile.pl. [46.205.200.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a2436a4sm133042166b.134.2025.07.31.09.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 09:26:19 -0700 (PDT)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH] shared/asha: Do not start ASHA in case of CoC connection failure
Date: Thu, 31 Jul 2025 18:26:05 +0200
Message-Id: <20250731162605.155115-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 profiles/audio/asha.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/asha.c b/profiles/audio/asha.c
index 9bd57d780..a17b877d9 100644
--- a/profiles/audio/asha.c
+++ b/profiles/audio/asha.c
@@ -89,6 +89,11 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 	struct bt_asha_device *asha_dev = conn_data->asha_dev;
 	GError *gerr = NULL;
 
+	if (err) {
+		error("%s", err->message);
+		return;
+	}
+
 	if (!bt_io_get(io, &gerr,
 				BT_IO_OPT_IMTU, &asha_dev->imtu,
 				BT_IO_OPT_OMTU, &asha_dev->omtu,
@@ -96,7 +101,7 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 		/* Let this be non-fatal? */
 		asha_dev->omtu = ASHA_MIN_MTU;
 		asha_dev->imtu = ASHA_CONNECTION_MTU;
-		error("Could not get L2CAP CoC socket MTU: %s", err->message);
+		error("Could not get L2CAP CoC socket MTU: %s", gerr->message);
 		g_error_free(gerr);
 	}
 
@@ -362,7 +367,7 @@ static void asha_source_device_remove(struct btd_service *service)
 	asha_dev = btd_service_get_user_data(service);
 	if (!asha_dev) {
 		/* Can this actually happen? */
-		DBG("Not handlihng ASHA profile");
+		DBG("Not handling ASHA profile");
 		return;
 	}
 
@@ -479,7 +484,7 @@ static int asha_source_disconnect(struct btd_service *service)
 
 	if (!asha_dev) {
 		/* Can this actually happen? */
-		DBG("Not handlihng ASHA profile");
+		DBG("Not handling ASHA profile");
 		return -1;
 	}
 
-- 
2.43.0

